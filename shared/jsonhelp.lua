-- There is a little annoyance with json.NULL - this module
-- creates a little helper function n() which checks for json.NULL
-- This helper method exists on string and json.NULL object.


local function ConvertNull(N)
   if json.NULL == N then
      return nil
   else
      return N
   end
end

-- Doing :n() on a string function is a null op

function string.n(V) 
   return V 
end

local function Init()
   local T = getmetatable(json.NULL)
   T["__index"] ={n=ConvertNull}
end

Init()

