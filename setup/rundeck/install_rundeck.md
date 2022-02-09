# Rundeck構築

## 参考サイト
- [ジョブスケジューラ「Rundeck」を試してみる \| DevelopersIO](https://dev.classmethod.jp/articles/try-rundeck-job/)
- [CentOS7\.2にRundeckをインストール \- Coniglioの忘備録](https://coniglio.hateblo.jp/entry/2018/02/22/154438)
- [【OSSジョブ管理】RundeckをCentOS7へインストールする – IT Learning](https://obenkyolab.com/?p=54)
- [Rundeck 3 でユーザのパスワードを暗号化（ハッシュ化）する方法 \- 約束の地](https://obel.hatenablog.jp/entry/20190211/1549856984)

## 手順

### コマンド実行

```bash
# Rundeck セットアップシェル実行
curl https://raw.githubusercontent.com/rundeck/packaging/main/scripts/rpm-setup.sh 2> /dev/null | bash -s rundeck 

# Rundeck・Javaインストール
yum install java-1.8.0 rundeck

# Rundeck サービス起動
systemctl start rundeckd

# Rundeck サービス起動
systemctl status rundeckd

# Rundeck 自動起動設定
systemctl enable rundeckd

# Rundeck設定1
# rundeck-config.properties の存在確認
ls -l /etc/rundeck/rundeck-config.properties

# rundeck-config.properties の編集
vi /etc/rundeck/rundeck-config.properties

# grails.serverURL=http://localhost/rundeck
# ↓ このサーバのアドレスに変える
# grails.serverURL=http://<ホスト名orIPアドレス>/rundeck
# ※ 20220207 追記 ※
# local で動かしているときは localhost で問題なさそう
# grails.serverURL=http://localhost:4440


# Rundeck設定2
# framework.properties の存在確認
ls -l /etc/rundeck/framework.properties

# framework.properties の編集
vi /etc/rundeck/framework.properties

# 以下の localhost の部分をこのサーバのアドレスに変える
# ※ 20220207 追記 ※
# local で動かしているときは localhost で問題なさそう
# framework.server.name = localhost
# framework.server.hostname = localhost
# framework.server.port = 4440
# framework.server.url = http://localhost:4440

# 念の為 Rundeck サービス再起動
systemctl restart rundeckd

# サービス確認（activeになっていること）
systemctl status rundeckd

# ポートの開放
firewall-cmd --add-port=4440/tcp --permanent
firewall-cmd --add-service=http --permanent
firewall-cmd --reload
```

### ログイン確認
- ブラウザから 「http://192.168.56.101:4440」 にアクセスする
- Userame「admin」、Password「admin」でログインする

### パスワード変更
- ログイン後、右上の歯車マークから「Password Utility」をクリックする。
- 「Encoder」を「Jetty」にして、「Username」を変更するユーザに、「Value To Encrypt」に設定するパスワードを入力する
- 「Output」に表示された「md5」の項目のハッシュ値を「MD5:」を含めてコピーする
- 以下のコマンドを投入していく

```bash
# rundeckユーザにスイッチ
su - rundeck

# 「realm.properties」ファイルの存在を確認
# （存在しない場合は、realm.propertiesを find などで探す）
ls -l /etc/rundeck/realm.properties

# 値を変更する
vi /etc/rundeck/realm.properties

#####################
# （例）yamadaユーザの場合
# yamada: MD5:c32ec965db3295bad074d2afa907b1c3,foo,bar
#####################

# rootにスイッチ
su -

# rundeck サービス再起動
systemctl restart rundeckd

# サービス状態確認
systemctl status rundeckd
```


### パスワードなしログインの設定

- ※先に PostgreSQL のインストールが必要

```bash
# 対象ユーザに切替
su - rundeck

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

