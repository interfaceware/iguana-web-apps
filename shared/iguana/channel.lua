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


local function CopyFileList(FileList)
   for i=1, #FileList do
      local Content = os.fs.readFile(FileList[i].from)
      os.fs.writeFile(FileList[i].to, Content)
   end
end

function ZipFileList(ScratchDir)
   local P = io.popen{dir=ScratchDir, command='zip', arguments="-r project.zip *"}
   local Content = P:read('*a')
end

local function BuildTransZip(RepoDir, ProjectDir, TargetGuid, ScratchDir)
   local FileList = {}
   local MainDir = RepoDir..'/'..ProjectDir..'/'
   for K,V in os.fs.glob(MainDir..'*') do
      FileList[#FileList+1] = {from=K, to=ScratchDir..'/'..TargetGuid..'/'..K:sub(#MainDir+1)}
   end
   local P = ProjectFile(MainDir)
   for i = 1, #P.OtherDependencies do 
      FileList[#FileList+1] = {from=RepoDir..'/other/'..P.OtherDependencies[i]}
      FileList[#FileList].to = ScratchDir..'/other/'..P.OtherDependencies[i]
   end
   for i = 1, #P.LuaDependencies do 
      FileList[#FileList+1] = {from=RepoDir..'/shared/'..P.LuaDependencies[i]:gsub("%.", '/')..'.lua'}
      FileList[#FileList].to = ScratchDir..'/shared/'..P.LuaDependencies[i]:gsub("%.",'/')..'.lua'
   end
   trace(FileList)
   CopyFileList(FileList)
   ZipFileList(ScratchDir)
   local ZipData = os.fs.readFile(ScratchDir..'/project.zip')
   os.fs.cleanDir(ScratchDir)
   return filter.base64.enc(ZipData)
end

function iguana.channel.add(T)
   local RepoDir = T.dir
   local Definition = T.definition
   local Api = T.api
   local ScratchDir = T.scratch
   
   local ChanDef = ChannelDefinition(RepoDir, Definition)
   if T.name then 
      ChanDef.channel.name = T.name
   end
   
   local NewChanDef = Api:addChannel{config=ChanDef, live=true}
   local TranList = iguana.channel.getTranslators(NewChanDef)
   for TransType,Guid in pairs(TranList) do
      local Start = os.ts.time()
      local ZipData = BuildTransZip(RepoDir, Definition..'_'..TransType, Guid, ScratchDir)
      local EndTime = os.ts.time()
      trace(EndTime-Start)
      Api:importProject{project=ZipData, guid=Guid, sample_data='replace', live=true}
      Api:saveProjectMilestone{guid=Guid, milestone_name='Channel Manager '..os.date(), live=true}
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
