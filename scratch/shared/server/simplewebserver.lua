local server = {}
server.simplewebserver = {}
local ws = server.simplewebserver

local wsutils = require 'server.utils'

function ws.default()
   return ws.template(app.config.approot..'/index.html', app.default())
end

-- Find the method for the action.
function ws.serveRequest(Data)
   local R = net.http.parseRequest{data=Data}
   trace(R.location)
   
   -- Get the action name by stipping off the app root
   local ActionName = R.location:sub(#app.config.approot+1)
   local Action = app.actions[ActionName]
   trace(Action)
   trace(app)
   
   -- Ajax requests. This design is for single page apps.
   -- Only the default below serves an entire HTML page.
   if Action then
      trace(R)
      local Func = app[Action]
      if not Func then
         net.http.respond{body="Action "..Action.." does not exist!"}
         return 
      else      
         local Result = app[Action](R)
         Result = json.serialize{data=Result}
         net.http.respond{body=Result, entity_type='text/json'}   
         return
      end
   end
   
   -- All other resources. CSS, JS, etc.
   local Resource = app.ui[R.location]
   if Resource then
      local Body = ws.template(R.location, Resource)      
      net.http.respond{body=Body, entity_type=ws.entity(R.location)} 
      return
   end
 
   local OtherFile = wsutils.loadOtherFile(R.location)
   if (OtherFile) then
      net.http.respond{body=OtherFile, entity_type=ws.entity(R.location)}
      return
   end
   
   -- Default page. The only HTML page.
   net.http.respond{body=ws.default(R)}
end

function ws.template(Name, Content)
   local NameOnDisk = Name:gsub("/", "_")
   if iguana.isTest() and app.ui[Name] then
      local F = io.open(NameOnDisk, 'w+')
      trace(app.ui[Name])
      F:write(app.ui[Name]);
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

--[[

-- This template writes all resources in the map each time.
-- The one above only writes the one in the current request.
function ui.template(Name, Content)
   Name = Name:gsub("/", "_")
   if iguana.isTest() then
      for Key, Val in pairs(ui.ResourceTable) do
         Key = Key:gsub("/", "_")
         local File = io.open(Key, 'w+')
         File:write(Val);
         File:close()   
      end
   else
      local File = io.open(Name, 'r')
      if (File) then
         Content = File:read('*a');
         File:close()
      end
   end
   return Content
end

function ws.mapRequest(T, R)
   T.server_guid = R.guid
   T.ts = os.ts.time()
   T.summary = R.summary
   T.status = R.retcode
   T.name = R.name
   return T
end

ws.threshold = 1000

function ws.connection()
   return db.connect{api=db.SQLITE, name='status'}
end

function ws.css(R)
   return presentation.css(R)
end

]]
