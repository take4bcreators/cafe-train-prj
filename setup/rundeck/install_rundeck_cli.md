# Rundeck CLI インストール
## 概要
Rundeck でジョブのエクスポートなどを行うには、
GUIの操作でも可能だが、1つ1つ行わなければならず、結構手間がかかる。

Rundeck CLI の rd コマンドを使用すれば、コマンドで操作できるので、
一括操作が楽になるかもしれない。

## 参考サイト
- [Rundeck CLI \- Install \| Rundeck Docs](https://docs.rundeck.com/docs/rd-cli/install.html#yum-usage)
- [OSS ジョブスケジューラ\(Rundeck\)を自宅サーバに入れてみた Part3 \- Qiita](https://qiita.com/legitwhiz/items/7c2cabe32083106c80a1)


## 手順

### コマンド実行

```bash
# Rundeck セットアップシェル実行
# Rundeckインストール時のものと一緒であるため、1回行なっていれば不要
curl https://raw.githubusercontent.com/rundeck/packaging/main/scripts/rpm-setup.sh 2> /dev/null | bash -s rundeck

# CLIインストール
yum install rundeck-cli

# rd コマンドがあることを確認
type rd
```



### 環境変数設定

```bash
# URL情報
export RD_URL=http://localhost:4440
```


### 実行

```bash
# ジョブ一覧を表示（-p で プロジェクト指定）
rd jobs list -p cafe-train-prj
```


### ジョブ定義のバックアップとリストア

```bash
# ジョブ定義のバックアップ
rd jobs list -f ファイル名.xml -p プロジェクト名

### 例
### rd jobs list -f jobs.xml -p cafe-train-prj

# ジョブ定義のバックアップ
rd jobs load -f ファイル名.xml -p プロジェクト名
```


