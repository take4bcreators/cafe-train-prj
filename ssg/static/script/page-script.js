"use strict";

// 要素取得
const elAllStCont  = document.querySelector('.allstations-container');
const elLnName     = document.querySelector('.lnname');
const elCfNameArr  = document.querySelectorAll('.cfname');
const elTrLineArr  = document.querySelectorAll('.trline');
const elStNameArr  = document.querySelectorAll('.stname');
const elMainHeader = document.querySelector('.main-header');

// メニュー関係の要素
const elMenuBtn         = document.querySelector('.menu-btn');
const elMenuBody        = document.querySelector('.menu-body');
const elMenuMask        = document.querySelector('.menu-mask');
const elMenuItemArr     = document.querySelectorAll('.menu li .item');
const elMenuItemLinkArr = document.querySelectorAll('li.menu-item a');

// メニュー内の路線選択関係の要素
const elMenuRailmapBtn       = document.querySelector('li.menu-item.lineselect p.item');
const elMenuLineList         = document.querySelector('li.menu-item.lineselect .linelist');
const elMenuCompNameArr      = document.querySelectorAll('li.menu-item.lineselect .linelist .linecompany>h1');
const elMenuCompLineListArr  = document.querySelectorAll('li.menu-item.lineselect .linelist .linecompany>ul');

// スプラッシュ画面関係要素
const elSplashContainer      = document.querySelector('.splash-container.page');
const elSplashLogo           = document.querySelector('.splash-container .splash-logo');
const elSmoothTextWrap       = document.querySelector('.smooth-text-wrap');
const elSmoothText           = document.querySelector('.smooth-text');
const elSplashContainerCover = document.querySelector('.splash-container.page-cover');

// カフェ存在アイコン
const elCfFlagArr  = document.querySelectorAll('.cfflag');



// スプラッシュ画面の設定
const delayMSec = 1000;

// 要素を非表示にする
setTimeout(() => {
    elSplashContainer.classList.add('hide');
    elSplashContainerCover.classList.add('hide');
    elSplashLogo.classList.add('hide');
}, delayMSec);

// 要素自体を消す
setTimeout(() => {
    elSplashContainer.style.display = 'none';
    elSplashContainerCover.style.display = 'none';
}, delayMSec + 200);



// ライン高さの自動調節処理
function resizeLineHeight() {
    const stationsHeight = elAllStCont.clientHeight;
    elTrLineArr.forEach(elTrLine => {
        elTrLine.style.height = stationsHeight + 'px';
    });    
}

resizeLineHeight();
window.addEventListener('resize', () => {
    resizeLineHeight();
});

// 表示時のアニメーション用
elTrLineArr.forEach(elTrLine => {
    setTimeout(() => {
        elTrLine.classList.add('show');
    }, 1000);
});



// 駅名の文字数に応じてクラスを付与
elStNameArr.forEach(elStName => {
    const textCont      = elStName.textContent;
    const charCount     = textCont.length;
    const classBaseName = 'cc';
    
    let addClassName = '';
    if (charCount < 10) {
        addClassName = classBaseName + charCount;
    } else {
        addClassName = classBaseName + '10over';
    }
    
    elStName.classList.add(addClassName);
});



// 読み込み時にカフェ存在アニメーション実行
elCfFlagArr.forEach(elCfFlag => {
    setTimeout(() => {
        elCfFlag.classList.add('show');
    }, 1000);
    setTimeout(() => {
        elCfFlag.classList.add('end');
    }, 2000);
});



// スクロールした際のイベント
window.addEventListener('scroll', () => {
    // スクロールした際にページタイトル（路線名）にクラスを付与して小さくする
    const toggleClassName = 'is-scroll';
    const topValue        = document.scrollingElement.scrollTop;
    if (topValue > 50) {
        elMainHeader.classList.add(toggleClassName);
        elMenuBtn.classList.add(toggleClassName);
    } else {
        elMainHeader.classList.remove(toggleClassName);
        elMenuBtn.classList.remove(toggleClassName);
    }
});



// 縦文字の ー に span 要素とクラスを追加する
// Safari では フォントによって 長音記号（ー） が縦にならない問題の対応
elCfNameArr.forEach(elCfName => {
    const textCont     = elCfName.textContent;
    const replacedText = textCont.replace('ー', '<span class="sideways">ー</span>');
    elCfName.innerHTML = replacedText;
});



// 路線名折り返しの設定
const textCont     = elLnName.textContent;
let replacedText   = textCont;
replacedText       = replacedText.replace('JR', 'JR<wbr>');
replacedText       = replacedText.replace('東京メトロ', '東京メトロ<wbr>');
replacedText       = replacedText.replace('都営地下鉄', '都営地下鉄<wbr>');
replacedText       = replacedText.replace('東急', '東急<wbr>');
replacedText       = replacedText.replace('東武', '東武<wbr>');
replacedText       = replacedText.replace('西武', '西武<wbr>');
replacedText       = replacedText.replace('小田急', '小田急<wbr>');
replacedText       = replacedText.replace('京王', '京王<wbr>');
replacedText       = replacedText.replace('京成', '京成<wbr>');
replacedText       = replacedText.replace('京急', '京急<wbr>');
replacedText       = replacedText.replace('相鉄', '相鉄<wbr>');
replacedText       = replacedText.replace('東京臨海高速鉄道', '東京臨海<wbr>高速鉄道<wbr>');
replacedText       = replacedText.replace('横浜高速鉄道', '横浜高速鉄道<wbr>');
replacedText       = replacedText.replace('埼玉高速鉄道', '埼玉高速鉄道<wbr>');
replacedText       = replacedText.replace('横浜市営地下鉄', '横浜市営地下鉄<wbr>');
replacedText       = replacedText.replace('東京モノレール', '東京モノレール<wbr>');
replacedText       = replacedText.replace('ライン', '<wbr>ライン');
elLnName.innerHTML = replacedText;



// メニューボタン切り替え
function toggleMenu() {
    elMenuBtn.classList.toggle('active');
    elMenuBody.classList.toggle('show');
    elMenuMask.classList.toggle('show');
    
    // メニュー項目の表示アニメーション
    let delayMSec = 100;
    elMenuItemArr.forEach(elMenuItem => {
        setTimeout(() => {
            elMenuItem.classList.toggle('show');
        }, delayMSec);
        delayMSec += 100;
    });
    
    // メニュー内路線選択用
    // 路線選択メニューを開いている場合は閉じる
    if (elMenuRailmapBtn.classList.contains('open')) {
        elMenuRailmapBtn.classList.remove('open');
    }
    if (elMenuLineList.classList.contains('open')) {
        elMenuLineList.classList.remove('open');
    }
    if (elMenuLineList.classList.contains('display')) {
        elMenuLineList.classList.remove('display');
    }
    elMenuCompNameArr.forEach(elMenuCompName => {
        if (elMenuCompName.classList.contains('open')) {
            elMenuCompName.classList.remove('open');
        }
    });
    elMenuCompLineListArr.forEach(elMenuCompLineList => {
        if (elMenuCompLineList.classList.contains('open')) {
            elMenuCompLineList.classList.remove('open');
        }
        if (elMenuCompLineList.classList.contains('display')) {
            elMenuCompLineList.classList.remove('display');
        }
    });
}

elMenuBtn.addEventListener('click', toggleMenu);
elMenuBody.addEventListener('click', toggleMenu);



// 「駅カフェ路線図」押下時の表示・アニメーション用
elMenuRailmapBtn.addEventListener('click', (event) => {
    // 「駅カフェ路線図」左の ＋ アイコンのアニメーション用
    elMenuRailmapBtn.classList.toggle('open');
    
    // 「display: none;」だと直接 transition ができないため、
    // 2段階でクラスを付与してアニメーションする
    if (elMenuLineList.classList.contains('open')) {
        // クラスの削除
        elMenuLineList.classList.remove('open');
        setTimeout(() => {
            elMenuLineList.classList.remove('display');
        }, 100);
    } else {
        // クラスの付与
        elMenuLineList.classList.add('display');
        setTimeout(() => {
            elMenuLineList.classList.add('open');
        }, 100);
    }
    
    // elMenuBody へイベントが伝搬すると、
    // メニュー画面自体が閉じてしまうため、防ぐ
    event.stopPropagation();
});

// 事業者名押下時の表示・アニメーション用
elMenuCompNameArr.forEach(elMenuCompName => {
    elMenuCompName.addEventListener('click', (event) => {
        // 事業者名 左の ＋ アイコンのアニメーション用
        elMenuCompName.classList.toggle('open');
        
        // 次の要素（事業者内路線リストの ul ）を取得
        const elMenuCompLineList = elMenuCompName.nextElementSibling;
        
        // 「display: none;」だと直接 transition ができないため、
        // 2段階でクラスを付与してアニメーションする
        if (elMenuCompLineList.classList.contains('open')) {
            // クラスの削除
            elMenuCompLineList.classList.remove('open');
            setTimeout(() => {
                elMenuCompLineList.classList.remove('display');
            }, 100);
        } else {
            // クラスの付与
            elMenuCompLineList.classList.add('display');
            setTimeout(() => {
                elMenuCompLineList.classList.add('open');
            }, 100);
        }
        
        // elMenuBody へイベントが伝搬すると、
        // メニュー画面自体が閉じてしまうため、防ぐ
        event.stopPropagation();
    });
});



// メニュー内のリンク全て
elMenuItemLinkArr.forEach(elMenuItemLink => {
    elMenuItemLink.addEventListener('click', (event) => {
        // elMenuBody へイベントが伝搬すると、
        // メニュー画面自体が閉じてしまうため、防ぐ
        event.stopPropagation();
    });
});



// 表示時のアニメーション用
elSmoothText.classList.add('show');
elSmoothTextWrap.classList.add('show');

