-- 処理対象指定
\set from_csv_path  :CSV_DIR'/mst_fetch_target_line.csv'
\set to_table_name  'mst_fetch_target_line'
\set column_list    'type_cd,target_cd'

-- 読込コマンド組立・実行 (カンマ区切り・列指定あり・ヘッダーなし)
\set importcmd      '\\COPY ':schema'.':to_table_name'(':column_list') FROM \'':from_csv_path'\' WITH CSV'
:importcmd
