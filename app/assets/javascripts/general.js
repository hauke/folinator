$(function() {
  $(".annotation-text").click(function(){
    var current = $(this.parentNode.parentNode);
    current.next().toggleClass("annotation-admin");
    current.next().next().toggleClass("annotation-admin");
  });
})

$(function() {
  $(".annotation-surrounding-head").click(function(){
    $(".annotation-surrounding").toggleClass("annotation-surrounding-hide");
  });
})

$(function() {
  $(".autoclick").click();
})
