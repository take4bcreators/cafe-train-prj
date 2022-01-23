-- 処理対象情報
\set to_table_name 'mst_target_prefectures'
\set column_list 'target_prefecture_code'
\set from_csv_path '../../csv/mst_target_prefectures.csv'

-- 読み込みコマンド組立・実行 (テキスト形式)
\set copycmd '\\COPY ':schema'.':to_table_name'(':column_list') FROM \'':from_csv_path'\''
:copycmd
