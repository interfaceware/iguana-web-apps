
require 'stringutil'

local BasicAuth = {}

local function getCreds(AuthHeader)
   local Auth64Str = AuthHeader:sub(#"Basic " + 1)
   local Creds = filter.base64.dec(Auth64Str):split(":")
   return Creds[1], Creds[2]   
end

function BasicAuth.isAuthorized(Request)
   local AuthHeader = Request.headers.Authorization
   if not AuthHeader then
      return false
   end

   local Name, Pass = getCreds(AuthHeader)
   
   -- webInfo requires Iguana 5.6.4 or above
   local WebInfo = iguana.webInfo()
   local Status, Code = net.http.post{
      url=WebInfo.ip..":"..WebInfo.web_config.port.."/status",
      auth={password=Pass,username=Name},
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
      headers={["WWW-Authenticate"]='Basic realm=Protected'}, 
      body="Please Authenticate"}
end

return BasicAuth
