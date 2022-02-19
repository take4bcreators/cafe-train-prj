# 機能別設定
export MOD_GRP_NAME="create_contents"

#########################
# ファイルパス定義
#########################
export GRP_NUMBERING_CSV="${CSV_DIR}/numbering_info.csv"


#########################
# PostgreSQLのバインド変数（共通設定に追記）
# SQLでも環境変数を使用したい場合に指定する
#########################
export DB_BIND+=" \
    -v GRP_NUMBERING_CSV=${GRP_NUMBERING_CSV} \
"
