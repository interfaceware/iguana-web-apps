-- This is a partly implemented next step in the channel manager to
-- make an object which can load and save a configuration file so that
-- we don't need to edit the source code of the channel manager to show
-- the configuration directory.

-- We're using some fancy parts of Lua called metatables which give us
-- the hooks to do object orientated programming in Lua.

if not cm then cm = {} end
if not cm.config then cm.config = {} end

local function DefaultConfigName()
   return os.fs.abspath(iguana.workingDir()..'/IguanaRepo.cfg')
end

local function DefaultRepoLocation()
   if os.isWindows() then
      return {['Name']="Iguana Apps", ['Source']="C:/iguana-web-apps/", ['Type'] = 'Default', ['RemoteSource']='/interfaceware/iguana-web-apps/'}
   else
      return {['Name']="Iguana Apps", ['Source']="~/iguana-web-apps/", ['Type'] = 'Default', ['RemoteSource']='/interfaceware/iguana-web-apps/'}
   end
end

local function ConfigDefault()
   return {locations={DefaultRepoLocation()}}
end
--Turn method, meta back to local
method = {}
meta={__index=method} 

local function ConvertOldFormat(S)
   if(S.config.repo)then
      for i=1, #S.config.repo do
         local Temp = {}
         Temp.Name = "Repository "..i
         Temp.Source = S.config.repo[i]
         Temp.RemoteSource = ""
         Temp.Type = 'Local'
         S.config.locations[#S.config.locations +1] = Temp
      end
      S.config.repo = nil
   end
   for K, V in ipairs(S.config.locations) do
      if not S.config.locations[K].Source then
         local Temp = {}
         Temp.Name = V.Name or ""
         Temp.Source = V.Dir or ""
         Temp.RemoteSource = ""
         Temp.Type = 'Local'
         S.config.locations[K] = Temp
      end 
   end
   return S
end

function method.load(S)
   local Name = S.file
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

function method.addRepo(S, Name, Path, _Type, Remote)
   S.config.locations[#S.config.locations+1] = {['Name']=Name, ['Source']=Path, ['Type']=_Type, ['RemoteSource'] = Remote}
end

function method.save(S)
   local Content = json.serialize{data=S.config}
   os.fs.writeFile(S.file, Content)
end

function method.clear(S)
   S.config.locations = {}
end

function method.repoList(S)
   return S.config.locations 
end

function cm.config.open(T)
   T = T or {}
   T.file = T.file or DefaultConfigName()
   trace(T)
   setmetatable(T, meta)
   T:load()
   return T  
end
