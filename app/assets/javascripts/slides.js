
$(function(){
  $("ol.sortable").sortable({
    update: function(){
      $.ajax({
        type: 'post',
        data: $('ol#slides').sortable('serialize'),
        dataType: 'script',
        url: 'slides/sort'
      })
    }
  });
})
