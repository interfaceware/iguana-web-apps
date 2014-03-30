-- The export has been confirmed.

local function inspectAndWrite(T, ChDir)
   local Path = ChDir:addDir()
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
   trace(T)
   local TranPath = Dir:addDir()..Dest
   trace(TranPath)
   if not os.fs.stat(TranPath) then
      os.fs.mkdir(TranPath)
   end
   inspectAndWrite(T[Guid], TranPath)
   if (T.other) then
      inspectAndWrite(T.other, Dir:addDir()..'other')
   end
   if (T.shared) then
      inspectAndWrite(T.shared, Dir:addDir()..'shared')
   end
end

function channelmanager.backend.export(Request)
   local ChannelName = Request.params.name
   trace(ChannelName)
   local ChAPI = channelmanager.utils.channelApi()
   local ChanDef = ChAPI:getChannelConfig{name=ChannelName, live=true}
   local Path = app.config.channelExportPath 
   if not os.fs.stat(Path) then
      os.fs.mkdir(Path)
   end

   local ChannelDir = app.config.channelExportPath 
   local SanitizedName = ChannelName:gsub(' ','_'):lower()
   ChanDef.channel.name = SanitizedName
   channelmanager.utils.writeFile(ChannelDir:addDir()..SanitizedName..'.xml', ChanDef:S())
   local TranList = channelmanager.utils.translatorGuids(ChanDef)
   for TranType,GUID in pairs(TranList) do 
      local ZipContent = ChAPI:exportProject{guid=GUID, live=true}
      writeZippedFiles(ZipContent, ChannelDir, GUID, SanitizedName.."_"..TranType)
   end
   return {message = 'Channel was exported successfully'}
end
