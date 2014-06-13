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
lib.help.getdata = {};
//Converts JSON to new format
lib.help.render.adapter = function(D){   
   if (D.hasOwnProperty('Parameters')){
      var temp = [];
      for (var i = 0; i < D.Parameters.length; i++){
         var row = {};
         for (var p in D.Parameters[i]){
            row.Name = p;
            row.Desc = D.Parameters[i][p].Desc;
            row.Optional = D.Parameters[i][p].hasOwnProperty('Opt')? "true" : "false";
         }
         temp[i]=row;
      }
      D.Parameters = temp;    
   }
   if (D.hasOwnProperty('Examples')){
      var temp = "";
      for (var i = 0; i < D.Examples.length; i++){
         temp += D.Examples[i].substring(5, D.Examples[i].length - 6);
      }
      D.Examples = temp;
   }
   return D;
}
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
      H.push('<h2>Parameters</h2><div class="Parameters table"> <div class="heading"><div class="cell">Name</div><div class="cell">Description</div><div class="cell">Optional</div></div>');
      for (var i =0; i < D.Parameters.length; i++){
         H.push('<div class="row"><div class="cell Name">' + D.Parameters[i].Name + '</div><div class="cell">' + D.Parameters[i].Desc + '</div><div class="cell">' + D.Parameters[i].Optional + '</div></div>');
      }
      H.push('</div>');
   }
   if (D.hasOwnProperty('Returns')){
      H.push('<h2>Returns:</h2><div class="Returns table"><div class="heading"><div class="cell">Number</div><div class="cell">Description</div></div>');
      for (var i = 0; i < D.Returns.length; i++) {
         H.push( '<div class="row"><div class="cell">' + (i + 1) + '</div><div class="cell">'+ D.Returns[i]["Desc"] + '</div></div>');
      };
      H.push("</div>");
   }
   if (D.hasOwnProperty('Examples')){
      H.push("<h2>Examples:</h2><div class='codeExample'><pre>");
      for (var i = 0; i < D.Examples.length; i++){
         H.push(D.Examples[i]);
      };
      H.push("</pre></div>");
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
   var possiblestring = ['SummaryLine', 'Desc', 'Usage', 'Parameters', 'Returns', 'Examples', 'SeeAlso'];   
   for (var i = 0; i < possiblestring.length; i++){
      if (D.hasOwnProperty(possiblestring[i])){ continue; };
      if (i < 3) {
         D[possiblestring[i]] = "";
      }
      else {D[possiblestring[i]] = []}
   }
   H.push("<div class='intellisenseHelpData'>");
   H.push('<h1>' + D.Title.replace("/", ".") + '</h1>');
   H.push('<h2>Summary Line</h2><p class="editable data" data-id ="SummaryLine">' + D.SummaryLine + "</p>");
   H.push('<h2>Description</h2><p class="editable data" data-id="Desc">' + D.Desc + "</p>");
   H.push('<h2>Usage</h2><div class="codeExample"><p class ="editable data" data-id="Usage">' + D.Usage + '</p></div>');
   H.push('<h2>Parameters</h2><div class="table data" data-id="Parameters"> <div class="heading"><div class="cell">Name</div><div class="cell">Description</div><div class="cell">Optional</div></div>');
   for (var i =0; i < D.Parameters.length; i++){
      H.push('<div class="row"><div class="cell editable essential" data-param="Name">' + D.Parameters[i].Name + '</div><div class="cell editable" data-param="Desc">' + D.Parameters[i].Desc + '</div><div class="cell" data-param="Optional">');
      if (D.Parameters[i].Optional == 'true'){
         H.push('<input type="checkbox" checked>');
      }
      else {
         H.push('<input type="checkbox">');
      }
      H.push('</div><div class="deletebtn">Delete</div></div>');
   }
   H.push('</div><div class="add">Add</div>');
   H.push('<h2>Returns:</h2><div class="data table" data-id="Returns"><div class="heading"><div class="cell">Description</div></div>');
   for (var i = 0; i < D.Returns.length; i++) {
         H.push('<div class="row"><div class="cell editable essential" data-param="Desc">'+ D.Returns[i]["Desc"] + '</div><div class="deletebtn">Delete</div></div>');
   };
   H.push('</div><div class="add")">Add</div>');
   H.push("<h2>Examples:</h2><div class='codeExample'><p class='editable data' data-id='Examples'>");
   for (var i = 0; i < D.Examples.length; i++){
      H.push(D.Examples[i]);
   };
   H.push('</p></div>');
   H.push('<h2>See Also:</h2><div data-id="SeeAlso" class="table data"><div class="heading"><div class="cell">Label</div><div class="cell">Address</div></div>');
   for (var i = 0; i < D.SeeAlso.length;i++){
      H.push('<div class="row"><div class="cell editable essential" data-param="Title">' + D.SeeAlso[i].Title + '</div><div class="cell editable" data-param="Link">' + D.SeeAlso[i].Link + '</div><div class="deletebtn">Delete</div></div>');
   };
   H.push('</div><div class="add">Add</div>');
   return H.join('');
}
   
//The following code is to send data back to the server
//Keep in mind that there is no controls or error checking, so the user can enter anything. Implement future controls here
//Converts JSON to old format
lib.help.getdata.adapter = function (D){
   if (D.hasOwnProperty('Parameters')){
      var temp = [];
      for (var i = 0; i < D.Parameters.length; i++){
         var row = {};
         var param = {};
         var location = D.Parameters[i];
         console.log(location);
         param.Desc = location.Desc;
         if (location.Optional == "true") {
            param.Opt = true;
         } 
         row[location.Name] = param;
         temp[i]=row;
      }
      D.Parameters = temp;    
   }
   if (D.hasOwnProperty('Examples')){
      var temp = [];
      temp[0] = ('<pre>' + D.Examples + '</pre>');
   }
   return D;
}   
   
/* Iterates throgh a table made up of <div>, and creates an array of objects, 
   where each entry in the array correspondes to each row.
   Each array entry has a collection of parameters in the form {id : data}, 
   where id is the value for 'data-param', and data is text within the cell.*/
lib.help.getdata.table = function (table){
   var rtn = [];
   var tableid = $(table).attr('data-id');
 
   $(table).find('.row').each(function (index, val){
      var obj = {};
      $(val).find('div').each(function (i, v){
         obj[$(v).attr('data-param')] = $(v).text();
      });
      rtn[index] = obj;    
   });
   return rtn;
}
/* Finds all tags with the attribute 'data-id', and stores the text within that 
   tag in an object with parameter name being the value of 'data-id'*/
lib.help.getdata.all = function (heading, d){
   $(heading).each(function(key, value){
      var id = $(value).attr('data-id');
      if ($(value).hasClass('table')){      
         d[id] = lib.help.getdata.table(value);
      }
      else {
         d[id] = $(value).text();
      }
   });
}
   
lib.help.addrow = function (caller){
   var list={
      Parameters : $('<div>', {
         class : 'row',
         html : '<div class="cell editable essential" data-param="Name" contenteditable="true">' + 
               '</div><div class="cell editable" data-param="Desc" contenteditable="true"></div><div class="cell" data-param="Optional"><input type="checkbox"></div><div class="deletebtn">Delete</div>'
      }),
      Returns : $('<div>', {
         class : 'row',
         html : '<div class="cell editable essential" data-param="Desc" contenteditable="true"></div><div class="deletebtn">Delete</div>'
      }),
      SeeAlso : $('<div>', {
         class : 'row',
         html : '<div class="cell editable essential" data-param="Title" contenteditable="true"></div><div class="cell editable" data-param="Link" contenteditable="true"></div><div class="deletebtn">Delete</div>'
      })};
   var table = $(caller).prev();
   $(table).append(list[$(table).attr('data-id')].clone()); 
}
lib.help.savedata=function(){    
   //Removes white space from the front and the back of the data
   $('.editable').each(function(key, val){
      $(this).html($.trim($(val).text()));
   });    
   //Checks that all essential boxes are not empty
   console.log($('.essential:empty'));
   $('.essential:empty').each(function(key, val) {
      console.log(val);
      if($(val).next().text() != ""){
         $(val).text('undefined');
      }
      else {
         $(val).parent().remove();
      }
   });
   //Changes the inputboxes into text form
   $('div[data-param|="Optional"]').each(function(key, val){
      if ($(val).children().is(':checked')){
         $(val).html('true');
      }
      else
         $(val).html('false');
   });
   console.log($('[data-param|="Optional"]'));
   
   //Removes delete button
   $('.deletebtn').remove();
   //Initializes the data object, and fills it with information.
   var d = {};
   lib.help.getdata.all('.data', d);
   d["Title"] = $(".intellisenseHelpData").find('h1').text().replace('.','/');
   //Looks through data, and deletes empty sections.
   for (var prop in d){
      if (typeof(d[prop]) == "string" && d[prop] == ""){
         delete d[prop];
         continue;
      }
      else if ($.isArray(d[prop]) && (d[prop].length < 1 || d[prop][0]=="")){
         delete d[prop];
         continue;
      }
   }
   
   //Determines if ParameterTable should be true
   d["ParameterTable"] = d.hasOwnProperty('Parameters') ? true : false;
   return d;  
}                              
