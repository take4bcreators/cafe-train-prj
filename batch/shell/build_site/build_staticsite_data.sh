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

# ログディレクトリの設定
MOD_LOG_DIR="${LOG_DIR}/${MOD_GRP_NAME}"

# 環境変数チェック
if [ -z "${SSG_DIR}" ]; then
    log_msg ${ERR} "環境変数が設定されていません"
    log_msg ${ERR} "変数名：SSG_DIR"
    log_msg ${ERR} "異常終了"
    exit 1
fi

if [ -z "${BUILD_TMP_LOG_NAME}" ]; then
    log_msg ${ERR} "環境変数が設定されていません"
    log_msg ${ERR} "変数名：BUILD_TMP_LOG_NAME"
    log_msg ${ERR} "異常終了"
    exit 1
fi


# ディレクトリの存在チェック
if [ ! -d "${SSG_DIR}" ]; then
    log_msg ${ERR} "SSGディレクトリが存在しません"
    log_msg ${ERR} "指定されたディレクトリパス：${SSG_DIR}"
    log_msg ${ERR} "異常終了"
    exit 1
fi

if [ ! -d "${MOD_LOG_DIR}" ]; then
    log_msg ${ERR} "ログディレクトリが存在しません"
    log_msg ${ERR} "指定されたディレクトリパス：${MOD_LOG_DIR}"
    log_msg ${ERR} "異常終了"
    exit 1
fi

# ディレクトリ移動
cd "${SSG_DIR}"
log_msg ${INFO} "作業ディレクトリ：$(pwd)"

# ビルド実行
BUILD_TMP_LOG_PATH="${MOD_LOG_DIR}/${BUILD_TMP_LOG_NAME}"
sudo gatsby build > "${BUILD_TMP_LOG_PATH}" 2>&1
status=$?

if [ ${status} -ne 0 ]; then
    log_msg ${ERR} "サイトデータビルドでエラーが発生しました"
    log_msg ${ERR} "gatsby build コマンド戻り値：${status}"
    log_msg ${ERR} "gatsby build コマンドメッセージ...\n$(cat ${BUILD_TMP_LOG_PATH})"
    delete_std_out_file
    log_msg ${ERR} "異常終了"
    exit 1
fi


log_msg ${ERR} "gatsby build コマンドメッセージ...\n$(cat ${BUILD_TMP_LOG_PATH})"
delete_std_out_file
log_msg ${INFO} "正常終了"
exit 0
