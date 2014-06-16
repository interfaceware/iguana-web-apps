-- This is a partly implemented next step in the channel manager to
-- make an object which can load and save a configuration file so that
-- we don't need to edit the source code of the channel manager to show
-- the configuration directory.

-- We're using some fancy parts of Lua called metatables which give us
-- the hooks to do object orientated programming in Lua.

if not cm then cm = {} end
if not cm.config then cm.config = {} end

local function ConfigName()
   return iguana.workingDir()..'/IguanaRepo.cfg'
end

local function DefaultRepoLocation()
   if os.isWindows() then
      return "C:/iguana-web-apps/"
   else
      return "~/iguana-web-apps/"
   end
end

local function ConfigDefault()
   return {repo={DefaultRepoLocation()}}
end

local method = {}
local meta={__index=method} 

local function ConvertOldFormat(S)
   if(S.config.repo)then
      for i=1, #S.config.repo do
         local Temp = {}
         Temp.Name = "Repository "..i
         Temp.Dir = os.fs.name.toNative(S.config.repo[i])
         S.config.locations[#S.config.locations +1] = Temp
      end
      S.config.repo = nil
   end
   return S
end

function method.load(S)
   local Name = ConfigName()
   if not os.fs.access(Name) then
      S.config = ConfigDefault()
      return
   end
   local Json = os.fs.readFile(Name)
   if #Json == 0 then
      S.config = ConfigDefault();
      return
   end
   S.config = json.parse{data=Json}
   if not S.config.locations then
      S.config.locations = {}
   end
   ConvertOldFormat(S)
end

function method.addRepo(S, Name, Path)
   S.config.repo[#S.config.locations+1] = {name=Name, path=Path}
end

function method.save(S)
   local Content = json.serialize{data=S.config}
   os.fs.writeFile(ConfigName(), Content)
end

function method.clear(S)
   S.config.locations = {}
end

function method.repoList(S)
   return S.config.locations 
end

function cm.config.open()
   local T = {}
   setmetatable(T, meta)
   T:load()
   return T  
end
