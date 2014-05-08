
require 'stringutil'

local BasicAuth = {}

local function getCreds(Headers)
   if not Headers.Authorization then
      return false
   end
   
   local Auth64Str = Headers.Authorization:sub(#"Basic " + 1)
   local Creds = filter.base64.dec(Auth64Str):split(":")
   return {username=Creds[1], password=Creds[2]}
end

function BasicAuth.isAuthorized(Request)
   local Credentials = getCreds(Request.headers)
   if not Credentials then
      return false
   end
   
   -- webInfo requires Iguana 5.6.4 or above
   local WebInfo = iguana.webInfo()
   local Status, Code = net.http.post{
      url=WebInfo.ip..":"..WebInfo.web_config.port.."/status",
      auth=Credentials,
      live=true}
   
   if Code == 200 then
      return true
   else
      return false
   end   
end

function BasicAuth.requireAuthorization()
   net.http.respond{
      code=401,
      headers={["WWW-Authenticate"]='Basic realm=Channel Manager'}, 
      body="Please Authenticate"}
end

function BasicAuth.getCredentials(HttpMsg)
   return getCreds(HttpMsg.headers)
end

return BasicAuth
