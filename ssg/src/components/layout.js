import React from "react"
import Header from "../components/header"
import Footer from "../components/footer"

// CSS
import "./ress.css"
import "./layout.css"

// Font Awesome の ロード時に拡大するのを防ぐための指定
import "@fortawesome/fontawesome-svg-core/styles.css"
import { config } from "@fortawesome/fontawesome-svg-core"
config.autoAddCss = false

const layout = ({ children }) => (
    <div>
        <Header />
            {children}
        <Footer />
    </div>
)

export default layout
