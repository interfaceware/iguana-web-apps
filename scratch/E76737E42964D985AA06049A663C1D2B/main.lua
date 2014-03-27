--
-- The server and the app object are global.
--

server = require 'server.simplewebserver'
app = require 'channelmanager.backend'

function main(Data)
   --server.serveRequest(Data)
   importChannel()
   net.http.respond{body='oak'}
end

-- Draft code for import channel. Clean up and move to
-- proper method in channelmanager.backend.lua
function importChannel()
   -- Grab the channel config assuming we were
   -- passed the name of the directory (guid)
   local Guid = "EB004E5EB4123CD02D0722A4B0D6895F"
   local Dir = app.config.channelExportPath
   local ChannelName = 'channel_exporter'

   local ChConf = xml.parse{
      data=io.open(Dir.."/"..ChannelName..".xml")
      :read("*a")}
   local Tmp = Dir.."/".."scratch"
   local ChGuid = ChConf.channel.from_http.guid
   print(Tmp)
   if not os.fs.stat(Tmp) then 
      os.fs.mkdir(Tmp)
   end

   local PrjDir = Dir.."/"..ChannelName.."_http"
   trace(PrjDir)
   --[[
   os.execute("cp -R "..PrjDir.." "..Tmp)
   ]]
 
   -- Open the project.prj file and pull in needed files
   local PrjF = json.parse{
      data=io.open(
         PrjDir.."/project.prj")
      :read("*a")}
   
   -- Copy over project files
   for k,v in os.fs.glob(PrjDir.."/*") do
      if not os.fs.stat(Tmp.."/"..ChGuid) then 
         os.fs.mkdir(Tmp.."/"..ChGuid) 
      end
      os.execute("cp "..k.." "..Tmp .."/"..ChGuid)
   end
   
   -- Move over dependencies
   for k,v in pairs(PrjF['OtherDependencies']) do
      if not os.fs.stat(Tmp.."/other") then
         os.fs.mkdir(Tmp.."/other")
      end
      print(k,v)
      os.execute("cp "..Dir.."/other/"..v.. " "..Tmp.."/other")
   end 
    
   for k,v in pairs(PrjF['LuaDependencies']) do
      if not os.fs.stat(Tmp.."/shared") then
         os.fs.mkdir(Tmp.."/shared")
      end
      if os.fs.stat(Dir.."/shared/"..v..".lua") then
         print('hi')
         os.execute("cp "..Dir.."/shared/"..v..".lua "..Tmp.."/shared")
      elseif v:find(".") then
         local PackageDir = v:sub(1, v:find('%.')-1)
         -- It's a package, copy from top down.
         os.execute("cp -R "..Dir.."/shared/"..PackageDir.. " "..Tmp.."/shared")
      end
   end
     
   -- Zip and import first project
   os.execute("cd "..Dir.."/scratch && zip -r scratch.zip *")
---[[
   require 'iguanaServer'
   local Web = iguana.webInfo()
   local ChAPI = iguanaServer.connect{
      url='http://localhost:6545',
      username='admin', password='password'}
   local B64 = filter.base64.enc(io.open(Dir.."/scratch/scratch.zip"):read("*a"))
   ChAPI:importProject{project=B64, guid='F8AE93FE7D8BEE761E982D75A76145B3',live=true}
--]]
   -- Zip and import filter
   
   -- Zip and import second project
   
   --[[
   for k,v in os.fs.glob(app.config.channelExportPath 
      .. "/EB004E5EB4123CD02D0722A4B0D6895F/*") 
   do
      print(k,v)
   end
   ]]
   
   --[[ 
   for f in os.fs.glob(
      app.config.channelExportPath .. 
      "/EB004E5EB4123CD02D0722A4B0D6895F" ..
      "/E76737E42964D985AA06049A663C1D2B/*") 
   do 
      -- grab the file name
      if f:match("/project.prj") then
         local F = io.open(f)
         local C = F:read("*a")
         local J = json.parse{data=C}
         --for k,v in pairs(J) do
         --   print(k,v)
         --end
         --trace(J.LuaDependencies[1])
      end
   end
   ]]
end
