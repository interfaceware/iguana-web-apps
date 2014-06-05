$(document).ready(function($) {
   console.log('Load page handling framework');
   lib.page.init(app.cm.page);
   
   $(document).ajaxError(function(Event, Info, Error){
      console.log(Error, Info, Event);
      if (Info.responseJSON) {
         cm.help.showError("Error: " +  Info.responseJSON.error);
      } else {
         cm.help.showError("Call " + Error.url + " failed: " + textStatus + " " + Error);
      }
   });
});

app = {};
app.cm = {};
cm = app.cm;
app.cm.page = {};

PAGE=app.cm.page;

