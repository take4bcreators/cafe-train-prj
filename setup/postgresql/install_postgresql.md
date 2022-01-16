# PostgreSQLインストール手順

## 参考ページ
- [CentOS7にPostgreSQLをインストールする](https://qiita.com/jinnai73/items/af58bdac6fca869933c7)
- [PostgreSQL インストール、起動/停止、ユーザー作成、ロール作成](https://qiita.com/tomsyoya/items/d09652ad2977d70c5e43)
- [PostgreSQL にデータベースとテーブルをコマンドで作成する方法](https://www.webolve.com/basic/sql/create-db-and-table-postgresql/)
- [アクセス権の付与 Postgresqlメモ](http://www.cgis.biz/others/postgresql/18/)
- [ユーザーとパスワードの設定 ｜ PostgreSQLではじめるDB入門](http://db-study.com/archives/121)
- [CentOSへのPostgreSQLのインストールと初期設定 \- Qiita](https://qiita.com/9ryuuuuu/items/9bc80396cbd6b4b2fc95)

## 手順

### PostgreSQL のインストール

```bash
# root ユーザに切替
su -

# yum で PostgreSQL のインストール
yum install postgresql-server

# インストール後バージョン確認
psql --version
```


### インストール後の初回設定

```bash
# DBの初期化
postgresql-setup initdb

# サービス自動起動有効化
systemctl enable postgresql.service

# サービスの開始
systemctl start postgresql.service

# サービスの起動確認（activeになっていること）
systemctl status postgresql
```


### ロールの作成

```bash
# postgres ユーザに切替
su - postgres

# psql へログイン
psql
```

```sql
-- ロールの確認（作成前）
\du

-- ユーザ・ロール作成
CREATE USER cafe;

-- 作成後のロール確認
\du

-- ロールに権限付与
ALTER ROLE cafe CREATEROLE CREATEDB LOGIN;

-- ロール確認（作成後）
\du
```


### パスワードの設定

```sql
-- postgres ユーザのパスワードを設定
ALTER ROLE postgres WITH PASSWORD '※設定するパスワード';

-- cafe ユーザのパスワードを設定
ALTER ROLE cafe WITH PASSWORD '※設定するパスワード';
```


### データベースの作成

```sql
-- データベース一覧確認（作成前）
\l

-- データベース作成
CREATE DATABASE cafeindb001;

-- データベース一覧確認（作成後）
\l
```


### 権限グループの作成と権限付与

```sql
-- グループ作成
CREATE GROUP cafegrp;

-- グループにユーザを追加
ALTER GROUP cafegrp ADD USER cafe;

-- テーブルへの権限をグループに追加
GRANT ALL ON DATABASE cafeindb001 TO cafegrp;

-- DBを一旦抜ける
\q
```

```bash
# 作成したDBにログインする
psql -U cafe -d cafeindb001
```


# スキーマの作成

```sql
-- ユーザ名と同じ名前のスキーマを作成する
CREATE SCHEMA AUTHORIZATION cafe;

-- prd スキーマの作成
CREATE SCHEMA prd;

-- dev スキーマの作成
CREATE SCHEMA dev;

-- work スキーマの作成
CREATE SCHEMA work;

-- DBを抜ける
\q
```


### アクセスの許可1 (リッスン設定)

```bash
# root ユーザに切替
su -

# postgresql.conf を探す
find / -name 'postgresql.conf'

# postgresql.conf の情報確認
# [例] ls -l /var/lib/pgsql/data/postgresql.conf
ls -l ※postgresql.confのパス

# postgresql.conf の内容確認
# [例] cat /var/lib/pgsql/data/postgresql.conf
cat ※postgresql.confのパス

# postgresql.conf の内容変更
# [例] vi /var/lib/pgsql/data/postgresql.conf
vi ※postgresql.confのパス

###############################
# #listen_addresses = 'localhost'         # what IP address(es) to listen on;
#  ↓↓↓
# listen_addresses = '*'
#
# # port = 5432                        # (change requires restart)
#  ↓↓↓
# port = 5432                        # (change requires restart)
##############################

# postgresql.conf の内容確認 (変更後)
cat ※postgresql.confのパス

# サービス再起動
systemctl restart postgresql

# サービス確認（activeになっていること）
systemctl status postgresql
```

### アクセスの許可2 (接続許可設定)

```bash
# rootの状態で行う

# pg_hba.conf を探す
find / -name 'pg_hba.conf'

# pg_hba.conf の情報確認
# [例] ls -l /var/lib/pgsql/data/pg_hba.conf
ls -l ※pg_hba.confのパス

# pg_hba.conf の内容確認
# [例] cat /var/lib/pgsql/data/pg_hba.conf
cat ※pg_hba.confのパス

# pg_hba.conf の内容変更
# [例] vi /var/lib/pgsql/data/pg_hba.conf
vi ※pg_hba.confのパス

##############################
# # IPv4 local connections:
# host    all             all             127.0.0.1/32            ident
# ↓↓↓
# # IPv4 local connections:
# host    all             all             127.0.0.1/32            md5
#
# または...
# host    all             all             0.0.0.0/0               md5
##############################

# pg_hba.conf の内容確認 (変更後)
cat ※pg_hba.confのパス

# サービス再起動
systemctl restart postgresql

# サービス確認（activeになっていること）
systemctl status postgresql
```


### パスワードなしログインの設定

- ※先に OS で cafe ユーザの作成が必要

```bash
# 対象ユーザに切替
su - cafe

# ファイルの存在を確認（作成前）
ls -la .pgpass

# ホームディレクトリに「.pgpass」を作成する
touch .pgpass

# 「.pgpass」を編集
vi .pgpass

##############################
# ホスト名:ポート:データベース名:ユーザ:パスワード
# の形式で追加する
# （例）
# localhost:5432:cafeindb001:cafe:※パスワード
##############################

# パーミッション変更
chmod 600 .pgpass

# パーミッション変更確認
ls -la .pgpass

# PSQLログイン確認
psql -U cafe -d cafeindb001

# パスワードなしでログインできることを確認する
```

