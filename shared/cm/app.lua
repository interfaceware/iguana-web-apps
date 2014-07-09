require 'file'
require 'stringutil'
require 'iguana.channel'
require 'node'
require 'iguanaServer'
require 'fossil'
require 'spin'
-- Notice we carefully only do a local include of this module to avoid poluting the global namespace.
local basicauth = require 'basicauth'

cm = {}

cm.app = {}

require 'cm.app.listChannels'
require 'cm.config'
require 'cm.githelper'
require 'cm.app.help'
function cm.app.importList(R)
   local Config = cm.config.open()
   if #Config.config.locations == 0 then
      return {dir="accessing directory", err='Repository does not exist'}
   end
   local RepoIndex = R.params.repository +1
   if RepoIndex > #Config.config.locations then  
      RepoIndex = 1
   end  
   
   local Repository = Config.config.locations[RepoIndex];

   if not os.fs.dirExists(Repository.Source) then
      os.fs.mkdir(Repository.Source)
      --[[Name = os.fs.abspath()
      local Parts = Name:split('/')
      local Dir = ''
      for i = 1, #Parts-1 do
         Dir = Dir..Parts[i]..'/'
         if not os.fs.dirExists(Dir) then
            os.fs.mkdir(Dir, 777)
         end
      end]]
   end
   if Repository.Type == 'GitHub-ReadOnly' or Repository.Type == 'Default' then
      local GitHubLink = Repository.RemoteSource:split('/')
      local commits, commitstatus = net.http.get{url='https://api.github.com/repos'.. Repository.RemoteSource ..'commits', 
         headers={['Accept'] = 'application/vnd.github.v3+json', ['User-Agent'] = GitHubLink[3]}, 
         --auth={username = '43506a1ef19c75250326594609dcecba3bf88f55', password=''}, 
         live=true}
      if (commitstatus >= 400) then 
         return {state = 'accessing repository commit information', err= commits .. " Error "..commitstatus}
      else
         local err = cm.githelper.comparecommits(json.parse{data=commits}, Repository.Source, 'https://github.com'.. 
            Repository.RemoteSource .. 'archive/master.zip')
         if err then return err end
      end
   end
   local L = {name={}, description={}} 
   for K, V in os.fs.glob(Repository.Source ..'/*.xml') do
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
   local Dir = Config.config.locations[RepoIndex+1].Source
   
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

--MADE FUNCTION ALWAYS WRITE
local function OnlyWriteChangedFile(FileName, Content)
   --[[if os.fs.access(FileName) then
      local CurrentContent = os.fs.readFile(FileName)
      if CurrentContent == Content then
         return
      end
   end
   trace(FileName)]]
   os.fs.writeFile(FileName, Content, 666)
end

function cm.app.WriteFiles(Root, Tree)
   for Name, Content in pairs(Tree) do
      if Content.type == 'folder' then
         cm.app.WriteFiles(Root..Name..'/', Content.data)
      else
         local FileName = Root..'/'..Name
         if Content.type ~= "str" then
            Content.data = filter.base64.dec(Content.data)
         end
         OnlyWriteChangedFile(FileName, Content.data)
         end
      end
end

local function FlattenTree(Tree)
   local Rtn = {}
   for K, V in pairs(Tree) do
      if V.type == 'folder' then
         Rtn[V.name] = FlattenTree(V.data)
      else
         Rtn[V.name] = (V.type == 'str') and V.data or filter.base64.dec(V.data)
      end
   end
   return Rtn
end

--[[local function MergeTree (T1, T2)
   for K, V in pairs(T1) do
      if type(V) == 'table' then
         MergeTree (V, 
      else
         
   end
end]]--

function cm.app.exportlist(R, Channel)
   local ChannelName = Channel.name
   local Credentials = basicauth.getCredentials(R)
   local Api = iguanaServer.connect(Credentials)
   local D = iguana.channel.export{api=Api, name=ChannelName, sample_data=(Channel.sample_data)}
   return D
end

function cm.app.import(R)
   local data = json.parse{data=R.body}
   local Credentials = basicauth.getCredentials(R)
   local Api = iguanaServer.connect(Credentials)
   
   
end

function cm.app.export(R)
   local data = json.parse{data=R.body}
   for K, V in pairs(data.data) do 
      cm.app.WriteFiles(data.target, V)
   end
   return {['status'] = 'ok'}
end

function cm.app.listRepo(R,App)
   local Config = cm.config.open()
   return Config:repoList()
end

-- We try and eliminate repositories which do not exist
function cm.app.saveRepo(R,App)
   local Info = json.parse{data=R.body}
   local List = {}
   for i=1, #Info do
      local Repo = os.fs.name.fromNative(Info[i].Source)
      Repo = Repo:trimWS()
      local temp = {};
      if (#Repo > 0) then
         temp.Name = Info[i].Name
         temp.Source = Repo
         temp.RemoteSource = Info[i].RemoteSource
         temp.Type = Info[i].Type
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

local function ConnectToServer(R)
   local Webinfo = iguana.webInfo()
   local Protocol = Webinfo.https_channel_server.use_https and 'https://' or 'http://'
   local Serverurl = Protocol .. Webinfo.ip .. ":" .. Webinfo.web_config.port
   local Username = basicauth.getCredentials(R).username
   local Password = basicauth.getCredentials(R).password
   local Server = iguanaServer.connect{url=Serverurl,
      username=Username, password=Password}
   return Server
end

--[[function cm.app.update(R)
   local Server = ConnectToServer(R)
   local Config = Server:getChannelConfig{guid=iguana.channelGuid()}
   local Num = 0
   for i = Num, 20 do
      if not iguana.channel.exists(Config.channel.name .. i) then
         Config.channel.name = Config.channel.name .. i
         Num = i
         break
      end
      if i == 20 then return {['error'] = 'Maximum channel managers reached, please remove one of your previous channels.'} end
   end  
   Server:updateChannel{config=Config, username=Username, password=Password}
   --cm.app.addChannel(R)
   local NewConfig = Server:getChannelConfig{name='Channel Manager'}
   NewConfig.channel.from_http.mapper_url_path = NewConfig.channel.from_http.mapper_url_path:nodeValue():gsub('/', Num..'%1')
   Server:updateChannel{config=NewConfig}
   
end

function cm.app.cleanup(R)
   local Server = ConnectToServer(R)
   local Changes = {}
   for i = 0, 20 do
      local ChannelName = iguana.channelName() .. i      
      if iguana.channel.exists(ChannelName) then
         for j = i + 1, 20 do
            local RemoveName = iguana.channelName() .. j
            if iguana.channel.exists(RemoveName) then
               Changes[#Changes] = RemoveName
               Server:stopChannel{name=RemoveName}
               Server:removeChannel{name=RemoveName}
            end
         end
      end
   end
   return Changes
end]]

cm.actions = {
   ['config_info'] = cm.app.configInfo,
   ['list-channels'] = cm.app.listChannels.list,
   ['exportChannels'] = cm.app.export,
   ['importChannels'] = cm.app.import,
   ['importList'] = cm.app.importList,
   ['addChannel']= cm.app.addChannel,
   ['listRepo'] = cm.app.listRepo,
   ['saveRepo'] = cm.app.saveRepo,
   ['exportDiff'] = cm.app.help.exportDiff,
   ['importDiff'] = cm.app.help.importDiff,
   ['update'] = cm.app.update,
   ['cleanup'] = cm.app.cleanup
}
