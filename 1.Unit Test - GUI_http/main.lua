require 'testrunner.app'
require 'lib.webserver'

function main(Data)
   local Server = lib.webserver.create{
      actions = testrunner.actions,
      default = 'app/testrunner/index.html',
      -- If the test property is defined then static files are pulled from the sandbox 
      -- rather than from the mile-stoned versioned copies of the files.  In production
      -- the test propery should be commmented out.
      test = 'admin'    
   }
   iguana.stopOnError(false) 
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