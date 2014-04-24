if (!app) { app ={}; }
if (!app.cm) { app.cm = {}; }

app.cm.help = {};
   
cm.help.header = function(){
   return '<h1>ER Bed Status</h1><div id="global">';
} 
   
cm.help.footer = function(){
   return '</div>';
}

cm.help.breadCrumb = function(T){
   return "<hr><a href='#'>Dashboard</a> &gt; "+ T +"<hr>";
}

cm.help.showError = function(Msg){
   $('body').html(cm.help.header() + "<font color='red'>" + Msg + '</font> <p><a href="#">Back to dashboard</a>' + cm.help.footer());
}

