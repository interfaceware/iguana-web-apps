-- This script maps specific patient data to an external database.

-- Connect to database
DB = db.connect{api=db.SQLITE, name='Demo/PatientData.sqlite'}

local DbSchema = dbs.tableLayoutFromFile{filename='todatabase/example.dbs'}
   
function main(Data)
   
   -- Parse incoming raw message with hl7.parse
   local MsgIn = hl7.parse{vmd='example/demo.vmd', data=Data}
   
   -- Build node tree of table to temporarily store information
   -- tables.vmd name = 'ADT'
   local TableOut = DbSchema:getTableSet('ALL')
   
   -- Map fields from PID segment to Patient table
   MapPatient(TableOut.Patient[1], MsgIn.PID)
   
   -- Insert information from TableOut into the real table
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
