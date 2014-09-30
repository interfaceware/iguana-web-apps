-- This module addeds a function called iguana.project.type()
-- which will return 'to', 'http', 'filter', 'to', 'from' depending on the type of translator.
-- It will figure this out once by caching the result of parsing the XML channel configuration.

local MyType = nil

local function GetTranslators(ChannelConfig)
   local Info = {}   
   local C = ChannelConfig.channel;
   if C.to_mapper then
      Info.to = C.to_mapper.guid:nodeValue()
   end
   if C.from_mapper then
      Info.from = C.from_mapper.guid:nodeValue()
   end
   if C.use_message_filter:nodeValue() == 'true' and C.message_filter and
      C.message_filter.use_translator_filter and
      C.message_filter.translator_guid then
      Info.filter = C.message_filter.translator_guid:nodeValue()
   end
   if C.from_llp_listener and C.from_llp_listener.ack_script then
      Info.ack = C.from_llp_listener.ack_script:nodeValue()
   end
   if C.from_http and C.from_http.guid then
      Info.http = C.from_http.guid:nodeValue()
   end   
   return Info
end

function iguana.project.type()
    if (MyType) then return MyType end
    local Config = iguana.channelConfig{guid=iguana.channelGuid()}
    Config = xml.parse{data=Config}
    local T = GetTranslators(Config)
    local MyGuid = iguana.project.guid()
    for K,V in pairs(T) do
      if V == MyGuid then
         MyType = K
         return K   
      end
    end   
end

