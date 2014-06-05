if (lib===undefined){
   var lib = {};  
}

if (!Array.prototype.last){
    Array.prototype.last = function(){
        return this[this.length - 1];
    };
};

lib.help = {}

/* 
The following is an imcompleted implementation of table control that automatically creates new rows
var newline = $('<tr/>',
   {
      html: '<td class="editable b" contenteditable="true"></td><td class="editable" contenteditable="true"></td><td/>',
      onkeydown: 'addline(this)',
      class: 'empty'
   });

var cross = $('<img/>', 
      {  
         class: 'cross',
         src: 'lib/tree/images/arrow-contractable.gif',
         onclick: 'deleteline(this)'
   });

function deleteline(caller){
   console.log($(caller).closest("tbody").children());
  if ($(caller).closest("tbody").children().length != 1) {
      $(caller).closest("tr").remove();
}}


function addline(caller){
   $(caller).focusout(function(){
      var table = $(this).parent();
      if (($(this).filter(':first').text() == "") &&($(this).filter(':eq(2)').text() == "")){
         $(this).addClass('empty');
         $(this).siblings('.empty').remove();   
         }
      }
   );
   var table = $(caller).parent();
   if ($(caller).hasClass('empty')){
      $(caller).removeClass('empty');
      table.append(newline.clone());
      table.filter(':last').children(':last').append(cross.clone());
   }
}
*/

function textHelper(type, D){
   var rtn = $('<div/>', {
      class: 'help' + type + ' hidden',
      html: '<h2>' + type + ':</h2>'
      });
   var strBuffer = "";

   // Handles description and usage
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
   else if(type == 'Returns'){
      if(D.hasOwnProperty(type)){
          $.each(D.Returns, function(key, value){
            strBuffer += "<tr><td>" + (key + 1) + '</td><td class="editable">'+ value["Desc"] + "</td></tr>";
          });
          rtn.removeClass('hidden');
      }
      rtn.append('<table class="Basic"> <tbody> <tr> <th>Number</th> <th>Description</th></tr>' + strBuffer +
          '</tbody></table>');
   }
   //The editable class is added when the data is recieved in page.js
   else if(type == 'Examples'){
      if(D.hasOwnProperty(type)){
         $.each(D.Examples, function(key, value){
         strBuffer = strBuffer +  value; 
         });
         rtn.removeClass('hidden');
      }
      rtn.append('<div class="codeExample">' + strBuffer + '</div>');
   }
   else if(type == 'SeeAlso'){
      if(D.hasOwnProperty(type)){
         $.each(D.SeeAlso, function(key, value){
            strBuffer += '<li class="editable link" ><a target="_blank" href=' + value["Link"] + '>' + value["Title"]+ '</a></li>';
         });
         rtn.removeClass('hidden');
      }
      rtn.append('<ol>' + strBuffer + '</ol>');
   }
   return rtn;
}

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
   var arrayLength = H.length;
   for (var i = 0; i < H.length; i++){
      rtn.append(H[i]);
   }
   return rtn;
}

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

var pnewline = $('<tr/>',
   {
      html: '<td class="editable b" contenteditable="true"></td><td class="editable" contenteditable="true"></td><td><input type="checkbox"></td>',
      
   });
var rnewline = $('<tr/>',
   {
      html: '<td/><td contenteditable="true"></td>'
   });

var snewline = $('<li/>',
   {
      html: '<input type="text" class="linkLabel" placeholder="Link label"><input type="text" class="linkAdd" placeholder="Link address"><img src="lib/tree/images/folder-open.gif" onclick="$(this).parent().remove()"></img>'
   });
var cross = $('<img/>', 
   {  
      class: 'cross',
      src: 'lib/tree/images/folder-open.gif',
      onclick: 'var table = $(this).parents("tbody"); $(this).parent().remove(); if (table.parents("div").hasClass("helpReturns")){renumber(table);}' 
   });
var padd = $('<img/>',
   {
      class: 'add',
      src: 'lib/tree/images/folder-open.gif',
      onclick: 'var table = $(this).siblings("table").find("tbody"); table.append(pnewline.clone()); table.children(":last").append(cross.clone())'
   });

function renumber(table){
   $(table).find('tr:gt(0)').each(function(idx){
      $(this).children().first().html(idx + 1);
   });
}

var radd = $('<img/>',
   {
      class: 'add',
      src: 'lib/tree/images/folder-open.gif',
      onclick: 'var table = $(this).siblings("table").find("tbody"); table.append(rnewline.clone()); table.children(":last").append(cross.clone()); renumber(table)'
   });

var ecross = $('<img/>',
   {  
      // class: 'cross',
      src: 'lib/tree/images/folder-open.gif',
      float: 'right',
      onclick: 'var table = $(this).parents("tbody"); $(this).parent().remove(); if (table.parents("div").hasClass("helpReturns")){renumber(table);}' 
   });

var sadd = $('<img/>',
   {
      class: 'add',
      src: 'lib/tree/images/folder-open.gif',
      onclick: '$(this).siblings("ol").append(snewline.clone())'
   });

function striptags(toplevel){
   $(toplevel).find('span').contents().unwrap();
   $(toplevel).find('pre').contents().unwrap();
   console.log($(toplevel));
   $(toplevel).wrapInner('<pre contenteditable = "true" class="editable"></pre>');
}

function convertlinks(list){
   while(($(list).children().length > 0) && ($(list).find('li:first').children().is('a'))){
      $(list).append(snewline.clone());
      $(list).children(':last').find('.linkLabel').attr('value', $(list).children(':first').find('a').text());
      $(list).children(':last').find('.linkAdd').attr('value', $(list).children(':first').find('a').attr('href'));
      $(list).children(':first').remove();
   }
}

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

function changetoform(){
   var objFields = {}
   var home = $('#helpdata');
   striptags($('.codeExample').find('.helpUsage'));
   striptags($('.helpExamples').find('.codeExample'));
   $('.editable').attr('contenteditable', 'true');
   home.find('tbody').addClass('newline');
   //Adding optional column for Parameters Table
   var ptable = home.find('.helpParameters').find('tbody');
   ptable.find('tr:first').append("<th>Optional</th>");
   ptable.find('tr:gt(0)').append('<td><input type="checkbox"></td>');
   fixparams(ptable);
   $('.helpParameters').append(padd);
   $('.helpParameters').find('tr:gt(0)').find('td:gt(1)').after(cross);
   //Adding controls for Returns Table
   console.log($('.helpReturns').find('tr:gt(0)').find('td:gt(0)').html());
   $('.helpReturns').find('tr:gt(0)').find('td:gt(0)').after(cross.clone());
   $('.helpReturns').append(radd);
   //Stripes example box into a plain <p>
   $('.helpSeeAlso').append(sadd);
   convertlinks($('.helpSeeAlso').find('ol'));
   /*Pretty text
   $('.codeExample').focusin(function(){
      $(this).find('span').contents().unwrap();
      $(this).find('.prettyprinted').removeClass('prettyprinted');
   });
   $('.codeExample').focusout(function(){
      prettyPrint();
   });
   */
   document.execCommand("enableInlineTableEditing", null, false);
   //Change CSS and Add animations
    //home.find('h1').siblings('div').css('opacity', '0.8');
   $(".hidden").fadeIn('slow');
   home.find('h1').siblings('div').hover(function(){
      $(this).addClass('mouseon');
   }, function(){
      $(this).removeClass('mouseon');
   });
  $(".editable").css({'border':'1px dashed gray', 'min-height':'10px'} );
}

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

function changetoview(){
   $('.editable').each(function(key, val){
      $(this).html($.trim($(val).text()));
   });
   $('input[type=text]').each(function(key, val){
      $(this).html($.trim($(val).text()));
   }); 
   var d = {};
   d["Desc"] = $('.helpDesc').find('p').text();
   d["Examples"] = { 0 : $('.helpExamples').find('.codeExample').children().text()};
   if ($('.helpParameters').find('tr:gt(0)')){
      d["ParameterTable"] = true;
      d["Parameters"] = iterate($('.helpParameters').find('tbody'));
   }
   else{d["ParameterTable"] = true;}
   d["Returns"] = iterate($('.helpReturns').find('tbody'));
   d["SeeAlso"] = iterate2($('.helpSeeAlso').find('ol'));
   d["SummaryLine"] =  $(".helpSummaryLine").find('p').text();
   d["Title"] = $(".intellisenseHelpData").find('h1').text();
   d["Usage"] = $('.helpUsage').find('.codeExample').children().text();
   for (var prop in d){
      if (typeof(d[prop]) == "string" && d[prop] == ""){
         delete d[prop];
         continue;
      }
      else if ($.isArray(d[prop]) && d[prop].length < 1){
         delete d[prop];
         continue;
      }
   }
   console.log(d);
   d.call = webservice.state.call;
   lib.ajax.call('setHelp', d, function(Result){ });
}

