ba = require 'basicauth'

function main(Data)
   local HttpMsg = net.http.parseRequest{data=Data}
   
   if ba.isAuthorized(HttpMsg) then
      net.http.respond{body='Welcome!'}
   else
      ba.requireAuthorization()
   end
end
