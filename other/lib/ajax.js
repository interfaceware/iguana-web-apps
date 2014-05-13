if (!lib) {
   var lib = {}
}

lib.ajax = {}

// This is the default error handler
lib.ajax.errorFunc = function(ErrMsg){
   $('body').html("Default error handler:" + ErrMsg);
}

// If we get a Lua exception we generate HTTP error code 500 which should result in the error handler being invoked
lib.ajax.call = function(CallName, SuccessFunc){
   console.log(CallName);
   var Url = CallName; 
   $.ajax({
       url : Url,
       success : function (Data) {
          SuccessFunc(Data);
       },
       error : function(Error, textStatus, errorThrown){
          console.log(Error);
          if Error.responseJSON {
             lib.ajax.errorFunc("Error: " +  Error.responseJSON.error}
          } else {
             lib.ajax.errorFunc("Call: '" + CallName + "' failed. " + textStatus + " " + errorThrown);
          }
       }
   });
}
