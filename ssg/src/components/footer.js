import React from "react"

import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import {
    faTwitter,
    faInstagram
} from "@fortawesome/free-brands-svg-icons"


const footer =  () => (
    <footer className="site-footer">
        <ul className="sns">
            <li>
                <a href="https://twitter.com/take4b_info">
                    <FontAwesomeIcon icon={faTwitter} />
                </a>
            </li>
            <li>
                <a href="https://www.instagram.com/take4b_cafein/">
                    <FontAwesomeIcon icon={faInstagram} />
                </a>
            </li>
        </ul>
        <div className="pagelink">
            <p>
            <a href="/">
                トップページ
            </a>
            </p>
            <p>
            <a href="/policy/">
                プライバシーポリシー
            </a>
            </p>
            <p>
            <a href="/about/">
                このサイトについて
            </a>
            </p>
        </div>
        <p className="copyright">
            © Take4B Creators. 2022.
        </p>
    </footer>
)

export default footer
