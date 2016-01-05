-- Put appropriate quotes around table/column name
function dbs_quote_name(Name)
   if     string.find(Name,'"')==nil then return '"' .. Name .. '"'
   elseif string.find(Name,"'")==nil then return "'" .. Name .. "'"
   elseif string.find(Name,"`")==nil then return "`" .. Name .. "`"
   elseif string.find(Name,"]")==nil then return "[" .. Name .. "]"
   else return Name end
end

-- Check if table exists in DB
function dbs_exists_table(Connection, Name)
   local api = Connection:info().api
   if api == db.SQLITE then
      return 0 < #Connection:query{sql="SELECT 1 FROM sqlite_master WHERE type='table' and name=" .. dbs_quote_name(Name), live=true }
   end
   return false;
end

-- Automatically creates tables if they do not already exist based on dbs schema
-- SQLite implementation only
function dbs_create_tables(Connection, Schema) 
   if Connection==nil or Connection:info().live==false or Connection:info().api~=db.SQLITE  then return false end
   local Tables = Schema:getTableSet()
   for i=1,#Tables,1 do
      if dbs_exists_table(Connection,Tables[i]:nodeName())==false then
         local Keys = nil
         local Stmt = "create table " .. dbs_quote_name(Tables[i]:nodeName()) .. " ( " 
         local Columns = Tables[i][1]
         for j=1,#Columns,1 do
            local Column  = dbs_quote_name(Columns[j]:nodeName())
            local ColType = Columns[j]:nodeType()
            if j~=1 then Stmt = Stmt .. " , " end
            Stmt = Stmt .. Column
            if     ColType == 'string'   then Stmt = Stmt .. " VARCHAR(255)"
            elseif ColType == 'integer'  then Stmt = Stmt .. " INTEGER"
            elseif ColType == 'double'   then Stmt = Stmt .. " DOUBLE PRECISION"
            elseif ColType == 'datetime' then Stmt = Stmt .. " TIMESTAMP"
            else                              Stmt = Stmt .. " VARCHAR(255)" end
            if Columns[j]:isKey() then
               if Keys==nil then Keys = Column
               else              Keys = Keys .. " , " .. Column end
               Stmt = Stmt .. " NOT NULL"
            end
         end
         if Keys ~= nil then Stmt = Stmt .. " , PRIMARY KEY (" .. Keys .. ")" end
         Stmt = Stmt .. " )"
         Connection:execute{sql=Stmt, live=true}
      end
   end
   return true
end
