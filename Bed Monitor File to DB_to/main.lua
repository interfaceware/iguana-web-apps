-- TODO - could do with real sample data.

function main(Data)
   local Hl7 = hl7.parse{vmd='example/demo.vmd', data=Data}
   local T = db.tables{vmd="bedtables.vmd", name="ADT"}
   local Db = connect()
   
   if Hl7.MSH[9][1]:nodeValue() == 'ADT' then
      -- TODO - can we catch real discharges?
      -- Every one out of four is a discharge
      if math.random(4) < 4 then
         mapPatient(T, Hl7.PID)
         mapVisit(T, Hl7.PV1)
         mapObservation(T, Hl7.OBX)
      else
         dischargePatient(T, Hl7.PV1)
      end
      
      trace(tostring(T))
      
      Db:merge{data=T, live=true}
   end
end

-- TODO pass in T.bed[1] as first argument.
function dischargePatient(T, PV1)
   T.bed[1].patient_first_name = ""
   T.bed[1].patient_last_name = ""
   T.bed[1].condition = ""
   mapVisit(T, PV1)
end

-- TODO pass in T.bed[1] as first argument.
function mapPatient(T, PID)
   T.bed[1].patient_first_name = PID[5][1][2]:nodeValue()
   T.bed[1].patient_last_name = PID[5][1][1][1]:nodeValue()
end

-- TODO pass in T.bed[1] as first argument.
function mapVisit(T, PV1)
   T.bed[1].ward = PV1[3][1]:nodeValue()
   T.bed[1].bed_name = PV1[3][3]
end

-- TODO pass in T.bed[1] as first argument.
function mapObservation(T, OBX)
   T.bed[1].condition = OBX[3][5][1][2]   
end

-- TODO - share this database connection in common module with the GUI
function connect()
   return db.connect{api=db.SQLITE, name='bedmonitor', live=true}
end