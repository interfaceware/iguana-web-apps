$(document).ready(function($) {
   console.log('Load page handling framework');
   lib.page.init(app.cm.page);
   lib.ajax.errorFunc = cm.help.showError;
});

app = {};
app.cm = {};
cm = app.cm;
app.cm.page = {};

PAGE=app.cm.page;
  
PAGE.listChannels = function() {
   var H = cm.help.header();
   H += "<hr>Dashboard</hr>";
   H += '<div id="channels_list">'
   H += '<div id="message"></div>'
   H += '<table id="channels_list_table" cellpadding="0" cellspacing="0" border="0"></table>'
   H += "</div><p><a href='#Page=addChannel'>Add Channel</a>" + cm.help.footer();
   $('body').html(H);

   lib.ajax.call(
      "list-channels",
      function(Data) {
        Results = Data;
        $("#channels_list_table").dataTable(Results);
      }
   );
}

PAGE.default = PAGE.listChannels;

 // I purposely build up the HTML directly to keep local control
PAGE.exportSummary = function(Params) {
   lib.ajax.call(
      "config_info",
      function (Data) {
         console.log(Data);
         var H =cm.help.header() + cm.help.breadCrumb('Export Channel') + "Do you want to export Channel <b>" + Params.Name + "</b> into <i>" + Data.ExportPath + "</i>?<br><a href='#Page=executeExportChannel&Name=" + Params.Name + "'>Yes!</a>" + cm.help.footer();  
         $('body').html(H);        
      }
   );
}

PAGE.executeExportChannel = function(Params){
   lib.ajax.call("export_channel?name=" + Params.Name,
      function (Data) {
         document.location.hash = "#Page=exportChannelComplete&Name=" + Params.Name;
      }
   );
}

PAGE.exportChannelComplete = function(Params){
   $('body').html(cm.help.header() + cm.help.breadCrumb('Export Channel') + "Exported " + Params.Name + " successfully.<p><a href='#'>Return to dashboard</a>" + cm.help.footer()) 
}
   
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
}
   
PAGE.addChannel = function(Params) {
   lib.ajax.call("importList",
      function (Data) {
         console.log(Data);
         var H =cm.help.header() + cm.help.breadCrumb('Add Channel') + "Add Channel from:<ol>" ;  
         for (var i = 0; i < Data.length; i++){
            H += "<li><a href='#Page=confirmAddChannel&With=" + Data[i] + "&Name=" + Params.Name +"'>" + Data[i] + "</a></li>";
         }
         H += "</ol>" + cm.help.footer();
           $('body').html(H);        
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
   lib.ajax.call("addChannel?name=" + Params.Name + "&with=" + Params.With,
      function (Data) {
         document.location.hash = "#Page=addChannelComplete&Name=" + Params.Name + "&With=" + Params.With;
      }
   );   
}
   
PAGE.addChannelComplete = function(Params) {
   $('body').html(cm.help.header() + cm.help.breadCrumb('Added Channel') + "Added " + Params.Name + " successfully with definition from " + Params.With + ".<p><a href='#'>Return to dashboard</a>" + cm.help.footer())   
}
   

