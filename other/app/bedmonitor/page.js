$(document).ready(function($) {
   console.log('Load page handling framework.');
   lib.page.init(app.cm.page);
   lib.ajax.errorFunc = cm.help.showError;
});

app = {};
app.cm = {};
cm = app.cm;
app.cm.page = {};

PAGE=app.cm.page;
  
PAGE.listBeds = function() {
   var H = cm.help.header();
   H += '<div id="channels_list">'
   H += '<div id="message"></div>'
   H += '<table id="channels_list_table" cellpadding="0" cellspacing="0" border="0"></table>'
   H +=  cm.help.footer();
   $('body').html(H);


   var Params = {
      url: "list-beds",
      success: function(Data) {
        Results = Data;
        $("#channels_list_table").dataTable($.extend(Results, {bPaginate: false, bInfo: false}));
      }
   };

   $.ajax(Params);

   // After sending the initializing request, we reset the success callback to do updates
   // and then set a timeout to call it every few seconds.

   Params.success = function (Data) {
      var ChannelsTbl = $('#channels_list_table').dataTable();
      var DataLength = Data.aaData.length;
      var TableLength = ChannelsTbl.fnGetData().length;
      var Row = 0;
      for ( ; Row < TableLength; Row++) {
         ChannelsTbl.fnUpdate(Data.aaData[Row], Row);
      }

      for ( ; Row < DataLength; Row++) {
         ChannelsTbl.fnAddData(Data.aaData[Row]);
      };
   };
   
   setInterval(function() {
      $.ajax(Params);
   }, 3000);
}

PAGE.default = PAGE.listBeds;
