-- The main function is the first function called from Iguana.
-- The Data argument will contain the message to be processed.
local webservice = require 'webservice.client'

function main(Data)
   local Highrise = webservice.client.connect{url='http://localhost:6544/webservice/', username='admin', password='password'}
   Result = Highrise.contact.add{firstname = "Hi", lastname = "Bye" , title = "Sir"}
   Highrise.contact.delete{ID=209113181}
   Highrise.company.add{name="hello",  background="A greetings company"}
   Highrise.company.delete{ID="12345"}
end