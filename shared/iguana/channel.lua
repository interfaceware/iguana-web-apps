-- This is a darn useful Lua library.  It provides a very convenient API to export and import
-- channels.  This library came out of refactoring the guts of the first version of the channel
-- manager.  It's decoupled from the web service part of the channel manager.  
--
-- This means you can use this module outside of the channel manager to do interesting things like write scripts
-- which can manipulate many channels at once.
--
-- The public functions are documented in comments above each function

iguana.channel = {}

-- iguana.channel.getTranslators(ChannelConfig)
-- 
-- This function takes a XML parsed fragment of an Iguana Channel and gives back a Lua table with a set
-- of the translator GUIDs found in the file.  Each Guid is named with a key which defines the type of translator instance:
--    * 'http'   - From HTTPS translator
--    * 'from'   - From Translator
--    * 'ack'    - Custom ACK translator on an LLP Listener
--    * 'filter' - Filter Translator
--    * 'to'     - To translator
-- This function really helps to make the rest of the code clean since one can write code which can iterate through
-- each translator instance in a channel.
function iguana.channel.getTranslators(ChannelConfig)     
   local C = ChannelConfig.channel
   return iguana.channel.returnGUID(C)
end

function iguana.channel.returnGUID(C)
   local Info = {} 
      if C.to_mapper then
      Info.to = C.to_mapper.guid:nodeValue()
   end
   if C.from_mapper then
      Info.from = C.from_mapper.guid:nodeValue()
   end
   if C.use_message_filter:nodeValue() == 'true' and C.message_filter and
      C.message_filter.use_translator_filter and
      C.message_filter.translator_guid then
      Info.filter = C.message_filter.translator_guid:nodeValue()
   end
   if C.from_llp_listener and C.from_llp_listener.ack_script then
      Info.ack = C.from_llp_listener.ack_script:nodeValue()
   end
   if C.from_http and C.from_http.guid then
      Info.http = C.from_http.guid:nodeValue()
   end   
   return Info
end

local function ChannelDefinition(Dir, Name)
   local FullFileName = Dir..'/'..Name..'.xml'
   local Content = os.fs.readFile(FullFileName)
   return xml.parse{data=Content}
end

local function ProjectFile(MainDir)
   local D = os.fs.readFile(MainDir.."/project.prj")
   return json.parse{data=D}
end

local function AddFile(Dir, File, Content)
   local Parts = File:split('/')
   local SubDir = Dir
   for i = 1, #Parts-1 do
      if #Parts[i] > 0 then
         if not SubDir[Parts[i]] then SubDir[Parts[i]] = {} end
         SubDir = SubDir[Parts[i]]
      end
   end
   SubDir[Parts[#Parts]] = Content
end

function BuildTransZip(RepoDir, ProjectDir, TargetGuid, Name)
   local Dir = {}
   local MainDir = RepoDir..'/'..ProjectDir..'/'
   MainDir = os.fs.abspath(MainDir)
   for K,V in os.fs.glob(MainDir..'*') do
      local Content = os.fs.readFile(K)
      if TargetGuid then 
         AddFile(Dir,TargetGuid..'/'..K:sub(#MainDir), Content)
      else
         AddFile(Dir,ProjectDir .. '/' .. K:sub(#MainDir), Content)
      end
   end
   trace(Dir)
   local P = ProjectFile(MainDir)
   for i = 1, #P.OtherDependencies do 
      local Content = os.fs.readFile(RepoDir..'/other/'..P.OtherDependencies[i])
      AddFile(Dir, '/other/'..P.OtherDependencies[i], Content)
   end
   for i = 1, #P.LuaDependencies do 
      local Content = os.fs.readFile(RepoDir..'/shared/'..P.LuaDependencies[i]:gsub("%.", '/')..'.lua')
      AddFile(Dir, '/shared/'..P.LuaDependencies[i]:gsub("%.", "/")..'.lua', Content)
   end
   trace(Dir)
   os.ts.time()
   local ZipData2 = filter.zip.deflate(Dir)
   os.ts.time()
   return filter.base64.enc(ZipData2), Dir
end

-- iguana.channel.add{api=ChannelApiObject, dir='<repo directory>', definition='SomeChannelFile.xml', }
-- This function will create a new channel.
-- It pulls the definition from directory with the definition you give it using the Channel API object that
-- pass in i.e.
--    local Api = iguanaServer.connect{username='admin', password='password'}
--    iguana.channel.add{api=Api, dir="C:/myrepo/", definition='Regression tester.xml'}
-- Since it takes and Api object there is no reason that you couldn't be loading the channel on to a remote server.
function iguana.channel.add(T)
   local RepoDir = T.dir
   local Definition = T.definition
   local Api = T.api
   local ChanDef = ChannelDefinition(RepoDir, Definition)
   if T.name then 
      ChanDef.channel.name = T.name
   end
   -- TODO sometime we should shift this into a help and use pcall so that exceptions are
   -- thrown that we can clean up the half added channel.
   local NewChanDef = Api:addChannel{config=ChanDef, live=true}
   local TranList = iguana.channel.getTranslators(NewChanDef)
   for TransType,Guid in pairs(TranList) do
      local Start = os.ts.time()
      local ZipData = BuildTransZip(RepoDir, Definition..'_'..TransType, Guid)
      local EndTime = os.ts.time()
      trace(EndTime-Start)
      Api:importProject{project=ZipData, guid=Guid, sample_data='replace', live=true}
      local CommitResult = Api:saveProjectMilestone{guid=Guid, comment='Channel Manager '..os.date(), live=true}
      Api:bumpProject{guid = Guid, commit_id = CommitResult.commit_id, live = true}
   end
   return NewChanDef
end

local function MergeTree(From, To)
   for k,v in pairs(From) do
      if type(v) == 'table' then
         if not To[k] then To[k] = {} end
         MergeTree(v, To[k])         
      end
      if type(v) == 'string' and not k:find("::") then -- Metadata
         To[k] = v
      end
   end
end

local function ExpandTranslatorZip(Result, Guid, Name, ZipContent)
   local D = filter.base64.dec(ZipContent)
   local T = filter.zip.inflate(D)
   trace(T)
   Result[Name] = {}
   MergeTree(T[Guid], Result[Name])
   if (T.other) then
      if not Result.other then
         Result.other ={}
      end
      MergeTree(T.other, Result.other)
   end
   if (T.shared) then
      if not Result.shared then
         Result.shared = {}
      end
      MergeTree(T.shared, Result.shared)
   end
end

-- GUIDs are noisy sources of spurious changes - we change them
local ZeroGuid = '00000000000000000000000000000000'

function RemoveGuids(ChanConfig)
   local C = ChanConfig.channel;
   C.guid = ZeroGuid
   if C.to_mapper then
      C.to_mapper.guid = ZeroGuid
   end
   if C.from_mapper then
      C.from_mapper.guid = ZeroGuid
   end
   if C.use_message_filter:nodeValue() == 'true' and C.message_filter and
        C.message_filter.use_translator_filter and
        C.message_filter.translator_guid then
      C.message_filter.translator_guid = ZeroGuid
   end
   if C.from_llp_listener and C.from_llp_listener.ack_script then
      C.from_llp_listener.ack_script = ZeroGuid
   end
   if C.from_http and C.from_http.guid then
      C.from_http.guid = ZeroGuid
   end   
end

-- iguana.channel.export{api=ChannelApiObject, name='Channel Name'}
-- This function will export a channel with the given name using the Channel API object you pass it.
-- The data is returned in a Lua table with all the files in nested format - it's up to the caller to do something
-- with those files - you could put it into a zip, save the files to disc etc.
--
-- That is one neat thing about this function.  The other really cool thing is that the channel API object you hand it
-- could be for a local Iguana instance or it could be for a remote Iguana instance.  So this library can be used to 
-- manipulate a local or a remote Iguana instance in a convenient manner.
function iguana.channel.export(T)
   local Result = {}
   local Api = T.api
   local ChannelName = T.name
   local ChanDef = Api:getChannelConfig{name=ChannelName, live=true}
   local TranList = iguana.channel.getTranslators(ChanDef)
   for TranType,GUID in pairs(TranList) do 
      local ZipContent = Api:exportProject{guid=GUID, live=true,sample_data=T.sample_data}
      ExpandTranslatorZip(Result, GUID, ChannelName.."_"..TranType, ZipContent)
   end
   RemoveGuids(ChanDef)
   Result[ChannelName..'.xml'] = tostring(ChanDef) 
   return Result
end

-- This function returns true if a Channel exists 
-- in the local instance with the given Name
function iguana.channel.exists(Name)
   local X = xml.parse{data=iguana.status()}
   for i = 1, X.IguanaStatus:childCount("Channel") do
      local C = X.IguanaStatus:child("Channel", i)
      if tostring(C.Name) == Name then
         return true;
      end
   end
   return false
end

-- TODO - might want to set this up to be a local namespace
