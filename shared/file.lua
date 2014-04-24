local IsWindows = false

os.fs.name = {}

if iguana.workingDir():find('\\') then
   IsWindows = true  
end
   
function os.fs.dirExists(Path)
   Path = os.fs.name.toNative(Path)
   return os.fs.access(Path,'r')
end

function os.fs.addDir(Dir)
   if Dir:sub(#Dir) ~= '/' then
      return Dir..'/'
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

function os.fs.name.toNative(Path)
   local FilePath = os.fs.abspath(Path)
   if os.isWindows() then
      FilePath = FilePath:gsub("/", "\\")
   end
   return FilePath
end

function os.fs.name.fromNative(Path)
   return Path:gsub("\\", "/")
end

local FileOpen = io.open

function io.open(FileName, Mode)
   FileName = os.fs.name.toNative(FileName)
   local Success, Result, ErrMessage = pcall(FileOpen, FileName, Mode) 
   if Success then
      return Result, ErrMessage
   else   
      error(Result, 1)
   end
end

function os.fs.tempDir()
   local Name = os.getenv('TEMP')
   if not Name then
      Name = os.getenv('TMPDIR')
   end
   return os.fs.name.fromNative(Name):addDir()
end

function os.fs.writeFile(Name, Content)
   Name = os.fs.abspath(Name)
   local Parts = Name:split('/')
   local Dir = ''
   for i = 1, #Parts-1 do
      Dir = Dir..Parts[i]..'/'
      trace(Dir)
      if not os.fs.dirExists(Dir) then
         os.fs.mkdir(Dir)
      end
   end
   os.fs.access(Name, 'w')
   local F, Err = io.open(Name, "wb+")
   if not F then error("Unable to write to "..Err) end
   F:write(Content)
   F:close()
end


function os.fs.readFile(Name)
   local F = io.open(Name, "rb")
   local Content = F:read('*a')
   F:close();
   return Content;
end


function os.fs.cleanDir(Dir, List)
   if not os.fs.dirExists(Dir) then
      return false
   end
   local LocalList = {}
   for Name,Info in os.fs.glob(os.fs.name.toNative(Dir:addDir())..'*') do
      trace(Name,Info)
      LocalList[Name] = Info
      if (Info.isdir) then
         os.fs.cleanDir(Name)
      end
   end
   trace(LocalList)
   for K, V in pairs(LocalList) do
      if V.isdir then
         os.fs.rmdir(K)
      else
         os.remove(K)
      end
   end   
end


local function ConvertProcessLine(T)
   local Dir = os.fs.name.toNative(T.dir)
   local Command = T.command
   local Args = T.arguments
   local CmdString = ''
   if os.isWindows() then
      if iguana.workingDir():sub(1,2) ~= Dir:sub(1,2) then
         CmdString = Dir:sub(1,2).." && "
      end
   end
   CmdString = CmdString..'cd '..Dir..' && '..Command..' '..Args
   return CmdString
end

local OsExecute = os.execute

function os.execute(T)
   local CmdString = ConvertProcessLine(T)
   return OsExecute(CmdString)
end

local POpen = io.popen

function io.popen(T)
   local CmdLine = ConvertProcessLine(T)
   return POpen(CmdLine, T.mode), CmdLine
end

local WorkingDir=iguana.workingDir():gsub('\\', '/')

function iguana.workingDir()
   return WorkingDir
end

local AbsPath = os.fs.abspath

function os.fs.abspath(Path)
   return AbsPath(Path):gsub('\\','/')   
end

local Access = os.fs.access
function os.fs.access(Path)
   Path = os.fs.name.toNative(Path)
   return Access(Path)
end

Glob = os.fs.glob
function os.fs.glob(Path) 
   Path = os.fs.name.toNative(Path)
   local GlobFunction =  Glob(Path)
   return function(K,V) 
      local A, B; 
      A, B = GlobFunction(K,V);
      if (A) then
         return os.fs.name.fromNative(A), B
      else
          return nil
      end
   end
end

Chmod = os.fs.chmod
function os.fs.chmod(Path, Permission)
   Path = os.fs.name.toNative(Path)
   Chmod(Path, Permission)
end


