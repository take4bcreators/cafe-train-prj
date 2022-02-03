-- 処理対象指定
\set from_csv_path  :TMP_DIR'/tmp_ejp_join.csv'
\set to_table_name  'ejp_join'
\set column_list    'line_cd,station_cd1,station_cd2'

-- 読込コマンド組立・実行 (カンマ区切り・列指定あり・ヘッダーあり)
\set importcmd      '\\COPY ':schema'.':to_table_name'(':column_list') FROM \'':from_csv_path'\' WITH CSV Header'
:importcmd
