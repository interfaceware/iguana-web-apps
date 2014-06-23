if not cm then cm = {} end
if not cm.githelper then cm.githelper = {} end

local function comparedates(base, new)
   for i, v in ipairs(base) do
      if v < new[i] then
         return true
      elseif v > new[i] then
         return false
      end
   end
end

function cm.githelper.comparecommits(committree, root, remotesrc)
   local topcommit = {}
   for i, v in ipairs(committree) do
      if next(topcommit) == nil  or comparedates(topcommit.date:split('%D'), committree[i].commit.author.date:split('%D')) then
         topcommit = {data = v, date = committree[i].commit.author.date}
      end
   end
   trace(topcommit)
   if os.fs.access(root..'lastsha') and os.fs.readFile(root..'lastsha') == topcommit.data.sha then
      return 
   end
   local zipdata, statuscode = net.http.get{url=remotesrc, live=true}
   if statuscode >= 400 then
        return {link=remotesrc, err="Bad URL. Error "..statuscode}
   end
   local tree=filter.zip.inflate(zipdata)
   for k,v in pairs(tree) do
      tree = v
   end  
   os.fs.cleanDir(root)
   os.fs.writeFile(root..'lastsha', topcommit.data.sha, 666)
   cm.app.WriteFiles(root, tree)
   return 
end  

--[[local function writemd5(path, checksum)
   local F = io.open(path, 'wb+')
   F:write(checksum)
   F:close()
end

function cm.githelper.verifychanges(filetree, path, checksum)
   local checksumpath = path .. 'checksum'
   if os.fs.access(checksumpath) then
      local sum = os.fs.readFile(checksumpath)
      if sum ~= checksum then
         os.fs.cleanDir(path)
         cm.githelper.writefiles(filetree, path)
         writemd5(checksumpath, checksum)
      end
   else
      os.fs.cleanDir(path)
      writemd5(checksumpath, checksum)
      cm.githelper.writefiles(filetree, path)
   end
 
end

function cm.githelper.writefiles(filetree, destination)
for key, val in pairs(filez) do 
      trace(key)
      local sample = io.open('/Users/kevin.cai/Desktop/' .. val, 'w+')
      sample:write("HELLO")
      sample:close()
   end  
   for k,v in pairs(filetree) do
      local path = os.fs.name.toNative(destination .. '/' .. k)
      trace(path)
      if type(v) == 'table' then       
         if not os.fs.dirExists(path) then
            os.fs.mkdir(path)
         end
         cm.githelper.writefiles(v, path)
      elseif type(v) == 'string' then
         local tidy = os.fs.access(path, 'w')
         local F, Err = io.open(path, "wb+")
         if not F then error("Unable to write to "..Err) end
         F:write(v)
         trace(F)
         F:close()         
      end
   end
end]]