-- 処理対象指定
\set from_csv_path  :TMP_DIR'/tmp_ejp_line.csv'
\set to_table_name  'ejp_line'
\set column_list    'line_cd,company_cd,line_name,line_name_k,line_name_h,line_color_c,line_color_t,line_type,lon,lat,zoom,e_status,e_sort'

-- 読込コマンド組立・実行 (カンマ区切り・列指定あり・ヘッダーあり)
\set importcmd      '\\COPY ':schema'.':to_table_name'(':column_list') FROM \'':from_csv_path'\' WITH CSV Header'
:importcmd
