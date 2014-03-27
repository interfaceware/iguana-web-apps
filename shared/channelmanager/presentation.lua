--[[
This module is required for now until we can edit other file types in the 
Translator. Another approach could be to edit in an external editor and
pull the files in with io.open in order to serve them. 
]]

channelmanager.presentation = {
      
   -- JS --
   ['/channelmanager/behaviour.js']=[==[
   var Results = {};
   var PAGlastHash = "INITIALIZED";
   
   $(document).ready(function($) {
     
     console.log('Ready set load.');
     // Initial setup
     window.onhashchange = PAGonHashChange;
     PAGonHashChange();
   });
   
   function PAGconvertSpaceEncoding(EncodedInput) {
      return EncodedInput.replace(/\+/g, "%20");
   }
   
   function PAGparseAnchorString(AnchorString) {
      var Params = {};
      var Vars = AnchorString.substring(1).split('&');
      for (var i = 0; i < Vars.length; i++) {
         var Parts = Vars[i].split('=');
         if (undefined != Parts[1]) {
            Parts[1] = PAGconvertSpaceEncoding(Parts[1]);
         }
         Params[Parts[0]] = decodeURIComponent(Parts[1]);
      }
      console.log(Params);
      return Params;
   }
   
      
// Controller/Router
   function PAGonHashChange() {
      console.log(document.location);
      if (PAGlastHash == document.location.hash){
         return;
      }
      PAGlastHash = document.location.hash;
      var Hash = document.location.hash;
      var Params = PAGparseAnchorString(Hash);

      var Action = APP[Params.Page];
      console.log(Action);
      if (Action) {
         Action(Params);
      } else {
         console.log("Do default action.");
         APP.default(Params);
     }
   }   

   APP={}
   
   // All actions go into the APP table.
   
   function APPheader(){
      return '<h1>Channel Manager App</h1><div id="global">';
   } 
   
   function APPfooter(){
      return '</div>';
   }
   
   function APPbreadCrumb(T){
      return "<hr><a href='#'>Dashboard</a> &gt; "+ T +"<hr>";
   }

   APP.listChannels = function() {
      var H = APPheader();
      H += "<hr>Dashboard</hr>";
      H += '<div id="channels_list">'
      H += '<div id="message"></div>'
      H += '<table id="channels_list_table" cellpadding="0" cellspacing="0" border="0"></table>'
      H += "</div><p><a href='#Page=addChannel'>Add Channel</a>" + APPfooter();
      $('body').html(H);
   
      $.ajax({
         url: "/channelmanager/list-channels",
         success: function(Data) {
           Results = Data;
           $("#channels_list_table").dataTable(Results);
         }
      });
    }
    APP.default = APP.listChannels;
   
    // I purposely build up the HTML directly to keep local control
    APP.exportSummary = function(Params) {
       $.ajax({
        url: "/channelmanager/config_info",
        success: function (Data) {
           console.log(Data);
           var H =APPheader() + APPbreadCrumb('Export Channel') + "Do you want to export Channel <b>" + Params.Name + "</b> into <i>" + Data.ExportPath + "</i>?<br><a href='#Page=executeExportChannel&Name=" + Params.Name + "'>Yes!</a>" + APPfooter();  
           $('body').html(H);        
        }
       });
     }
   
     APP.executeExportChannel = function(Params){
        $.ajax({
           url: "/channelmanager/export_channel?name=" + Params.Name,
           success: function (Data) {
              document.location.hash = "#Page=exportChannelComplete&Name=" + Params.Name;
           }
        });
     }
   
     APP.exportChannelComplete = function(Params){
        $('body').html(APPheader() + APPbreadCrumb('Export Channel') + "Exported " + Params.Name + " successfully.<p><a href='#'>Return to dashboard</a>" + APPfooter()) 
     }
   
    APP.replaceChannel = function(Params) {
        $.ajax({
        url: "/channelmanager/importList",
        success: function (Data) {
           console.log(Data);
           var H =APPheader() + APPbreadCrumb('Replace Channel') + "Replace Channel " + Params.Name + " with:<ol>" ;  
           for (var i = 0; i < Data.length; i++){
              H += "<li><a href='#Page=confirmReplaceChannel&Name=" + Params.Name + "&With=" + Data[i] + "'>" + Data[i] + "</a></li>";
           }
           H += "</ol>" + APPfooter();
           $('body').html(H);        
        }
       });
     }
   
   APP.confirmReplaceChannel = function(Params) {
      var H = APPheader() + APPbreadCrumb('Confirm Replace Channel') + "Replace Channel " + Params.Name + " with " + Params.With + "?";
      H += "<p><a href='#Page=executeReplaceChannel&Name=" + Params.Name + "&With=" + Params.With + "'>Do it!</a>"; 
      H += APPfooter();
      $('body').html(H);
   }
   
   APP.executeReplaceChannel = function(Params) {
      $.ajax({
         url: "/channelmanager/replaceChannel?name=" + Params.Name + "&with=" + Params.With,
         success: function (Data) {
            document.location.hash = "#Page=replaceChannelComplete&Name=" + Params.Name + "&With=" + Params.With;
         }
     }); 
   }
   
   APP.replaceChannelComplete = function(Params) {
      $('body').html(APPheader() + APPbreadCrumb('Replaced Channel') + "Replaced " + Params.Name + " successfully with " + Params.With + ".<p><a href='#'>Return to dashboard</a>" + APPfooter())   
   }
   
   APP.addChannel = function(Params) {
        $.ajax({
        url: "/channelmanager/importList",
        success: function (Data) {
           console.log(Data);
           var H =APPheader() + APPbreadCrumb('Add Channel') + "Add Channel from:<ol>" ;  
           for (var i = 0; i < Data.length; i++){
              H += "<li><a href='#Page=confirmAddChannel&With=" + Data[i] + "&Name=" + Params.Name +"'>" + Data[i] + "</a></li>";
           }
           H += "</ol>" + APPfooter();
           $('body').html(H);        
        }
       });
   }
   
   APP.confirmAddChannel = function(Params) {
      var H = APPheader() + APPbreadCrumb('Confirm Add Channel') + "Add Channel " + Params.With + " with definition from " + Params.With + "?";
      H += "<p><a href='#Page=executeAddChannel&Name=" + Params.With + "&With=" + Params.With + "'>Do it!</a>"; 
      H += APPfooter();
      $('body').html(H);     
   }
   
   APP.executeAddChannel = function(Params) {
      $.ajax({
         url: "/channelmanager/addChannel?name=" + Params.Name + "&with=" + Params.With,
         success: function (Data) {
            document.location.hash = "#Page=addChannelComplete&Name=" + Params.Name + "&With=" + Params.With;
         }
     });   
   }
   
   APP.addChannelComplete = function(Params) {
      $('body').html(APPheader() + APPbreadCrumb('Added Channel') + "Added " + Params.Name + " successfully with definition from " + Params.With + ".<p><a href='#'>Return to dashboard</a>" + APPfooter())   
   }
    
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
   <title>Iguana Channel Manager App</title>
   </head>
   <body>
   <!-- body is purposely blank -->
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

