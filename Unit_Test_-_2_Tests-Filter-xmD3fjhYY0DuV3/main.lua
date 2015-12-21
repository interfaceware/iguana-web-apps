require 'web.file'
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
   queue.push{data=Data}

   return Result
end