// This page handles the main dashboard

PAGE.listChannels = function() {
   var H = cm.help.header();
   H += "<hr><div class = 'toplbuttons'>Dashboard</div>";
   H += "<div class='toprbuttons'> <a href='#Page=viewUpdate'><span class='button updatecm'>Update Channel Manager </span></a><span class='button updaterepo'>Update GitHub Repos</span>" 
   H += "<a href='#Page=viewRepo'><span class='button' id='repositories'>Repositories</span></a></div>";
   H += '<div id="channels_list">';
   H += '<div id="message"></div>';
   H += '<table id="channels_list_table" cellpadding="0" cellspacing="0" border="0"></table>';
   H += '<table id="selected_channels"></table>';
   H += "<div class='importexport'><a href='#Page=exportChannel'><span class='button exportchannel'>Export Channel</span></a><a href='#Page=importChannel'>";
   H += "<span id='add-channel'></span></a></div>";
   H += "</div>" + cm.help.footer();
   $('body').html(H);
   
   $.post(
      "list-channels",
      function(Data) {
         console.log(Data);
         
         var RawData = Data;
         var TD = {};
         TD.aoColumns = [//{'sTitle' : '<input type="checkbox" class="selectall>', "sWidth" : "1em"},
                         {"sTitle" : "Channel Name", "sWidth" : "28em" },
                         {'sTitle' : 'Status', 'sType' : 'html', "sWidth" : "6em"},
                         {'sTitle' : 'Type',   'sType' : 'string', "sWidth" : "4em"}];
            
         TD.aaData = [];
         for (var i=0; i < RawData.name.length; i++){
            TD.aaData[i] = [];
            //TD.aaData[i][0] = '<input type="checkbox" class="selectone">';
            TD.aaData[i][0] = RawData.name[i];
            TD.aaData[i][1] = '<div class="chan-' + RawData.status[i] + '"/>';
            TD.aaData[i][2] = '<div class="chan-type"><div class="' + RawData.source[i] + '"></div><div class="FILTER"></div><div class="' + RawData.destination[i] + '"></div></div>';
         };
         TD.iDisplayLength = 20
         TD.sDom = 'ftip'
         lib.datatable.addSearchHighlight(TD);  
         $("#channels_list_table").dataTable(TD);
         /*$('#selected_channels').dataTable({
            aoColumns : [{"sTitle" : "Channel Name", "sWidth" : "28em" },
                           {"sTitle" : 'Status', 'sType' : 'html', "sWidth" : "6em"},
                           {'sTitle' : 'Type',   'sType' : 'string', "sWidth" : "4em"}],            
            'sDom': 'fti'
         });*/
         
      }
   );
   $('.updaterepo').click(function(){
      $('<div/>', {'class' : 'overlay'}).appendTo('body');
      $('body').append('<div class = "overlaywidget">' + cm.help.loadWheel('Updating Repos...') + '</div>');
      $.get("updateRepo", function (Data){
         if (!(Data.err)){
            $('.overlaywidget').html('Success! Click anywhere to continue!');
            $('body').click(function (){
               $('.overlaywidget, .overlay').remove();
               $('body').unbind('click');
            });
         }
         else {
            $('.overlaywidget').html('While ' + Data.state + ' :<br>' + Data.err + '<br> Click anywhere outside this textbox to continue!');
            $('.overlay').click(function(){
               $('.overlaywidget, .overlay').remove();
               $('.overlay').unbind('click');
            });
      }});
   });
};

PAGE.default = PAGE.listChannels;
