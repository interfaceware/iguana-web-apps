regressions.config = {}

local config = regressions.config

config.approot = '/regression_tests'

-- NOTE: THIS DIRECTORY MUST ALREADY EXIST
config.WorkTank = os.fs.abspath("~") .. '/iguana_expected/'

config.actionTable = {
   ['channels'] = regressions.core.loadChannels,
   ['run_tests'] = regressions.core.runTests,
   ['build'] = regressions.core.build,
   ['edit_result'] = regressions.core.editResult
}

config.creds = {
   ['user'] = 'admin',
   ['pass'] = 'password'
}

config.ig = iguana.webInfo()

return config