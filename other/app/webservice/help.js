if (webservice === undefined){
   var webservice = {};
}

webservice.help = {};
   
webservice.help.header = function(){
   return '<h1>Webservice Browser</h1><div id="global">';
} 
   
webservice.help.footer = function(){
   return '</div>';
}

webservice.help.showError = function(Msg){
   $('body').html(webservice.help.header() + "<font color='red'>" + Msg + '</font> <p><a href="#">Back to dashboard</a>' + webservice.help.footer());
}

