// Javascript pertaining to importing channels   
app.cm.addChannelListRender = function(Data){
   var H = cm.help.header() + cm.help.breadCrumb('Add Channel') + "Add Channel from " + app.cm.repo.fillSelect(Data.repository) + "<ol>" ; 
   List = Data.list;
   for (var i = 0; i < List.length; i++){
      H += "<li><a href='#Page=confirmAddChannel&With=" + List[i] + "'>" + List[i] + "</a></li>";
   }
   H += "</ol>" + cm.help.footer();
   return H;
}

PAGE.addChannel = function(Params) {
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
         var H = app.cm.addChannelListRender(Data);
         $('body').html(H)
            
         $('.repolist').change(".repolist", function(E){
            // TODO we might want to use a 'proper' MVC framework later.
            cm.settings.repository = $(".repolist")[0].selectedIndex;
            $('body').html(cm.help.header() + cm.help.breadCrumb('Add Channel') + "<p>Retrieving data...</p>" + cm.help.footer());
            PAGE.addChannel(Params);
         });      
      }
   );
}


PAGE.confirmAddChannel = function(Params) {
   var H = cm.help.header() + cm.help.breadCrumb('Confirm Add Channel') + "Add Channel " + Params.With + " with definition from " + Params.With + "?";
   H += "<p><a href='#Page=executeAddChannel&Name=" + Params.With + "&With=" + Params.With + "'>Do it!</a>"; 
   H += cm.help.footer();
   $('body').html(H);     
}
   
PAGE.executeAddChannel = function(Params) {
   $.post("addChannel", {'name' : Params.Name, 'with' :Params.With, 'repository' : cm.settings.repository},
      function (Data) {
         document.location.hash = "#Page=addChannelComplete&Name=" + Params.Name + "&With=" + Params.With;
      }
   );   
}
   
PAGE.addChannelComplete = function(Params) {
   $('body').html(cm.help.header() + cm.help.breadCrumb('Added Channel') + "Added " + Params.Name + " successfully with definition from " + Params.With + ".<p><a href='#'>Return to dashboard</a>" + cm.help.footer())   
}

/*
PAGE.replaceChannel = function(Params) {
   lib.ajax.call("importList", function (Data) {
      console.log(Data);
      var H =cm.help.header() + cm.help.breadCrumb('Replace Channel') + "Replace Channel " + Params.Name + " with:<ol>" ;  
      for (var i = 0; i < Data.length; i++){
          H += "<li><a href='#Page=confirmReplaceChannel&Name=" + Params.Name + "&With=" + Data[i] + "'>" + Data[i] + "</a></li>";
      }
      H += "</ol>" + cm.help.footer();
      $('body').html(H);        
   });
}
   
PAGE.confirmReplaceChannel = function(Params) {
   var H = cm.help.header() + cm.help.breadCrumb('Confirm Replace Channel') + "Replace Channel " + Params.Name + " with " + Params.With + "?";
   H += "<p><a href='#Page=executeReplaceChannel&Name=" + Params.Name + "&With=" + Params.With + "'>Do it!</a>"; 
   H += cm.help.footer();
   $('body').html(H);
}
      
PAGE.executeReplaceChannel = function(Params) {
   lib.ajax.call("replaceChannel?name=" + Params.Name + "&with=" + Params.With,
      function (Data) {
         document.location.hash = "#Page=replaceChannelComplete&Name=" + Params.Name + "&With=" + Params.With;
   });
}
 
PAGE.replaceChannelComplete = function(Params) {
   $('body').html(cm.help.header() + cm.help.breadCrumb('Replaced Channel') + "Replaced " + Params.Name + " successfully with " + Params.With + ".<p><a href='#'>Return to dashboard</a>" + cm.help.footer())   
}*/
