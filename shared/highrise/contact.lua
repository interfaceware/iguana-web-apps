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
   return result
end

function highrise.contact.delete(D)
   local result = net.http.delete{url='https://interfaceware2.highrisehq.com/people/#' .. D.ID .. '.xml'}
   return result
end

function highrise.contact.getUrls(C)
   local List = {}
   local A = C["web-addresses"]
   for i = 1, A:childCount('web-address') do
      List[i] = {}
      local Address = A:child("web-address", i)
      List[i].location = Address.location:text()
      List[i].id = Address.id:text()
      List[i].url = Address.url:text()
   end
   return List
end

function highrise.contact.removeUrl(List, Url, C)
   local EUrl = filter.html.enc(Url)
   for K,V in pairs(List) do
      debug(K)
      if List[K] and List[K].url == EUrl then 
         List[K].id = '-'..List[K].id 
         C.ChangeCount = C.ChangeCount + 1
      end
   end
   return List
end

function highrise.contact.hasPhone(ContactData, Number)
   local PhoneArray = ContactData["phone-numbers"]
   local StripNumber = Number:gsub("[^%d]", "")
   
   for i=1, PhoneArray:childCount("phone-number") do
      local Phone = PhoneArray:child("phone-number", i)
      if StripNumber == Phone.number:text():gsub("[^%d]", "") then
         return true
      end
   end 
   return false
end

function highrise.contact.addUrl(List, Url, C)
   local EUrl = filter.html.enc(Url)
   local Present = false
   for K,V in pairs(List) do
      if List[K].url == EUrl then
         Present = true   
      end
   end
   if not Present then
      C.ChangeCount = C.ChangeCount + 1
      List[table.maxn(List)+1] = {url=EUrl, location='Other'}      
   end
   return List
end

function highrise.contact.addAddress(Contact)
   local Node = Contact.addresses
   local C = Node:append(xml.ELEMENT, 'address')	 	 
   C:setInner([[	 	 
      <city>#</city>	 	 
	   <country>#</country>	 	 
	   <state>#</state>	 	 
	   <street>#</street>	 	 
	   <zip>#</zip>	 	 
	   <location>#</location>]])	 	 
   return C	 	 
end	 	 


function highrise.contact.extractEmail(Contact, List)
   if List == nil then List = {} end  
   local E = xml.findElement(Contact, 'email-addresses')
   if not E then error('Could not find email-addresses') end
   for i = 1, E:childCount('email-address') do
      List[#List+1] = E:child("email-address", i).address[1]:S()  
   end
   return List
end

function highrise.contact.memberId(SubjectData)
   if SubjectData == nil then return nil end
   for i =1 , SubjectData:childCount('subject_data') do
      local S = SubjectData:child('subject_data', i)
      if S.subject_field_label:text() == 'MemberId' then
         return S.value:text()
      end
   end
   return nil
end

function highrise.contact.ConvertUrlListToXml(List)
   local Out = ''
   for K,V in pairs(List) do
      Out = Out..'<web-address>'
      if List[K].id then 
         Out = Out..'<id type="integer">'..List[K].id..'</id>'
      end
      Out = Out..'<location>'..List[K].location..'</location>'
      Out = Out..'<url>'..List[K].url..'</url>'
      Out = Out..'</web-address>'
   end
   return Out
end

function highrise.contact.addPhone(Contact)	 	 
   local List = Contact["phone-numbers"]
   local C = List:append(xml.ELEMENT, 'email-address')	 	 
   C:setInner([[<location>#</location><number>#</number>]])
   return C	 	 
end

function highrise.contact.addPhoneIfNotPresent(Contact, Phone, PhoneType)
   if Phone:isNull() then return false end
   if not highrise.contact.hasPhone(Contact, Phone:S()) then
      
      local NewPhone = highrise.contact.addPhone(Contact)
      NewPhone.number[1] = Phone
      NewPhone.location[1] = PhoneType
      return true      
   end
   return false
end

function highrise.contact.setMemberId(Contact,MemberId) 
   local Tag = Contact["contact-data"]:append(xml.ELEMENT, 'member-id')
   Tag:setInner([[<subject-field-id type="integer">455042</subject-field-id>
      <value>]]..MemberId..[[</value>]])
   if Contact.subject_datas == nil then
      A = Contact:append(xml.ELEMENT, 'subject_datas'):append(xml.ATTRIBUTE, 'type')
      A:setInner('array') -- little bit confusing
   end
   local SubjectData = Contact.subject_datas:append(xml.ELEMENT, 'subject_data')
   SubjectData:setInner([[<subject_field_id type="integer">455042</subject_field_id>
 <subject_field_label>MemberId</subject_field_label>
      <value>]]..MemberId..[[</value>]])
   return Contact
end

function highrise.contact.addAddressIfNotPresent(Contact, R)
   if Contact.addresses:childCount('address') > 0 then
      return false
   end
   if not R.primary_address_country:isNull() then
      local A = highrise.contact.addAddress(Contact)
      A.country[1] = R.primary_address_country
      A.state[1] = R.primary_address_state
      A.zip[1] = R.primary_address_postalcode
      A.city[1] = R.primary_address_city
      A.street[1] = R.primary_address_street
      A.location[1] = 'Work'
      return true
   end
   return false
end

function highrise.contact.addEmail(Contact)	 	 
   local List = Contact["email-addresses"]
   local C = List:append(xml.ELEMENT, 'email-address')	 	 
   C:setInner([[	 	 
      <address>#</address>	 	 
      <location>#</location>]])	 
   return C	 	 
end

function highrise.contact.addEmailIfNotPresent(Contact, Email)
   local UpdateRequired = true
   local EmailLower = Email:lower()
   for i=1, Contact["email-addresses"]:childCount("email-address") do
      if Contact["email-addresses"]:child("email-address",i).address:text():lower() == EmailLower then
         UpdateRequired = false
      end
   end
   if UpdateRequired then
      local E = highrise.contact.addEmail(Contact) 
      E.address[1] = EmailLower
      E.location[1] = 'Work'
   end
   return UpdateRequired
end