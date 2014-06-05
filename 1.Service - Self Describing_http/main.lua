require 'lib.webserver'

-- This is a work in progress showing how a super friendly web service
-- can be created which offers really friendly help on the calls that it
-- supports.

-- This first stage shows how we can serve up the help information for
-- a group of functions that are in the core API.

function main(Data)
   local Server = lib.webserver.create{
      actions=hl7,
      methods={hl7=hl7, net=net, string=string},
      default='app/webservice/index.html',
      test='admin'
   }
   
   Server:serveRequest{data=Data}
end