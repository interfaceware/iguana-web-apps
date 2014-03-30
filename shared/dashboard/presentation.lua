local present = {}

local Html=[[
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css">
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/2.1.0/jquery.min.js"></script>
<script type="text/javascript" charset="utf8" src="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="/monitor/dashboard.js"></script>
<link rel="stylesheet" type="text/css" href="/monitor/dashboard.css">
<link type="text/css" rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800">
<title>Global Dashboard</title>
</head>
<body></body>
</html>
]]

function present.main()
   return Html
end

function present.template(Name, Content)
   Name = Name:gsub("/", "_")
   if iguana.isTest() then
      for K,V in pairs(present.ResourceTable) do
         K = K:gsub("/", "_")
         local F = io.open(K, 'w+')
         F:write(V);
         F:close()   
      end
   else
      local F = io.open(Name, 'r')
      if (F) then
         Content = F:read('*a');
         F:close()
      end
   end
   return Content
end

function present.loadOther(FileName)
   trace(iguana.project.files())
   FileName = iguana.project.files()["other/"..FileName:sub(10)]
   if not FileName then
      return nil
   end
   local F = io.open(FileName, "rb")
   local C = F:read("*a")
   F:close()
   return C
end
-- 

present.ResourceTable={
 ['/monitor/dashboard.css']=[[

#server_info div.mywrapper {
    width: 33.33%;
    float: left;
}
   
body {
    background-color: #eff1e8;
    font-family: 'Open Sans',sans-serif;
    font-size: 12pt;
    padding: 0px;
    margin: 0px;
}

h1 {
    font-size: 2.8em;
    font-weight: 700;
    text-align: center;
    padding: 35px 0px 25px 0px;
    background: -webkit-linear-gradient(#a5db58, #7bc144) #a5db58;
    background: -o-linear-gradient(#a5db58, #7bc144) #a5db58;
    background: -moz-linear-gradient(#a5db58, #7bc144) #a5db58;
    background: linear-gradient(#a5db58, #7bc144) #a5db58;
    color: #FFFFFF;
    text-shadow: #264504 0px 1px 2px;
    box-shadow: #888888 0px 1px 1px;
}

#main {
    background: none repeat scroll 0 0 #FCFCFC;
    border: 1px solid #DDDDDD;
    border-radius: 5px;
    margin: 10px;
    padding: 20px;
}

#chart, #time {
    margin: 0px auto;
    display: block;
    width: 80%;
}
   
#time {
   padding: 4px 0 0 0;
   text-align: right;
}

#time span {
   font-weight: bold;
}
#detail {
    display: none;
    padding: 30px;
}
div.dataTables_wrapper {
    background-color: #FFFFFF;
    border: 1px solid #DDDDDD;
    border-radius: 5px;
    box-shadow: none;
    overflow: hidden;
    padding: 15px 15px 10px 15px;
}

.dataTables_length label,
.dataTables_filter label {
    color: #777777;
    letter-spacing: 0.05em;
    font-size: 0.85em;
    text-transform: uppercase;
    font-weight: 600;
}

input {
    border: 1px solid #DDDDDD;
    height: 20px;
}

#summary {
    width: 100% !important;
    border-collapse: separate;
    border-color: #DDDDDD;
    border-image: none;
    border-style: solid solid solid none;
    border-width: 1px 1px 1px 0px;
    margin: 36px 0px 10px 0px;
}

#summary thead {
    background-color: #FAFAFA;
    background-image: linear-gradient(to bottom, #FAFAFA, #EFEFEF);
    box-shadow: none;
    height: 36px;
    overflow: hidden;
    color: #444444;
}

#summary thead th {
    border-bottom: 0px solid #FFFFFF;
}

#summary thead th {
    border-left: 1px solid #DDDDDD;
}
#summary thead th:first-child {
    border-left: 1px solid #DDDDDD;
}

#summary thead th:last-child {
    border-right: 0px solid #DDDDDD;
}

#summary_info.dataTables_info {
    float: left;
    min-width: 30%;
}
   
th {
    font-size: 0.75em;
    font-weight: 600 !important;
    text-transform: uppercase;
    letter-spacing: 0.15em;
}

td {
    font-size: 0.9em;
    font-weight: 300;
    border-top: 1px solid #DDDDDD;
    border-left: 1px solid #DDDDDD;
}

table.dataTable td {
    padding: 5px 10px;
}

table.dataTable tr.odd {
    background-color: #FFFFFF;
}

table.dataTable tr.even {
    background-color: #F9F9F9;
}

table.dataTable tr.odd td.sorting_1 {
    background-color: #f3fafc;
}

table.dataTable tr.even td.sorting_1 {
    background-color: #e7f4f9;
}

.status-green {
    width:10px;
    height:10px;
    border-radius:50px;
    background:linear-gradient(to bottom, #a6e182, #54c600);
    border: 2px solid #FFFFFF;
    margin: 0px auto;
}

.status-red {
    width:10px;
    height:10px;
    border-radius:50px;
    background:linear-gradient(to bottom, #f5896e, #da2300);
    border: 2px solid #FFFFFF;
    margin: 0px auto;
}

.status-grey {
    width:10px;
    height:10px;
    border-radius:50px;
    background:linear-gradient(to bottom, #C1C1C1, #B2B2B2);
    border: 2px solid #FFFFFF;
    margin: 0px auto;
}

.status-yellow {
    width: 10px;
    height: 10px;
    border-radius: 50px;
    background: linear-gradient(to bottom, #FFF159, #E9DC51);
    border: 2px solid #FFFFFF;
    margin: 0px auto;
}

.dataTables_info, #time {
    text-transform: uppercase;
    padding: 10px;
    color: #777777;
    letter-spacing: 0.05em;
    font-size: 0.85em;
    font-weight: 600;
}

div#summary_paginate {
    text-transform: uppercase;
    color: #777777;
    letter-spacing: 0.05em;
    font-size: 0.8em;
    font-weight: 600;
}

.paginate_disabled_previous,
.paginate_enabled_previous,
.paginate_enabled_previous:hover,
.paginate_disabled_next,
.paginate_enabled_next,
.paginate_enabled_next:hover {
    background: none;
}

a#summary_previous:before
{
    content: "\2190 \A0";
}

a#summary_previous {
    border: 1px solid #DDDDDD;
    border-bottom-left-radius: 4px;
    border-left-width: 1px;
    border-top-left-radius: 4px;
    padding: 8px 10px 3px 10px;
    background: #FFFFFF;
}

a#summary_next:after
{
    content: "\A0 \2192";
}

a#summary_next {
    border: 1px solid #DDDDDD;
    border-bottom-right-radius: 4px;
    border-right-width: 1px;
    border-top-right-radius: 4px;
    border-left: none;
    padding: 8px 10px 3px 10px;
    background: #FFFFFF;
    margin-left: 0px;
}

.alarm {
   color: #da2300;
   font-weight: bold;
}
.filterMatches {
   background-color: #ffffaa;
}

#channels_table_wrapper, #server_info_wrapper { width: 800px; }
]];
   
['/monitor/dashboard.js']=[==[

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
   <div id="detail" style="display:none;"><a href="/monitor">Back to main view</a>\
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
      //(function fetchDetails() {
      //DetailParams.complete = fetchDetails;
      TimeoutID = setInterval(function() {
         $.ajax(DetailParams);  
      }, 6000);
      //})();
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

]==];
   
}

-- Setup Gifs for Dashboard.
--present.ResourceTable['/monitor/status-red.gif'] = LoadWebImage('/images/button-dotgreenv4.gif')

return present