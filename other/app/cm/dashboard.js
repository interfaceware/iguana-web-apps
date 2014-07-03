// This page handles the main dashboard

PAGE.listChannels = function() {
   var H = cm.help.header();
   H += "<hr>Dashboard</hr> <a href='#Page=viewRepo'><span class='button' id='repositories'>Repositories</span></a>";
   H += '<div id="channels_list">';
   H += '<div id="message"></div>';
   H += '<table id="channels_list_table" cellpadding="0" cellspacing="0" border="0"></table>';
   H += '<table id="selected_channels"></table>';
   H += "<div class='importexport'><a href='#Page=exportChannel'><span class='button exportchannel'>Export Channel</span></a><a href='#Page=addChannel'><span id='add-channel'></span></a></div>";
   H += "</div>" + cm.help.footer();
   $('body').html(H);
   
   $.post(
      "list-channels",
      function(Data) {
         console.log(Data);
         
         var RawData = Data;
         var TD = {};
         TD.aoColumns = [{'sTitle' : '<input type="checkbox" class="selectall>', "sWidth" : "1em"},
                         {"sTitle" : "Channel Name", "sWidth" : "28em" },
                         {'sTitle' : 'Status', 'sType' : 'html', "sWidth" : "6em"},
                         {'sTitle' : 'Type',   'sType' : 'string', "sWidth" : "4em"}];
            
         TD.aaData = [];
         for (var i=0; i < RawData.name.length; i++){
            TD.aaData[i] = [];
            TD.aaData[i][0] = '<input type="checkbox" class="selectone">';
            TD.aaData[i][1] = RawData.name[i];
            TD.aaData[i][2] = '<div class="chan-' + RawData.status[i] + '"/>';
            TD.aaData[i][3] = '<div class="chan-type"><div class="' + RawData.source[i] + '"></div><div class="FILTER"></div><div class="' + RawData.destination[i] + '"></div></div>';
         };
         lib.datatable.addSearchHighlight(TD);  
         $("#channels_list_table").dataTable(TD);
         $('#selected_channels').dataTable({
            aoColumns : [{"sTitle" : "Channel Name", "sWidth" : "28em" },
                           {"sTitle" : 'Status', 'sType' : 'html', "sWidth" : "6em"},
                           {'sTitle' : 'Type',   'sType' : 'string', "sWidth" : "4em"}],            
            'sDom': 't'
         });
         
      }
   );
};

PAGE.default = PAGE.listChannels;