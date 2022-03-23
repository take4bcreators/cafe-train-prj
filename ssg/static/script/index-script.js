"use strict";

// 要素取得
const elSplashContainer = document.querySelector('.splash-container');
const elSplashLogo      = document.querySelector('.splash-container .splash-logo');
const elSplashSvg       = document.querySelector('.splash-container .splash-logo svg');

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

// トップページの路線選択関係の要素
const elDetailsArr  = document.querySelectorAll('.linelist.index details');

// トップページ装飾用
const elHumikiriBar     = document.querySelector('.humikiri_bar svg');
const elMainMsgType1    = document.querySelector('.mainmsg.type1');
const elLuxy            = document.querySelector('#luxy');
const elMainImg         = document.querySelector('.mainimg');
const elHashiraType1    = document.querySelector('.hashira.type1');



// 画面読み込み時のアニメーション
const delayMSec = 2000;

// SVGアニメーションの開始
// 開発時の Safari 表示のため、少し遅らせてスタート
setTimeout(() => {
    elSplashSvg.classList.add('active');
}, 100);

// 要素を非表示にする
setTimeout(() => {
    elSplashContainer.classList.add('hide');
    elSplashLogo.classList.add('hide');
}, delayMSec);

// 要素自体を消す
setTimeout(() => {
    elSplashContainer.style.display = 'none';
    elSplashSvg.classList.remove('active');
}, delayMSec + 200);

// ロード時ブラーアニメーション用
setTimeout(() => {
    elLuxy.classList.add('show');
}, delayMSec + 300);



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



// トップページの路線選択画面の ＋ アイコン処理
elDetailsArr.forEach(elDetails => {
    elDetails.addEventListener('toggle', () => {
        if (elDetails.open) {
            // 開いた際の処理
            elDetails.classList.add('open');
        } else {
            // 閉じた際の処理
            elDetails.classList.remove('open');
        }
    });
});



// 数値範囲変換汎用関数（変換対象, 元範囲最小, 元範囲最大, 新範囲最小, 新範囲最大）
function valueRemap(targetNumber, oldFrom, oldTo, newFrom, newTo) {
    const oldDiff = oldTo - targetNumber
    const oldRange = oldTo - oldFrom
    const newRange = newTo - newFrom
    const percentage = oldDiff / oldRange
    const newDiff = percentage * newRange
    const rs = newTo - newDiff
    return rs
}



// スクロールした際のイベント
window.addEventListener('scroll', () => {
    // スクロール位置
    const scrollValue = document.scrollingElement.scrollTop;
    
    // ウィンドウの高さ取得
    const windowHeight = window.innerHeight;
    
    const execValScale01 = 2.2;
    const execVal01 = windowHeight * execValScale01;
    if (scrollValue >= execVal01) {
        elHumikiriBar.classList.add('open');
    } else {
        elHumikiriBar.classList.remove('open');
    }
    
    const execValScale02 = 1.1;
    const execVal02 = windowHeight * execValScale02;
    if (scrollValue >= execVal02) {
        elMainMsgType1.classList.add('show');
    } else {
        elMainMsgType1.classList.remove('show');
    }
    
    const execValScale03 = 2.5;
    const execVal03 = windowHeight * execValScale03;
    if (scrollValue >= execVal03) {
        elMainImg.classList.add('hide');
    } else {
        elMainImg.classList.remove('hide');
    }
});



// Luxy の横移動調整関数
function setLuxySpeedX() {
    // ウィンドウの横幅を取得
    const windowWidth = window.innerWidth;
    
    // メインイメージの横移動距離変換（横幅 1440 の時、-12）
    const mainImgSpeedX = valueRemap(windowWidth, 0, 1440, 0, -12);
    
    // 柱1の横移動距離変換（横幅 1440 の時、2）
    const hashiraType1SpeedX = valueRemap(windowWidth, 0, 1440, 0, 2);
    
    // 属性セット
    elMainImg.setAttribute('data-speed-x', mainImgSpeedX);
    elHashiraType1.setAttribute('data-speed-x', hashiraType1SpeedX);
}

// 読み込み時に発火
setLuxySpeedX();

