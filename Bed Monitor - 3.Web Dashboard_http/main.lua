require 'bedmonitor.app'
require 'bedmonitor.db'
require 'lib.webserver'

bedmonitor.db.init()

local Server = lib.webserver.create{
   actions = bedmonitor.actions,
   default = 'app/bedmonitor/index.html',
   -- If the test property is defined then static files are pulled from the sandbox 
   -- rather than from the mile-stoned versioned copies of the files.  In production
   -- the test propery should be commmented out.
   --test = 'admin'    
}

function main(Data)
   Server:serveRequest{data=Data}
end
