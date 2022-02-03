#!/bin/bash

# 機能別設定ファイル名を指定
grp_env_file_name='grp_env_create_request.sh'

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

# 緯度経度の数を取得
lat_lon_count_sql="SELECT COUNT(*) FROM ${DB_SCHEMA}.tmp_unique_fetch_lineinfo;"
lat_lon_count=$(psql -tAq -d ${DB_NAME} -U ${DB_USER} -c "${lat_lon_count_sql}")

# 取得対象チェーンの数を取得
chain_count_sql="SELECT COUNT(*) FROM ${DB_SCHEMA}.mst_fetch_target_chain;"
chain_count=$(psql -tAq -d ${DB_NAME} -U ${DB_USER} -c "${chain_count_sql}")


sep_char="、"

# 取得対象のチェーン名称を取得
chain_names_sql="SELECT STRING_AGG(chain_name, '${sep_char}') FROM ${DB_SCHEMA}.mst_filtering_fetch_cafechain;"
chain_names=$(psql -tAq -d ${DB_NAME} -U ${DB_USER} -c "${chain_names_sql}")

# 取得対象の事業者名称を取得
company_names_sql="
    SELECT STRING_AGG(company_name, '${sep_char}')
    FROM ${DB_SCHEMA}.ejp_company
    WHERE company_cd IN (
        SELECT target_cd
        FROM   ${DB_SCHEMA}.mst_fetch_target_line
        WHERE  type_cd = 1
    );
"
company_names=$(psql -tAq -d ${DB_NAME} -U ${DB_USER} -c "${company_names_sql}")

# 取得対象の路線名称を取得
line_names_sql="
    SELECT STRING_AGG(line_name, '${sep_char}')
    FROM ${DB_SCHEMA}.ejp_line
    WHERE line_cd IN (
        SELECT target_cd
        FROM   ${DB_SCHEMA}.mst_fetch_target_line
        WHERE  type_cd = 2
    );
"
line_names=$(psql -tAq -d ${DB_NAME} -U ${DB_USER} -c "${line_names_sql}")

# 取得対象の駅を取得
station_names_sql="
    SELECT STRING_AGG(station_name, '${sep_char}')
    FROM (
        SELECT DISTINCT station_name
        FROM ${DB_SCHEMA}.ejp_station
        WHERE
            station_cd IN (
                SELECT target_cd
                FROM   ${DB_SCHEMA}.mst_fetch_target_line
                WHERE  type_cd = 3
            ) OR 
            station_g_cd IN (
                SELECT target_cd
                FROM   ${DB_SCHEMA}.mst_fetch_target_line
                WHERE  type_cd = 4
            )
        ORDER BY station_name
    ) tmp;
"
station_names=$(psql -tAq -d ${DB_NAME} -U ${DB_USER} -c "${station_names_sql}")

# 時刻情報
now_date=$(date "+%Y年%m月%d日 %H:%M:%S")

# 算出
request_count_sum=$(( ${lat_lon_count} * ${chain_count} ))
request_cost_sum=$(( ${request_count_sum} * ${REQUEST_COST_YEN} ))

# レポート作成
# cat << EOF > ${DATA_DIR}/${REQUEST_REPORT_NAME}
# 【リクエストレポート】
#     ■ 対象緯度経度数        ：   $(printf '%8s\n' ${lat_lon_count})
#     ■ 対象チェーン数        ：   $(printf '%8s\n' ${chain_count})
#     ■ 設定リクエスト単価    ： ¥ $(printf '%8s\n' ${REQUEST_COST_YEN})
#     ■ 合計リクエスト数      ：   $(printf '%8s\n' ${request_count_sum})
#     ■ 予想コスト            ： ¥ $(printf '%8s\n' ${request_cost_sum})

# 【取得予定チェーン】
# ${chain_names}

# ${now_date} 出力
# EOF


report_text="
【リクエストレポート】
    ■ 対象緯度経度数        ：   $(printf '%8s\n' ${lat_lon_count})
    ■ 対象チェーン数        ：   $(printf '%8s\n' ${chain_count})
    ■ 設定リクエスト単価    ： ¥ $(printf '%8s\n' ${REQUEST_COST_YEN})
    ■ 合計リクエスト数      ：   $(printf '%8s\n' ${request_count_sum})
    ■ 予想コスト            ： ¥ $(printf '%8s\n' ${request_cost_sum})

【取得予定チェーン】
    ${chain_names}

【取得対象駅（事業者指定）】
    ${company_names}

【取得対象駅（路線指定）】
    ${line_names}

【取得対象駅（駅指定）】
    ${station_names}

${now_date} 出力
"

echo -e "${report_text}" > ${DATA_DIR}/${REQUEST_REPORT_NAME}


log_msg ${INFO} "実行完了"

exit 0
