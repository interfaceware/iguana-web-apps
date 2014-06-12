highrise.company = {}

local defaults = {}
setmetatable(defaults, {__mode = "k"})
local mt = {__index = function (t) return defaults[t] end}
function setDefault (t, d)
   defaults[t] = d
   setmetatable(t, mt)
end

local XMLcreate = 
[[
<company>
<name/>
<background/>
<contact-data>
<email-addresses>
<email-address>
<address/>
</email-address>
</email-addresses>
<phone-numbers>
<phone-number>
<number/>
</phone-number>
</phone-numbers>
</contact-data>
</company>
]]

function highrise.company.add(D)
   setDefault(D, "")
   local X = xml.parse{data=XMLcreate}
   X.company:child('name'):text(D.name)
   X.company:child('background'):text(D.background)
   X.company["contact-data"]["email-addresses"]["email-address"]:child('address'):text(D.address)
   X.company["contact-data"]["phone-numbers"]["phone-number"].number:text(D.number)
   local result = net.http.post{url='https://interfaceware2.highrisehq.com/companies.xml', headers={['Content-type'] = 'application/xml'}, 
      auth={username='47ae105b9a78b02af4ee12e4aad576bc', password = 'X'}, live=true, body=tostring(X)}
   return result
end

function highrise.company.delete(D)
   local result = net.http.delete{url='https://interfaceware2.highrisehq.com/company/#' .. D.ID .. '.xml'}
   return result
end