"use strict";


// 要素取得
const elSplash      = document.querySelector('#splash');
const elSplashLogo  = document.querySelector('#splash-logo');
const elSplashSvg   = document.querySelector('#splash-logo svg');

// メニュー関係の要素
const elMenuBtn     = document.querySelector('.menu-btn');
const elMenuBody    = document.querySelector('.menu-body');
const elMenuMask    = document.querySelector('.menu-mask');



// スプラッシュ画面の設定
const delayMSec = 2000;

// 画面読み込み時
elSplashSvg.classList.add('active');

// 要素を非表示にする
setTimeout(() => {
    elSplash.classList.add('hide');
    elSplashLogo.classList.add('hide');
}, delayMSec);

// 要素自体を消す
setTimeout(() => {
    elSplash.style.display = 'none';
    elSplashSvg.classList.remove('active');
}, delayMSec + 200);




// メニューボタン切り替え
const toggleMenu = () => {
    elMenuBtn.classList.toggle('active');
    elMenuBody.classList.toggle('show');
    elMenuMask.classList.toggle('show');
}

elMenuBtn.addEventListener('click', () => {
    toggleMenu();
});

elMenuBody.addEventListener('click', () => {
    toggleMenu();
});

elMenuMask.addEventListener('click', () => {
    elMenuBtn.classList.remove('active');
    elMenuBody.classList.remove('show');
    elMenuMask.classList.remove('show');
});

