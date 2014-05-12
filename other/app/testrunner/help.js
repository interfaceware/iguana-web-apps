if (!testrunner) { testrunner = {}; }

testrunner.help = {};
   
testrunner.help.header = function(){
   return '<h1>Test Runner</h1><div id="wrapper">';
} 
   
testrunner.help.footer = function(){
   return '</div>';
}

testrunner.help.breadCrumb = function(T){
   return "<hr><a href='#'>Dashboard</a> &gt; "+ T +"<hr>";
}

testrunner.help.showError = function(Msg){
   $('body').html(testrunner.help.header() + "<font color='red'>" + Msg + '</font> <p><a href="#">Back to dashboard</a>' + testrunner.help.footer());
}

