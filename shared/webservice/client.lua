-- This module connects to the web service, then assembles all the API functions as stubs on the fly from the help data.
local webservice = {}
webservice.client = {}

local function SetHelp(F, Name, Connect)
   local HelpData = net.http.post{url=Connect.url..'helpdata?call='..Name,  auth={username=Connect.username, password = Connect.password}, live=true}
   HelpData = json.parse{data=HelpData}
   if (HelpData.error) then
      return -- no help available.
   end
   help.set{input_function=F, help_data=HelpData} 
end

local function MarshallTransaction(T, Connect, path)
   local Url = Connect.url..path
   local R = net.http.post{url=Url,parameters=T, 
          auth={username=Connect.username, password=Connect.password}, 
          live=true}
   local R = json.parse{data=R}
   return R
end

local function AddFuncDef(T, Connect, path)
   for K,V in pairs(T) do
      trace(V)
      if type(V) == 'table' then 
         AddFuncDef(V, Connect, path..K..'/') 
      elseif V == 1 then
         T[K] = function(T) return unpack(MarshallTransaction(T, Connect, path..K)) end
         SetHelp(T[K], path..K, Connect)
      end
   end
end

function webservice.client.connect(T)
   local Client = {}
   local D = net.http.post{url=T.url..'helpsummary', 
                 auth={username=T.username, password = T.password},
                 live=true}
   if pcall(json.parse, D) then
      D =json.parse{data=D}
   else
      return D
   end
   AddFuncDef(D, T, "")
   return D
end

return webservice
