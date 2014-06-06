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

function highrise.company.get(Id)
   local Url = highrise.RiseUrl..'/companies/#'..Id..'.xml'
   local R,C,H=net.http.get{url=Url,live=true,
      auth=highrise.Auth}
   return R
end

function highrise.company.getPeople(Company)
   local Url = highrise.RiseUrl..'/companies/'..Company.company.id:text()..'/people.xml'
   local R,C,H=net.http.get{url=Url,live=true,
      auth=highrise.Auth}
   return xml.parse{data=R}   
end


function highrise.company.getByMemberId(Id)
   local Url = highrise.RiseUrl..'/companies/search.xml'
   local Param={['criteria[member_id]']=Id}
   local R,C,H=net.http.get{url=Url,live=true, parameters=Param,
      auth=highrise.Auth}
   return xml.parse{data=R}   
end

function highrise.company.getUpdated(Time)
   local TimeStamp = os.ts.date('!%Y%m%d%H%M', Time)
   local Url = highrise.RiseUrl..'/companies.xml?since='
      ..TimeStamp
   local R,C,H=net.http.get{url=Url,live=true,
      auth=highrise.Auth}
   return xml.parse{data=R}, os.ts.date("%c", Time)
end

function highrise.company.getAll()
   local Url = highrise.RiseUrl..'/companies.xml'
   local R,C,H=net.http.get{url=Url,live=true,
      auth=highrise.Auth}
   return xml.parse{data=R}
end

function highrise.company.update(C, Live)
   if Live == nil then Live = false end
   local B = C:S()
   local Id = C.company.id:text()
   local Url = highrise.RiseUrl..'/companies/'..Id..'.xml'
   net.http.put{url=Url,
         headers={['Content-Type']='application/xml'}, 
         data=B, live=Live, auth=highrise.Auth}
end


function highrise.company.redirect(Id)
   local Url = highrise.RiseUrl..'/companies/'..Id
   net.http.respond{headers={Refresh='0; url='..Url}, body=''}       
end

function highrise.company.returnIdWithMemberId(C, MemberId)
   for i=1, C:childCount('company') do
      local Sub = C:child('company', i).subject_datas
      for j=1, Sub:childCount('subject_data') do
         if Sub:child('subject_data',j).subject_field_label:text() == 'MemberId' then
           if Sub:child('subject_data',j).value:text() == MemberId then
               return C:child('company', i).id:text()
           end
         end
      end
   end
   return nil
end

function highrise.company.emailList(CompanyId)
   local Company = highrise.company.get(CompanyId)
   local People = highrise.company.getPeople(Company)
   local EmailList = {}
   for i=1, People.people:childCount('person') do
      highrise.contact.extractEmail(People.people:child('person',i)["contact-data"], EmailList)
   end
   return EmailList   
end

function highrise.company.memberId(Company)
   return highrise.contact.memberId(Company.company.subject_datas)
end

