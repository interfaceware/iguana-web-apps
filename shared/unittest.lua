unittest = {}


function unittest.findTest(Name)
   local T = Name:split('%.')
   local F = _G;
   for i=1, #T do
      F = F[T[i]]
   end
   return F
end


local function compare(Expected, Actual)
   if (type(Expected) ~= type(Actual)) then
      -- Type don't match
      return false
   end
   if (type(Expected) == 'userdata') then
      -- Cannot compare userdata
      return false
   end
   if (type(Expected) ~= 'table') then
      return (Expected == Actual) 
   end
   
   for K,V in pairs(Expected) do
      if not compare(V, Actual[K]) then
         return false
      end
   end
   for K, V in pairs(Actual) do
      if not Expected[K] then
         return false
      end
   end
   return true
end

local function asString(Object) 
   if (type(Object) == 'table') then 
      return json.serialize{data=Object} 
   else
      return tostring(Object)
   end
end


function unittest.assertEqual(Expected,Actual)
   local Match = compare(Expected, Actual)
   if (not Match) then
      error('Actual does not matched expected result\nExpected:\n'..asString(Expected)..'\nActual:\n'..asString(Actual), 2)
   end
end