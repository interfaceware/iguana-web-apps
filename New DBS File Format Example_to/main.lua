-- This script maps specific patient data to an external database.
-- It makes use of the example DBS file format which was introduced
-- in Iguana 5.6.8.  If you have an earlier version of Iguana then
-- this won't work.

-- Connect to database
DB = db.connect{api=db.SQLITE, name='Demo/PatientData.sqlite'}

-- This dbs file support requires Iguana 5.6.8 or above.
local DbSchema = dbs.init{filename='todatabase/example.dbs'}

function main(Data)
   -- Parse incoming raw message with hl7.parse
   local MsgIn = hl7.parse{vmd='example/demo.vmd',
                          data=Data}
 
   -- Let's just get all the tables.
   local TableOut = DbSchema:tables()
   
   -- Map fields from PID segment to Patient table
   MapPatient(TableOut.Patient[1], MsgIn.PID)
   
   -- Insert information from TableOut into the real DB
   DB:merge{data=TableOut, live=false}
   -- Change the above live=false to live=true 
   
   -- Remove comment below and click Result Set in the
   -- annotations to the right
   --DB:query{sql='Select * from Patient'}
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
