channelmanager.config = {}

local config = channelmanager.config

-- TODO we should make the sure code is robust with respect to passing in trailing / characters

config.approot = '/channelmanager'

if os.isWindows() then
   config.channelExportPath = 'D:\\community\\iguana-web-apps'
   config.scratchDir = 'C:\\temp\\channelmanager\\'
end
   
   
config.username = 'admin'
config.password = 'password'



config.actionTable = {
   ['config_info'] = channelmanager.backend.info,
   ['list-channels'] = channelmanager.backend.listChannels,
   ['export_channel'] = channelmanager.backend.export ,
   ['importList'] = channelmanager.backend.importList,
   ['replaceChannel']= channelmanager.backend.replaceChannel, 
   ['addChannel']= channelmanager.backend.addChannel 
}


config['Other Configuration'] = {
   key1 = 'val1',
   key2 = 'val2',
   key3 = 'val3',
}

return config