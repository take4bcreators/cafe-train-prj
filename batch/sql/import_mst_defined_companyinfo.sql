-- 処理対象指定
\set from_csv_path  :GRP_DEF_COMP_CSV
\set to_table_name  'mst_defined_companyinfo'
\set column_list    'company_cd, def_company_name, note'

-- 読込コマンド組立・実行 (CSV形式・列指定あり・ヘッダーなし)
\set importcmd      '\\COPY ':schema'.':to_table_name'(':column_list') FROM \'':from_csv_path'\' WITH CSV'
:importcmd
