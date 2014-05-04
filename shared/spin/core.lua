spin.core = {}

function getIguana(Url, User, Pass) 
   return iguanaServer.connect{
      url = Url and Url or spin.conf.ig.ip .. ':' .. spin.conf.ig.web_config.port,
      username = User and User or spin.conf.creds.user,
      password = Pass and Pass or spin.conf.creds.pass,
   }
end


-- Returns a "Translator" object
function spin.getTranslator(ChannelGuid)
   trace(ChannelGuid)
   -- Private functions
   local function checkChannelName(Name) 
      local Start, Finish = string.find(Name, spin.conf.params.sandbox_name .. ' %x+')
      return Start == 1 and Finish == 61
   end

   local function getParamsHttps(Num)
      local Conf = spin.Iggy:getDefaultConfig{
         source = iguanaServer.FROM_HTTPS,
         destination = iguanaServer.TO_CHANNEL
      }
      Conf.channel.name = spin.conf.params.sandbox_name .. ' ' .. Num
      Conf.channel.from_http.mapper_url_path = spin.conf.params.sandbox_uri .. "_" .. Num
      return Conf
   end
   
   local function makeZip(Sandbox, Main, Project, Samples, Shared, Other) 
      local Path = spin.conf.scratch
      local DirNames = {Sandbox.channel.from_http.guid:nodeValue(), 'other', 'shared'}
      
      local Tree = {
         [Sandbox.channel.from_http.guid:nodeValue()] = {
            ['main.lua'] = Main,
            ['project.prj'] = Project,
            ['samples.json'] = Samples
         },
         ['other'] = Other and Other or {},
         ['shared'] = Shared and Shared or {}
      }
      return filter.base64.enc(filter.zip.deflate(Tree))
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
      spin.Iggy:importProject{guid=Sandbox.channel.from_http.guid:nodeValue(), project=ReadyToGo, live=true}
      return
   end
   
   local function findSandbox(Guid)
      local Success, Result = pcall(function() 
            return spin.Iggy:getChannelConfig{guid = Guid}
         end)
      return Success and Result or false
   end
   
   local function makeSandbox()
      local Success, Result = pcall(function()
            math.randomseed(os.ts.time())
            local Num = math.random(9999999)
            local NewChannel = spin.Iggy:addChannel{config = getParamsHttps(Num), live = true}
            trace(NewChannel)
            NewChannel.channel.name = NewChannel.channel.name:nodeValue():gsub(Num, NewChannel.channel.guid:nodeValue())
            NewChannel.channel.from_http.mapper_url_path = NewChannel.channel.from_http.mapper_url_path:nodeValue():gsub(Num, NewChannel.channel.guid:nodeValue())
            spin.Iggy:updateChannel{config=NewChannel, live = true}
            setupTranslator(NewChannel)
            spin.Iggy:saveProjectMilestone{guid = NewChannel.channel.from_http.guid:nodeValue(), milestone_name = "Remotely created by Spinner", live = true}
            return NewChannel
         end)
      if Success then 
         return Result
      end
      error(Result)
   end
   
   local function findOrMakeSandbox(Guid)
      if Guid then
         local Existing = findSandbox(Guid)
         if Existing then 
            return Existing
         end
      end
      return makeSandbox()
   end  
   -- End private functions
   
   local Obj = {}
   local Sandbox = findOrMakeSandbox(ChannelGuid)
   trace(Sandbox)

   
   -- Begin public API
   function Obj:baseUrl() 
      return spin.conf.ig.ip .. ':' .. spin.conf.ig.https_channel_server.port .. '/' .. Sandbox.channel.from_http.mapper_url_path .. '/'
   end  
      
   function Obj:cGuid() 
      return Sandbox.channel.guid:nodeValue()
   end
   
   function Obj:tGuid() 
      return Sandbox.channel.from_http.guid:nodeValue()
   end
   
   function Obj:start()
      spin.Iggy:startChannel{guid=Sandbox.channel.guid:nodeValue(), live=true}
      if (spin.Iggy:pollChannelStatus{guid=Sandbox.channel.guid:nodeValue(), channel_status='on'}) then 
         return self 
      end
      error("Could not start sandbox channel '" .. Sandbox.channel.name:nodeValue())
   end

   function Obj:stop() 
      spin.Iggy:stopChannel{guid=Sandbox.channel.guid:nodeValue(), live=true}
            if (spin.Iggy:pollChannelStatus{guid=Sandbox.channel.guid:nodeValue(), channel_status='off'}) then 
         return self 
      end
      error("Could not stop sandbox channel '" .. Sandbox.channel.name:nodeValue())
   end

   function Obj:reset()
      return self:stop():start()      
   end
   
   function Obj:overload(ZipTree)
      local Success, Failure = pcall(function()
            return self:reset()
         end)
      local Url = Obj:baseUrl() .. 'overload'
      local Result, Code = net.http.post{url = Url, body=json.serialize{data=ZipTree, compact=true}, live=true}
      trace(Result)
      if Code == 200 then 
         return self
      end
      error("Overload failed.")
   end
   
   function Obj:run(DataSet, Options)
      local Options = Options and Options or {}
      local Url = Obj:baseUrl() .. 'go'
      local Result, Code = net.http.post{url = Url, body=json.serialize{data={DataSet = DataSet, Options = Options}, compact=true}, live=true}
      trace (Result)
      if Code ~= 200 then 
         error{error = Result, code = Code}
      end
      return json.parse{data=Result}
   end
   
   function Obj:quit() 
      if true then return {status = "OK"} end
      spin.Iggy:stopChannel{guid = self:cGuid()}
      spin.Iggy:removeChannel{guid = self:cGuid()}
      return true
   end
   -- End public API
   
   return Obj
end



-- /clear
function spin.clearSandboxes() 
--   if true then return {status = "OK"} end
   local Conf = spin.Iggy:listChannels()
   for i = 1, Conf:child("IguanaStatus"):childCount("Channel") do
      local Channel = Conf.IguanaStatus:child("Channel", i)
      trace(spin.conf.params.sandbox_name)
      local Start, Finish = string.find(Channel.Name:nodeValue(), spin.conf.params.sandbox_name .. ' %x+')
      if (Start == 1 and Finish == 61) then
         spin.Iggy:stopChannel{guid=Channel.Guid:nodeValue(), live=true}
         spin.Iggy:removeChannel{guid=Channel.Guid:nodeValue(), live=true}
      end
      local Start, Finish = string.find(Channel.Name:nodeValue(), spin.conf.params.sandbox_name .. ' %d+')
      if (Start) then
         spin.Iggy:stopChannel{guid=Channel.Guid:nodeValue(), live=true}
         spin.Iggy:removeChannel{guid=Channel.Guid:nodeValue(), live=true}
      end
   end
   return {"Hi"}
end

function spin.findASandbox() 
   local Conf = spin.Iggy:listChannels()
   for i = 1, Conf:child("IguanaStatus"):childCount("Channel")  do 
      local Channel = Conf.IguanaStatus:child("Channel", i)
      local Start, Finish = string.find(Channel.Name:nodeValue(), spin.conf.params.sandbox_name .. ' %x+')
      if (Start == 1 and Finish == 61) then
         return Channel.Guid:nodeValue()       
      end
   end
   return nil
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

