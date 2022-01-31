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
if [ $# -ne 3 ]; then
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

# 削除ファイル情報組み立て
delete_file_name=$3
delete_target="${TMP_DIR}/${delete_file_name}"
log_msg ${INFO} "削除対象ファイル：${delete_target}"
if [ -z "${delete_target}" ]; then
    log_msg ${ERR} "ファイル名の指定が正しくありません"
    exit 1
fi

# 存在確認して削除
if [ -f ${delete_target} ]; then
    rm ${delete_target}
    rtn_cd=$?
    if [ ${rtn_cd} -ne 0 ]; then
        log_msg ${ERR} "ファイル削除でエラーが発生しました"
        exit 1
    fi
else
    log_msg ${WARN} "削除対象ファイルはありませんでした"
fi

log_msg ${INFO} "実行完了"

exit 0
