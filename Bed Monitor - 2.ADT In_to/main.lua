require 'bedmonitor.db'
require 'node'

bedmonitor.db.init()

function main(Data)
 
   local Hl7 = hl7.parse{vmd='app/bedmonitor/demo.vmd', data=Data}
   local T = db.tables{vmd="app/bedmonitor/bedtables.vmd", name="ADT"}
   local Db = bedmonitor.db.connect()
   
   if Hl7.MSH[9][1]:nodeValue() == 'ADT' then
      if Hl7.MSH[9][2]:nodeValue() == 'A03' then
         DischargePatient(T.bed[1], Hl7.PV1)
      else
         MapPatient(T.bed[1], Hl7.PID)
         MapVisit(T.bed[1], Hl7.PV1)
         MapObservation(T.bed[1], Hl7.OBX)
      end
 
      T:S()
      Db:merge{data=T, live=true}
   end
end

function DischargePatient(T, PV1)
   T.patient_first_name = ""
   T.patient_last_name = ""
   T.condition = ""
   MapVisit(T, PV1)
end

function MapPatient(T, PID)
   T.patient_first_name = PID[5][1][2]:nodeValue()
   T.patient_last_name = PID[5][1][1][1]:nodeValue()
end

function MapVisit(T, PV1)
   T.ward = PV1[3][1]:nodeValue()
   T.bed_name = PV1[3][3]
end

function MapObservation(T, OBX)
   T.condition = OBX[3][5][1][2]   
end
