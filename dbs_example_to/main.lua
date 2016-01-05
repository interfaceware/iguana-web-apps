-- This script maps specific patient data to an external database.
-- (this does the same thing as the 02 - Socket to Database demo channel
--  except that it loads the table schema from dbs file instead of vmd file)

require "dbs_meta"

-- Connect to database
DB = db.connect{api=db.SQLITE, name='Demo/PatientData.sqlite'}
-- load a copy of table schema from tables.dbs file
Schema = dbs.tableLayoutFromFile{filename="tables.dbs"}
-- create the tables in database if they don't already exist
dbs_create_tables(Connection, Schema)

function main(Data)
   -- Connection:execute{sql="drop table Patient", live=true}
   
   -- Parse incoming raw message with hl7.parse
   local MsgIn = hl7.parse{vmd='example/demo.vmd', data=Data}

   local TableOut = Schema:getTableSet("ADT");
   
   -- Map fields from PID segment to Patient table
   MapPatient(TableOut.Patient[1], MsgIn.PID)
   
   -- Insert information from TableOut into the real table
   DB:merge{data=TableOut, live=false}
   -- Change the above live=false to live=true 
   
   -- Remove comment below and click Result Set in the
   -- annotations to the right
   DB:query{sql='Select * from Patient'}
end

function MapPatient(Patient, PID)
   -- This function prepares the TableOut variable
   Patient.Id        = PID[3][1][1]
   Patient.FirstName = PID[5][1][2]
   Patient.LastName  = PID[5][1][1][1]
   Patient.Gender    = PID[8]   
   -- Click the Patient Row to the right to see results
   return Patient
end
