require 'file'
require 'stringutil'
require 'node'
require 'iguanaServer'

testrunner = {}
testrunner.app = {}
testrunner.ini = require 'testrunner.ini'
testrunner.db = require 'testrunner.db'
testrunner.config = require 'testrunner.config'
testrunner.iggy = iguanaServer.connect{
   url = iguana.webInfo().ip .. ':' .. iguana.webInfo().web_config.port,
   username = testrunner.ini.account.user,
   password = testrunner.ini.account.pass
}
local Spin = require 'spin'

function testrunner.app.start()
   if not testrunner.app.checkSetup() then
      return {IsSetup = false}
   else
      return testrunner.app.generateTable()
   end
end

-- ##########
-- Pull the results from the database and generate a table
-- in DataTables' expected format. In this case the server names
-- are generated as the column headers and the test names as the
-- row headers.
-- ##########
function testrunner.app.generateTable()
   local Table = {aaData={}, aoColumns={{['sTitle'] = 'Test Name',   ['sType'] = 'string'}}}
   local Tests = {}
   local DB = testrunner.db.connect()
   local RSet = DB:execute{sql="SELECT name, results FROM hosts WHERE results <> '' AND results NOT NULL", live=true}
   if #RSet > 0 then
      for i=1,#RSet do
         if RSet[i].results:S() ~= nil and RSet[i].results:S() ~= '' then
            Tests = {}
            local TestResultArray = {}
            local SortedArray = hashtableToSortedArray(json.parse{data=RSet[i].results:S()})
            table.insert(Table.aoColumns, {['sTitle'] = RSet[i].name:S(), ['sType'] = 'html'})
            for x=1,#SortedArray do
               if SortedArray[x][2] then
                  table.insert(TestResultArray, '<div class="status-green"></div>')
               elseif SortedArray[x][2] == false then
                  table.insert(TestResultArray, '<div class="status-red"></div>')
               end
               table.insert(Tests, SortedArray[x][1])
            end
            table.insert(Table.aaData, TestResultArray)
         end
      end
      if #Table.aaData > 0 then
         Table.aaData = transpose(Table.aaData)
         for i=1,table.getn(Table.aaData) do
            table.insert(Table.aaData[i],1,Tests[i])
         end
      end
   end
   if Table.aaData == {} then
      Table.aaData = nil
   end
   return Table
end

-- ##########
-- If there are no hosts in the database then Test Runner hasn't been setup
-- ##########
function testrunner.app.checkSetup()
   local count = 0
   for k,v in pairs(testrunner.config.getHosts()) do
      if(v.results ~= 'NULL' and v.results ~= nil and v.results ~= '') then
         count = count + 1
      end
   end
   return count ~= 0 or false
end

-- ##########
-- Run the tests and update the database
-- ##########
function testrunner.app.runTest()
   local DB = testrunner.db.connect()
   local Hosts = testrunner.config.getHosts()
   local Spinner = spin.getSpinner(Hosts)
   local Results = {aaData={}, aoColumns={{['sTitle'] = 'Test Name',   ['sType'] = 'string'}}}
   local Tests = {}
   local SpinnerNodes = Spinner:getNodes()
   for NodeKey, Node in pairs(SpinnerNodes) do
      local DB = testrunner.db.connect()
      local Translator = Node:getTranslator()
      local TGuid = xml.parse{data=iguana.channelConfig{name=testrunner.ini.testSuiteName}}.channel.message_filter.translator_guid:S()
      local ZipTree, TestData = getTestSuite(TGuid)
      Translator:overload(ZipTree)
      local TestResultTable = Translator:run(TestData)
      local SerializedResults = json.serialize{data=TestResultTable['tests']}
      if TestResultTable['tests'] ~= nil and TestResultTable['tests'] ~= '' and next(TestResultTable['tests']) ~= nil then
         DB:execute{sql="UPDATE hosts SET results = '" .. SerializedResults .. "' WHERE host_id = " .. DB:quote(Hosts[NodeKey].host_id), live=true}
      end
   end
   return {true}
end

-- ##########
-- Taken from Bret's regressions.core
-- ##########
function climbTree(Node) 
   local Node = Node and Node or {}
   local NewNode = {}
   for Name, Val in pairs(Node) do 
      trace(Name)
      if type(Val) == 'table' then 
         NewNode[Name] = climbTree(Val)
      end
      if type(Val) == 'string' and not Name:find('::') then 
         NewNode[Name] = Val
      end
   end
   return NewNode
end

-- ##########
-- Modified from Bret's regressions.core to return the zip tree and dataset and not call the spinner overload
-- ##########
function getTestSuite(TGuid)
   local Guid = tostring(TGuid)
   local Config = testrunner.iggy:exportProject{guid = Guid}
   local ZipFile = filter.base64.dec(Config)
   local Tree = filter.zip.inflate(ZipFile)
   local Samples = json.parse{data = Tree[Guid]["samples.json"]}
   local SimpleTree = {
      ['main.lua'] = Tree[Guid]['main.lua'],
      shared = climbTree(Tree.shared),
      other =  climbTree(Tree.other)
   }
   local DataSet = json.parse(Tree[Guid]["samples.json"]).Samples
   return SimpleTree, DataSet
end

-- ##########
-- Matrix Transposition snippit grabbed from:
-- http://rosettacode.org/wiki/Matrix_transposition
-- ##########
function transpose(m)
   local res = {}
   for i = 1, #m[1] do
      res[i] = {}
      for j = 1, #m do
         res[i][j] = m[j][i]
      end
   end
   return res
end

-- ##########
-- Convert a Lua hash to a Lua array and sort
-- by what would have been the hash key
-- ##########
function hashtableToSortedArray(Hash)
   
   function compare(A,B) --Local compare function                         
      return A[1] < B[1]
   end
   local Array = {}
   for HashKey, HashValue in pairs(Hash) do
      table.insert(Array, {HashKey, HashValue})
   end
   table.sort(Array, compare)
   return Array
end

testrunner.actions = {
   ["start"] = testrunner.app.start,
   ["run"] = testrunner.app.runTest,
   ["list"] = testrunner.config.getHosts,
   ["delete"] = testrunner.config.deleteHost,
   ["save"] = testrunner.config.saveHosts
}