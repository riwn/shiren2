const Counter = $(".counter");
const MinusOdo = $(".minus");
const PlusOdo = $(".plus");
const cntTime = 200;
const DefaultVal = 0;
const Inc = 1;

const SoilMax = 16;
const WaterMax = 12;
const WoodMax = 12;
const RockMax = 8;
const IronSandMax = 8;

//初期値を代入
$(document).ready(function () {
    let counter = $("#counter1");
    ChangeNum(DefaultVal, counter);
    counter = $("#counter2");
    ChangeNum(DefaultVal, counter);
    counter = $("#counter3");
    ChangeNum(DefaultVal, counter);
    counter = $("#counter4");
    ChangeNum(DefaultVal, counter);
    counter = $("#counter5");
    ChangeNum(DefaultVal, counter);
});

//マイナスボタンを押したときの動作
MinusOdo.click(function () {
    let btnid = $(this).attr("id");
    let id = GetCounterID(btnid);
    let num = Minus(id);
    ChangeBtnProp(num, btnid, id);
    ChangeNum(num, id);
});

//プラスボタンを押したときの動作
PlusOdo.on('click', function () {
    let btnid = $(this).attr("id");
    let id = GetCounterID(btnid);
    let num = Plus(id);
    ChangeBtnProp(num, btnid, id);
    ChangeNum(num, id);
});

function Plus(counter) {
    return Number(counter.val().replace(/,/, "")) + Inc;
}

function Minus(counter) {
    return Number(counter.val().replace(/,/, "")) - Inc;
}

//値を変更する関数
function ChangeNum(num, counter) {
    setTimeout(function () {
        counter.val(num);
        counter.text(num);
    }, cntTime);
}

function ChangeBtnProp(num, btnid, counter) {
    let MinVal = 0;
    let MaxVal = 16;
    let minusbtn;
    let plusbtn;
    switch (btnid) {
        case "minus1":
        case "plus1":
            MaxVal = SoilMax;
            minusbtn = $("#minus1");
            plusbtn = $("#plus1");
            break;
        case "minus2":
        case "plus2":
            MaxVal = WaterMax;
            minusbtn = $("#minus2");
            plusbtn = $("#plus2");
            break;
        case "minus3":
        case "plus3":
            MaxVal = WoodMax;
            minusbtn = $("#minus3");
            plusbtn = $("#plus3");
            break;
        case "minus4":
        case "plus4":
            MaxVal = RockMax;
            minusbtn = $("#minus4");
            plusbtn = $("#plus4");
            break;
        case "minus5":
        case "plus5":
            MaxVal = IronSandMax;
            minusbtn = $("#minus5");
            plusbtn = $("#plus5");
            break;
    }
    if (num <= MinVal) {
        minusbtn.prop("disabled", true);
    } else if (num >= MaxVal) {
        plusbtn.prop("disabled", true);
        counter.css("color", "blue");
    } else {
        minusbtn.prop("disabled", false);
        plusbtn.prop("disabled", false);
        counter.css("color", "black");
    }
}

function GetCounterID(btnID) {
    let counterID;
    switch (btnID) {
        case "minus1":
        case "plus1":
            counterID = $("#counter1");
            break;
        case "minus2":
        case "plus2":
            counterID = $("#counter2");
            break;
        case "minus3":
        case "plus3":
            counterID = $("#counter3");
            break;
        case "minus4":
        case "plus4":
            counterID = $("#counter4");
            break;
        case "minus5":
        case "plus5":
            counterID = $("#counter5");
            break;
    }
    return counterID;
}