-- 処理対象指定
\set from_csv_path  :GRP_DEF_LINE_CSV
\set to_table_name  'mst_defined_lineinfo'
\set column_list    'line_cd, def_line_cd, line_symbol, def_line_name, note'

-- 読込コマンド組立・実行 (CSV形式・列指定あり・ヘッダーなし)
\set importcmd      '\\COPY ':schema'.':to_table_name'(':column_list') FROM \'':from_csv_path'\' WITH CSV'
:importcmd
