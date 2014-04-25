require 'file'
require 'stringutil'
require 'iguana.channel'
require 'node'
require 'iguanaServer'

cm = {}
cm.config = {}

-- Use posix file conventions.
cm.config.channelExportPath = 'D:/community/iguana-web-apps/'
cm.config.scratchDir = os.fs.tempDir()..'/channelmanager/'
cm.app = {}

require 'cm.app.listChannels'
require 'cm.config'

-- TODO - user should login to provide the user name and password

cm.config.username = 'admin'
cm.config.password = 'password'

function cm.app.importList(R) 
   local L = {}
   for K, V in os.fs.glob(cm.config.channelExportPath..'/*.xml') do
      local N = K:split("/")
      N = N[#N]
      N = N:sub(1, #N-4)
      L[#L+1] = N
   end
   return L
end

-- Only returning the information on the export path
-- It's important that we make the web api of this application modular and orthonal
function cm.app.configInfo(Request)
   return {ExportPath = os.fs.name.toNative(cm.config.channelExportPath)}
end

function cm.app.addChannel(R)
   local ChannelName = R.params.name
   local From = R.params.with
   local Api = iguanaServer.connect{username=cm.config.username, 
                     password=cm.config.password}

   iguana.channel.add{dir=cm.config.channelExportPath, 
      definition=ChannelName, api=Api, scratch=cm.config.scratchDir}
   return {success=true}
end

local TextFile={
   [".lua"]=true,   
   [".js"]=true,
   [".xml"]=true,
   [".css"]=true,
   [".vmd"]=true,
   [".html"]=true,
   [".htm"]=true,
   [".json"]=true
}

local function IsText(FileName)
   local Ext = FileName:match('.*(%.%a+)$')
   return TextFile[Ext]      
end

local function ConvertLF(Content)
   Content = Content:gsub('\r\n', '\n')
   return Content
end

local function OnlyWriteChangedFile(FileName, Content)
   if os.fs.access(FileName) then
      local CurrentContent = os.fs.readFile(FileName)
      if CurrentContent == Content then
         return
      end
   end
   trace(FileName)
   os.fs.writeFile(FileName, Content, 666)
end

local function WriteFiles(Root, Tree)
   for Name, Content in pairs(Tree) do
      if type(Content) == 'string' then
         local FileName = Root..'/'..Name
         if IsText(FileName) then
            Content = ConvertLF(Content)            
         end
         OnlyWriteChangedFile(FileName, Content)
      elseif type(Content) == 'table' then
          WriteFiles(Root..'/'..Name, Content)
      end
   end
end

function cm.app.export(R)
   local ChannelName = R.params.name
   local Api = iguanaServer.connect{username=cm.config.username, 
                     password=cm.config.password}

   local D = iguana.channel.export{api=Api, 
                         scratch=cm.config.scratchDir, name=ChannelName}
   
   WriteFiles(cm.config.channelExportPath, D)
   return D
end

function cm.app.listRepo(R,App)
   
   return App.config.config.repo
end

function cm.app.create()
   local App ={}
   App.config = cm.config.open()
   return App
end

cm.actions = {
   ['config_info'] = cm.app.configInfo,
   ['list-channels'] = cm.app.listChannels,
   ['export_channel'] = cm.app.export,
   ['importList'] = cm.app.importList,
   ['addChannel']= cm.app.addChannel,
   ['listRepo'] = cm.app.listRepo
}
