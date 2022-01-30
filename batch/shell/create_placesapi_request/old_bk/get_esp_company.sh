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
request_info_csv_name="tmp_request_prefectures.csv"
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

# リクエスト情報の整形
request_prefecturecode=$(cat ${TMP_DIR}/${request_info_csv_name} | sed 's/,/:/g')
log_msg ${DEBUG} "リクエスト対象都道府県：${request_prefecturecode}"

# 駅すぱあとAPI リクエスト実行
curl -sS -X GET "http://api.ekispert.jp/v1/json/corporation?key=${EP_API_KEY}&prefectureCode=${request_prefecturecode}" \
    | jq -r '.ResultSet.Corporation[] |  [.code, .Name, .Type] | @csv' \
    | sed 's/"//g' \
    | awk -F ',' 'BEGIN{OFS=","}$3=="train"{print $1, $2}' \
    > ${TMP_DIR}/tmp_esp_company.csv 2> ${STD_ERR_FILE}

# curlエラーチェック
if [ -s ${STD_ERR_FILE} ]; then
    log_msg ${ERR} "curlエラー"
    log_msg ${ERR} "curlエラーメッセージ...\n""$(cat ${STD_ERR_FILE})"
    delete_std_out_file
    log_msg ${ERR} "異常終了"
    exit 1
fi

delete_std_out_file
log_msg ${INFO} "正常終了"

exit 0
