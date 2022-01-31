#!/bin/bash

# 実行シェルの名前を指定
exec_shell_name='copy_ekidata_csv.sh'
# 機能別設定ファイル名を指定
grp_env_file_name='grp_env_create_placesapi_request.sh'
# コピー対象ファイルタイプ（YYYYMMDDを含めた形式）
csv_file_type='lineYYYYMMDDfree.csv'
# コピー先の一時ファイル名
tmp_file_name='tmp_ejp_line.csv'

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
#  copy_ekidata_csv.sh 機能別設定ファイル名 このシェルのファイル名 コピー対象ファイルタイプ コピー先の一時ファイル名
${exec_shell} ${grp_env_file_name} ${this_shell_name} ${csv_file_type} ${tmp_file_name}

exit $?
