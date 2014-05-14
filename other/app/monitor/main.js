// This is the main page of the monitor GUI it draws the top level dashboard
// All the main init code is here together with helpers.

// For the detail page, that code is in detail.js.  In general it helps to keep
// each source file manageable in size.

$(document).ready(function(){
   console.log('Load page handling framework');
   lib.page.init(app.monitor.page);
   lib.ajax.errorFunc = monitor.help.showError;
});
                  
var app = {};
app.monitor = {};
app.monitor.page = {};

PAGE = app.monitor.page;

PAGE.main = function(){  
   clearInterval(app.TimerId); 
   var H = monitor.help.header();
   H+= "<div id='chart'>";
   H+= "<table id='summary' cellpadding='0' cellspacing='0' border='0'></table>";
   H+= "</div>";
   H+= "<div id='time'></div>";
   H+= monitor.help.footer();
   $('body').html(H);

   lib.ajax.call(
      "summary", 
      function(Data) {
        lib.datatable.addSearchHighlight(Data); 
        $("#summary").dataTable(Data);
        // For the first run I call app.monitor.main.update immediately
        // so that I get the Last Update populated immediately.
        app.monitor.main.update(Data);
        app.TimerId = setInterval(function(){
            lib.ajax.call("summary", app.monitor.main.update);
        }, 3000);
      }
   );
}

PAGE.default = PAGE.main;

app.monitor.main = {}
      
app.monitor.main.update=function(Data){
   // grab the existing table and update it. it's fun!
   // TODO - we have the Copy/Paste pattern here.  Like the detail refresh we
   // might want to consider only changed cells which have changed.
   var Control = $("#summary").dataTable();
   for (var i = 0; i < Data.aaData.length; i++) {
      Control.fnUpdate(Data.aaData[i], i);
   }
   lib.datatable.hideNavigationArrows(Control, Data);
   $("#time").html('Last update: <span>' + Data.Info.AsString + '</span>');
}

