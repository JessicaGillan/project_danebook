var DB = DB || {};

DB.flashCtrl = (function($){
  var $flashWrapper;

  var renderFlash = function renderFlash(flash) {
    $flashWrapper = $('#flash-wrapper')
    $flashWrapper.html(flash).slideDown(500);
    setTimeout(_removeFlash, 1500);
  }

  var _removeFlash = function _removeFlash() {
    $flashWrapper.slideUp(300);
  }

  return { renderFlash: renderFlash }
})($);
