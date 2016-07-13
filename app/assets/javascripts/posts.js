$(document).ready(function(){
  $(".edits").on("click", ".notLoggedIn", function(){
    event.preventDefault();
    $("#loginModal").modal("toggle");
  });
});
