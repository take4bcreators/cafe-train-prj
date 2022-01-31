-- 処理対象指定
\set from_csv_path  :PROJECT_ROOT'/batch/csv/ekidatajp/company20200619.csv'
\set to_table_name  'ejp_company'
\set column_list    'company_cd,rr_cd,company_name,company_name_k,company_name_h,company_name_r,company_url,company_type,e_status,e_sort'

-- 読込コマンド組立・実行 (カンマ区切り・列指定あり・ヘッダーあり)
\set importcmd      '\\COPY ':schema'.':to_table_name'(':column_list') FROM \'':from_csv_path'\' WITH CSV Header'
:importcmd
