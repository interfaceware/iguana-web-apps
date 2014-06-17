$(document).ready(function($) {
   console.log('Load page handling framework.');
   lib.page.init(app.cm.page);
   // Switch over to straight jQuery for AJAX
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
         console.log(Data);
         var TD = {};
         TD.bInfo = false;
         TD.bPaginate = false;
         TD.aoColumns = [{ 'sTitle' : 'Bed',       'sType' : 'string'},
                         { 'sTitle' : 'Patient',   'sType' : 'string'},
                         { 'sTitle' : 'Condition', 'sType' : 'string'}];
         TD.aaData = [];
         for (var i=0; i < Data.name.length; i++){
            TD.aaData[i] = [];
            var Row = TD.aaData[i];
            Row[0] = Data.bed[i];
            Row[1] = Data.name[i];
            Row[2] = Data.condition[i];
         }
         console.log(TD);
       
         $("#channels_list_table").dataTable(TD);
      }
   };

   $.ajax(Params);

   // After sending the initializing request, we reset the success callback to do updates
   // and then set a timeout to call it every few seconds.
   Params.success = function (Data) {
      var ChannelsTbl = $('#channels_list_table').dataTable();
      var DataLength = Data.name.length;
      var TableLength = ChannelsTbl.fnGetData().length;
      var i = 0;
      for ( ; i < TableLength; i++) {
         var RowData = [Data.bed[i], Data.name[i], Data.condition[i]];
         ChannelsTbl.fnUpdate(RowData, i);
      }

      for ( ; i < DataLength; i++) {
         var RowData = [Data.bed[i], Data.name[i], Data.condition[i]];
         ChannelsTbl.fnAddData(RowData);
      };
   };
   
   setInterval(function() {
      $.ajax(Params);
   }, 3000);
}

PAGE.default = PAGE.listBeds;
