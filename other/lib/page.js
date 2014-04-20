if (!lib) {
   var lib = {}
}

lib.page = {}

lib.page.init = function(PageTable){
   var m_LastHash = "INITIALIZED";
   // Controller/Router
   var OnHashChange =function() {
      console.log(document.location);
      if (m_LastHash == document.location.hash){
         return;
      }
      m_LastHash = document.location.hash;
      var Hash = document.location.hash;
      var Params = ParseAnchorString(Hash);

      var Action = PageTable[Params.Page];
      console.log(Action);
      if (Action) {
         Action(Params);
      } else {
         console.log("Do default action.");
         PageTable.default(Params);
      }
   }

   ConvertSpaceEncoding = function(EncodedInput) {
      return EncodedInput.replace(/\+/g, "%20");
   }
   
   ParseAnchorString = function(AnchorString) {
      var Params = {};
      var Vars = AnchorString.substring(1).split('&');
      for (var i = 0; i < Vars.length; i++) {
         var Parts = Vars[i].split('=');
         if (undefined != Parts[1]) {
            Parts[1] = ConvertSpaceEncoding(Parts[1]);
         }
         Params[Parts[0]] = decodeURIComponent(Parts[1]);
      }
      console.log(Params);
    return Params;
   }   
      
   window.onhashchange = OnHashChange;
   OnHashChange();
}
   

      

