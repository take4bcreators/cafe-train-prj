# セットアップ時の情報

## yarn のインストール

```bash
npm install -g yarn
```

## yarn で gatsby-cli をインストール

- 詳細：https://www.gatsbyjs.com/docs/glossary/yarn/

```bash
yarn global add gatsby-cli
```


## Gatsby のデフォルトパッケージマネージャーの変更

`~/.config/gatsby/config.json` ファイルに、
次の行を追加する。

```json
{
  "cli": {
    "packageManager": "yarn"
  }
}
```

## プロジェクトの新規作成

```bash
# コマンド投下
gatsby new ssg https://github.com/gatsbyjs/gatsby-starter-hello-world
```


## react-helmet の導入

head 要素内の記述（meta、title、link、script）に必須。
（Helmet が使えるようになる）

```bash
yarn add gatsby-plugin-react-helmet react-helmet
```


## gatsby-source-filesystem の導入

ファイルを扱うためのプラグインの導入

```bash
yarn add gatsby-source-filesystem
```

gatsby-config.js の plugins に、
以下を追加する。

```js
    {
      resolve: `gatsby-source-filesystem`,
      options: {
        name: `data`,
        path: `${__dirname}/src/data/`,
      },
    },
```

- path に扱うファイルのディレクトリを指定する。
- 指定したパス（この場合は /src/data/ ）が存在しない場合は gatsby develop でエラーとなるので注意


## gatsby-transformer-csv の導入

CSVを読み込むためのプラグインの導入

```bash
yarn add gatsby-transformer-csv
```

インストール後、gatsby-config.js の plugins に、
以下を追加する。

```js
    `gatsby-transformer-csv`,
```


## fortawesome プラグインの導入

Fort Awesome のアイコンを使用する場合ため、
プラグインを導入する。

```bash
# react-fontawesome 関連のインストール
yarn add @fortawesome/fontawesome-svg-core
yarn add @fortawesome/react-fontawesome

# アイコンのインストール
# 使用するものに応じて、「solid」「regular」「brands」をインストールする
# すでに HTML で使用している場合は i 要素の class 名に情報がある
yarn add @fortawesome/free-brands-svg-icons
```



## Google Analytics 用プラグインの導入

下記コマンド投下で、 `gatsby-plugin-google-gtag` をインストールする。

```bash
# プラグインのインストール
yarn add gatsby-plugin-google-gtag
```

gatsby-config.js で 下記を参考に記述を追加する。
※ この際、plugins のすぐ下に設定しないと、
うまく作動しないことがあるので、gatsby-plugin-google-gtag は、一番目に設定する。

```js
module.exports = {
  plugins: [
    {
      resolve: `gatsby-plugin-google-gtag`,
      options: {
        trackingIds: [process.env.GATSBY_TRACKING_ID],
      },
    },
  ],
}
```

#### .env.development ファイルの作成
- ルート直下に `.env.development` と `.env.production` ファイルを作成する。
- ファイルの中に、`GATSBY_TRACKING_ID = G-xxxxxxx` を入力する（G-xxxxxxx は Google アナリティクス で取得した測定ID）。

#### gatsby-config.js への記述
- `gatsby-config.js` に以下の内容を記述する （ `module.exports =` の前に記述する）

```js
require("dotenv").config({
  path: `.env.${process.env.NODE_ENV}`,
})
```

※ 覚書も併せて参照




## 画像用プラグインの導入

### プラグインの導入

- gatsby-plugin-image
- gatsby-plugin-sharp
- gatsby-transformer-sharp

※ gatsby-image は非推薦になったらしいので未導入。さらに GraphQL 不要。

```bash
# プラグインのインストール
yarn add gatsby-plugin-image gatsby-plugin-sharp gatsby-transformer-sharp
```

#### gatsby-config.js への記述

下記のように追加する。

```js
module.exports = {
  plugins: [
    `gatsby-plugin-image`,
    `gatsby-plugin-sharp`,
    `gatsby-transformer-sharp`,
    {
      resolve: `gatsby-source-filesystem`,
      options: {
        name: `images`,
        path: `${__dirname}/src/images/`,
      },
    },
  ],
}
```

※ gatsby-source-filesystem は他に項目があっても name をわければ問題なし


### 参考リンク
- [Gatsby の新しい画像プラグイン](https://zenn.dev/kaito18/articles/1b7a813375ac69)
- [gatsby\-image が非推奨になり gatsby\-plugin\-image に推奨されていたので使い方を解説してみた \- Qiita](https://qiita.com/akifumii/items/ccb5c93b3d962f9e4f3f)
- [GatsbyJS の画像の扱いが至極簡単になった \| gatsby\-plugin\-image への進化 \| typememo\.jp](https://typememo.jp/tech/gatsby-image-evolution-gatsby-plugin-image/)
- [Gatsbyで2種類のマークダウンファイルの区別する方法Takumon Blog](https://takumon.com/how-to-distinct-2-kinds-of-markdown-in-gatsby)

