$(document).ready(function($) {
   console.log('Load page handling framework.');
   console.log(testrunner);
   lib.page.init(testrunner.page);
   lib.ajax.errorFunc = testrunner.help.showError;
});

testrunner = {}; 
testrunner.page = {};

PAGE=testrunner.page;
  
PAGE.main = function() {
   var H = testrunner.help.header();
  
   H += '<p>This is the Test Runner GUI. <a href="#Page=run&test=FileRun">Click here</a> to execute the tests.</p>';

   H +=  testrunner.help.footer();
   $('body').html(H);
}
   
PAGE.run = function(R){
   var H = testrunner.help.header();
   H += '<p>Running tests...</p>'
   H +=  testrunner.help.footer(); 
   $('body').html(H);
   
   lib.ajax.call('run', function(R){
      var R = R;
      var H = testrunner.help.header(); 
      for (var i = 0; i < R.length; i++){
         H += "<h2 style=\"color: black; border-bottom: 1px dotted black; padding: 10px; margin: 10px 0px 10px 0px;\">Results for " + R[i][0]["name"] + " (" + R[i][0]["os"] + ")</h2>"
         for (var v in R[i][1]) {
            H += v + ": " + R[i][1][v] + "<br>";
         }
      }
      H += '<a href="#Page=main">&lt; Home</a>';
      H +=  testrunner.help.footer();      
     $('body').html(H);

   });
}  
PAGE.default = PAGE.main;