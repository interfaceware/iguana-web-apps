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
      return {state="accessing directory", err='Repository does not exist'}
   end
   local RepoIndex = R.params.repository +1
   if RepoIndex > #Config.config.locations then  
      RepoIndex = 1
   end  
   
   local Repository = Config.config.locations[RepoIndex];
   
   if not os.fs.dirExists(Repository.Source) then
      os.fs.mkdir(Repository.Source)
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

function OnlyWriteChangedFile(FileName, Content)
   if os.fs.access(FileName) then
      local CurrentContent = os.fs.readFile(FileName)
      if CurrentContent == Content then
         return
      end
   end
   trace(FileName)
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

function cm.app.exportlist(R, Channel)
   local ChannelName = Channel.name
   local Credentials = basicauth.getCredentials(R)
   local Api = iguanaServer.connect(Credentials)
   local D = iguana.channel.export{api=Api, name=ChannelName, sample_data=(Channel.sample_data)}
   return D
end

local function Merge(t1, t2)
   for k, v in pairs(t1) do
      if (type(t2) == 'nil') or (type(t2[k]) == 'nil') then
      elseif (type(v) == "table") and (type(t2[k]) == "table") then
         Merge(t1[k], t2[k])
      else 
         t1[k] = t2[k]
      end
   end
   return t1
end

function cm.app.import(R)
   local data = json.parse{data=R.body}
   local Credentials = basicauth.getCredentials(R)
   local Api = iguanaServer.connect(Credentials)
   
   for k,v in ipairs(data.data) do 
      local ChannelName = v.name
      if (iguana.channel.exists(ChannelName)) then
         Api:stopChannel{name=ChannelName, live=true}
         Api:removeChannel{name=ChannelName, live = true}
      end
      local XmlConfig = xml.parse{data= next(v.data) and v.data[ChannelName .. '.xml'].data or os.fs.readFile(data.target .. ChannelName .. '.xml')}
      v.data[ChannelName .. '.xml'] = nil
      local NewChanDef = Api:addChannel{config=XmlConfig, live=true}
      local TranList = iguana.channel.getTranslators(NewChanDef)
      for TransType,Guid in pairs(TranList) do
         local Start = os.ts.time()
         local _, ZipData = BuildTransZip(data.target, ChannelName..'_'..TransType, Guid)
         ZipData = Merge(ZipData, v.data)
         ZipData = filter.base64.enc(filter.zip.deflate(ZipData))
         local EndTime = os.ts.time()
         trace(EndTime-Start)
         Api:importProject{project=ZipData, guid=Guid, sample_data='replace', live=true}
         Api:saveProjectMilestone{guid=Guid, milestone_name='Channel Manager '..os.date(), live=true}
      end
   end   
   return {status = 'success'}
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

function cm.app.updateRepo(R)
   local Config = cm.config.open()
   if #Config.config.locations == 0 then
      return {state="accessing directory", err='Repository does not exist'}
   end
   for Counter, Repository in ipairs(Config.config.locations) do
      if not os.fs.dirExists(Repository.Source) then
         os.fs.mkdir(Repository.Source)
      end
      if Repository.Type == 'GitHub-ReadOnly' or Repository.Type == 'Default' then
         local GitHubLink = Repository.RemoteSource:split('/')
         local commits, commitstatus = net.http.get{url='https://api.github.com/repos'.. Repository.RemoteSource ..'commits',
            --auth = {username = 'db6a50027c3000fcad2d0816e22423d31dd7bf54', password = ''},
            headers={['Accept'] = 'application/vnd.github.v3+json', ['User-Agent'] = GitHubLink[3]},
            live=true}
         if (commitstatus >= 400) then 
            return {state = 'accessing repository commit information', err= commits .. " Error "..commitstatus}
         else
            local err = cm.githelper.comparecommits(json.parse{data=commits}, Repository.Source, 'https://github.com'.. 
               Repository.RemoteSource .. 'archive/master.zip')
            if err then return err end
         end
      end
   end
   return {status = "ok"}
end


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
   ['updateRepo'] = cm.app.updateRepo
}
