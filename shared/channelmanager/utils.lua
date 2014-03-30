channelmanager.utils = {}

local lm = channelmanager.utils

function lm.translatorGuids(ChannelConfig)
   local Info = {}   
   local C = ChannelConfig.channel;
   if C.to_mapper then
      Info.to = Ch.to_mapper.guid:nodeValue()
   end
   if C.from_mapper then
      Info.from = C.from_mapper.guid:nodeValue()
   end
   if C.use_message_filter:S() == 'yes' and C.message_filter and
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

function lm.scratchDir()
   local Tmp = channelmanager.config.scratchDir
   if not os.fs.stat(Tmp) then
      os.fs.mkdir(Tmp)
   end
   return Tmp
end

function lm.readFile(FileName)
   local F = io.open(FileName, "r")
   local Content = F:read('*a');
   F:close();
   return Content
end

function lm.writeFile(FileName, Content)
   local Parts = FileName:split(os.fs.dirSep())
   local Dir = ''
   for i = 1, #Parts-1 do
      Dir = Dir..os.fs.addDir(Parts[i])
      trace(Dir)
      if not os.fs.dirExists(Dir) then
         os.fs.mkdir(Dir)
      end
   end
   local F = io.open(FileName,"w")
   F:write(Content)
   F:close()
end

function lm.removeDir(D)
   local Success, ErrMessage = pcall(os.fs.rmdir, D)
   if not Success then iguana.logInfo(ErrMessage) end
end

function lm.deleteDir(DTree, Parent)
   local Count = 0
   local Parent = Parent or ''
   for K,V in pairs(DTree) do
      trace(K,V)
      lm.deleteDir(V, Parent..K:addDir())
   end
   lm.removeDir(Parent)
end

-- TODO THIS ROUTINE NEEDS CHECKING UNDER POSIX
function lm.cleanDirList(FileList, Root)
   local DTree = {}
   for i=1, #FileList do
      local Parts = FileList[i]:sub(#Root+1):split(os.fs.dirSep())
      local Dir = ''
      Tree = DTree
      for j=1, #Parts-1 do
         Dir = Dir..Parts[j]:addDir()
         trace(Dir)
         if not Tree[Parts[j]] then
            Tree[Parts[j]] = {}
         end
        
         Tree = Tree[Parts[j]]
         if (#Dir > #channelmanager.config.scratchDir and Dir:sub(1, 
                  #channelmanager.config.scratchDir) == channelmanager.config.scratchDir) then
             DirList[Dir] = ''
         end
        
      end
      trace(DTree)
   end
   trace(DTree)
   lm.deleteDir(DTree, Root:addDir())
end

function lm.doesChannelExist(Name)
   local X = xml.parse{data=iguana.status()}
   for i = 1, X.IguanaStatus:childCount("Channel") do
      local C = X.IguanaStatus:child("Channel", i)
      if tostring(C.Name) == Name then
         return true;
      end
   end
   return false
end

function lm.isNullGuid(Guid)
   return Guid:nodeValue() 
       == '00000000000000000000000000000000'
end

function lm.cleanChannelName(Name)
   return tostring(Name):gsub(" ", "_"):lower()
end

function lm.undoCleanChannelName(Name)
   return tostring(Name):gsub("_", " "):lower()
end

function lm.channelApi()
   local Web = iguana.webInfo()
   return iguanaServer.connect{url='http://localhost:'..Web.web_config.port, 
      username=channelmanager.config.username, 
      password=channelmanager.config.password}
end

function string.split(s, d)
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