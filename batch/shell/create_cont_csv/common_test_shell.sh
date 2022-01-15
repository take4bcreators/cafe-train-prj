#!/bin/bash

# シェルの名前を格納
EXEC_SHELL_NAME=$(basename $0)

# プロジェクトパス情報読み込みファイルの存在チェックと読み込み
if [ ! -f prjrootpath.sh ]; then
    echo "プロジェクトパス情報読み込みファイルが存在しません"
    exit 1
fi
source prjrootpath.sh

# 共通設定読み込みファイルの存在チェックと読み込み
if [ ! -f $PROJECT_ROOT/config/common_env.sh ]; then
    echo "共通設定読み込みファイルが存在しません"
    exit 1
fi
source $PROJECT_ROOT/config/common_env.sh

# 機能別設定読み込みファイルの存在チェックと読み込み
GRP_ENV_FILE_NAME=grp_env_create_cont_csv.sh
if [ ! -f $CONFIG_DIR/$GRP_ENV_FILE_NAME ]; then
    echo "機能別設定読み込みファイルが存在しません"
    exit 1
fi
source $CONFIG_DIR/$GRP_ENV_FILE_NAME

# 共通モジュール読み込みファイルの存在チェックと読み込み
if [ ! -f $CONFIG_DIR/common_lib.sh ]; then
    echo "共通モジュール読み込みファイルが存在しません"
    exit 1
fi
source $CONFIG_DIR/common_lib.sh

# 認証情報読み込みファイルの存在チェックと読み込み
if [ ! -f $ENV_DIR/.env ]; then
    echo "認証情報読み込みファイルが存在しません"
    exit 1
fi
source $ENV_DIR/.env



log_msg $INFO "実行開始"

echo "メイン処理"
log_msg $INFO "メイン処理実行中"

log_msg $INFO "実行完了"

exit 0
