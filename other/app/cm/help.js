if (!app) { app ={}; }
if (!app.cm) { app.cm = {}; }

app.cm.help = {};

cm.help.header = function(){
   return '<h1>Channel Manager</h1><div id="global">';
}; 

cm.help.footer = function(){
   return '</div>';
};

cm.help.breadCrumb = function(T){
   return "<hr><a href='#'>Dashboard</a> &gt; "+ T +"<hr>";
};

cm.help.showError = function(Msg){
   $('body').html(cm.help.header() + "<font color='red'>" + Msg + '</font> <p><a href="#">Back to dashboard</a>' + cm.help.footer());
};

cm.help.loadWheel = function(Msg){
   return '<figure class="loading"><figcaption>' + Msg + '</figcaption>' +
      '<img class="spinner" src="spinner_big_green.gif"> </figure>'
      };

app.cm.help.tagEvent = function(Alias){
   $('.treepane').on('click', '.tag', function(){
      if ($(this).data().isBranch()){
         var Toggle = $(this).hasClass('foss') ? 'repo' : 'foss';
         $(this).parent().find('span.tag').each(function (key, val){
            if ($(val).parent().hasClass('branch')) {
               app.cm.help.toggleTag(val, Toggle, Alias.Branch);}
            else {
               app.cm.help.toggleTag(val, Toggle, Alias.Node);}
         });
      }
      else {
         console.log($(this).data().ref);
         var Toggle = "";
         if ($(this).hasClass('foss')) {
            if ($(this).data().ref.hasOwnProperty('trans')){Toggle = 'trans';}
            else {Toggle = 'repo'}
         }
         else if ($(this).hasClass('trans')) {
            Toggle = 'repo';
         }
         else {Toggle = 'foss'}
         app.cm.help.toggleTag(this, Toggle, Alias.Node);
         if ((Toggle == 'foss')||(Toggle == 'trans')){
            Toggle = 'foss';
            $(this).parents(':gt(0)').children('.tag').each(function(key, val){
               app.cm.help.toggleTag(val, Toggle, Alias.Branch);
            });
         }
      }
      if ($(this).hasClass('none') && (!($(this).parent().find('span.tag').not('.none')))){
         $(this).parent().children('span.tag').trigger('click');
      };
   });
};

app.cm.help.toggleTag = function(TagObj, ToggleTo, Alias){
   TagObj = $(TagObj);
   TagObj.removeClass();
   TagObj.addClass('tag ' + ToggleTo + ' ' + Alias.Class[ToggleTo]).text(Alias.Text[ToggleTo]);
};
   
app.cm.help.generateTree = function (Data, Tree){
   for (var i = 0; i < Data.length; i ++) {
      if (Data[i].type == 'folder') {
         var branch = Tree.add(Data[i].name, null, Callback);
         branch.ref = Data[i];
         app.cm.help.generateTree(Data[i].data,branch);
      }
      else {
         Tree.add(Data[i].name, null, Callback).ref = Data[i];
      }
   }
};

app.cm.help.extractFileData = function (Node, Source){
   var Rtn = {};
   var Tag = "";
   if ($(Source).hasClass('foss')) {Tag = 'foss'} 
   else if ($(Source).hasClass('trans')) {Tag = 'trans'}
   else if ($(Source).hasClass('repo')) {Tag = 'repo'};
   Rtn.type = Node.type;
   Rtn.data = Node[Tag];
   return Rtn;
};

app.cm.help.compressFileTree = function (Data, Ignore){
   var rtn = {};
   for (var i = 0; i < Data.length; i++){
      if(!($(Data[i].tag).hasClass(Ignore))){
         if (Data[i].type == 'folder') {
            rtn[Data[i].name] = {'type' : 'folder', 'data' : app.cm.help.compressFileTree(Data[i].data)};
         } else {
            rtn[Data[i].name] = app.cm.help.extractFileData(Data[i], Data[i].tag);
         }
      }
   }
   return rtn;
};
