regressions.presentation = {

   ['/regression_tests/index.html']=[[
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css">
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/2.1.0/jquery.min.js"></script>
<script type="text/javascript" charset="utf8" src="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="/regression_tests/scripts.js"></script>
<link rel="stylesheet" type="text/css" href="/regression_tests/styles.css">
<link type="text/css" rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800">
<title>Iguana Regression Tests</title>
</head>
<body></body>
</html>
   ]];
   
   
 ['/regression_tests/styles.css']=[[
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

#global {
    background: none repeat scroll 0 0 #FCFCFC;
    border: 1px solid #DDDDDD;
    border-radius: 5px;
    margin: 10px;
    padding: 20px;   
}

#chart, #time {
    margin: 0px auto;
    padding: 20px 0;
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
   
#detail, #inspect {
    display: none;   
}

#detailchart {
    width: 50%;
    margin: auto;
}
   
#detailmessage {
    padding: 10px;
    margin: 15px 0;
    border 1px solid #ffffff;
}
   
.go {
    border: 1px solid #a5db58;
    color: #79A041;
    background-color: #EEF8E8;
}

.stop, #error {
    padding: 10px;
    margin: 15px 0;
    border: 1px solid #da2300;
    color: #da2300;
    background-color: #F7E5E5;
}

#translatorlink {
    text-align: center;
    padding: 20px;
}

.sample-data {
    font-family: Inconsolata, Menlo, Courier, monospace;
}

del {
    background-color: #F7E5E5;   
}

ins {
    background-color: #EEF8E8;   
}

.line-end {
    font-weight: bold;
    font-size: 1.3em; 
    color: fuchsia;
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

a#summary_next:after {
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

#error {
   margin-top: 10px;
   display: none;
}
   
.alarm {
   color: #da2300;
   font-weight: bold;
}
   
.filterMatches {
   background-color: #ffffaa;
}
   ]];
   
   
   ['/regression_tests/scripts.js']=[[
   
var ifware = {};
ifware.TblSrchCache = {};
ifware.here = document.location;
var Tank = {};
var GreenLight = '<div class="status-green"></div>';
var RedLight = '<div class="status-red"></div>';

jQuery(document).ready(function($) {
   $("body").html('\
   <h1>Iguana Regression Tests</h1>\
   <div id="global">\
      <div id="breadcrumbs"><a href="/regression_tests#">Main</a></div>\
      <div id="error" class="alarm"></div>\
      <div id="main">\
         <div id="chart"></div>\
      </div>\
      <div id="detail"></div>\
      <div id="inspect"></div>\
   ');
   
   $("#chart").html('<table id="summary" cellpadding="0" cellspacing="0" border="0"></table>');
   resetDetail();
   

   var Params = {
      url: "/regression_tests/channels",
      success: function(Data) {
         Tank = Data;
         Tank.fnRowCallback = hl;
         var Tbl = $("#summary").dataTable(Tank);
         arrows(Tbl);
         watchHash();
      }
   };
   $.ajax(Params);
   
   window.onhashchange = watchHash;   
});
   
function watchHash() {
   var Hash = document.location.hash;
   var Vars = {};
   if (Hash.length) {
   console.log("Hash requires action.");
      var Nubbins = Hash.substr(1).split('&');
      for (var i = 0; i < Nubbins.length; i++) {
         var Pieces = Nubbins[i].split('=');

         // The baffy spacing below keeps the Lua extended string quoting intact
         Vars[ Pieces[0] ] = Pieces[1];
      }
   }

   if (Vars.Test) {
      console.log("Hash says test.");
      if (Vars.Inspect) {
        console.log("Hash says inspect.");
         inspectTest(Vars.Inspect, Vars.Test);
         breadcrumbs(Hash, Vars);
         return;
      } else {
         console.log("OK want to run test");
         console.log(Tank);
         doTests(Vars.Test, showDetail);
         breadcrumbs(Hash, Vars);
         return;
      }
   } else {
      showMain();
   } 
}   

function breadcrumbs(Hash, Vars) {
   var OldBc = $('#breadcrumbs *:not(a:first)');
   var NewBc = '';
   if (! Hash.length) {
      OldBc.remove();
      return;
   }
   if (Vars.Test) {
      NewBc = '<span> &gt; </span><a href="#Test=' + Vars.Test + '">' + Tank.Guids[mapGuid(Vars.Test)][1] + '</a>';
      if (Vars.Inspect) {
         NewBc += '<span> &gt; </span><a href="#Inspect=' + Vars.Inspect + '&Test=' + Vars.Test + '">Test #' + Vars.Inspect + '</a>';
      }
   }
   OldBc.remove()
   $('#breadcrumbs').append(NewBc);
}

function checkError(Error, Status, Message) {
   console.log(Error);
   console.log(Error.responseJSON);
   console.log(Error.responseJSON.stack);
   $('#error').html("Error: " + Error.responseJSON.error + ' <a href="/regression_tests">Back to main screen</a>').show();
}

function doTests(Guid, Callback) {
   console.log("Doing Tests.");
   resetDetail();
   var index = mapGuid(Guid);
   console.log(index);
   if (Tank.Guids[index][2]) {
      $.ajax({
         url: "/regression_tests/run_tests?channel=" + Guid +"&name=" + Tank.Guids[index][1],
         success: function(Data) {
            updateDetail(Data, index);
            if (Callback) {
               console.log("Calling back");
               Callback();
            }
         },
         error: checkError
      });
   } else {
      console.log("Need to build");
      offerToBuild(Guid, index, Callback);
   }
}

function updateDetail(Response, index) {
   Tank.Detail = Response;
   var Status = Response.error
                ? RedLight
                : GreenLight;
   var Tbl = $("#summary").dataTable();
   Tbl.fnUpdate(Status, index, 4);
   $("#detailchart").html('<table id="testresult" cellpadding="0" cellspacing="0" border="0"></table>');
   var TestTbl = $("#testresult").dataTable(Tank.Detail);
}

function offerToBuild(Guid, index, Callback) {
   $("#detail").prepend('<h3 id="test_title">Can\'t run tests for ' + Tank.Guids[index][1] + '</h3>\
                        <p>(Need to <a href="' + document.location + '" id="generate">generate a set of expected results first</a>)</p>');
   $("a#generate").click(function(event) {
      event.preventDefault();
      $.ajax({
         url: "/regression_tests/build?channel=" + Tank.Guids[index][3],
         success: function(Data) {
            Tank.Guids[index][2] = true;
            console.log(Tank.Guids[index][2]);
            var Tbl = $("#summary").dataTable();
            Tbl.fnUpdate(GreenLight, index, 3);
            $('#detailmessage').removeClass('go').html('');
            $('#detail h3, #detail p').remove();
            doTests(Guid, showDetail);
         },
         error: checkError
      });
   });
   if (Callback) {
      Callback();
   }
}
   
function inspectTest(SDidx, Guid, Callback) {
   --SDidx;
   if (Tank.Detail && Tank.Detail.Guid == Guid) {
      updateInspection(Guid, SDidx);
      $('#main').hide();
      $('#detail').hide();
      $('#inspect').show();
   } else {
      doTests(Guid, function() {
         if (! Tank.Detail.Res) {
            // Must be missing the expected result set.
            document.location.hash = '#Test=' + Guid;
         } else {
            updateDetail(Tank.Detail, SDidx);
            updateInspection(Guid, SDidx);
            $('#main').hide();
            $('#detail').hide();
            $('#inspect').show();
         }
      });
   }
}

function updateInspection(Guid, SDidx) {
   $('#inspect').html('<div id="translatorlink">' + Tank.Detail.Res[SDidx].EditLink + '</div>\
                       <div id="expected" class="sample-data"><h3>Expected result:</h3><span id="youcanchangethis" contenteditable="true">' + Tank.Detail.Res[SDidx].Exp + '</span></div>\
                       <div id="actual" class="sample-data"><h3>Actual result:</h3>' + diffString(Tank.Detail.Res[SDidx].Exp, Tank.Detail.Res[SDidx].Act) + '</div>');
   $('#youcanchangethis').blur(function() {
      if ($(this).text() != Tank.Detail.Res[SDidx].Exp) {
         console.log("Will update expected results.");
         var NewExp = $(this).html().replace(/ <span class="line-end">(\\n|\\r)<\/span><br> /gm, '<span class=\"line-end\">$1</span><br>');
         $(this).html(NewExp);
         changeExpected(Guid, SDidx, $(this).text());
         Tank.Detail.Res[SDidx].Exp = $(this).text();
      }
   });
}

function changeExpected(Guid, SDidx, NewText) {
   var i = mapGuid(Guid);
   var Data = {
      't_guid': Tank.Guids[i][3],
      'sd_idx': SDidx,
      'txt': NewText 
   };
   $.ajax({
      url: '/regression_tests/edit_result',
      type: 'POST',
      data: Data,
      dataType: 'json',
      success: function() {
         console.log("Expected result changed.");
      },
      error: checkError
   });
}   
   
function arrows(Table) {
   var Arrows = $("#summary_paginate a");
   if (Tank.aaData.length < Table.fnSettings()._iDisplayLength) {
      Arrows.hide();
      return;
   }
   Arrows.show();
}
   
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

function showMain() {
   $("#detail").hide();
   $("#inspect").hide();
   $("#main").show();
   resetDetail();
}

function showDetail() {
   $("#main").hide();
   $("#inspect").html('').hide();
   $("#detail").show();
}

function resetDetail() {
   $("#detail").html('<h3></h3><div id="detailmessage"></div><div id="detailchart"></div>');
   Tank.Detail = {};
}
   
function mapGuid(Guid) {
   for (var i = 0; i < Tank.Guids.length; i++) {
      if (Tank.Guids[i][0] == Guid) {
         return i;
      }
   }
}
   
/*
 * Javascript Diff Algorithm
 *  By John Resig (http://ejohn.org/)
 *  Modified by Chu Alan "sprite"
 *
 * Released under the MIT license.
 *
 * More Info:
 *  http://ejohn.org/projects/javascript-diff-algorithm/
 */

function escape(s) {
    var n = s;
    n = n.replace(/&/g, "&amp;");
    n = n.replace(/</g, "&lt;");
    n = n.replace(/>/g, "&gt;");
    n = n.replace(/"/g, "&quot;");

    return n;
}

function diffString( o, n ) {
  o = o.replace(/\s+$/, '');
  n = n.replace(/\s+$/, '');

  var out = diff(o == "" ? [] : o.split(/\s+/), n == "" ? [] : n.split(/\s+/) );
  var str = "";

  var oSpace = o.match(/\s+/g);
  if (oSpace == null) {
    oSpace = ["\n"];
  } else {
    oSpace.push("\n");
  }
  var nSpace = n.match(/\s+/g);
  if (nSpace == null) {
    nSpace = ["\n"];
  } else {
    nSpace.push("\n");
  }

  if (out.n.length == 0) {
      for (var i = 0; i < out.o.length; i++) {
        str += '<del>' + escape(out.o[i]) + oSpace[i] + "</del>";
      }
  } else {
    if (out.n[0].text == null) {
      for (n = 0; n < out.o.length && out.o[n].text == null; n++) {
        str += '<del>' + escape(out.o[n]) + oSpace[n] + "</del>";
      }
    }

    for ( var i = 0; i < out.n.length; i++ ) {
      if (out.n[i].text == null) {
        str += '<ins>' + escape(out.n[i]) + nSpace[i] + "</ins>";
      } else {
        var pre = "";

        for (n = out.n[i].row + 1; n < out.o.length && out.o[n].text == null; n++ ) {
          pre += '<del>' + escape(out.o[n]) + oSpace[n] + "</del>";
        }
        str += " " + out.n[i].text + nSpace[i] + pre;
      }
    }
  }
  
  return str;
}

function diff( o, n ) {
  var ns = new Object();
  var os = new Object();
  
  for ( var i = 0; i < n.length; i++ ) {
    if ( ns[ n[i] ] == null )
      ns[ n[i] ] = { rows: new Array(), o: null };
    ns[ n[i] ].rows.push( i );
  }
  
  for ( var i = 0; i < o.length; i++ ) {
    if ( os[ o[i] ] == null )
      os[ o[i] ] = { rows: new Array(), n: null };
    os[ o[i] ].rows.push( i );
  }
  
  for ( var i in ns ) {
    if ( ns[i].rows.length == 1 && typeof(os[i]) != "undefined" && os[i].rows.length == 1 ) {
      n[ ns[i].rows[0] ] = { text: n[ ns[i].rows[0] ], row: os[i].rows[0] };
      o[ os[i].rows[0] ] = { text: o[ os[i].rows[0] ], row: ns[i].rows[0] };
    }
  }
  
  for ( var i = 0; i < n.length - 1; i++ ) {
    if ( n[i].text != null && n[i+1].text == null && n[i].row + 1 < o.length && o[ n[i].row + 1 ].text == null && 
         n[i+1] == o[ n[i].row + 1 ] ) {
      n[i+1] = { text: n[i+1], row: n[i].row + 1 };
      o[n[i].row+1] = { text: o[n[i].row+1], row: i + 1 };
    }
  }
  
  for ( var i = n.length - 1; i > 0; i-- ) {
    if ( n[i].text != null && n[i-1].text == null && n[i].row > 0 && o[ n[i].row - 1 ].text == null && 
         n[i-1] == o[ n[i].row - 1 ] ) {
      n[i-1] = { text: n[i-1], row: n[i].row - 1 };
      o[n[i].row-1] = { text: o[n[i].row-1], row: i - 1 };
    }
  }
  
  return { o: o, n: n };
}

   
   
]];
   
}

