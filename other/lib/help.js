if (lib===undefined){
   var lib = {};  
}

if (!Array.prototype.last){
    Array.prototype.last = function(){
        return this[this.length - 1];
    };
};

lib.help = {}

function textHelper(type, D){
   var rtn = $('<div/>', {
      class: 'help' + type + ' hidden',
      html: '<h2>' + type + ':</h2>'
      });
   var strBuffer = "";

   // Handles description and usage
   if(type == 'Desc' || type == 'Usage'){
      if (D.hasOwnProperty(type)){
         strBuffer = D[type];
         rtn.removeClass('hidden');
      };
      if (type == 'Desc') {rtn.html('<h2>Description:</h2><p>' + strBuffer + '</p>');}
      else {rtn.append('<div class=\"codeExample\"> <pre class=\"prettyPrint\">' + strBuffer + "</pre>" + "</div>"); }
   }
   // Handles parameters
   else if(type == 'Parameters'){
      if(D.hasOwnProperty(type)){
         $.each(D.Parameters, function(key, value){
            for (var key2 in value){
               if (key2 != "Desc"){
               var key = key2;
               if (value[key2].hasOwnProperty('Opt')) {
                  key += " [Optional]";
               }
               strBuffer += "<tr><td><b>" + key + "</b></td><td>" + value[key2]["Desc"] + "</td></tr>"
         ;};};});
         rtn.removeClass('hidden');
      }
      rtn.append('<table class="Basic"> <tbody> <tr> <th>Name</th><th>Description</th></tr>' + strBuffer + '</tbody></table>');
      }
   else if(type == 'Returns'){
      if(D.hasOwnProperty(type)){
          $.each(D.Returns, function(key, value){
            strBuffer += "<tr><td>" + (key + 1) + "</td><td>"+ value["Desc"] + "</td></tr>";
          });
          rtn.removeClass('hidden');
      }
      rtn.append('<table class="Basic"> <tbody> <tr> <th>Number</th> <th>Description</th></tr>' + strBuffer +
          '</tbody></table>');
   }
   else if(type == 'Examples'){
      if(D.hasOwnProperty(type)){
         $.each(D.Examples, function(key, value){
         strBuffer = strBuffer + value;
         });
         rtn.removeClass('hidden');
      }
      rtn.append('<div class="codeExample">' + strBuffer + '</div>');
   }
   else if(type == 'SeeAlso'){
      if(D.hasOwnProperty(type)){
         $.each(D.SeeAlso, function(key, value){
            strBuffer += "<li><a target=\"_blank\" href=\"" + value["Link"] + "\">" + value["Title"]+ "</a></li>";
         });
         rtn.removeClass('hidden');
      }
      rtn.append('<ol>' + strBuffer + '</ol>');
   }
   return rtn;
}

lib.help.render=function(D){
   var H = [];
   H.push($('<h1/>', {
      html: D.Title
   }));
   H.push(textHelper('Desc', D));
   H.push(textHelper('Usage', D));
   H.push(textHelper('Parameters', D));
   H.push(textHelper('Returns', D));
   H.push(textHelper('Examples',D));
   H.push(textHelper('SeeAlso', D));
   var rtn = $('<div/>', {
      class: 'intellisenseHelpData'
   });
   var arrayLength = H.length;
   for (var i = 0; i < H.length; i++){
      rtn.append(H[i]);
   }
   return rtn;
}
