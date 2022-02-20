-- 処理対象指定
\set from_csv_path  :GRP_TARGET_LINE_CSV
\set to_table_name  'mst_fetch_target_line'
\set column_list    'type_cd, target_cd, note'

-- 読込コマンド組立・実行 (CSV・列指定あり・ヘッダーあり)
\set importcmd      '\\COPY ':schema'.':to_table_name'(':column_list') FROM \'':from_csv_path'\' WITH CSV Header'
:importcmd
