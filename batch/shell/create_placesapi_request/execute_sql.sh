#!/bin/bash

##### 環境変数の設定チェック #####
if [ -z "${PROJECT_ROOT}" ]; then
    echo "ERROR プロジェクトパスが設定されていません"
    exit 1
fi


##### 引数チェック #####
# 個数チェック
if [ $# != 2 ]; then
    echo "ERROR 引数の数が正しくありません"
    exit 1
fi

# 引数取得
exec_sql_file_path=${PROJECT_ROOT}/batch/sql/$1
EXEC_SHELL_NAME=$2

# SQLファイル存在チェック
if [ ! -f ${exec_sql_file_path} ]; then
    echo "ERROR 実行SQLファイルが存在しません"
    echo "指定されたファイル名：${exec_sql_file_path}"
    exit 1
fi


##### 共通設定読み込み #####
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


##### メイン処理 #####
log_msg ${INFO} "実行開始"
psql -d ${DB_NAME} -U ${DB_USER} -f "${exec_sql_file_path}" -v schema=${DB_SCHEMA} > ${STD_OUT_FILE} 2> ${STD_ERR_FILE}

if [ -s ${STD_OUT_FILE} ]; then
    log_msg ${INFO} "PSQL標準出力メッセージ...\n""$(cat ${STD_OUT_FILE})"
else
    log_msg ${INFO} "PSQL標準出力メッセージ なし"
fi

if [ -s ${STD_ERR_FILE} ]; then
    log_msg ${ERR} "PSQLエラー"
    log_msg ${ERR} "PSQLエラーメッセージ...\n""$(cat ${STD_ERR_FILE})"
    delete_std_out_file
    log_msg ${ERR} "異常終了"
    exit 1
fi

delete_std_out_file
log_msg ${INFO} "正常終了"

exit 0
