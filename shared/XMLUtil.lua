require 'node'

-- create xml.secure object as container
xml.secure = {}
xml.secure.Keys = {}
xml.secure.Template = {}
xml.secure.SMD = {}

-- set parameters
-- key files
xml.secure.Keys.sPrivateKeyFile = ''
xml.secure.Keys.sPublicKeyFile = ''
xml.secure.Keys.sCertificateFile = ''
xml.secure.sSKI = ''

xml.secure.SMD.sTo = ''
xml.secure.SMD.sFrom = ''
xml.secure.SMD.sReceiverOrg = ''
xml.secure.SMD.sSenderOrg = ''
xml.secure.SMD.sResponseURL = 'http://iguana.myurl.com/smd/response'

-- xml templates
xml.secure.Template.sSignedXML = [[
<sp:signedPayload xmlns:sp="http://ns.electronichealth.net.au/xsp/xsd/SignedPayload/2010">
	<sp:signatures>
		<ds:Signature xmlns:ds="http://www.w3.org/2000/09/xmldsig#">
			<ds:SignedInfo>
				<ds:CanonicalizationMethod Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#" />
				<ds:SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1" />
				<ds:Reference URI="#">
					<ds:Transforms>
						<ds:Transform Algorithm="http://www.w3.org/2001/10/xml-exc-c14n#" />
					</ds:Transforms>
					<ds:DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1" />
					<ds:DigestValue></ds:DigestValue>
				</ds:Reference>
			</ds:SignedInfo>
			<ds:SignatureValue></ds:SignatureValue>
			<ds:KeyInfo>
				<ds:X509Data>
					<ds:X509Certificate></ds:X509Certificate>
				</ds:X509Data>
			</ds:KeyInfo>
		</ds:Signature>
	</sp:signatures>
	<sp:signedPayloadData id="">
		<sp:data/>
	</sp:signedPayloadData>
</sp:signedPayload>
]]

xml.secure.Template.sEncryptedXML = [[
<ep:encryptedPayload xmlns:ep="http://ns.electronichealth.net.au/xsp/xsd/EncryptedPayload/2010">
	<ep:keys>
		<xenc:EncryptedKey xmlns:xenc="http://www.w3.org/2001/04/xmlenc#" Id="">
			<xenc:EncryptionMethod Algorithm="http://www.w3.org/2001/04/xmlenc#rsa-1_5" />
			<ds:KeyInfo xmlns:ds="http://www.w3.org/2000/09/xmldsig#">
				<ds:X509Data>
					<ds:X509SKI></ds:X509SKI>
				</ds:X509Data>
			</ds:KeyInfo>
			<xenc:CipherData>
				<xenc:CipherValue/>
			</xenc:CipherData>
			<xenc:ReferenceList>
				<xenc:DataReference URI="" />
			</xenc:ReferenceList>
		</xenc:EncryptedKey>
	</ep:keys>
	<ep:encryptedPayloadData>
		<xenc:EncryptedData xmlns:xenc="http://www.w3.org/2001/04/xmlenc#" Id="" Type="http://www.w3.org/2001/04/xmlenc#Element">
			<xenc:EncryptionMethod Algorithm="http://www.w3.org/2001/04/xmlenc#aes128-cbc" />
			<xenc:CipherData>
				<xenc:CipherValue/>
			</xenc:CipherData>
		</xenc:EncryptedData>
	</ep:encryptedPayloadData>
</ep:encryptedPayload>
]]

xml.secure.Template.sSMD = [[
<S:Envelope xmlns:S="http://www.w3.org/2003/05/soap-envelope">
	<S:Header>
		<To xmlns="http://www.w3.org/2005/08/addressing"></To>
		<Action xmlns="http://www.w3.org/2005/08/addressing">http://ns.electronichealth.net.au/smd/svc/SealedMessageDelivery/2010/SealedMessageDelivery/deliverRequest</Action>
		<MessageID xmlns="http://www.w3.org/2005/08/addressing">urn:uuid:</MessageID>
		<wsa:From xmlns:wsa="http://www.w3.org/2005/08/addressing">
			<wsa:Address></wsa:Address>
		</wsa:From>
	</S:Header>
	<S:Body>
		<ns8:deliver
				xmlns:ns8="http://ns.electronichealth.net.au/smd/svc/SealedMessageDelivery/2010"
				xmlns:ns3="http://ns.electronichealth.net.au/smd/xsd/SealedMessage/2010"
				xmlns:ns7="http://ns.electronichealth.net.au/els/xsd/DataTypes/2010">
			<ns8:message>
				<ns3:metadata>
					<ns3:creationTime></ns3:creationTime>
					<ns3:expiryTime></ns3:expiryTime>
					<ns3:invocationId>urn:uuid:</ns3:invocationId>
					<ns3:receiverOrganisation></ns3:receiverOrganisation>
					<ns3:senderOrganisation></ns3:senderOrganisation>
					<ns3:serviceCategory></ns3:serviceCategory>
					<ns3:serviceInterface>http://ns.electronichealth.net.au/smd/intf/SealedMessageDelivery/TLS/2010</ns3:serviceInterface>
					<ns3:routeRecord>
						<ns3:sendIntermediateResponses>true</ns3:sendIntermediateResponses>
						<ns3:interaction>
							<ns7:target></ns7:target>
							<ns7:serviceCategory></ns7:serviceCategory>
							<ns7:serviceInterface>http://ns.electronichealth.net.au/smd/intf/TransportResponseDelivery/TLS/2010</ns7:serviceInterface>
							<ns7:serviceEndpoint></ns7:serviceEndpoint>
							<ns7:serviceProvider></ns7:serviceProvider>
						</ns3:interaction>
					</ns3:routeRecord>
				</ns3:metadata>
			</ns8:message>
		</ns8:deliver>
	</S:Body>
</S:Envelope>
]]

function xml.secure:sign(_sPayload)
   -- insert a parload into a signed xml steructure and sign it
   
   -- get template
   local _xmlSigned = xml.parse{data = xml.secure.Template.sSignedXML}
   
   -- add payload
   _xmlSigned["sp:signedPayload"]["sp:signedPayloadData"]["sp:data"]:setInner(_sPayload:xmlCharRef())
   -- set id
   _sID = util.guid(128)
   _xmlSigned["sp:signedPayload"]["sp:signedPayloadData"].id = _sID
   _xmlSigned["sp:signedPayload"]["sp:signatures"]["ds:Signature"]["ds:SignedInfo"]["ds:Reference"].URI = '#' .. _sID
   
   -- hash the payload
   -- canonicalize it first
   local _sHash = util:sha1(_xmlSigned["sp:signedPayload"]["sp:signedPayloadData"]:xmlCanonicalize(_xmlSigned):xmlCrRef())
   _xmlSigned["sp:signedPayload"]["sp:signatures"]["ds:Signature"]["ds:SignedInfo"]["ds:Reference"]["ds:DigestValue"]:setInner(_sHash)
   
   -- hash the signed info that includes the hash of the payload
   _sHash = util:sha1(_xmlSigned["sp:signedPayload"]["sp:signatures"]["ds:Signature"]["ds:SignedInfo"]:xmlCanonicalize(_xmlSigned))
   -- sign the hash with the private key
   local _sSignature = filter.RSA:sign(_sHash, xml.secure.Keys.sPrivateKeyFile)
   _xmlSigned["sp:signedPayload"]["sp:signatures"]["ds:Signature"]["ds:SignatureValue"]:setInner(_sSignature)
   
   -- include the public key to verify the signature
   _xmlSigned["sp:signedPayload"]["sp:signatures"]["ds:Signature"]["ds:KeyInfo"]["ds:X509Data"]["ds:X509Certificate"]:setInner(filter.RSA:getPublicKey(xml.secure.Keys.sPublicKeyFile))
   
   -- return the signed xml
   return _xmlSigned:S()    
end

function node:getAncestors(_target)
   -- get list of ancestor nodes starting with top node
   if not _target or self == _target then
      -- no ancestors
      return {}
   else
      -- look for target in children
      for _n = 1, self:childCount() do
         if self[_n] == _target then
            --traget found
            return {self}
         else
            _t = self[_n]:getAncestors(_target)
            -- target found so add self to list
            if _t then
               table.insert(_t, 1, self)
               return _t
            end
         end
      end
   end  
end

function node:xmlCanonicalize(_top)
   if self:nodeType() == 'element' then
      if not _top then
         _top = self
      end
      
      -- store original xml
      local _sOriginal = _top:S()
      
      --insert parent or ancestor namespace if not present
      local _prefix = self:nodeName():sub(0, self:nodeName():find(':')-1)
      if (_prefix == '' and not self['xmlns']) or (_prefix ~= '' and not self['xmlns:' .. _prefix]) then 
         -- return list of ancestors
         local _a = _top:getAncestors(self)
         local _xmlns = ''
         --look for namespace
         for _n = 1, #_a do
            if _prefix == '' and _a[_n].xmlns then
               _xmlns = _a[_n].xmlns:nodeValue()
            elseif _a[_n]['xmlns:' .. _prefix] then
               _xmlns = _a[_n]['xmlns:' .. _prefix]:nodeValue()
            end
         end
         
         --set namespace
         if _prefix == '' and _xmlns ~= '' then
            self:append(xml.ATTRIBUTE, 'xmlns:')
            self['xmlns:'] = _xmlns               
         elseif _xmlns ~= '' then
            self:append(xml.ATTRIBUTE, 'xmlns:' .. _prefix)
            self['xmlns:' .. _prefix] = _xmlns
         end
      end
      
      -- sort attributes, remove redundant namespaces
      -- convert cdata, convert CR to LF
      self:xmlCanonicalizeChildren()
      
      -- preserve inside white space from original message so extract from _top string
      -- assumes unique node name
      local _s = _top:S()
      _s = _s:sub(_s:find('<' .. self:nodeName())-1, _s:find('</' .. self:nodeName()) + #self:nodeName() + 2)
      
      -- reset to original
      _top:setInner(_sOriginal)
      
      -- return canonicalized xml string
      return _s
   end
end

function node:xmlCanonicalizeChildren(_p)
   local _a = {}
   local _ns = {}
   
   -- sort attributes, remove redundant namespaces
   -- convert cdata, convert CR to LF
   for _i=self:childCount(), 1, -1 do
      _n = self[_i]
      if _n:nodeType() == 'element'then
         _n:xmlCanonicalizeChildren(self)
      elseif _n:nodeType() == 'attribute'  and not _n:nodeName():find('xmlns') then
         -- list attributes for sorting
         table.insert(_a, _n:nodeName())
      elseif _n:nodeType() == 'attribute'  and _n:nodeName():find('xmlns')
         and (_n:nodeValue() == '' or (_p and _p[_n:nodeName()] and _p[_n:nodeName()]:nodeValue() == _n:nodeValue())) then           
         -- remove redundant or empty namespaces
         self:remove(_i)            
         table.insert(_a, _n:nodeName())
      elseif _n:nodeType() == 'attribute'  and _n:nodeName():find('xmlns') then
         -- list namespaces for sorting
         table.insert(_ns, _n:nodeName())
      elseif _n:nodeType() == 'text' then
         -- replace CR
         _s = tostring(_n):xmlCrRef()
         self:setInner(_s)
      elseif _n:nodeType() == 'cdata' then
         -- convert cdata
         _s = _n:nodeValue():xmlCharRef()
         self:remove(_i)
         self:setInner(_s)
      end
   end
   
   -- sort namespace attributes
   table.sort(_ns)
   -- remove attributes and re-add in sorted order
   for _i,_k in ipairs(_ns) do
      _v = self[_k]:nodeValue()
      self:remove(_k)
      self:append(xml.ATTRIBUTE, _k)
      self[_k] = _v
   end

   -- sort other attributes
   table.sort(_a)
   -- remove attributes and re-add in sorted order
   for _i,_k in ipairs(_a) do
      _v = self[_k]:nodeValue()
      self:remove(_k)
      self:append(xml.ATTRIBUTE, _k)
      self[_k] = _v
   end   
end

function string:xmlCharRef()
   --convert reserved characters
   local _s = self
   _s = _s:gsub('&', '&amp;')
   _s = _s:gsub('>', '&gt;')
   _s = _s:gsub('<', '&lt;')
   _s = _s:gsub('%%', '&#37;')
   _s = _s:gsub("'", '&apos;')
   _s = _s:gsub('"', '&quot;')
   return _s
end

function string:xmlCrRef()
   -- replace CR with LF
   local _s = self
   _s = _s:gsub('\r', '\n')
   return _s
end


function xml.secure:encrypt(_sPayload)
   -- encrypt the payload (signed xml)
   -- insert encrypted data into encrypted xml structure
   
   -- get emcrypted xml structure
   local _xmlEncrypted = xml.parse{data = xml.secure.Template.sEncryptedXML}
   
   -- set random 128 bit aes key
   local _sKey = util.guid(128)
   --  symetrical encrypt with key (aes128-cbc)
   local _sEnc = filter.base64.enc(filter.aes.enc{data=_sPayload,key=_sKey})
   _xmlEncrypted["ep:encryptedPayload"]["ep:encryptedPayloadData"]["xenc:EncryptedData"]["xenc:CipherData"]["xenc:CipherValue"]:setInner(_sEnc)
   
   -- set id
   _sID = util.guid(128)
   _xmlEncrypted["ep:encryptedPayload"]["ep:encryptedPayloadData"]["xenc:EncryptedData"].Id = _sID
   _xmlEncrypted["ep:encryptedPayload"]["ep:keys"]["xenc:EncryptedKey"].Id = util.guid(128)
   _xmlEncrypted["ep:encryptedPayload"]["ep:keys"]["xenc:EncryptedKey"]["xenc:ReferenceList"]["xenc:DataReference"].URI = '#' .. _sID
   
   -- set SKI
   _xmlEncrypted["ep:encryptedPayload"]["ep:keys"]["xenc:EncryptedKey"]["ds:KeyInfo"]["ds:X509Data"]["ds:X509SKI"]:setInner(xml.secure.sSKI)
   -- encrypt aes key with private key 
   _xmlEncrypted["ep:encryptedPayload"]["ep:keys"]["xenc:EncryptedKey"]["xenc:CipherData"]["xenc:CipherValue"]:setInner(filter.RSA:encrypt(_sKey, xml.secure.Keys.sPublicKeyFile))
   
   -- return encrypted xml structure
   return _xmlEncrypted:S()
end

function xml.secure:setPrivateKey(_sPath)
   -- set the private key file
   if os.fs.access(os.fs.abspath(_sPath)) then
      xml.secure.Keys.sPrivateKeyFile = os.fs.abspath(_sPath)
      return true
   end
   error('Key file not found', 2)
end

function xml.secure:setPublicKey(_sPath)
   -- set the public key file
   if os.fs.access(os.fs.abspath(_sPath)) then
      xml.secure.Keys.sPublicKeyFile = os.fs.abspath(_sPath)
      return true
   end
   error('Key file not found', 2)
end

function xml.secure:setCertificate(_sPath)
   -- set the certificate file
   if os.fs.access(os.fs.abspath(_sPath)) then
      xml.secure.Keys.sCertificateFile = os.fs.abspath(_sPath)
      return true
   end
   error('Key file not found', 2)
end

function xml.secure:uuid()
   -- return guid in 8-4-4-12 form
   local _s = util.guid(128)
   _s = _s:sub(0,8) .. '-' .. _s:sub(9, 12) .. '-' .. _s:sub(13, 16) 
   .. '-' .. _s:sub(17, 20) .. '-' .. _s:sub(21) 
   return _s:lower()
end

function xml.secure.Now(_nOffset, _sTZ)
   -- get time in yyyy-mm-ddThh:mm:ss+tz format (ISO 8601)
   
   -- set timezone
   local _sDefaultZone = '00:00'
   if not _sTZ then
      _sTZ = _sDefaultZone
   end

   local _t = os.ts.time()

   -- add offset from system time
   if _nOffset then
      _t = _t + _nOffset
   end
   return os.ts.date('%Y-%m-%dT%H:%M:%S+' .. _sTZ, _t)
   
end

function xml.secure:SMDDeliver(_sPayload, _sType)
   
   local _xmlSMD = xml.parse{data=xml.secure.Template.sSMD:gsub('</ns8:message>', _sPayload .. '</ns8:message>')}
   
   _xmlSMD["S:Envelope"]["S:Header"].To:setInner(xml.secure.SMD.sTo)
   _xmlSMD["S:Envelope"]["S:Header"]["wsa:From"]["wsa:Address"]:setInner(xml.secure.SMD.sFrom)
   _xmlSMD["S:Envelope"]["S:Header"].MessageID[2] = 'urn:uuid:' .. xml.secure.uuid()
   _xmlSMD["S:Envelope"]["S:Body"]["ns8:deliver"]["ns8:message"]["ns3:metadata"]["ns3:creationTime"]:setInner(xml.secure.Now(0, '10:00'))
   _xmlSMD["S:Envelope"]["S:Body"]["ns8:deliver"]["ns8:message"]["ns3:metadata"]["ns3:expiryTime"]:setInner(xml.secure.Now(3600, '10:00'))
   _xmlSMD["S:Envelope"]["S:Body"]["ns8:deliver"]["ns8:message"]["ns3:metadata"]["ns3:invocationId"][1] = 'urn:uuid:' .. xml.secure:uuid()       
   _xmlSMD["S:Envelope"]["S:Body"]["ns8:deliver"]["ns8:message"]["ns3:metadata"]["ns3:receiverOrganisation"]:setInner(xml.secure.SMD.sReceiverOrg)
   _xmlSMD["S:Envelope"]["S:Body"]["ns8:deliver"]["ns8:message"]["ns3:metadata"]["ns3:senderOrganisation"]:setInner(xml.secure.SMD.sSenderOrg)
   
   local _sServiceCategory = ''
   if _sType == '2.3.1' then
      _sServiceCategory = 'http://ns.ahml.com.au/smd/sc/smd/hl7v2.3.1'      
   elseif _sType == '2.4' then
      _sServiceCategory = 'http://ns.electronichealth.net.au/eReferrals/Sc/Referral/HL724/1.0'
   elseif _sType == '2.5' then
      _sServiceCategory = 'http://ns.electronichealth.net.au/eReferrals/Sc/Referral/HL725/1.0'   
   end
   _xmlSMD["S:Envelope"]["S:Body"]["ns8:deliver"]["ns8:message"]["ns3:metadata"]["ns3:serviceCategory"]:setInner(_sServiceCategory)
   
   _xmlSMD["S:Envelope"]["S:Body"]["ns8:deliver"]["ns8:message"]["ns3:metadata"]["ns3:routeRecord"]["ns3:interaction"]["ns7:target"]:setInner(xml.secure.SMD.sSenderOrg)
   _xmlSMD["S:Envelope"]["S:Body"]["ns8:deliver"]["ns8:message"]["ns3:metadata"]["ns3:routeRecord"]["ns3:interaction"]["ns7:serviceCategory"]:setInner(_sServiceCategory)
   _xmlSMD["S:Envelope"]["S:Body"]["ns8:deliver"]["ns8:message"]["ns3:metadata"]["ns3:routeRecord"]["ns3:interaction"]["ns7:serviceEndpoint"]:setInner(xml.secure.SMD.sResponseURL)
   _xmlSMD["S:Envelope"]["S:Body"]["ns8:deliver"]["ns8:message"]["ns3:metadata"]["ns3:routeRecord"]["ns3:interaction"]["ns7:serviceProvider"]:setInner(xml.secure.SMD.sSenderOrg)
   
   
   return _xmlSMD:S()
   
end