if (typeof testrunner == "undefined") { testrunner = {}; }

testrunner.help = {};
   
testrunner.help.header = function(){
   return '<h1>Test Runner</h1><div id="wrapper">';
} 
   
testrunner.help.footer = function(){
   return '</div>';
}
   
testrunner.help.hostTableHead = function() {
   return "<thead><tr>&nbsp;<th></th><th>Name</th><th>Host</th><th>HTTPS</th><th>Port</th><th>HTTP Port</th><th>User</th><th>Pass</th><th>&nbsp;</th></tr></thead><tbody>";
}

testrunner.help.breadCrumb = function(T){
   return "<hr><a href='#'>Main</a> &gt; "+ T +"<hr>";
}

testrunner.help.showError = function(Msg){
   $('body').html(testrunner.help.header() + "<font color='red'>" + Msg + '</font> <p><a href="#">Back to Main</a>' + testrunner.help.footer());
}

