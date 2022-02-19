#!/bin/bash

# 実行シェルの名前を指定
exec_shell_name="export_db_data.sh"
# 機能別設定ファイル名を指定
grp_env_file_name="grp_env_create_request.sh"
# 実行SQLファイル名を指定
exec_sql_file_name="export_placesapi_request_data_csv.sql"
# 出力ファイルパスの指定方法を指定（0：パスを直接指定、1：パスの情報がある環境変数名を指定）
export_file_specified_method="1"
# 出力ファイルパスの指定（上記の指定方法で指定）
export_file_id="GRP_REQUEST_CSV"


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

# 機能別設定読み込みファイルの存在チェックと読み込み
if [ ! -f ${CONFIG_DIR}/${grp_env_file_name} ]; then
    echo "ERROR 機能別設定読み込みファイルが存在しません"
    exit 1
fi
source ${CONFIG_DIR}/${grp_env_file_name}

# 出力ファイルパスを指定した方法で設定
case "${export_file_specified_method}" in
    0) export_file_path="${export_file_id}" ;;
    1) export_file_path="${!export_file_id}" ;;
    *) export_file_path="" ;;
esac
if [ -z "${export_file_path}" ]; then
    echo "出力ファイルパスが設定されませんでした"
    exit 1
fi

# 実行シェル名をパスに変換
exec_shell="${COM_SHELL_DIR}/${exec_shell_name}"

# シェル実行
#  export_db_data.sh このシェルのファイル名 実行SQLファイル名 出力するファイルのパス
${exec_shell} "${this_shell_name}" "${exec_sql_file_name}" "${export_file_path}"

exit $?
