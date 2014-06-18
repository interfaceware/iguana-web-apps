
local function getCondition(Row)
   local Cond = Row.condition:S()
   if Cond == '' then 
      return "N/A" 
   else
      return Cond
   end
end

local function getName(Row)
   if Row.patient_last_name:S() == "" then
      return "Unoccupied"
   else
      return Row.patient_last_name..", "..Row.patient_first_name
   end
end

function bedmonitor.app.listBeds(Request)
   local DB = bedmonitor.db.connect()
   local Data = DB:query{sql="SELECT * FROM bed"}
   local Results = {bed={}, name={}, condition={}}
   for i=1, #Data do
      local Row = Data[i]
      Results.bed[i] = Row.bed_name
      Results.name[i] = getName(Row)
      Results.condition[i] = getCondition(Row)
   end
   return Results
end




