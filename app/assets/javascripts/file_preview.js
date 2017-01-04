$(document).ready(function() {
  // $('#upload_name').on('select', function(){

    var url = $("#upload_name").find(":selected").val();
    var img = $("<img />").attr('src', url).height(100).width(100);
    $("#upload_name").find(":selected");
      $("#files").append(img);
  // });
});
