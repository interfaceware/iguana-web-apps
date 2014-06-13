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
   local DB = testrunner.db.connect()
   local RSet = DB:execute{sql="SELECT * FROM hosts", live=true}
   local CurrentHosts = {}
   local ErrorList = {}
   for x=1,#RSet do
      table.insert(CurrentHosts, RSet[x].host_id)
   end
   local Incoming = json.parse{data=Hosts.body}
   for i=1,#Incoming do
      if #CurrentHosts > 0 then
         for x=1,#CurrentHosts do
            if tostring(CurrentHosts[x]) == Incoming[i].host_id then
               Incoming[i]['results'] = RSet[i].results:nodeValue()
               config.saveHost(Incoming[i])
               CurrentHosts[x] = nil
            else
               config.saveHost(Incoming[i])
            end
         end
      else
         config.saveHost(Incoming[i])
      end
   end
   for i=1,#CurrentHosts do
      if keyExists(CurrentHosts, i) then
         config.deleteHost(CurrentHosts[i])
      end
   end
   if #ErrorList > 0 then
      return ErrorList
   else
      return {true}
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
function config.getHosts()
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