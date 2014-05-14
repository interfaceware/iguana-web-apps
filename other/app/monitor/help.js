console.log('Begin monitor')
if (!monitor){ 
   var monitor={}; 
}

monitor.help = {};   

monitor.help.header = function(){
   return "<h1>Iguana instance monitor</h1><div id='main'>";
}
 
monitor.help.footer = function(){
   return "</div>";  
}   
   
monitor.help.showError = function(Msg){
   $('body').html(monitor.help.header() + "<font color='red'>" + Msg + '</font> <p><a href="#">Back to dashboard</a>' + monitor.help.footer());      
}