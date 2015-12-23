-- Store module used with Athena adapter
-- Copyright (c) 2011-2012 iNTERFACEWARE Inc. ALL RIGHTS RESERVED
-- iNTERFACEWARE permits you to use, modify, and distribute this file in accordance
-- with the terms of the iNTERFACEWARE license agreement accompanying the software
-- in which it is used.
--
-- http://help.interfaceware.com/code/details/store-lua
 
local store = {}
 
-- Constants.
local STORE_NAME = "athena.db"
local DROP_TABLE_COMMAND = "DROP TABLE IF EXISTS store"
local CREATE_TABLE_COMMAND = [[
CREATE TABLE store
(
CKey Text(255) NOT NULL PRIMARY KEY,
CValue Text(255) 
)
]]
 
-- Functions.
 
-- use to create connection object when needed
local function connCreate()
   return db.connect{api=db.SQLITE, name=STORE_NAME}
end
 
-- This function returns the state of the store table by performing a general select
-- query on it.
function store.getTableState()
   local conn = connCreate()
   local R = conn:query ("SELECT * FROM store")
   conn:close()
   return R
end
 
-- This function resets the state of the store table by first deleting it and then
-- recreating it.
function store.resetTableState()
   -- This operation is performed as a database transaction to prevent another
   -- Translator script from accidentally attempting to access the store table
   -- while it has been temporarily deleted.
   local conn = connCreate()
   conn:begin()
   conn:execute{sql=DROP_TABLE_COMMAND, live=true}
   conn:execute{sql=CREATE_TABLE_COMMAND, live=true}
   conn:commit()
   conn:close()
end
   
function store.put(Key, Value)
   local conn = connCreate()
   local R = conn:query('REPLACE INTO store(CKey, CValue) VALUES(' .. conn:quote(tostring(Key)) .. ',' .. conn:quote(tostring(Value)) .. ')')
   conn:close()
end
 
function store.get(Key)
   local conn = connCreate()
   local R = conn:query('SELECT CValue from store WHERE CKey = ' .. conn:quote(tostring(Key)))
   conn:close()
   
   if #R == 0 then
      return nil
   end
   
   return R[1].CValue:nodeValue()
end
 
-- Local Functions
 
-- INITITALIZE DB: This automatically ensures the SQLlite database exists and has the store table present at script compile time.   
local function init()
   local conn = connCreate()
   local R = conn:query('SELECT * from sqlite_master WHERE type="table" and tbl_name="store"')
   conn:close()
   
   trace(#R)
   if #R == 0 then
      store.resetTableState()
   end
end
init() -- DO NOT REMOVE: Calls init() (once only) at script compile time to perform the initialization
 
-- help for the functions
 
if help then
   ------------------------
   -- store.getTableState()
   ------------------------
   local h = help.example()
   h.Title = 'store.getTableState'
   h.Desc = 'Return the state of the store table, by selecting all the rows.'
   h.Usage = 'store.getTableState()'
   h.Parameters = ''
   h.Returns = {[1]={['Desc']='All the rows from the store table <u>result set node tree</u>'}}
   h.ParameterTable = false
   h.Examples = {[1]=[[<pre>
      -- check the state of the store table, if more than 1 row then empty the store
      if  #store.getTableState() > 1 then
         store.resetTableState()
      end
      </pre>]]}
   h.SeeAlso = ''
   help.set{input_function=store.getTableState, help_data=h}
 
   --------------------------
   -- store.resetTableState()
   --------------------------
   local h = help.example()
   h.Title = 'store.resetTableState'
   h.Desc = 'Reset the state of the store table, by deleting and recreating the table.'
   h.Usage = 'store.resetTableState()'
   h.Parameters = ''
   h.Returns = 'none.'
   h.ParameterTable = false
   h.Examples = {[1]=[[<pre>
      -- reset the store table if more than 1 row exists
      if  #store.getTableState() > 1 then
         store.resetTableState()
      end
      </pre>]]}
   h.SeeAlso = ''
   help.set{input_function=store.resetTableState, help_data=h}
 
   ------------------------
   -- store.put()
   ------------------------
   local h = help.example()
   h.Title = 'store.put'
   h.Desc = [[Insert a Value for the Key. If the Key exists then replace the value. 
              If the Key does not exist insert a new Key and Value.]]
   h.Usage = 'store.put(Key, Value)'
   h.Parameters = {
      [1]={['Key']={['Desc']='Unique Identifier <u>string</u>'}},
      [2]={['Value']={['Desc']='Value to store <u>string</u>'}}
   }
   h.Returns = 'none.'
   h.ParameterTable = false
   h.Examples = {[1]=[[<pre>store.put('I am the Key', 'I am the Value')</pre>]]}
   h.SeeAlso = ''
   help.set{input_function=store.put, help_data=h}
 
   ------------------------
   -- store.get()
   ------------------------
   local h = help.example()
   h.Title = 'store.get'
   h.Desc = 'Retrieve the Value for the specified Key.'
   h.Usage = 'store.get(Key)'
   h.Parameters = {
      [1]={['Key']={['Desc']='Unique Identifier <u>string</u>'}}
   }
   h.Returns = {[1]={['Desc']='The Value of the row specified by the Key <u>string</u>'}}
   h.ParameterTable = false
   h.Examples = {[1]=[[<pre>store.get('I am the Key')</pre>]]}
   h.SeeAlso = ''
   help.set{input_function=store.get, help_data=h}
end
 
return store