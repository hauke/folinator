function autoextend()
{
  if ($(this).next().find("input").get()[0].type != "submit")
    return
  var copy = $(this).clone();
  copy.click(autoextend);
  copy.select(autoextend);
  copy.find("input").val("");
  copy.insertAfter(this);
}

$(function() {
  $(".autoextend").click(autoextend);
  $(".autoextend").select(autoextend);
})
