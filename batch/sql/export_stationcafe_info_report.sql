-- 処理対象指定
\set from_table_name    'tmp_create_stationcafe_info'
\set to_csv_path        :GRP_EKICAFE_REP_CSV

-- 出力コマンド組立・実行 (カンマ区切り形式／列指定なし／ヘッダーあり)
\set exportcmd          '\\COPY (SELECT * FROM ':schema'.':from_table_name') TO \'':to_csv_path'\' WITH CSV HEADER'
:exportcmd
