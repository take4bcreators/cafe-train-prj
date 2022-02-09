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
-- cafeユーザ作成
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


```sql
-- storageユーザ作成
-- ロールの確認（作成前）
\du

-- ユーザ・ロール作成
CREATE USER storage;

-- 作成後のロール確認
\du

-- ロールに権限付与
ALTER ROLE storage CREATEROLE CREATEDB LOGIN;

-- ロール確認（作成後）
\du
```


### パスワードの設定

```sql
-- postgres ユーザのパスワードを設定
ALTER ROLE postgres WITH PASSWORD '※設定するパスワード';

-- cafe ユーザのパスワードを設定
ALTER ROLE cafe WITH PASSWORD '※設定するパスワード';

-- storage ユーザのパスワードを設定
ALTER ROLE storage WITH PASSWORD '※設定するパスワード';
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

-- テーブルへの権限をグループに追加
GRANT ALL ON DATABASE cafeindb001 TO cafegrp;

-- グループにユーザを追加
ALTER GROUP cafegrp ADD USER cafe;
ALTER GROUP cafegrp ADD USER storage;

-- DBを一旦抜ける
\q
```


# スキーマの作成

```bash
# 作成した postgres ユーザで DB にログインする
psql -d cafeindb001 -U postgres
```

```sql
-- スキーマ一覧（作成前）
\dn

-- prd スキーマの作成
CREATE SCHEMA prd;

-- dev スキーマの作成
CREATE SCHEMA dev;

-- work スキーマの作成
CREATE SCHEMA work;

-- スキーマ一覧（作成後）
\dn

-- ※ もしスキーマの所有者が postgres 以外の場合に実施 ※
-- スキーマの所有者を変更
ALTER SCHEMA prd OWNER TO postgres;
ALTER SCHEMA dev OWNER TO postgres;
ALTER SCHEMA work OWNER TO postgres;

-- オブジェクトへのアクセス権限を付与する
GRANT USAGE ON SCHEMA prd TO cafegrp;
GRANT USAGE ON SCHEMA dev TO cafegrp;
GRANT USAGE ON SCHEMA work TO cafegrp;

-- CREATE TABLE などのオブジェクト作成権限を与える
GRANT CREATE ON SCHEMA prd TO cafegrp;
GRANT CREATE ON SCHEMA dev TO cafegrp;
GRANT CREATE ON SCHEMA work TO cafegrp;

-- DBを一旦抜ける
\q
```


# テーブル権限の付与

```bash
# 作成した cafe ユーザで DB にログインする
psql -U cafe -d cafeindb001
```

```sql
-- 権限の確認（変更前）
\z prd.*
\z dev.*
\z work.*

-- 現在存在するテーブルに権限を付与する
-- ここでは TRUNCATE 権限を与えないように、ALL ではなく個別に権限を指定する
GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER ON ALL TABLES IN SCHEMA prd To cafegrp;
GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER ON ALL TABLES IN SCHEMA dev To cafegrp;
GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER ON ALL TABLES IN SCHEMA work To cafegrp;

-- 今後作成される テーブル へのデフォルト権限を設定する （ユーザごとに行う）
-- ここでは TRUNCATE 権限を与えないように、ALL ではなく個別に権限を指定する
ALTER DEFAULT PRIVILEGES GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER ON TABLES TO cafegrp;

-- 権限の確認（変更後）
\z prd.*
\z dev.*
\z work.*

-- 一旦 PSQL ログアウト
\q
```


```bash
# 作成した storage ユーザで DB にログインする
psql -U storage -d cafeindb001
```

```sql
-- 権限の確認（変更前）
\z prd.*
\z dev.*
\z work.*

-- 今後作成される テーブル へのデフォルト権限を設定する （ユーザごとに行う）
-- ここでは TRUNCATE 権限を与えないように、ALL ではなく個別に権限を指定する
ALTER DEFAULT PRIVILEGES GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER ON TABLES TO cafegrp;

-- 権限の確認（変更後）
\z prd.*
\z dev.*
\z work.*

-- PSQL ログアウト
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
# localhost:5432:cafeindb001:storage:※パスワード
##############################

# パーミッション変更
chmod 600 .pgpass

# パーミッション変更確認
ls -la .pgpass

# PSQLログイン確認
psql -U cafe -d cafeindb001

# パスワードなしでログインできることを確認する
```

