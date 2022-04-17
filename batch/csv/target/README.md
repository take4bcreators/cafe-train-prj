
# ターゲットCSVについて

以下の CSV ファイル をこのフォルダ配下に用意する。



## fetch_target_chain.csv
PlacesAPI で データを取得する対象のカフェチェーンを指定するCSV

### 指定する項目
target_chain_id,note

    target_chain_id：チェーン番号（独自定義）を指定する
    note：メモ（処理には使用しない）



## fetch_target_line.csv
PlacesAPI で データを取得する対象の路線を指定するCSV

### 指定する項目
type_cd,target_cd,note

    type_cd：
        1 … 事業者コードで指定
        2 … 路線コード（オリジナル）で指定
        3 … 駅コードで指定
        4 … 駅グループコードで指定
    target_cd：「type_cd」で指定したものに応じて、PlacesAPI 取得対象のコードを指定する
                ※ 路線コードの指定の場合、独自定義したものではなく、駅データJPのデータそのままの路線コードを指定する
    note：メモ（処理には使用しない）



## page_create_target_line.csv
ページコンテンツCSVに出力する対象の路線を指定するCSV

### 指定する項目
page_create_line_cd,note

    page_create_line_cd：路線コードを指定する。独自定義したものがある場合は、独自定義した路線コードを指定する。
    note：メモ（処理には使用しない）

