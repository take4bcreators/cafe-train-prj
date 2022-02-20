-- 処理対象指定
\set from_csv_path  :GRP_COMP_URL_CSV
\set to_table_name  'mst_company_url'
\set column_list    'company_cd, company_url_str, note'

-- 読込コマンド組立・実行 (CSV形式・列指定あり・ヘッダーあり)
\set importcmd      '\\COPY ':schema'.':to_table_name'(':column_list') FROM \'':from_csv_path'\' WITH CSV HEADER'
:importcmd
