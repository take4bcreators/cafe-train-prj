-- 処理対象指定
\set from_csv_path  :project_root'/batch/csv/mst_target_prefectures.csv'
\set to_table_name  'mst_target_prefectures'
\set column_list    'target_prefecture_code'

-- 読込コマンド組立・実行 (テキスト形式)
\set importcmd '\\COPY ':schema'.':to_table_name'(':column_list') FROM \'':from_csv_path'\''
:importcmd
