require 'cm.app'
require 'lib.webserver'

local Server = lib.webserver.create{
   actions=cm.actions,
   auth=true, -- Requires basic authentication username/password from this Iguana instance
   default='app/cm/index.html',
   -- If the test property is defined then static files are pulled from the sandbox 
   -- rather than from the mile-stoned versioned copies of the files.  In production
   -- the test property should be commented out.
   -- test='admin'    
}

function main(Data)   
   Server:serveRequest{data=Data}
end
