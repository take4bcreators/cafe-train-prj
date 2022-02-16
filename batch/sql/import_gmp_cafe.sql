-- 処理対象指定
\set from_csv_path  :DATA_DIR'/get_gmp_data.tsv'
\set to_table_name  'gmp_cafe'
\set column_list    'search_lat,search_lon,search_name,place_id,place_name,place_lat,place_lon'

-- 読込コマンド組立・実行 (列指定あり・ヘッダーなし・TSV)
\set importcmd      '\\COPY ':schema'.':to_table_name'(':column_list') FROM \'':from_csv_path'\''
:importcmd
