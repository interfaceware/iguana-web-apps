iguana.channel = {}

require 'file'

function iguana.channel.getTranslators(ChannelConfig)
   local Info = {}   
   local C = ChannelConfig.channel;
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
   trace(FullFileName)
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

local function BuildTransZip(RepoDir, ProjectDir, TargetGuid, ScratchDir)
   local Dir = {}
   local MainDir = RepoDir..'/'..ProjectDir..'/'
   for K,V in os.fs.glob(MainDir..'*') do
      local Content = os.fs.readFile(K)
      AddFile(Dir,TargetGuid..'/'..K:sub(#MainDir), Content)
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
   return filter.base64.enc(ZipData2)
end

function iguana.channel.add(T)
   local RepoDir = T.dir
   local Definition = T.definition
   local Api = T.api
   local ScratchDir = T.scratch
   os.ts.time()

   local ChanDef = ChannelDefinition(RepoDir, Definition)
   if T.name then 
      ChanDef.channel.name = T.name
   end
   os.ts.time()
   local NewChanDef = Api:addChannel{config=ChanDef, live=true}
   os.ts.time()
   local TranList = iguana.channel.getTranslators(NewChanDef)
   os.ts.time()
   for TransType,Guid in pairs(TranList) do
      local Start = os.ts.time()
      local ZipData = BuildTransZip(RepoDir, Definition..'_'..TransType, Guid, ScratchDir)
      local EndTime = os.ts.time()
      trace(EndTime-Start)
      os.ts.time()
      Api:importProject{project=ZipData, guid=Guid, sample_data='replace', live=true}
      os.ts.time()
      Api:saveProjectMilestone{guid=Guid, milestone_name='Channel Manager '..os.date(), live=true}
      os.ts.time()
   end
   os.ts.time()
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

function iguana.channel.export(T)
   local Result = {}
   local Api = T.api
   local ChannelName = T.name
   local ChanDef = Api:getChannelConfig{name=ChannelName, live=true}
   Result[ChannelName..'.xml'] = tostring(ChanDef) 
   local TranList = iguana.channel.getTranslators(ChanDef)
   for TranType,GUID in pairs(TranList) do 
      local ZipContent = Api:exportProject{guid=GUID, live=true}
      ExpandTranslatorZip(Result, GUID, ChannelName.."_"..TranType, ZipContent)
   end
   return Result
end

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
