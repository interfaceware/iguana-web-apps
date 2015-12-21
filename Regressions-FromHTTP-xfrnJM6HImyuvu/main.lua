require 'app'
require 'web.server'


local Server = web.webserver.create{
   actions=regressions.actions,
   auth=false, -- Requires basic authentication username/password from this Iguana instance
   default='web/index.html',
   -- If the test property is defined then static files are pulled from the sandbox 
   -- rather than from the mile-stoned versioned copies of the files.  In production
   -- the test property should be commented out.
   --test='admin'    
}

function main(Data)
   Server:serveRequest{data=Data}
end
