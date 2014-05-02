
require 'stringutil'

local function getCreds(AuthHeader)
   local Auth64Str = AuthHeader:sub(#"Basic " + 1)
   local Creds = filter.base64.dec(Auth64Str):split(":")
   return Creds[1], Creds[2]   
end

function isAuthorized(Request)
   local AuthHeader = Request.headers.Authorization
   if not AuthHeader then
      return false
   end

   local Name, Pass = getCreds(AuthHeader)
   
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

function requireAuthorization()
   net.http.respond{
      code=401,
      headers={["WWW-Authenticate"]='Basic realm=localhost:6547/auth'}, 
      body="Please Authenticate"}
end