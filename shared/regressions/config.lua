local config = {}

-- NOTE: THIS DIRECTORY MUST ALREADY EXIST
config.WorkTank = os.fs.abspath("~") .. '/iguana_expected/'

config.hosts = {
   ['local'] = {
      ['user'] = 'admin',
      ['pass'] = 'password',
      ['http_port'] = '6544'
   },
--[[
      ['fake_remote_host1'] = {
      ['host'] = '192.168.3.178',
      ['port'] = '6543',
      ['user'] = 'admin',
      ['pass'] = 'password',
      ['https'] = true,
      ['http_port'] = '6544'
   },
      ['fake_remote_host2'] = {
      ['host'] = '192.168.3.179',
      ['port'] = '6543',
      ['user'] = 'admin',
      ['pass'] = 'password',
      ['https'] = true,
      ['http_port'] = '6544'
   }
]]--
}
return config