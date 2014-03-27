require 'stringutil'

regressions.core = {}

------------
--
-- Local "helpers"
--

local function checkGuid(Guid) 
   if Guid:match("%W") or Guid:len() ~= 32 then 
      return false
   end
   return true
end

-- Given a channel Guid, looks up the guid for that channel's filter translator
local function getTranslatorGuid(ChannelGuid) 
   C = regressions.core.loadChannel(ChannelGuid)
   if C.channel.use_message_filter:nodeValue() ~= 'false' then
      if tostring(C.channel.message_filter.translator_guid) == '00000000000000000000000000000000' then
         server.serveError('Channel ' .. tostring(C.channel.name) ..' does not have a filter with a saved milestone.', 400)
        return  
      end
      return C.channel.message_filter.translator_guid
   end
   return false   
end

-- Returns a handle on the database for a given translator instance 
local function dbconn(TGuid)
   return db.connect{api=db.SQLITE, name = iguana.workingDir() .. 'data/' .. TGuid .. '.db'}
end

-- Checks for the presence of sample data in a given translator instance
local function hasSample(TGuid) 
   local db = dbconn(TGuid)
   local Res = db:query{sql='SELECT COUNT(Id) FROM Log', live = true}
   local Count = tonumber(Res[1]["COUNT(Id)"]:nodeValue())
   return Count > 0 and Count or nil   
end


------------
--
-- The App
--

-- Require this app object in the top of your main script for
-- your web app. Make it *non-local* so the webserver can use it.

local REDLIGHT = '<div class="status-red"></div>'
local GREENLIGHT = '<div class="status-green"></div>'

-- This table holds an in-memory tree of all the files making up a translator instance.
regressions.TheTrans = {}

function regressions.core.cleanConfig()
   regressions.TheTrans = {}
end

-- Pull a script out of another translator and execute it
function regressions.core.require(ModName)
   local ReqScript = regressions.TheTrans.shared[ModName .. '.lua']
   local MF = loadstring(ReqScript)
   return MF()
end


------------
-- REQUEST HANDLERS
------------

-- /regression_tests
function regressions.default()
   return regressions.presentation["/regression_tests/index.html"]
end

-- /regression_tests/channels
function regressions.core.loadChannels()
   local Channels = {}
   local Guids = {}
   local Summary, Retcode = net.http.post{url='http://localhost:' .. app.config.ig['web_config']['port'] .. '/monitor_query', 
      auth={username="admin", password="password"},parameters={Compact='T'}, live=true}
   if Retcode == 200 then
      local Xml = xml.parse(Summary).IguanaStatus
      local ChannelIndex = 1
      for i = 1, #Xml do
         if Xml[i]:nodeName() == 'Channel' then
            local ThisChannel = Xml[i]
            trace(ThisChannel.Guid)
            local TGuid = getTranslatorGuid(ThisChannel.Guid)
            trace(TGuid)
            if TGuid and hasSample(TGuid) then
               local Expected = regressions.core.loadExpected(TGuid)
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
   return {['aaData'] = Channels, ['aoColumns'] = Fields, ['Guids'] = Guids}
end

-- /regression_tests/run_tests?channel={GUID}
function regressions.core.runTests(Request) 
   local Channel = Request.get_params.channel
   local ChannelName = Request.get_params.name or ''
   if not checkGuid(Channel) then 
      return {error = "Sorry, channel " .. ChannelName .. " not found", code = 404}
   end
   
   -- Actully run the tests
   Results = regressions.core.load(Channel)
   return Results.error and Results or regressions.core.formatResults(Results, Channel, ChannelName)
end

-- /regression_tests/build?channel={GUID}
function regressions.core.build(Request) 
   local Channel = Request.get_params.channel
   if not checkGuid(Channel) then 
      return {error = "Bad Channel GUID", code = 400}
   end
   return regressions.core.buildExpected(Channel)
end

-- /regression_tests/edit_result
function regressions.core.editResult(Request) 
   local Translator = Request.post_params.t_guid
   if not checkGuid(Translator) then 
      return {error = "Bad Translator GUID", code = 400}
   end
   return regressions.core.changeExpected(Translator, Request.post_params.sd_idx, regressions.core.restoreLineEnds(Request.post_params.txt))
end


------------
-- CHANNEL AND TRANSLATOR INFO TOOLS
------------

-- Exports a translator instance into an in-memory tree
function regressions.core.loadTranslator(TGuid)
   local Guid = tostring(TGuid)
   local Config = net.http.post{url='localhost:' .. app.config.ig['web_config']['port'] .. '/export_project',
                       auth={password = app.config.creds.pass, username = app.config.creds.user},
                       parameters={guid=Guid, sample_data='true'}, 
                       live=true}

   local ZipFile = filter.base64.dec(Config)
   regressions.TheTrans = filter.zip.inflate(ZipFile)
   trace(regressions.TheTrans)
   local MainScript = regressions.TheTrans[Guid]["main.lua"]
   
   MainScript = MainScript:gsub("function main", "function originalMain")
   trace(MainScript) 
   require = regressions.core.require
   local MF = loadstring(MainScript)
   MF()
end

-- Pulls sample data out of the in-memory JSON string into a lua table
function regressions.core.loadSample(TGuid)
   local Guid = tostring(TGuid)
   local SampleData = regressions.TheTrans[Guid]["samples.json"]
   if not SampleData then 
      return {}
   end 
   return json.parse{data=SampleData}.Samples or {}
end

-- Pulls expected results from disk
function regressions.core.loadExpected(Guid)
   local ExpectedFile = app.config.WorkTank .. Guid .. '.json'
   local F = io.open(ExpectedFile, "r")
   if (not F) then
      return {}
   end
   local C = F:read('*a')
   return json.parse{data=C} or {}
end

-- Fetches details about a channel using the channel API
function regressions.core.loadChannel(ChannelGuid)
   local ChannelGuid = tostring(ChannelGuid)
   local Channel, ResponseCode = net.http.post{url='http://localhost:' .. app.config.ig.web_config.port .. '/get_channel_config', 
                 auth={password='password', username='admin'},
                parameters={guid=ChannelGuid, compact=false}, live=true}
   if (ResponseCode ~= 200) then
      return {error = Channel}
   end
   return xml.parse{data = Channel}
end

-- Updates a single expected result on disk
function regressions.core.changeExpected(TGuid, SDidx, NewText)
   local SDidx = SDidx + 1
   local NewText = filter.uri.dec(NewText)
   --trace(NewText)
   local ExpectedFile = regressions.config.WorkTank .. TGuid .. '.json'
   --trace(ExpectedFile)
   local Ex = io.open(ExpectedFile, 'r')
   if not Ex then 
      return {error = "Could not open " .. ExpectedFile 
               .. ", the file that should hold expected test results.", code = 500}
   end
   local ExText = Ex:read('*a')
   local ExTree = json.parse{data=ExText}
   Ex:close()
   --trace(ExTree)
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
   return {error="Saving expected results to " 
           .. ExpectedFile .. " did not succeed.", code = 500}
end

-- Creates or overwrites an expected results file on disk
function regressions.core.saveExpected(TGuid, Actual)  
   local ExpectedFile = regressions.config.WorkTank .. TGuid .. '.json'
   trace(ExpectedFile)
   local F = io.open(ExpectedFile, 'w+')
   F:write(json.serialize{data=Actual})
   F:close()      
end

-- Makes a set of expected results by copying the actuals
function regressions.core.buildExpected(TGuid)
   regressions.core.loadTranslator(TGuid)
   local Input = regressions.core.loadSample(TGuid)
   queue.reset()
   for i=1, #Input do
      queue.setCurrent(Input[i].Message, i, Input[i].Name)
      originalMain(Input[i].Message)
   end
   regressions.core.saveExpected(TGuid, queue.results())
   return {status="OK"}
end



------------
-- TESTS AND RESULT FORMATTING
------------

-- This is where most of the action happens. Takes a channel, finds the
-- relevent translator, then runs the regression tests against that translator
function regressions.core.load(ChannelGuid)
   local TGuid = getTranslatorGuid(ChannelGuid)
   if TGuid then
      regressions.core.loadTranslator(TGuid)
      return regressions.core.testTranslator(TGuid)
   end
   return {error = 'Channel ' .. tostring(C.channel.name) ..' does not use a translator filter so this regression test is of no use.', code = 400}
end

-- Pulls the actual and expected results together
function regressions.core.testTranslator(TGuid)  
   local Input = regressions.core.loadSample(TGuid)
   queue.reset()
   local Expected = regressions.core.loadExpected(TGuid)
   queue.setExpected(Expected)
   for i=1, #Input do
      queue.setCurrent(Input[i].Message, i, Input[i].Name)
      originalMain(Input[i].Message)
   end
   local Actual = queue.results() 
   return regressions.core.compare(Expected, Actual)
end

-- Iterate through the results and evaulate each test
function regressions.core.compare(Expected, Actual) 
   local Result = {}
   if not next(Expected) then
      return {error = "No expected test result set exists for this translator"}
   end
   for Input, AOut in pairs(Actual) do
      Result[AOut.i] = {r = 'Y', name = AOut.name, Act = regressions.core.hideLineEnds(AOut.output)}
      local EOut = Expected[Input]
      trace(EOut)
      if EOut then 
         Result[AOut.i]['Exp'] = regressions.core.hideLineEnds(EOut.output)
      else 
         Result[AOut.i]['Exp'] = 'NO EXPECTED RESULT EXISTS FOR THIS TEST'
      end
      if EOut.output ~= AOut.output then
         Result[AOut.i]['r'] = 'N'
      end
   end
   return Result
end

-- Put a test result set into a DataTables structure
function regressions.core.formatResults(Results, Channel, ChannelName) 
   local Cols = {
      {['sTitle'] = 'Test', ['sType'] = 'numeric'},
      {['sTitle'] = 'Name', ['sType'] = 'string'},
      {['sTitle'] = 'Result', ['sType'] = 'string'},
      {['sTitle'] = 'Inspect', ['sType'] = 'html'},
   }
   local Rows = {}
   local TGuid = tostring(getTranslatorGuid(Channel))
   for i = 1, #Results do
      local Light = Results[i]['r'] == 'Y' and GREENLIGHT or REDLIGHT
      local Link = '<a href="#Inspect=' .. i .. '&Test=' .. Channel .. '">Inspect</a>'
      Results[i]['EditLink'] = '<a target="_blank" href="http://localhost:' .. regressions.config.ig.web_config.port 
                               .. '/mapper/#User=' .. regressions.config.creds.user .. '&ComponentName=Filter&ChannelName='
                               .. ChannelName .. '&ChannelGuid=' .. TGuid
                               .. '&ComponentType=Filter&Page=OpenEditor&Module=main&SDindex='
                               .. i .. '">See this sample data in the Iguana Translator</a>'
      Rows[i] = {i, Results[i]['name'], Light, Link}
   end
   return {['aoColumns'] = Cols, ['aaData'] = Rows, ['Res'] = Results,
           ['aaSorting'] = {{2, 'desc'}}, ['bFilter'] = false,
           ['bInfo'] = false, ['bPaginate'] = false, ['Guid'] = Channel}
end



------------
-- TEXT UTILITIES
------------

local LineEndings = {
   ['\n'] = '\\n',
   ['\r'] = '\\r'
}

function regressions.core.hideLineEnds(TheString) 
   TheString = string.gsub(TheString, '\\', '\\\\')
   for Real, Fake in pairs(LineEndings) do
      TheString = string.gsub(TheString, Real, Fake)
      TheString = string.gsub(TheString, Fake, ' <span class="line-end">' .. Fake .. '</span><br> ')
   end
   return TheString
end

function regressions.core.restoreLineEnds(TheString)
   for Real, Fake in pairs(LineEndings) do
      TheString = string.gsub(TheString, Real, '')
      TheString = string.gsub(TheString, Fake, Real)
   end
   TheString = string.gsub(TheString, '\\\\', '\\')
   return TheString
end



------------
-- TOOLS SPECIFIC TO HL7 PARSING IN TESTED CHANNELS
------------

function regressions.core.findVmd(Node, Path)
   local Pieces = Path:split('/')
   for i = 1, #Pieces do
      trace(Pieces[i])
      Node = Node[Pieces[i]]
   end
   return Node
end

local originalHl7Parse = hl7.parse
function hl7.parse(T)
   T.vmd_definition = regressions.core.findVmd(regressions.TheTrans.other, T.vmd)
   return originalHl7Parse(T)
end

local originalHl7Message = hl7.message
function hl7.message(T)
   T.vmd_definition = regressions.core.findVmd(regressions.TheTrans.other, T.vmd)
   return originalHl7Message(T)
end



return app
