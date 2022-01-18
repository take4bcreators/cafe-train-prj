# PlaceAPIリクエスト実行

## 1. 概要
作成した、駅の 緯度経度 情報を利用して、
Google Cloud Platform の Places API に実際にリクエストを送り、
レスポンスデータを DB に格納する。

## 2. 個別処理概要
- カフェ情報読み込み (一時CSV → Places API → 一時CSV → カフェ情報TBL)
