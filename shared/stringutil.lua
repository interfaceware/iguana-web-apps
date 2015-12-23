-- The stringutil module
-- Copyright (c) 2011-2012 iNTERFACEWARE Inc. ALL RIGHTS RESERVED
-- iNTERFACEWARE permits you to use, modify, and distribute this file in accordance
-- with the terms of the iNTERFACEWARE license agreement accompanying the software
-- in which it is used.
-- See http://help.interfaceware.com/code/details/stringutil-lua

-- stringutil contains a number of extensions to the standard Lua String library. 
-- As you can see writing extra methods that will work on strings is very easy. 
-- See http://www.lua.org/manual/5.1/manual.html#5.4 for documentation on the Lua String library

-- Trims white space on both sides.
function string.trimWS(self)
   return self:match('^%s*(.-)%s*$')
end

-- Trims white space on right side.
function string.trimRWS(self)
   return self:match('^(.-)%s*$')
end

-- Trims white space on left side.
function string.trimLWS(self)
   return self:match('^%s*(.-)$')
end

-- This routine will replace multiple spaces with single spaces 
function string.compactWS(self) 
   return self:gsub("%s+", " ") 
end

-- This routine capitalizes the first letter of the string
-- and returns the rest in lower characters
function string.capitalize(self)
   local R = self:sub(1,1):upper()..self:sub(2):lower()
   return R
end
