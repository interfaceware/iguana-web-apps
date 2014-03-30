function ChannelDef(ChannelName) 
   local FileName = channelmanager.config.channelExportPath.."/"..ChannelName..".xml"
   if not os.fs.access(FileName) then
      error("There is no channel in the repository called "..ChannelName);
   end
   return xml.parse{data=channelmanager.utils.readFile(FileName)}   
end

function channelmanager.backend.addChannel(R)
   local ChannelName = R.params.name
   local From = R.params.with
   return channelmanager.backend.addChannelImp(ChannelName, From)
end

function channelmanager.backend.addChannelImp(ChannelName, From)
   trace(ChannelName, From)
   local ChanApi = channelmanager.utils.channelApi()
   if channelmanager.utils.doesChannelExist(ChannelName) then
      error("Channel exists already.");
   end
   local ChanDef = ChannelDef(From)
   ChanDef.channel.name = ChannelName

   local NewChanDef = ChanApi:addChannel{config=ChanDef,live=true}
   
   local TranList = channelmanager.utils.translatorGuids(NewChanDef)
   local RepoDir = channelmanager.config.channelExportPath
   for K,V in pairs(TranList) do
      channelmanager.backend.buildTranZip(os.fs.addDir(RepoDir)..From..'_'..K, V)
      ChanApi:importProject{guid=V,source_file=channelmanager.config.scratchDir:addDir()..'project.zip',sample_data='replace', live=true}
      ChanApi:saveProjectMilestone{guid=V, milestone_name='Channel Manager '..os.date(), live=true}
   end
   return {message="Success"}
end

function channelmanager.backend.projectFile(MainDir)
   local ProjectName = os.fs.addDir(MainDir).."project.prj"
   local D = channelmanager.utils.readFile(ProjectName)
   return json.parse{data=D}
end

function channelmanager.backend.buildTranZip(MainDir, Guid)
   local FileList = {}
   for K,V in os.fs.glob(os.fs.addDir(MainDir)..'*') do
      FileList[#FileList+1] = {from=K, to=os.fs.addDir(channelmanager.config.scratchDir)..Guid..K:sub(#MainDir+1)}
   end
   local P = channelmanager.backend.projectFile(MainDir)
   for i = 1, #P.OtherDependencies do 
      FileList[#FileList+1] = {from=channelmanager.config.channelExportPath:addDir()..('other'):addDir()..P.OtherDependencies[i]}
      FileList[#FileList].to = channelmanager.config.scratchDir:addDir()..('other'):addDir()..P.OtherDependencies[i]:gsub('/', os.fs.dirSep())
   end
   for i = 1, #P.LuaDependencies do 
      FileList[#FileList+1] = {from=channelmanager.config.channelExportPath:addDir()..('shared'):addDir()..P.LuaDependencies[i]:gsub("%.", os.fs.dirSep())..'.lua'}
      FileList[#FileList].to = channelmanager.config.scratchDir:addDir()..'shared'..os.fs.dirSep()..P.LuaDependencies[i]:gsub("%.", os.fs.dirSep())..'.lua'
   end
   trace(FileList)
   channelmanager.backend.copyFileList(FileList)
   channelmanager.backend.import.zipFileList(channelmanager.config.scratchDir, 'project')
   channelmanager.backend.import.cleanFileList(FileList)
end

function channelmanager.backend.copyFileList(FileList)
   for i=1, #FileList do
      local Content = channelmanager.utils.readFile(FileList[i].from)
      channelmanager.utils.writeFile(FileList[i].to, Content)
   end
end


