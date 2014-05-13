var Tank = {};
var DetailsTank = {};

jQuery(document).ready(function($) {
   var ifware = {};
   ifware.TblSrchCache = {};
   ifware.here = document.location;
   
   // Dashboard template
   $("body").html('\
   <h1>Iguana instance monitor</h1>\
   <div id="main">\
      <div id="chart">\
         <table id="summary" cellpadding="0" cellspacing="0" border="0"></table>\
      </div>\
      <div id="time"></div>\
   </div>\
   <div id="detail" style="display:none;"><a href="#">Back to main view</a>\
      <div id="details_time"></div>\
      <div id="channel_list"></div>\
      <div id="server_info_list"></div>\
   </div>\
   ');
   
   // helper functions
   function timer(Info) {
      $("#time").html('Last update: <span>' + Info.AsString + '</span>');
   }
   
   function detailsTimer(Info) {
      $("#details_time").html('Last update: <span>' + Info.AsString + '</span>');
   }
   
   function arrows(Table) {
      var Arrows = $("#summary_paginate a");
      if (Tank.aaData.length < Table.fnSettings()._iDisplayLength) {
         Arrows.hide();
         return;
      }
      Arrows.show();
   }
   
   // setup the summary table
   var Params = {
      url: "/monitor/summary",
      success: function(Data) {
         Tank = Data;
         Tank.fnRowCallback = hl;
         var Tbl = $("#summary").dataTable(Tank);
         arrows(Tbl);
         timer(Tank.Info);     
      }
   };
   
   // send the initial request to populate the summary table
   $.ajax(Params);
   
   // setup a new ajax.success that will update
   Params.success = function(Data) {
      Tank = Data;
      
      // grab the existing table and update it. it's fun!
      var Tbl = $("#summary").dataTable();
      for (var i = 0; i < Tank.aaData.length; i++) {
          Tbl.fnUpdate(Tank.aaData[i], i);
      }
      arrows(Tbl);
      timer(Tank.Info);
   };
   
   // update every 30000
   (function fetch() {
      Params.complete = fetch;
      setTimeout(function() {
         $.ajax(Params);  
      }, 30000);
   })();

   function hl(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
      var searchStrings = [];
      var oApi = this.oApi;
      var oSettings = this.fnSettings();
      var ch = ifware.TblSrchCache;
      if (oSettings.oPreviousSearch.sSearch) {
          searchStrings.push(oSettings.oPreviousSearch.sSearch);
      }
      if ((oSettings.aoPreSearchCols) && (oSettings.aoPreSearchCols.length > 0)) {
         for (i in oSettings.aoPreSearchCols) {
            if (oSettings.aoPreSearchCols[i].sSearch) {
               searchStrings.push(oSettings.aoPreSearchCols[i].sSearch);
            }
         }
      }
      if (searchStrings.length > 0) {
         var sSregex = searchStrings.join("|");
         if (!ch[sSregex]) {
            // This regex will avoid in HTML matches
            ch[sSregex] = new RegExp("("+sSregex+")(?!([^<]+)?>)", 'i');
         }
         var regex = ch[sSregex];
      }
      $('td', nRow).each( function(i) {
         var j = oApi._fnVisibleToColumnIndex( oSettings,i);
         if (aData[j]) {
            if ((typeof sSregex !== 'undefined') && (sSregex)) {
               this.innerHTML = aData[j].replace( regex, function(matched) {
                   return "<span class='filterMatches'>"+matched+"</span>";
               });
            }
            else {
               this.innerHTML = aData[j];
            }
         }
      });
      return nRow;
   };

   //
   // View Functions
   //

   var TimeoutID;

   function showMain() {
      clearInterval(TimeoutID);
      $("#channel_list").html("");
      $("#server_info_list").html("");
      $("#detail").hide();
      $("#main").show();
   }

   function showDetail(Guid) {
      var ServerTableParams = {
         bAutoWidth: false,
         bPaginate: false,
         bFilter: false,
         bInfo: false,
      };
   
      var ChannelTableParams = {
         aLengthMenu: [[25, 50, 75], [25, 50, 75]],
         iDisplayLength: 25
      };

      // make the initial call for details
       var DetailParams = {
         url: "/monitor/detail?guid=" + Guid,
         success: function(Data) {
            DetailsTank = Data;
            console.log(Data);
            Data.ChannelsInfo.fnRowCallback = hl;
            $('#channel_list').html('<table id="channels_table" cellpadding="0" cellspacing="0" border="0"></table>');
            $('#server_info_list').html('<table id="server_info" cellpadding="0" cellspacing="0" border="0"></table>');
            $('#channels_table').dataTable($.extend(Data.ChannelsInfo, ChannelTableParams));
            $('#server_info').dataTable($.extend(Data.ServerInfo, ServerTableParams));
            $("#main").hide();
            $("#detail").show();
            detailsTimer(Data.Info);
         }
      }
   
      $.ajax(DetailParams);
      
      DetailParams.success = function(Data) {
      
         // grab the existing table and update it. it's fun!
         var ServerTbl = $('#server_info').dataTable();
         for (var i = 0; i < Data.ServerInfo.aaData.length; i++) {
            ServerTbl.fnUpdate(Data.ServerInfo.aaData[i], i);
         }

         var ChannelsTbl = $('#channels_table').dataTable();
         for (var i = 0; i < Data.ChannelsInfo.aaData.length; i++) {
            ChannelsTbl.fnUpdate(Data.ChannelsInfo.aaData[i], i);
         }
         // arrows(Tbl);
         detailsTimer(Data.Info);
      };
   
      // update every 30000
      TimeoutID = setInterval(function() {
         $.ajax(DetailParams);  
      }, 6000);
   }
   
   window.onhashchange = function() {
      console.log(document.location);
      var Hash = document.location.hash;
      if (Hash.length) {
   // is something missing from here???
         showDetail(Hash.substr(-32,32));
      } else {
         showMain();
      }
   }
});   
