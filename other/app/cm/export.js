// I purposely build up the HTML directly to keep local control
if (!app.cm.export) {app.cm.export = {}};

PAGE.exportChannel = function(Params) {
   $.post("listRepo",function (repolist){
      if (repolist.length == 0){
         var H =cm.help.header() + cm.help.breadCrumb('Export Channel') +
             "You do not have any repositories defined.  No problem, <a href='#Page=viewRepo'>just go and configure some.</a>" + cm.help.footer();  
         $('body').html(H);
         return;
            }
      $.post("list-channels",function (Data) {
         var H = cm.help.header();
         H += cm.help.breadCrumb('Export Channel');
         H += '<div>Export Channel into' + app.cm.repo.fillSelect(repolist) +'</div>';
         H += '<table id="exporttable" cellpadding="0" cellspacing="0" border="0"></table>';
         H += "<span class='button performexport'>Export</span>";
         H += cm.help.footer();
         $('body').html(H);
         console.log(Data);
         RawData = Data;
         var TD = {};
         TD.aoColumns = [{'sTitle' : 'Export', 'sType' : 'html', "sWidth" : "20px"},
                         {"sTitle" : "Channel Name", "sWidth" : "28em" },                      
                         {'sTitle' : 'Type',   'sType' : 'string', "sWidth" : "4em"},                         
                         {'sTitle' : 'Sample Data', 'sWidth' : '20px'}];  
         TD.aaData = [];
         for (var i=0; i < RawData.name.length; i++){
            TD.aaData[i] = [];
            TD.aaData[i][0] = '<input type="checkbox" class="channel">';
            TD.aaData[i][1] = '<div class="channelname">' + RawData.name[i] + '</div>';
            TD.aaData[i][2] = '<div class="chan-type"><div class="' + RawData.source[i] + '"></div><div class="FILTER"></div><div class="' + RawData.destination[i] + '"></div></div>';
            TD.aaData[i][3] = '<input type="checkbox" class="sampledata">';
         };
         TD.iDisplayLength = 20
            TD.sDom = 'ftip'
               lib.datatable.addSearchHighlight(TD);  
         $("#exporttable").dataTable(TD);
         $('.performexport').click(function (Caller){
            var exportlist = {'repo' : cm.settings.repository, 'data' : []};                             
            console.log($('.channel:checked').parents('tr'));
            $('.channel:checked').parents('tr').each(function(key, val){             
               var channel = {'name' : $(this).find('.channelname').text(), 
                              'sample_data' : $(this).find('.sampledata').is(':checked')};
               exportlist.data.push(channel);
            });
            if (exportlist.data.length == 0) {
               $('#global').append('<span class="error">No channel selected</span>');
               setTimeout(function(){$('.error').remove();}, 2000);
               return false;
            }
            console.log(exportlist);
            document.location.hash="#Page=exportSummary&Data=" + JSON.stringify(exportlist);
         });
      });
   });
}; 

app.cm.export.generateTree = function (Data, Tree){
   for (var i = 0; i < Data.length; i ++) {
      if (Data[i].type == 'folder') {
         var branch = Tree.add(Data[i].name, null, Callback);
         branch.ref = Data[i];
         app.cm.export.generateTree(Data[i].data,branch);
      }
      //if (Data[i].type == 'file')
      else {
         Tree.add(Data[i].name, null, Callback).ref = Data[i];
      }
   }
};

app.cm.export.mostUpToDate = function (Node){
   var Rtn = "";
   if (Node.type == "str") {
      if (Node.foss) {
         Rtn = Node.foss;
      }
      else if (Node.trans){
         Rtn = Node.trans;
      }
      else if (Node.old){
         Rtn = Node.old;
      }
   }
   else {
      Rtn = "data";
   }
   return Rtn;
};

app.cm.export.compressFileTree = function (Data){
   var rtn = {};
   for (var i = 0; i < Data.length; i++){
      if($(Data[i].node).is(':checked')){
         if (Data[i].type == 'folder') {
            rtn[Data[i].name] = app.cm.export.compressFileTree(Data[i].data);
         } else {
            rtn[Data[i].name] = app.cm.export.mostUpToDate(Data[i]);
         }
      }
   }
   return rtn;
};

PAGE.exportSummary = function(Params){
   var H = cm.help.header() + cm.help.breadCrumb("<a href='#Page=exportChannel'>Export Channel</a> &gt; Review Export");
   H += cm.help.loadWheel('Fetching Data...');
   H += cm.help.footer();
   $('body').html(H);
   $.post("exportDiff", Params.Data, function (Data){
      console.log(Data);
      D = Data.data;
      if (D.length == 0) {
         $('#global').append('Already up-to-date! <p><a href="#">Return to dashboard</a></p>');
         $('body').find('figure.loading').remove();
         return;
            }
      var H ="<span class='target'>Exporting to " + Data.target + "</span>"; 
      H += "<div class='data'><div class='treepane'></div><div class='diffpane'><div class='leftpane'></div><div class='middlepane'></div><div class='rightpane'></div></div></div>";
      $('#global').append(H);
      $('body').find('figure.loading').remove();
      for (var i = 0; i < D.length; i++){
         console.log(Callback);
         var tree = new Tree22(D[i].name, null, Callback);
         tree.ref= D[i];
         app.cm.export.generateTree(D[i].data, tree);
         $('.treepane').append($('<div/>', {class : 'Tree'}));
         tree.render($('.treepane').children('div:last'));
         tree.open();
      }; 
      $('.data').append("<span class='button confirmexport'>Confirm</span>");
      $('#global').on('click', '.confirmexport', function(){
         $('.data').html(cm.help.loadWheel('Exporting...'));
         var filetree = {};
         for (var i = 0; i < D.length; i++){
            console.log(D[i]);
            var tree  = {};
            tree.name = D[i].name;  
            tree.data = app.cm.export.compressFileTree(D[i].data);
            filetree = $.extend(filetree, tree);
         }
         console.log(filetree);
         var result =  JSON.stringify({target : Data.target, data : filetree});
         console.log(result);
         $.post("exportChannels", result, function(D){
            console.log(D);
            $('.data').html("Export " + D.status + "<p><a href='#'>Return to dashboard</a>");
            
         });   
      });
   });
};

PAGE.exportResults = function(Params){
   $('body').html(cm.help.header() + cm.help.breadCrumb("Export Results") + cm.help.loadWheel('Please Wait...') + cm.help.footer());   
};

PAGE.exportChannelComplete = function(Params){
   $('body').html(cm.help.header() + cm.help.breadCrumb('Export Channel') + "Exported " + Params.Name + " successfully.<p><a href='#'>Return to dashboard</a>" + cm.help.footer());
};
