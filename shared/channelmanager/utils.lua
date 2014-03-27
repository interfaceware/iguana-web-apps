channelmanager.utils = {}

local lm = channelmanager.utils

function lm.channelInfo(Ch)
   local Info = {}   
   Info.name = Ch.name:nodeValue()
   Info.config = Ch
   Info.trans_guids = {}
   
   if Ch.to_mapper then
      Info.trans_guids.to = Ch.to_mapper.guid:nodeValue()
   end

   if Ch.from_mapper then
      Info.trans_guids.from = Ch.from_mapper.guid:nodeValue()
   end

   if Ch.message_filter 
      and Ch.message_filter.translator_guid 
      and not lm.isNullGuid(Ch.message_filter.translator_guid)
      then
      Info.trans_guids.filter = Ch.message_filter.translator_guid:nodeValue()
   end
   
   -- TODO: confirm this one works
   if Ch.from_llp_listener 
      and Ch.from_llp_listener.ack_script 
      then
      Info.trans_guids.ack = Ch.from_llp_listener.ack_script:nodeValue()
   end

   -- TODO: confirm this one works
   if Ch.from_http 
      and Ch.from_http.guid 
      then
      Info.trans_guids.http = Ch.from_http.guid:nodeValue()
   end
   
   return Info
end

function lm.scratchDir()
   local Tmp = channelmanager.config.scratchDir
   if not os.fs.stat(Tmp) then
      os.fs.mkdir(Tmp)
   end
   return Tmp
end

function lm.readFile(FileName)
   local F = io.open(FileName, "r")
   local Content = F:read('*a');
   F:close();
   return Content
end

function lm.writeFile(FileName, Content)
   local Parts = FileName:split("/")
   local Dir = ''
   for i = 1, #Parts-1 do
      Dir = Dir..Parts[i]..'/'
      trace(Dir)
      if not os.fs.stat(Dir) then
         os.fs.mkdir(Dir)
      end
   end
   local F = io.open(FileName,"w")
   F:write(Content)
   F:close()
end

function lm.removeDir(D)
   local Success, ErrMessage = pcall(os.fs.rmdir, D)
   if not Success then iguana.logInfo(ErrMessage) end
end

function lm.deleteDir(DTree, Parent)
   local Count = 0
   local Parent = Parent or ''
   for K,V in pairs(DTree) do
      trace(K,V)
      lm.deleteDir(V, Parent..K..'/')
   end
   lm.removeDir(Parent)
end

function lm.cleanDirList(FileList, Root)
   local DTree = {}
   for i=1, #FileList do
      local Parts = FileList[i]:sub(#Root+1):split("/")
      local Dir = ''
      Tree = DTree
      for j=2, #Parts-1 do
         Dir = Dir..Parts[j]..'/'
         trace(Dir)
         if not Tree[Parts[j]] then
            Tree[Parts[j]] = {}
         end
        
         Tree = Tree[Parts[j]]
         if (#Dir > #channelmanager.config.scratchDir and Dir:sub(1, #channelmanager.config.scratchDir) == channelmanager.config.scratchDir) then
             DirList[Dir] = ''
         end
        
      end
      trace(DTree)
   end
   trace(DTree)
   lm.deleteDir(DTree, Root..'/')
end

function lm.isNullGuid(Guid)
   return Guid:nodeValue() 
       == '00000000000000000000000000000000'
end

function lm.cleanChannelName(Name)
   return tostring(Name):gsub(" ", "_"):lower()
end

function lm.undoCleanChannelName(Name)
   return tostring(Name):gsub("_", " "):lower()
end

function string.split(s, d)
   local t = {}
   local i = 0
   local f
   local match = '(.-)' .. d .. '()'
   if string.find(s, d) == nil then
      return {s}
   end
   for sub, j in string.gfind(s, match) do
      i = i + 1
      t[i] = sub
      f = j
   end
   if i~= 0 then
      t[i+1]=string.sub(s,f)
   end
   return t
end