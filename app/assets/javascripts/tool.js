const Counter = $("#counter");
const MinusOdo = $("#minus");
const PlusOdo = $("#plus");
const cntTime = 500;
const DefaultVal = 5;
const MaxVal = 10;
const MinVal = 0;
const Inc = 1;

//初期値を代入
$(document).ready(function () {
    ChangeNum(DefaultVal);
});

//マイナスボタンを押したときの動作
MinusOdo.click(function () {
    let num = Number(Counter.val().replace(/,/, "")) - Inc;
    ChangeNum(num);
});

//プラスボタンを押したときの動作
PlusOdo.click(function () {
    let num = Number(Counter.val().replace(/,/, "")) + Inc;
    ChangeNum(num);
});

//値を変更する関数
function ChangeNum(num) {
    setTimeout(function () {
        Counter.val(num);
        Counter.text(num);
    }, cntTime);
    if (num <= MinVal) {
        MinusOdo.prop("disabled", true);
    } else if (num >= MaxVal) {
        PlusOdo.prop("disabled", true);
    } else {
        PlusOdo.prop("disabled", false);
        MinusOdo.prop("disabled", false);
    }
}