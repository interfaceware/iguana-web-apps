local webservice = {}
webservice.client = {}

local function SetHelp(F, Name, Connect)
   myhelp = net.http.post{url=Connect.url..'helpdata?call='..Name,  auth={username=Connect.username, password = Connect.password}, live=true}
   for key, value in pairs(json.parse{data=myhelp}) do
      myhelp = value
   end
   help.set{input_function=F, help_data=myhelp} 
end

local function MarshallTransaction(T, Connect, path)
   local Url = Connect.url..'callapi?call='..path
   local R = net.http.post{ url=Url, body=json.serialize{data=T},auth={username=Connect.username, password=Connect.password}, live=true}
   return R
end

local function AddFuncDef(T, Connect, path)
   for K,V in pairs(T) do
      trace(V)
      if type(V) == 'table' then 
         AddFuncDef(V, Connect, path..K..'.') 
      elseif V == 1 then
         T[K] = function(T) return MarshallTransaction(T, Connect, path..K) end
         SetHelp(T[K], path..K, Connect)
      end
   end
end

function webservice.client.connect(T)
   local Client = {}
   
   local D = net.http.post{url=T.url..'helpsummary', auth={username=T.username, password = T.password}, live=true}
   if pcall(json.parse, D) then
      D =json.parse{data=D}
   else
      return D
   end
      
   help.get(string.byte)
   AddFuncDef(D, T, "")
   return D
end

return webservice