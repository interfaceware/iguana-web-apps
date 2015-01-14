-- $Revision: 1.5 $
-- $Date: 2013-10-23 20:30:15 $

--
-- The custom_merge module
-- Copyright (c) 2012-2013 iNTERFACEWARE Inc. ALL RIGHTS RESERVED
-- iNTERFACEWARE permits you to use, modify, and distribute this file in accordance
-- with the terms of the iNTERFACEWARE license agreement accompanying the software
-- in which it is used.
--

if not db then
   error('db module must be present.', 2)
end

if not db.connect then
   error('db.customMerge requires Iguana 5.5.1 or newer.', 2)
end
----------------------
local Conn, Params --The database handle and parameters for the method call.
local SQLmethods --Database specific methods, defined below.
----------------------
-- Returns a table with object-oriented methods to collect non-nil strings and to return them concatenated.
-- Inspired by: http://snippets.luacode.org/?p=snippets/String_Writer_108 (MIT/X11 License)
-- Due to technical limitations, the variable arguments (...) to write() may not display properly in annotations.

local function getStringWriter()
   return setmetatable({}, {
         __index = {
            write = function(self, ...)
               for _,s in ipairs({...}) do --Nil arguments will cause subsequent ones to be ignored.
                  self[#self + 1] = tostring(s)      
               end
               return self
            end,
            getValue = function(self)
               return table.concat(self)
            end
         },         
         _display = function(self)
            --Used in annotations - short and long view.
            return 'StringWriter', self:getValue()
         end
      }
   )
end
----------------------

local function OracleDateTime(Node, Buffer)
   Buffer:write('TO_DATE(\'', Node, '\', \'YYYY-MM-DD HH24:MI:SS\')')
end

local function addSQLValue(Node, Buffer)
   if Node:isNull() then
      Buffer:write('NULL')
      return
   end
   
   local curType = Node:nodeType()
   
   if SQLmethods[Params.api].AddValue and SQLmethods[Params.api].AddValue[curType] then
      SQLmethods[Params.api].AddValue[curType](Node, Buffer)
   elseif curType == 'string' then
      if tostring(Node):match('^0x%x+$') then
         Buffer:write(Node)
      else
         Buffer:write(Conn:quote(tostring(Node)))
      end
   elseif curType == 'datetime' then      
      Buffer:write(Conn:quote(tostring(Node)))
   else --Double or integer assumed.
      Buffer:write(Node)
   end   
end

local function addKeyConditions(Row, Buffer, Keys)
   Buffer:write(' WHERE ')
   for i = 1,#Keys do
      if i > 1 then
         Buffer:write(' AND ')
      end
      Buffer:write(Keys[i], ' = ')
      addSQLValue(Row[Keys[i]], Buffer)            
   end   
end

local function addRowInsert(TableName, Row, Buffer)   
   Buffer:write('INSERT INTO ', TableName, '(')
   local NotFirstVal = false
   for i=1, #Row do
      if Row[i]:nodeValue() ~= '' or
         (Row[i]:nodeValue() == '' and Params.merge_null) then
         if i ~= 1 and NotFirstVal then
            Buffer:write(', ')
         end
         Buffer:write(Row[i]:nodeName())         
         NotFirstVal = true
      end
   end   
   Buffer:write(') VALUES(')
   NotFirstVal = false
   for i=1, #Row do
      if Row[i]:nodeValue() ~= '' or
         (Row[i]:nodeValue() == '' and Params.merge_null) then
         if NotFirstVal then
            Buffer:write(', ')
         end
         addSQLValue(Row[i], Buffer)
         NotFirstVal = true
      end
   end
   Buffer:write(')')
end

local function addRowUpdate(TableName, Row, Buffer, Keys)   
   Buffer:write('UPDATE ', TableName, ' SET ')
   local NotFirstVal = false
   for i=1, #Row do      
      if Row[i]:nodeValue() ~= '' or
         (Row[i]:nodeValue() == '' and Params.merge_null) then
         if NotFirstVal then
            Buffer:write(', ')
         end
         Buffer:write(Row[i]:nodeName(),' = ')
         addSQLValue(Row[i], Buffer)
         NotFirstVal = true
      end
   end   
   addKeyConditions(Row, Buffer, Keys)    
end

local function genericMergeSQL(Table, Statements, Keys)
   for i=1, #Table do
      local Buffer = getStringWriter()
      if i > 1 then
         Buffer:write('\n')
      end
      local count = 0
      if #Keys > 0 then
         local CountBuffer = getStringWriter()
         CountBuffer:write('SELECT COUNT(', Keys[1],
            ') FROM ', Table:nodeName())
         addKeyConditions(Table[i], CountBuffer, Keys)            
         
         local results = Conn:query(CountBuffer:getValue())
         count = tonumber(results[1][1]:nodeValue())
      end
      if count == 0 then
         addRowInsert(Table:nodeName(), Table[i], Buffer)
      elseif count == 1 then
         addRowUpdate(Table:nodeName(), Table[i], Buffer, Keys)         
      else         
         error('Multiple rows found with same primary keys in table '
            .. Table:nodeName() .. '.')
      end
      Statements[#Statements+1] = Buffer:getValue()
   end
end

local function batchBeginEnd(Statements)
   return 'BEGIN\n' .. table.concat(Statements, ';\n') .. ';\nEND;'
end

SQLmethods = { --Declared as local at the top.
   [db.MY_SQL]      = {Merge = genericMergeSQL},
   [db.ORACLE_OCI]  = {Merge = genericMergeSQL, Batch = batchBeginEnd, AddValue = {datetime = OracleDateTime}},
   [db.ORACLE_ODBC] = {Merge = genericMergeSQL, Batch = batchBeginEnd, AddValue = {datetime = OracleDateTime}},
   [db.SQL_SERVER]  = {Merge = genericMergeSQL, Batch = batchBeginEnd},
   [db.SQLITE]      = {Merge = genericMergeSQL},
}

local function getMergeStatements()
   local Tables = Params.data      
  
   local SQLstatements = {}   
   for i=1, #Tables do      
      --Need non-zero number of rows to merge and to determine keys.
      if #Tables[i] > 0 then
         local Keys = {}      
         
         for j=1,#Tables[i][1] do
            if Tables[i][1][j]:isKey() then
               Keys[#Keys + 1] = Tables[i][1][j]:nodeName()
            end
         end      
         
         SQLmethods[Params.api].Merge(Tables[i], SQLstatements, Keys)
      end 
   end
   return SQLstatements
end

local function checkTable(T, CallDepth)
   if type(T) ~= 'table' then
      error('Expected a table of parameters.', CallDepth)
   end
end

local function checkParam(ParamTable, List, CallDepth)
   for i=1, #List do
      if not ParamTable[List[i]] then
         error('Missing parameter "'..List[i]..'".', CallDepth)
      end
   end
end

local function getParams(arg1, arg2, CallDepth)
   if getmetatable(arg1) == getmetatable(db)._submeta.db_connection then
      --First argument is a db.connection, so second one is the method parameters.
      Conn, Params = arg1, arg2
      
      Params.api = Conn:info().api
      Params.name = Conn:info().name
      
      if Conn:info().live == false --Connection itself isn't live.
         then Params.live = false
      end
   else --Assume no db.connection was passed in.  
      Params = arg1
      checkTable(Params, CallDepth + 1)
      checkParam(Params, {'api','name','user','password'}, CallDepth + 1)
      Conn = db.connect{ 
         api=Params.api, 
         name=Params.name,
         user =Params.user,
         password = Params.password,
         use_unicode = Params.use_unicode,
         timeout = Params.timeout,
         live = Params.live
      }
      Params.IsTempConnection = true
   end   
   
   checkParam(Params, {'data'}, CallDepth + 1)
      
   if not SQLmethods[Params.api] then 
      error('Merge using this database API is not currently supported.', CallDepth)
   end
      
   if type(Params.data) ~= 'userdata' or not Params.data:nodeType() or Params.data:nodeType() ~= 'table_collection' then
      error('The data parameter must be a table collection as produced from db.tables{}.', CallDepth)
   end 
   
   -- merge_null defaults to true to match db.merge() behaviour
   if Params.merge_null == nil then Params.merge_null = true end
      
   -- transaction defaults to true to match db.merge() behaviour
   if Params.transaction == nil then Params.transaction = true end
end

function db.customMerge(arg1, arg2, CallDepth)
   if not CallDepth then
      --Assume this function is being called directly.
      CallDepth = 2
   end
   
   getParams(arg1,arg2,CallDepth + 1)
   
   local MergeSQL = getMergeStatements()     
   
   if Params.transaction then            
      Conn:begin{live = Params.live}      
   end
      
   local success, result = pcall(
      --Enclosing the merge in a pcall to be able to roll back.
      function(Conn, Params, MergeSQL)
         if SQLmethods[Params.api].Batch then --Batch the operations if we can.
            Conn:execute{sql = SQLmethods[Params.api].Batch(MergeSQL), live = Params.live}
         else
            for i=1,#MergeSQL do
               Conn:execute{sql = MergeSQL[i], live = Params.live}
            end
         end
      end,
      Conn, Params, MergeSQL
   )
   
   --Commit or rollback the transaction, if we began one.
   if success then 
      if Params.transaction then Conn:commit{live = Params.live} end
   else
      if Params.transaction then Conn:rollback{live = Params.live} end
      error(result, CallDepth)
   end
   
   if Params.IsTempConnection then Conn:close() end
      
   if Params.live ~= true then
      return 'Operation not live.'
   end           
end

--A wrapper for db.customMerge for object-oriented use with db.connections.
--We do it this way to attach different help data to the wrapper.
getmetatable(db)._submeta.db_connection.__index.customMerge = function(arg1, arg2)   
   local CallDepth = 2 --Used for bubbling up errors to where the method is being called.
   checkTable(arg2, CallDepth + 1) --Expecting a db.connection and a table of parameters.     
   local res = db.customMerge(arg1, arg2, CallDepth + 1)
   --Avoiding a tail call (which changes the call stack in Lua) so errors can be bubbled up properly.
   return res
end

if help then
   --Help data for use as db.customMerge().
   help.set{input_function=db.customMerge,      
      help_data= {
         SummaryLine = 'Merges records into a database (customizable Lua method).',
         Desc = 'Merges records into a database. This is a special, customizable method written in Lua. '..
         'It currently supports MySQL, SQL Server, Oracle ODBC/OCI, and SQLite.',
         Parameters = {
            {api = {Desc = 'Database API, should be in the form: db.SQL_SERVER, db.MY_SQL, etc.'}},
            {name = {Desc = 'Database name/address.'}},
            {user = {Desc = 'User name.'}},
            {password = {Desc = 'Password.'}},         
            {data = {Desc = 'The data to merge, in the form of a node tree created using db.tables().'}},         
            {live = {Desc = 'Whether operation should be executed live in the editor (default = false).', Opt = true}},
            {use_unicode = {Desc = 'Whether Unicode should be used when communicating with the database.', Opt = true}},
            {timeout = {Desc = 'Maximum time in seconds allowed for the connection (0 for infinite).', Opt = true}},
            {transaction = {Desc = 'Whether merge should be performed as a transaction (default = true).', Opt = true}},
            {merge_null = {Desc = 'Whether NULL values should be updated/inserted (default = true).', Opt = true}},                 
         },         
         Title = 'db.customMerge',
         Usage = "db.customMerge{api=&#60;value&#62;, name=&#60;value&#62;, ...}",
         SeeAlso = {{Title = 'More on customMerge', Link = 'http://wiki.interfaceware.com/888.html'}},
         ParameterTable = true
      }
   } 
   
   --Help data for use as conn:customMerge().
   help.set{input_function=getmetatable(db)._submeta.db_connection.__index.customMerge,
      help_data={
         SummaryLine = 'Merges records into a database (customizable Lua method).',
         Desc = 'Merges records into a database. This is a special, customizable method written in Lua. '..
         'It currently supports MySQL, SQL Server, Oracle ODBC/OCI, and SQLite.',
         Parameters = {      
            {data = {Desc = 'The data to merge, in the form of a node tree created using db.tables().'}},         
            {live = {Desc = 'Whether operation should be executed live in the editor (default = false).', Opt = true}},
            {transaction = {Desc = 'Whether merge should be performed as a transaction (default = true).', Opt = true}},         
            {merge_null = {Desc = 'Whether NULL values should be updated/inserted (default = true).', Opt = true}},                      
         },         
         Title = 'customMerge',
         Usage = "Conn:customMerge{data=&#60;value&#62; [, merge_null=&#60;value&#62;] [, ...]}",
         SeeAlso = {{Title = 'More on customMerge', Link = 'http://wiki.interfaceware.com/888.html'}},
         ParameterTable = true
      }
   }
end
