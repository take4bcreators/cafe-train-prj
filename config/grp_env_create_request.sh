# 機能別設定
export MOD_GRP_NAME="create_request"

#########################
# ファイルパス定義
#########################
export GRP_TARGET_LINE_CSV="${CSV_DIR}/mst_fetch_target_line.csv"
export GRP_TARGET_CHAIN_CSV="${CSV_DIR}/mst_fetch_target_chain.csv"
export GRP_CAFE_MST_CSV="${CSV_DIR}/mst_cafe_chain.csv"
export GRP_REQUEST_CSV="${DATA_DIR}/placesapi_request_data.csv"
export GRP_REQUEST_REPORT="${DATA_DIR}/request_data_report.txt"

#########################
# Places API 関連
#########################
export GRP_REQUEST_COST_YEN="4"

#########################
# PostgreSQLのバインド変数（共通設定に追記）
# SQLでも環境変数を使用したい場合に指定する
#########################
export DB_BIND+=" \
    -v GRP_TARGET_LINE_CSV=${GRP_TARGET_LINE_CSV} \
    -v GRP_TARGET_CHAIN_CSV=${GRP_TARGET_CHAIN_CSV} \
    -v GRP_CAFE_MST_CSV=${GRP_CAFE_MST_CSV} \
    -v GRP_REQUEST_CSV=${GRP_REQUEST_CSV} \
"
