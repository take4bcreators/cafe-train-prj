#!/bin/bash

# 機能別設定ファイル名を指定
grp_env_file_name='grp_env_build_site.sh'

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


# 環境変数チェック
if [ -z "${GRP_PAGE_CONT_CSV}" ]; then
    log_msg ${ERR} "環境変数が設定されていません"
    log_msg ${ERR} "変数名：GRP_PAGE_CONT_CSV"
    log_msg ${ERR} "異常終了"
    exit 1
fi

if [ -z "${SSG_DATA_DIR}" ]; then
    log_msg ${ERR} "環境変数が設定されていません"
    log_msg ${ERR} "変数名：SSG_DATA_DIR"
    log_msg ${ERR} "異常終了"
    exit 1
fi


# ファイル・ディレクトリの存在チェック
if [ ! -f "${GRP_PAGE_CONT_CSV}" ]; then
    log_msg ${ERR} "コピー元ファイルが存在しません"
    log_msg ${ERR} "指定されたファイルパス：${GRP_PAGE_CONT_CSV}"
    log_msg ${ERR} "異常終了"
    exit 1
fi

if [ ! -d "${SSG_DATA_DIR}" ]; then
    log_msg ${ERR} "コピー先ディレクトリが存在しません"
    log_msg ${ERR} "指定されたディレクトリパス：${SSG_DATA_DIR}"
    log_msg ${ERR} "異常終了"
    exit 1
fi


# ファイルコピー
log_msg ${INFO} "コピー元ファイル    ：${GRP_PAGE_CONT_CSV}"
log_msg ${INFO} "コピー先ディレクトリ：${SSG_DATA_DIR}"
cp "${GRP_PAGE_CONT_CSV}" "${SSG_DATA_DIR}" 2> "${STD_ERR_FILE}"
status=$?

if [ ${status} -ne 0 ]; then
    log_msg ${ERR} "ファイルコピーでエラーが発生しました"
    log_msg ${ERR} "cpコマンド戻り値：${status}"
    log_msg ${ERR} "cpコマンドエラーメッセージ...\n$(cat ${STD_ERR_FILE})"
    delete_std_out_file
    log_msg ${ERR} "異常終了"
    exit 1
fi


delete_std_out_file
log_msg ${INFO} "正常終了"
exit 0
