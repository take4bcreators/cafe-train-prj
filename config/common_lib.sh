#!/bin/bash

# ログ関連の出力指定
readonly ERR='ERROR'
readonly WARN='WARN'
readonly INFO='INFO'
readonly DEBUG='DEBUG'
readonly sep="\t"

# 必須変数存在確認
if [ -z "${EXEC_SHELL_NAME}" ]; then
    echo "ERROR 必須の変数が設定されていません"
    echo "設定されていない変数：EXEC_SHELL_NAME"
    exit 1
fi

if [ -z "${TMP_DIR}" ]; then
    echo "ERROR 必須の変数が設定されていません"
    echo "設定されていない変数：TMP_DIR"
    exit 1
fi

if [ -z "${LOG_DIR}" ]; then
    echo "ERROR 必須の変数が設定されていません"
    echo "設定されていない変数：LOG_DIR"
    exit 1
fi

if [ -z "${MOD_GRP_NAME}" ]; then
    echo "ERROR 必須の変数が設定されていません"
    echo "設定されていない変数：MOD_GRP_NAME"
    exit 1
fi

# 出力ファイル設定
STD_OUT_FILE="${TMP_DIR}/std_out_$$.tmp"
STD_ERR_FILE="${TMP_DIR}/std_err_$$.tmp"
LOG_FILE_NAME="${LOG_DIR}/${MOD_GRP_NAME}/${MOD_GRP_NAME}_$(date +%Y%m%d).log"


# ログ出力用関数
# 引数
#   1：重要度を示す変数
#   2：ログに出力するメッセージ
# 使用例：log_msg $INFO "実行開始"
# 出力例：2022-01-01 10:01:36 INFO pid:3001 import_mst_prefectures_csv.sh 実行開始
function log_msg() {
    local logdata="$(date '+%Y-%m-%d %H:%M:%S')"
    local pri=$1
    local pid=$$
    local shlname=${EXEC_SHELL_NAME}
    local logmsg=$2
    
    echo -e "${logdata}${sep}${pri}${sep}pid:${pid}${sep}${shlname}${sep}${logmsg}"
    
} >> ${LOG_FILE_NAME}




