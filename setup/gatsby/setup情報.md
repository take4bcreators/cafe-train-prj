
# セットアップ時の情報

## プロジェクトの新規作成

```bash
# コマンド投下
gatsby new ssg https://github.com/gatsbyjs/gatsby-starter-hello-world
```


## yarn のインストール

```bash
npm install -g yarn
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
npm install gatsby-source-filesystem
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
```

path に扱うファイルのディレクトリを指定する。



## gatsby-transformer-csv の導入

CSVを読み込むためのプラグインの導入

```bash
npm install gatsby-transformer-csv
```

インストール後、gatsby-config.js の plugins に、
以下を追加する。

```js
    `gatsby-transformer-csv`,
```



