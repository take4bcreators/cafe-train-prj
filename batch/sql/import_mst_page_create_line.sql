-- 処理対象指定
\set from_csv_path  :GRP_PAGE_CREATE_LINE_CSV
\set to_table_name  'mst_page_create_line'
\set column_list    'page_create_line_cd, note'

-- 読込コマンド組立・実行 (CSV形式・列指定あり・ヘッダーなし)
\set importcmd      '\\COPY ':schema'.':to_table_name'(':column_list') FROM \'':from_csv_path'\' WITH CSV'
:importcmd
