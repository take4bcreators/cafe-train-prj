-- 処理対象指定
\set from_table_name    'tmp_unique_fetch_lineinfo'
\set column_list        'lat, lon'
\set to_csv_path        :SHL_EXPORT_FILE_PATH

-- 出力コマンド組立・実行 (CSV／列指定あり／ヘッダーなし)
\set exportcmd          '\\COPY (SELECT ':column_list' FROM ':schema'.':from_table_name') TO \'':to_csv_path'\' WITH CSV'
:exportcmd
