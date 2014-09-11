require 'stringutil'
local Zip = require 'zip'
regressions = {}
regressions.config = require 'regressions.config'
regressions.app = {}
require 'iguanaServer'
local spin = require 'spin'
local Spinner = spin.getSpinner(regressions.config.hosts)

------------
--
-- Local "helpers"
--

regressions.ThisIggy = iguanaServer.connect{
      url = iguana.webInfo().ip .. ':' .. iguana.webInfo().web_config.port,
      username = regressions.config.hosts['local']['user'],
      password = regressions.config.hosts['local']['pass']
   }

local function checkGuid(Guid) 
 --  trace(regressions.ThisIggy:getChannelConfig{guid='6FA425840DAE168B25CE8AFBFED4245E'})
      if Guid:match("%W") or Guid:len() ~= 32 then 
      return false
   end
   return true
end

-- Given a channel Guid, looks up the guid for that channel's filter translator
local function getTranslatorGuid(ChannelGuid) 
   C = regressions.app.loadChannel(ChannelGuid)
   trace (C.channel)
   if C.channel.use_message_filter:nodeValue() ~= 'false' then

      -- Catch Python scripts
      if C.channel.message_filter.use_translator_filter:nodeValue() == 'false' then 
         return 'ChameleonTransformation'
      end
      
      if tostring(C.channel.message_filter.translator_guid) == '00000000000000000000000000000000' then
         error{error = 'Channel ' .. tostring(C.channel.name) ..' does not have a filter with a saved milestone.', code = 400}
 
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


------------
-- REQUEST HANDLERS
------------

-- /regression_tests/
function regressions.default()
   return regressions.presentation["/regression_tests/index.html"]
end

-- /regression_tests/channels
function regressions.app.loadChannels()
   local Channels = {}
   local Guids = {}
   trace(regressions.config)

   local Summary, Retcode = net.http.get{
      url = 'http://localhost:' .. iguana.webInfo()['web_config']['port'] .. '/monitor_query',
      auth = {username=regressions.config.hosts['local']['user'], password=regressions.config.hosts['local']['pass']},
      parameters = {Compact='T'},
      live = true
   }
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
               local Expected = regressions.app.loadExpected(TGuid)
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
      error{error = "Could not load channel list", code = 500}
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
function regressions.app.runTests(Request)
   local Channel = Request.get_params.channel
   local ChannelName = Request.get_params.name or ''
   if not checkGuid(Channel) then 
      error{error = "Sorry, channel " .. ChannelName .. " not found", code = 404}
   end
   
   -- Actully run the tests
   regressions.app.load(Channel)
   local Results = regressions.app.compare()
   return regressions.app.formatResults(Results, Channel, ChannelName)
end

-- /regression_tests/build?channel={GUID}
function regressions.app.build(Request) 
   local Channel = Request.get_params.channel
   if not checkGuid(Channel) then 
      error{error = "Bad Channel GUID", code = 400}
   end
   regressions.app.load(Channel)
   local Translator = getTranslatorGuid(Channel) 
   return regressions.app.buildExpected(Translator:nodeValue())
end

-- /regression_tests/edit_result
function regressions.app.editResult(Request) 
   local Translator = Request.post_params.t_guid
   if not checkGuid(Translator) then 
      error{error = "Bad Translator GUID", code = 400}
   end
   return regressions.app.changeExpected(Translator, Request.post_params.sd_idx, regressions.app.restoreLineEnds(Request.post_params.txt))
end


------------
-- CHANNEL AND TRANSLATOR INFO TOOLS
------------

-- Takes a Zip-structure tree and returns a 
-- simpler one in the format the spinner likes.
function climbTree(Node) 
   local Node = Node and Node or {}
   local NewNode = {}
   for Name, Val in pairs(Node) do 
      trace(Name)
      if type(Val) == 'table' then 
         NewNode[Name] = climbTree(Val)
      end
      if type(Val) == 'string' and not Name:find('::') then 
         NewNode[Name] = Val
      end
   end
   return NewNode
end

-- Makes a simplified list of sample data
function trimSamples(Complex) 
   local Simple = {}
   for i = 1, #Complex do 
      Simple[i] = Complex[i].Message
   end
   return Simple
end

function regressions.app.overloadTranslator(TGuid)
   local Guid = tostring(TGuid)
   local Config = regressions.ThisIggy:exportProject{guid = Guid}
   local ZipFile = filter.base64.dec(Config)
   local Tree = filter.zip.inflate(ZipFile)
   local Samples = json.parse{data = Tree[Guid]["samples.json"]}
   local SimpleTree = {
      ['main.lua'] = Tree[Guid]['main.lua'],
      shared = climbTree(Tree.shared),
      other =  climbTree(Tree.other)
   }
   trace(SimpleTree)
   regressions.DataSet = json.parse(Tree[Guid]["samples.json"]).Samples
   trace(regressions.DataSet)
   return regressions.Trans:overload(SimpleTree)
end

-- Runs the current dataset through the overloaded translator.
function regressions.app.getActuals()
   return regressions.Trans:run(trimSamples(regressions.DataSet), {OneForOne = true}).messages
end

-- Pulls expected results from disk
function regressions.app.loadExpected(Guid)
   local ExpectedFile = regressions.config.WorkTank .. Guid .. '.json'
   local F = io.open(ExpectedFile, "r")
   if (not F) then
      return {}
   end
   local C = F:read('*a')
   return json.parse{data=C} or {}
end

-- Fetches details about a channel using the channel API
function regressions.app.loadChannel(ChannelGuid)
   local ChannelGuid = tostring(ChannelGuid)
   local Channel, ResponseCode = net.http.post{url='http://localhost:' .. iguana.webInfo().web_config.port .. '/get_channel_config', 
                 auth={password='password', username='admin'},
                parameters={guid=ChannelGuid, compact=false}, live=true}
   if (ResponseCode ~= 200) then
      error{error = Channel, code = ResponseCode}
   end
   return xml.parse{data = Channel}
end

-- Updates a single expected result on disk
function regressions.app.changeExpected(TGuid, SDidx, NewText)
   local SDidx = SDidx + 1
   local NewText = filter.uri.dec(NewText)
   local ExpectedFile = regressions.config.WorkTank .. TGuid .. '.json'
   local Ex = io.open(ExpectedFile, 'r')
   if not Ex then 
      error{error = "Could not open " .. ExpectedFile 
               .. ", the file that should hold expected test results.", code = 500}
   end
   local ExText = Ex:read('*a')
   local ExTree = json.parse{data=ExText}
   Ex:close()
   --trace(ExTree)
   for Input, Tree in pairs(ExTree) do
      trace(Tree['i'])   
      if Tree['i'] == SDidx then
         Tree['output']['data'] = NewText
         Ex = io.open(ExpectedFile, 'w+')
         Ex:write(json.serialize{data=ExTree})
         Ex:close()
         return {status="OK"}
      end
   end
   error{error="Saving expected results to " 
           .. ExpectedFile .. " did not succeed.", code = 500}
end

-- Creates or overwrites an expected results file on disk
function regressions.app.saveExpected(TGuid, Expected)  
   local ExpectedFile = regressions.config.WorkTank .. TGuid .. '.json'
   trace(ExpectedFile)
   local F = io.open(ExpectedFile, 'w+')
   F:write(json.serialize{data=Expected})
   F:close()
end

-- Makes a set of expected results by copying the actuals
function regressions.app.buildExpected(TGuid)
   local Expected = {}
   local Input = regressions.DataSet
   local Actuals = regressions.Actuals
   for i=1, #Input do
      Expected[Input[i].Message] = {
         i = i,
         name = Input[i].Name,
         output = Actuals[i]
      }
   end
   regressions.app.saveExpected(TGuid, Expected)
   return Expected
end


------------
-- TESTS AND RESULT FORMATTING
------------

-- This is where most of the action happens. Takes a channel, finds the
-- relevent translator, then runs the regression tests against that translator
function regressions.app.load(ChannelGuid)
   regressions.Trans = Spinner:getTranslator()
   regressions.TestingCGuid = ChannelGuid
   regressions.DataSet = {}
   regressions.Actuals = {}
   regressions.Expected = {}
   
   local TGuid = getTranslatorGuid(ChannelGuid)
   if TGuid then

      regressions.TestingTGuid = TGuid:nodeValue()
      local Success, Result = pcall(function()
            regressions.app.overloadTranslator(TGuid) 
         end)
      if not Success then 
         error{error = "Could not overload Sandbox Channel " .. ChannelGuid, code = 500} 
      end
      regressions.Actuals = regressions.app.getActuals()
      regressions.Expected = regressions.app.loadExpected(TGuid)
      return
   end
   error{error = 'Channel ' .. tostring(C.channel.name) 
      ..' does not use a translator filter so this regression test is of no use.', code = 400}
end

-- Pulls the actual and expected results together
function regressions.app.testTranslator(TGuid)  
   local Expected = regressions.app.loadExpected(TGuid)
   return regressions.app.compare(Expected, Actual)
end

-- Iterate through the results and evaulate each test
function regressions.app.compare()
   local Data = regressions.DataSet
   local Actuals = regressions.Actuals
   trace(Actuals)
   local Expected = regressions.Expected
   trace(Expected)
   local Result = {}
   if not next(Expected) then
      error{error = "No expected test result set exists for this translator", code = 404}
   end
   for i = 1, #Data do
      local Input = Data[i].Message
      trace(Actuals)
      Result[i] = {r = 'Y', name = Data[i].name or '', Act = regressions.app.hideLineEnds(Actuals[i]['data'])}
      trace(Result)
      local EOut = Expected[Input]
      trace(EOut.output)
      if EOut then 
         Result[i]['Exp'] = regressions.app.hideLineEnds(EOut.output.data)
      else 
         Result[i]['Exp'] = 'NO EXPECTED RESULT EXISTS FOR THIS TEST'
      end
      if EOut.output.data ~= Actuals[i].data then
         Result[i]['r'] = 'N'
      end
   end
   return Result
end

-- Put a test result set into a DataTables structure
function regressions.app.formatResults(Results, Channel, ChannelName) 
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
      Results[i]['EditLink'] = '<a target="_blank" href="http://localhost:' .. iguana.webInfo().web_config.port 
                               .. '/mapper/#User=' .. regressions.config.hosts['local']['user'] .. '&ComponentName=Filter&ChannelName='
                               .. ChannelName .. '&ChannelGuid=' .. TGuid
                               .. '&ComponentType=Filter&Page=OpenEditor&Module=main&SDindex='
                               .. i .. '">See this sample data in the Iguana Translator</a>'
      Rows[i] = {i, Results[i]['name'], Light, Link}
   end
   return {['aoColumns'] = Cols, ['aaData'] = Rows, ['Res'] = Results,
           ['aaSorting'] = {{2, 'desc'}}, ['bFilter'] = false,
           ['bInfo'] = false, ['bPaginate'] = false, ['Guid'] = Channel}
end

function regressions.app.die()
   spin.getSpinner(regressions.config.hosts):getNode('local'):reset()
   return {['status'] = "Sandboxes removed"}
end

------------
-- TEXT UTILITIES
------------

local LineEndings = {
   ['\n'] = '\\n',
   ['\r'] = '\\r'
}

function regressions.app.hideLineEnds(TheString) 
   if not TheString then 
      return nil 
   end
   TheString = string.gsub(TheString, '\\', '\\\\')
   for Real, Fake in pairs(LineEndings) do
      TheString = string.gsub(TheString, Real, Fake)
      TheString = string.gsub(TheString, Fake, ' <span class="line-end">' .. Fake .. '</span><br> ')
   end
   return TheString
end

function regressions.app.restoreLineEnds(TheString)
   if not TheString then 
      return nil 
   end
   for Real, Fake in pairs(LineEndings) do
      TheString = string.gsub(TheString, Real, '')
      TheString = string.gsub(TheString, Fake, Real)
   end
   TheString = string.gsub(TheString, '\\\\', '\\')
   return TheString
end

regressions.actions = {
   ['channels'] = regressions.app.loadChannels,
   ['run_tests'] = regressions.app.runTests,
   ['build'] = regressions.app.build,
   ['edit_result'] = regressions.app.editResult,
   ['die'] = regressions.app.die
}
