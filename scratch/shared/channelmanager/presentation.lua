--[[
This module is required for now until we can edit othe file types in the 
Translator. Another approach could be to edit in an external editor and
pull the files in with io.open in order to serve them. 
]]

local ResourceTable = {
      
   -- JS --
   ['/channelmanager/behaviour.js']=[==[
   var Results = {};
   jQuery(document).ready(function($) {

     // Initial setup
   
     listChannels();
     //exportChannel('2542DA64E3C4288514B9DD8B1C69AFAA')
     // Handlers
   
     function listChannels() {
       $("#export_summary").hide();
       $.ajax({
         url: "/channelmanager/list-channels",
         success: function(Data) {
           Results = Data;
           $("#channels_list_table").dataTable(Results);
         }
       });
     }

     function exportSummary(Guid) {
       $.ajax({
         url: "/channelmanager/export-summary?channel=" + Guid,
         success: function (Data) {
           $("#channels_list").hide();
           $("#export_summary").show();
           $("#channel_name").text(Data.ChannelName);
           $("#to_path").text(Data.ExportPath);
           $("#to_path").after(Data.ConfirmBtn);
         }
       });
     }
   
     function exportChannel(Guid) {
       $.ajax({
         url: "/channelmanager/export-channel?channel=" + Guid,
         success: function (Data) {
           $("#channels_list").hide();
           $("#export_summary").show();   
         }
       });
     }
   
     function importSummary(Guid) {
       $.ajax({
         url: "/channelmanager/import-summary?channel=" + Guid,
         success: function (Data) {
           $("#channels_list").hide();
           $('#global').append('\
             <div id="import_summary">\
               <div id="message"></div>\
               <div id="summary">\
                 <span id="channel_name">' + Data.ChannelName + '</span> From <span id="from_path">' + Data.ExportPath + '</span>\
                 <div id="files_list"></div>' 
                 + Data.ConfirmBtn + 
               '</div>\
             </div>');
       }
       });
     }
   
     function importChannel(Guid) {
       $.ajax({
         url: "/channelmanager/import-channel?channel=" + Guid,
         success: function (Data) {
           $("#channels_list").hide();
           $("#import_summary").show();
       }
       });
     }
     
     // Controller/Router
   
     window.onhashchange = function() {
       console.log(document.location);
       var Hash = document.location.hash;
       if (Hash.length) {
         var Parts = Hash.split("&");
         var Action = Parts.shift();
         // TODO - make this into a hash table
         switch (Action) {
           case "#export-summary":
             exportSummary(Parts[0].split("=")[1]);
           break;
           case "#export-channel":
             exportChannel(Parts[0].split("=")[1]);
           break;
           case "#import-summary":
             importSummary(Parts[0].split("=")[1]);
           break;
           case "":
           break;
           case "#import-channel":
             importChannel(Parts[0].split("=")[1]);
           case "":
           break;
         }
       } 
     }
   });
   ]==];
   
   -- HTML --
   ['/channelmanager/index.html']=[==[
   <!DOCTYPE html>
   <html>
   <head>
   <link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css">
   <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/2.1.0/jquery.min.js"></script>
   <script type="text/javascript" charset="utf8" src="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>
   <script type="text/javascript" src="/channelmanager/behaviour.js"></script>
   <link rel="stylesheet" type="text/css" href="/channelmanager/styles.css">
   <link type="text/css" rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800">
   <title>Channel Manager App</title>
   </head>
   <body>
   <h1>Channel Manager App</h1>
   <div id="global">
     <div id="channels_list">
       <div id="message"></div>
       <table id="channels_list_table" cellpadding="0" cellspacing="0" border="0"></table>
     </div>
   
     <!-- TODO lets generate screens from pure Javascript -->
     <div id="export_summary">
       <div id="message"></div>
       <div id="summary">
         <span id="channel_name"></span> To <span id="to_path"></span>
         <div id="files_list></div>
       </div>
     </div>     
   </body>
   </html>
   ]==];
   
   -- CSS --
   ['/channelmanager/styles.css']=[==[
   
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
   
   #global, #channels_list {
   background: none repeat scroll 0 0 #FCFCFC;
   border: 1px solid #DDDDDD;
   border-radius: 5px;
   margin: 10px;
   padding: 20px;
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
   width: 120px; /* fix me */
   }
   
   table.dataTable td {
   padding: 5px 10px;
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

   ]==];
}

return ResourceTable