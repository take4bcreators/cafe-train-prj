-- 処理対象指定
\set from_csv_path  :CSV_DIR'/company_url.csv'
\set to_table_name  'mst_company_url'
\set column_list    'company_cd, company_url_str, note'

-- 読込コマンド組立・実行 (カンマ区切り・列指定あり・ヘッダーなし)
\set importcmd      '\\COPY ':schema'.':to_table_name'(':column_list') FROM \'':from_csv_path'\' WITH CSV'
:importcmd
