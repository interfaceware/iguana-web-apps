--
-- The server and the app object are global.
require 'channelmanager'
server = require 'server.simplewebserver'

function main(Data)
   iguana.stopOnError(false)
   
   if iguana.isTest() then
      server.serveRequest(Data)
   else
      local Success, ErrMsg = pcall(server.serveRequest, Data)
      if (not Success) then
         local refId = queue.push{data=Data}
         iguana.logError(ErrMsg, refId)
      end
   end
end
