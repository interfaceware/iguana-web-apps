
require 'basicauth'

function main(Data)
   local HttpMsg = net.http.parseRequest{data=Data}
   
   if isAuthorized(HttpMsg) then
      net.http.respond{body='Welcome!'}
   else
      requireAuthorization()
   end
end
