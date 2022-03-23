import React from "react"
import Layout from "../components/layout"
import Seo from "../components/seo"
import { StaticImage } from "gatsby-plugin-image";

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
                <StaticImage
                    src="../images/img404.png"
                    width={600}
                    alt="img404"
                    placeholder="blurred" // ボヤッと読み込ませるオプション
                />
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
