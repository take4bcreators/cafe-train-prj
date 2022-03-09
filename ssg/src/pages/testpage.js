import React from "react"
import Layout from "../components/layout"
import Seo from "../components/seo"

export default function Home() {
  return (
  <Layout>
    <Seo
      pagetitle="JR京浜東北線"
      pagedesc="駅周辺のカフェ情報を一覧化したマップを公開するサイト"
      pagescript="page-script.js"
      pagecolor="#74b7c6"
    />
    <main>
      <header className="main-header">
        <h1 className="lnname">JR京浜東北線</h1>
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
          <div className="station-container">
            <div className="stinfo-container">
              <p className="stno">JK47</p>
              <h1 className="stname">大宮</h1>
            </div>
            <div className="cfflag-container">
              <div className="cfflag cf-01"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>
              <div className="cfflag cf-02"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>
              <div className="cfflag cf-03"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>
              <div className="cfflag cf-04 vshide" />
              <div className="cfflag cf-05"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>
              <div className="cfflag cf-06"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>
            </div>
          </div>
          <div className="station-container">
            <div className="stinfo-container">
              <p className="stno">JK46</p>
              <h1 className="stname">さいたま新都心</h1>
            </div>
            <div className="cfflag-container">
              <div className="cfflag cf-01"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>
              <div className="cfflag cf-02 vshide" />
              <div className="cfflag cf-03"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>
              <div className="cfflag cf-04 vshide" />
              <div className="cfflag cf-05 vshide" />
              <div className="cfflag cf-06 vshide" />
            </div>
          </div>
          <div className="station-container">
            <div className="stinfo-container">
              <p className="stno">JK45</p>
              <h1 className="stname">与野</h1>
            </div>
            <div className="cfflag-container">
              <div className="cfflag cf-01 vshide" />
              <div className="cfflag cf-02 vshide" />
              <div className="cfflag cf-03"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>
              <div className="cfflag cf-04 vshide" />
              <div className="cfflag cf-05 vshide" />
              <div className="cfflag cf-06 vshide" />
            </div>
          </div>
          <div className="station-container">
            <div className="stinfo-container">
              <p className="stno">JK44</p>
              <h1 className="stname">北浦和</h1>
            </div>
            <div className="cfflag-container">
              <div className="cfflag cf-01 vshide" />
              <div className="cfflag cf-02 vshide" />
              <div className="cfflag cf-03"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>
              <div className="cfflag cf-04 vshide" />
              <div className="cfflag cf-05 vshide" />
              <div className="cfflag cf-06"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>
            </div>
          </div>
          <div className="station-container">
            <div className="stinfo-container">
              <p className="stno">JK43</p>
              <h1 className="stname">浦和</h1>
            </div>
            <div className="cfflag-container">
              <div className="cfflag cf-01"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>
              <div className="cfflag cf-02"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>
              <div className="cfflag cf-03"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>
              <div className="cfflag cf-04 vshide" />
              <div className="cfflag cf-05"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>
              <div className="cfflag cf-06 vshide" />
            </div>
          </div>
          <div className="station-container">
            <div className="stinfo-container">
              <p className="stno">JK42</p>
              <h1 className="stname">南浦和</h1>
            </div>
            <div className="cfflag-container">
              <div className="cfflag cf-01 vshide" />
              <div className="cfflag cf-02 vshide" />
              <div className="cfflag cf-03"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>
              <div className="cfflag cf-04 vshide" />
              <div className="cfflag cf-05 vshide" />
              <div className="cfflag cf-06 vshide" />
            </div>
          </div>
          <div className="station-container">
            <div className="stinfo-container">
              <p className="stno">JK41</p>
              <h1 className="stname">蕨</h1>
            </div>
            <div className="cfflag-container">
              <div className="cfflag cf-01 vshide" />
              <div className="cfflag cf-02 vshide" />
              <div className="cfflag cf-03"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>
              <div className="cfflag cf-04 vshide" />
              <div className="cfflag cf-05 vshide" />
              <div className="cfflag cf-06 vshide" />
            </div>
          </div>
          <div className="station-container">
            <div className="stinfo-container">
              <p className="stno">JK40</p>
              <h1 className="stname">西川口</h1>
            </div>
            <div className="cfflag-container">
              <div className="cfflag cf-01 vshide" />
              <div className="cfflag cf-02 vshide" />
              <div className="cfflag cf-03"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>
              <div className="cfflag cf-04 vshide" />
              <div className="cfflag cf-05 vshide" />
              <div className="cfflag cf-06 vshide" />
            </div>
          </div>
          <div className="station-container">
            <div className="stinfo-container">
              <p className="stno">JK39</p>
              <h1 className="stname">川口</h1>
            </div>
            <div className="cfflag-container">
              <div className="cfflag cf-01 vshide" />
              <div className="cfflag cf-02"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>
              <div className="cfflag cf-03"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>
              <div className="cfflag cf-04 vshide" />
              <div className="cfflag cf-05"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>
              <div className="cfflag cf-06 vshide" />
            </div>
          </div>
          <div className="station-container">
            <div className="stinfo-container">
              <p className="stno">JK38</p>
              <h1 className="stname">赤羽</h1>
            </div>
            <div className="cfflag-container">
              <div className="cfflag cf-01"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>
              <div className="cfflag cf-02 vshide" />
              <div className="cfflag cf-03"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>
              <div className="cfflag cf-04"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>
              <div className="cfflag cf-05 vshide" />
              <div className="cfflag cf-06"><img src="/images/coffee_bean.svg" alt="カフェあり" width={40} /></div>
            </div>
          </div>
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
