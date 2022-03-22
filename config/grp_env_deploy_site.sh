# 機能別設定
export MOD_GRP_NAME="deploy_site"


#########################
# ファイルパス定義
#########################
export SITE_DATA_ZIP_NAME="staticsite_data.zip"
export NL_SITE_STATUS_REPORT="${DATA_DIR}/site_status_report.txt"

#########################
# 設定値
#########################
# 本番サイトのサイトID （http:// XXXX.netlify.app の https// を除いた部分）
export NL_PRD_SITE_ID="take4b-cafein.netlify.app"

# 検証サイトのサイトID （http:// XXXX.netlify.app の https// を除いた部分）
export NL_DEV_SITE_ID="musing-heyrovsky-98930a.netlify.app"

# デプロイフラグ（1:本番サイト/2:検証用サイト）
export DEPLOY_PRD_DEV_FLAG="2"

# デプロイ時の一時ログのファイル名
export NL_DEPLOY_RES_LOG_NAME="deploy_curl_res.log"

# サイトステータス確認時の一時ログのファイル名
export NL_STATUS_RES_LOG_NAME="status_curl_res.log"

