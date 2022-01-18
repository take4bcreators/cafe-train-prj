#!/bin/bash

# シェルの名前を格納
EXEC_SHELL_NAME=$(basename $0)

### 共通設定読み込み ###
# プロジェクトパス情報読み込みファイルの存在チェックと読み込み
if [ ! -f prjrootpath.sh ]; then
    echo "ERROR プロジェクトパス情報読み込みファイルが存在しません"
    exit 1
fi
source prjrootpath.sh

# 共通設定読み込みファイルの存在チェックと読み込み
if [ ! -f ${PROJECT_ROOT}/config/common_env.sh ]; then
    echo "ERROR 共通設定読み込みファイルが存在しません"
    exit 1
fi
source ${PROJECT_ROOT}/config/common_env.sh

# 機能別設定読み込みファイルの存在チェックと読み込み
grp_env_file_name=grp_env_create_placesapi_request.sh
if [ ! -f ${CONFIG_DIR}/${grp_env_file_name} ]; then
    echo "ERROR 機能別設定読み込みファイルが存在しません"
    exit 1
fi
source ${CONFIG_DIR}/${grp_env_file_name}

# 共通モジュール読み込みファイルの存在チェックと読み込み
if [ ! -f ${CONFIG_DIR}/common_lib.sh ]; then
    echo "ERROR 共通モジュール読み込みファイルが存在しません"
    exit 1
fi
source ${CONFIG_DIR}/common_lib.sh

# 認証情報読み込みファイルの存在チェックと読み込み
if [ ! -f ${ENV_DIR}/.env ]; then
    echo "ERROR 認証情報読み込みファイルが存在しません"
    exit 1
fi
source ${ENV_DIR}/.env

### メイン処理 ###
log_msg ${INFO} "実行開始"
echo "メイン処理"
log_msg ${INFO} "メイン処理実行中"
log_msg ${INFO} "実行完了"

exit 0
