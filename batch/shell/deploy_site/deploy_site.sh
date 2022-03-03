#!/bin/bash

# 機能別設定ファイル名を指定
grp_env_file_name='grp_env_deploy_site.sh'

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
if [ -z "${DATA_DIR}" ]; then
    log_msg ${ERR} "環境変数が設定されていません"
    log_msg ${ERR} "変数名：DATA_DIR"
    log_msg ${ERR} "異常終了"
    exit 1
fi

if [ -z "${NL_TOKEN}" ]; then
    log_msg ${ERR} "環境変数が設定されていません"
    log_msg ${ERR} "変数名：NL_TOKEN"
    log_msg ${ERR} "異常終了"
    exit 1
fi

if [ -z "${SITE_DATA_ZIP_NAME}" ]; then
    log_msg ${ERR} "環境変数が設定されていません"
    log_msg ${ERR} "変数名：SITE_DATA_ZIP_NAME"
    log_msg ${ERR} "異常終了"
    exit 1
fi

if [ -z "${DEPLOY_PRD_DEV_FLAG}" ]; then
    log_msg ${ERR} "環境変数が設定されていません"
    log_msg ${ERR} "変数名：DEPLOY_PRD_DEV_FLAG"
    log_msg ${ERR} "異常終了"
    exit 1
fi

if [ -z "${NL_DEPLOY_RES_LOG_NAME}" ]; then
    log_msg ${ERR} "環境変数が設定されていません"
    log_msg ${ERR} "変数名：NL_DEPLOY_RES_LOG_NAME"
    log_msg ${ERR} "異常終了"
    exit 1
fi


# ディレクトリ・ファイルの存在チェック
if [ ! -f "${DATA_DIR}/${SITE_DATA_ZIP_NAME}" ]; then
    log_msg ${ERR} "サイトデータZIPが存在しません"
    log_msg ${ERR} "指定されたパス：${DATA_DIR}/${SITE_DATA_ZIP_NAME}"
    log_msg ${ERR} "異常終了"
    exit 1
fi

if [ ! -d "${MOD_LOG_DIR}" ]; then
    log_msg ${ERR} "ログディレクトリが存在しません"
    log_msg ${ERR} "指定されたディレクトリパス：${MOD_LOG_DIR}"
    log_msg ${ERR} "異常終了"
    exit 1
fi


# デプロイフラグ認識
nl_site_id=""
if [ ${DEPLOY_PRD_DEV_FLAG} -eq 1 ]; then
    if [ -z "${NL_PRD_SITE_ID}" ]; then
        log_msg ${ERR} "環境変数が設定されていません"
        log_msg ${ERR} "変数名：NL_PRD_SITE_ID"
        log_msg ${ERR} "異常終了"
        exit 1
    fi
    nl_site_id="${NL_PRD_SITE_ID}"
elif [ ${DEPLOY_PRD_DEV_FLAG} -eq 2 ]; then
    if [ -z "${NL_DEV_SITE_ID}" ]; then
        log_msg ${ERR} "環境変数が設定されていません"
        log_msg ${ERR} "変数名：NL_DEV_SITE_ID"
        log_msg ${ERR} "異常終了"
        exit 1
    fi
    nl_site_id="${NL_DEV_SITE_ID}"
else
    log_msg ${ERR} "環境変数の設定値が正しくありません"
    log_msg ${ERR} "変数名：NL_PRD_SITE_ID"
    log_msg ${ERR} "設定値：${DEPLOY_PRD_DEV_FLAG}"
    log_msg ${ERR} "変数名：異常終了"
    exit 1
fi

if [ -z "${nl_site_id}" ]; then
    log_msg ${ERR} "サイトIDの設定で想定外のエラーが発生しました"
    log_msg ${ERR} "サイトID：${nl_site_id}"
    log_msg ${ERR} "異常終了"
    exit 1
fi


# ディレクトリ移動
cd "${DATA_DIR}"
log_msg ${INFO} "作業ディレクトリ：$(pwd)"

# ログパスの設定
deploy_tmp_log_path="${MOD_LOG_DIR}/${NL_DEPLOY_RES_LOG_NAME}"

# リクエスト情報ログ出力
log_msg ${INFO} "実行リクエスト...
curl -Ss -X POST -H \"Content-Type: application/zip\"
                 -H \"Authorization: Bearer XXXXXX\"
                 --data-binary \"@${SITE_DATA_ZIP_NAME}\"
                 \"https://api.netlify.com/api/v1/sites/${nl_site_id}/deploys\""

# デプロイ実行
curl -Ss -X POST -H "Content-Type: application/zip" \
                 -H "Authorization: Bearer ${NL_TOKEN}" \
                 --data-binary "@${SITE_DATA_ZIP_NAME}" \
                 "https://api.netlify.com/api/v1/sites/${nl_site_id}/deploys" \
                 | jq . > "${deploy_tmp_log_path}" 2> "${STD_ERR_FILE}"
status=$?

# curlのエラーが発生している場合は異常終了
if [ ${status} -ne 0 ] && [ -s ${STD_ERR_FILE} ]; then
    log_msg ${ERR} "APIリクエスト実行エラー"
    log_msg ${ERR} "curlコマンド戻り値：${status}"
    log_msg ${ERR} "curlコマンドエラーメッセージ...\n$(cat ${STD_ERR_FILE})"
    delete_std_out_file
    log_msg ${ERR} "異常終了"
    exit 1
fi

# レスポンス取得
dep_res_name=$(cat ${deploy_tmp_log_path} | jq -r '.name')
dep_res_url=$(cat ${deploy_tmp_log_path} | jq -r '.ssl_url')
dep_res_status=$(cat ${deploy_tmp_log_path} | jq -r '.state')
dep_res_createdat=$(cat ${deploy_tmp_log_path} | jq -r '.created_at')
dep_res_updatedat=$(cat ${deploy_tmp_log_path} | jq -r '.updated_at')
dep_res_errmsg=$(cat ${deploy_tmp_log_path} | jq -r '.error_message')

# ログ出力
log_msg ${INFO} "デプロイ情報..."
log_msg ${INFO} "サイト名：${dep_res_name}"
log_msg ${INFO} "サイトURL：${dep_res_url}"
log_msg ${INFO} "ステータス：${dep_res_status}"
log_msg ${INFO} "作成日時：${dep_res_createdat}"
log_msg ${INFO} "更新日時：${dep_res_updatedat}"
log_msg ${INFO} "エラーメッセージ：${dep_res_errmsg}"

# レスポンスのステータスの文言で成功判定
if [ "${dep_res_status}" != "uploaded" ]; then
    log_msg ${ERR} "でプロステータスが uploaded ではありません"
    delete_std_out_file
    log_msg ${ERR} "異常終了"
    exit 1
fi

delete_std_out_file
log_msg ${INFO} "正常終了"
exit 0
