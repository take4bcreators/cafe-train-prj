
# Git のインストール

## 参考リンク

- [CentOS7 に最新版の Git をインストールする方法 \- Qiita](https://qiita.com/tomy0610/items/66e292f80aa1adc1161d)


# 手順

## 依存関係のあるライブラリをインストール

依存関係があるライブラリ（curl、zlib、openssl、expat、libiconv あたり）を導入する。
真っさらなサーバだと、コンパイルするのに必要な gcc がそもそも入ってないパターンもあるのでこれも入れる。

```bash
# rootへ切替
su -

# 依存関係のあるライブラリをインストール
yum -y install gcc curl-devel expat-devel gettext-devel openssl-devel zlib-devel perl-ExtUtils-MakeMaker autoconf
```


## ダウンロード対象を確認

https://mirrors.edge.kernel.org/pub/software/scm/git/ で Git の落としたいバージョンを確認し、アドレスのリンクをコピーする。
（今回は git-2.9.5.tar.gz のリンクをコピーした。）


## Git パッケージをダウンロード

```bash
# インストールに適切な場所に移動
cd /usr/local/src/

# サイトから Git の圧縮ファイルをダウンロード
wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.9.5.tar.gz

# ファイルを解凍
tar xzvf git-2.9.5.tar.gz
```

※ もし wget が入ってなかったら `sudo yum install wget` でインストールできる

ダウンロードが完了したら、tar.gz ファイルは不要なので消してもいい

```bash
# 圧縮ファイルの確認 (削除前)
ls -l git-2.9.5.tar.gz

# 圧縮ファイルを削除
rm -rf git-2.9.5.tar.gz

# 圧縮ファイルの確認 (削除後)
ls -l git-2.9.5.tar.gz
```

## Git をインストール

```bash
# 解凍した Git ディレクトリに移動
cd git-2.9.5/

# make コマンドでインストール1
sudo make prefix=/usr/local all

# make コマンドでインストール2
sudo make prefix=/usr/local install
```

## インストールされたか確認

```bash
# バージョン確認コマンド
git --version

# → git version 2.9.5
```

以上。

