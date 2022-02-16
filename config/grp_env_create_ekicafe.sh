# 機能別設定
export MOD_GRP_NAME="create_ekicafe"

#########################
# ファイルパス定義
#########################
export GRP_GMP_TSV="${DATA_DIR}/get_gmp_data.tsv"

#########################
# PostgreSQLのバインド変数（共通設定に追記）
# SQLでも環境変数を使用したい場合に指定する
#########################
export DB_BIND+=" \
    -v GRP_GMP_TSV=${GRP_GMP_TSV} \
"
