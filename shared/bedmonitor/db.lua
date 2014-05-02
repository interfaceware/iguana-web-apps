-- DB helpers can go here
if not bedmonitor then bedmonitor = {} end

bedmonitor.db = {}

function bedmonitor.db.connect()
   return db.connect{api=db.SQLITE, name='bedmonitor', live=true}
end

-- If the database has not been created we create it on the fly.
function bedmonitor.db.init()
   local Connection = bedmonitor.db.connect()
   local Result = Connection:query{sql='SELECT * FROM sqlite_master WHERE type="table" and name="bed"', live=true}
   if #Result == 0 then
      Connection:execute{sql="CREATE TABLE bed (bed_name TEXT(255) NOT NULL ,ward TEXT(255),patient_first_name TEXT(255),patient_last_name TEXT(255),condition TEXT(255),PRIMARY KEY (bed_name));"}
   end
   Connection:close()
end