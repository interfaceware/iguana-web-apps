// Javascript pertaining to importing channels   
app.cm.importChannelListRender = function(Data){
   var H = cm.help.header() + cm.help.breadCrumb('Add Channel') + "Add Channel from " + app.cm.repo.fillSelect(Data.repository); 
   H += "<table id='listChannels' cellpadding='0' cellspacing='0' border='0'></table>" + cm.help.footer();
   H += "<span class='button performimport'>Import</span>";
   $('body').html(H);
   
   // We take plainly formatted JSON data from the server and reformat it into the form liked by the jQuery datatable.
   var TD= {}
   TD.aoColumns = [];
   TD.aoColumns = [{"sTitle" : "Import", "sWidth" : "5em"}, 
                   {"sTitle" : "Channel Name", "sWidth" : "19em" }, 
                   {"sTitle" : "Description"}]
   TD.aaData    = [];
   List = Data.list;
   TD.aaData = [];
   for (var i = 0; i < List.name.length; i++){
      TD.aaData[i] = ["<input type='checkbox' class='channel'>","<p class='channelname'>" + List.name[i] + "</p>", List.description[i]];
   }
   console.log(TD);
   lib.datatable.addSearchHighlight(TD);
   $("#listChannels").dataTable(TD); 
}   
   
PAGE.importChannel = function(Params) {
   $('body').html(cm.help.header() + cm.help.breadCrumb('Add Channel') + cm.help.loadWheel('Fetching Data...') + cm.help.footer());
   $.post("importList",
      {'repository': cm.settings.repository },
      function (Data) {
         console.log(Data);
         if (Data.err){
            var H =cm.help.header() + cm.help.breadCrumb('Add Channel');
            H += '<p>While ' + Data.state + ':</p>';
            H += '<p>' + Data.err + '</p>';
            H += cm.help.footer();
            $('body').html(H);
            return;
         }
         app.cm.importChannelListRender(Data);
          
         $('.repolist').change(".repolist", function(E){
            // TODO we might want to use a 'proper' MVC framework later.
            cm.settings.repository = $(".repolist")[0].selectedIndex;
            $('body').html(cm.help.header() + cm.help.breadCrumb('Add Channel') + cm.help.loadWheel('Fetching Data...') + cm.help.footer());
            PAGE.importChannel(Params);
         });      
          $('.performimport').click(function (Caller){
            var importlist = {'repo' : cm.settings.repository, 'data' : []};                             
            console.log($('.channel:checked').parents('tr'));
            $('.channel:checked').parents('tr').each(function(key, val){             
               var channel = {'name' : $(this).find('.channelname').text()};
               importlist.data.push(channel);
            });
            if (importlist.data.length == 0) {
               $('#global').append('<span class="error">No channel selected</span>');
               setTimeout(function(){$('.error').remove();}, 2000);
               return false;
            }
            console.log(importlist);
            document.location.hash="#Page=importSummary&Data=" + JSON.stringify(importlist);
         });
      }
   );
}

PAGE.importSummary = function (Params){
   var H = cm.help.header() + cm.help.breadCrumb("<a href='#Page=addChannel'>Import Channel</a> &gt; Review Import");
   H += cm.help.loadWheel('Fetching Data...');
   H += cm.help.footer();
   $('body').html(H);   
   $.post('importDiff', Params.Data, function (Data){
      console.log(Data);
      var D = Data.data;
      if (D.length == 0) {
         $('#global').append('Already up-to-date! <p><a href="#">Return to dashboard</a></p>');
         $('body').find('figure.loading').remove();
         return;
      } 
      var H ="<span class='target'>Importing from " + Data.target + "</span>"; 
      H += "<div class='data'><div class='treepane'></div><div class='diffpane'><div class='leftpane'></div><div class='rightpane'></div></div></div>";
      $('#global').append(H);
      $('body').find('figure.loading').remove();
      for (var i = 0; i < D.length; i++){
         console.log(Callback);
         var tree = new Tree22(D[i].name, null, Callback);
         tree.ref= D[i];
         app.cm.help.generateTree(D[i].data, tree);
         $('.treepane').append($('<div/>', {class : 'Tree'}));
         tree.render($('.treepane').children('div:last'));
         tree.open();
      }; 
      $('.treepane').append("<span class='button confirmimport'>Confirm</span>");
      cm.help.tagEvent();           
      $('#global').on('click', '.confirmimport', function(){
         $('.data').html(cm.help.loadWheel('Exporting...'));
         var filetree = [];
         for (var i = 0; i < D.length; i++){
            console.log(D[i]);
            var tree  = {};
            tree.name = D[i].name;  
            tree.data = app.cm.help.compressFileTree(D[i].data, 'trans');
            filetree.push(tree);
         }
         var result =  JSON.stringify({target : Data.target, data : filetree});
         $.post("importChannels", result, function(D){
            console.log(D);
            $('.data').html("Import " + D.status + "<p><a href='#'>Return to dashboard</a></p>");          
         });   
      });
   });
}
