-- This example is just showing the beginning of how this could work.
-- We connect to the web service and construct the API on the fly to talk to highrise.

local webservice = require 'webservice.client'

function main(Data)
   local WebInfo = iguana.webInfo()
   local Url = 'http://localhost:'..WebInfo.https_channel_server.port..'/webservice/'
   -- We connect to the server to get our API
   local Highrise = webservice.client.connect{url=Url, 
                username='admin', password='password'}
   -- We add in Jim Smith and remove him.
   local Id, ContactXml = 
      Highrise.contact.add{firstname="Jim", lastname="Smith", title="Mr"}
   Highrise.contact.delete{id=Id}
end