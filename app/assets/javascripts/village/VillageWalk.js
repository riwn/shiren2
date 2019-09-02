function Village_Walk() {
  var shiren_cat = 0;
  var maml_cat = 0;

  setInterval(function () {
    $('.nataneVillage .shirenwalk').css('background-position', shiren_cat + 'px top');
    shiren_cat = shiren_cat - 21 > -167 ? shiren_cat - 21 : 0;
  }, 200);
  setInterval(function () {
    $('.nataneVillage .mamlwalk').css('background-position', maml_cat + 'px top');
    maml_cat = maml_cat - 12 > -60 ? maml_cat - 12 : 0;
  }, 150);
  Move_Left(".shirenL1", 90);
  Move_Left(".mamlL1", 120);
  Move_Left(".cloudL1", 200);
  Move_Left(".cloudL2", 200);
  Move_Left(".cloudL3", 200);
  Move_Right(".mamlR1", 200);
}

function Move_Left(obj, time) {
  var ww = window.innerWidth
  var ctPos = ww;
  var leftPos = Math.floor(Math.random() * (ww - 200));
  setInterval(function () {
    if (leftPos > ctPos) {
      leftPos = -60;
    } else {
      leftPos = leftPos + 1;
      $(obj).css({
        'transform': 'translate(' + leftPos + 'px,0px) rotateY(0deg)',
        'transition': '',
        'opacity': 1
      });
    }
  }, time);
}

function Move_Right(obj, time) {
  var ww = window.innerWidth
  var ctPos = ww;
  var rightPos = Math.floor(Math.random() * (ww - 200));
  setInterval(function () {
    if (rightPos < -50) {
      rightPos = ctPos;
    } else {
      rightPos = rightPos - 1;
      $(obj).css({
        'transform': 'translate(' + rightPos + 'px,0px) rotateY(0deg)',
        'transition': 'none',
        'opacity': 1
      });
    }
  }, time);
}