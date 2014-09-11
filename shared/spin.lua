spin = {}
require 'iguanaServer'


-- Helper functions
local function makeUrl(Config) 
   local Protocol = Config.https and 'https://' or 'http://'
   return Protocol .. Config.host .. ':' .. Config.port
end

local function getIguana(Config)
   return iguanaServer.connect{
      url = makeUrl(Config),
      username = Config.user,
      password = Config.pass
   }
end

local function checkChannelName(Name) 
   local Start, Finish = string.find(Name, spin.conf.params.sandbox_name .. ' %x+')
   return Start == 1 and Finish == 61
end

local function makeZip(Sandbox, Main, Project, Samples, Shared, Other) 
   local DirNames = {Sandbox.channel.from_http.guid:nodeValue(), 'other', 'shared'}
   
   local Tree = {
      [Sandbox.channel.from_http.guid:nodeValue()] = {
         ['main.lua'] = Main,
         ['project.prj'] = Project,
         ['samples.json'] = Samples
      },
      ['other'] = Other or {},
      ['shared'] = Shared or {}
   }
   return filter.base64.enc(filter.zip.deflate(Tree))
end
-- End helpers


-- Returns a "Translator" object. Only called by a Node object.
local function getTranslator(ChannelGuid, Iggy, Sandbox, Node)

   local Translator = {}
 
   local function checkSelfParam(self)
      if self ~= Translator then
         error("Try calling the function using colon syntax (e.g. Translator:funcName()).", 3)
      end
   end
   
   ------------------------
   -- PUBLIC TRANSLATOR API
   ------------------------
   function Translator:baseUrl()
      checkSelfParam(self)
      trace(iguana.webInfo())
      trace(Sandbox)

      -- This line is waiting for web port to be available in channel API. 
      -- Fallbacks are (a) hard-coding in config, and (b) hoping remote port is the same as local one.
      local TargetPort = self:node():httpPort() or iguana.webInfo().https_channel_server.port
      return self:node():protocol() .. self:node():host() .. ':' .. TargetPort .. '/' .. Sandbox.channel.from_http.mapper_url_path .. '/'
   end  

   function Translator:cGuid() 
      checkSelfParam(self)
      return Sandbox.channel.guid:nodeValue()
   end
   
   function Translator:tGuid() 
      checkSelfParam(self)
      return Sandbox.channel.from_http.guid:nodeValue()
   end
   
   function Translator:node() 
      checkSelfParam(self)
      return Node
   end
   
   function Translator:start()
      checkSelfParam(self)
      Iggy:startChannel{guid = self:cGuid(), live=true}
      if (Iggy:pollChannelStatus{guid = self:cGuid(), channel_status='on'}) then 
         return self 
      end
      error("Could not start sandbox channel '" .. Sandbox.channel.name:nodeValue())
   end

   function Translator:stop() 
      checkSelfParam(self)
      Iggy:stopChannel{guid = self:cGuid(), live=true}
      if (Iggy:pollChannelStatus{guid = self:cGuid(), channel_status='off'}) then 
         return self
      end
      error("Could not stop sandbox channel '" .. Sandbox.channel.name:nodeValue())
   end

   function Translator:reset()
      checkSelfParam(self)
      return self:stop():start()      
   end
   
   function Translator:overload(ZipTree)
      checkSelfParam(self)
      local Success, Failure = pcall(function()
            return self:reset()
         end)
      local Url = Translator:baseUrl() .. 'overload'
      local Result, Code = net.http.post{url = Url, body=json.serialize{data=ZipTree, compact=true}, live=true}
      trace(Result)
      if Code == 200 then 
         return self
      end
      error("Overload failed.")
   end
   
   function Translator:run(DataSet, Options)
      checkSelfParam(self)
      local Options = Options or {}
      local Url = Translator:baseUrl() .. 'go'
      local Result, Code = net.http.post{url = Url, body=json.serialize{data={DataSet = DataSet, Options = Options}, compact=true}, live=true}
      trace (Result)
      if Code ~= 200 then 
         error{error = Result, code = Code}
      end
      return json.parse{data=Result}
   end
   
   function Translator:quit()
      checkSelfParam(self)
      self:stop()
      Iggy:removeChannel{guid = self:cGuid()}
      return true
   end
   ------------------------
   ------------------------
   
   return Translator
end



---------------------------------------
local function getNode(Config)
   local Iggy = getIguana(Config)
   
   -- Private functions
   local function getParamsHttps(Num)
      local Conf = Iggy:getDefaultConfig{
         source = iguanaServer.FROM_HTTPS,
         destination = iguanaServer.TO_CHANNEL
      }
      Conf.channel.name = spin.conf.params.sandbox_name .. ' ' .. Num
      Conf.channel.from_http.mapper_url_path = spin.conf.params.sandbox_uri .. "_" .. Num
      return Conf
   end

   local function setupTranslator(Sandbox) 
      local Project = json.serialize{data = {
            Name = Sandbox.channel.name:nodeValue(),
            LuaDependencies = {},
            OtherDependencies = {}
         }
      }
      local Samples = json.serialize{data={}}
      local MyMain = spin.conf.defaults.main:gsub('PLACEHOLDER', Sandbox.channel.from_http.guid:nodeValue())
      
      -- Note: Project and Samples below are not currently used, but can be, if we should ever
      -- want to launch a sandbox translator preloaded with dependencies or sample data.
      local ReadyToGo = makeZip(Sandbox, MyMain, Project, Samples)
      Iggy:importProject{guid=Sandbox.channel.from_http.guid:nodeValue(), project=ReadyToGo, live=true}
      return
   end
   
   
   local function findSandbox(Guid)
      local Success, Result = pcall(function() 
            return Iggy:getChannelConfig{guid = Guid}
         end)
      return Success and Result or nil
   end
   
   local function findAnySandbox() 
      local Conf = Iggy:listChannels()
      for i = 1, Conf:child("IguanaStatus"):childCount("Channel")  do 
         local Channel = Conf.IguanaStatus:child("Channel", i)
         local Start, Finish = string.find(Channel.Name:nodeValue(), spin.conf.params.sandbox_name .. ' %x+')
         if (Start == 1 and Finish == 61) then
            return Iggy:getChannelConfig{guid = Channel.Guid:nodeValue()}       
         end
      end
      return nil
   end
   
   local function makeSandbox()
      local Success, Result = pcall(function()
            math.randomseed(os.ts.time())
            local Num = math.random(9999999)
            local NewChannel = Iggy:addChannel{config = getParamsHttps(Num), live = true}
            trace(NewChannel)
            NewChannel.channel.name = NewChannel.channel.name:nodeValue():gsub(Num, NewChannel.channel.guid:nodeValue())
            NewChannel.channel.from_http.mapper_url_path = NewChannel.channel.from_http.mapper_url_path:nodeValue():gsub(Num, NewChannel.channel.guid:nodeValue())
            Iggy:updateChannel{config=NewChannel, live = true}
            setupTranslator(NewChannel)
            Iggy:saveProjectMilestone{guid = NewChannel.channel.from_http.guid:nodeValue(), milestone_name = "Remotely created by Spinner", live = true}
            return NewChannel
         end)
      if Success then 
         return Result
      end
      error(Result)
   end
   
   local function findOrMakeSandbox(Guid)
      local Existing = nil
      if Guid then
         Existing = findSandbox(Guid)
         if not Existing then 
            error("Could not find sandbox channel " .. Guid)
         end
      else
         Existing = findAnySandbox()
      end
      if Existing then 
         return Existing
      end
      return makeSandbox()
   end 
   
   local function clearSandboxes() 
      -- uncomment the next line to avoid accidental clearouts
         if true then return true end
      local Conf = Iggy:listChannels()

      -- first look by GUID
      for i = 1, Conf:child("IguanaStatus"):childCount("Channel") do
         local Channel = Conf.IguanaStatus:child("Channel", i)
         -- trace(spin.conf.params.sandbox_name)
         if (checkChannelName(Channel.Name:nodeValue())) then
            Iggy:stopChannel{guid=Channel.Guid:nodeValue(), live=true}
            if (Iggy:pollChannelStatus{guid=Channel.Guid:nodeValue(), channel_status='off'}) then 
               Iggy:removeChannel{guid=Channel.Guid:nodeValue(), live=true}
            end
         end
      end
      
      -- then clean up any with integer names
      for i = 1, Conf:child("IguanaStatus"):childCount("Channel") do
         local Channel = Conf.IguanaStatus:child("Channel", i)
         -- trace(spin.conf.params.sandbox_name)
         local Start, Finish = string.find(Channel.Name:nodeValue(), spin.conf.params.sandbox_name .. ' %d+')
         if Start then
            Iggy:stopChannel{guid=Channel.Guid:nodeValue(), live=true}
            if (Iggy:pollChannelStatus{guid=Channel.Guid:nodeValue(), channel_status='off'}) then 
               Iggy:removeChannel{guid=Channel.Guid:nodeValue(), live=true}
            end
         end
      end
      return true
   end
   -- End private functions
   
   local Node = {}
   local function checkSelfParam(self)
      if self ~= Node then
         error("Try calling the function using colon syntax (e.g. Node:funcName()).", 3)
      end
   end

   ------------------
   -- PUBLIC NODE API
   ------------------
   function Node:protocol() 
      return Config.https and 'https://' or 'http://'
   end
   
   function Node:host() 
      checkSelfParam(self)
      return Config.host   
   end
   
   function Node:port()
      checkSelfParam(self)
      return Config.port
   end
      
   -- REMOVE THIS ONCE CHANNEL CONFIG CAN SUPPLY WEB PORT
   function Node:httpPort()
      checkSelfParam(self)
      return Config.http_port
   end
   -----------
   
   function Node:url() 
      checkSelfParam(self)
      return makeUrl(Config)
   end
   
   function Node:getTranslator(ChannelGuid)
      checkSelfParam(self)
      local Sandbox = findOrMakeSandbox(ChannelGuid)
      return getTranslator(ChannelGuid, Iggy, Sandbox, self)   
   end
   
   function Node:getTranslators() 
      checkSelfParam(self)
      local Translators = {}
      local Conf = Iggy:listChannels()
      for i = 1, Conf:child("IguanaStatus"):childCount("Channel") do
         local Channel = Conf.IguanaStatus:child("Channel", i)
         -- trace(spin.conf.params.sandbox_name)
         if (checkChannelName(Channel.Name:nodeValue())) then
            table.insert(Translators, self:getTranslator(Channel.Guid))
         end
      end
      return Translators
   end
   
   function Node:reset()
      checkSelfParam(self)
      clearSandboxes()
      return self
   end
   ------------------
   ------------------
   
   return Node
end


----------------------
function spin.getSpinner(Config)
   local Landscape = Config
   if Landscape['local'] then 
      Landscape['local']['host'] = Landscape['local']['host'] or iguana.webInfo().ip
      Landscape['local']['port'] = Landscape['local']['port'] or iguana.webInfo().web_config.port
      Landscape['local']['https'] = Landscape['local']['https'] or iguana.webInfo().web_config.use_https
   end

   local function pickNode() 
      -- Expand this to choose the least-busy node
      return 'local'
   end
   
   local Spinner = {}
   local function checkSelfParam(self)
      if self ~= Spinner then
         error("Try calling the function using colon syntax (e.g. Spinner:funcName()).", 3)
      end
   end
   
   ---------------------
   -- PUBLIC SPINNER API
   ---------------------
   function Spinner:getNode(Name) 
      checkSelfParam(self)
      local Target = Name or pickNode()
      return getNode(Landscape[Target])
   end

   function Spinner:getNodes()
      checkSelfParam(self)
      local Nodes = {}
      for Name, Conf in pairs(Landscape) do 
         Nodes[Name] = self:getNode(Name)
      end
      return Nodes
   end

   function Spinner:getTranslator() 
      checkSelfParam(self)
      local Node = self:getNode()
      return Node:getTranslator()
   end
   ---------------------
   ---------------------
   
   return Spinner
end




-- These two are not in current use, but might be useful in the coming days.
function spin.makeProject(Sandbox, Vars)
   local Project = {
      Name = Sandbox.channel.name:nodeValue(),
      LuaDependencies = Vars.shared or {},
      OtherDependencies = Vars.other or {}
   }
   return json.serialize{data=Project}
end

function spin.checkSandbox(Status, Guid)
   for i = 1, Status:child("IguanaStatus"):childCount("Channel") do 
      local Channel = Status.IguanaStatus:child("Channel", i)
      if Channel.Guid:nodeValue() == Guid then 
         return Channel.Status:nodeValue()
      end
   end
   error("Sandbox channel was not found")
end


spin.conf = {}
spin.conf.params = {
   sandbox_name = 'SANDBOX CHANNEL DO NOT TOUCH',
   sandbox_uri = 'sandbox_do_not_touch'
}

spin.conf.defaults = {
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
   
   -- This table will return messages for regressions and tests for unit testing
   local Results = {['tests'] = {}, ['messages'] = {}}

   -- Return nil on queue.push for the first time simulatedMain is run (i.e.
   -- without data for unit testing)
   queue.push = function() return nil end
   if #DataSet > 0 then
      Results.tests = simulatedMain_PLACEHOLDER(DataSet[1])
   else
      Results.tests = simulatedMain_PLACEHOLDER()
   end

   local doThisInstead = function(Args)
      table.insert(Results.messages, catch_PLACEHOLDER(Args))
   end
   
   net.http.respond = doThisInstead
   queue.push = doThisInstead
   
   for i = 1, #DataSet do
      simulatedMain_PLACEHOLDER(DataSet[i])
      if Options.OneForOne then 
         if #Results.messages < i then 
            doThisInstead({})
         end
      end
   end
   
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

spin.conf.filterwrap = [[ 
function main(Data)
   local Revised = chm.transform{vmd = 'EDreports_PeerNET_Test.vmd', data = Data}
   queue.push(Revised)
end
]]

spin.conf.scratch = os.fs.abspath("~") .. '/sandbox_tmp'

return spin
