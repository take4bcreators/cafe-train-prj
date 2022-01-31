# 共通設定ファイル

#########################
# パス指定変数
# ディレクトリのパスの最後に / は入れない
#########################
# 第1階層ディレクトリ
export BATCH_DIR=${PROJECT_ROOT}/batch
export CONFIG_DIR=${PROJECT_ROOT}/config
export DATA_DIR=${PROJECT_ROOT}/data
export ENV_DIR=${PROJECT_ROOT}/env
export LOG_DIR=${PROJECT_ROOT}/log
export SSG_DIR=${PROJECT_ROOT}/ssg
export TMP_DIR=${PROJECT_ROOT}/tmp

# 第2階層ディレクトリ
export CSV_DIR=${BATCH_DIR}/csv
export SHELL_DIR=${BATCH_DIR}/shell
export SQL_DIR=${BATCH_DIR}/sql

# 第3階層ディレクトリ
export EKIDATAJP_DIR=${CSV_DIR}/ekidatajp
export COM_SHELL_DIR=${SHELL_DIR}/common

# ファイルパス
export COMMON_LIB_SH=${CONFIG_DIR}/common_lib.sh
export DOT_ENV=${ENV_DIR}/.env


#########################
# PostgreSQLの設定
#########################
export DB_NAME='cafeindb001'
export DB_USER='cafe'
export DB_SCHEMA='dev'


#########################
# PostgreSQLのバインド変数
#########################
export DB_BIND=" \
    -v schema=${DB_SCHEMA} \
    -v PROJECT_ROOT=${PROJECT_ROOT} \
    -v BATCH_DIR=${BATCH_DIR} \
    -v CONFIG_DIR=${CONFIG_DIR} \
    -v DATA_DIR=${DATA_DIR} \
    -v ENV_DIR=${ENV_DIR} \
    -v LOG_DIR=${LOG_DIR} \
    -v SSG_DIR=${SSG_DIR} \
    -v TMP_DIR=${TMP_DIR} \
    -v CSV_DIR=${CSV_DIR} \
    -v SHELL_DIR=${SHELL_DIR} \
    -v SQL_DIR=${SQL_DIR} \
    -v EKIDATAJP_DIR=${EKIDATAJP_DIR} \
    -v COM_SHELL_DIR=${COM_SHELL_DIR} \
"
