# Rundeck基本情報

## ユーザ定義
使用ユーザ：admin

## ジョブフォルダ構成
- (プロジェクトトップ)
  - batch
    - main
      - create_placesapi_request
      - execution_placesapi_request
      - create_site_page_contents
      - build_static_site_data
      - deploy_site
    - sub
    - unit
      - JB010101
      - JB010102
      - JB010103
  - tool
    - bulk_count_table_data


## Rundeckジョブ一覧

| JOB ID    | 処理名                                | 実行シェル                            |
| --------- | ------------------------------------- | ------------------------------------- |
| JB010101  | 対象都道府県テーブルトランケート      | truncate_mst_target_prefectures.sh    |


