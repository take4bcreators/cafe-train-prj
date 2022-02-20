-- 処理対象指定
\set from_csv_path  :GRP_NUMBERING_CSV
\set to_table_name  'mst_numbering_info'
\set column_list    'station_cd, new_line_cd, numbering, note'

-- 読込コマンド組立・実行 (カンマ区切り・列指定あり・ヘッダーあり)
\set importcmd      '\\COPY ':schema'.':to_table_name'(':column_list') FROM \'':from_csv_path'\' WITH CSV HEADER'
:importcmd
