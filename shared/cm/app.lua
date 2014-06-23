require 'file'
require 'stringutil'
require 'iguana.channel'
require 'node'
require 'iguanaServer'

-- Notice we carefully only do a local include of this module to avoid poluting the global namespace.
local basicauth = require 'basicauth'

cm = {}

cm.app = {}

require 'cm.app.listChannels'
require 'cm.config'
require 'cm.githelper'

function cm.app.importList(R)
   local Config = cm.config.open()
   if #Config.config.locations == 0 then
      return {dir="<none defined>", err='Repository does not exist'}
   end
   local RepoIndex = R.params.repository +1
   if RepoIndex > #Config.config.locations then  
      RepoIndex = 1
   end  
   
   local Repository = Config.config.locations[RepoIndex];

   if not os.fs.dirExists(Repository.Src) then
      return {dir=os.fs.name.toNative(Repository.Src), 
               err='Local repository does not exist'}
   end
   if Repository.Type == 'github' then
      local commits, commitstatus = net.http.get{url='https://api.github.com/repos/kevincai3/iguana-web-apps/commits', headers={['Accept'] = 'application/vnd.github.v3+json', ['User-Agent'] = 'kevincai3'}, auth={username = '43506a1ef19c75250326594609dcecba3bf88f55', password=''}, live=true}
      if (commitstatus >= 400) then 
         return {link = 'Hi', err="Bad URL. Error"..commitstatus}
      else
         local rtn = cm.githelper.comparecommits(json.parse{data=commits}, Repository.Src, Repository.RemoteSrc)
         if rtn then return rtn end
      end
   end
   local L = {name={}, description={}} 
   for K, V in os.fs.glob(Repository.Src ..'/*.xml') do
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
   local Dir = Config.config.locations[RepoIndex+1].Src
   
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

function cm.app.WriteFiles(Root, Tree)
   for Name, Content in pairs(Tree) do
      if type(Content) == 'string' then
         local FileName = Root..'/'..Name
         if IsText(FileName) then
            Content = ConvertLF(Content)            
         end
         OnlyWriteChangedFile(FileName, Content)
      elseif type(Content) == 'table' then
          cm.app.WriteFiles(Root..'/'..Name, Content)
      end
   end
end

local function comparedata(server, client)
   local result = {}
   for k, v in pairs(client) do
      if type(v) == 'table' then
         result[k] = comparedata(server[k], client[k])
      else
         if (v == "data") and server[k] then
            result[k] = server[k]
         else 
            result[k] = v
         end  
      end       
   end
   return result
end


function cm.app.exportlist(R, Channel)
   local ChannelName = Channel.name
   
   local Credentials = basicauth.getCredentials(R)
   local Api = iguanaServer.connect(Credentials)

   local D = iguana.channel.export{api=Api, name=ChannelName, sample_data=(Channel.sample_data)}
   return D
end

function cm.app.export(R)
   local data = json.parse{data=R.body}
   local ChannelName = data.data.name
   
   local Credentials = basicauth.getCredentials(R)
   local Api = iguanaServer.connect(Credentials)

   local D = iguana.channel.export{api=Api, name=ChannelName, sample_data=false}
   local tree = comparedata(D, data.data.data)
   trace(tree)
   cm.app.WriteFiles(data.target, tree)
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
      local Repo = os.fs.name.fromNative(Info[i].Src)
      Repo = Repo:trimWS()
      local temp = {};
      if (#Repo > 0) then
         temp.Name = Info[i].Name
         temp.Src = Repo
         temp.RemoteSrc = Info[i].RemoteSrc
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

cm.actions = {
   ['config_info'] = cm.app.configInfo,
   ['list-channels'] = cm.app.listChannels.list,
   ['exportChannels'] = cm.app.export,
   ['importList'] = cm.app.importList,
   ['addChannel']= cm.app.addChannel,
   ['listRepo'] = cm.app.listRepo,
   ['saveRepo'] = cm.app.saveRepo,
   ['exportDiff'] = cm.app.listChannels.exportDiff
}
