import React from "react"

import { FontAwesomeIcon } from "@fortawesome/react-fontawesome"
import {
    faTwitter,
    faFacebookSquare,
    faInstagram
} from "@fortawesome/free-brands-svg-icons"


const footer =  () => (
    <footer className="site-footer">
        <ul className="sns">
            <li>
                <FontAwesomeIcon icon={faTwitter} />
            </li>
            <li>
                <FontAwesomeIcon icon={faFacebookSquare} />
            </li>
            <li>
                <FontAwesomeIcon icon={faInstagram} />
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
