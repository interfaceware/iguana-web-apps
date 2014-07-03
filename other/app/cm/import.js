// Javascript pertaining to importing channels   
app.cm.addChannelListRender = function(Data){
   var H = cm.help.header() + cm.help.breadCrumb('Add Channel') + "Add Channel from " + app.cm.repo.fillSelect(Data.repository); 
   H += "<table id='listChannels' cellpadding='0' cellspacing='0' border='0'></table>" + cm.help.footer();
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
      TD.aaData[i] = ["<input type='checkbox'>", List.name[i], List.description[i]];
   }
   console.log(TD);
   lib.datatable.addSearchHighlight(TD);
   $("#listChannels").dataTable(TD); 
}   
   
PAGE.addChannel = function(Params) {
   $('body').html(cm.help.header() + cm.help.breadCrumb('Add Channel') + cm.help.loadWheel('Fetching Data...') + cm.help.footer());
   $.post("importList",
      {'repository': cm.settings.repository },
      function (Data) {
         console.log(Data);
         if (Data.err){
            var H =cm.help.header() + cm.help.breadCrumb('Add Channel');
            H += 'The repository directory ' + Data.dir + ' does not exist.';
            H += '<p>No problem - we just need to <a href="#Page=viewRepo">configure that</a>.</p>'
            H += cm.help.footer();
            $('body').html(H);
            return;
         }
         app.cm.addChannelListRender(Data);
            
         $('.repolist').change(".repolist", function(E){
            // TODO we might want to use a 'proper' MVC framework later.
            cm.settings.repository = $(".repolist")[0].selectedIndex;
            $('body').html(cm.help.header() + cm.help.breadCrumb('Add Channel') + cm.help.loadWheel('Fetching Data...') + cm.help.footer());
            PAGE.addChannel(Params);
         });      
      }
   );
}

PAGE.confirmAddChannel = function(Params) {
   $.post(
      "list-channels",
      function(D){
         console.log(D);
         var ChannelExists = false;
         for (var i=0;i < D.name.length; i++){
            if (D.name[i] === Params.With){
               ChannelExists = true; 
            }
         }
         var H = cm.help.header() + cm.help.breadCrumb('Confirm Add Channel') + "Add Channel " + Params.With + "?";
         if (ChannelExists){
            H += "<span class='warning'>This will result in replacing the existing channel by the same name.</span>";  
         }
         H += "<p><a href='#Page=executeAddChannel&Name=" + Params.With + "&With=" + Params.With + "'><span class='button'>Execute</span></a>"; 
         H += cm.help.footer();
         $('body').html(H);       
   });     
}
   
PAGE.executeAddChannel = function(Params) {
   $.post("addChannel", {'name' : Params.Name, 'with' :Params.With, 'repository' : cm.settings.repository},
      function (Data) {
         document.location.hash = "#Page=addChannelComplete&Name=" + Params.Name + "&With=" + Params.With;
      }
   );   
}
   
PAGE.addChannelComplete = function(Params) {
   $('body').html(cm.help.header() + cm.help.breadCrumb('Added Channel') + "Added " + Params.Name + " successfully.<p><a href='#'>Return to dashboard</a>" + cm.help.footer())   
}
