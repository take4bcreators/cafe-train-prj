-- 処理対象指定
\set from_csv_path  :GRP_CAFE_MST_CSV
\set to_table_name  'mst_cafe_chain'
\set column_list    'chain_id, chain_name, api_search_word, res_judge_regexp, note'

-- 読込コマンド組立・実行 (CSV・列指定あり・ヘッダーあり)
\set importcmd      '\\COPY ':schema'.':to_table_name'(':column_list') FROM \'':from_csv_path'\' WITH CSV Header'
:importcmd
