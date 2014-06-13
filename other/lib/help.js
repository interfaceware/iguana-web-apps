if (lib===undefined){
   var lib = {};  
}

if (!Array.prototype.last){
    Array.prototype.last = function(){
        return this[this.length - 1];
    };
};

lib.help = {};
<<<<<<< HEAD
// Main function to render the help data
function textHelper(type, D){
   var rtn = $('<div/>', {
      class: 'help' + type + ' hidden',
      html: '<h2>' + type + ':</h2>'
      });
   var strBuffer = "";

   // Handles description, usage, and summaryline
   if(type == 'Desc' || type == 'Usage' || type == 'SummaryLine'){
      if (D.hasOwnProperty(type)){
         strBuffer = D[type];
         rtn.removeClass('hidden');
      };
      if (type == 'Desc') {rtn.html('<h2>Description:</h2><p class="editable">' + strBuffer + '</p>');}
      else if (type == 'SummaryLine') {rtn.html('<h2>Summary Line</h2><p class="editable">' + strBuffer + "</p>");}
      else {rtn.append('<div class="codeExample"> <pre>'  + strBuffer + "</pre>" + "</div>"); }
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
               strBuffer += '<tr><td class="editable b"><b>' + key + '</b></td><td class="editable">' + value[key2]["Desc"] + "</td></tr>"
         ;};};});
         rtn.removeClass('hidden');
      }
      rtn.append('<table class="Basic"> <tbody> <tr> <th>Name</th><th>Description</th></tr>' + strBuffer + '</tbody></table>');
      }
   //Handles returns
   else if(type == 'Returns'){
      if(D.hasOwnProperty(type)){
          $.each(D.Returns, function(key, value){
            strBuffer += "<tr><td>" + (key + 1) + '</td><td class="editable">'+ value["Desc"] + "</td></tr>";
          });
          rtn.removeClass('hidden');
=======
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
>>>>>>> 27fc8cafe56e6656ff3e32f02258f341842c4272
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
      H.push("</div>");
   }
<<<<<<< HEAD
   //The editable class is added when the data is recieved in page.js
   else if(type == 'Examples'){
      if(D.hasOwnProperty(type)){
         $.each(D.Examples, function(key, value){
         strBuffer = strBuffer +  value; 
         });
         rtn.removeClass('hidden');
=======
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
>>>>>>> 27fc8cafe56e6656ff3e32f02258f341842c4272
      }
      else {D[possiblestring[i]] = []}
   }
<<<<<<< HEAD
   //Handles the see also links
   else if(type == 'SeeAlso'){
      if(D.hasOwnProperty(type)){
         $.each(D.SeeAlso, function(key, value){
            strBuffer += '<li class="editable link" ><a target="_blank" href=' + value["Link"] + '>' + value["Title"]+ '</a></li>';
         });
         rtn.removeClass('hidden');
=======
   H.push("<div class='intellisenseHelpData'>");
   H.push('<h1>' + D.Title.replace("/", ".") + '</h1>');
   H.push('<h2>Summary Line</h2><p class="editable summaryline">' + D.SummaryLine + "</p>");
   H.push('<h2>Description</h2><p class="editable desc">' + D.Desc + "</p>");
   H.push('<h2>Usage</h2><div class="codeExample"><p class ="editable usage">' + D.Usage + '</p></div>');
   H.push('<h2>Parameters</h2><table class="Basic"> <tbody class = "parameters"> <tr> <th>Name</th><th>Description</th></tr>');
   for (var i =0; i < D.Parameters.length; i++){
      var Param = D.Parameters[i];
      for (K in Param){
         H.push('<tr><td class="editable">' + K + '</td><td class="editable">' + Param[K]["Desc"] + "</td></tr>");
>>>>>>> 27fc8cafe56e6656ff3e32f02258f341842c4272
      }
   }
   H.push('</table>');
   H.push("<h2>Returns:</h2><table class='Basic'><tbody class='returns'><tr><th>Number</th><th>Description</th></tr>");
   for (var i = 0; i < D.Returns.length; i++) {
      H.push( "<tr><td>" + (i + 1) + "</td><td class='editable'>"+ D.Returns[i]["Desc"] + "</td></tr>");
   };
   H.push("</tbody></table>");
   H.push("<h2>Examples:</h2><div class='codeExample'><p class='editable examples'>");
   for (var i = 0; i < D.Examples.length; i++){
      H.push(D.Examples[i]);
   };
   H.push('</p></div>');
   H.push("<h2>See Also:</h2><ol class='seealso'>");
   for (var i = 0; i < D.SeeAlso.length;i++){
      H.push('<li><input type="text" placeholder="Link label" value = "' + D.SeeAlso[i]["Title"] + '"><input type="text" placeholder="Link address" value = "' + D.SeeAlso[i]["Link"] + '"></li>');
   };
   H.push("</ol></div>");
   return H.join('');
}
<<<<<<< HEAD
/* The way the help data information is handled is as follows:
      An array, H, holds all the DOM that is 1 level down from body
      The title is generated first, and it's not editable in edit view
      All the other fields are of the JSON object D is passed into textHelper, 
       which returns a corresponding div for each section. The textHelper does the following:
         1. Determines if no data is provided. If no data, the class 'Hidden' is applied to the div and pushed to H.
         2. Depending on the section, it generates the corresponding html, wrappes it in a 'Editable' class, and utilises strBuffer to maintain the data.
         3. The heading of each section is added on, and the finished html is pushed to H.
      
*/
lib.help.render=function(D, title){
   var H = [];
   H.push($('<h1/>', {
      html: title
   }));
   H.push(textHelper('SummaryLine', D));
   H.push(textHelper('Desc', D));
   H.push(textHelper('Usage', D));
   H.push(textHelper('Parameters', D));
   H.push(textHelper('Returns', D));
   H.push(textHelper('Examples',D));
   H.push(textHelper('SeeAlso', D));
   var rtn = $('<div/>', {
      class: 'intellisenseHelpData'
   });
   // I recall that there was code to concatenate an array of strings, and I think it can be applied here.
   var arrayLength = H.length;
   for (var i = 0; i < H.length; i++){
      rtn.append(H[i]);
   }
   return rtn;
}
//Handles the changing of the edit button and calls the appropiate functions.
lib.help.togglemode=function(Event){
   if (Event.textContent == 'Edit'){
      Event.textContent = 'Save';
      changetoform();
   }
   else {
      Event.textContent = 'Edit';
      changetoview();
   }
}

//Renumbers the return table whenever an adujstment is made to the returns table.
function renumber(table){
   $(table).find('tr:gt(0)').each(function(idx){
      $(this).children().first().html(idx + 1);
   });
}
//Removes all tags left behind by google-prettify   <script type="text/javascript" src="lib/assets.js"></script>
function striptags(toplevel){
   $(toplevel).find('span').contents().unwrap();
   $(toplevel).find('pre').contents().unwrap();
   console.log($(toplevel));
   $(toplevel).wrapInner('<pre contenteditable = "true" class="editable"></pre>');
}
//Converts the links from a tags into two input boxes
function convertlinks(list){
   while(($(list).children().length > 0) && ($(list).find('li:first').children().is('a'))){
      $(list).append(snewline.clone());
      $(list).children(':last').find('.linkLabel').attr('value', $(list).children(':first').find('a').text());
      $(list).children(':last').find('.linkAdd').attr('value', $(list).children(':first').find('a').attr('href'));
      $(list).children(':first').remove();
   }
}
// Finds parameters that have the optional tag, deletes the tag, and checks the corresponding 'optional box'
function fixparams(table){
   $(table).children(':gt(0)').each(function(key, val){
      var name = $(val).children(':eq(0)');
      name.children().contents().unwrap();
      var text = name.text();
      if ((text.length > 10) && (text.slice(text.length - 10) == '[Optional]')){
         name.text(text.slice(0, text.length - 10));
         $(val).find('input').attr('checked', 'true');
      }});
}
// Main function called to make the page editable
function changetoform(){
   var home = $('#helpdata');
   //Removes the google-prettify tags.
   striptags($('.codeExample').find('.helpUsage'));
   striptags($('.helpExamples').find('.codeExample'));
   //Make all DOM objects that have the editable tag actually editable.
   $('.editable').attr('contenteditable', 'true');
   //Adding optional column for Parameters Table
   var ptable = home.find('.helpParameters').find('tbody');
   ptable.find('tr:first').append("<th>Optional</th>");
   ptable.find('tr:gt(0)').append('<td><input type="checkbox"></td>');
   fixparams(ptable);
   $('.helpParameters').append(assets.add.parameter);
   $('.helpParameters').find('tr:gt(0)').find('td:gt(1)').after(assets.del);
   //Adding controls for Returns Table
   $('.helpReturns').find('tr:gt(0)').find('td:gt(0)').after(assets.del.clone());
   $('.helpReturns').append(assets.add.returns);
   //Stripes example box into a plain <p>
   $('.helpSeeAlso').append(assets.add.seealso);
   convertlinks($('.helpSeeAlso').find('ol'));
   //Prevents firefox from allowing users to manipulate tables
   document.execCommand("enableInlineTableEditing", null, false);
   //Change CSS and Add animations
    //home.find('h1').siblings('div').css('opacity', '0.8');
   $(".hidden").fadeIn('slow');
   //Incomplete animation that activates when the corresponding div is mousedover
   home.find('h1').siblings('div').hover(function(){
      $(this).addClass('mouseon');
   }, function(){
      $(this).removeClass('mouseon');
   });
   //Borders the DOM objects so the users knows when an object is editable. Will be supplemented by the above function.
   $(".editable").css({'border':'1px dashed gray', 'min-height':'10px'} );
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
// Only iterates through the see also table, pulling out the links.
function iterate2 (structures){
   var rtn = [];
   $(structures).children().each(function(index, value){
      var obj = {};
      obj.Link = $(value).children(':eq(1)').val();
      if (obj.Link == "") {return}
      obj.Title = $(value).children(':eq(0)').val();
      if (obj.Title == "") {obj.Title=obj.Link}
      rtn[index] = obj;
   });
   return rtn;
}   
// Main function called to send data back to the server
function changetoview(){
   //Removes white space from the front and the back of the data
   $('.editable').each(function(key, val){
      $(this).html($.trim($(val).text()));
   });
   $('input[type=text]').each(function(key, val){
      $(this).html($.trim($(val).text()));
   }); 
   //Initializes the data object, and fills it with information.
   var d = {};
   d["Desc"] = $('.helpDesc').find('p').text();
   d["Examples"] = [$('.helpExamples').find('.codeExample').children().text()];
   if ($('.helpParameters').find('tr:gt(0)')){
      d["ParameterTable"] = true;
      d["Parameters"] = iterate($('.helpParameters').find('tbody'));
   }
   d["Returns"] = iterate($('.helpReturns').find('tbody'));
   d["SeeAlso"] = iterate2($('.helpSeeAlso').find('ol'));
   d["SummaryLine"] =  $(".helpSummaryLine").find('p').text();
   d["Title"] = $(".intellisenseHelpData").find('h1').text();
   d["Usage"] = $('.helpUsage').find('.codeExample').children().text();
=======
   
//The following code is to send data back to the server
//Keep in mind that there is no controls or error checking, so the user can enter anything. Implement future controls here

// Iterates through the tables of Parameters and Returns, creating an array of objects.
                                 
lib.help.savedata=function(){
   function iterate (table){
      var rtn = [];
      $(table).children(':gt(0)').each(function(index, value){
         var obj = {};
         if ($(table).hasClass('parameters')){
            var name = $(value).children(':eq(0)').text();
            if (name == ""){return}
            obj[name] = {Desc : $(value).children(':eq(1)').text()};
            if ($(value).find('input').is(':checked')) {
               obj[name]["Optional"] = 'true';
            }
         } else {
            if (name == "") {return}
            obj.Desc = $(value).children(':eq(1)').text()
         }
         rtn[index] = obj;
      });
      return rtn;
   }  
   // Only iterates through the see also table, pulling out the links.
   function iterate2 (structures){
      var rtn = [];
      $(structures).children().each(function(index, value){
        var obj = {};
        obj.Link = $(value).children(':eq(1)').val();
        if (obj.Link == "") {return}
        obj.Title = $(value).children(':eq(0)').val();
        if (obj.Title == "") {obj.Title=obj.Link}
           rtn[index] = obj;
        });
        return rtn;
   }   
                                          

   //Removes white space from the front and the back of the data
   $('.editable').each(function(key, val){
      $(this).html($.trim($(val).text()));
   });
   $('input[type=text]').each(function(key, val){
      $(this).html($.trim($(val).text()));
   }); 
   //Initializes the data object, and fills it with information.
   var d = {};
   d["Desc"] = $('p .description').text();
   d["Examples"] = $('p .examples').text();
   if ($('.parameters').find('tr:gt(0)')){
      d["ParameterTable"] = true;
      d["Parameters"] = iterate($('.parameters'));
   }
   d["Returns"] = iterate($('.returns'));
   d["SeeAlso"] = iterate2($('.seealso'));
   d["SummaryLine"] =  $(".summaryline").text();
   d["Title"] = $(".intellisenseHelpData").find('h1').text();
   d["Usage"] = $('.usage').text();
>>>>>>> 27fc8cafe56e6656ff3e32f02258f341842c4272
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
<<<<<<< HEAD
   console.log(d);
   d.call = webservice.state.call;
   //Sends the data back to the server
   lib.ajax.call('setHelp', d, function(Result){
   if (Result.hasOwnProperty('status') && Result['status'] == "ok"){
      alert('Function stored!');
   }
   else{ alert('Error');}
   //Re-renders the help data page
   renderdatapage(d.call);
   });
}
=======
   return d;  
}                              
      
>>>>>>> 27fc8cafe56e6656ff3e32f02258f341842c4272
