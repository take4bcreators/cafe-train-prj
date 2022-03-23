import React from "react"
import Layout from "../components/layout"
import Seo from "../components/seo"

const page404 = ({ location }) => (
    <Layout>
        <Seo
            pagetitle="ページが見つかりません"
            pagedesc=""
            pagepath={location.pathname}
            pagescript="page404-script.js"
            pagecolor=""
        />
        <main className="page-404">
            <div className="page404img">
                <img src="images/img404.png" alt="" />
            </div>
            <section>
                <h1>
                お探しのページが見つかりませんでした
                </h1>
            </section>
        </main>
    </Layout>
)

export default page404
