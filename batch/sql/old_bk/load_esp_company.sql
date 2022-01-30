-- 処理対象指定
\set from_csv_path  :project_root'/tmp/tmp_esp_company.csv'
\set to_table_name  'esp_company'

-- 読込コマンド組立・実行 (カンマ区切り・ヘッダーなし・列指定なし)
\set importcmd '\\COPY ':schema'.':to_table_name' FROM \'':from_csv_path'\' WITH CSV'
:importcmd
