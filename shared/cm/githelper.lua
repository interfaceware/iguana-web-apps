if not cm then cm = {} end
if not cm.githelper then cm.githelper = {} end

--local filez = {one = "fake", two = "superfake", three = "powerfake"}

local function writemd5(path, checksum)
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
--[[for key, val in pairs(filez) do 
      trace(key)
      local sample = io.open('/Users/kevin.cai/Desktop/' .. val, 'w+')
      sample:write("HELLO")
      sample:close()
   end]]    
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
end