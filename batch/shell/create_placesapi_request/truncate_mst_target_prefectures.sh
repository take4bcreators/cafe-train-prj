#!/bin/bash

# 実行するSQLファイル名を指定
exec_sql_file_name='truncate_mst_target_prefectures.sql'

# シェルの名前を格納
exec_shell_name=$(basename $0)

# プロジェクトパス情報読み込みファイルの存在チェックと読み込み
if [ ! -f prjrootpath.sh ]; then
    echo "ERROR プロジェクトパス情報読み込みファイルが存在しません"
    exit 1
fi
source prjrootpath.sh

# SQL実行シェルのパスを指定
exec_sql_shell_path=${PROJECT_ROOT}/batch/shell/create_placesapi_request/execute_sql.sh

# SQL実行シェル実行
#   execute_sql.sh 実行SQLファイル名 このシェルのファイル名
${exec_sql_shell_path} ${exec_sql_file_name} ${exec_shell_name}

exit $?
