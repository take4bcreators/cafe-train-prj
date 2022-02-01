-- 処理対象指定
\set from_table_name    'tmp_unique_fetch_lineinfo'
\set column_list        'lat,lon'
\set to_csv_path        :DATA_DIR'/placesapi_request_data.csv'

-- 出力コマンド組立・実行 (カンマ区切り形式)
\set exportcmd          '\\COPY (SELECT ':column_list' FROM ':schema'.':from_table_name') TO \'':to_csv_path'\' WITH CSV'
:exportcmd
