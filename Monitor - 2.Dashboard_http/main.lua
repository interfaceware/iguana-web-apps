local dash = require 'dashboard.store'
require 'lib.webserver'

-- The main function is the first function called from Iguana.
-- The Data argument will contain the message to be processed.
dash.init()

-- TODO - this code needs a little TLC to get to use the same framework as the channel
-- manager but it gets the concept across well enough.
function main(Data)
   local Server = lib.webserver.create{
      actions=dash.Actions,
      default='app/monitor/index.html',
      -- If the test property is defined then static files are pulled from the sandbox 
      -- rather than from the mile-stoned versioned copies of the files.  In production
      -- the test propery should be commmented out.
      --test='admin'    
   }  
   Server:serveRequest{data=Data}
   iguana.stopOnError(false)   
end
