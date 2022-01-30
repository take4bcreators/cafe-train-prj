-- 処理対象指定
\set from_table_name    'esp_company'
\set column_list        'company_code'
\set to_csv_path        :project_root'/tmp/tmp_request_company.csv'

-- 出力コマンド組立・実行 (カンマ区切り形式)
\set outputcmd '\\COPY (SELECT ':column_list' FROM ':schema'.':from_table_name') TO \'':to_csv_path'\' WITH CSV'
:outputcmd
