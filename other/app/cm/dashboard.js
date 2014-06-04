// This page handles the main dashboard

PAGE.listChannels = function() {
   var H = cm.help.header();
   H += "<hr>Dashboard</hr>&nbsp;<span class='settings'><a href='#Page=viewRepo'>Repositories</a></span>";
   H += '<div id="channels_list">'
   H += '<div id="message"></div>'
   H += '<table id="channels_list_table" cellpadding="0" cellspacing="0" border="0"></table>'
   H += "</div><p><a href='#Page=addChannel'>Add Channel</a>" + cm.help.footer();
   $('body').html(H);

   $.post(
      "list-channels",
      function(Data) {
        Results = Data;
        $("#channels_list_table").dataTable(Results);
      }
   );
}

PAGE.default = PAGE.listChannels;