require 'cm.app'
require 'lib.webserver'

function main(Data)   
   local Server = lib.webserver.create{
      actions=cm.actions,
      auth=true, -- Requires basic authentication username/password from this Iguana instance
      default='app/cm/index.html',
      -- If the test property is defined then static files are pulled from the sandbox
      -- rather than from the mile-stoned versioned copies of the files.  In production
      -- the test property should be commented out.
      --test='admin'
   }
   Server:serveRequest{data=Data}
end


-- TODO - at some point we really should move the icon_* files into a shared library folder so they don't clutter up
-- the top level directory of the other folder.  Not worth changing at this exact point in time.
