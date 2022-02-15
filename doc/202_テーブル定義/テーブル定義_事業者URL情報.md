# テーブル定義

**【テーブル論理名】**  
事業者URL情報

**【テーブル物理名】**  
mst_company_url

**【テーブルレイアウト】**  

| No  |  カラム論理名   |  カラム物理名   | データ型  | PK  | UK  | NN  |         コメント          |
| --- | --------------- | --------------- | --------- | --- | --- | --- | ------------------------- |
| 01  | 事業者コード    | company_cd      | INTEGER   | o   |     | o   |                           |
| 02  | 事業者URL文字列 | company_url_str | TEXT      |     |     | o   |                           |
| 03  | 補足メモ        | note            | TEXT      |     |     |     | 処理には使用しない        |
| 04  | 更新日時        | updated_at      | TIMESTAMP |     |     | o   | DEFAULT CURRENT_TIMESTAMP |

