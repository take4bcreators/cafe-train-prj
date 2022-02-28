import React from "react"
import Layout from "../components/layout"
import Seo from "../components/seo"

const page404 = () => (
    <Layout>
        <Seo
            pagetitle="ページが見つかりません"
            pagedesc=""
            pagescript=""
            pagecolor=""
        />
        <h1 style={{ padding: "20vh 0", textAlign: "center" }}>
            お探しのページが見つかりませんでした
        </h1>
    </Layout>
)

export default page404
