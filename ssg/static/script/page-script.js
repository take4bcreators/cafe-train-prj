"use strict";


// 要素取得
const elAllStCont  = document.querySelector('.allstations-container');
const elLnNameArr  = document.querySelectorAll('.lnname');
const elCfNameArr  = document.querySelectorAll('.cfname');
const elTrLineArr  = document.querySelectorAll('.trline');
const elStNameArr  = document.querySelectorAll('.stname');
const elMainHeader = document.querySelector('.main-header');

// メニュー関係の要素
const elMenuBtn     = document.querySelector('.menu-btn');
const elMenuBody    = document.querySelector('.menu-body');
const elMenuMask    = document.querySelector('.menu-mask');



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



// スクロールした際にページタイトル（路線名）にクラスを付与して小さくする
window.addEventListener('scroll', () => {
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
elLnNameArr.forEach(elLnName => {
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
    replacedText       = replacedText.replace('東京臨海<wbr>高速鉄道', '東京臨海<wbr>高速鉄道<wbr>');
    replacedText       = replacedText.replace('横浜高速鉄道', '横浜高速鉄道<wbr>');
    replacedText       = replacedText.replace('埼玉高速鉄道', '埼玉高速鉄道<wbr>');
    replacedText       = replacedText.replace('横浜市営地下鉄', '横浜市営地下鉄<wbr>');
    replacedText       = replacedText.replace('東京モノレール', '東京モノレール<wbr>');
    replacedText       = replacedText.replace('ライン', '<wbr>ライン');
    elLnName.innerHTML = replacedText;
});



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


