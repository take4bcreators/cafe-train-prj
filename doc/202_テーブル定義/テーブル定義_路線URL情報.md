# テーブル定義

**【テーブル論理名】**  
路線URL情報

**【テーブル物理名】**  
mst_line_url

**【テーブルレイアウト】**  

| No  | カラム論理名  | カラム物理名 | データ型  | PK  | UK  | NN  |         コメント          |
| --- | ------------- | ------------ | --------- | --- | --- | --- | ------------------------- |
| 01  | 路線コード    | line_cd      | INTEGER   | o   |     | o   |                           |
| 02  | 路線URL文字列 | line_url_str | TEXT      |     |     | o   |                           |
| 03  | 補足メモ      | note         | TEXT      |     |     |     | 処理には使用しない        |
| 04  | 更新日時      | updated_at   | TIMESTAMP |     |     | o   | DEFAULT CURRENT_TIMESTAMP |

