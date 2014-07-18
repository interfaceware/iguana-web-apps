
-- stringutil contains a number of extensions to the standard Lua String library. 
-- As you can see writing extra methods that will work on strings is very easy. 
-- See http://www.lua.org/manual/5.1/manual.html#5.4 for documentation on the Lua String library

function string.UnEscape(sText)
   sText = sText:gsub('\\T\\nbsp;', '&nbsp;')
   sText = sText:gsub('\\F\\', '/')
   sText = sText:gsub('\\T\\', '+')
   sText = sText:gsub('\\S\\', '*')
   sText = sText:gsub('\\R\\', '-')
   sText = sText:gsub('\\E\\', '/')   
   return sText
end

function string:isIn(tList)
   local bReturn = false
   for k,v in pairs(tList) do
      if v == self then
         bReturn = true
      end
   end
   return bReturn
end
-- string.isIn
h = {}
h.Title = 'stringutil:isIn'
h.Desc = 'Checks if a string value is in a table'
h.Usage = 'string:isIn({s1,s2,s3,...})'
h.Returns = {}
h.Returns[1] = {}
h.Returns[1].Desc = 'Boolean'
help.set{input_function=string.isIn, help_data=h}


function string:Q()
      return "'"..self:gsub("'", "''") .."'"
end

function string:N()
   return tonumber(self)
end

function string:split(sDelimiter, bNoTrim)
   t = {}
   s = self .. sDelimiter:gsub('%%', '')
   nEsc = 0
   if sDelimiter:find('%%') then
      nEsc = 1
   end
   
   if not bNoTrim then
      s = s:gsub('%s$', '')
   end
   s:gsub('(.-' .. sDelimiter .. ')', function(ss) 
         table.insert(t, ss:sub(1, -1-#sDelimiter+nEsc))   
      end)
   return t
end

function string:proper(bPreserveUpper)
   local tPattern = {' Ma?c%a', '%a+%-%a', "[ %-]O'%a", '%a+/%a'}
   
   -- add a space to beginning for reasons that will become clear soon
   local sResult = ' ' .. self
   
   if not bPreserveUpper then
      -- start with everything in lower case
      sResult = sResult:lower()
   end
   
   -- capitalise the first letter following a spaceincluding the first character in the string
   sResult = sResult:gsub(' %a', function (s)
      return s:upper()
    end)
   
   -- now loop through the patterns and capitalise the last letter in the pattern
   for nCntr = 1, #tPattern do
      sResult = sResult:gsub(tPattern[nCntr], function (s)
            return s:sub(1, -2) .. s:sub(-1):upper()
         end)         
   end
   
   -- return all except the added first space
   return sResult:sub(2)
end

-- Trims white space on both sides.
function string.trimWS(self)  
   local L, R
   L = #self
   while _isWhite(self:byte(L)) and L > 1 do
      L = L - 1
   end
   R = 1
   while _isWhite(self:byte(R)) and R < L do
      R = R + 1
   end     
   return self:sub(R, L)
end

-- Trims white space on right side.
function string.trimRWS(self)
   local L
   L = #self
   while _isWhite(self:byte(L)) and L > 0 do
      L = L - 1
   end
   return self:sub(1, L)
end

-- Trims white space on left side.
function string.trimLWS(self)
   local R = 1
   local L = #self
   while _isWhite(self:byte(R)) and R < L do
      R = R + 1
   end
   return self:sub(R, L)
end

function _isWhite(byte) 
   return byte == 32 or byte == 9
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

function string.oldsplit(s, d)
   local t = {}
   local i = 0
   local f
   local match = '(.-)' .. d .. '()'
   if string.find(s, d) == nil then
      return {s}
   end
   for sub, j in string.gfind(s, match) do
      i = i + 1
      t[i] = sub
      f = j
   end
   if i~= 0 then
      t[i+1]=string.sub(s,f)
   end
   return t
end

function string.left(self, n)
   return self:sub(1, n)
end

function string.right(self, n)
   return self:sub(-n)
end

-- This routine will remove spaces 
function string.removeWS(self) 
   return self:gsub("%s+", "") 
end


function string:HTML_To_HL7Text ()
  -- nbased on code from http://developer.coronalabs.com/code/strip-html-tags-text
   -- Declare variables, load the file. Make tags lowercase.
   text = string.gsub (self,"(%b<>)",
  function (tag)
    return tag:lower()
  end)
  -- Ok, same for styles.
  text = string.gsub (text, "(<%s*style[^>]*>)", "<style>")
  text = string.gsub (text, "(<%s*%/%s*style%s*>)", "</style>")
  text = string.gsub (text, "(<style>.*<%/style>)", "")
    
  -- Replace <br> with linebreaks.
  text = string.gsub (text, "(<%s*br%s*%/%s*>)","\\.br\\")
  text = string.gsub (text, "(<%s*br%s*>)","\\.br\\")
  
  -- Replace <li> with an asterisk surrounded by 2 spaces.
  -- Replace </li> with a newline.
  text = string.gsub (text, "(<%s*li%s*%s*>)"," *  ")
  text = string.gsub (text, "(<%s*/%s*li%s*%s*>)","\\.br\\")
  
  -- <p>, <div>, <tr>, <ul> will be replaced to a double newline.
    text = string.gsub (text, "(<%s*div[^>]*>)", "\\.br\\\\.br\\")
    text = string.gsub (text, "(<%s*p[^>]*>)", "\\.br\\\\.br\\")
    text = string.gsub (text, "(<b>)", "\\H\\")
    text = string.gsub (text, "(</b>)", "\\N\\")
  
  -- Nuke all other tags now but only those without a space to open
   -- trying to stop replacing of measurement results eg a < b > c
  text = string.gsub(text, '<%s', '_#')
  text = string.gsub (text, "(%b<>)","")
  text = string.gsub(text, '_#', '< ')
   
  -- Replace entities to their correspondant stuff where applicable.
  local entities = {}
  setmetatable (entities,
  {
    __newindex = function (tbl, key, value)
      key = string.gsub (key, "(%#)" , "%%#")
      key = string.gsub (key, "(%&)" , "%%&")
      key = string.gsub (key, "(%;)" , "%%;")
      key = string.gsub (key, "(.+)" , "("..key..")")
      rawset (tbl, key, value)
    end
  })
  entities = 
  {
    ["&nbsp;"] = " ",
    ["&bull;"] = " *  ",
  }
  for entity, repl in pairs (entities) do
    text = string.gsub (text, entity, repl)
  end
  
   -- remove space on lines with nothing else  
   text = string.gsub(text, '(\\%.br\\%s+\\%.br\\)', '\\.br\\\\.br\\')
   -- replace 3 or more blank lines with 2 blank lines
   text = string.gsub(text, '\\%.br\\\\%.br\\[\\%.br\\]+', '\\.br\\\\%.br\\')
  return text
  
end

-- string.HTML_to_HL7Text
h = {}
h.Title = 'stringutil:HTML_to_HL7Text'
h.Desc = 'Converts HTML formatted text into HL7 formatted text'
h.Usage = 'string:HTML_to_HL7Text()'
h.Returns = {}
h.Returns[1] = {}
h.Returns[1].Desc = 'String: Text reformatted to HL7 encoding'
help.set{input_function=string.HTML_To_HL7Text, help_data=h}

function string:stripHTML ()
  -- based on code from http://developer.coronalabs.com/code/strip-html-tags-text
   -- Declare variables, load the file. Make tags lowercase.
  text = string.gsub (self,"(%b<>)",
  function (tag)
    return tag:lower()
  end)
  -- Ok, same for styles.
  text = string.gsub (text, "(<%s*style[^>]*>)", "<style>")
  text = string.gsub (text, "(<%s*%/%s*style%s*>)", "</style>")
  text = string.gsub (text, "(<style>.*<%/style>)", "")
    
  -- Replace <br> with linebreaks.
  text = string.gsub (text, "(<%s*br%s*%/%s*>)","\r\n")
  text = string.gsub (text, "(<%s*br%s*>)","\r\n")
  
  -- Replace <li> with an asterisk surrounded by 2 spaces.
  -- Replace </li> with a newline.
  text = string.gsub (text, "(<%s*li%s*%s*>)"," *  ")
  text = string.gsub (text, "(<%s*/%s*li%s*%s*>)","\\.br\\")
  
  -- <p>, <div>, <tr>, <ul> will be replaced to a double newline.
    text = string.gsub (text, "(<%s*div[^>]*>)", "\r\n\r\n")
    text = string.gsub (text, "(<%s*p[^>]*>)", "\r\n\r\n")
  
  -- Nuke all other tags now but only those without a space to open
   -- trying to stop replacing of measurement results eg a < b > c
  text = string.gsub(text, '<%s', '_#')
  text = string.gsub (text, "(%b<>)","")
  text = string.gsub(text, '_#', '< ')
   
     -- remove space on lines with nothing else  
   text = string.gsub(text, '(\r\n%s+\r\n)', '\r\n\r\n')
   -- replace 3 or more blank lines with 2 blank lines
   text = string.gsub(text, '\r\n\r\n[\r\n]+', '\r\n\r\n')
   
   -- Replace entities to their correspondant stuff where applicable.
  local entities = {}
  setmetatable (entities,
  {
    __newindex = function (tbl, key, value)
      key = string.gsub (key, "(%#)" , "%%#")
      key = string.gsub (key, "(%&)" , "%%&")
      key = string.gsub (key, "(%;)" , "%%;")
      key = string.gsub (key, "(.+)" , "("..key..")")
      rawset (tbl, key, value)
    end
  })
  entities = 
  {
    ["&nbsp;"] = " ",
    ["&bull;"] = " *  ",
  }
  for entity, repl in pairs (entities) do
    text = string.gsub (text, entity, repl)
  end
  
  return text
  
end

-- string.stripHTML
h = {}
h.Title = 'stringutil:stripHTML'
h.Desc = 'Strips HTML formatting from text'
h.Usage = 'string:stripHTML()'
h.Returns = {}
h.Returns[1] = {}
h.Returns[1].Desc = 'String: Text reformatted to plain text'
help.set{input_function=string.stripHTML, help_data=h}
