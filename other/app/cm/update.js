/*PAGE.update = function (Params){
   //https://localhost:6543/get_server_config
   var H = cm.help.footer() + cm.help.loadWheel('Modefying Channels') + 
      "<iframe src='https://localhost:6543/' id='Server' display='none'></iframe>" + cm.help.footer();
   scripttext = "var XMLhttp = new XMLHttpRequest();" +
                  "XMLhttp.open('GET', 'channel_manager/app/cm/update.html', true, 'admin', 'password');" +
                  "XMLhttp.send();" +
                  "XMLhttp.onreadystatechange = window.parent.postMessage(document.location.href, '*');";
                  /*"$.ajax({url : 'https://localhost:6543/get_channel_config','type' : 'POST','headers' : {'compact' : 'true', 'name' : 'channel_manager'}});" + 
                  "window.parent.postMessage('hello', 'https://localhost:6544/channel_manager/update');" +
                  "function receiveMessage(event) {if (event.origin !== 'https://localhost:6544/channel_manager/update'){return;}};" +
                  "window.addEventListener('message', receiveMessage, false);";
   $('body').html(H);
   var myIframe = document.getElementById("Server");
   var script = myIframe.contentWindow.document.createElement("script");
   script.type = "text/javascript";
   script.text = scripttext;
   myIframe.contentWindow.document.body.appendChild(script);
   //$('<script/>', {html : scripttext}).appendTo('#Server').children('body');
   var Host = window.location.protocol + "//" + window.location.hostname + ":" + window.location.port;
   $.ajax(Host + '/get_channel_config', {
      {'type' : 'POST'},
      {'headers' : {'compact' : 'true', 'guid' : Params.guid}}
   });
   function receiveMessage(event){
      console.log(event);
   }
   window.addEventListener("message", receiveMessage, false);
}

PAGE.update = function (Params){
   $.get('update', function(Data){
      console.log(Data);
   }
}*/
