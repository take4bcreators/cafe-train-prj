import React from "react"
import Header from "../components/header"
import Footer from "../components/footer"

// CSS
import "./layout.css"
import "./ress.css"


const layout = ({ children }) => (
    <div>
        <Header />
            {children}
        <Footer />
    </div>
)

export default layout
