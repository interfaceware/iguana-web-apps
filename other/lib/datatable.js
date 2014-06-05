// In practice with data tables it turns out there are a bunch of useful utility functions which are
// really helpful.  So we put them here.

if (!lib) {
   var lib = {}
}

lib.datatable = {}

// So when you have a data table that with 3 elements showing all 3 elements then
// seeing the Previous and Next buttons isn't that helpful.  This is a generic need
// so I factored out this helper function.
// Usage is lib.datatable.hideNavigationArrows(GridControl, GridData)
lib.datatable.hideNavigationArrows = function(GridControl, GridData){
   var Arrows = $("#summary_paginate a");
   if (GridData.aaData.length < GridControl.fnSettings()._iDisplayLength) {
      Arrows.hide();
      return;
   }
   Arrows.show();
}

// This little helper function adds the gorgeous yellow highlighting to the data
// It looks complicated but the beautiful thing is that you can have this
// nice behavior by adding one line of code:
// lib.datatable.addSearchHighlight(Grid);
// And make sure you also have a CSS style defined like span.filterMatches{background-color : yellow; }
lib.datatable.addSearchHighlight = function(GridData){
   function searchHighlight(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
      var searchStrings = [];
      var oApi = this.oApi;
      var oSettings = this.fnSettings();
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
         // This regex will avoid in HTML matches
         var regex = new RegExp("("+sSregex+")(?!([^<]+)?>)", 'i');
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
   GridData.fnRowCallback = searchHighlight;
}


