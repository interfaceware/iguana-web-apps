 // I purposely build up the HTML directly to keep local control
PAGE.exportSummary = function(Params) {
   $.post(
      "listRepo",
      function (Data) {
         console.log(Data);
         var H =cm.help.header() + cm.help.breadCrumb('Export Channel') 
              + "Export Channel <b>" + Params.Name + "</b> into <i>" 
              + app.cm.repo.fillSelect(Data) + "</i>?<br><a href='#Page=executeExportChannel&Name="
              + Params.Name + "'>Yes</a> <a href='#'>Cancel</a>" + cm.help.footer();  
         $('body').html(H);
      }
   );
}

PAGE.executeExportChannel = function(Params){
   $.post("export_channel", {'name' : Params.Name, 'repository' : cm.settings.repository},
       function (Data) {
          document.location.hash = "#Page=exportChannelComplete&Name=" + Params.Name;
       }
   );
}

PAGE.exportChannelComplete = function(Params){
   $('body').html(cm.help.header() + cm.help.breadCrumb('Export Channel') + "Exported " + Params.Name + " successfully.<p><a href='#'>Return to dashboard</a>" + cm.help.footer()) 
}
