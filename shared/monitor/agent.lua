selfmon = {}
-- derp
function selfmon.sendUpdate(Name)
   iguana.stopOnError(false)
   local Result
   local Info = {}
   Info.guid = iguana.channelGuid()
   Info.name = Name
   Info.summary, Info.retcode = net.http.post{url="http://localhost:6543/monitor_query", 
      auth={username="admin", password="password"},parameters={Compact='T'}, live=true}
   net.http.post{url='http://localhost:6544/monitor/send', body=json.serialize{data=Info,compact=true}, live=true}
   return "Sent update"
end

return selfmon