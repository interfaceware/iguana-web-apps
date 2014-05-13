local monitor = {}
monitor.agent = {}

local function MonitorUrl()
   local T = iguana.webInfo()
   local Url = 'http'
   if T.web_config.use_https then Url = Url..'s' end
   Url = Url..'://localhost:'.. T.https_channel_server.port..'/monitor/send'   
   return Url
end

-- You would edit this URL in a real agent to point to a central server.
local MONITOR_URL = MonitorUrl()

function monitor.agent.sendUpdate(Name)
   iguana.stopOnError(false)
   local Result
   local Info = {}
   Info.guid = iguana.channelGuid()
   Info.name = Name
   
   Info.status = iguana.status()
   MonitorUrl()
   net.http.post{url=MONITOR_URL, body=json.serialize{data=Info,compact=true}, live=true}
   return "Sent update"
end

return monitor.agent