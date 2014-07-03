function node.text(N)
   if #N > 0 then 
      for i = 1, #N do
         if N[i]:nodeType() == 'text' then
            return N[i]:S()
         end
      end
   end
   return ''
end

function xml.findElement(X, Name)
   if X:nodeName() == Name then return X end
   for i=1,#X do
      local C = xml.findElement(X[i], Name)
      if C then
         return C
      end
   end
   return nil
end

-- Put in logging and error catching around xml.parse
local RawParse = xml.parse
function xml.parse(T)
   local Success, Result = pcall(RawParse, T)
   if not Success then
      iguana.logWarning('Could not parse:\n'..T.data)
      error('Could not parse:\n'..T.data, 2)
   end
   return Result
end
