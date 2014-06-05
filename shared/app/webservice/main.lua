local basicauth = require 'basicauth'

app = {}
app.webservice = {}
app.webservice.main = {}
app.webservice.actions = {}

function app.webservice.main.initHelp()
   
end

local function ExistsInTable(val, t)
   for i=1,#t do
      if t[i] == val then
         return true
      end
   end
   return false
end

function findfunction(filename, table)
   
end

function app.webservice.actions.setHelp(R, App)
   local HelpData = R.body
   local T = json.parse{data=HelpData}
   local CallName = App.root .. "."..T.call
   FilePath = 'help/'..CallName:gsub("%.", "/")..'.json'
   local UserName = basicauth.getCredentials(R).username;
   local FileName = iguana.workingDir()..'edit/'..UserName..'/other/'..FilePath
   trace(FileName)
   trace(FilePath)
   trace(CallName)
   os.fs.writeFile(FileName, HelpData)
   local Config = xml.parse{data=iguana.channelConfig{guid=iguana.channelGuid()}}
   local TranslatorGuid = Config.channel.from_http.guid:nodeValue()
   local ProjectPath = iguana.workingDir()..'edit/'..UserName..'/'..TranslatorGuid..'/project.prj'
   
   trace(ProjectPath)
   local Project = os.fs.readFile(ProjectPath)
   Project = json.parse{data=Project}
   
  if (not ExistsInTable(FilePath, Project.OtherDependencies)) then
      table.insert(Project.OtherDependencies,FilePath)
      os.fs.writeFile(ProjectPath, json.serialize{data=Project})
   end
   os.fs.writeFile(FileName, json.serialize{data=T})
   CallName = CallName:split("%.")
   trace(CallName)
   local location = _G
   for i =1, #CallName do
      location = location[CallName[i]]
   end
   help.set{input_function=location, help_data=T}
   return {status="ok"}
end

return app
