# Rundeck基本情報

## ユーザ定義
使用ユーザ：admin

## ジョブフォルダ構成
- cafe-train-prj
  - batch
    - main
      - NT01
      - NT02
      - NT03
      - NT04
      - NT05
    - sub
    - net
      - NT0101
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
| JB010102  | 対象都道府県CSV読込                   | load_target_prefectures.sh            |


