PAGE.detail=function(R){
   clearInterval(app.TimerId);
   var H = monitor.help.header();
   H+="<div id='detail'>";
   H+="<a href='#'>Back to main view</a>";
   H+="<div id='details_time'></div>";
   H+="<div id='channel_list'><table id='channels_table' cellpadding='0' cellspacing='0' border='0'></table></div>";
   H+="<div id='server_info_list'><table id='server_info' cellpadding='0' cellspacing='0' border='0'></table></div>";
   H+= monitor.help.footer();
   $('body').html(H);

   lib.ajax.call(
      "detail?guid=" + R.Server,
      function(Data) {
         console.log(Data);
      
         // So the handy thing about jQuery datatables is you can hand in all this great styling information which is what we 
         // are doing with these Params tables.  We add in this extra presentation information on the client side in Javascript
         // and we use the jQuery extend call to add in the extra presentation information.
         lib.datatable.addSearchHighlight(Data.ChannelsInfo); 
         var ChannelTableParams = {
            aLengthMenu: [[25, 50, 75], [25, 50, 75]],
            iDisplayLength: 25
         };
         $('#channels_table').dataTable($.extend(Data.ChannelsInfo, ChannelTableParams));
      
         var ServerTableParams = {
            bAutoWidth: false,
            bPaginate: false,
            bFilter: false,
            bInfo: false,
         };
         $('#server_info').dataTable($.extend(Data.ServerInfo, ServerTableParams));

         // TODO - Eliot for some reason the layout of the tables look a hell of lot nicer after the first update.
         // I need to understand why but for now...
         app.monitor.detail.update(Data);

         app.TimerId = setInterval(function(){
            lib.ajax.call("detail?guid=" + R.Server, app.monitor.detail.update);
         }, 3000);
      }
   );
}

app.monitor.detail = {}

app.monitor.detail.update=function(Data){
   console.log(Data);
   // grab the existing table and update it. it's fun!
   // Eliot - TODO - this strikes me as generic functionality (Note the Copy-Paste OO Pattern ;-) 
   // I suspect also we stop it flickering if we only change cells which
   // have actually see a change in data.
   // Also as it stands this code could be 'interesting' when you remove rows from the source data etc.
   var ServerTbl = $('#server_info').dataTable();
   for (var i = 0; i < Data.ServerInfo.aaData.length; i++) {
      ServerTbl.fnUpdate(Data.ServerInfo.aaData[i], i);
   }
   var ChannelsTbl = $('#channels_table').dataTable();
   for (var i = 0; i < Data.ChannelsInfo.aaData.length; i++) {
      ChannelsTbl.fnUpdate(Data.ChannelsInfo.aaData[i], i);
   }
   $("#details_time").html('Last update: <span>' + Data.Info.AsString + '</span>');
}


