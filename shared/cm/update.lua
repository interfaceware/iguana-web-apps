local basicauth = require 'basicauth'
if not cm then cm = {} end
if not cm.update then cm.update = {} end

function cm.update.list()
   local Config = cm.app.config();
end

local function RetrieveLib(LibTree)
   
end

--Only for hardcoded spinner data files
--Delete when finished
local function FormatTransFiles(Tree, Name)
   local TestData = ''
   for K, V in pairs(Tree) do
      if type(V) == 'string' then
         Tree[K] = nil
      end
      if K == Name .. '_http' then
         Tree['main.lua'] = V["main.lua"]
         TestData = V["samples.json"]
         Tree[K] = nil
      end
   end
   Tree.other = {}
   return Tree, TestData
end


function cm.update.spin(Self, R)
   local Files = RetrieveLib({['shared'] = {['iguana'] = {['channel'] = true},
                              ['iguanaServer'] = true,
                              ['lib'] = {['webserver'] = true},
                              ['file'] = true}})
   local GUID = iguana.channelGuid()
   local Credentials = basicauth.getCredentials(Self)
   local Host = {['local'] = {}}
   Host['local']['host'] = iguana.webInfo().ip
   Host['local']['port'] = iguana.webInfo().web_config.port
   Host['local']['https'] = iguana.webInfo().web_config.use_https
   Host['local']['user'] = Credentials.username
   Host['local']['pass'] = Credentials.password
   local Spinner = spin.getSpinner(Host)
   local SpinnerNode = Spinner:getNode()
   local Translator = SpinnerNode:getTranslator()
   local ZipData = iguana.channel.export{api = iguanaServer.connect(Credentials), name = "Spun Up Channel"}
   _, SampleData = FormatTransFiles(ZipData, "Spun Up Channel")
   Translator:overload(ZipData)
   Translator:baseUrl()
   --Translator:run({[1] = json.parse{data=SampleData}.Samples[1].Message})
   return { Address = Translator:baseUrl(), Path = ''}
end