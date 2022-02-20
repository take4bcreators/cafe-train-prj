#!/bin/bash

# 実行シェルの名前を指定
exec_shell_name='execute_sql.sh'
# 機能別設定ファイル名を指定
grp_env_file_name='grp_env_create_ekicafe.sh'
# 実行SQLファイル名を指定
exec_sql_file_name='truncate_add_station_name.sql'


# シェルの名前を格納
this_shell_name=$(basename $0)

# プロジェクトルート読み込みファイルの存在チェックと読み込み
if [ ! -f PROJECT_ROOT.sh ]; then
    echo "ERROR プロジェクトルート読み込みファイルが存在しません"
    exit 1
fi
source PROJECT_ROOT.sh

# 共通設定読み込みファイルの存在チェックと読み込み
if [ ! -f ${PROJECT_ROOT}/config/common_env.sh ]; then
    echo "ERROR 共通設定読み込みファイルが存在しません"
    exit 1
fi
source ${PROJECT_ROOT}/config/common_env.sh

# 実行シェル名をパスに変換
exec_shell=${COM_SHELL_DIR}/${exec_shell_name}

# シェル実行
#  execute_sql.sh 機能別設定ファイル名 このシェルのファイル名 実行SQLファイル名
${exec_shell} ${grp_env_file_name} ${this_shell_name} ${exec_sql_file_name}

exit $?
