--
-- Private helpers
--

--local function unpackC

local function statuses()
   local StatusHtml = '<div class="%s"></div>'
   local Statuses = {
      on='status-green', 
      off='status-grey', 
      error='status-red', 
      transition='status-yellow'}
   
   return StatusHtml, Statuses
end

local function components()
   local ComponentsHtml =
   [[<img alt="%s" width="38" height="16"
   border="0" title="" src="/channelmanager/icon_%s.gif">
   <img alt="arrow" width="11" height="16" 
   border="0" title="" src="/channelmanager/arrow.gif">
   <img alt="%s" width="38" height="16"
   border="0" title="" src="/channelmanager/icon_%s.gif">]]
   
   local Components = {
      ['From Translator'] = 'TRANS',
      ['To Translator']   = 'TRANS',
      ['From File']  = 'FILE',
      ['To File']    = 'FILE',
      ['From HTTPS'] = 'HTTPS',
      ['To HTTPS']   = 'HTTPS',
      ['LLP Listener'] = 'LLP',
      ['LLP Client']   = 'LLP',
      ['From Channel'] = 'QUE',
      ['To Channel']   = 'QUE',
      ['To Plugin']    = 'PLG-N',
      ['From Plugin']  = 'PLG-N'}
   
   return ComponentsHtml, Components
end

local function exportSummaryBtn(Channel)
   local Html = string.format(
      '<a href=\"%s#export-summary&channel=%s\">Export</a>',
      app.config.approot, Channel.Name:nodeValue():gsub(" ","_"))
   return Html
end

local function importSummaryBtn(Channel)
   local Html = string.format(
      '<a href=\"%s#import-summary&channel=%s\">Import</a>',
      app.config.approot, Channel.Name:nodeValue():gsub(" ","_"))
   return Html
end



local function exportConfirmBtn(Channel)
   local Html = string.format(
      '<a href=\"%s#export-channel&channel=%s\">Export</a>',
      app.config.approot, Channel.Name:nodeValue():gsub(" ","_"))
   return Html
end

local function importConfirmBtn(Channel)
   local Html = string.format(
      '<a href=\"%s#import-channel&channel=%s\">Import</a>', 
      app.config.approot, Channel.Name:nodeValue():gsub(" ","_"))
   return Html
end

local function inspectAndWrite(T, ChDir)
   local Path = ChDir .. "/"
   for k,v in pairs(T) do
      if type(v) == 'table' then
         if not os.fs.stat(Path .. k) then 
            os.fs.mkdir(Path .. k)
         end
         inspectAndWrite(v, Path .. k)         
      end
      
      if type(v) == 'string'
         and not k:find("::") -- Metadata
         then
         local F = io.open(Path .. k, "w+")
         F:write(v)
         F:close()
      end
   end
end

local function writeZippedFiles(B64, Dir, Guid, Dest)
   local D = filter.base64.dec(B64)
   local T = filter.zip.inflate(D)
   local TranPath = Dir..'/'..Dest
   trace(TranPath)
   if not os.fs.stat(TranPath) then
      os.fs.mkdir(TranPath)
   end
   inspectAndWrite(T[Guid], TranPath)
   if (T.other) then
      inspectAndWrite(T.other, Dir..'/other')
   end
   if (T.shared) then
      inspectAndWrite(T.shared, Dir..'/shared')
   end
end

--
-- End helpers
--

-- -- -- -- -- --

--
-- The App
--

-- Require this app object in the top of your main script for
-- your web app. Make in *non-local* so the webserver can use it.
local app = {}

app.ui = require 'channelmanager.presentation'
app.config = require 'channelmanager.config'
app.actions = app.config.actions

function app.default()
   return app.ui["/channelmanager/index.html"]
end

function app.listChannels(Request)
   -- switch this to iguana.status once it's available
   local StatusXml = iguana.status()
   
   local Conf = xml.parse{data=StatusXml}.IguanaStatus
   
   local Results = {aaData={}, aoColumns={}}
   Results.aoColumns = {
      {['sTitle'] = 'Name',   ['sType'] = 'string'},
      {['sTitle'] = 'Status', ['sType'] = 'html'},
      {['sTitle'] = 'Type',   ['sType'] = 'string'},
      {['sTitle'] = 'Msgs Queued', ['sType'] = 'string'},
      {['sTitle'] = 'Total Errs',  ['sType'] = 'string'},
      {['sTitle'] = 'Export',  ['sType'] = 'html'},
      {['sTitle'] = 'Import',  ['sType'] = 'html'}}
   
   local StatusHtml, Statuses = statuses()
   ComponentsHtml, Components = components()
   
   for i=1, Conf:childCount('Channel') do
      local Ch = Conf:child('Channel', i)
      Results.aaData[i] = {
         Ch.Name:nodeValue(), 
         string.format(
            StatusHtml, 
            Statuses[Ch.Status:nodeValue()]), 
         string.format(
            ComponentsHtml, 
            Components[Ch.Source:nodeValue()],
            Components[Ch.Source:nodeValue()], 
            Components[Ch.Destination:nodeValue()], 
            Components[Ch.Destination:nodeValue()]),
         Ch.MessagesQueued:nodeValue(),
         Ch.TotalErrors:nodeValue(),
         exportSummaryBtn(Ch),
         importSummaryBtn(Ch)}
   end
   
   return Results
end

-- A summary of the channel and a chance to confirm.
function app.exportSummary(Request)
   local Status = iguana.status()
   local ConfXml = xml.parse{data=Status}.IguanaStatus
   for i=1, ConfXml:childCount('Channel') do
      local Ch = ConfXml:child('Channel', i)
      if Ch.Name:nodeValue():gsub(" ","_") 
         == Request.get_params.channel 
         then
         return {
            ChannelName = Ch.Name:nodeValue(),
            ExportPath = app.config.channelExportPath,
            ConfirmBtn = exportConfirmBtn(Ch)}
      end
   end
end

function app.importSummary(Request)
   local Status = iguana.status()
   local ConfXml = xml.parse{data=Status}.IguanaStatus
   for i=1, ConfXml:childCount('Channel') do
      local Ch = ConfXml:child('Channel', i)
      if Ch.Name:nodeValue():gsub(" ","_") 
         == Request.get_params.channel 
         then
         return {
            ChannelName = Ch.Name:nodeValue(),
            ExportPath = app.config.channelExportPath,
            ConfirmBtn = importConfirmBtn(Ch)}
      end
   end
end

function app.importChannel(Request)
   local ChGuid = Request.get_params.guid
   local Dir = app.config.channelExportPath


   local ChConf = xml.parse{
      data=io.open(Dir.."/"..Request.get_params.channel..".xml")
      :read("*a")}
   local Tmp = Dir.."/".."scratch"
   local ChannelName = ChConf.channel.name:nodeValue():gsub(" ","_")
      
   print(Tmp)
   if not os.fs.stat(Tmp) then 
      os.fs.mkdir(Tmp)
   end

   --local PrjDir = Dir.."/"..ChannelName.."_http"
   --trace(PrjDir)
   --[[
   os.execute("cp -R "..PrjDir.." "..Tmp)
   ]]
   
   local PrjDir
   
   if ChConf.channel.use_message_filter:nodeValue() == 'true' then
      PrjDir = Dir.."/"..ChannelName.."_message_filter"
   end
   trace(PrjDir)
   -- Open the project.prj file and pull in needed files
   local PrjF = json.parse{
      data=io.open(
         PrjDir.."/project.prj")
      :read("*a")}
   
   -- Copy over project files
   for k,v in os.fs.glob(PrjDir.."/*") do
      if not os.fs.stat(Tmp.."/"..ChConf.channel.guid) then 
         os.fs.mkdir(Tmp.."/"..ChConf.channel.guid)
      end
      os.execute("cp "..k.." "..Tmp .."/"..ChConf.channel.guid)
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
      url='http://localhost:'..Web.web_config.port,
      username='admin', password='password'}
      -- Add the channel
   local NewCfg = ChAPI:addChannel{
      config=ChConf, live=true
   }.channel 

   local B64 = filter.base64.enc(io.open(Dir.."/scratch/scratch.zip"):read("*a"))
   ChAPI:importProject{project=B64, guid=NewCfg.message_filter.translator_guid:nodeValue() ,live=true}
   
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
-- The export has been confirmed.
function app.exportChannel(Request)
   -- grab the channel configuration
   local Web = iguana.webInfo()
   local CnlCfg = net.http.post{
      url='http://localhost:'..Web.web_config.port..'/get_channel_config',
      auth={password='password', username='admin'},
      parameters={name=Request.get_params.channel:gsub("_"," ")},
      live=true}
   trace(CnlCfg)
   local Ch = xml.parse{data=CnlCfg}.channel
   local Path = app.config.channelExportPath 
   
   if not os.fs.stat(Path) then
      os.fs.mkdir(Path)
   end

   local ChannelDir = app.config.channelExportPath 
   local ChannelName = Ch.name:nodeValue():gsub(' ','_'):lower()
   
   -- Write the config fragment for the channel. This is
   -- required for importing.
   local F = io.open(ChannelDir .. "/"..ChannelName..".xml", "w")
   F:write(CnlCfg)
   F:close()
   
   -- switch on component types
   require 'iguanaServer'


   local ChAPI = iguanaServer.connect{
      url='http://localhost:'..Web.web_config.port,
      username='admin', password='password'}

   -- TODO - all the other components...
   if Ch.to_mapper then
      B64ProjectContents = ChAPI:exportProject{
         guid=Ch.to_mapper.guid:nodeValue(), live=true}
      writeZippedFiles(B64ProjectContents, ChannelDir, Ch.to_mapper.guid:nodeValue(), ChannelName.."_to_mapper")
   end

   if Ch.from_mapper then
      ChAPI:exportProject{
         guid=Ch.from_mapper.guid:nodeValue(), live=true}
      writeZippedFiles(B64ProjectContents, ChannelDir)
   end

   if Ch.message_filter 
      and Ch.message_filter.translator_guid 
      and Ch.message_filter.translator_guid:nodeValue() 
      ~= '00000000000000000000000000000000' 
      then
      B64ProjectContents = ChAPI:exportProject{
         guid=Ch.message_filter.translator_guid:nodeValue(), 
         live=true}
      writeZippedFiles(B64ProjectContents, ChannelDir, 
         Ch.message_filter.translator_guid:nodeValue(), 
         ChannelName.."_message_filter")
   end
   
   -- TODO: confirm this one works
   if Ch.from_llp_listener 
      and Ch.from_llp_listener.ack_script 
      then
      B64ProjectContents = ChAPI:exportProject{
         guid=Ch.from_llp_listener.ack_script:nodeValue(), 
         live=true}
      writeZippedFiles(B64ProjectContents, ChannelDir)
   end

   -- TODO: confirm this one works
   if Ch.from_http 
      and Ch.from_http.guid 
      then
      B64ProjectContents = ChAPI:exportProject{
         guid=Ch.from_http.guid:nodeValue(), live=true}
      writeZippedFiles(B64ProjectContents, ChannelDir, Ch.from_http.guid:nodeValue(), ChannelName.."_from_http")
   end
   
   local Message = 'Channel was exported successfully'

   return {message = Message}
end

return app