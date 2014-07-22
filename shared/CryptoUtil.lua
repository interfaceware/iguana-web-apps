require 'stringutil'

-- set path for OpenSSL executable (include trailing separator)
local _sOpenSSL_Path = ''

-- get environment
local _bIsWindows = false
local _sPathSep = '/'

if iguana.workingDir():find('\\') then
   _bIsWindows = true
end
   
-- set the temp folder otherwise default temp folder is used
local _sTempFolder = ''
if _sTempFolder == '' then
   if(not os.fs.access('/tmp', 'rw')) then
      if os.fs.access(os.getenv('TEMP'), 'rw') then
         _sTempFolder = os.getenv('TEMP') .. '/'
      elseif os.fs.access(os.getenv('TMPDIR'), 'rw') then
         _sTempFolder = os.getenv('TMPDIR') .. '/'
      elseif os.fs.access(os.getenv('TMP'), 'rw') then
         _sTempFolder = os.getenv('TMP') .. '/'
      else
         _sTempFolder = iguana.workingDir() .. '/'
      end
   else
      _sTempFolder = '/tmp/'
   end
end

filter.RSA = {}
filter.RSA.commands = {}
if _bIsWindows then
   filter.RSA.commands.enc = 'pkeyutl'
   filter.RSA.commands.key = 'pkey'
else
   filter.RSA.commands.enc = 'rsautl'
   filter.RSA.commands.key = 'rsa'
end

function util:sha1(_sPayload)
   -- call OpenSSL to return sha1 hash
   -- write payload to file
   local _file = _sTempFolder .. util.guid(128) .. '.dat'
   local _f = io.open(_file, 'wb')
   _f:write(_sPayload)
   _f:close()

   --call OpenSSL with popen and read result from stdout
   local _sCommand = _sOpenSSL_Path .. 'openssl dgst -binary -sha1 "' .. _file .. '"'
   local _pipe = io.popen(_sCommand)
   local _sha1 = filter.base64.enc(_pipe:read('*a'))
   _pipe:close()

   -- remove temporary file
   os.remove(_file)

   if _sha1 == '' then
      error('Error executing command: ' .. _sCommand, 2)
   end

   return _sha1
end

function filter.RSA:sign(_sPayload, _sPrivateKeyFile)
   -- call OpenSSL to return signature value
   -- write payload to file
   local _file = _sTempFolder .. util.guid(128) .. '.dat'
  
   local _f = io.open(_file, 'wb')
   _f:write(_sPayload)
   _f:close()
   
   --call OpenSSL with popen and read result from stdout
   local _sCommand = _sOpenSSL_Path .. 'openssl '.. filter.RSA.commands.enc .. ' -sign -in "' .. _file .. '" -inkey "' .. _sPrivateKeyFile .. '"'
   local _pipe = io.popen(_sCommand)
   local _sSign = filter.base64.enc(_pipe:read('*a'))
   _pipe:close()
   
   -- throw error if no value returned
   if _sSign == '' then
      error('Error executing command: ' .. _sCommand, 2)
   end

   -- remove temporary file
   os.remove(_file)

   return _sSign
end

function filter.RSA:getSKI(_sCertificateFile)
   --return the SKI from the certificate
   --call OpenSSL with popen and read result from stdout
   local _sCommand = _sOpenSSL_Path .. 'openssl x509 -inform pem -text -in "' .. _sCertificateFile .. '"'
   local _pipe = io.popen(_sCommand)
   local _s = _pipe:read('*a')
   _pipe:close()

   -- throw error if no value returned
   if _s == '' then
      error('Error executing command: ' .. _sCommand, 2)
   end

   -- convert hex codes to bytes
   _, nStart = _s:find('Subject Key Identifier: \n')
   _s = _s:sub(nStart + 1)
   _s = _s:sub(0, _s:find('\n')-1):gsub('[ :]','')
   return filter.base64.enc(filter.hex.dec(_s))
end

function filter.RSA:encrypt(_sPayload, _sPublicKeyFile)
   -- call OpenSSL to return encrypted value
   -- write payload to file
   local _file = _sTempFolder .. util.guid(128) .. '.dat'
   
   local _f = io.open(_file, 'wb')
   _f:write(_sPayload)
   _f:close()
   
   --call OpenSSL with popen and read result from stdout
   local _sCommand = _sOpenSSL_Path .. 'openssl '.. filter.RSA.commands.enc .. ' -encrypt -pubin -in ' .. _file .. ' -inkey  "' .. _sPublicKeyFile .. '"'
   local _pipe = io.popen(_sCommand)
   local _sEnc = filter.base64.enc(_pipe:read('*a'))
   _pipe:close()
   
   -- throw error if no value returned
   if _sEnc == '' then
      error('Error executing command: ' .. _sCommand, 2)
   end

   -- remove temporary file
   os.remove(_file)
   return _sEnc
end

function filter.RSA:extractPublicKey(_sCertificateFile, _sPublicKeyFile)
   --extract the public key from the certificate
   --call OpenSSL with popen and read result from stdout
   local _sCommand = _sOpenSSL_Path .. 'openssl x509 -inform PEM -pubkey -noout  -in "' .. _sCertificateFile .. '"'
   local _pipe = io.popen(_sCommand)
   local _sKey = _pipe:read('*a')
   _pipe:close()

   -- throw error if no value returned
   if _sKey == '' then
      error('Error executing command: ' .. _sCommand, 2)
   end

   -- write string to file
   local _file = io.open(os.fs.abspath(_sPublicKeyFile), 'w')
   _file:write(_sKey)
   _file:close()
end

function filter.RSA:getPublicKey(_sPublicKey)
   -- return the public key
   --call OpenSSL with popen and read result from stdout
   local _sCommand = _sOpenSSL_Path .. 'openssl '.. filter.RSA.commands.key .. ' -pubin   -in "' .. _sPublicKey .. '"'
   local _pipe = io.popen(_sCommand)
   local _s = _pipe:read('*a')
   _pipe:close()
   
   if _s == '' then
      error('Error executing command: ' .. _sCommand, 2)
   end
   
   -- remove first and last line
   return _s:sub(_s:find('\n')+1, _s:find('\n', -26)-1)
end
