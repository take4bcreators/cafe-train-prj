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
if [ -z "${SSG_DIR}" ]; then
    log_msg ${ERR} "環境変数が設定されていません"
    log_msg ${ERR} "変数名：SSG_DIR"
    log_msg ${ERR} "異常終了"
    exit 1
fi

if [ -z "${SSG_PUBLIC_DIR_NAME}" ]; then
    log_msg ${ERR} "環境変数が設定されていません"
    log_msg ${ERR} "変数名：SSG_PUBLIC_DIR_NAME"
    log_msg ${ERR} "異常終了"
    exit 1
fi

if [ -z "${DATA_DIR}" ]; then
    log_msg ${ERR} "環境変数が設定されていません"
    log_msg ${ERR} "変数名：DATA_DIR"
    log_msg ${ERR} "異常終了"
    exit 1
fi


# ファイル・ディレクトリの存在チェック
if [ ! -d "${SSG_DIR}/${SSG_PUBLIC_DIR_NAME}" ]; then
    log_msg ${ERR} "コピー元ディレクトリが存在しません"
    log_msg ${ERR} "指定されたディレクトリパス：${SSG_DIR}/${SSG_PUBLIC_DIR_NAME}"
    log_msg ${ERR} "異常終了"
    exit 1
fi


# 既存のZIPを削除
if [ -f "${SITE_DATA_ZIP}" ]; then
    log_msg ${INFO} "既存のZIPファイルを削除します"
    log_msg ${INFO} "削除ファイル：${SITE_DATA_ZIP}"
    rm "${SITE_DATA_ZIP}"
    status=$?
    if [ ${status} -ne 0 ]; then
        log_msg ${ERR} "既存ZIP削除でエラーが発生しました"
        log_msg ${ERR} "cpコマンド戻り値：${status}"
        delete_std_out_file
        log_msg ${ERR} "異常終了"
        exit 1
    fi
fi

# ディレクトリ移動
cd "${SSG_DIR}"
log_msg ${INFO} "作業ディレクトリ：$(pwd)"

# ZIP化実行
# （書式）zip ZIP化後ファイル名 -r 対象ディレクトリ
# zip内の階層を浅くするため、対象ディレクトリは 相対パス で指定
zip "${SITE_DATA_ZIP}" -r "${SSG_PUBLIC_DIR_NAME}" > "${STD_OUT_FILE}" 2> "${STD_ERR_FILE}"
status=$?

if [ ${status} -ne 0 ]; then
    log_msg ${ERR} "zipコマンドでエラーが発生しました"
    log_msg ${ERR} "zipコマンド戻り値：${status}"
    log_msg ${ERR} "zipコマンド標準メッセージ...\n$(cat ${STD_OUT_FILE})"
    log_msg ${ERR} "zipコマンドエラーメッセージ...\n$(cat ${STD_ERR_FILE})"
    delete_std_out_file
    log_msg ${ERR} "異常終了"
    exit 1
fi

log_msg ${INFO} "zipコマンド標準メッセージ...\n$(cat ${STD_OUT_FILE})"
log_msg ${INFO} "作成ZIPファイルパス：${SITE_DATA_ZIP}"
delete_std_out_file
log_msg ${INFO} "正常終了"
exit 0
