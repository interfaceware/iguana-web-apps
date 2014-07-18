require 'XMLUtil'
require 'CryptoUtil'

function main(Data)
   
   -- ########################
   -- 
   -- INSTRUCTIONS:
   --    Set the location of certificate & RSA keys in the empty strings below.
   --    These can be generated in the command line using the following command:
   --    openssl req -new -newkey rsa:1024 -days 365 -nodes -x509 -keyout private.key -out certificate.cert
   --
   --    This script will automatically generate and output your public key to the path you define
   --    in the publicKeyPath variable.
   --
   -- NOTE:
   --    If openssl isn't defined in your path you will need to set the location of your openssl binary
   --    in CryptoUtil -> _sOpenSSL_Path
   --
   -- ########################
   
   local privateKeyPath = ''   -- Example:  ~/.ssh/keys/private.key
   local certificatePath = ''  -- Example:  ~/.ssh/keys/certificate.cert
   local publicKeyPath = ''    -- Example:  ~/.ssh/keys/public.key
                               -- Note:     Your public key is automatically generated at the path above.

   xml.secure:setPrivateKey(privateKeyPath)
   xml.secure:setCertificate(certificatePath)
   filter.RSA:extractPublicKey(xml.secure.Keys.sCertificateFile,publicKeyPath) 
   xml.secure:setPublicKey(publicKeyPath)
   
   -- wrap Data in signed xml structure
   local sSecureXML = xml.secure:sign(Data)
   
   -- get the SKI fom the certificate
   xml.secure.sSKI = filter.RSA:getSKI(xml.secure.Keys.sCertificateFile)
   -- encrypt the signed xml and embed in excrypted xml structure
   local sEncryptedXML = xml.secure:encrypt(sSecureXML)
   
   Data = Data:gsub("\n+", "\r"):gsub("\r+", "\r") 
   local sSMDXML = xml.secure:SMDDeliver(sEncryptedXML, Data:split('\r')[1]:split('|')[12])
   
   return sSMDXML
end