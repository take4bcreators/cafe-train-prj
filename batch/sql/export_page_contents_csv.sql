-- 処理対象指定
\set from_table_name    'page_contents'
\set to_csv_path        :SHL_EXPORT_FILE_PATH

-- 出力コマンド組立・実行 (CSV／列指定なし／ヘッダーあり)
\set exportcmd          '\\COPY (SELECT * FROM ':schema'.':from_table_name') TO \'':to_csv_path'\' WITH CSV HEADER'
:exportcmd
