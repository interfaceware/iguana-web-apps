-- So one of the biggest headaches for us programming these modules is that half the time we're working
-- on POSIX/Unix style operating systems like Mac OS X and Linux and the rest of the time on Windows.
-- The majority of our customers are on windows although we develop and test on all of them - and we have
-- noticed a growing trend towards people using Linux lately.

-- The problem is that Windows uses forward slashes \ and the rest of the world uses /.  It can make for a
-- lot of ugly bug prone code if you scatter different checks for creating directory paths in the code - very very
-- easy to make a new feature on one OS type and break the behavior on another OS type - ouch.

-- So this module changes the behavior of the built in file handling functions.  Internally we convert everything to
-- paths which use POSIX style / characters.  Then we convert at the last moment into form that is native for the
-- actually operating system which we call the real underlying calls to the OS and when we display paths in the GUI.

-- It greatly simplifies the code we have that deals with file paths.  Windows paths get expressed like this:
-- 'D:/my repo/great stuff/here'


local IsWindows = false

os.fs.name = {}

if package.config:sub(1,1):find('\\') then
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

function os.fs.writeFile(Name, Content, Permissions)
   Name = os.fs.abspath(Name)
   local Parts = Name:split('/')
   local Dir = ''
   for i = 1, #Parts-1 do
      Dir = Dir..Parts[i]..'/'
      trace(Dir)
      if not os.fs.dirExists(Dir) then
         os.fs.mkdir(Dir, 777)
      end
   end
   os.fs.access(Name, 'w') 
   local F, Err = io.open(Name, "wb+")
   if not F then error("Unable to write to "..Err) end
   F:write(Content)
   F:close()
   if Permissions then
      os.fs.chmod(Name, Permissions)
   end
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
   
   if Chmod then Chmod(Path, Permission) end
end


