-- 処理対象情報
\set to_table_name 'mst_fetch_target_chain'
\set column_list 'target_chain_id'
\set from_csv_path :project_root'/batch/csv/mst_fetch_target_chain.csv'

-- 読み込みコマンド組立・実行 (カンマ区切り・ヘッダーなし)
\set copycmd '\\COPY ':schema'.':to_table_name'(':column_list') FROM \'':from_csv_path'\' WITH CSV'
:copycmd
