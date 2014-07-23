local config = {}
if not testrunner then testrunner = {} end
if not testrunner.db then testrunner.db = require 'testrunner.db' end

-- ##########
-- Runs when the save button is clicked after editing hosts.
-- First gets a list of current hosts and each host that isn't
-- submitted back gets deleted (because this means the delete key was
-- clicked). All other hosts are inserted or updated
-- ##########
function config.saveHosts(Hosts)
   local function isValid(Host)
      local IsValid = true
      local ErrorTable = {
         ['name'] = true,
         ['host'] = true,
         ['https'] = true,
         ['port'] = true,
         ['http_port'] = true,
         ['user'] = true,
         ['pass'] = true
      }

      if not type(Host.name) == 'string' or Host.name == '' then
         ErrorTable.name = false
      end
      
      if Host.host == '' then
         ErrorTable.host = false
      end
      
      if not (string.lower(Host.https) == 'false' or string.lower(Host.https) == 'true') and not (Host.https == '1' or Host.https == '2') then
         ErrorTable.https = false
      end
      
      if not tonumber(Host.port) then
         ErrorTable.port = false
      end
      
      if not tonumber(Host.http_port) then
         ErrorTable.http_port = false
      end
      
      if not type(Host.user) == 'string' or Host.user == '' then
         ErrorTable.user = false
      end
      
      if not type(Host.pass) == 'string' or Host.pass == '' then
         ErrorTable.pass = false
      end
      
      local Connected, Message = pcall(iguanaServer.connect, {url=Host.host .. ':' .. Host.port,username=Host.user,password=Host.pass})
      if not Connected then
         if string.lower(Message):find([[couldn't resolve host]]) then
            ErrorTable.host = false
            ErrorTable.port = false
         elseif string.lower(Message):find([[invalid username or password]]) then
            ErrorTable.user = false
            ErrorTable.pass = false
         elseif string.lower(Message):find([[couldn't connect to host]]) then
            ErrorTable.host = false
            ErrorTable.pass = false
         end
      end
      
      for k,v in pairs(ErrorTable) do
         if not ErrorTable[k] then
            IsValid = false
         end
      end
      
      return IsValid, ErrorTable
   end
   
   local DB = testrunner.db.connect()
   local RSet = DB:execute{sql="SELECT * FROM hosts", live=true}
   local CurrentHosts = {}
   local ErrorList = {}
   for x=1,#RSet do
      CurrentHosts[tostring(RSet[x].host_id)] = false
   end
   local Incoming = json.parse{data=Hosts.body}
   for i=1,#Incoming do
      if CurrentHosts[Incoming[i].host_id] ~= nil then
         Incoming[i]['results'] = RSet[i].results:nodeValue()
         CurrentHosts[Incoming[i].host_id] = true
      end
      Valid, Errors = isValid(Incoming[i])
      if Valid then
         config.saveHost(Incoming[i])
      else
         table.insert(ErrorList, {['index'] = i, ['errors'] = Errors})
      end
   end
   for k,v in pairs(CurrentHosts) do
      if not v then
         config.deleteHost(k)
      end
   end
   if #ErrorList > 0 then
      return {['err'] = true, ['message'] = 'There were some problems with the highlighted fields below.', ['data'] = ErrorList}
   else
      return {['err'] = false, ['message'] = 'Hosts saved successfully.'}
   end
end

-- ##########
-- Build the SQL statement from a table of host data and
-- execute against the DB with an INSERT OR REPLACE query.
-- The unique keys are host_id and name.
-- ##########
function config.saveHost(HostData)
   local DB = testrunner.db.connect()
   local SQL = "INSERT OR REPLACE INTO hosts (host_id,host,port,name,user,https,pass,http_port,results) VALUES ("
   if (HostData.host_id == nil or HostData.host_id == "") then
      SQL = SQL .. "null, "
   else
      SQL = SQL .. DB:quote(HostData.host_id) .. ", "
   end
   SQL = SQL .. DB:quote(HostData.host) .. ", "
   SQL = SQL .. DB:quote(HostData.port) .. ", "
   SQL = SQL .. DB:quote(HostData.name) .. ", "
   SQL = SQL .. DB:quote(HostData.user) .. ", "
   if HostData.https == "false" then
      SQL = SQL .. "0, "
   elseif HostData.https == "" then
      SQL = SQL .. ", "
   else
      SQL = SQL .. "1, "
   end
   SQL = SQL .. DB:quote(HostData.pass) .. ", "
   SQL = SQL .. DB:quote(HostData.http_port) .. ", "
   if HostData.results ~= nil then
      SQL = SQL .. DB:quote(HostData.results) .. ")"
   else
      SQL = SQL .. "NULL)"
   end
   
   pcall(DB.execute, DB, {sql=SQL, live=true})
end

-- ##########
-- Simply delete a host record by providing the host_id
-- ##########
function config.deleteHost(HostId)
   local DB = testrunner.db.connect()
   DB:execute{sql="DELETE FROM hosts WHERE host_id = " .. DB:quote(tostring(HostId)), live=true}
end

-- ##########
-- Retrieve a list of test hosts and return them
-- ##########
function config.getHosts(R)
   local Hosts = {}
   local DB = testrunner.db.connect()
   local RSet = DB:execute{sql="SELECT * FROM hosts", live=true}
   if #RSet > 0 then
      for i=1,#RSet do
         local host = RSet[i].name:S()
         Hosts[host] = {}
         Hosts[host].host_id = RSet[i].host_id:S()
         Hosts[host].host = RSet[i].host:S()
         if RSet[i].https:S() == '0' then
            Hosts[host].https = false
         else
            Hosts[host].https = true
         end
         Hosts[host].port = RSet[i].port:S()
         Hosts[host].http_port = RSet[i].http_port:S()
         Hosts[host].user = RSet[i].user:S()
         Hosts[host].pass = RSet[i].pass:S()
         Hosts[host].results = RSet[i].results:S()
      end
   else
      return {}
   end
   
   return Hosts
end

function config.getConfig(R)
   local DB = testrunner.db.connect()
   local RSET = DB:execute{sql="SELECT test_suite, github_oauth_token, github_repo, local_git_repo FROM config", live=true}[1]
   local Settings = {
      test_suite = RSET.test_suite,
      github_oauth_token = RSET.github_oauth_token,
      github_repo = RSET.github_repo,
      local_git_repo = RSET.local_git_repo
   }
   
   return {['err'] = false, ['message'] = 'Settings retrieved successfully.', ['data'] = Settings}
end

function config.saveConfig(R)
   local function isValid(Config)
      local ErrorTable = {
            ['github_repo'] = true,
            ['github_oauth_token'] = true,
            ['test_suite'] = true,
            ['local_git_repo'] = true
      }
      
      if Config.github_oauth_token ~= '' or Config.github_repo ~= '' then
         if Config.github_oauth_token ~= '' and Config.github_repo == '' then
            ErrorTable.github_oauth_token = false
         elseif Config.github_oauth_token == '' and Config.github_repo ~= '' then
            ErrorTable.github_repo = false
         elseif Config.github_oauth_token ~= '' and Config.github_repo ~= '' then
            GitJson = net.http.get{
               url='https://' .. Config.github_oauth_token .. ':x-oauth-basic@api.github.com/repos/' .. Config.github_repo .. '/commits',
               live=true,headers={['User-Agent']='iNTERFACEWARE Iguana'}
            }
            GitTable = json.parse{data=GitJson}
            
            if string.lower(GitJson):find([[api rate limit exceeded]]) then
               error([[GitHub API rate limit exceeded - this is probably due to too many failed authentication attempts. The unit testing app can't save your settings at this time.]])
               return
            end
            
            if GitTable.message ~= nil and string.lower(GitTable.message) == 'bad credentials' then
               ErrorTable.github_oauth_token = false
               GitJson2 = net.http.get{
                  url='https://api.github.com/repos/' .. Config.github_repo .. '/commits',
                  live=true,headers={['User-Agent']='iNTERFACEWARE Iguana'}
               }
               GitTable2 = json.parse{data=GitJson2}
               if string.lower(GitJson2):find([[api rate limit exceeded]]) then
                  error([[GitHub API rate limit exceeded - this is probably due to too many failed authentication attempts. The unit testing app can't save your settings at this time.]])
                  return
               end
               if GitTable2.message ~= nil and string.lower(GitTable2.message) == 'not found' then
                  ErrorTable.github_repo = false
               end
            end
            
            if GitTable.message ~= nil and string.lower(GitTable.message) == 'not found' then
               ErrorTable.github_repo = false
            end
         end
      end
      
      if string.lower(iguana.channelConfig{name=Config.test_suite}) == 'no channel by that name!' then
         ErrorTable.test_suite = false
      end
      
      if Config.local_git_repo == '' then
         ErrorTable.local_git_repo = true
      else
         if not os.fs.access(Config.local_git_repo .. '/.git', 'rw') then
            ErrorTable.local_git_repo = false
         end
      end

      for k,v in pairs(ErrorTable) do
         if v == false then
            return false, ErrorTable
         end
      end
      return true, ErrorTable
   end
   local Submitted = json.parse{data=R.body}
   local Valid, Results = isValid(Submitted)
   if Valid then
      local DB = testrunner.db.connect();
      local SQL = 'UPDATE config SET test_suite = ' .. DB:quote(Submitted.test_suite) .. 
      ', github_oauth_token = ' .. DB:quote(Submitted.github_oauth_token) .. 
      ', github_repo = ' .. DB:quote(Submitted.github_repo) .. 
      ', local_git_repo = ' .. DB:quote(Submitted.local_git_repo) .. 
      ';'
      trace(SQL)
      DB:execute{sql=SQL, live=true}
      return {['err'] = false, ['message'] = 'Config saved successfully.'}
   else
      return {['err'] = true, ['message'] = 'There were problems with the highlighted properties.', ['data'] = Results}
   end
   
end

-- ##########
-- Not currently in use
-- ##########
function config.getSuite()
   local DB = testrunner.db.connect()
   local RSet = DB:execute{sql="SELECT * FROM config", live=true}
end

-- ##########
-- Helper function for readability
-- ##########
function keyExists(table, key)
   return table[key] ~= nil
end

return config