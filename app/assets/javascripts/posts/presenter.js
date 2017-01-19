var DB = DB || {};

DB.posts.presenter = (function($){
  var $flashWrapper;

  var getCommentsSectionFor = function getCommentsSectionFor(type, id) {
    var search = "[data-type='" + type + "'][data-id='" + id + "'] .comments"
    return $(search)
  }

  var addCommentOn = function addCommentOn(type, id, comment) {
    var $comments = getCommentsSectionFor(type, id);
    var $comment = $(comment);

    $comments.append($comment);

    $comment.hide();
    $comment.slideDown(500);
  }

  return { addCommentOn: addCommentOn }
})($);
