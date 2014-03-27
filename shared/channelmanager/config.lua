channelmanager.config = {}

local config = channelmanager.config

-- TODO we should make the sure code is robust with respect to passing in trailing / characters

config.approot = '/channelmanager'
config.channelExportPath = os.fs.abspath("~") .. '/build/lua_apps'
config.scratchDir = os.fs.abspath("~")..'/temp'

config.actionTable = {
   ['config_info'] = channelmanager.backend.info,
   ['list-channels'] = channelmanager.backend.listChannels,
   ['export_channel'] = channelmanager.backend.export ,
   ['importList'] = channelmanager.backend.importList,
   ['replaceChannel']= channelmanager.backend.replaceChannel 
}


config['Other Configuration'] = {
   key1 = 'val1',
   key2 = 'val2',
   key3 = 'val3',
}

return config