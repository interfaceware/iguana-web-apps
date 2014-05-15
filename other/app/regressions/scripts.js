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
      <div id="breadcrumbs"><a href="/regressions/#">Main</a></div>\
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
      url: "/regressions/channels",
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
      breadcrumbs(Hash, Vars);
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
   var ErrorString;
   if (Error.responseJSON) {
      console.log(Error.responseJSON);
      console.log(Error.responseJSON.stack);
      ErrorString = Error.responseJSON.error;
   } else {
      ErrorString = Error.responseText;
   }
   $('#error').html("Error: " + ErrorString + ' <a href="/regressions/">Back to main screen</a>').show();
}

function doTests(Guid, Callback) {
   console.log("Doing Tests.");
   resetDetail();
   var index = mapGuid(Guid);
   console.log(index);
   if (Tank.Guids[index][2]) {
      $.ajax({
         url: "/regressions/run_tests?channel=" + Guid +"&name=" + Tank.Guids[index][1],
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
         url: "/regressions/build?channel=" + Guid,
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
      url: '/regressions/edit_result',
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

