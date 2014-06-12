-- The built in json.serialize routine throws an error when you pass it a user data object
--
-- This is an experimental replacement function which is meant to provide a nicer
-- interface.  It recursively searches through the code.  When it finds a userdata
-- object it checks to see if has the property nodeValue.  This indicates it is a node
-- tree.  Then it checks to see if we have a branch or a node by calling the # operator.
-- Branches (#N >0) are converted to strings using "tostring" and
-- Leaf nodes (#N == 0) are converted to strings using nodeValue()

-- The result is cleaner syntax when building up JSON trees.


local function ConvertUserData(T)
   for K,V in pairs(T) do
      local TypeV = type(V)
      if TypeV == 'userdata' then
         if (V.nodeValue) then
            if (#V > 0) then
               T[K] = tostring(V)
            else  
               T[K] = V:nodeValue()
            end
         end
      elseif TypeV == 'table' then
         ConvertUserData(V)
      end
   end
end

JsonSerializeSaveFunction = json.serialize

function json.serialize(T)
   ConvertUserData(T.data)
   return JsonSerializeSaveFunction(T)
end
