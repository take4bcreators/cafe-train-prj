# 機能別設定
export MOD_GRP_NAME="create_ekicafe"

#########################
# ファイルパス定義
#########################
export GRP_GMP_TSV="${DATA_DIR}/get_gmp_data.tsv"
export GRP_EXCLUDE_PLACEID_CSV="${CSV_DIR}/exclude_placeid.csv"
export GRP_EKICAFE_REPORT_CSV="${DATA_DIR}/stationcafe_info_report.csv"


#########################
# 判定用定義
#########################
export GRP_RADIUS_METER="400"


#########################
# PostgreSQLのバインド変数（共通設定に追記）
# SQLでも環境変数を使用したい場合に指定する
#########################
export DB_BIND+=" \
    -v GRP_GMP_TSV=${GRP_GMP_TSV} \
    -v GRP_EXCLUDE_PLACEID_CSV=${GRP_EXCLUDE_PLACEID_CSV} \
    -v GRP_RADIUS_METER=${GRP_RADIUS_METER} \
"
