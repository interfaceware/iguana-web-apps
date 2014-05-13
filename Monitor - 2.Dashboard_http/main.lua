local dash = require 'dashboard.store'
require 'lib.webserver'

-- The main function is the first function called from Iguana.
-- The Data argument will contain the message to be processed.
dash.init()

local Server = lib.webserver.create{
   actions=dash.Actions,
   default='app/monitor/index.html'
   -- If the test property is defined then static files are pulled from the sandbox 
   -- rather than from the mile-stoned versioned copies of the files.  In production
   -- the test propery should be commmented out.
   --test='admin'    
}  

function main(Data)
   Server:serveRequest{data=Data}
end
