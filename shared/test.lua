local test = {}
test.ui = require 'testui'

zip = require 'zip'
queue = require 'mockqueue'

test.EXPECTED_DATA = "~/iguana_expected"
test.IGUANA_PORT = "7500"

local REDLIGHT = '<div class="status-red"></div>'
local GREENLIGHT = '<div class="status-green"></div>'

test.TheTrans = {}

function test.cleanConfig()
   test.TheTrans = {}
end

-- Returns a handle on the database for a given translator instance 
function test.dbconn(TGuid)
   return db.connect{api=db.SQLITE, name = iguana.workingDir() .. 'data/' .. TGuid .. '.db'}
end

function loadChannel(ChannelGuid)
   local ChannelGuid = tostring(ChannelGuid)
   local C,R = net.http.post{url='http://localhost:' .. test.IGUANA_PORT .. '/get_channel_config', 
                 auth={password='password', username='admin'},
                parameters={guid=ChannelGuid, compact=false}, live=true}
   if (R ~= 200) then
      test.error(C)
   end
   return xml.parse{data = C}
end

function test.getTranslatorGuid(ChannelGuid) 
   C = loadChannel(ChannelGuid)
   if C.channel.use_message_filter:nodeValue() ~= 'false' then
      if tostring(C.channel.message_filter.translator_guid) == '00000000000000000000000000000000' then
         test.error('Channel ' .. tostring(C.channel.name) ..' does not have a filter with a saved milestone.')   
      end
      return C.channel.message_filter.translator_guid
   end
   return false   
end

function test.load(T)
   local TGuid = test.getTranslatorGuid(T)
   if TGuid then
      test.loadTrans(TGuid)
      return test.testTrans(TGuid)
   end
   test.error('Channel ' .. tostring(C.channel.name) .. ' does not use a translator filter so this regression test is of no use.')
end

function test.error(Msg)
   error({error=Msg})
end

function test.loadExpected(Guid)
   local ExpectedFile = os.fs.abspath(test.EXPECTED_DATA).."/"..Guid..".json"
   trace(ExpectedFile)
   local F = io.open(ExpectedFile, "r")
   if (not F) then
      return {}
   end
   local C = F:read('*a')
   return json.parse{data=C}
end

function test.hasSample(Guid) 
   local Cpath  = iguana.workingDir() .. 'IguanaConfiguration.xml'
   local Cfile = io.open(Cpath, 'r')
   local Config = Cfile:read("*a")
   Cfile:close()
   local Details = xml.parse(Config)
end

function test.loadSample(Guid)
   local Guid = tostring(Guid)
   local SampleData = test.TheTrans[Guid]["samples.json"]
   if not SampleData then 
      return {}
   end 
   return json.parse{data=SampleData}.Samples or {}
end

function test.changeExpected(Guid, SDidx, NewText)
   local SDidx = SDidx + 1
   local NewText = filter.uri.dec(NewText)
   trace(NewText)
   local ExpectedFile = os.fs.abspath(test.EXPECTED_DATA)
                        .."/"..Guid..".json"
   trace(ExpectedFile)
   local Ex = io.open(ExpectedFile, 'r')
   local ExText = Ex:read('*a')
   local ExTree = json.parse{data=ExText}
   Ex:close()
   trace(ExTree)
   for Input, Tree in pairs(ExTree) do
      trace(Tree['i'])   
      if Tree['i'] == SDidx then
         Tree['output'] = NewText
         Ex = io.open(ExpectedFile, 'w+')
         Ex:write(json.serialize{data=ExTree})
         Ex:close()
         return {status="OK"}
      end
   end
   return {status="Error"}
end

function test.saveExpected(Guid, Actual)  
   local ExpectedFile = os.fs.abspath(test.EXPECTED_DATA)
                        .."/"..Guid..".json"
   trace(ExpectedFile)
   local F = io.open(ExpectedFile, 'w+')
   F:write(json.serialize{data=Actual})
   F:close()      
end

function test.buildExpected(TGuid)
   test.loadTrans(TGuid)
   local Input = test.loadSample(TGuid)
   queue.reset()
   for i=1, #Input do
      queue.setCurrent(Input[i].Message, i, Input[i].Name)
      originalMain(Input[i].Message)
   end
   test.saveExpected(TGuid, queue.results())
   return {status="OK"}
end

function test.testTrans(Guid)  
   local Input = test.loadSample(Guid)
   queue.reset()
   local Expected = test.loadExpected(Guid)
   queue.setExpected(Expected)
   for i=1, #Input do
      queue.setCurrent(Input[i].Message, i, Input[i].Name)
      originalMain(Input[i].Message)
   end
   local Actual = queue.results() 
   return test.compare(Expected, Actual)
end

function test.compare(Expected, Actual) 
   local Result = {}
   for Input, AOut in pairs(Actual) do
      Result[AOut.i] = {r = 'Y', name = AOut.name, Act = test.hideLineEnds(AOut.output)}
      local EOut = Expected[Input]
      trace(EOut)
      if EOut then 
         Result[AOut.i]['Exp'] = test.hideLineEnds(EOut.output)
      else 
         Result[AOut.i]['Exp'] = 'NO EXPECTED RESULT EXISTS FOR THIS TEST'
      end
      if EOut.output ~= AOut.output then
         Result[AOut.i]['r'] = 'N'
      end
   end
   return Result
end

local LineEndings = {
   ['\n'] = '\\n',
   ['\r'] = '\\r'
}

function test.hideLineEnds(TheString) 
   TheString = string.gsub(TheString, '\\', '\\\\')
   for Real, Fake in pairs(LineEndings) do
      TheString = string.gsub(TheString, Real, Fake)
      TheString = string.gsub(TheString, Fake, ' <span class="line-end">' .. Fake .. '</span><br> ')
   end
   return TheString
end

function test.restoreLineEnds(TheString)
   for Real, Fake in pairs(LineEndings) do
      TheString = string.gsub(TheString, Real, '')
      TheString = string.gsub(TheString, Fake, Real)
   end
   TheString = string.gsub(TheString, '\\\\', '\\')
   return TheString
end

function test.require(ModName)
   local ReqScript = test.TheTrans.shared[ModName .. '.lua']
   local MF = loadstring(ReqScript)
   return MF()
end

-- Checks a given translator for the presence of sample data
function test.hasSample(TGuid) 
   local db = test.dbconn(TGuid)
   local Res = db:query{sql='SELECT COUNT(Id) FROM Log', live = true}
   local Count = tonumber(Res[1]["COUNT(Id)"]:nodeValue())
   return Count > 0 and Count or nil   
end

-- Returns a list of channels with relevant details in a format DataTables likes.
function test.loadChannels()
   local Channels = {}
   local Guids = {}
   local Summary, Retcode = net.http.post{url='http://localhost:' .. test.IGUANA_PORT .. '/monitor_query', 
      auth={username="admin", password="password"},parameters={Compact='T'}, live=true}
   if Retcode == 200 then
      local Xml = xml.parse(Summary).IguanaStatus
      local ChannelIndex = 1
      for i = 1, #Xml do
         if Xml[i]:nodeName() == 'Channel' then
            local ThisChannel = Xml[i]
            trace(ThisChannel.Guid)
            local TGuid = test.getTranslatorGuid(ThisChannel.Guid)
            trace(TGuid)
            if TGuid and test.hasSample(TGuid) then
               local Expected = test.loadExpected(TGuid)
               local HasExp = next(Expected) and true or false
               Channels[ChannelIndex] = {
                  '<a href="#Test=' .. tostring(ThisChannel.Guid) .. '">' 
                  .. tostring(ThisChannel.Name) .. '</a>', tostring(ThisChannel.Source), 
                  tostring(ThisChannel.Destination), HasExp and GREENLIGHT or REDLIGHT, ''}
               Guids[ChannelIndex] = {tostring(ThisChannel.Guid), tostring(ThisChannel.Name), HasExp, tostring(TGuid)}
               ChannelIndex = ChannelIndex + 1
            end
         end
      end
      
   else
      return {"Error"}
   end
   local Fields = {
      {['sTitle'] = 'Name', ['sType'] = 'html', ['sWidth'] = '40%'},
      {['sTitle'] = 'Source', ['sType'] = 'string'},
      {['sTitle'] = 'Destination', ['sType'] = 'string'},
      {['sTitle'] = 'Has Test List', ['sType'] = 'string'},
      {['sTitle'] = 'Test Results', ['sType'] = 'string'}
   }
   return Channels, Fields, Guids
end

function test.loadTrans(Guid)
   local Guid = tostring(Guid)
   local Config = net.http.post{url='localhost:' .. test.IGUANA_PORT .. '/export_project',
                       auth={password='password', username='admin'},
                       parameters={guid=Guid, sample_data='true'}, 
                       live=true}

   local ZipFile = filter.base64.dec(Config)
   test.TheTrans = filter.zip.inflate(ZipFile)
   trace(test.TheTrans)
   local MainScript = test.TheTrans[Guid]["main.lua"]
   
   MainScript = MainScript:gsub("function main", "function originalMain")
   trace(MainScript) 
   require = test.require
   local MF = loadstring(MainScript)
   MF()
end

function test.default(R) 
   return test.ui.main(R)
end

local ContentTypeMap = {
   ['.js']  = 'application/x-javascript',
   ['.css'] = 'text/css'
}

function test.entity(Location) 
   local Ext = Location:match('.*(%.%a+)$')
   local Entity = ContentTypeMap[Ext]
   return Entity or 'text/plain'
end

function test.serveRequest(Data)
   local R = net.http.parseRequest{data=Data}
   
   -- The UI itself
   if R.location == '/unit' and next(R.get_params) == nil then
      local Body = test.ui.main()
      net.http.respond{body=Body, entity_type="text/html"}
      return
   end
   
   -- UI asset requests
   local Resource = test.ui.ResourceTable[R.location]
   if (Resource) then
      local Body = test.ui.template(R.location, Resource)      
      net.http.respond{body=Body, entity_type=test.entity(R.location)} 
      return
   end
   
   -- Channel details
   if R.location == '/unit/channels' then
      local Channels = {}
      Channels.aaData, Channels.aoColumns, Channels.Guids = test.loadChannels()
      local Out = json.serialize{data=Channels}
      net.http.respond{body=Out, entity_type='text/json'}
      return
   end
   
   -- Build expected result set
   if R.location == '/unit/build' then 
      local Channel = R.get_params.channel
      if (not Channel) then
         net.http.respond{body='{error="Please supply channel=guid in URL"}', entity_type='text/json'}
         return
      end
      local Result = test.buildExpected(Channel)
      net.http.respond{body = json.serialize{data = Result}, entity_type='text/json'}
      return
   end
   
   -- Change a single expected result
   if R.location == '/unit/edit_result' then 
      local Translator = R.post_params.t_guid
      if (not Translator) then
         net.http.respond{body='{error="Please supply t_guid in URL"}', entity_type='text/json'}
         return
      end
      local Result = test.changeExpected(Translator, R.post_params.sd_idx, test.restoreLineEnds(R.post_params.txt))
      net.http.respond{body = json.serialize{data = Result}, entity_type='text/json'}
      return
   end
   
   -- Run tests on a specific channel 
   local Channel = R.get_params.channel
   local ChannelName = R.get_params.name or ''
   if (not Channel) then
      net.http.respond{body='{error="Please supply channel=guid in URL"}', entity_type='text/json'}
      return
   else
      -- Actully run the tests
      local Success, Results 
      if iguana.isTest() then
         Results = test.load(Channel)
      else
         Success, Results = pcall(test.load, Channel)
         if (not Success) then
            if type(Results) == 'string' then
               Results = {error=Results}
            end
         end
      end
 
      -- Munge the result set into a DataTables structure
      local Cols = {
         {['sTitle'] = 'Test', ['sType'] = 'numeric'},
         {['sTitle'] = 'Name', ['sType'] = 'string'},
         {['sTitle'] = 'Result', ['sType'] = 'string'},
         {['sTitle'] = 'Inspect', ['sType'] = 'html'},
      }
      local Rows = {}
      for i = 1, #Results do
         local Light = Results[i]['r'] == 'Y' and GREENLIGHT or REDLIGHT
         local Link = '<a href="#Inspect=' .. i .. '&Test=' .. Channel .. '">Inspect</a>'
         Results[i]['EditLink'] = '<a target="_blank" href="http://localhost:' .. test.IGUANA_PORT .. '/mapper/#User=admin&ComponentName=Filter&ChannelName='
                                  .. ChannelName .. '&ChannelGuid=' .. tostring(test.getTranslatorGuid(Channel))
                                  .. '&ComponentType=Filter&Page=OpenEditor&Module=main&SDindex='
                                  .. i .. '">See this sample data in the Iguana Translator</a>'
         Rows[i] = {i, Results[i]['name'], Light, Link}
      end
      local FinalResult = {['aoColumns'] = Cols, ['aaData'] = Rows, ['Res'] = Results,
                           ['aaSorting'] = {{2, 'desc'}}, ['bFilter'] = false,
                           ['bInfo'] = false, ['bPaginate'] = false}
      net.http.respond{body=json.serialize{data=FinalResult}, entity_type='text/json'}
      return 
   end
end

-- This is a helper, used for cutting a path
function string:split(Delimiter)
  local Results = {}
  local Index = 1
  local SplitStart, SplitEnd = string.find(self, Delimiter, Index)
  while SplitStart do
    table.insert(Results, string.sub(self, Index, SplitStart - 1) )
    Index = SplitEnd + 1
    SplitStart, SplitEnd = string.find(self, Delimiter, Index)
  end
  table.insert(Results, string.sub(self, Index) )
  return Results
end

function test.findVmd(Node, Path)
   local Pieces = Path:split('/')
   for i = 1, #Pieces do
      trace(Pieces[i])
      Node = Node[Pieces[i]]
   end
   return Node
end

local originalHl7Parse = hl7.parse
function hl7.parse(T)
   T.vmd_definition = test.findVmd(test.TheTrans.other, T.vmd)
   return originalHl7Parse(T)
end

local originalHl7Message = hl7.message
function hl7.message(T)
   T.vmd_definition = test.findVmd(test.TheTrans.other, T.vmd)
   return originalHl7Message(T)
end

return test