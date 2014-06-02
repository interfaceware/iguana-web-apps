if (lib===undefined){
   var lib = {};  
}

lib.help = {}

lib.help.render=function(D){
   console.log(D);
   var H = []; 
   H.push("<div class=intellisenseHelpData>");
   H.push("<h1>" + D.Title + "</h1>");
   H.push("<h2> Usage: </h2>");
   H.push("<div class=\"codeExample\"> <pre class=\"prettyPrint\">" + D.Usage + "</pre>" + "</div>");
   H.push("<p>" + D.Desc + "</p>");
   H.push("<h2> Parameters: </h2>");
   var strBuffer="";
   $.each(D.Parameters, function(key, value){
      for (var key2 in value){
         if (key2 != "Desc"){
            var key = key2;
            if (value[key2].hasOwnProperty('Opt')) {
               key += " [Optional]";
            }
            strBuffer += "<tr><td><b>" + key + "</b></td><td>" + value[key2]["Desc"] + "</td></tr>";
         };
      };
   });
   H.push("<table class=\"Basic\"> <tbody> <tr> <th>Name</th><th>Description</th></tr>" + strBuffer
             + "</tbody></table>");
   strBuffer = "";
   H.push("<h2>Returns:</h2>");
   $.each(D.Returns, function(key, value){
      strBuffer += "<tr><td>" + (key + 1) + "</td><td>"+ value["Desc"] + "</td></tr>";
   });
   console.log(strBuffer);
   H.push("<table class=\"Basic\"> <tbody> <tr> <th>Number</th> <th>Description</th></tr>" + strBuffer +
          "</tbody></table>");
   strBuffer="";
   $.each(D.Examples, function(key, value){
      strBuffer = strBuffer + value;
   });
   H.push("<h2>Examples:</h2>" + strBuffer);
   strBuffer = "";
   
   H.push("<div class=\"codeExample\">" + strBuffer + "</div>");
   H.push("<h2>See Also:</h2>");
   $.each(D.SeeAlso, function(key, value){
      console.log(value["Title"]);
      console.log(value["Link"]);
      strBuffer += "<li><a target=\"_blank\" href=\"" + value["Link"] + "\">" + value["Title"]+ "</a></li>";
   });
   H.push("<ol>" + strBuffer + "</ol>");
   strBuffer = "";
   H.push("</div>");
   return H.join('');
}

