#!/bin/bash

# 実行シェルの名前を指定
exec_shell_name='delete_tmp_file.sh'
# 機能別設定ファイル名を指定
grp_env_file_name='grp_env_import_train.sh'
# 削除tmpファイル名を指定
delete_file_name='tmp_ejp_join.csv'


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
#  delete_tmp_file.sh 機能別設定ファイル名 このシェルのファイル名 削除tmpファイル名
${exec_shell} ${grp_env_file_name} ${this_shell_name} ${delete_file_name}

exit $?
