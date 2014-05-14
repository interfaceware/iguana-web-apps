// This library is provides the various hacks needed to make IE9 happy(ish)

if (typeof console == 'undefined'){
   console = {};
   console.log = function() {}; 
}

var Browser = {
   Version: function() {
      var version = 9;
      if (navigator.appVersion.indexOf("MSIE") != -1) {
         version = parseFloat(navigator.appVersion.split("MSIE")[1]);
      }
      return version;
   }
}

// Because we don't have jQuery going at this point we drop down to regular Javascript
if(Browser.Version() < 9) {
   document.open();
   document.write("<p>This application only supports Firefox, Chrome, and Internet Explorer 9+</p><p>If you're using Internet Explorer 9 or later and you're still seeing this message you may be running in compatability mode.</p>");
   document.close();
}

