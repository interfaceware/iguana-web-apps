require 'db.sqlite'

function main(Data)
   local Hl7 = hl7.parse{vmd='example/demo.vmd', data=Data}
   local T = db.tables{vmd="bedtables.vmd", name="ADT"}
   local Db = connect()
   
   if Hl7.MSH[9][1]:nodeValue() == 'ADT' then

      if Hl7.MSH[9][2]:nodeValue() == 'A03' then
         dischargePatient(T.bed[1], Hl7.PV1)
      else
         mapPatient(T.bed[1], Hl7.PID)
         mapVisit(T.bed[1], Hl7.PV1)
         mapObservation(T.bed[1], Hl7.OBX)
      end
      
      trace(tostring(T))
      
      Db:merge{data=T, live=true}
   end
end

function dischargePatient(T, PV1)
   T.patient_first_name = ""
   T.patient_last_name = ""
   T.condition = ""
   mapVisit(T, PV1)
end

function mapPatient(T, PID)
   T.patient_first_name = PID[5][1][2]:nodeValue()
   T.patient_last_name = PID[5][1][1][1]:nodeValue()
end

function mapVisit(T, PV1)
   T.ward = PV1[3][1]:nodeValue()
   T.bed_name = PV1[3][3]
end

function mapObservation(T, OBX)
   T.condition = OBX[3][5][1][2]   
end
