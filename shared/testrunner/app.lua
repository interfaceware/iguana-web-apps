require 'file'
require 'stringutil'
require 'node'
require 'spin'
testrunner = {}
require 'testrunner.core'
testrunner.app = {}

function testrunner.app.runTest()
   local Result = {}
   
   -- ##########
   -- Define the guid of your test suite channel you want to execute on the remote server
   -- ##########
   local TestSuiteChannelGuid = 'E148692D008437C9240A8A7E17BF7CF6'
   
   -- ##########
   -- All servers listed will have the tests run against them.
   -- It's easy to add extra server info and print it out in the page.js javascript from this table.
   -- The corresponding table is passed (minus the password) with its results 
   -- ##########
   local TestServers = {
      {
         name = 'Localhost',
         os = 'Mac OSX 10.9 x64',
         info = '',
         address = '127.0.0.1',
         httpPort = '6543',
         httpsPort = '6544',
         user = 'admin',
         password = 'password'
      },
      {
         name = 'Ping',
         os = 'Windows Server 2008r2 x64',
         info = '',
         address = 'pp-rhel.ifware.net',
         httpPort = '6543',
         httpsPort = '6544',
         user = 'admin',
         password = ''
      },
      {
         name = 'Pong',
         os = 'Red Hat 6.4 x64',
         info = '',
         address = 'pp-win2008r2-x64.ifware.net',
         httpPort = '6543',
         httpsPort = '6544',
         user = 'admin',
         password = ''
      }
   }
   
   -- ##########
   -- Loop through the provided servers, create a spinner instance, send off and execute your test suite,
   -- append server info and test results to results table
   -- ##########
   for key, value in pairs(TestServers) do
      local Server = testrunner.core.initializeServer(value.address, value.httpPort, value.user, value.password)
      local TestSimpleTree, TestDataSet = testrunner.core.overloadTranslator(spin.Iggy:getChannelConfig{guid=TestSuiteChannelGuid}.channel.message_filter.translator_guid:S())
      Server:setUrl(value.address, value.httpsPort)
      local ServerOverload = Server:overload(TestSimpleTree)
      local TestResults = Server:run(TestDataSet)
      value.password = nil
      table.insert(TestResults, 1, value)
      table.insert(Result, TestResults)
   end
   
   return Result
end

testrunner.actions = {
   ["run"] = testrunner.app.runTest,
}