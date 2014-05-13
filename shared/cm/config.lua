-- This is a partly implemented next step in the channel manager to
-- make an object which can load and save a configuration file so that
-- we don't need to edit the source code of the channel manager to show
-- the configuration directory.

-- We're using some fancy parts of Lua called metatables which give us
-- the hooks to do object orientated programming in Lua.

if not cm then cm = {} end
if not cm.config then cm.config = {} end

local function ConfigName()
   return iguana.workingDir()..'/channelmanager.config'
end

local function ConfigDefault()
   return {repo={}}
end

local method = {}
local meta={__index=method} 

function method.load(S)
   local Name = ConfigName()
   if not os.fs.access(Name) then
      S.config = ConfigDefault()
      return
   end
   local Json = os.fs.readFile(Name)
   S.config = json.parse{data=Json}
end

function method.addRepo(S, Name, Path)
   S.config.repo[#S.config.repo+1] = {name=Name, path=Path}
end

function method.save(S)
   local Content = json.serialize{data=S.config}
   os.fs.writeFile(ConfigName(), Content)
end

function method.clear(S)
   S.config.repo = {}
end

function cm.config.open()
   local T = {}
   setmetatable(T, meta)
   T:load()
   return T  
end