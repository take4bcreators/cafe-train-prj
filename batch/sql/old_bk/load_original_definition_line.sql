-- 処理対象指定
\set from_csv_path  :project_root'/batch/csv/mst_original_definition_line.csv'
\set to_table_name  'mst_original_definition_line'
\set column_list    'line_code,line_definition_code,line_definition_name,line_definition_color'

-- 読込コマンド組立・実行 (カンマ区切り・ヘッダーなし)
\set importcmd '\\COPY ':schema'.':to_table_name'(':column_list') FROM \'':from_csv_path'\' WITH CSV'
:importcmd
