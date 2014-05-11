if (!lib) {
   var lib = {}
}

lib.ajax = {}

// This is the default error handler
lib.ajax.errorFunc = function(ErrMsg){
   $('body').html("Default error handler:" + ErrMsg);
}

// Have to figure out with Bret if we should change this to use HTTP error codes rather than inspecting the
// JSON payload - it would be a change in this and in lib.webserver
lib.ajax.call = function(CallName, SuccessFunc){
   console.log(CallName);
   var Url = CallName; 
   $.ajax({
       url : Url,
       success : function (Data) {
          if (Data.error){
             lib.ajax.errorFunc(Data.error);
             return;
          } else {
            SuccessFunc(Data);
          }
       },
       error : function(jqXHR, textStatus, errorThrown){
           lib.ajax.errorFunc("Call: '" + CallName + "' failed. " + textStatus + " " + errorThrown);
       }
   });
}

