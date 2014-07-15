require 'file'
require 'test.file'
require 'test.cm.config'
require 'unittest'

-- This is the beginnings of showing how to unit test translator code nicely
function main(Data)
   Result = {}
   local LastError = nil
   local ErrMsg
   for K,V in pairs(test.file) do
      trace(K)
      Result[K], ErrMsg = pcall(V)
      trace(Result)
     if (Result[K] == false ) then LastError = Result[K] end
    end
  
   -- hard code for now - change to tree of functions
   for K,V in pairs(test.cm.config) do
      trace(K)
      Result[K], ErrMsg = pcall(V)
      trace(Result)   
      if (Result[K] == false ) then LastError = ErrMsg .. K end
   end
   
   trace(Result)
   queue.push{data=Data}

   if (LastError and iguana.isTest()) then
      error(LastError)
   end
   return Result
end