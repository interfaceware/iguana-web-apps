--[[

Send an laboratory record to CalREDIE using SOAP 1.2

CalREDIE provides a PFX certificate. It must be converted to PEM for Iguana to use it.
With OpenSSL installed run the following commands:

    openssl pkcs12 -in mycert.pfx -out ca.pem -cacerts -nokeys
    openssl pkcs12 -in mycert.pfx -out client.pem -clcerts -nokeys 
    openssl pkcs12 -in mycert.pfx -out key.pem -nocerts

When you do the extraction, you must use the password provided by CalREDIE,
the one emailed separately from the certificate. However, when it asks,
you can give it any PEM passphrase you want. 

CalREDIE Password is your SOAP password which came with your sending facility ID. 
Keypass is whatever passphrase you gave when extracting the certificates.

--]]

require 'node'

Live = false

-- Credentials
SendingFacility = "Your sending facility ID"
CalREDIEPassword = "Your SOAP password"

Cert    = [[C:\Path\to\client.pem]]
CAcert  = [[C:\Path\to\ca.pem]]
Key     = [[C:\Path\to\key.pem]]
KeyPass = "The password you gave when extracting the PEMs"

XmlFragment=[==[
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:cdc:iisb:2011">
  <soap:Header/>
  <soap:Body>
    <urn:submitMessage>
      <urn:userid></urn:userid>
      <urn:password></urn:password>
      <urn:dataownerid></urn:dataownerid>
      <urn:cdphprogramid>1</urn:cdphprogramid>
      <urn:cdphprogramenvironment>T</urn:cdphprogramenvironment>
      <urn:action>SEND</urn:action>
      <urn:messagecontent>
         <![CDATA[]]>
      </urn:messagecontent>
    </urn:submitMessage>
  </soap:Body>
</soap:Envelope>
]==]

function main(Data)
   local Msg, Name = hl7.parse{vmd="HL7_2.5.1.vmd", data=Data}
   local OutMsg = hl7.message{vmd="HL7_2.5.1.vmd", name=Name}
   OutMsg:mapTree(Msg)
   
   trace(OutMsg:S())
   
   local Xml = xml.parse{data=XmlFragment}
   local SingleMsg = Xml["soap:Envelope"]["soap:Body"]["urn:submitMessage"]
   trace(SingleMsg)
   SingleMsg["urn:messagecontent"][1] = OutMsg:S()
   SingleMsg["urn:userid"]:setInner(SendingFacility)
   SingleMsg["urn:password"]:setInner(CalREDIEPassword)
   SingleMsg["urn:dataownerid"]:setInner(SendingFacility)
   
   trace(Xml:S())

   local Result, Code, Headers = net.http.post{
      url='https://hiegateway.cdph.ca.gov/submit/services/CDPH_transfer.CDPH_transferHttpsSoap12Endpoint',
      headers={
         ['Content-type']='text/xml', 
         SOAPAction="urn:cdc:iisb:2011:submitMessage"},
      ssl = {
         cert=Cert,
         key_type="PEM",
         key=Key,
         key_pass=KeyPass,
         ca_file=CAcert,
         verify_peer=false},
      body=Xml:S(),
      live=Live}
end

