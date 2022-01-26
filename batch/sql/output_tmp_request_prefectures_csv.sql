-- 処理対象指定
\set from_table_name    'mst_target_prefectures'
\set column_list        'target_prefecture_code'
\set to_csv_path        :project_root'/tmp/tmp_request_prefectures.csv'

-- 出力コマンド組立・実行 (テキスト形式)
\set outputcmd '\\COPY (SELECT ':column_list' FROM ':schema'.':from_table_name') TO \'':to_csv_path'\''
:outputcmd
