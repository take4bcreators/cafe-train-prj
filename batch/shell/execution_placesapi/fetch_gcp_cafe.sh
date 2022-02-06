#!/bin/bash

# 機能別設定ファイル名を指定
grp_env_file_name='grp_env_execution_placesapi.sh'

# シェルの名前を格納
exec_shell_name=$(basename $0)

### 共通設定読み込み ###
# プロジェクトルート読み込みファイルの存在チェックと読み込み
if [ ! -f PROJECT_ROOT.sh ]; then
    echo "ERROR プロジェクトルート読み込みファイルが存在しません"
    exit 1
fi
source PROJECT_ROOT.sh

# 共通設定読み込みファイルの存在チェックと読み込み
if [ ! -f ${PROJECT_ROOT}/config/common_env.sh ]; then
    echo "ERROR 共通設定読み込みファイルが存在しません"
    exit 1
fi
source ${PROJECT_ROOT}/config/common_env.sh

# 機能別設定読み込みファイルの存在チェックと読み込み
if [ ! -f ${CONFIG_DIR}/${grp_env_file_name} ]; then
    echo "ERROR 機能別設定読み込みファイルが存在しません"
    exit 1
fi
source ${CONFIG_DIR}/${grp_env_file_name}

# 共通モジュール読み込みファイルの存在チェックと読み込み
if [ ! -f ${COMMON_LIB_SH} ]; then
    echo "ERROR 共通モジュール読み込みファイルが存在しません"
    exit 1
fi
source ${COMMON_LIB_SH} ${exec_shell_name}

# 認証情報読み込みファイルの存在チェックと読み込み
if [ ! -f ${DOT_ENV} ]; then
    echo "ERROR 認証情報読み込みファイルが存在しません"
    exit 1
fi
source ${DOT_ENV}


### メイン処理 ###
log_msg ${INFO} "実行開始"


# 取得対象チェーンの検索名称を取得
chain_name_list_sql="SELECT STRING_AGG(search_name, ' ') FROM ${DB_SCHEMA}.mst_filtering_fetch_cafechain;"
chain_name_list=$(psql -tAq -d ${DB_NAME} -U ${DB_USER} -c "${chain_name_list_sql}")

if [ -z "${chain_name_list}" ]; then
    log_msg ${ERR} "取得対象チェーンの検索名称を取得出来ませんでした"
    exit 1
fi


# リクエスト用CSVの確認
request_csv="${DATA_DIR}/placesapi_request_data.csv"

if [ ! -f "${request_csv}" ]; then
    log_msg ${ERR} "リクエスト用CSVがありません"
    log_msg ${ERR} "CSVファイルパス：${request_csv}"
    exit 1
fi

if [ ! -s "${request_csv}" ]; then
    log_msg ${ERR} "リクエスト用CSVにデータがありません"
    log_msg ${ERR} "CSVファイルパス：${request_csv}"
    exit 1
fi


# 結果格納用TSVファイルの初期化
tmp_cafe_tsv="${TMP_DIR}/tmp_gmp_cafe.tsv"
: > "${tmp_cafe_tsv}"
rtn_cd=$?

if [ ${rtn_cd} -ne 0 ]; then
    log_msg ${ERR} "結果用TSVファイルの初期化でエラーが発生しました"
    log_msg ${ERR} "TSVファイルパス：${tmp_cafe_tsv}"
    exit 1
fi


# リクエスト時使用変数の定義・初期化
curl_response_file="${TMP_DIR}/curlres.$$.tmp"
latlon_cnt=0
req_cnt=0
zero_cnt=0
get_cnt=0


# Places API 実行開始
log_msg ${INFO} "カフェ情報取得開始"
for latlon in $(cat ${request_csv} | sed '/^$/d'); do
    let latlon_cnt++
    log_msg ${INFO} "地点カウント：${latlon_cnt} 地点：${latlon}"
    latlon_tsv=$(echo ${latlon} | sed 's/,/\t/')
    for chain in ${chain_name_list}; do
        let req_cnt++
        
        # リクエスト実行
        curl -Ss -X GET "https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=${GM_API_KEY}&location=${latlon}&radius=${RADIUS_METER}&language=ja&keyword=${chain}" \
            > ${curl_response_file} 2> ${STD_ERR_FILE}
        rtn_cd=$?
        
        # curl でエラーが発生した場合は異常終了
        if [ ${rtn_cd} -ne 0 ] || [ -s ${STD_ERR_FILE} ]; then
            log_msg ${ERR} "APIリクエスト実行エラー"
            log_msg ${ERR} "curl戻り値：${rtn_cd}"
            log_msg ${ERR} "curlエラーメッセージ...\n$(cat ${STD_ERR_FILE})"
            log_msg ${INFO} "リクエスト実行数：${req_cnt}"
            log_msg ${INFO} "検索結果ゼロ数：${zero_cnt}"
            log_msg ${INFO} "結果加工実行数：${get_cnt}"
            if [ -f ${curl_response_file} ]; then
                log_msg ${INFO} "一時ファイルを削除：${curl_response_file}"
                rm ${curl_response_file}
            fi
            delete_std_out_file
            log_msg ${ERR} "異常終了"
            exit 1
        fi
        
        # レスポンスステータス（検索結果）が 0 であればスキップ
        api_status=$(cat ${curl_response_file} | jq -r '.status')
        if [ "${api_status}" = "ZERO_RESULTS" ]; then
            let zero_cnt++
            continue
        fi
        
        # レスポンスデータの加工
        cat ${curl_response_file} \
            | jq -r '.results[] | [.place_id, .name, .geometry.location.lat, .geometry.location.lng] | @tsv' \
            | sed 's/"//g' \
            | awk -v latlon="${latlon_tsv}" -v chain="${chain}" 'BEGIN{OFS="\t"}{print latlon, chain, $0}' \
            >> ${tmp_cafe_tsv} 2> ${STD_ERR_FILE}
        rtn_cd=$?
        
        # レスポンスデータの加工時にエラーが発生した場合は異常終了
        #   考慮不要なエラー出力により、処理が中断してしまう可能性もあるが、
        #   無駄にAPIリクエストをしない為にも一旦実装。
        if [ ${rtn_cd} -ne 0 ] || [ -s ${STD_ERR_FILE} ]; then
            log_msg ${ERR} "レスポンスデータの加工エラー"
            log_msg ${ERR} "AWK戻り値：${rtn_cd}"
            log_msg ${ERR} "AWKエラーメッセージ...\n$(cat ${STD_ERR_FILE})"
            log_msg ${INFO} "リクエスト実行数：${req_cnt}"
            log_msg ${INFO} "検索結果ゼロ数：${zero_cnt}"
            log_msg ${INFO} "結果加工実行数：${get_cnt}"
            if [ -f ${curl_response_file} ]; then
                log_msg ${INFO} "一時ファイルを削除：${curl_response_file}"
                rm ${curl_response_file}
            fi
            delete_std_out_file
            log_msg ${ERR} "異常終了"
            exit 1
        fi
        let get_cnt++
    done
done
log_msg ${INFO} "カフェ情報取得完了"
log_msg ${INFO} "リクエスト実行数：${req_cnt}"
log_msg ${INFO} "検索結果ゼロ数：${zero_cnt}"
log_msg ${INFO} "結果加工実行数：${get_cnt}"


# 終了時処理（一時ファイル削除）
if [ -f ${curl_response_file} ]; then
    log_msg ${INFO} "一時ファイルを削除：${curl_response_file}"
    rm ${curl_response_file}
fi
delete_std_out_file
log_msg ${INFO} "実行完了"

exit 0
