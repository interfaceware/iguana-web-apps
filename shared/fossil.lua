require 'file'
require 'stringutil'
local basicauth = require 'basicauth'

fossil = {}

function fossil.buildFileTree()
   
end

local function EscapeChar(Name)
   return Name:gsub("[ !-.:_]", "\\%1")  
end

local function ReturnEmptyFolder()
   for i = 0, 100 do
      local Rnd = math.random(0, 1e6)
      --local FolderPath = os.fs.tempDir()..Rnd..'/'
      local FolderPath = os.fs.tempDir()..'11111'..'/'
      if not os.fs.dirExists(FolderPath) then
         os.fs.mkdir(FolderPath)
         --return FolderPath
      end
      return os.fs.tempDir()..'11111'..'/'
   end
   error("Maximum folders created")
end

function fossil.openNewInstance(Data)
   local F = {}
   F.path = ReturnEmptyFolder()
   local P, Out = ""
   if not os.fs.access(F.path..'_FOSSIL_') then
      P = io.popen{['dir'] = F.path,['command'] = iguana.workingDir()..'fossil', 
         ['arguments'] = "open "..iguana.workingDir()..'vcs_repo.sqlite'}      
      Out = P:read('*a')
   end
   os.execute{['dir'] = F.path,['command'] = iguana.workingDir()..'fossil', ['arguments'] = "close "}
   fossil.convertGUID(Data, F)
   return F
end

local function RenameDir (F, Oldname, Newname)
   --Newname = Newname:gsub(" ", "/ ")
   if os.fs.dirExists(F.path..Newname) then
      os.fs.cleanDir(F.path..Newname)
      os.fs.rmdir(F.path..Newname)
   end
   local P = io.popen{['dir'] = F.path, ['command'] = 'mv', 
      ['arguments'] = Oldname.. ' ./' .. EscapeChar(Newname)}
end

function fossil.convertGUID(R, F)
   local WebInfo = iguana.webInfo()
   local Protocol = iguana.webInfo().web_config.use_https and 'https' or 'http'  
   local XMLConfig = net.http.get{url=Protocol..'://'..WebInfo.ip..":"..
      WebInfo.web_config.port..'/get_server_config', 
      live=true, auth=basicauth.getCredentials(R)}
   XMLConfig = xml.parse{data=XMLConfig}
   local ChannelList = XMLConfig.iguana_config.channel_config
   for i = 1, #ChannelList do
      local Channel = ChannelList[i]
      local ChannelName = Channel.name
      local Mapping = iguana.channel.returnGUID(Channel)
      for K, V in pairs(Mapping) do
         RenameDir (F, V, ChannelName..'_'..K)
      end
      RemoveGuids{['channel'] = ChannelList[i]}
      os.fs.writeFile(F.path..ChannelName..'.xml' , tostring(ChannelList[i]))
   end
end