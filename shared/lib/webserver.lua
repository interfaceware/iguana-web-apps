if not lib then lib = {} end

lib.webserver = {}

require 'file'

local ws = lib.webserver

local webMT = {__index=lib.webserver}

local function CheckVersion()
   local V = iguana.version()
   local D = V.major * 10000 + V.minor * 100 + V.build
   trace(D)
   if D < 50605 then
      iguana.stopOnError(true);
      error('Sorry this script requires Iguana 5.6.5 or greater.');
   end
end

local function CalcBaseUrl()
   CheckVersion()
   local Config = iguana.channelConfig{guid=iguana.channelGuid()}
   Config = xml.parse{data=Config}
   BaseUrl = '/'..tostring(Config.channel.from_http.mapper_url_path)
   if BaseUrl:sub(#BaseUrl) ~= '/' then
      iguana.stopOnError(true)
      error('Please reconfigure the channel to have the base URL path '..BaseUrl..'/');
   end
   return BaseUrl
end

function lib.webserver.create(T)
   T.baseUrl = CalcBaseUrl()
   T.baseUrlSize = #T.baseUrl +1
   setmetatable(T, webMT)  
   return T
end

local function ServeError(ErrMessage, Code, Stack, Data)
   local Body = {error = ErrMessage}
   if Stack then 
      Body.stack = Stack
   end
   if Data then 
      Body.data = Data 
   end
   net.http.respond{code = Code, body = json.serialize{data = Body}, entity_type = 'text/json'}
   -- Only log internal errors
   if Code > 499 then
      local ErrId = queue.push{data = Data}
      iguana.logError(Stack .. '\n' .. Data, ErrId)
   end
end

local function DoJsonAction(Self, R)   
   local Action = R.location:sub(Self.baseUrlSize)
   local Func = Self.actions[Action]
   trace(Func)
   if (Func) then
      local Result = Func(R, Self.app)
      if Result.error then 
         ServeError(Result.error, Result.code)
         return false
      end
      Result = json.serialize{data=Result}
      net.http.respond{body=Result, entity_type='text/json'}   
      return true
   end
   return false
end

local ContentTypeMap = {
   ['.js']  = 'application/x-javascript',
   ['.css'] = 'text/css',
   ['.gif'] = 'image/gif',
   ['.html'] = 'text/html'
}

local function FindEntity(Location) 
   local Ext = Location:match('.*(%.%a+)$')
   local Entity = ContentTypeMap[Ext]
   return Entity or 'text/plain'
end

local function LoadMilestonedFile(FileName)   
   FileName = iguana.project.files()["other/"..FileName]
   trace(FileName)
   if FileName then
      return os.fs.readFile(FileName);
   end
end

local function LoadSandboxFile(FileName, User)
   local RootDir = iguana.workingDir()..'edit/'..User..'/other/'
   trace(RootDir)
   local Path = os.fs.abspath(RootDir..FileName)
   if (Path:sub(1, #RootDir) ~=RootDir) then
      -- We have an above root attack.
      return
   end
   if (os.fs.access(Path)) then
      return os.fs.readFile(Path)
   end
end

local function ServeFile(Self, R)
   local FileName = R.location:sub(Self.baseUrlSize)
   if #FileName == 0 then 
      FileName = Self.default 
   end
   
   local Content
   if Self.test then 
      Content = LoadSandboxFile(FileName, Self.test)
   else
      Content = LoadMilestonedFile(FileName)
   end
   local Entity = FindEntity(FileName)
   trace(Content)
   if (Content) then
      net.http.respond{body=Content, entity_type=Entity}
      return true
   end
   return false
end

-- Find the method for the action.
function ws.serveRequest(Self, P)
   local R = net.http.parseRequest{data=P.data}
   if DoJsonAction(Self, R) then return end
   if ServeFile(Self, R) then return end
   net.http.respond{code=400,body='Bad request'}
end


