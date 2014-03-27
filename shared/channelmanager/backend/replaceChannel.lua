local iguanaServer = require "iguanaServer"
channelmanager.backend.import = {}

local lm = channelmanager.backend.import
local cm = channelmanager

function channelmanager.backend.replaceChannel(R)
   local Remove = R.params.name:lower()
   local Replace = R.params.with
   trace(Remove, Replace)
   
   local ScratchDir = cm.utils.scratchDir()
   local RepoDir = cm.config.channelExportPath

   local RemoveCfg = lm.findChannelToRemove(Remove)
   trace(RemoveCfg)
   
   local ReplaceXml = cm.utils.readFile(RepoDir.."/"..Replace..".xml")
   ReplaceCfg = xml.parse{data=ReplaceXml}
   local ReplaceInfo = cm.utils.channelInfo(ReplaceCfg.channel)
   
   lm.import(ReplaceInfo, RemoveCfg)

   return {}
end

function lm.import(ChanDef, RemoveChannel)
   local Name = cm.utils.cleanChannelName(ChanDef.name)
   -- TODO change channelExportPath --> channelExportDir

   local Web = iguana.webInfo()
   
   local ChAPI = iguanaServer.connect{
   url='http://localhost:'..Web.web_config.port,
   username='admin', password='password'}
   
   --[[
   local ChAPI = iguanaServer.connect{
      url='http://localhost:6545',
      username='admin', password='password'}
   ]]
   
   lm.stopAndRemoveChannel(ChAPI, RemoveChannel)
   local NewConf = lm.createChannel(ChAPI, ChanDef)
   local NewChInfo = cm.utils.channelInfo(NewConf) 

   for CompType, Guid in pairs(ChanDef.trans_guids) do
      local MainDir = cm.config.channelExportPath..'/'..Name..'_'..CompType
      local FileList = lm.buildTranZip(MainDir, Guid, ChanDef, CompType)
      lm.importComponent(ChAPI, CompType, NewChInfo.trans_guids[CompType])
      lm.cleanFileList(FileList)
   end
end
function lm.findChannelToRemove(ChannelName)
   local ServerConf = xml.parse{data=iguana.status()}.IguanaStatus
   for i = 1, ServerConf:childCount("Channel") do
      local Ch = ServerConf:child("Channel", i)
      if Ch.Name:nodeValue():lower() == cm.utils.undoCleanChannelName(ChannelName) then
         trace(Ch.Name)
         return Ch
      end
   end
end


function lm.projectFile(MainDir)
   local ProjectName = MainDir.."/project.prj"
   local D = channelmanager.utils.readFile(ProjectName)
   return json.parse{data=D}
end

function lm.buildTranZip(MainDir, Guid, ChanDef, Component)
   local FileList = {}
   for K,V in os.fs.glob(MainDir..'/*') do
      FileList[#FileList+1] = {from=K, to=channelmanager.config.scratchDir..'/'..Guid..K:sub(#MainDir+1)}
   end
   local P = lm.projectFile(MainDir)
   for i = 1, #P.OtherDependencies do 
      FileList[#FileList+1] = {from=channelmanager.config.channelExportPath..'/other/'..P.OtherDependencies[i]}
      FileList[#FileList].to = channelmanager.config.scratchDir..'/other/'..P.OtherDependencies[i]
      
   end
   for i = 1, #P.LuaDependencies do 
      FileList[#FileList+1] = {from=channelmanager.config.channelExportPath..'/shared/'..P.LuaDependencies[i]:gsub("%.", "/")..'.lua'}
      FileList[#FileList].to = channelmanager.config.scratchDir..'/shared/'..P.LuaDependencies[i]:gsub("%.", "/")..'.lua'
   end
   trace(FileList)
   lm.copyFileList(FileList)
   local Zipfile = lm.zipFileList(cm.config.scratchDir, Component)
   FileList[#FileList+1] = {to=Zipfile}
   return FileList
end
 
function lm.stopAndRemoveChannel(ChAPI, ChanDef)
   local x,y = pcall(ChAPI.stopChannel, ChAPI, {name=ChanDef.Name:nodeValue(), live=true})
   trace(x,y)
   local a,b = pcall(ChAPI.removeChannel, ChAPI, {name=ChanDef.Name:nodeValue(), live=true})
   trace(a,b)
end

function lm.createChannel(ChAPI, ChanDef)
   local C = ChAPI:addChannel{
      config=ChanDef.config, live=true
   }.channel 
   return C   
end

function lm.importComponent(ChAPI, CompType, NewGuid)
   local ZipFile = app.config.scratchDir.."/"..CompType..".zip"
   trace(ZipFile)
   ChAPI:importProject{source_file=ZipFile, guid=NewGuid, live=true}
end

function lm.copyFileList(FileList)
   for i=1, #FileList do
      local Content = cm.utils.readFile(FileList[i].from)
      cm.utils.writeFile(FileList[i].to, Content)
   end
end

function lm.zipFileList(ScratchDir, Component)
   local ZipFile = Component..".zip"
   local Cmd = "cd "..ScratchDir.." && zip -r "..ZipFile.. " *"
   os.execute(Cmd)
   return ScratchDir.."/"..ZipFile
end

function lm.cleanFileList(FileList)
   local SimpleFileList = {}
   for i=1, #FileList do
      os.remove(FileList[i].to)
      SimpleFileList[#SimpleFileList+1] = FileList[i].to
   end
   channelmanager.utils.cleanDirList(SimpleFileList, channelmanager.config.scratchDir)
end
