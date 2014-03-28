-- The server and the app object are global.
require 'channelmanager'
server = require 'server.simplewebserver'

function main(Data)
   iguana.stopOnError(false) 
   if iguana.isTest() then
      server.serveRequest(Data)
   else
      -- When running, push full stack error out to browser.
      -- In the case of an internal error, log it.
      local Stack = nil
      local Success, ErrMsg = pcall(server.serveRequest, Data)
      if (not Success) then
         local ErrObj = {error=ErrMsg}
         net.http.respond{body=json.serialize{data=ErrObj}, entity_type='text/json'}
      end
   end
end
