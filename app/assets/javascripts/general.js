$(function() {
  $(".annotation-text").click(function(){
    var current = $(this.parentNode.parentNode);
    current.next().toggleClass("annotation-admin");
    current.next().next().toggleClass("annotation-admin");
  });
})
