import React from "react"
import Layout from "../components/layout"
import Seo from "../components/seo"

export default function About({ location }) {
  return (
  <Layout>
    <Seo
      pagetitle="このサイトについて"
      pagedesc="駅周辺のカフェ情報を一覧化したマップを公開するサイト"
      pagepath={location.pathname}
      pagescript="about-script.js"
      pagecolor="#000000"
    />
    <div className="splash-container about">
    </div>
    <main className="page-about">
      <article>
        <h1>このサイトについて</h1>
        <p>
          2021年09月、Twitter で一時期話題になった、
          <a href="https://twitter.com/ShinagawaJP?s=20&t=hqWKelmQ_ERuburI5UJiaA">@ShinagawaJP</a> 
          さんの投稿による、「カフェ路線図」。
        </p>
        <p>
          この路線図に感銘を受けて、情報をまとめたWEBサイトを制作いたしました！
        </p>
        <section>
          <h2>駅カフェ路線図のデータについて</h2>
          <p>
            駅カフェ路線図で使用しているデータは、API などを使用して自動で取得しています。
          </p>
          <p>
            その為、情報に一部誤りがある場合があります。
          </p>
          <p>
            情報の利用については<mark>参考程度</mark>でお願いいたします。
          </p>
          <p>
            また、掲載している情報などに関して、<strong>各店舗への問い合わせ等は行わないでください</strong>。
          </p>
        </section>
        <section>
          <h2>Thank you！</h2>
          <ul className="thanks">
            <li>
              dexit
            </li>
            <li>
              chanKS（イラスト協力 他）
            </li>
          </ul>
        </section>
      </article>
    </main>
  </Layout>
  )
}
