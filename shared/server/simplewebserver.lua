local server = {}
server.simplewebserver = {}
local ws = server.simplewebserver

local wsutils = require 'server.utils'

function ws.default()
   return ws.template(app.config.approot..'/index.html', app.default())
end

function ws.doJsonAction(R)
   local Action = R.location:sub(#app.config.approot+2)
   local Func = app.config.actionTable[Action]
   trace(app)
   trace(Func)
   if (Func) then
      local Result = Func(R)
      if Result.error then 
         ws.serveError(Result.error, Result.code)
         return false
      end
      Result = json.serialize{data=Result}
      net.http.respond{body=Result, entity_type='text/json'}   
      return true
   end
   return false
end

function ws.doStaticResource(R)
   local Resource = app.presentation[R.location]
   if Resource then
      local Body = ws.template(R.location, Resource)      
      net.http.respond{body=Body, entity_type=ws.entity(R.location)} 
      return true
   end   
   return false;
end

function ws.doOtherFile(R)
   local OtherFile = wsutils.loadOtherFile(R.location)
   if (OtherFile) then
      net.http.respond{body=OtherFile, entity_type=ws.entity(R.location)}
      return true
   end
   return false
end

-- Find the method for the action.
function ws.serveRequest(Data)
   local R = net.http.parseRequest{data=Data}
   if ws.doJsonAction(R) then return end
   if ws.doStaticResource(R) then return end
   if ws.doOtherFile(R) then return end   
   net.http.respond{body=ws.default(R)}
end

function ws.serveError(ErrMessage, Code, Stack, Data)
   local Body = {error = ErrMessage}
   if Stack then 
      Body.stack = Stack
   end
   if Data then 
      Body.data = Data 
   end
   net.http.respond{code = Code, body = json.serialize{data = Body}, entity_type = 'text/json'}
   -- Only log internal errors
   if Code > 499 then
      local ErrId = queue.push{data = Data}
      iguana.logError(Stack .. '\n' .. Data, ErrId)
   end
end

function ws.template(Name, Content)
   local NameOnDisk = Name:gsub("/", "_")
   if iguana.isTest() and app.presentation[Name] then
      local F = io.open(NameOnDisk, 'w+')
      trace(app.presentation[Name])
      F:write(app.presentation[Name]);
      F:close()   
   elseif not iguana.isTest() then
      local F = io.open(NameOnDisk, 'r')
      if (F) then
         Content = F:read('*a');
         F:close()
      end
   end
   return Content
end


local ContentTypeMap = {
   ['.js']  = 'application/x-javascript',
   ['.css'] = 'text/css',
   ['.gif'] = 'image/gif'
}

function ws.entity(Location) 
   local Ext = Location:match('.*(%.%a+)$')
   local Entity = ContentTypeMap[Ext]
   return Entity or 'text/plain'
end

return ws
