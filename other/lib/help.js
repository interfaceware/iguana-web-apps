if (lib===undefined){
   var lib = {};  
}

if (!Array.prototype.last){
    Array.prototype.last = function(){
        return this[this.length - 1];
    };
};

lib.help = {};
lib.help.render = {};

lib.help.render.all=function(D, Title){
   console.log(D);
   var H = [];
   H.push("<div class='intellisenseHelpData'>");
   H.push('<h1>' + Title.replace("/", ".") + '</h1>');
   if (D.hasOwnProperty('SummaryLine')){
      H.push('<h2>Summary Line</h2><p>' + D.SummaryLine + "</p>");
   }
   if (D.hasOwnProperty('Desc')){
      H.push('<h2>Description</h2><p>' + D.Desc + "</p>");
   }
   if (D.hasOwnProperty('Usage')){
      H.push('<h2>Usage</h2><div class="codeExample"><pre>' + D.Usage + '</pre></div>');
   }
   if (D.hasOwnProperty('Parameters')){
      H.push('<h2>Parameters</h2><table class="Basic"> <tbody> <tr> <th>Name</th><th>Description</th></tr>');
      for (var i =0; i < D.Parameters.length; i++){
         var Param = D.Parameters[i];
         for (K in Param){
            H.push('<tr><td><b>' + K) 
            if(Param[K].hasOwnProperty('Optional')){
               H.push(' Optional');
            }
            H.push('</b></td><td>' + Param[K]["Desc"] + "</td></tr>");
         }
      }
      H.push('</table>');
   }
   if (D.hasOwnProperty('Returns')){
      H.push("<h2>Returns:</h2><table class='Basic'><tbody><tr><th>Number></th><th>Description</th></tr>");
      for (var i = 0; i < D.Returns.length; i++) {
         H.push( "<tr><td>" + (i + 1) + "</td><td>"+ D.Returns[i]["Desc"] + "</td></tr>");
      };
      H.push("</tbody></table>");
   }
   if (D.hasOwnProperty('Examples')){
      H.push("<h2>Examples:</h2><div class='codeExample'>");
      for (var i = 0; i < D.Examples.length; i++){
         H.push(D.Examples[i]);
      };
   }
   if (D.hasOwnProperty('SeeAlso')){
      H.push("<h2>See Also:</h2><ol>");
      for (var i = 0; i < D.SeeAlso.length;i++){
         H.push("<li><a target='_blank' href='" + D.SeeAlso[i]["Link"] + "'>" +  D.SeeAlso[i]["Title"]+ "</a></li>");
      };
      H.push("</ol></div>");
   }
   return H.join('');
}
   
lib.help.render.edit=function(D){
   var H = [];
   
   H.push('Hello world');
   return H.join('');
}
   
//The following code is to send data back to the server
//Keep in mind that there is no controls or error checking, so the user can enter anything. Implement future controls here

// Iterates through the tables of Parameters and Returns, creating an array of objects.
function iterate (table){
   var rtn = [];
   $(table).children(':gt(0)').each(function(index, value){
      var obj = {};
      if ($(table).parents('div').hasClass('helpParameters')){
         var name = $(value).children(':eq(0)').text();
         if (name == ""){return}
         obj[name] = {Desc : $(value).children(':eq(1)').text()};
         if ($(value).find('input').is(':checked')) {
            obj[name]["Optional"] = 'true';
         }
      }
      else {
         if(name == ""){return}
         obj.Desc = $(value).children(':eq(1)').text()
      }
      rtn[index] = obj;
   });
   return rtn;
}  
