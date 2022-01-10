# jq コマンド インストール

## 概要
JSONデータの、整形やCSV変換には jq コマンドを使用する。
そのインストール手順。

## 参考サイト
- [jq コマンドを CentOS 7 にインストールする \(yum あり・なし\) \- サーバー構築と設定 ～初心者にも分かりやすく解説～](https://xn--o9j8h1c9hb5756dt0ua226amc1a.com/?p=2379)

## 手順

```bash
# yum を使ってインストールする場合、事前にリポジトリの追加が必要。
# CentOS 7 の標準リポジトリには jq が含まれていません。

# EPEL リポジトリを yum コマンドでインストールする。
# GPG キーのインポート確認が表示された場合は y で先に進める。
yum install epel-release

# パッケージ情報を確認
yum info jq --enablerepo=epel

# jq コマンドをインストールする。
# GPG キーのインポート確認が表示された場合は y を入力
yum install jq --enablerepo=epel

# インストールされたバージョンを確認する
jq --version
```

