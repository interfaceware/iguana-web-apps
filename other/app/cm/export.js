 // I purposely build up the HTML directly to keep local control
PAGE.exportSummary = function(Params) {
   $.post(
      "listRepo",
      function (Data) {
         if (Data.length == 0){
            var H =cm.help.header() + cm.help.breadCrumb('Export Channel') 
              + "You do not have any repositories defined.  No problem, <a href='#Page=viewRepo'>just go and configure some.</a>" + cm.help.footer();  
            $('body').html(H);
            return;
         }
         console.log(Data);
         var H =cm.help.header() + cm.help.breadCrumb('Export Channel') 
              + "<p>Export Channel <b>" + Params.Name + "</b> into <i>" 
              + app.cm.repo.fillSelect(Data) + "</i>?</p>"
              + "<p><span class='label'>Export sample data?</span><input id='sample_data' type='checkbox'></p>"
              + "<p><span id='submit' class='button'>Yes</a></span> <span class='button'><a href='#'>Cancel</a></span>" + cm.help.footer();  
            $('body').html(H);
            $("#submit").click(function(E){
            $.post("export_channel", {'name' : Params.Name, 'repository' : cm.settings.repository, 'sample_data' : $('#sample_data').is(":checked")},
               function (Data) {
                  document.location.hash = "#Page=exportChannelComplete&Name=" + Params.Name;
               }   
            );
         });
      }
   );
}
   
PAGE.exportChannelComplete = function(Params){
   $('body').html(cm.help.header() + cm.help.breadCrumb('Export Channel') + "Exported " + Params.Name + " successfully.<p><a href='#'>Return to dashboard</a>" + cm.help.footer()) 
}
