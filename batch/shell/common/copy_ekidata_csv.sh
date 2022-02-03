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


##### 引数チェック #####
# 個数チェック
if [ $# -ne 4 ]; then
    echo "ERROR 引数の数が正しくありません"
    exit 1
fi


##### 共通設定読み込み #####
# 機能別設定読み込みファイルの存在チェックと読み込み
grp_env_file_name=$1
if [ ! -f ${CONFIG_DIR}/${grp_env_file_name} ]; then
    echo "ERROR 機能別設定読み込みファイルが存在しません"
    exit 1
fi
source ${CONFIG_DIR}/${grp_env_file_name}

# 共通モジュール読み込みファイルの存在チェックと読み込み
exec_shell_name=$2
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

# コピー対象CSV絞り込み
csv_file_type=$3
csv_file_type=$(echo ${csv_file_type} | sed 's/YYYYMMDD/\*/')
copy_target=$(ls -r ${EKIDATAJP_DIR}/${csv_file_type} | head -1)
if [ -z "${copy_target}" ]; then
    log_msg ${ERR} "コピー対象ファイルがありません"
    log_msg ${ERR} "コピー対象ファイル：${copy_target}"
    exit 1
fi

# CSVコピー
tmp_file_name=$4
copy_to="${TMP_DIR}/${tmp_file_name}"
log_msg ${INFO} "CSVファイルコピー"
log_msg ${INFO} "コピー元ファイル：${copy_target}"
log_msg ${INFO} "コピー先ファイル：${copy_to}"
cp ${copy_target} ${copy_to}
rtn_cd=$?
if [ ${rtn_cd} -ne 0 ]; then
    log_msg ${ERR} "CSVファイルコピーでエラーが発生しました"
    exit 1
fi

log_msg ${INFO} "実行完了"

exit 0
