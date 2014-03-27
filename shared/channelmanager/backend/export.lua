-- The export has been confirmed.

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

-- TODO this function needs to be refactored.
function channelmanager.backend.export(Request)
   -- grab the channel configuration
   local Web = iguana.webInfo()
   local CnlCfg = net.http.post{
      url='http://localhost:'..Web.web_config.port..'/get_channel_config',
      auth={password='password', username='admin'},
      parameters={name=Request.params.name:gsub("_"," ")},
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
   local ChAPI = iguanaServer.connect{
      url='http://localhost:'..Web.web_config.port,
      username='admin', password='password'}

   -- TODO - all the other components...
   if Ch.to_mapper then
      B64ProjectContents = ChAPI:exportProject{
         guid=Ch.to_mapper.guid:nodeValue(), live=true}
      writeZippedFiles(B64ProjectContents, ChannelDir, Ch.to_mapper.guid:nodeValue(), ChannelName.."_to")
   end

   if Ch.from_mapper then
      ChAPI:exportProject{
         guid=Ch.from_mapper.guid:nodeValue(), live=true}
      -- TODO !!
      --writeZippedFiles(B64ProjectContents, ChannelDir)
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
      writeZippedFiles(B64ProjectContents, ChannelDir, Ch.from_http.guid:nodeValue(), ChannelName.."_http")
   end
   
   local Message = 'Channel was exported successfully'

   return {message = Message}
end
