require 'jsonhelp'

local map = {}

-- Convert date from DD/MM/YYYY -> YYYY-MM-DD
local function ConvertDate(ADate)
   local Year = ADate:sub(-4)
   local Month = ADate:sub(1,2)
   local Day = ADate:sub(4,5)
   
   return Year..'-'..Month..'-'..Day
end

function map.Patient(T, P)
   T.PatientId = P.patientid
   T.FirstName = P.firstname
   T.LastName = P.lastname
   T.MiddleName = P.middlename
   T.Sex = P.sex
   T.Address1 = P.address1
   T.Dob = ConvertDate(P.dob)
   T.Zip = P.zip
   T.City = P.city
   T.DriversLicense = P.driverslicense:n()
   T.ContactMobilePhone = P.contactmobilephone:n()
   T.MiddleName = P.middlename
   T.ContactMobilePhone = P.contactmobilephone:n()
   T.EmployerPhone = P.employerphone:n()
   T.NextKinPhone = P.nextkinphone:n()
   T.Ssn = P.ssn:n()
   T.MobilePhone = P.mobilephone
end

return map