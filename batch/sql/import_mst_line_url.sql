-- 処理対象指定
\set from_csv_path  :GRP_LINE_URL_CSV
\set to_table_name  'mst_line_url'
\set column_list    'line_cd, line_url_str, note'

-- 読込コマンド組立・実行 (CSV形式・列指定あり・ヘッダーあり)
\set importcmd      '\\COPY ':schema'.':to_table_name'(':column_list') FROM \'':from_csv_path'\' WITH CSV HEADER'
:importcmd
