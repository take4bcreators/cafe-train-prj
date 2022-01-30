# 共通設定ファイル

#########################
# パス指定変数
#########################
# ディレクトリのパスの最後に / は入れない
BATCH_DIR=${PROJECT_ROOT}/batch
CONFIG_DIR=${PROJECT_ROOT}/config
DATA_DIR=${PROJECT_ROOT}/data
ENV_DIR=${PROJECT_ROOT}/env
LOG_DIR=${PROJECT_ROOT}/log
SSG_DIR=${PROJECT_ROOT}/ssg
TMP_DIR=${PROJECT_ROOT}/tmp
CSV_DIR=${BATCH_DIR}/csv
SHELL_DIR=${BATCH_DIR}/shell
SQL_DIR=${BATCH_DIR}/sql
EKIDATAJP_DIR=${CSV_DIR}/ekidatajp

#########################
# PostgreSQLの設定
#########################
DB_NAME='cafeindb001'
DB_USER='cafe'
DB_SCHEMA='dev'

#########################
# PostgreSQLのバインド変数
#########################
DB_BIND=" \
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
"
