$(document).ready(function($) {
   console.log('Load page handling framework.');
   console.log(testrunner);
   lib.page.init(testrunner.page);
   $(document).ajaxError(function(Event, Info, Error){
      console.log(Error, Info, Event);
      if (Info.responseJSON) {
         testrunner.help.showError("Error: " +  Info.responseJSON.error);
      } else {
         testrunner.help.showError("Call " + Error.url + " failed: " + textStatus + " " + Error);
      }
   });
});

testrunner = {}; 
testrunner.page = {};
PAGE=testrunner.page;

PAGE.main = function() {
   var H = testrunner.help.header();
   $.ajax({
      url: 'start',
      dataType: 'json',
      type: 'POST',
      success: function(R){
         if(!R.setup){
            H += "<p>It looks like you haven't configured this app yet. Please set your initial <a href='#Page=config'>configuration</a>.</p>" ;
            H += "<p>If you have already finished configuring and adding your test servers then <a href=\"#Page=run\">executing your first run</a> will prevent this page from appearing in the future.</p>";
            H += testrunner.help.footer();
            $('body').html(H);
         } else {
            H += "<table id=\"results_table\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"></table>";
            H += "<a class=\"button\" href=\"#Page=run\">Run Tests</a><br /><a class=\"button\" href=\"#Page=config\">Manage Configuration</a>"
               H +=  testrunner.help.footer();
            $('body').html(H);
            $("#results_table").dataTable(R.data);
         }
      }
   })
}
   
PAGE.config = function(){
   $.ajax({
      url: 'listHosts',
      dataType: 'json',
      type: 'POST',
      success: function(R){
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
         H += "<a class=\"button\" href=\"#Page=hostsEdit\">Edit & Add Hosts</a>";
         H += "<br /><a class=\"button\" href=\"#Page=configList\">View & Edit Settings</a>";
         H += "<br /><a class=\"button\" href=\"#Page=run\">Run Tests</a>";
         H += "<br /><a class=\"button\" href=\"#Page=sync\" onclick=\"return confirm('Are you sure you want to sync your Git repo? All uncommitted changes will be lost.');\">Sync GIT Repo</a><span> Note: This will wipe any uncommited changes in your Git directory.";
         H += "<br /><a class=\"button\" href=\"#Page=main\">Home</a>";
         H += testrunner.help.footer();
         $('body').html(H);
      }
   });
}
   
PAGE.hostsEdit = function(){
   $.ajax({
      url: 'listHosts',
      dataType: 'json',
      type: 'POST',
      success: function(R){
         var H = testrunner.help.header();
         H += "<form id=\"hosts\" action=\"save\"><table id=\"hosts\">";
         H += testrunner.help.hostTableHead();
         var count = 0;
         for(var key in R){
            count++;
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
            H += "<td><span class=\"button delete\">Delete</span></td>";
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
            H += "<td><span class=\"button delete\">Delete</span></td>";
            H += "</tr>";
         }
         H += "</tbody></table></form>";
         H += "<span id=\"add\" class=\"button\">Add Host</span>";
         H += "<span id=\"save\" class=\"button\">Save Hosts</span>";
         H += "<span id=\"cancel\" class=\"button\">Cancel</span>";
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
            $.ajax({
               url: 'saveHosts',
               dataType: 'json',
               type: 'POST',
               data: JSON.stringify(rows),
               success: function(R){
                  if (R.err) {
                     $('div.err').remove();
                     $('<div class="err"><p>' + R.message + '</p></div>').insertBefore('#hosts');
                     $('input').removeClass('err');
                     for (var key in R.data) {
                        for (var k in R.data[key]['errors']) {
                           if (!R.data[key]['errors'][k]) {
                              $('tr:eq(' + R.data[key]['index'] + ') td input[name="' + k + '"]').addClass('err');
                           }
                        }
                     }
                  } else {
                     window.location.hash = "#Page=config";
                  }
               }
            });
            return false;
         });
         $("#cancel").click(function() {
            window.location.hash = "#Page=config";
         });
      }
   });
}
   
PAGE.configList = function(){
   $.ajax({
      url: 'listConfig',
      dataType: 'json',
      type: 'GET',
      success: function(R){
         Result = R
         var H = testrunner.help.header();
         H += "<h2>Settings</h2>";
         for (var key in R.data) {
            if (R.data[key] == null || R.data[key] == '') {
               R.data[key] = "Not yet configured";
            }
         }
         H += "<table>";
         H += "<tr><td><strong>Test Suite Channel</strong></td><td>" + R.data['test_suite'] + "</td></tr>";
         H += "<tr><td><strong>Local Git Repo</strong></td><td>" + R.data['local_git_repo'] + "</td></tr>";
         H += "<tr><td><strong>GitHub Repo</strong></td><td>" + R.data['github_repo'] + "</td></tr>";
         H += "<tr><td><strong>GitHub OAuth Token</strong></td><td>" + R.data['github_oauth_token'] + "</td></tr>";
         H += "</table>";
         H += "<a href=\"#Page=config\" class=\"button\">Back</a>";
         H += "<a href=\"#Page=configEdit\" class=\"button\">Edit Settings</a>";
         H += testrunner.help.footer();
         $('body').html(H);
      }
   });
}
   
PAGE.configEdit = function(){
   $.ajax({
      url: 'listConfig',
      dataType: 'json',
      type: 'GET',
      success: function(R){
         Result = R
         var H = testrunner.help.header();
         H += "<h2>Settings</h2>";
         H += "<table>";
         H += "<tr><td><strong>Test Suite Channel</strong></td><td><input size=\"70\" type=\"text\" name=\"test_suite\" value=\"" + R.data['test_suite'] + "\" /></td></tr>";
         H += "<tr><td><strong>Local Git Repo</strong></td><td><input size=\"70\" type=\"text\" name=\"local_git_repo\" value=\"" + R.data['local_git_repo'] + "\" /></td></tr>";
         H += "<tr><td><strong>GitHub Repo</strong></td><td><input size=\"70\" type=\"text\" name=\"github_repo\" value=\"" + R.data['github_repo'] + "\" /></td></tr>";
         H += "<tr><td><strong>GitHub OAuth Token</strong></td><td><input size=\"70\" type=\"text\" name=\"github_oauth_token\" value=\"" + R.data['github_oauth_token'] + "\" /></td></tr>";
         H += "</table>";
         H += "<span id=\"save\" class=\"button\">Save Hosts</span>";
         H += "<span id=\"cancel\" class=\"button\">Cancel</span>";
         H += testrunner.help.footer();
         $('body').html(H);
         
         $('#save').click(function(){
            var config = {
               test_suite: $(document).find('input[name="test_suite"]').val(),
               local_git_repo: $(document).find('input[name="local_git_repo"]').val(),
               github_repo: $(document).find('input[name="github_repo"]').val(),
               github_oauth_token: $(document).find('input[name="github_oauth_token"]').val()
            }
            $.ajax({
               url: 'saveConfig',
               dataType: 'json',
               type: 'POST',
               data: JSON.stringify(config),
               success: function(R){
                  if (R.err) {
                     $('input').removeClass('err');
                     for (var key in R.data) {
                        if (!R.data[key]) {
                           $('input[name="' + key + '"]').addClass('err');
                        }
                     }
                     return false;
                  } else {
                     window.location.hash = "#Page=configList";
                  }
               }
            });
         });
         
         $("#cancel").click(function() {
            window.location.hash = "#Page=configList";
         });
      }
   });
}
   
PAGE.run = function(){
   var H = testrunner.help.header();
   H += '<p>Running tests...</p>';
   H +=  testrunner.help.footer(); 
   $('body').html(H);
   $.ajax({
      url: 'run',
      dataType: 'json',
      type: 'GET',
      success: function(R){
         if(R.err) {
            var H = testrunner.help.header();
            H += '<p>' + R.message + '</p>';
            H += '<p><a href=\"#Page=main\">< Go Back</a></p>';
            H +=  testrunner.help.footer(); 
            $('body').html(H);
         } else {
            window.location.hash = '#Page=main';
         }
      }
   });
}
   
PAGE.sync = function(){
   var H = testrunner.help.header();
   H += '<p>Syncing git...</p>'
   H +=  testrunner.help.footer(); 
   $('body').html(H);
   $.ajax({
      url: 'sync',
      dataType: 'json',
      type: 'GET',
      success: function(R){
         H = testrunner.help.header();
         H += "<p>" + R.message + "</p>";
         H += "<p><a href=\"#Page=main\">Home</a></p>";
         H += testrunner.help.footer();
         $('body').html(H);
      }
   });
}  

PAGE.default = PAGE.main;