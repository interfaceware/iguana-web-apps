require 'web.file'
require 'iguana.channel'
require 'iguanaServer'

-- Notice we carefully only do a local include of this module to avoid poluting the global namespace.
local basicauth = require 'web.basicauth'

cm = {}

cm.app = {}

require 'listChannels'
require 'config'

function cm.app.importList(R)
   local Config = cm.config.open()
   if #Config.config.locations == 0 then
      return {dir="<none defined>", err='Repository does not exist'}
   end
   local RepoIndex = R.params.repository +1
   if RepoIndex > #Config.config.locations then  
      RepoIndex = 1
   end  
   
   local Repository = Config.config.locations[RepoIndex].Dir;
   trace(Repository)
   if not os.fs.dirExists(Repository) then
      return {dir=os.fs.name.toNative(Repository), 
               err='Repository does not exist'}
   end
   local L = {name={}, description={}} 
   for K, V in os.fs.glob(Repository..'/*.xml') do
      local CD = os.fs.readFile(K)
      local X = xml.parse{data=CD}
      L.name[#L.name+1] = X.channel.name
      L.description[#L.description+1] = X.channel.description
   end
   return {repository=Config:repoList(), list=L}
end

function cm.app.addChannel(R)
   local ChannelName = R.params.name
   local From = R.params.with
   local RepoIndex = R.params.repository
   
   local Config = cm.config.open()
   local Dir = Config.config.locations[RepoIndex+1].Dir
   
   local Credentials = basicauth.getCredentials(R)
   local Api = iguanaServer.connect(Credentials)

   if (iguana.channel.exists(ChannelName)) then
      Api:stopChannel{name=ChannelName}
      Api:removeChannel{name=ChannelName}
   end
   
   iguana.channel.add{dir=Dir, 
      definition=ChannelName, api=Api}
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
   local RepoIndex = R.params.repository

   local Credentials = basicauth.getCredentials(R)
   local Api = iguanaServer.connect(Credentials)

   local D = iguana.channel.export{api=Api, name=ChannelName, sample_data=(R.params.sample_data == "true")}
   local Config = cm.config.open()
   
   local R = pcall(WriteFiles, Config.config.locations[RepoIndex+1].Dir, D)
   if R then
      return {['success'] = true}
   else
      error('There was a problem exporting the selected channel.')
   end
end

function cm.app.listRepo(R,App)
   local Config = cm.config.open()
   return Config:repoList()
end

-- Trims white space on both sides.
function string.trimWS(self)
   return self:match('^%s*(.-)%s*$')
end

-- We try and eliminate repositories which do not exist
function cm.app.saveRepo(R,App)
   local Info = json.parse{data=R.body}
   local List = {}
   for i=1, #Info do
      local Repo = os.fs.name.fromNative(Info[i].Dir)
      Repo = Repo:trimWS()
      local temp = {};
      if (#Repo > 0) then
         temp.Name = Info[i].Name
         temp.Dir = Repo
         List[i] = temp
      end
   end
   local Config = cm.config.open()
   Config.config.locations = List
   Config.config.repo = nil
   Config:save()
   return {status='ok'}
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
   ['listRepo'] = cm.app.listRepo,
   ['saveRepo'] = cm.app.saveRepo
}
