channelmanager.backend.import = {}

local lm = channelmanager.backend.import
local cm = channelmanager
local iguanaServer = require("iguanaServer")

function lm.action(R)
   local ChannelName = R.params.channel
   local ScratchDir = cm.utils.scratchDir()
   local RepoDir = cm.config.channelExportPath
   local ChannelDef = cm.utils.readFile(RepoDir.."/"..ChannelName..".xml")
   ChannelDef = xml.parse{data=ChannelDef}
   lm.importFromHttpTrans(ChannelDef)
   ChannelDef.channel.name = ChannelName
   lm.doImport(cm.config.scratchDir, ChannelDef, ChannelName)
end

function lm.importFromHttpTrans(ChanDef)
   if (ChanDef.channel.from_http 
         and ChanDef.channel.from_http.type:nodeValue() == 'mapper' 
         and not cm.utils.isNullGuid(ChanDef.channel.from_http.guid)) then
      -- We have a HTTP component
      local Guid = ChanDef.channel.from_http.guid:nodeValue()
      local Name = cm.utils.cleanChannelName(ChanDef.channel.name)
      -- TODO change channelExportPath --> channelExportDir
      local MainDir = cm.config.channelExportPath..'/'..Name..'_http'
      lm.buildTranZip(MainDir, Guid, ChanDef)
   end
end

function lm.projectFile(MainDir)
   local ProjectName = MainDir.."/project.prj"
   local D = channelmanager.utils.readFile(ProjectName)
   return json.parse{data=D}
end

function lm.buildTranZip(MainDir, Guid, ChanDef)
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
   lm.zipFileList(cm.config.scratchDir)
   --lm.cleanFileList(FileList)
end

function lm.doImport(ScratchDir, ChanDef, ChannelName)
   local Web = iguana.webInfo()
   local ChAPI = iguanaServer.connect{
      url='http://localhost:'..Web.web_config.port,
      username='admin', password='password'}

   pcall(ChAPI.removeChannel, ChAPI, {name=ChannelName, live=true})
   local NewChan = ChAPI:addChannel{config=ChanDef, live=true}   
   
   -- import the project. Need to handle all translator comonents.
   local Res = ChAPI:importProject{guid=NewChan.channel.from_http.guid:nodeValue(), source_file=cm.config.scratchDir.."/project.zip", live=true}
   ChAPI:saveProjectMilestone{guid=NewChan.channel.from_http.guid:nodeValue(), milestone_name='Channel import '..os.ts.date()}
end

function lm.updateChannel(ChAPI, ChanDef)
   local NewCfg = ChAPI:updateChannel{
      config=ChanDef, live=true
   }.channel
   return NewCfg
end

function lm.addNewChannel(ChAPI, ChanDef)
   local C = ChAPI:addChannel{
      config=ChanDef, live=true
   }.channel 
   return C
end

function lm.copyFileList(FileList)
   for i=1, #FileList do
      local Content = cm.utils.readFile(FileList[i].from)
      cm.utils.writeFile(FileList[i].to, Content)
   end
end

function lm.createFile(LongFileName)
   
end

function lm.zipFileList(ScratchDir)
   os.execute("cd "..ScratchDir.." && zip -r project.zip *")
end

function lm.__cleanFileList(ScratchDir)
   for k,v in os.fs.glob(ScratchDir.."/*") do
      if v.isdir then
         lm.cleanFileList(k.."/*")
      end
   end
end

function lm.cleanFileList(FileList)
   local SimpleFileList = {}
   for i=1, #FileList do
      os.remove(FileList[i].to)
      SimpleFileList[#SimpleFileList+1] = FileList[i].to
   end
   channelmanager.utils.cleanDirList(SimpleFileList, channelmanager.config.scratchDir)
end

function basename(Dir)
  
end


