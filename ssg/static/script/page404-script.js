"use strict";


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

elMenuBtn.addEventListener('click', () => {
    toggleMenu();
});

elMenuBody.addEventListener('click', () => {
    toggleMenu();
});

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

