local csv = {}

local function escape(V)
   V = V:rxsub('\"', '""')
   return V
end

-- This is for a JSON based file
function csv.formatHeaders(R)
   local Headers = ''
   for K, V in pairs(R) do
      if type(V) == 'string' or type(V) == 'number' then
         Headers = Headers .. '"'..K..'",'
      end
   end
   Headers = Headers:sub(1, #Headers-1)
   return Headers
end

-- This is for a JSON based file
function csv.formatLine(R)
   local Line = ''
   for K,V in pairs(R) do
      if type(V) == 'string' then
         Line = Line .. '"'..escape(V)..'",'
      elseif type(V) == 'number' then
         Line = Line ..V..","    
      end
   end
   Line = Line:sub(1, #Line-1)
   return Line
end

function csv.formatCsv(T)
   if #T == 0 then 
      return ''
   end
   local Headers = ''
   for i=1, #T[1] do
      Headers = Headers .. '"'..T[1][i]:nodeName()..'",'
   end
   -- Get rid of the trailing ,
   Headers = Headers:sub(1, #Headers-1)
   trace(Headers)
   local Data = Headers.."\n"
   for i=1, #T do
      local Line = ''
      local Row = T[i]
      for j=1, #Row do 
         local CType = Row[j]:nodeType()
         if CType == 'string' then
            Line = Line..'"'..escape(Row[j]:nodeValue())..'",'
         else -- for datetime, integer, double
            Line = Line..Row[j]:nodeValue()..","
         end
      end
      trace(Line)
      -- strip trailing ,
      Line = Line:sub(1, #Line-1)
      Data = Data..Line .."\n"
   end
   trace(Data)
   return Data
end

-- We write to a temp file and rename it *after* we have finished writing the data.
function csv.writeFileAtomically(Name,Content)
   local FileNameTemp = Name..".tmp"
   local F = io.open(FileNameTemp, "w")
   F:write(Content)
   F:close()
   -- Atomically rename file once we are done!
   os.rename(FileNameTemp, Name)
end


return csv