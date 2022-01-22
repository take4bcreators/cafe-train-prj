#!/bin/bash

# 挙動変更用変数
db_schema='dev'
db_name='cafeindb001'
db_user='cafe'
tablelist_file='./tablelist.txt'
file_ext='.sql'
create_ddl_dir='../001_create_table_ddl'

# カウント用変数
exec_sql_count=0
success_count=0
failure_count=0

# 処理実行
echo "[一括 CREATE TABLE 開始]"
echo "  対象DB      ：${db_name}"
echo "  実行ユーザ  ：${db_user}"
echo "  対象スキーマ：${db_schema}"
echo ""

for table_name in $(cat ${tablelist_file} | sed  '/^$/d')
do
    ddl_file_path="${create_ddl_dir}/${table_name}${file_ext}"
    if [ -f "${ddl_file_path}" ]; then
        echo "実行SQLファイル：${ddl_file_path}"
        # ON_ERROR_STOP=1 とすることで、SQL失敗時に戻り値で 0 以外を返すようになる（SQLは失敗した場所で中断）
        psql -d ${db_name} -U ${db_user} -f "${ddl_file_path}" -v schema=${db_schema} -v ON_ERROR_STOP=1
        if [ $? -eq 0 ]; then
            let success_count++
        else
            let failure_count++
        fi
        let exec_sql_count++
    fi
done

echo ""
echo "[結果]"
echo "  実行テーブル数：${exec_sql_count}"
echo "  成功テーブル数：${success_count}"
echo "  失敗テーブル数：${failure_count}"

exit 0
