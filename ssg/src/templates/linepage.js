import React from "react"
import Layout from "../components/layout"
import Seo from "../components/seo"
import { graphql } from "gatsby"

// graphql による情報取得
export const query = graphql`
  query LinePageTemplateQuery($lineUrl: String!) {
    allPageContentsCsv(filter: {ln_url: {eq: $lineUrl}}) {
      nodes {
        ln_url
        ln_cd
        ln_symbol
        ln_name
        ln_color
        cp_url
        cp_cd
        cp_name
        st_num
        st_cd
        st_name
        cf01
        cf02
        cf03
        cf04
        cf05
        cf06
        cf07
        cf08
        cf09
        cf10
      }
    }
  }
`

// JSXページデータ
const Linepage = ({ data, location }) => {
  const { nodes } = data.allPageContentsCsv;
  return (
    <Layout>
      <Seo
        pagetitle={nodes[0].ln_name}
        pagedesc="駅周辺のカフェ情報を一覧化したマップを公開するサイト"
        pagepath={location.pathname}
        pagescript="page-script.js"
        pagecolor={nodes[0].ln_color}
      />
      <div className="splash-container page-cover">
      </div>
      <div className="splash-container page">
        <div className="splash-logo">
          <span className="smooth-text-wrap">
            <span className="smooth-text">
              {nodes[0].ln_name}
            </span>
          </span>
        </div>
      </div>
      <main>
        <header className="main-header">
          <h1 className="lnname">{nodes[0].ln_name}</h1>
        </header>
        <div className="main-container">
          <div className="cafename-container">
            <div className="cfname-container">
              <div className="cfname cf-01">スタバ</div>
              <div className="cfname cf-02">タリーズ</div>
              <div className="cfname cf-03">ドトール</div>
              <div className="cfname cf-04">サンマルク</div>
              <div className="cfname cf-05">ベローチェ</div>
              <div className="cfname cf-06">コメダ珈琲</div>
            </div>
          </div>
          <div className="trainline-container">
            <div className="trline-container">
              <div className="trline cf-01" />
              <div className="trline cf-02" />
              <div className="trline cf-03" />
              <div className="trline cf-04" />
              <div className="trline cf-05" />
              <div className="trline cf-06" />
            </div>
          </div>
          <div className="allstations-container">
            {
              nodes.map((node, index) => {
                return (
                  <div className="station-container" key={index}>
                    <div className="stinfo-container">
                      <p className="stno">{node.st_num}</p>
                      <h1 className="stname">{node.st_name}</h1>
                    </div>
                    <div className="cfflag-container">
                      {node.cf01 !== '0' ? (<div className="cfflag cf-01"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>) : (<div className="cfflag cf-01 vshide" />)}
                      {node.cf02 !== '0' ? (<div className="cfflag cf-02"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>) : (<div className="cfflag cf-02 vshide" />)}
                      {node.cf03 !== '0' ? (<div className="cfflag cf-03"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>) : (<div className="cfflag cf-03 vshide" />)}
                      {node.cf04 !== '0' ? (<div className="cfflag cf-04"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>) : (<div className="cfflag cf-04 vshide" />)}
                      {node.cf05 !== '0' ? (<div className="cfflag cf-05"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>) : (<div className="cfflag cf-05 vshide" />)}
                      {node.cf06 !== '0' ? (<div className="cfflag cf-06"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>) : (<div className="cfflag cf-06 vshide" />)}
                    </div>
                  </div>
                )
              })
            }
          </div>
          <div className="notice-container">
            <p>※ 各駅から 約 400m 以内の情報を掲載しています。</p>
          </div>
          <div className="text-container">
            {/* <p>大宮〜赤羽はドトールコーヒーが多いですね。</p> */}
            {/* <p>By 編集担当Y</p> */}
          </div>
        </div>
      </main>
    </Layout>
  )
}

export default Linepage
