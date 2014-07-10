local basicauth = require 'basicauth'
if not cm then cm = {} end
if not cm.update then cm.update = {} end

function cm.update.list()
   local Config = cm.app.config();
end

local function RetrieveLib(LibTree)
   
end

function cm.update.spin(Self, R)
   local Files = RetrieveLib({['shared'] = {['iguana'] = {['channel'] = true},
                              ['iguanaServer'] = true,
                              ['lib'] = {['webserver'] = true},
                              ['file'] = true}})
   local GUID = iguana.channelGuid()
   local Credentials = basicauth.getCredentials(Self)
   local Host = {['local'] = {}}
   Host['local']['host'] = iguana.webInfo().ip
   Host['local']['port'] = iguana.webInfo().web_config.port
   Host['local']['https'] = iguana.webInfo().web_config.use_https
   Host['local']['user'] = Credentials.username
   Host['local']['pass'] = Credentials.password
   local Spinner = spin.getSpinner(Host)
   local SpinnerNode = Spinner:getNodes()
   
end