import React from "react"
import { Helmet } from "react-helmet"
import { withPrefix } from "gatsby"
import { useStaticQuery, graphql } from "gatsby"


const Seohelmet = (props) => {
    // graphql で取得するデータ
    const data = useStaticQuery(graphql`
        query {
            site {
                siteMetadata {
                  description
                  lang
                  title
                  siteUrl
                  locale
                  fbappid
                }
            }
        }
    `)
    
    // 引数の取得と初期値
    const title = props.pagetitle ? ` ${props.pagetitle} | ${data.site.siteMetadata.title}` : data.site.siteMetadata.title
    const description = props.pagedesc || data.site.siteMetadata.description
    const scriptname = props.pagescript || "dummy.js"
    const pagecolor = props.pagecolor || "#000"
    
    // script情報組み立て
    const scriptdir = "script/"
    const scriptpath = scriptdir + scriptname
    
    // トップページのみパララックスのJSもセット
    const parallaxjsname = (scriptname === "index-script.js") ? "luxy-all.js" : "dummy.js"
    const parallaxjspath = scriptdir + parallaxjsname
    
    // CSS 情報組み立て
    const rootcss = ":root {--line-color: " + pagecolor + ";}"
    
    // ページパス情報組み立て
    const url = props.pagepath ? `${data.site.siteMetadata.siteUrl}${props.pagepath}` : data.site.siteMetadata.siteUrl
    
    // OGP用画像情報組み立て
    const imgurl = `${data.site.siteMetadata.siteUrl}/images/thumb.png`
    const imgw = 1200
    const imgh = 630
    
    // JSX
    return (
        <Helmet>
            <html lang={data.site.siteMetadata.lang} />
            <title>{title}</title>
            <meta name="description" content={description} />
            
            {/* canonical */}
            <link rel="canonical" href={url} />
            
            {/* iOS ICON */}
            <link rel="apple-touch-icon" href="images/apple-touch-icon.png" />
            
            {/* OGP */}
            <meta property="og:site_name" content={data.site.siteMetadata.title} />
            <meta property="og:title" content={title} />
            <meta property="og:description" content={description} />
            <meta property="og:url" content={url} />
            <meta property="og:type" content="website" />
            <meta property="og:locale" content={data.site.siteMetadata.locale} />
            <meta property="og:image" content={imgurl} />
            <meta property="og:image:width" content={imgw} />
            <meta property="og:image:height" content={imgh} />
            <meta name="twitter:card" content="symmary_large_image" />
            
            {/* Script JS */}
            <script src={withPrefix(scriptpath)} type="text/javascript" defer />
            <script src={withPrefix(parallaxjspath)} type="text/javascript" defer />
            
            {/* Google Fonts */}
            <link rel="preconnect" href="https://fonts.googleapis.com" />
            <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin />
            <link href="https://fonts.googleapis.com/css2?family=Arima+Madurai:wght@100;200;300;400;500;700;800;900&family=Fredericka+the+Great&family=Julius+Sans+One&family=Kaisei+Decol:wght@400;500;700&family=Kaisei+Opti:wght@400;500;700&family=M+PLUS+Rounded+1c:wght@100;300;400;500;700;800;900&family=Roboto+Condensed:wght@300;400;700&display=swap" rel="stylesheet" />
            
            {/* ページ別スタイル */}
            <style>{rootcss}</style>
        </Helmet>
    )
}

export default Seohelmet
