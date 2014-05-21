monitor = {}

require 'monitor.detail'
require 'monitor.main'

local function CreateDatabase(C)
   local C = monitor.connection()
   C:execute{sql=[[DROP TABLE IF EXISTS status]], live=true}
   C:execute{sql=[[CREATE TABLE status (
      server_guid TEXT NOT NULL,
      name TEXT,
      ts INTEGER,
      summary TEXT,
      status INTEGER,
      PRIMARY KEY (server_guid))]], live=true} 
   return {status='OK'}
end

function monitor.connection()
   return db.connect{api=db.SQLITE, name='status'}
end

function monitor.init()
   local Connection = monitor.connection()
   local Result = Connection:query{sql='SELECT * FROM sqlite_master WHERE type="table" and name="status"', live=true}
   Connection:close()
   if #Result == 0 then
      CreateDatabase();
   end
end

local function MapAgentRequest(T, R)
   T.server_guid = R.guid
   T.ts = os.ts.time()
   T.summary = R.status
   T.status = R.retcode
   T.name = R.name
   return T
end


function monitor.receiveData(R)
   local C = monitor.connection()
   local T = db.tables{vmd='status.vmd', name='Message'}
   local Data = json.parse{data=R.body}
   MapAgentRequest(T.status[1], Data)
   C:merge{data=T, live=true}
   return {status='OK'}
end

monitor.Actions={
   ['send']=monitor.receiveData,
   ['summary']=monitor.main,
   ['detail']=monitor.detail,
   ['reset']=monitor.reset
}