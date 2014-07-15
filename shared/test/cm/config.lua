if (not test ) then test = {} end

test.cm = {}
test.cm.config = {}

local SampleCurrent = {['locations'] = {{['Name']="Repository 1", ['Source']="~/fakelocation/iguana-web-apps/", ['Type'] = "Local", ['RemoteSource'] = ""},
      {['Name']="Repository 2", ['Source']="~/iguana-web-apps/", ['Type'] = "Local", ['RemoteSource'] = ""}}} 
local SampleOld = {['repo'] = {'~/fakelocation/iguana-web-apps/', '~/iguana-web-apps/'}}
local function findemptyfile()
   local Breaker = 0
   local ConfigFile = ""
   repeat
      if Breaker > 100 then error("Maximum file access") end
      local Rnd = math.random(0, 1e6)
      ConfigFile = os.fs.tempDir()..Rnd..'.cfg'
   until (not os.fs.access(ConfigFile))
   return ConfigFile
end


function test.cm.config.testEmpty()
   -- Start by loading a non existent file
   local breaker = 0
   local ConfigFile = findemptyfile()
   --os.fs.tempDir() .. 'Nonexistent.cfg'
   local Config = cm.config.open{file=ConfigFile}
   -- Setting up expected
   local Expected = {}
   setmetatable(Expected, meta)
   Expected.file = ConfigFile
   Expected.config = {['locations'] = {{['Name']="default", ['Source']="~/iguana-web-apps/", ['Type'] = "Local", ['RemoteSource'] = ""}}}
   if os.isWindows() then Expected.config.locations[1].Source="C:/iguana-web-apps/" end
   --Comparison
   unittest.assertEqual(Expected, Config)
end

function test.cm.config.testNoargs()
   -- Basic sanity test
   local Config = cm.config.open()
   trace(Config.file)
   local Expected = os.fs.name.fromNative(iguana.workingDir()..'IguanaRepo.cfg')
   unittest.assertEqual(Config.file, Expected)
end

function test.cm.config.testUpgradeOldVersion()
   local OldConfigFile = findemptyfile()
   os.fs.writeFile(OldConfigFile, json.serialize{data=SampleOld})
   local Config = cm.config.open{file=OldConfigFile}
   local Expected = {}
   setmetatable(Expected, meta)
   Expected.file = OldConfigFile
   Expected.config = SampleCurrent   
   for k,v in ipairs(Expected.config.locations) do 
      v.Source = os.fs.name.toNative(v.Source)
   end
   unittest.assertEqual(Expected, Config)
   os.remove(OldConfigFile)
   -- May not be compatible with Windows
   -- Create a config file with the old format, ensure that we can read and get the new format  
end

function test.cm.config.testCurrent()
   local ConfigFile = findemptyfile()
   os.fs.writeFile(ConfigFile, json.serialize{data=SampleCurrent})
   local Config = cm.config.open{file=ConfigFile}
   local Expected = {}
   setmetatable(Expected, meta)
   Expected.file = ConfigFile
   Expected.config = SampleCurrent
   unittest.assertEqual(Expected, Config)
   os.remove(ConfigFile)
   -- Create a config file with current format - ensure we can read repo information
end

local function copytable(Template)
   local Copy = {}
   for K, V in pairs(Template) do
      if (type(V) == 'table')then
         Copy[K] = copytable(V)
      else
         Copy[K] = V
      end
   end
   return Copy
end

function test.cm.config.addRepo()
   local ConfigFile = findemptyfile()
   os.fs.writeFile(ConfigFile, json.serialize{data=SampleCurrent})
   local NewSample = copytable(SampleCurrent)
   NewRepo = {['Name']="iNTERFACEWARE Repo", ['Source']="~/interfaceware/iguana-web-apps/", 
      ['Type'] = "GitHub-ReadOnly", ['RemoteSource'] = "/interfaceware/iguana-web-apps/"}
   NewSample.locations[#NewSample.locations + 1] = NewRepo
   local Config = cm.config.open{file=ConfigFile}
   Config:addRepo(NewRepo.Name, NewRepo.Source, NewRepo.Type, NewRepo.RemoteSource)
   local Expected = {}
   setmetatable(Expected, meta)
   Expected.file = ConfigFile
   Expected.config = NewSample
   unittest.assertEqual(Expected, Config)
   os.remove(ConfigFile)
   
   -- Create a config file with current format 
   -- Add a repo, save it, create a new config object which loads it
   -- Confirm you can access new repo.
   
end

-- Could do s similar test with deleting a repo.
-- Create a function to make a fake config table
-- Compatibility test with Windows