
--[[

Send an immunization record to CAIR using SOAP 1.1

CAIR provides a PFX certificate. It must be converted to pem for Iguana to use it.
Run the following commands

    openssl pkcs12 -in mycert.pfx -out ca.pem -cacerts -nokeys
    openssl pkcs12 -in mycert.pfx -out client.pem -clcerts -nokeys 
    openssl pkcs12 -in mycert.pfx -out key.pem -nocerts

When you do the extraction, you must use the password provided by CAIR,
the one emailed separately from the certificate. However, when it asks,
you can give it any pem passphrase you want. 

CairPassword is your SOAP password which came with your sending facility ID. 
Keypass is whatever passphrase you gave when extracting the certificates.

--]]

require 'node'

Live = false

-- CAIR credentials
SendingFacility = "Your sending facility ID"
CairPassword = "Your SOAP password"

Cert    = [[C:\Path\to\client.pem]]
CAcert  = [[C:\Path\to\ca.pem]]
Key     = [[C:Path\to\key.pem]]
KeyPass = "The password you gave when extracting the pems"

XmlFragment=[==[
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:cdc:iisb:2011">
  <soap:Header/>
  <soap:Body>
    <urn:submitSingleMessage>
      <urn:username></urn:username>
      <urn:password></urn:password>
      <urn:facilityID>CAIR</urn:facilityID>
      <urn:hl7Message><![CDATA[]]></urn:hl7Message>
    </urn:submitSingleMessage>
  </soap:Body>
</soap:Envelope>
]==]

function main(Data)
   local Msg, Name = hl7.parse{vmd="cair/vxu.vmd", data=Data}
   local OutMsg = hl7.message{vmd="cair/vxu.vmd", name=Name}
   OutMsg:mapTree(Msg)

   -- These required fields are specific to a type 3 site
   OutMsg.MSH[4][1] = SendingFacility
   OutMsg.PD1[3][1][10] = SendingFacility
   OutMsg.RXA[11][4][1] = SendingFacility
   
   trace(OutMsg:S())
   
   local Xml = xml.parse{data=XmlFragment}

   local SingleMsg = Xml["soap:Envelope"]["soap:Body"]["urn:submitSingleMessage"]
   SingleMsg["urn:hl7Message"][1] = OutMsg:S()
   SingleMsg["urn:username"]:setInner(SendingFacility)
   SingleMsg["urn:password"]:setInner(CairPassword)
   
   trace(Xml:S())

   local Result, Code, Headers = net.http.post{
      url='https://igs.cdph.ca.gov/submit/services/client_Service.client_ServiceHttpsSoap11Endpoint',
      headers={
         ['Content-type']='text/xml', 
         SOAPAction="urn:cdc:iisb:2011:submitSingleMessage"},
      ssl = {
         cert=Cert,
         key_type="PEM",
         key=Key,
         key_pass=KeyPass,
         key_type="PEM",
         ca_file=CAcert,
         verify_peer=false},
      body=Xml:S(),
      live=Live}
end

