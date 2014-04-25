require 'regressions'

server = require 'server.simplewebserver'

function main(Data)
   iguana.stopOnError(false)
   
   if iguana.isTest() then
      server.serveRequest(Data)
      
   else
      -- When running, push full stack error out to browser.
      -- In the case of an internal error, log it.
      local Stack = nil
      local Success, ErrMsg = xpcall(
         function()
            server.serveRequest(Data)
         end,
         function(Error)
            Stack = debug.traceback()
            server.serveError(Error.error, Error.code, Stack, Data)
         end)      
   end
end

