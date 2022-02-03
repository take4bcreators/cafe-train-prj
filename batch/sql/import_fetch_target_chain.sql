-- 処理対象指定
\set from_csv_path  :CSV_DIR'/mst_fetch_target_chain.csv'
\set to_table_name  'mst_fetch_target_chain'
\set column_list    'target_chain_id'

-- 読込コマンド組立・実行 (列指定あり・ヘッダーなし)
\set importcmd      '\\COPY ':schema'.':to_table_name'(':column_list') FROM \'':from_csv_path'\''
:importcmd
