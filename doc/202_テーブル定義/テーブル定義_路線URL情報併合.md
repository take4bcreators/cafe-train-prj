# テーブル定義

**【テーブル論理名】**  
路線URL情報併合

**【テーブル物理名】**  
tmp_merge_line_url

**【テーブルレイアウト】**  

| No  |     カラム論理名     | カラム物理名  | データ型 | PK  | UK  | NN  |        コメント        |
| --- | -------------------- | ------------- | -------- | --- | --- | --- | ---------------------- |
| 01  | 路線コード           | line_cd       | INTEGER  | o   |     | o   |                        |
| 02  | 結合路線コード       | join_line_cd  | INTEGER  |     |     |     |                        |
| 03  | 事業者コード         | company_cd    | INTEGER  |     |     | o   |                        |
| 04  | 路線名称(一般)       | line_name     | TEXT     |     |     | o   |                        |
| 05  | 路線名称(一般・カナ) | line_name_k   | TEXT     |     |     |     |                        |
| 06  | 路線名称(正式名称)   | line_name_h   | TEXT     |     |     |     |                        |
| 07  | 定義路線別名         | def_line_name | TEXT     |     |     |     |                        |
| 08  | 路線シンボル         | line_symbol   | TEXT     |     |     |     |                        |
| 09  | ラインカラーコード   | line_color_cd | TEXT     |     |     |     |                        |
| 10  | 路線カラー（コード） | line_color_c  | TEXT     |     |     |     | *1                     |
| 11  | 路線カラー(名称）    | line_color_t  | TEXT     |     |     |     | *1                     |
| 12  | 路線区分             | line_type     | INTEGER  |     |     |     | *1                     |
| 13  | 路線URL文字列        | line_url_str  | TEXT     |     |     |     | 路線URL情報TBLから取得 |
| 14  | 路線表示時の中央経度 | lon           | TEXT     |     |     |     |                        |
| 15  | 路線表示時の中央緯度 | lat           | TEXT     |     |     |     |                        |
| 16  | 路線表示時のGM倍率   | zoom          | INTEGER  |     |     |     | *2                     |
| 17  | 状態                 | e_status      | INTEGER  |     |     |     | *3                     |
| 18  | 並び順               | e_sort        | INTEGER  |     |     |     | *4                     |


【*1】
有料データの為、一部を除いてデータ無し

【*2】
GM：GoogleMap

【*3】
0:運用中
1:運用前
2:廃止

【*4】
「並び順」＋「路線コード」で昇順

