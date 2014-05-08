require 'file'
require 'test.file'
require 'unittest'

-- This is the beginnings of showing how to unit test translator code nicely
function main(Data)
   Result = {}
   for K,V in pairs(test.file) do
      trace(K)
      Result[K] = pcall(V)
      trace(Result)
   end
   trace(Result)
   net.http.respond{body=json.serialize{data=Result}}
   return
   
--[[   local F = unittest.findTest(Data)   
   local Success
   if (iguana.isTest()) then
     F()
     Success = true
   else
     Success = pcall(F)
   end   
   local Result = {success=Success}
   net.http.respond{body=json.serialize{data=Result},
        entity_type='text/json'} ]] 
end