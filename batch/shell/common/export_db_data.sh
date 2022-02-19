#!/bin/bash

##### 環境変数の設定チェック #####
if [ -z "${PROJECT_ROOT}" ]; then
    echo "ERROR プロジェクトルートが設定されていません"
    exit 1
fi

if [ -z "${COMMON_LIB_SH}" ]; then
    echo "ERROR 共通設定変数が設定されていません"
    exit 1
fi

if [ -z "${MOD_GRP_NAME}" ]; then
    echo "ERROR 機能別設定変数が設定されていません"
    exit 1
fi


##### 引数チェック #####
# 個数チェック
if [ $# -ne 3 ]; then
    echo "ERROR 引数の数が正しくありません"
    exit 1
fi


##### 共通設定読み込み #####
# 共通モジュール読み込みファイルの存在チェックと読み込み
exec_shell_name=$1
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


##### メイン処理 #####
log_msg ${INFO} "実行開始"

# SQLファイル存在チェック
exec_sql_file_name=$2
exec_sql_file_path="${SQL_DIR}/${exec_sql_file_name}"
if [ ! -f "${exec_sql_file_path}" ]; then
    log_msg ${ERR} "実行SQLファイルが存在しません"
    log_msg ${ERR} "指定されたファイル名：${exec_sql_file_path}"
    exit 1
fi

# 出力ファイルパス情報の有無チェック
export_file_path=$3
if [ -z "${export_file_path}" ]; then
    log_msg ${ERR} "出力ファイルパスの指定が正しくありません"
    log_msg ${ERR} "指定されたパス情報：${export_file_path}"
    exit 1
fi

# SQL実行
psql -d ${DB_NAME} -U ${DB_USER} -f "${exec_sql_file_path}" ${DB_BIND} -v SHL_EXPORT_FILE_PATH="${export_file_path}" > ${STD_OUT_FILE} 2> ${STD_ERR_FILE}
if [ -s ${STD_OUT_FILE} ]; then
    log_msg ${INFO} "PSQL標準出力メッセージ...\n""$(cat ${STD_OUT_FILE})"
else
    log_msg ${INFO} "PSQL標準出力メッセージ なし"
fi

# SQLエラーチェック
if [ -s ${STD_ERR_FILE} ]; then
    log_msg ${ERR} "PSQLエラー"
    log_msg ${ERR} "PSQLエラーメッセージ...\n$(cat ${STD_ERR_FILE})"
    delete_std_out_file
    log_msg ${ERR} "異常終了"
    exit 1
fi

# 出力したファイルへ書込権を付与
# 単体実行時 と Rundeck実行時 で 所有者が異なるため実装
chmod a+w "${export_file_path}" 2> ${STD_ERR_FILE}
status=$?
if [ ${status} -ne 0 ]; then
    log_msg ${ERR} "出力ファイルへの書込権付与でエラーが発生しました"
    log_msg ${ERR} "chmodエラーメッセージ...\n$(cat ${STD_ERR_FILE})"
    delete_std_out_file
    log_msg ${ERR} "異常終了"
    exit ${status}
fi

# 出力確認用ファイルの削除
delete_std_out_file

log_msg ${INFO} "正常終了"
exit 0
