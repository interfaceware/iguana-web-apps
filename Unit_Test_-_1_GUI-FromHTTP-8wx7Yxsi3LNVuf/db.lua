testrunner.db = {}
   
function testrunner.db.connect()
   return db.connect{api=db.SQLITE, name='testrunner.sqlite', live=true}
end

function testrunner.db.init()
   local Conn = testrunner.db.connect()
   local Result = Conn:query{sql='SELECT * FROM sqlite_master WHERE type="table" and name="hosts"', live=true}
   if #Result == 0 then
      Conn:execute{sql=[[CREATE TABLE hosts (
         host_id INTEGER PRIMARY KEY AUTOINCREMENT,
         name TEXT(255) NULL,
         host TEXT(255) NULL,
         https INTEGER NULL,
         port TEXT(255) NULL,
         http_port TEXT(255) NULL,
         user TEXT(255) NULL,
         pass TEXT(255) NULL,
         results TEXT NULL
      );]], live=true}
      
      Conn:execute{sql=[[CREATE UNIQUE INDEX host_idx ON hosts (host_id, name);]], live=true}
      
      Conn:execute{sql=[[CREATE TABLE config (
         test_suite TEXT(255) NULL,
         github_commit_hash TEXT NULL,
         github_oauth_token TEXT NULL,
         github_repo TEXT NULL,
         local_git_repo TEXT NULL
      );]], live=true}
      
      Conn:execute{sql=[[INSERT INTO config (github_commit_hash) VALUES ('first run')]], live=true}
      
      local name = Conn:quote('local')
      local host = Conn:quote('localhost')
      local https 
      if iguana.webInfo().https_channel_server.use_https then
         https = '1'
      else
         https = '0'
      end
      local port = Conn:quote(tostring(iguana.webInfo().web_config.port))
      local http_port = Conn:quote(tostring(iguana.webInfo().https_channel_server.port))
      local user = Conn:quote('admin')
      local pass = Conn:quote('password')
      
      SQL = [[INSERT INTO hosts (name, host, https, port, http_port, user, pass)]]
      SQL = SQL .. ' VALUES (' .. name .. ', ' .. host .. ', ' .. https .. ', ' .. port .. ', ' .. http_port .. ', ' .. user .. ', ' .. pass .. ')'
      
      Conn:execute{sql=SQL, live=true}
   end
   Conn:close()
end

testrunner.db.init()

return testrunner.db