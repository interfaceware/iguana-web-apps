local config = {}

config.approot = '/channelmanager'
config.channelExportPath = os.fs.abspath("~") .. '/build/lua_apps'

config.actions = {
   ['/list-channels'] = 'listChannels',
   ['/export-summary'] = 'exportSummary',
   ['/export-channel'] = 'exportChannel',
   ['/import-summary'] = 'importSummary',
   ['/import-channel'] = 'importChannel',
}

config['Other Configuration'] = {
   key1 = 'val1',
   key2 = 'val2',
   key3 = 'val3',
}

return config