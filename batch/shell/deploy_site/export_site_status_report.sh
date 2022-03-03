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
if [ -z "${NL_SITE_STATUS_REPORT}" ]; then
    log_msg ${ERR} "環境変数が設定されていません"
    log_msg ${ERR} "変数名：NL_SITE_STATUS_REPORT"
    log_msg ${ERR} "異常終了"
    exit 1
fi

if [ -z "${NL_TOKEN}" ]; then
    log_msg ${ERR} "環境変数が設定されていません"
    log_msg ${ERR} "変数名：NL_TOKEN"
    log_msg ${ERR} "異常終了"
    exit 1
fi

if [ -z "${DEPLOY_PRD_DEV_FLAG}" ]; then
    log_msg ${ERR} "環境変数が設定されていません"
    log_msg ${ERR} "変数名：DEPLOY_PRD_DEV_FLAG"
    log_msg ${ERR} "異常終了"
    exit 1
fi

if [ -z "${NL_STATUS_RES_LOG_NAME}" ]; then
    log_msg ${ERR} "環境変数が設定されていません"
    log_msg ${ERR} "変数名：NL_STATUS_RES_LOG_NAME"
    log_msg ${ERR} "異常終了"
    exit 1
fi


# ディレクトリ・ファイルの存在チェック
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


# ログパスの設定
status_tmp_log_path="${MOD_LOG_DIR}/${NL_STATUS_RES_LOG_NAME}"

# リクエスト情報ログ出力
log_msg ${INFO} "実行リクエスト...
curl -Ss -X GET -H \"Authorization: Bearer XXXXXXXX\"
                \"https://api.netlify.com/api/v1/sites/${nl_site_id}/deploys\""

# ステータス確認実行
curl -Ss -X GET -H "Authorization: Bearer ${NL_TOKEN}" \
                   "https://api.netlify.com/api/v1/sites/${nl_site_id}/deploys" \
                   | jq . > "${status_tmp_log_path}" 2> "${STD_ERR_FILE}"
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
dep_res_name=$(cat ${status_tmp_log_path} | jq -r '.[0] | .name')
dep_res_url=$(cat ${status_tmp_log_path} | jq -r '.[0] | .ssl_url')
dep_res_status=$(cat ${status_tmp_log_path} | jq -r '.[0] | .state')
dep_res_createdat=$(cat ${status_tmp_log_path} | jq -r '.[0] | .created_at')
dep_res_updatedat=$(cat ${status_tmp_log_path} | jq -r '.[0] | .updated_at')
dep_res_adminurl=$(cat ${status_tmp_log_path} | jq -r '.[0] | .admin_url')
dep_res_errmsg=$(cat ${status_tmp_log_path} | jq -r '.[0] | .error_message')

# 時刻情報（レスポンスは UTC なので JST に変換）
now_date=$(date "+%Y年%m月%d日 %H:%M:%S")
dep_res_createdat_jst=$(date +"%Y年%m月%d日 %H:%M:%S" -d "${dep_res_createdat}")
dep_res_updatedat_jst=$(date +"%Y年%m月%d日 %H:%M:%S" -d "${dep_res_updatedat}")

# レポート作成
report_text="
【サイトステータスレポート】
    ■ サイト名           ： ${dep_res_name}
    ■ サイトURL          ： ${dep_res_url}
    ■ ステータス         ： ${dep_res_status}
    ■ 作成日             ： ${dep_res_createdat_jst}
    ■ 更新日             ： ${dep_res_updatedat_jst}
    ■ 管理画面URL        ： ${dep_res_adminurl}
    ■ エラーメッセージ   ： ${dep_res_errmsg}

${now_date} 出力
"

# レポートファイルがない場合は、新規作成して書込権を付与
# 単体実行時 と Rundeck実行時 で 所有者が異なるため実装
if [ ! -f "${NL_SITE_STATUS_REPORT}" ]; then
    touch "${NL_SITE_STATUS_REPORT}"
    chmod a+w "${NL_SITE_STATUS_REPORT}" 2> ${STD_ERR_FILE}
    status=$?
    if [ ${status} -ne 0 ]; then
        log_msg ${ERR} "レポートファイルへの書込権付与でエラーが発生しました"
        log_msg ${ERR} "chmod コマンドエラーメッセージ...\n$(cat ${STD_ERR_FILE})"
        delete_std_out_file
        log_msg ${ERR} "異常終了"
        exit ${status}
    fi
fi

# レポート出力
echo -e "${report_text}" > ${NL_SITE_STATUS_REPORT}
status=$?
if [ ${status} -ne 0 ]; then
    log_msg ${ERR} "レポート出力でエラーが発生しました"
    delete_std_out_file
    log_msg ${ERR} "異常終了"
    exit ${status}
fi

delete_std_out_file
log_msg ${INFO} "正常終了"
exit 0
