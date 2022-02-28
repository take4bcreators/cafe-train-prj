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
                }
            }
        }
    `)
    
    // 引数の取得と初期値
    const title = props.pagetitle ? ` ${props.pagetitle} | ${data.site.siteMetadata.title}` : data.site.siteMetadata.title
    const description = props.pagedesc || data.site.siteMetadata.description
    const scriptname = props.pagescript || "dummy.js"
    const pagecolor = props.pagecolor || "#000"
    
    // 情報組み立て
    const scriptdir = "script/"
    const scriptpath = scriptdir + scriptname
    const rootcss = ":root {--line-color: " + pagecolor + ";}"
    
    // JSX
    return (
        <Helmet>
            <html lang={data.site.siteMetadata.lang} />
            <title>{title}</title>
            <meta name="description" content={description} />
            
            {/* Script JS */}
            <script src={withPrefix(scriptpath)} type="text/javascript" defer />
            
            {/* Google Fonts */}
            <link rel="preconnect" href="https://fonts.googleapis.com" />
            <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin />
            <link href="https://fonts.googleapis.com/css2?family=Kaisei+Decol:wght@400;500;700&family=Kaisei+Opti:wght@400;500;700&family=Roboto+Condensed:wght@300;400;700&display=swap" rel="stylesheet" />
            
            {/* ページ別スタイル */}
            <style>{rootcss}</style>
        </Helmet>
    )
}

export default Seohelmet
