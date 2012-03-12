$(function() {
  $(".autoextend").select(function() {
    if ($(this).next().find("input").get()[0].type != "submit") {
      return
    }
    var copy = $(this).clone(true);
    copy.find("input").val("");
    copy.insertAfter(this);
  })
})
