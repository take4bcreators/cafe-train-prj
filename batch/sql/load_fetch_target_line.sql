-- 処理対象指定
\set from_csv_path  :project_root'/batch/csv/mst_fetch_target_line.csv'
\set to_table_name  'mst_fetch_target_line'
\set column_list    'target_line_code'

-- 読込コマンド組立・実行 (カンマ区切り・ヘッダーなし)
\set importcmd '\\COPY ':schema'.':to_table_name'(':column_list') FROM \'':from_csv_path'\' WITH CSV'
:importcmd
