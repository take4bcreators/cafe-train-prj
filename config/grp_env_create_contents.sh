# 機能別設定
export MOD_GRP_NAME="create_contents"

#########################
# ファイルパス定義
#########################
export GRP_DEF_COMP_CSV="${CSV_DIR}/defined_companyinfo.csv"
export GRP_COMP_URL_CSV="${CSV_DIR}/company_url.csv"
export GRP_DEF_LINE_CSV="${CSV_DIR}/defined_lineinfo.csv"
export GRP_LINE_COLOR_CSV="${CSV_DIR}/linecolor.csv"
export GRP_LINE_URL_CSV="${CSV_DIR}/line_url.csv"
export GRP_PAGE_CREATE_LINE_CSV="${CSV_DIR}/page_create_line.csv"
export GRP_DEF_ST_CSV="${CSV_DIR}/defined_stationinfo.csv"
export GRP_NUMBERING_CSV="${CSV_DIR}/numbering_info.csv"
export GRP_PAGE_CONT_CSV="${DATA_DIR}/page_contents.csv"


#########################
# PostgreSQLのバインド変数（共通設定に追記）
# SQLでも環境変数を使用したい場合に指定する
#########################
export DB_BIND+=" \
    -v GRP_DEF_COMP_CSV=${GRP_DEF_COMP_CSV} \
    -v GRP_COMP_URL_CSV=${GRP_COMP_URL_CSV} \
    -v GRP_DEF_LINE_CSV=${GRP_DEF_LINE_CSV} \
    -v GRP_LINE_COLOR_CSV=${GRP_LINE_COLOR_CSV} \
    -v GRP_LINE_URL_CSV=${GRP_LINE_URL_CSV} \
    -v GRP_PAGE_CREATE_LINE_CSV=${GRP_PAGE_CREATE_LINE_CSV} \
    -v GRP_DEF_ST_CSV=${GRP_DEF_ST_CSV} \
    -v GRP_NUMBERING_CSV=${GRP_NUMBERING_CSV} \
"
