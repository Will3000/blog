var BASE_URL = "http://localhost3000/"

$(document).ready(function(){
  $.ajax({
    method: "GET",
    url:    "posts",
    error: function(){
      alert("Errors!")
    },
    success: function(data){

      var template = $('#post-template').html();
      Mustache.parse(template);

      for(var i=0; i<data.length; i++){
        var post = posts[i];
        var rendered = Mustache.render(template, post);
        $("posts").prepend(rendered);
      }
    }
  })
})
