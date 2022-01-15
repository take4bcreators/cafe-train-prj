#!/bin/bash

# 重要度
ERR=error
WRN=warning
INF=info
DEB=debug
SEP="\t"

LOG_FILE_NAME=$LOG_DIR/$MOD_GRP_NAME/$MOD_GRP_NAME_$(date +%Y%m%d).log

# ログ出力用関数
# 引数
#   1：重要度を示す変数
#   2：ログに出力するメッセージ
# 使用例：log_msg $INF "実行開始"
# 出力例：2022/01/01 10:01:36 info pid:3001 import_mst_prefectures_csv.sh 実行開始
function log_msg() {
    local logdata="$(date '+%Y/%m/%d %H:%M:%S')"
    local pri=$1
    local pid=$$
    local shlname=$EXEC_SHELL_NAME
    local logmsg=$2
    
    echo -e "${logdata}${SEP}${pri}${SEP}pid:${pid}${SEP}${shlname}${SEP}${logmsg}"
    
} >> $LOG_FILE_NAME




