-- 処理対象指定
\set from_csv_path  :TMP_DIR'/tmp_ejp_station.csv'
\set to_table_name  'ejp_station'
\set column_list    'station_cd,station_g_cd,station_name,station_name_k,station_name_r,line_cd,pref_cd,post,add,lon,lat,open_ymd,close_ymd,e_status,e_sort'

-- 読込コマンド組立・実行 (カンマ区切り・列指定あり・ヘッダーあり)
\set importcmd      '\\COPY ':schema'.':to_table_name'(':column_list') FROM \'':from_csv_path'\' WITH CSV Header'
:importcmd
