highrise.contact = {}

local defaults = {}
setmetatable(defaults, {__mode = "k"})
local mt = {__index = function (t) return defaults[t] end}
function setDefault (t, d)
   defaults[t] = d
   setmetatable(t, mt)
end

function node.text(X, V)
   if #X > 0 then
      return X[1]
   else
      X:append(xml.TEXT,V)
      return X
   end
end

local XMLcreate = 
[[
<person>
<first-name/>
<last-name/>
<title/>
<company-name/>
<background/>
<linkedin_url/>
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
</person>
]]

function highrise.contact.add(D)
   setDefault(D, "")
   local X = xml.parse{data=XMLcreate}
   X.person:child('first-name'):text(D.firstname)
   X.person:child('last-name'):text(D.lastname)
   X.person:child('title'):text(D.title)
   X.person:child('company-name'):text(D.companyname)
   X.person:child('background'):text(D.background)
   X.person:child('linkedin_url'):text(D.linkedinurl)
   X.person["contact-data"]["email-addresses"]["email-address"]:child('address'):text(D.address)
   X.person["contact-data"]["phone-numbers"]["phone-number"].number:text(D.number)
   local result = net.http.post{url='https://interfaceware2.highrisehq.com/people.xml', headers={['Content-type'] = 'application/xml'}, 
      auth={username='47ae105b9a78b02af4ee12e4aad576bc', password = 'X'}, live=true, body=tostring(X)}
   local Config = xml.parse{data=result}
   
   return {Config.person.id[2], result}
end

function highrise.contact.delete(D)
   local result = net.http.delete{url='https://interfaceware2.highrisehq.com/people/#' .. D.id .. '.xml'}
   return result
end
