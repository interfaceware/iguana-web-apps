require 'app'
require 'web.server'
local basicauth = require 'web.basicauth'

function main(Data)
   local Server = web.webserver.create{
      auth=true,
      actions = testrunner.actions,
      default = 'web/index.html',
      -- If the test property is defined then static files are pulled from the sandbox 
      -- rather than from the mile-stoned versioned copies of the files.  In production
      -- the test propery should be commmented out.
      --test = 'admin'
   }
   iguana.stopOnError(false)
   
   local R = net.http.parseRequest{data=Data}
   
   if not basicauth.isAuthorized(R) then
      basicauth.requireAuthorization()
      return
   else
      local Auth64Str = R.headers.Authorization:sub(#"Basic " + 1)
      local Creds = filter.base64.dec(Auth64Str):split(":")
      local Connected = testrunner.app.makeIggy({user = Creds[1], pass = Creds[2]})
   end

   if iguana.isTest() then
      Server:serveRequest{data=Data}
   else
      -- When running, push full stack error out to browser.
      -- In the case of an internal error, log it.
      local Stack = nil
      local Success, ErrMsg = pcall(Server.serveRequest, Server, {data=Data})
      if (not Success) then
         local ErrObj = {error=ErrMsg}
         net.http.respond{body=json.serialize{data=ErrObj}, entity_type='text/json'}
      end
   end
end