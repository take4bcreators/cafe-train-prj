/**
 * Configure your Gatsby site with this file.
 *
 * See: https://www.gatsbyjs.com/docs/gatsby-config/
 */

// .env.development を読み込むための記述
require("dotenv").config({
  path: `.env.${process.env.NODE_ENV}`,
})

module.exports = {
  /* Your site config here */
  siteMetadata: {
    title: `Cafein`,
    description: `駅周辺のカフェ情報を一覧化したマップを公開するサイト`,
    lang: `ja`,
    siteUrl: `https://take4b-cafein.netlify.app`,
    locale: `ja_JP`,
    fbappid: `XXXXXXXXX`,
  },
  plugins: [
    {
      resolve: `gatsby-plugin-google-gtag`,
      options: {
        trackingIds: [process.env.GATSBY_TRACKING_ID],
      },
    },
    {
      resolve: `gatsby-source-filesystem`,
      options: {
        name: `data`,
        path: `${__dirname}/src/data/`,
      },
    },
    `gatsby-transformer-csv`,
  ],
}
