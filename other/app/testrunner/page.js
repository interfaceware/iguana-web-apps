$(document).ready(function($) {
   console.log('Load page handling framework.');
   console.log(testrunner);
   lib.page.init(testrunner.page);
   // TODO get rid of using lib/ajax.js and swtich over to how the channel manager does it.
   lib.ajax.errorFunc = testrunner.help.showError;
});

testrunner = {}; 
testrunner.page = {};

PAGE=testrunner.page;
  
PAGE.main = function() {
   var H = testrunner.help.header();
   lib.ajax.call('start', function(R){
      if(typeof R.IsSetup != 'undefined' && !R.IsSetup){
         H += "<p>It looks like you haven't configured this app yet. Please set your initial configuration in testrunner.ini and then <a href='#Page=config'>continue</a>.</p>" ;
         H += "<p>If you have already finished configuring then <a href=\"#Page=run\">executing your first run</a> will prevent this page from appearing in the future.</p>";
         H += testrunner.help.footer();
         $('body').html(H);
      } else {
         H += "<table id=\"results_table\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"></table>";
         H += "<a href=\"#Page=run\">Run Tests</a><br /><a href=\"#Page=config\">Manage Configuration</a>"
         H +=  testrunner.help.footer();
         $('body').html(H);
         $("#results_table").dataTable(R);
      }
   });
}
   
PAGE.config = function(){
   lib.ajax.call('list', function(R){
      var H = testrunner.help.header();
      H += "<h3 style=\"margin-bottom: -20px;\">Test Hosts</h3>";
      H += "<table id=\"hosts\">";
      H += testrunner.help.hostTableHead();
      for(var key in R){
         H += "<tr>";
         H += "<td></td>";
         H += "<td>" + key + "</td>";
         H += "<td>" + R[key]['host'] + "</td>";
         H += "<td>" + R[key]['https'] + "</td>";
         H += "<td>" + R[key]['port'] + "</td>";
         H += "<td>" + R[key]['http_port'] + "</td>";
         H += "<td>" + R[key]['user'] + "</td>";
         H += "<td>" + R[key]['pass'] + "</td>";
         H += "</tr>";
      }
      H += "<table>";
      H += "<a href=\"#Page=configEdit\">Edit & Add Hosts</a>";
      H += "<br /><a href=\"#Page=run\">Run Tests</a>";
      H += "<br /><a href=\"#Page=main\">Home</a>";
      H += testrunner.help.footer();
      $('body').html(H);
   });
}
   
PAGE.configEdit = function(){
   lib.ajax.call('list', function(R){
      var H = testrunner.help.header();
      H += "<form id=\"hosts\" action=\"save\"><table id=\"hosts\">";
      H += testrunner.help.hostTableHead();
      var count = 0;
      for(var key in R){
         count++
         H += "<tr>";
         H += "<td><input name=\"host_id\" type=\"hidden\" value=\"" + R[key]['host_id'] + "\"/>";
         H += "<td><input name=\"name\" type=\"text\" value=\"" + key + "\" /></td>";
         H += "<td><input name=\"host\" type=\"text\" value=\"" + R[key]['host'] + "\" /></td>";
         H += "<td><input name=\"https\" type=\"text\" value=\"" + R[key]['https'] + "\" /></td>";
         H += "<td><input name=\"port\" type=\"text\" value=\"" + R[key]['port'] + "\" /></td>";
         H += "<td><input name=\"http_port\" type=\"text\" value=\"" + R[key]['http_port'] + "\" /></td>";
         H += "<td><input name=\"user\" type=\"text\" value=\"" + R[key]['user'] + "\" /></td>";
         H += "<td><input name=\"pass\" type=\"text\" value=\"" + R[key]['pass'] + "\" /></td>";
         H += "<td><input name=\"results\" type=\"hidden\" value=\"" + R[key]['results'] + "\" /></td>";
         H += "<td><span class=\"delete\">Delete</span></td>";
         H += "</tr>";
      }
      if(count <= 0){
         H += "<tr>";
         H += "<td><input name=\"host_id\" type=\"hidden\" value=\"\"/>";
         H += "<td><input name=\"name\" type=\"text\" value=\"\" /></td>";
         H += "<td><input name=\"host\" type=\"text\" value=\"\" /></td>";
         H += "<td><input name=\"https\" type=\"text\" value=\"\" /></td>";
         H += "<td><input name=\"port\" type=\"text\" value=\"\" /></td>";
         H += "<td><input name=\"http_port\" type=\"text\" value=\"\" /></td>";
         H += "<td><input name=\"user\" type=\"text\" value=\"\" /></td>";
         H += "<td><input name=\"pass\" type=\"text\" value=\"\" /></td>";
         H += "<td><input name=\"results\" type=\"hidden\" value=\"\" /></td>";
         H += "<td><span class=\"delete\">Delete</span></td>";
         H += "</tr>";
      }
      H += "</tbody></table></form>";
      H += "<span id=\"add\">Add Host</span> | ";
      H += "<span id=\"save\">Save Hosts</span> | ";
      H += "<span id=\"cancel\">Cancel</span>";
      H += testrunner.help.footer();
      $('body').html(H);
      $('#add').click(function () {
         $('#hosts tbody tr:last').clone(true).insertAfter('#hosts tbody>tr:last');
         $('#hosts tbody tr:last input').val('');
         return false;
      });
      $('.delete').click(function() {
         var tr = $(this).closest('tr');
         if ($('#hosts tbody tr').length > 1) {
            tr.remove();
         } else {
            $('#hosts tbody tr:last').clone(true).insertAfter('#hosts tbody>tr:last');
            $('#hosts tbody tr:last input').val('');
            tr.remove();
         }
         return false;
      });
      $('#save').click(function() {
         var rows = [];
         $('#hosts tbody tr').each(function(){
            rows.push({
               host_id: $(this).find('input[name="host_id"]').val(),
               name: $(this).find('input[name="name"]').val(),
               host: $(this).find('input[name="host"]').val(),
               https: $(this).find('input[name="https"]').val(),
               port: $(this).find('input[name="port"]').val(),
               http_port: $(this).find('input[name="http_port"]').val(),
               user: $(this).find('input[name="user"]').val(),
               pass: $(this).find('input[name="pass"]').val(),
            });
         });
         console.log(rows)
         $.ajax({
            url: 'save',
            dataType: 'json',
            type: 'POST',
            data: JSON.stringify(rows),
            success: function(data){
               if(data[0]===true) {
                  window.location.hash = "#Page=config";
               }
            }
         });
         return false;
      });
      $("#cancel").click(function() {
         window.location.hash = "#Page=config";
      });
   });
}
   
PAGE.run = function(R){
   var H = testrunner.help.header();
   H += '<p>Running tests...</p>'
   H +=  testrunner.help.footer(); 
   $('body').html(H);
   lib.ajax.call('run', function(R){
      var Result = R
      window.location.hash = '#Page=main'
   });
}  

PAGE.default = PAGE.main;