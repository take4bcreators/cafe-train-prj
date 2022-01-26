#!/bin/bash

# シェルの名前を格納
EXEC_SHELL_NAME=$(basename $0)

### 共通設定読み込み ###
# プロジェクトパス情報読み込みファイルの存在チェックと読み込み
if [ ! -f prjrootpath.sh ]; then
    echo "ERROR プロジェクトパス情報読み込みファイルが存在しません"
    exit 1
fi
source prjrootpath.sh

# 共通設定読み込みファイルの存在チェックと読み込み
if [ ! -f ${PROJECT_ROOT}/config/common_env.sh ]; then
    echo "ERROR 共通設定読み込みファイルが存在しません"
    exit 1
fi
source ${PROJECT_ROOT}/config/common_env.sh

# 機能別設定読み込みファイルの存在チェックと読み込み
grp_env_file_name=grp_env_create_placesapi_request.sh
if [ ! -f ${CONFIG_DIR}/${grp_env_file_name} ]; then
    echo "ERROR 機能別設定読み込みファイルが存在しません"
    exit 1
fi
source ${CONFIG_DIR}/${grp_env_file_name}

# 共通モジュール読み込みファイルの存在チェックと読み込み
if [ ! -f ${CONFIG_DIR}/common_lib.sh ]; then
    echo "ERROR 共通モジュール読み込みファイルが存在しません"
    exit 1
fi
source ${CONFIG_DIR}/common_lib.sh

# 認証情報読み込みファイルの存在チェックと読み込み
if [ ! -f ${ENV_DIR}/.env ]; then
    echo "ERROR 認証情報読み込みファイルが存在しません"
    exit 1
fi
source ${ENV_DIR}/.env


### メイン処理 ###
log_msg ${INFO} "実行開始"

# リクエスト用CSVのチェック
request_info_csv_name="tmp_request_company.csv"
if [ ! -f ${TMP_DIR}/${request_info_csv_name} ]; then
    log_msg ${ERR} "${request_info_csv_name} ファイルが存在しません"
    log_msg ${ERR} "確認チェック対象：${TMP_DIR}/${request_info_csv_name}"
    log_msg ${ERR} "異常終了"
    exit 1
fi
if [ ! -s ${TMP_DIR}/${request_info_csv_name} ]; then
    log_msg ${ERR} "${request_info_csv_name} ファイルの内容が空です"
    log_msg ${ERR} "確認チェック対象：${TMP_DIR}/${request_info_csv_name}"
    log_msg ${ERR} "異常終了"
    exit 1
fi

response_data_csv_name="tmp_esp_line.csv"
log_msg ${DEBUG} "リクエスト用CSV：${TMP_DIR}/${request_info_csv_name}"
log_msg ${DEBUG} "レスポンス用CSV：${TMP_DIR}/${response_data_csv_name}"

# 書き込み先の初期化
: > ${TMP_DIR}/${response_data_csv_name}

# リクエスト実行
response_tmp_path="${TMP_DIR}/response.$$.tmp"
cat ${TMP_DIR}/${request_info_csv_name} | sed '/^$/d' | while read company_code; do
    curl -sS -X GET "http://api.ekispert.jp/v1/json/operationLine?key=${EP_API_KEY}&corporationCode=${company_code}" | jq . \
        > ${response_tmp_path}
    
    # スキップ判定
    if [ ! -s ${response_tmp_path} ]; then
        log_msg ${INFO} "レスポンスデータなし 会社コード：${company_code}"
        continue
    fi
    ekispert_err_code=$(cat ${response_tmp_path} | jq -r '.ResultSet.Error.code')
    if [ ${ekispert_err_code} != 'null' ]; then
        log_msg ${WARN} "駅すぱあとAPIエラー 会社コード：${company_code}"
        log_msg ${WARN} "駅すぱあとAPI エラーコード：${ekispert_err_code}"
        log_msg ${WARN} "駅すぱあとAPI エラーメッセージ..\n""$(cat ${response_tmp_path} | jq -r '.ResultSet.Error.Message')"
        continue
    fi
    
    line_count=$(cat ${response_tmp_path} | jq -r '.ResultSet.max')
    log_msg ${DEBUG} "会社コード：${company_code} 路線数：${line_count}"
    
    # 取得路線が一つの場合は .ResultSet.Line が配列になっていないので、分岐して取得する
    if [ ${line_count} -eq 1 ]; then
        cat ${response_tmp_path} | jq -r '.ResultSet.Line | [.code, .Name, .Yomi, .Color] | @csv' | sed 's/"//g' \
            | awk -v cc="${company_code}" -F "," 'BEGIN{OFS=","}{print cc,$0}' \
            >> ${TMP_DIR}/${response_data_csv_name}
    else
        cat ${response_tmp_path} | jq -r '.ResultSet.Line[] | [.code, .Name, .Yomi, .Color] | @csv' | sed 's/"//g' \
            | awk -v cc="${company_code}" -F "," 'BEGIN{OFS=","}{print cc,$0}' \
            >> ${TMP_DIR}/${response_data_csv_name}
    fi
    
    # 1つの会社のデータが100件より多い場合は追加で取得する
    if [ ${line_count} -gt 100 ]; then
        repeat_count=$((${line_count} / 100))
        for i in $(seq 1 ${repeat_count}); do
            # オフセット値を指定して取得
            offset_value=$(( ($i * 100) + 1 ))
            curl -sS -X GET "http://api.ekispert.jp/v1/json/operationLine?key=${EP_API_KEY}&corporationCode=${company_code}&offset=${offset_value}" | jq . \
                > ${response_tmp_path}
            
            # 取得路線が一つの場合は .ResultSet.Line が配列になっていないので、分岐して取得する
            if [ ${line_count} -eq ${offset_value} ]; then
                cat ${response_tmp_path} | jq -r '.ResultSet.Line | [.code, .Name, .Yomi, .Color] | @csv' | sed 's/"//g' \
                    | awk -v cc="${company_code}" -F "," 'BEGIN{OFS=","}{print cc,$0}' \
                    >> ${TMP_DIR}/${response_data_csv_name}
            else
                cat ${response_tmp_path} | jq -r '.ResultSet.Line[] | [.code, .Name, .Yomi, .Color] | @csv' | sed 's/"//g' \
                    | awk -v cc="${company_code}" -F "," 'BEGIN{OFS=","}{print cc,$0}' \
                    >> ${TMP_DIR}/${response_data_csv_name}
            fi
        done
    fi
done

if [ -f ${response_tmp_path} ]; then
    rm ${response_tmp_path}
fi

if [ ! -s ${TMP_DIR}/${response_data_csv_name} ]; then
    log_msg ${ERR} "結果データがありません"
    log_msg ${ERR} "異常終了"
    exit 1
fi

delete_std_out_file
log_msg ${INFO} "正常終了"

exit 0
