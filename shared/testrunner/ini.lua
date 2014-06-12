local ini = {}
-- ##########
-- Enter the username and password of a local Iguana admin
-- account. This account will be used for running the tests.
-- ##########
ini['account'] = {
   ['user'] = 'admin',
   ['pass'] = 'password'
}

-- ##########
-- Enter the channel GUID of the test suite channel here.
-- This is easily found in your IguanaConfig.xml or in the
-- expanded Web API (link to which is found on the Iguana
-- dashboard)
-- ##########
ini.testSuiteName = '2.Unit Test - Suite'
return ini