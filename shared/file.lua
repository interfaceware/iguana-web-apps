local IsWindows = false
local DirSep = '/'

if iguana.workingDir():find('\\') then
   IsWindows = true  
   DirSep = '\\'
end
   
function os.fs.dirExists(Path)
   if os.isWindows() then
      return 0 == os.execute('cd '..Path)
   else
      return os.fs.access(Path)  
   end
end


function os.fs.addDir(Dir)
   if Dir:sub(#Dir) ~= DirSep then
      return Dir..DirSep
   end
   return Dir
end

function os.isWindows()
   return IsWindows
end

function os.fs.dirSep()
   return DirSep
end

function string.addDir(S)
   return os.fs.addDir(S)
end