# 機能別設定
export MOD_GRP_NAME="execution_placesapi"

#########################
# ファイルパス定義
#########################
export GRP_REQUEST_CSV="${DATA_DIR}/placesapi_request_data.csv"
export GRP_GMP_TSV="${DATA_DIR}/get_gmp_data.tsv"
export GRP_CURL_RES_TMP="${TMP_DIR}/curlres.$$.tmp"

#########################
# Places API 関連
#########################
export GRP_RADIUS_METER="400"

#########################
# 設定値の定義
#########################
export RETRY_INTERVAL_SEC=30
export MAX_RETRY_TIMES=3

