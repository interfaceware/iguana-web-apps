spin.conf = {}
local conf = spin.conf

conf.approot = '/spinner'

conf.actions = {
   spin = spin.getSandboxChannel,
   remove = spin.removeSandboxChannel,
   setup = spin.getTranslator,
   overload = spin.overloadTranslator,
   overloadd = spin.fake,
   go = spin.go,
   gooo = spin.fakego,
   run = spin.runTranslator,
   status = spin.status,
   clear = spin.clearSandboxes
}

conf.creds = {
   user = 'admin',
   pass = 'password'
}

conf.ig = iguana.webInfo()

conf.params = {
   sandbox_name = 'SANDBOX CHANNEL DO NOT TOUCH',
   sandbox_uri = 'sandbox_do_not_touch'
}

conf.defaults = {
   main = [==[
function main(Data)
   loadUrls_PLACEHOLDER()
   print(Data)
   local Stack = nil

   originalRespond_PLACEHOLDER = net.http.respond
   originalPush_PLACEHOLDER = queue.push
   
   local Success, ErrMsg = xpcall(
      function()
         originalRespond_PLACEHOLDER(serveRequest_PLACEHOLDER(Data))
      end,
      function()
         Stack = debug.traceback()
         originalRespond_PLACEHOLDER(serveError_PLACEHOLDER("Internal error", 500, Stack, Data))
      end)
end

function catch_PLACEHOLDER(Args)
   return Args
end

function loadUrls_PLACEHOLDER()
   Root = '/sandbox_do_not_touch_PLACEHOLDER'
   Actions = {
      ['overload'] = overload_PLACEHOLDER,
      ['go'] = go_PLACEHOLDER
   }
end

function serveRequest_PLACEHOLDER(Data)
   local Params = net.http.parseRequest{data = Data}
   local Command = Params.location:sub(#Root + 2)
   if Actions[Command] then
      local Result = Actions[Command](Params)
      if Result.error and Result.code then 
         return {body=json.serialize{data=Result}, code = Result.code, entity_type = 'text/json'}
      end
      local BodyData = json.serialize{data=Result}
      print(BodyData)
      return {body=BodyData, entity_type="text/json"}
   end

   --The default behaviour of a "fake" translator is simply to echo back the request
   return {body=Data, entity_type="text/plain"}
end

function serveError_PLACEHOLDER(String, Code, Stack, Data)
   local Body = {error = String}
   if Stack then 
      Body.stack = Stack
   end
   if Request then 
      Body.data = Data 
   end
   -- Only log internal errors
   if Code > 499 then
      local ErrId = queue.push{data = Data}
      iguana.logError(Stack .. '\n' .. Data, ErrId)
   end
   local BodyData = json.serialize{data=Body}
   print(BodyData)
   return {code = Code, body = BodyData, entity_type = 'text/json'}
end

function overload_PLACEHOLDER(Params)
   local ZipTree = json.parse{data=Params.body}
   trace(ZipTree)
   require = function(Module)
      newRequire_PLACEHOLDER(Module, ZipTree)
   end
   updateVmds_PLACEHOLDER(ZipTree)
   
   local LuaText = ZipTree['main.lua']
   LuaText = LuaText:gsub('function main', 'function simulatedMain_PLACEHOLDER')
   local ReadyToRun = loadstring(LuaText)
   ReadyToRun()
   return {status = 'THAT TOTALLY WORKED'}
end

function go_PLACEHOLDER(Params)
   if not simulatedMain_PLACEHOLDER then 
      return {error = 'This translator must be overridden before it can be run.', code = 403}
   end
   
   local Payload = json.parse{data=Params.body}
   local DataSet = Payload.DataSet
   local Options = Payload.Options
   
   local Results = {}

   local doThisInstead = function(Args)
      table.insert(Results, catch_PLACEHOLDER(Args))
   end
   
   net.http.respond = doThisInstead
   queue.push = doThisInstead
   
   table.insert(Results, 1, simulatedMain_PLACEHOLDER(DataSet[1]))
   
   --[[
   for i = 1, #DataSet do
      simulatedMain_PLACEHOLDER(DataSet[i])
      if Options.OneForOne then 
         if #Results < i then 
            doThisInstead({})
         end
      end
   end
   --]]
   
   net.http.respond = originalRespond_PLACEHOLDER
   queue.push = originalPush_PLACEHOLDER
   
   return Results
end

function newRequire_PLACEHOLDER(ModName, ZipTree)
   local Pieces = ModName:split_PLACEHOLDER('%.')
   Pieces[#Pieces] = Pieces[#Pieces] .. '.lua'
   local Node = ZipTree.shared
   for i = 1, #Pieces do 
      trace(Pieces[i])
      Node = Node[Pieces[i]]
   end
   local LuaText = loadstring(Node)
   return LuaText()
end

function findVmd_PLACEHOLDER(Node, Path) 
   local Pieces = Path:split_PLACEHOLDER('/')
   for i = 1, #Pieces do
      trace(Pieces[i])
      Node = Node[Pieces[i]]
   end
   return Node
end

function updateVmds_PLACEHOLDER(ZipTree)
   local LegacyFunctionNames = {
      'chm.fromXml',
      'chm.parse',
      'chm.transform',
      'chm.toXml',
      'db.tables',
      'hl7.message',
      'hl7.parse',
      'x12.message',
      'x12.parse',
   }
   for i = 1, #LegacyFunctionNames do
      local Parts = LegacyFunctionNames[i]:split_PLACEHOLDER('%.')
      local Original = _G[Parts[1]][Parts[2]]
      _G[Parts[1]][Parts[2]] = function(Table)
         Table.vmd_definition = findVmd_PLACEHOLDER(ZipTree.other, Table.vmd)
         return Original(Table)
      end
   end
end

function string.split_PLACEHOLDER(s, d)
   local t = {}
   local i = 0
   local f
   local match = '(.-)' .. d .. '()'
   if string.find(s, d) == nil then
      return {s}
   end
   for sub, j in string.gfind(s, match) do
      i = i + 1
      t[i] = sub
      f = j
   end
   if i~= 0 then
      t[i+1]=string.sub(s,f)
   end
   return t
end
   
   ]==]
}

conf.scratch = os.fs.abspath("~") .. '/sandbox_tmp'

return conf
