$(document).ready(function() {


  $("#upload_name").change(function (){
    var url = $("#upload_name").find(":selected").val();
    $.get(url, function(data) {
          var build = '<table border="1" cellpadding="2" cellspacing="0" style="border-collapse: collapse" width="100%">\n';
          var rows = data.split("\n");
          rows.forEach( function getvalues(thisRow) {
        	build += "<tr>\n";
        	var columns = thisRow.split(",");
        	for(var i=0;i<columns.length;i++){ build += "<td>" + columns[i] + "</td>\n"; }
        	build += "</tr>\n";
        	})
        	build += "</table>";
    $("#upload_name").find(":selected");
      $("#files").html('');
      $("#files").append(build);
    });
  });
});
