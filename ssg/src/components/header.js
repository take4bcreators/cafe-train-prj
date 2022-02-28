import React from "react"

const header = () => (
    <header className="site-header">
        <div className="header-logo">
            <a href="/">
                <img src="/images/cafeinprj_logo.svg" alt="Cafein" width={120} />
            </a>
        </div>
        <div className="menu-container">
            <div className="menu-btn">
            <span />
            <span />
            <span />
            </div>
            <div className="menu-mask">
            </div>
            <div className="menu-body">
            <div className="menu-body-logo">
                <img src="/images/cafeinprj_logo.svg" alt="Cafein" width={120} />
            </div>
            <nav className="menu">
                <ul>
                <li className="menu-totop">
                    <a href="/">
                        トップ
                    </a>
                </li>
                <li className="menu-toabout">
                    このサイトについて
                </li>
                </ul>
            </nav>
            </div>
        </div>
    </header>
)

export default header
