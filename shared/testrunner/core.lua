require 'stringutil'

testrunner = {}
testrunner.core = {}

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
function testrunner.core.overloadTranslator(TGuid)
   local Guid = tostring(TGuid)
   local Config = spin.Iggy:exportProject{guid = Guid}
   local ZipFile = filter.base64.dec(Config)
   local Tree = filter.zip.inflate(ZipFile)
   local Samples = json.parse{data = Tree[Guid]["samples.json"]}
   local SimpleTree = {
      ['main.lua'] = Tree[Guid]['main.lua'],
      shared = climbTree(Tree.shared),
      other =  climbTree(Tree.other)
   }
   trace(SimpleTree)
   testrunner.DataSet = json.parse(Tree[Guid]["samples.json"]).Samples
   trace(testrunner.DataSet)
   return SimpleTree, testrunner.DataSet
end

-- ##########
-- Start an iguanaServer instance followed by a spinner instance
-- return the spinner instance
-- ##########
function testrunner.core.initializeServer(Address, HttpPort, User, Password)
   local IguanaInstance = getIguana('http://' .. Address .. ':' .. HttpPort, User, Password)
   local TranslatorInstance = spin.getTranslator(spin.findASandbox(IguanaInstance), IguanaInstance)
   return TranslatorInstance
end