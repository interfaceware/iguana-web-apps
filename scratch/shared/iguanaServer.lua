-- $Revision: 1.2 $
-- $Date: 2013-11-28 17:58:09 $

--
-- The iguanaServer module
-- Copyright (c) 2011-2013 iNTERFACEWARE Inc. ALL RIGHTS RESERVED
-- iNTERFACEWARE permits you to use, modify, and distribute this file in accordance
-- with the terms of the iNTERFACEWARE license agreement accompanying the software
-- in which it is used.
--

--------------------------------------------------------------------------------
-- Parameter checking.
-- In all functions the parameter "Args" should be a table.
--------------------------------------------------------------------------------

local function checkParamTable(Arg, Optional)
   if Optional and Arg == nil then
      return {}
   end
   
   local ArgType = type(Arg)
   if ArgType ~= "table" then
      error("Parameter table expected, got " .. ArgType .. ".", 3)
   end
   
   return Arg
end

local function checkParam(Args, Name, ExpectedType, Optional, DefaultValue)
   local Arg = Args[Name]
   if Optional and Arg == nil then
      return DefaultValue
   end
   
   local ArgType = type(Arg)
   if ArgType ~= ExpectedType then
      error("Expected " .. ExpectedType .. ' for parameter "' .. Name ..
         '", got ' .. ArgType .. ".", 3)
   end
   
   return Arg
end

local function checkLiveParam(Args, Default)
   local Success, Result = pcall(checkParam, Args, "live", "boolean", true,
      Default)
   if not Success then
      error(Result, 3)
   end
   
   -- Ignore the result if the channel is running live.
   if not iguana.isTest() then
      return true
   end
   
   return Result
end

-- Parameter checking for variables with length values (strings, tables, etc.).
local function checkNonEmptyParam(Args, Name, ExpectedType, Optional)
   local Success, Result = pcall(checkParam, Args, Name, ExpectedType, Optional)
   if not Success then
      error(Result, 3)
   end
   
   if Result and #Result == 0 then
      error('Parameter "' .. Name .. '" must be nonempty.', 3)
   end
   
   return Result
end

-- Helper function for public calls that allow channels to be identified by name
-- or by GUID. The underlying web service calls that use these parameters will
-- give priority to channel GUIDs if both are specified since these are more
-- permanent than channel names.
local function checkForNameOrGuid(Args)
   local Success, Result, Guid = pcall(function()
         return checkNonEmptyParam(Args, "name", "string", true),
         checkNonEmptyParam(Args, "guid", "string", true)
      end)
   
   if not Success then
      error(Result, 3)
   end
   
   local Name = Result
   if not Name and not Guid then
      error('Parameter "name" or "guid" is required.', 3)
   end
   
   return Name, Guid
end

--------------------------------------------------------------------------------
-- Miscellaneous functions.
--------------------------------------------------------------------------------

-- NOTE: This may be better as a public function
-- of the connection object.
local function getCurrentVersion(Host)
   -- No authentication is needed to access this page.
   local Success, Result = pcall(net.http.get,
      {url=Host .. "/current_version", live=true})
   if not Success then
      error(Result, 3)
   end
   
   return json.parse(Result)
end

-- Doesn't copy tables with sub-tables... yet.
local function copyTable(Table, Iter)
   local Copy = {}
   
   for Key, Val in Iter(Table) do
      Copy[Key] = Val
   end
   
   return Copy
end

local NULL_GUID = '00000000000000000000000000000000'

local function getAttrValue(E, Attr)
   local A = (E and E[Attr]) or nil
   return (A and A:isLeaf() and A:nodeValue() ~= '' and A:nodeValue()) or nil
end

local function getTranslatorImpl(Component, GuidAttr, UseMostRecentAttr, MilestoneAttr)
   local Guid = getAttrValue(Component, GuidAttr)
   local UseMostRecent = getAttrValue(Component, UseMostRecentAttr) == 'true'
   local MilestoneName = getAttrValue(Component, MilestoneAttr)
   if Guid and Guid ~= NULL_GUID then
      local T = {['Guid']=Guid}
      if not UseMostRecent then
         T.Milestone = MilestoneName
      end
      return T
   else
      return nil
   end
end

local function getTranslator(OC, NC, Component, GuidAttr, UseMostRecentAttr, MilestoneAttr)
   local OldTrans, NewTrans =
      getTranslatorImpl(OC[Component], GuidAttr, UseMostRecentAttr, MilestoneAttr),
      getTranslatorImpl(NC[Component], GuidAttr, UseMostRecentAttr, MilestoneAttr)
   if OldTrans and NewTrans then
      return {old=OldTrans, new=NewTrans}
   else
      return nil
   end
end

local function addToProjectList(Projects, Pair)
   if Pair then
      Projects[#Projects+1] = Pair
   end
end

local function getTranslatorProjects(OldConfig, NewConfig)
   local Projects = {}
   local OC = OldConfig.channel
   local NC = NewConfig.channel
   
   -- Source component
   local Pair = 
      getTranslator(OC, NC, 'from_llp_listener', 'ack_script', 'ack_use_most_recent', 'ack_milestone') or
      getTranslator(OC, NC, 'from_mapper', 'guid', 'use_most_recent_milestone', 'milestone') or
      getTranslator(OC, NC, 'from_http', 'guid', 'use_most_recent_milestone', 'milestone')
   addToProjectList(Projects, Pair)
   
   -- Filter component
   Pair =
      getTranslator(OC, NC, 'message_filter', 'translator_guid', 'use_most_recent_milestone', 'translator_milestone')
   addToProjectList(Projects, Pair)
   
   -- Destination component
   Pair =
      getTranslator(OC, NC, 'to_mapper', 'guid', 'use_most_recent_milestone', 'milestone')
   addToProjectList(Projects, Pair)
   
   return Projects
end

--------------------------------------------------------------------------------
-- Help data definition.
--------------------------------------------------------------------------------

local ObjectHelp, ModuleHelp = {}, {}

-- To enable the use of auto-completion while editing the help data, require the
-- module from somewhere in your main() function instead of at the global scope.
if iguana.isTest() then
   -- Help data for server objects.
   local ListChannelsHelp = help.example()
   ListChannelsHelp.ParameterTable = true
   ListChannelsHelp.Title = "listChannels"
   ListChannelsHelp.Usage = "Server:listChannels{[live=&lt;boolean&gt;]} <b>or</b> Server:listChannels([&lt;boolean&gt;])"
   ListChannelsHelp.Desc = "Returns a XML report with information on the server itself and the channels within it."
   ListChannelsHelp.Parameters = {
      {live={Opt=true, Desc="If true, the function will be executed in the editor. Default is true. <u>boolean</u>"}}
   }
   ListChannelsHelp.Returns = {
      {Desc="The status of the server and the channels within it. <u>xml node tree</u>"}
   }
   ListChannelsHelp.Examples = {
[[-- Construct a list of the channel names in the server.
local Status = Server:listChannels{}.IguanaStatus
local ChannelNames = {}
for i=1, Status:childCount("Channel") do
   table.insert(ChannelNames, Status:child("Channel", i).Name)
end]]
   }
   ListChannelsHelp.SeeAlso = {}
   ObjectHelp.listChannels = ListChannelsHelp
   
   local GetChannelConfigHelp = help.example()
   GetChannelConfigHelp.SummaryLine = "Retrieves the configuration for a channel serialized as XML."
   GetChannelConfigHelp.ParameterTable = true
   GetChannelConfigHelp.Title = "getChannelConfig"
   GetChannelConfigHelp.Usage = "Server:getChannelConfig{name=&lt;string&gt; OR guid=&lt;string&gt; [, live=&lt;boolean&gt;]}"
   GetChannelConfigHelp.Desc = GetChannelConfigHelp.SummaryLine ..
      " This operation requires the user to have view permission for the channel."..
   [[<br><br><b>Note</b>: We recommend using the <b>guid</b> to identify a channel, because the <i>guid does not change when a channel is renamed</i>.]]
   GetChannelConfigHelp.Parameters = {
      {name={Desc="<i>alternative</i>: (name OR guid required) The name of the channel to view. <u>string</u>"}},
      {guid={Desc="<i>alternative</i>: (name OR guid required) The GUID of the channel to view. <u>string</u>"}},
      {live={Opt=true, Desc="If true, the function will be executed in the editor. Default is true. <u>boolean</u>"}}
   }
   GetChannelConfigHelp.Returns = {
      {Desc="The configuration of the specified channel. <u>xml node tree</u>"}
   }
   GetChannelConfigHelp.Examples = {
[[-- Get the configuration of the channel named "My Channel".
Server:getChannelConfig{name="My Channel"}]]
   }
   GetChannelConfigHelp.SeeAlso = {}
   ObjectHelp.getChannelConfig = GetChannelConfigHelp
   
   local RemoveChannelHelp = help.example()
   RemoveChannelHelp.SummaryLine = "Removes a channel from the Iguana server."
   RemoveChannelHelp.ParameterTable = true
   RemoveChannelHelp.Title = "removeChannel"
   RemoveChannelHelp.Usage = "Server:removeChannel{name=&lt;string&gt; OR guid=&lt;string&gt; [, live=&lt;boolean&gt;]}"
   RemoveChannelHelp.Desc = RemoveChannelHelp.SummaryLine ..
      " This operation requires the user to have administrator privileges."..
   [[<br><br><b>Note</b>: We recommend using the <b>guid</b> to identify a channel, because the <i>guid does not change when a channel is renamed</i>. ]]
   RemoveChannelHelp.Parameters = {
      {name={Desc="<i>alternative</i>: (name OR guid required) The name of the channel to remove. <u>string</u>"}},
      {guid={Desc="<i>alternative</i>: (name OR guid required) The GUID of the channel to remove. <u>string</u>"}},
      {live={Opt=true, Desc="If true, the function will be executed in the editor. Default is false. <u>boolean</u>"}}
   }
   RemoveChannelHelp.Returns = {
      {Desc="The configuration of the channel that was removed. <u>xml node tree</u>"}
   }
   RemoveChannelHelp.Examples = {
[[-- Remove a channel with a specific GUID.
Server:removeChannel{guid="2E89ECEDEBC53A7E6977DA1AB3F4E08C"}]],
[[-- An example where pcall() is used while removing the channel to log any errors
-- that occur.
local Success, Result = pcall(Server.removeChannel, Server, {name="My Channel"})
if not Success then
   iguana.logError(Result)
end]]
   }
   RemoveChannelHelp.SeeAlso = {}
   ObjectHelp.removeChannel = RemoveChannelHelp
   
   local VersionInfoHelp = help.example()
   VersionInfoHelp.SummaryLine = "Returns a table containing version information for the Iguana server."
   VersionInfoHelp.ParameterTable = false
   VersionInfoHelp.Title = "versionInfo"
   VersionInfoHelp.Usage = "Server:versionInfo()"
   VersionInfoHelp.Desc = VersionInfoHelp.SummaryLine ..
      " If the connection isn't live then the table will be empty."
   VersionInfoHelp.Parameters = {}
   VersionInfoHelp.Returns = {
      {Desc="Version information for the Iguana server. <u>table</u>"}
   }
   VersionInfoHelp.Examples = {
[[local Version = Server:versionInfo()
if Version.Major == 5 and Version.Minor == 6 then
   -- perform an operation on the server specific to this Iguana version
end]]
   }
   VersionInfoHelp.SeeAlso = {}
   ObjectHelp.versionInfo = VersionInfoHelp
   
   local StartChannelHelp = help.example()
   StartChannelHelp.SummaryLine = "Starts a channel in the Iguana server."
   StartChannelHelp.ParameterTable = true
   StartChannelHelp.Desc = StartChannelHelp.SummaryLine .. "<br><br>" ..
      "<b>Tip</b>: Starting channels is performed asynchronously, so to " ..
      "determine if the channel has been successfully started you will " ..
      "need to poll the status of the channel using the pollChannelStatus{} function."..
   [[<br><br><b>Note</b>: We recommend using the <b>guid</b> to identify a channel, because the <i>guid does not change when a channel is renamed</i>.]]
   StartChannelHelp.Title = "startChannel"
   StartChannelHelp.Usage = "Server:startChannel{name=&lt;string&gt; OR guid=&lt;string&gt; [, live=&lt;boolean&gt;]}"
   StartChannelHelp.Parameters = {
      {name={Desc="<i>alternative</i>: (name OR guid required) The name of the channel to start. <u>string</u>"}},
      {guid={Desc="<i>alternative</i>: (name OR guid required) The GUID of the channel to start. <u>string</u>"}},
      {live={Opt=true, Desc="If true, the function will be executed in the editor. Default is false. <u>boolean</u>"}}
   }
   StartChannelHelp.Returns = {
      {Desc="The status of the server and the channels within it. <u>xml node tree</u>"}
   }
   StartChannelHelp.Examples = {
[[Server:startChannel{name="My Channel"}]]
   }
   StartChannelHelp.SeeAlso = {}
   ObjectHelp.startChannel = StartChannelHelp
   
   local StopChannelHelp = help.example()
   StopChannelHelp.SummaryLine = "Stops a channel in the Iguana server."
   StopChannelHelp.ParameterTable = true
   StopChannelHelp.Desc = StopChannelHelp.SummaryLine .. "<br><br>" ..
      "<b>Tip</b>: Stopping channels is performed asynchronously, so to " ..
      "determine if the channel has been successfully stopped you will " ..
      "need to poll the status of the channel using the pollChannelStatus{} function."..
   [[<br><br><b>Note</b>: We recommend using the <b>guid</b> to identify a channel, because the <i>guid does not change when a channel is renamed</i>.]]
   StopChannelHelp.Title = "stopChannel"
   StopChannelHelp.Usage = "Server:stopChannel{name=&lt;string&gt; OR guid=&lt;string&gt; [, live=&lt;boolean&gt;]}"
   StopChannelHelp.Parameters = {
      {name={Desc="<i>alternative</i>: (name OR guid required) The name of the channel to stop. <u>string</u>"}},
      {guid={Desc="<i>alternative</i>: (name OR guid required) The GUID of the channel to stop. <u>string</u>"}},
      {live={Opt=true, Desc="If true, the function will be executed in the editor. Default is false. <u>boolean</u>"}}
   }
   StopChannelHelp.Returns = {
      {Desc="The status of the server and the channels within it. <u>xml node tree</u>"}
   }
   StopChannelHelp.Examples = {
[[Server:stopChannel{name="My Channel"}]]
   }
   StopChannelHelp.SeeAlso = {}
   ObjectHelp.stopChannel = StopChannelHelp
   
   local StartAllChannelsHelp = help.example()
   StartAllChannelsHelp.SummaryLine = "Starts all channels in the Iguana server."
   StartAllChannelsHelp.ParameterTable = true
   StartAllChannelsHelp.Desc = StartAllChannelsHelp.SummaryLine .. "<br><br>" ..
      "<b>Tip</b>: Starting channels is performed asynchronously, so to " ..
      "determine if the channels have been successfully started you will need " ..
      "need to poll the status of each channel using the pollChannelStatus{} function."
   StartAllChannelsHelp.Title = "startAllChannels"
   StartAllChannelsHelp.Usage = "Server:startAllChannels{[live=&lt;boolean&gt;]} <b>or</b> Server:startAllChannels([&lt;boolean&gt;])"
   StartAllChannelsHelp.Parameters = {
      {live={Opt=true, Desc="If true, the function will be executed in the editor. Default is false. <u>boolean</u>"}}
   }
   StartAllChannelsHelp.Returns = {
      {Desc="The status of the server and the channels within it. <u>xml node tree</u>"}
   }
   StartAllChannelsHelp.Examples = {
[[Server:startAllChannels()]]
   }
   StartAllChannelsHelp.SeeAlso = {}
   ObjectHelp.startAllChannels = StartAllChannelsHelp
   
   local StopAllChannelsHelp = help.example()
   StopAllChannelsHelp.SummaryLine = "Stops all channels in the Iguana server."
   StopAllChannelsHelp.ParameterTable = true
   StopAllChannelsHelp.Desc = StopAllChannelsHelp.SummaryLine .. "<br><br>" ..
      "<b>Tip</b>: Stopping channels is performed asynchronously, so to " ..
      "determine if the channels have been successfully stopped you will need " ..
      "need to poll the status of each channel using the pollChannelStatus{} function."
   StopAllChannelsHelp.Title = "stopAllChannels"
   StopAllChannelsHelp.Usage = "Server:stopAllChannels{[live=&lt;boolean&gt;]} <b>or</b> Server:stopAllChannels([&lt;boolean&gt;])"
   StopAllChannelsHelp.Parameters = {
      {live={Opt=true, Desc="If true, the function will be executed in the editor. Default is false. <u>boolean</u>"}}
   }
   StopAllChannelsHelp.Returns = {
      {Desc="The status of the server and the channels within it. <u>xml node tree</u>"}
   }
   StopAllChannelsHelp.Examples = {
[[Server:stopAllChannels()]]
   }
   StopAllChannelsHelp.SeeAlso = {}
   ObjectHelp.stopAllChannels = StopAllChannelsHelp
   
   local GetDefaultConfigHelp = help.example()
   GetDefaultConfigHelp.SummaryLine = "Returns the default configuration for a channel with the specified components."
   GetDefaultConfigHelp.ParameterTable = true
   GetDefaultConfigHelp.Title = "getDefaultConfig"
   GetDefaultConfigHelp.Usage = "Server:getDefaultConfig{source=&lt;string&gt;, destination=&lt;string&gt; [, live=&lt;boolean&gt;]}"
   GetDefaultConfigHelp.Desc = GetDefaultConfigHelp.SummaryLine ..
      " You can use the constants provided by the iguanaServer module to specify the component types.<br><br>" ..
      "This function can be used in conjunction with addChannel{} to add new channels to an Iguana server."
   GetDefaultConfigHelp.Parameters = {
      {source={Desc="The source component type for the channel. <u>string</u>"}},
      {destination={Desc="The destination component type for the channel. <u>string</u>"}},
      {live={Opt=true, Desc="If true, the function will be executed in the editor. Default is true. <u>boolean</u>"}}
   }
   GetDefaultConfigHelp.Returns = {
      {Desc="The default configuration for a channel with the specified components. <u>xml node tree</u>"}
   }
   GetDefaultConfigHelp.Examples = {
[[-- Retrieve the default configuration for a LLP Listener -> To Translator
-- channel and increment the port number in the source component by one.
local Config = Server:getDefaultConfig{
   source=iguanaServer.LLP_LISTENER,
   destination=iguanaServer.TO_TRANSLATOR
}
local Port = Config.channel.from_llp_listener.port
Port:setInner(Port:nodeValue() + 1)]]
   }
   GetDefaultConfigHelp.SeeAlso = {}
   ObjectHelp.getDefaultConfig = GetDefaultConfigHelp
   
   local AddChannelHelp = help.example()
   AddChannelHelp.SummaryLine = "Adds a new channel to the Iguana server."
   AddChannelHelp.ParameterTable = true
   AddChannelHelp.Title = "addChannel"
   AddChannelHelp.Usage = "Server:addChannel{config=&lt;xml node tree&gt; [, source_password=&lt;string&gt;] [, destination_password=&lt;string&gt;] [, salt=&lt;string&gt;] [, live=&lt;boolean&gt;]}<br>" ..
      "   <b>or</b> Server:addChannel(&lt;xml node tree&gt;)"
   AddChannelHelp.Desc = AddChannelHelp.SummaryLine ..
      " The channel added must have a unique name. This operation requires the user to have administrator privileges."
   AddChannelHelp.Parameters = {
      {config={Desc="The configuration for the new channel. <u>xml node tree</u>"}},
      {source_password={Opt=true, Desc="The password for the source component. Only applicable to channels with a From File or From Database component. <u>string</u>"}},
      {destination_password={Opt=true, Desc="The password for the destination component. Only applicable to channels with a To File or To Database component. <u>string</u>"}},
      {salt={Opt=true, Desc="A value used to re-encrypt the passwords in certain component types. Useful when cloning channels between servers to prevent passwords from becoming invalid. <u>string</u>"}},
      {live={Opt=true, Desc="If true, the function will be executed in the editor. Default is false. <u>boolean</u>"}}
   }
   AddChannelHelp.Returns = {
      {Desc="The configuration of the newly added channel. <u>xml node tree</u>"}
   }
   AddChannelHelp.Examples = {
[[-- Add a new LLP Listener -> To Translator channel with
-- the default configuration.
local Config = Server:getDefaultConfig{
   source=iguanaServer.LLP_LISTENER,
   destination=iguanaServer.TO_TRANSLATOR
}
Config.channel.name = "My Channel"
Server:addChannel(Config)]],
[[-- Clone a channel within the same server and give it a unique name.
local Config = Server:getChannelConfig{name="My Channel"}.channel
Config.name = Config.name .. " (Clone)"
Server:addChannel(Config)]]
   }
   AddChannelHelp.SeeAlso = {}
   ObjectHelp.addChannel = AddChannelHelp
   
   local PollChannelStatusHelp = help.example()
   PollChannelStatusHelp.SummaryLine = "Continuously polls the server until the specified channel reaches a particular status, " ..
      "or until the number of retries is exceeded."
   PollChannelStatusHelp.ParameterTable = true
   PollChannelStatusHelp.Title = "pollChannelStatus"
   PollChannelStatusHelp.Usage = "Server:pollChannelStatus{name=&lt;string&gt; OR guid=&lt;string&gt;, channel_status=&lt;string&gt;<br>" ..
      "   [, num_retries=&lt;number&gt;] [, interval=&lt;number&gt;] [, status=&lt;xml node tree&gt;] [, live=&lt;boolean&gt;]}"
   PollChannelStatusHelp.Desc = PollChannelStatusHelp.SummaryLine ..
      " This is useful when starting or stopping channels since these are asynchronous operations and may not take effect right away.<br><br>" ..
      'There are constants defined in the iguanaServer module that can be used for the "channel_status" parameter.'..
[[<br><br><b>Note</b>: We recommend using the <b>guid</b> to identify a channel, because the <i>guid does not change when a channel is renamed</i>.]]
   PollChannelStatusHelp.Parameters = {
      {name={Desc="<i>alternative</i>: (name OR guid required) The name of the channel to poll for a status change. <u>string</u>"}},
      {guid={Desc="<i>alternative</i>: (name OR guid required) The GUID of the channel to poll for a status change. <u>string</u>"}},
      {channel_status={Desc='The status of the channel to poll until. Can be either "on" or "off". <u>string</u>'}},
      {num_retries={Opt=true, Desc="The number of times to poll the server before returning. Default is 10. <u>number</u>"}},
      {interval={Opt=true, Desc="The length of time to sleep between poll attempts. Default is 100 milliseconds. <u>number</u>"}},
      {status={Opt=true, Desc="The status of the Iguana server returned from a previous function call, such as listChannels(), startChannel{}, etc. " ..
            "If this argument is given then it will be checked first for the desired status before sending any additional network requests. <u>xml node tree</u>"}},
      {live={Opt=true, Desc="If true, the function will be executed in the editor. Default is true. <u>boolean</u>"}}
   }
   PollChannelStatusHelp.Returns = {
      {Desc="True if the specified channel reached the desired status within the alloted number of retry attempts, false otherwise. " ..
         'This function always returns true when "live" has been set to false. <u>boolean</u>'},
      {Desc="The last viewed status of the channel, if the first return value is false. <u>string</u>"}
   }
   PollChannelStatusHelp.Examples = {
[[-- Wait for the channel to reach the "on" status after issuing a start request.
-- Notice how the return value of startChannel{} is passed in as an argument
-- to pollChannelStatus{}. Some types of channels start immediately, which will
-- alleviate the need to send any additional network requests in pollChannelStatus{}.
local Name = "My Channel"
local Status = Server:startChannel{name=Name}
Server:pollChannelStatus{name=Name, channel_status=iguanaServer.CHANNEL_ON,
   status=Status}]]
   }
   PollChannelStatusHelp.SeeAlso = {}
   ObjectHelp.pollChannelStatus = PollChannelStatusHelp
   
   local CloneChannelHelp = help.example()
   CloneChannelHelp.SummaryLine = "Clones a channel within the same Iguana server or to a remote one."
   CloneChannelHelp.ParameterTable = true
   CloneChannelHelp.Title = "cloneChannel"
   CloneChannelHelp.Usage = "Server:cloneChannel{name=&lt;string&gt; OR guid=&lt;string&gt; [, other=&lt;Iguana server object&gt;]<br>" ..
      "   [, new_name=&lt;string&gt;] [, configurator=&lt;function&gt;] [, live=&lt;boolean&gt;]}"
   CloneChannelHelp.Desc = CloneChannelHelp.SummaryLine ..
      [[ The "configurator" parameter can be used to make modifications to the configuration of the new channel before it gets added.<br><br>
<b>Note</b>: We recommend using the <b>guid</b> to identify a channel, because the <i>guid does not change when a channel is renamed</i>.]]
   CloneChannelHelp.Parameters = {
      {name={Desc="<i>alternative</i>: (name OR guid required) The name of the channel to clone. <u>string</u>"}},
      {guid={Desc="<i>alternative</i>: (name OR guid required) The GUID of the channel to clone. <u>string</u>"}},
      {other={Opt=true, Desc="The Iguana server to clone the channel to. If this is left unspecified then the clone will be made locally. <u>Iguana server object</u>"}},
      {new_name={Opt=true, Desc="The new name to use for the channel. If the clone is being made locally then this parameter is required, " ..
            "since the channel would be invalid otherwise. <u>string</u>"}},
      {configurator={Opt=true, Desc="A function that accepts the XML configuration for the channel being cloned as an argument. <u>function</u>"}},
      {sample_data={Opt=true, Desc="Specifies how sample data will be cloned from the channel's Translator project(s). Should be \"append\", \"replace\", or unspecified (meaning sample data will not be cloned). <u>string</u>"}},
      {live={Opt=true, Desc="If true, the function will be executed in the editor. Default is false. <u>boolean</u>"}}
   }
   CloneChannelHelp.Returns = {
      {Desc="The configuration of the newly added channel. <u>xml node tree</u>"}
   }
   CloneChannelHelp.Examples = {
[[-- Simple example whereby a channel is cloned locally and no changes are made
-- to the configuration for the new channel (except for the name).
Server:cloneChannel{name="My Channel", new_name="My Other Channel"}]],
[[-- A more advanced example where the channel is cloned to a remote server and changes
-- are made to the new channel's configuration using the "configurator" function.
-- Assume that the variable Remote is an Iguana server object returned by
-- iguanaServer.connect{} and that "My Channel" has a LLP Listener source component.
-- Notice how the anonymous "configurator" function is able to access variables
-- within its closure (e.g. the PortNum variable).
local PortNum = 5350
Server:cloneChannel{name="My Channel", other=Remote, sample_data="replace", configurator=function(Config)
      Config.channel.from_llp_listener.port = PortNum
   end}]]
   }
   CloneChannelHelp.SeeAlso = {}
   ObjectHelp.cloneChannel = CloneChannelHelp
   
   local GetServerSaltHelp = help.example()
   GetServerSaltHelp.SummaryLine = "Retrieves the salt used by the Iguana server for encryption purposes."
   GetServerSaltHelp.ParameterTable = true
   GetServerSaltHelp.Title = "getServerSalt"
   GetServerSaltHelp.Usage = "Server:getServerSalt{[live=&lt;boolean&gt;]} <b>or</b> Server:getServerSalt([&lt;boolean&gt;])"
   GetServerSaltHelp.Desc = GetServerSaltHelp.SummaryLine ..
      " The main use for this function is to preserve password settings when cloning channels between different servers with certain component types." ..
      " The component types concerned are From/To Database and From/To File."
   GetServerSaltHelp.Parameters = {
      {live={Opt=true, Desc="If true, the function will be executed in the editor. Default is true. <u>boolean</u>"}}
   }
   GetServerSaltHelp.Returns = {
      {Desc="The salt used by the server for encryption. <u>string</u>"}
   }
   GetServerSaltHelp.Examples = {
[[-- Showing how the salt can be used when cloning a channel to different server.
-- Assume that "My Channel" has at least one component with the relevant
-- password settings.
local Config = Server:getChannelConfig{name="My Channel"}
local Salt = Server:getServerSalt()
Remote:addChannel{config=Config, salt=Salt}]]
   }
   GetServerSaltHelp.SeeAlso = {}
   ObjectHelp.getServerSalt = GetServerSaltHelp
   
   local UpdateChannelHelp = help.example()
   UpdateChannelHelp.SummaryLine = "Updates the configuration of an existing channel."
   UpdateChannelHelp.ParameterTable = true
   UpdateChannelHelp.Title = "updateChannel"
   UpdateChannelHelp.Usage = "Server:updateChannel{config=&lt;xml node tree&gt; [, source_password=&lt;string&gt;] [, destination_password=&lt;string&gt;] [, live=&lt;boolean&gt;]}<br>" ..
      "   <b>or</b> Server:updateChannel(&lt;xml node tree&gt;)"
   UpdateChannelHelp.Desc = UpdateChannelHelp.SummaryLine ..
      " This can be used in conjunction with getChannelConfig{}, by first retrieving the configuration for the channel and then modifying it before being passed into this function.<br><br>" ..
      "This operation requires the channel to be stopped before being updated. The user must also have edit permission for the channel."
   UpdateChannelHelp.Parameters = {
      {config={Desc="The configuration to update the channel with. <u>xml node tree</u>"}},
      {source_password={Opt=true, Desc="The password for the source component. Only applicable to channels with a From File or From Database component. <u>string</u>"}},
      {destination_password={Opt=true, Desc="The password for the destination component. Only applicable to channels with a To File or To Database component. <u>string</u>"}},
      {live={Opt=true, Desc="If true, the function will be executed in the editor. Default is false. <u>boolean</u>"}}
   }
   UpdateChannelHelp.Returns = {
      {Desc="The configuration of the updated channel. <u>xml node tree</u>"}
   }
   UpdateChannelHelp.Examples = {
[[-- Enable the usage of the Filter in an existing channel.
local Config = Server:getChannelConfig{name="My Channel"}
Config.channel.use_message_filter = "true"
Server:updateChannel(Config)]]
   }
   UpdateChannelHelp.SeeAlso = {}
   ObjectHelp.updateChannel = UpdateChannelHelp
   
   -- exportProject()
   local ExportProjectHelp = help.example()
   ExportProjectHelp.SummaryLine = "Retrieves a zip file containing the contents of a Translator project."
   ExportProjectHelp.ParameterTable = true
   ExportProjectHelp.Title = "exportProject"
   ExportProjectHelp.Usage = "Server:exportProject{guid=&lt;string&gt; [, milestone_name=&lt;string&gt;] [, sample_data=&lt;boolean&gt;] [, destination_file=&lt;string&gt;] [, live=&lt;boolean&gt;]}<br>"..
      "<b>or</b> Server:exportProject(&lt;string&gt;)"
   ExportProjectHelp.Desc = ExportProjectHelp.SummaryLine ..
      " The function can return the base64-encoded contents of the zip file, or write the file out to disk."
   ExportProjectHelp.Parameters = {
      {guid={Desc="The GUID of the Translator project to export. <u>string</u>"}},
      {milestone_name={Opt=true, Desc="The name of the milestone to export. Default is the project's most recent milestone. <u>string</u>"}},
      {sample_data={Opt=true, Desc="If false, sample data will be excluded from the project zip. Default is true. <u>boolean</u>"}},
      {destination_file={Opt=true, Desc="If present, project zip will be written out to this specified location. <u>string</u>"}},
      {live={Opt=true, Desc="If true, the function will be executed in the editor. Default is true. <u>boolean</u>"}}
   }
   ExportProjectHelp.Returns = {
      {Desc="The base64-encoded contents of the project zip file, <b>or</b> the path to which the zip file was written if destination_file was provided."}
   }
   ExportProjectHelp.Examples = {
[[-- Download the project to &lt;Guid&gt;.zip.
-- Alternatively omit the destination_file parameter to simply get the
-- base64-encoded contents of the zip file.
Server:exportProject{guid=Guid, sample_data=true, destination_file=Guid..'.zip'}]]
   }
   ExportProjectHelp.SeeAlso = {}
   ObjectHelp.exportProject = ExportProjectHelp
   
   -- importProject()
   local ImportProjectHelp = help.example()
   ImportProjectHelp.SummaryLine = "Sets the contents of a Translator project to the contents of a project zip file."
   ImportProjectHelp.ParameterTable = true
   ImportProjectHelp.Title = "importProject"
   ImportProjectHelp.Usage = "Server:importProject{guid=&lt;string&gt; [, source_file=&lt;string&gt;] [, project=&lt;string&gt;] [, sample_data=&lt;string&gt;] [, live=&lt;boolean&gt;]}"
   ImportProjectHelp.Desc = ImportProjectHelp.SummaryLine ..
      " The function can accept the base64-encoded contents of the zip file, or read the file from disk."
   ImportProjectHelp.Parameters = {
      {guid={Desc="The GUID of the Translator project to import to. <u>string</u>"}},
      {project={Opt=true, Desc="Base64-encoded project zip file contents. <u>string</u>"}},
      {source_file={Opt=true, Desc="Location of the project zip file on disk. <u>string</u>"}},
      {sample_data={Opt=true, Desc="Should be \"append\", \"replace\", or unspecified (meaning sample data will not be included). <u>string</u>"}},
      {live={Opt=true, Desc="If true, the function will be executed in the editor. Default is false. <u>boolean</u>"}}
   }
   ImportProjectHelp.Returns = {
      {Desc="The GUID of the Translator project into which the zip file was imported."}
   }
   ImportProjectHelp.Examples = {
[[-- Import a base64-encoded zip file (as received from exportProject()).
Server:importProject{guid=DestGuid, project=B64Proj, sample_data='replace', live=true}
-- or, import from a zip file on disk.
Server:importProject(guid=DestGuid, source_file='my_template.zip', sample_data='replace', live=true}]]
   }
   ImportProjectHelp.SeeAlso = {}
   ObjectHelp.importProject = ImportProjectHelp
   
   -- saveProjectMilestone()
   local SaveProjectMilestoneHelp = help.example()
   SaveProjectMilestoneHelp.SummaryLine = "Saves a milestone for the specified Translator project."
   SaveProjectMilestoneHelp.ParameterTable = true
   SaveProjectMilestoneHelp.Title = "saveProjectMilestone"
   SaveProjectMilestoneHelp.Usage = "Server:saveProjectMilestone{guid=&lt;string&gt; milestone_name=&lt;string&gt;}"
   SaveProjectMilestoneHelp.Desc = SaveProjectMilestoneHelp.SummaryLine
   SaveProjectMilestoneHelp.Parameters = {
      {guid={Desc="The GUID of the Translator project. <u>string</u>"}},
      {milestone_name={Desc="The name of the milestone. <u>string</u>"}},
      {live={Opt=true, Desc="If true, the function will be executed in the editor. Default is false. <u>boolean</u>"}}
   }
   SaveProjectMilestoneHelp.Returns = {
      {Desc="The name of the milestone that was saved."}
   }
   SaveProjectMilestoneHelp.Examples = {
[[local Now = tostring(os.time())
Server:saveProjectMilestone{guid=DestGuid, milestone_name=Now..' - imported', live=true}]]
   }
   SaveProjectMilestoneHelp.SeeAlso = {}
   ObjectHelp.saveProjectMilestone = SaveProjectMilestoneHelp
   
   -- updateProject()
   local UpdateProjectHelp = help.example()
   UpdateProjectHelp.SummaryLine = "Copies a source Translator project to a destination Translator project."
   UpdateProjectHelp.ParameterTable = true
   UpdateProjectHelp.Title = "updateProject"
   UpdateProjectHelp.Usage = "Server:updateProject{source_guid=&lt;string&gt;, destination_guid=&lt;string&gt;, new_milestone_name=&lt;string&gt; [, source_milestone_name=&lt;string&gt;] [, sample_data=&lt;string&gt;], [, live=&lt;boolean&gt;]}"
   UpdateProjectHelp.Desc = UpdateProjectHelp.SummaryLine ..
      " The function will read a specific milestone from the source project, and save a new milestone for the destination project."..
      " The destination project can be local or remote (specified through the \"other\" parameter)."
   UpdateProjectHelp.Parameters = {
      {source_guid={Desc="The GUID of the source Translator project. <u>string</u>"}},
      {destination_guid={Desc="The GUID of the destination Translator project. <u>string</u>"}},
      {new_milestone_name={Desc="The name of the new milestone for the destination Transaltor project. <u>string</u>"}},
      {other={Opt=true, Desc="The Iguana server to on which the destination Translator project is found. If this is left unspecified then the update will be performed locally. <u>Iguana server object</u>"}},
      {source_milestone_name={Opt=true, Desc="The name of the milestone to export from the source Translator project. <u>string</u>"}},
      {sample_data={Opt=true, Desc="Should be \"append\", \"replace\", or unspecified (meaning sample data will not be included). <u>string</u>"}},
      {live={Opt=true, Desc="If true, the function will be executed in the editor. Default is false. <u>boolean</u>"}}
   }
   UpdateProjectHelp.Returns = {
      {Desc="The name of the milestone that was saved."}
   }
   UpdateProjectHelp.Examples = {
[[local Now = tostring(os.time())
Server:updateProject{
   source_guid=SourceGuid,
   destination_guid=DestGuid,
   new_milestone_name=Now..' - imported',
   sample_data='replace'
}]]
   }
   UpdateProjectHelp.SeeAlso = {}
   ObjectHelp.updateProject = UpdateProjectHelp
   
   -- isLive()
   local IsLiveHelp = help.example()
   IsLiveHelp.SummaryLine = "Returns true if the connection to the Iguana server is \"live\"."
   IsLiveHelp.ParameterTable = false
   IsLiveHelp.Title = "isLive"
   IsLiveHelp.Usage = "Server:isLive()"
   IsLiveHelp.Desc = IsLiveHelp.SummaryLine ..
      " This is set in iguanaServer.connect()."
   IsLiveHelp.Parameters = {}
   IsLiveHelp.Returns = {
      {Desc="true if the connection is live, false otherwise. <u>boolean</u>"}
   }
   IsLiveHelp.Examples = {
[[Server:cloneChannel{name="My Channel", new_name="My Other Channel"}
if Server:isLive() then
   print("\"My Other Channel\" successfully created.")
end]]
   }
   IsLiveHelp.SeeAlso = {}
   ObjectHelp.isLive = IsLiveHelp
   
   
   -- Help data for the module.
   local ConnectHelp = help.example()
   ConnectHelp.SummaryLine = "Connects to an Iguana server."
   ConnectHelp.ParameterTable = true
   ConnectHelp.Title = "connect"
   ConnectHelp.Usage = "iguanaServer.connect{url=&lt;string&gt;, username=&lt;string&gt;, password=&lt;string&gt; [, live=&lt;boolean&gt;]}"
   ConnectHelp.Desc = ConnectHelp.SummaryLine ..
      " This function returns an object that can be used to perform operations on the server's channels. " ..
      "The colon operator should be used to make method calls on the object, e.g. Server:functionName(Args)."
   ConnectHelp.Parameters = {
      {url={Desc="The URL of the Iguana server. <u>string</u>"}},
      {username={Desc="The name of the user to login as. <u>string</u>"}},
      {password={Desc="The password of the user to login as. <u>string</u>"}},
      {live={Opt=true, Desc="If true, the function will be executed in the editor. Default is true. " ..
            "If this is set to false then none of the operations performed on the object will be executed in the editor. <u>boolean</u>"}}
   }
   ConnectHelp.Returns = {
      {Desc="A connection to the specified Iguana server. <u>Iguana server object</u>"}
   }
   ConnectHelp.Examples = {
[[local Server = iguanaServer.connect{
   url="localhost:6543",
   username="admin",
   password="password"
}]]
   }
   ConnectHelp.SeeAlso = {}
   ModuleHelp.connect = ConnectHelp
   
   local CloneXmlNodeHelp = help.example()
   CloneXmlNodeHelp.SummaryLine = "Utility function for cloning specific types of XML nodes."
   CloneXmlNodeHelp.ParameterTable = true
   CloneXmlNodeHelp.Title = "cloneXmlNode"
   CloneXmlNodeHelp.Usage = "iguanaServer.cloneXmlNode{source=&lt;xml node tree&gt;, dest=&lt;xml node tree&gt;}"
   CloneXmlNodeHelp.Desc = CloneXmlNodeHelp.SummaryLine ..
      " This is useful for configuring certain channel settings.<br><br>" ..
      "The default implementation of this function will only clone XML elements with attributes for child nodes. " ..
      "Most of the XML nodes in the responses sent back by the various channel API request handlers adhere to this structure."
   CloneXmlNodeHelp.Parameters = {
      {source={Desc="The node to clone. <u>xml node tree</u>"}},
      {dest={Desc="The node to append the new node to. <u>xml node tree</u>"}}
   }
   CloneXmlNodeHelp.Returns = {
      {Desc="The new node that was made. <u>xml node tree</u>"}
   }
   CloneXmlNodeHelp.Examples = {
[[-- Below we show how you can use this function to configure the sources for a
-- a channel with a From Channel source component. Note that the sources are
-- actually stored in the configuration for the destination component, rather
-- than the From Channel component.
local Config = Server:getDefaultConfig{source=iguanaServer.FROM_CHANNEL,
   destination=iguanaServer.LLP_CLIENT}
local DequeueList = Config.channel.to_llp_client.dequeue_list
local Dequeue = DequeueList.dequeue
Dequeue.source_name = "Channel 1"
-- Now clone this node to configure the second source channel.
Dequeue = iguanaServer.cloneXmlNode{source=Dequeue, dest=DequeueList}
Dequeue.source_name = "Channel 2"]]
   }
   CloneXmlNodeHelp.SeeAlso = {}
   ModuleHelp.cloneXmlNode = CloneXmlNodeHelp
end

local function setHelpData(Table, HelpData)
   for Name, Func in pairs(Table) do
      if HelpData[Name] then
         help.set{input_function=Func, help_data=HelpData[Name]}
      end
   end
end

--------------------------------------------------------------------------------
-- Public API.
--------------------------------------------------------------------------------

iguanaServer = {}

-- Constants for component types passed to the getDefaultConfig{} function.
iguanaServer.LLP_LISTENER = "LLP Listener"
iguanaServer.FROM_DATABASE = "From Database"
iguanaServer.FROM_FILE = "From File"
iguanaServer.FROM_PLUGIN = "From Plugin"
iguanaServer.FROM_HTTPS = "From HTTPS"
iguanaServer.FROM_CHANNEL = "From Channel"
iguanaServer.FROM_TRANSLATOR = "From Translator"
iguanaServer.TO_TRANSLATOR = "To Translator"
iguanaServer.TO_DATABASE = "To Database"
iguanaServer.LLP_CLIENT = "LLP Client"
iguanaServer.TO_FILE = "To File"
iguanaServer.TO_PLUGIN = "To Plugin"
iguanaServer.TO_HTTPS = "To HTTPS"
iguanaServer.TO_CHANNEL = "To Channel"

-- Constants for the various Status values that a channel can have in the
-- response to a /status request.
iguanaServer.CHANNEL_ON = "on"
iguanaServer.CHANNEL_OFF = "off"
iguanaServer.CHANNEL_STARTING = "..." -- corresponds to the "yellow light" state
iguanaServer.CHANNEL_ERROR = "error"

-- This function stores the instance variables for the server object in a
-- closure as a form of information hiding. If access to these variables is
-- really needed after instantiating the object then it would be trivial to
-- write appropriate getter/setter functions.
function iguanaServer.connect(Args)
   checkParamTable(Args)
   
   -- Private variables.
   local Data = {}
   Data.Url = checkParam(Args, "url", "string")
   Data.Username = checkParam(Args, "username", "string")
   Data.Password = checkParam(Args, "password", "string")
   Data.Live = checkLiveParam(Args, true)
   
   -- Holds references to the various functions that can be called on the object.
   local Obj = {}
   
   -- Helper functions.
   
   -- Should be the first call made in any public function to enforce the
   -- object-oriented style of parameter passing.
   local function checkSelfParam(self)
      if self ~= Obj then
         error('Implicit "self" parameter is not equal to object table.\n' ..
            "Try calling the function using colon syntax (e.g. Server:funcName()).", 3)
      end
   end
   
   -- Makes a request to a handler in the channel API.
   local function makeApiRequest(Handler, Params, Live, HttpMethod)
      HttpMethod = HttpMethod or net.http.get
      
      local Success, Result, Status = pcall(HttpMethod, {
            url=Data.Url .. Handler,
            parameters = Params,
            auth={username=Data.Username, password=Data.Password},
            live=Data.Live and Live
         })
      trace(Success)
      if not Success or Status >= 400 then
         error(Result, 3)
      end
      
      return Result
   end
   
   -- We will only attempt to connect to the server if live is set to true.
   if Data.Live then
      -- First attempt to get the version information for the server. An error
      -- will be thrown if the hostname is invalid.
      Data.Version = getCurrentVersion(Data.Url)
      
      if Data.Version.Major < 5 or
         Data.Version.Major == 5 and Data.Version.Minor < 6 then
         error("iguanaServer only supports operations on Iguana instances version 5.6 and up", 2)
      end
      
      -- Next send a dummy request to the /status handler to validate the login
      -- info given.
      makeApiRequest("/status", {}, true)
   end
   
   -- Public functions.
   -- Using colon syntax for the function definitions here isn't strictly
   -- necessary because instance variables are held in the closure for the
   -- connect{} function rather than the implicit "self" paramater. But we do so
   -- anyway because this is the style that is most commonly used for object
   -- methods. Note that you can also call functions using regular dot syntax so
   -- long as you pass in the object table for the first parameter
   -- (e.g. Server.funcName(Server)).
   
   function Obj:listChannels(Args)
      checkSelfParam(self)
      if type(Args) == "boolean" then
         Args = {live=Args}
      else
         Args = checkParamTable(Args, true)
      end
      local Live = checkLiveParam(Args, true)
      
      return xml.parse(makeApiRequest("/status", {}, Live))
   end
   
   function Obj:getChannelConfig(Args)
      checkSelfParam(self)
      checkParamTable(Args)
      local Name, Guid = checkForNameOrGuid(Args)
      local Live = checkLiveParam(Args, true)
      
      -- For debugging purposes you may want to remove the compact="true"
      -- parameter if you need to inspect the raw XML directly.
      return xml.parse(makeApiRequest("/get_channel_config",
            {name=Name, guid=Guid, compact="true"},
            Live))
   end
   
   function Obj:removeChannel(Args)
      checkSelfParam(self)
      checkParamTable(Args)
      local Name, Guid = checkForNameOrGuid(Args)
      local Live = checkLiveParam(Args, false)
      
      return xml.parse(makeApiRequest("/remove_channel",
            {name=Name, guid=Guid, compact="true"},
            Live, net.http.post))
   end
   
   -- NOTE: There isn't a live parameter for this function because if the version
   -- info isn't available already then this means that the server object is
   -- non-live, in which case a live value here wouldn't make a difference.
   function Obj:versionInfo()
      checkSelfParam(self)
      -- Returns a copy of the Version table so that it can't be modified
      -- outside the module.
      return copyTable(Data.Version or {}, pairs)
   end
   
   function Obj:startChannel(Args)
      checkSelfParam(self)
      checkParamTable(Args)
      local Name, Guid = checkForNameOrGuid(Args)
      local Live = checkLiveParam(Args, false)
      
      return xml.parse(makeApiRequest("/status",
            {name=Name, guid=Guid, action="start"},
            Live, net.http.post))
   end
   
   function Obj:stopChannel(Args)
      checkSelfParam(self)
      checkParamTable(Args)
      local Name, Guid = checkForNameOrGuid(Args)
      local Live = checkLiveParam(Args, false)
      
      return xml.parse(makeApiRequest("/status",
            {name=Name, guid=Guid, action="stop"},
            Live, net.http.post))
   end
   
   function Obj:startAllChannels(Args)
      checkSelfParam(self)
      if type(Args) == "boolean" then
         Args = {live=Args}
      else
         Args = checkParamTable(Args, true)
      end
      local Live = checkLiveParam(Args, false)
      
      return xml.parse(makeApiRequest("/status", {action="startall"}, Live,
            net.http.post))
   end
   
   function Obj:stopAllChannels(Args)
      checkSelfParam(self)
      if type(Args) == "boolean" then
         Args = {live=Args}
      else
         Args = checkParamTable(Args, true)
      end
      local Live = checkLiveParam(Args, false)
      
      return xml.parse(makeApiRequest("/status", {action="stopall"}, Live,
            net.http.post))
   end
   
   function Obj:getDefaultConfig(Args)
      checkSelfParam(self)
      checkParamTable(Args)
      local Source = checkNonEmptyParam(Args, "source", "string")
      local Destination = checkNonEmptyParam(Args, "destination", "string")
      local Live = checkLiveParam(Args, true)
      
      return xml.parse(makeApiRequest("/get_default_config",
            {source=Source, destination=Destination, compact="true"},
            Live))
   end
   
   function Obj:addChannel(Args)
      checkSelfParam(self)
      local ArgType = type(Args)
      if ArgType == "userdata" then
         Args = {config=Args}
      else
         checkParamTable(Args)
         checkParam(Args, "config", "userdata")
         checkNonEmptyParam(Args, "source_password", "string", true)
         checkNonEmptyParam(Args, "destination_password", "string", true)
         checkNonEmptyParam(Args, "salt", "string", true)
      end
      local Live = checkLiveParam(Args, false)
      
      return xml.parse(makeApiRequest("/add_channel",
            {config=tostring(Args.config),
               source_password=Args.source_password,
               destination_password=Args.destination_password,
               salt=Args.salt,
               compact="true"},
            Live, net.http.post))
   end
   
   function Obj:pollChannelStatus(Args)
      checkSelfParam(self)
      checkParamTable(Args)
      
      -- Higher-order function for finding a channel node in the response to a
      -- /status request.
      local function findChannel(Attribute, Value)
         return function(Status)
            local IguanaStatus = Status.IguanaStatus
            for i = 1, IguanaStatus:childCount("Channel") do
               local Channel = IguanaStatus:child("Channel", i)
               if Channel[Attribute]:nodeValue() == Value then
                  return Channel
               end
            end
            
            return nil
         end
      end
      
      local Name, Guid = checkForNameOrGuid(Args)
      local ChannelFinder
      if Guid then -- give priority to channel GUIDs
         ChannelFinder = findChannel("Guid", Guid)
      else
         ChannelFinder = findChannel("Name", Name)
      end
      
      local ChannelStatus = checkNonEmptyParam(Args, "channel_status", "string")
      -- The channel status in the response to /status can also be set to "..."
      -- or "error" which correspond to the starting state and error state,
      -- respectively, but it doesn't make much sense to poll for these states.
      if ChannelStatus ~= iguanaServer.CHANNEL_ON and
         ChannelStatus ~= iguanaServer.CHANNEL_OFF then
         error('Invalid channel status "' .. ChannelStatus .. '" specified.', 2)
      end
      
      local NumRetries = checkParam(Args, "num_retries", "number", true, 10)
      local Interval = checkParam(Args, "interval", "number", true, 100) -- milliseconds
      local Status = checkParam(Args, "status", "userdata", true)
      local Live = checkLiveParam(Args, true)
      
      -- Always return true when live is set to false, the rationale being that
      -- some applications will likely treat a return value of false as an error
      -- case.
      if not Live then
         return true
      end
      
      -- The remaining code is wrapped in an anonymous function and called
      -- through pcall in case the Status that has been given is invalid or a
      -- /status request fails.
      local Success, Result, LastChannelStatus = pcall(function()
            -- If an existing response to a /status request has been provided
            -- then check this first for the channel status, but only if the
            -- node tree is non-empty. (It will be empty if the function call it
            -- was returned from had live set to false.)
            if Status and #Status > 0 then
               local Channel = ChannelFinder(Status)
               if Channel and Channel.Status:nodeValue() == ChannelStatus then
                  return true
               end
            end
            
            local LastChannelStatus
            for RetryCount = 1, NumRetries do
               Status = xml.parse(makeApiRequest("/status", {}, true))
               local Channel = ChannelFinder(Status)
               if Channel then
                  LastChannelStatus = Channel.Status:nodeValue()
                  if LastChannelStatus == ChannelStatus then
                     return true
                  end
               end
               
               if RetryCount < NumRetries then
                  -- no point sleeping on the last iteration
                  util.sleep(Interval)
               end
            end
            
            return false, LastChannelStatus
         end)
      
      if not Success then
         error(Result, 2)
      end
      
      return Result, LastChannelStatus
   end
   
   function Obj:cloneChannel(Args)
      checkSelfParam(self)
      checkParamTable(Args)
      local Name, Guid = checkForNameOrGuid(Args)
      -- If another server has been specified then we'll attempt to clone the
      -- channnel there. Otherwise the clone will be made locally, in which case
      -- a new name for the channel needs to be specified since it will be
      -- invalid if it has a duplicate name.
      local Other = checkParam(Args, "other", "table", true)
      -- Validate that the table has the function we need to complete the clone.
      -- This isn't a very rigorous check, but it's good enough.
      if Other and (type(Other.addChannel) ~= "function" or
                    type(Other.isLive)     ~= "function") then
         error('The argument given for the "other" parameter is not a valid ' ..
            "server object.", 2)
      end
      local NewName = checkNonEmptyParam(Args, "new_name", "string", true)
      if not NewName and not Other then
         error("You must specify a new name for the channel when cloning locally.", 2)
      end
      -- Optional function argument that can be used to make modifications to
      -- the channel configuration before it gets added to the target server.
      local Configurator = checkParam(Args, "configurator", "function", true)
      checkNonEmptyParam(Args, "sample_data", "string", true)
      if Args.sample_data and Args.sample_data ~= 'append' and Args.sample_data ~= 'replace' then
         error("Parameter \"sample_data\" must be \"append\" or \"replace\"", 2)
      end
      -- Use "nil" as the default live value so that the appropriate default
      -- will get used in each function call when live has not been specified.
      local Live = checkLiveParam(Args, nil)
      
      local Success, Result = pcall(function()
            local Config = self:getChannelConfig{name=Name, guid=Guid, live=Live}
            local OldConfig = xml.parse(tostring(Config)) -- backup unmodified Config
            if #Config > 0 then
               if NewName then
                  Config.channel.name = NewName
               end
               if Configurator then
                  Configurator(Config)
               end
            end
            
            local Salt, Target
            if Other then
               Salt = self:getServerSalt(Live)
               Target = Other
            else
               Target = self
            end
            local TargetLive = Live and Target:isLive()
            
            -- NOTE: We don't use source_password and destination_password
            -- parameters here because they shouldn't be needed when cloning a
            -- channel. If the clone is being made locally then the existing
            -- passwords will work fine, and if the clone is made to a remote
            -- server then the salt from the source server will be used to
            -- handle encryption details.
            local NewConfig = Target:addChannel{config=Config, salt=Salt, live=TargetLive}
            
            if not TargetLive and #NewConfig == 0 then
               NewConfig = Config -- helps us with annotations and auto-completion
            end
            
            -- Copy Translator project(s).  Each channel may have between 0 and 3
            -- Translator projects.
            local Projects = getTranslatorProjects(OldConfig, NewConfig)
            for i,Project in ipairs(Projects) do
               -- For now we just pick a reasonable (timestamp-based) milestone name if
               -- we're not copying a specific milestone.  In the future cloneChannel()
               -- could be enhanced to take a new_milestone_name parameter to pass along,
               -- much like we do with sample_data.
               local NewMilestoneName = Project.new.Milestone or (tostring(os.time())..' - imported')
               self:updateProject{
                  source_guid=Project.old.Guid,
                  destination_guid=Project.new.Guid, 
                  new_milestone_name=NewMilestoneName,
                  other=Other,
                  source_milestone_name=Project.old.Milestone,
                  sample_data=Args.sample_data,
                  live=Live
               }
            end
            
            return NewConfig
         end)
      
      if not Success then
         error(Result, 2)
      end
      
      return Result
   end
   
   function Obj:getServerSalt(Args)
      checkSelfParam(self)
      if type(Args) == "boolean" then
         Args = {live=Args}
      else
         Args = checkParamTable(Args, true)
      end
      local Live = checkLiveParam(Args, true)
      
      if Data.Live and Live then
         return makeApiRequest("/get_server_salt", {}, Live)
      end
      
      -- If the request would've been sent non-live then we return nil instead
      -- of the empty string returned by makeApiRequest() since addChannel{}
      -- will treat an empty string passed in for the salt parameter as an error.
      return nil
   end
   
   function Obj:updateChannel(Args)
      checkSelfParam(self)
      if type(Args) == "userdata" then
         Args = {config=Args}
      else
         checkParamTable(Args)
         checkParam(Args, "config", "userdata")
         checkNonEmptyParam(Args, "source_password", "string", true)
         checkNonEmptyParam(Args, "destination_password", "string", true)
      end
      local Live = checkLiveParam(Args, false)
      
      return xml.parse(makeApiRequest("/update_channel",
            {config=tostring(Args.config),
               source_password=Args.source_password,
               destination_password=Args.destination_password,
               compact="true"},
            Live, net.http.post))
   end
   
   function Obj:exportProject(Args)
      checkSelfParam(self)
      if type(Args) == "string" then
         Args = {guid=Args}
      else
         checkParamTable(Args)
         checkNonEmptyParam(Args, "guid", "string")
         checkNonEmptyParam(Args, "milestone_name", "string", true)
         if Args.sample_data ~= nil and type(Args.sample_data) ~= "boolean" then
            error("Parameter \"sample_data\" must be a boolean", 2)
         elseif Args.sample_data == false then
            Args.sample_data = nil
         else
            Args.sample_data = 'true'
         end
         checkNonEmptyParam(Args, "destination_file", "string", true)
      end
      local Live = checkLiveParam(Args, true)
      
      if Data.Live and Live then
         local Base64ZipContents = makeApiRequest("/export_project",
            {guid=Args.guid, milestone_name=Args.milestone_name, sample_data=Args.sample_data},
            Live)
         if not Args.destination_file then
            return Base64ZipContents
         else
            local ZipContents = filter.base64.dec(Base64ZipContents)
            local ZipFile = io.open(Args.destination_file, 'w+b')
            ZipFile:write(ZipContents)
            ZipFile:close()
            return Args.destination_file
         end
      end
   end
   
   function Obj:importProject(Args)
      checkSelfParam(self)
      checkParamTable(Args)
      checkNonEmptyParam(Args, "guid", "string")
      checkNonEmptyParam(Args, "project", "string", true)
      checkNonEmptyParam(Args, "source_file", "string", true)
      if not Args.project and not Args.source_file then
         error("One of parameters \"project\" or \"source_file\" is required.", 2)
      elseif Args.project and Args.source_file then
         error("Only one of parameters \"project\" or \"source_file\" is allowed.", 2)
      end
      checkNonEmptyParam(Args, "sample_data", "string", true)
      if Args.sample_data and Args.sample_data ~= 'append' and Args.sample_data ~= 'replace' then
         error("Parameter \"sample_data\" must be \"append\" or \"replace\"", 2)
      end
      local Live = checkLiveParam(Args, false)
      
      if Data.Live and Live then
         local Base64ZipContents = Args.project
         if not Base64ZipContents then
            local ZipFile = io.open(Args.source_file, "rb")
            local ZipContents = ZipFile:read("*all")
            ZipFile:close()
            Base64ZipContents = filter.base64.enc(ZipContents)
         end
         makeApiRequest("/import_project",
            {guid=Args.guid, project=Base64ZipContents, sample_data=Args.sample_data},
            Live)
      end
      
      return Args.guid
   end
   
   function Obj:saveProjectMilestone(Args)
      checkSelfParam(self)
      checkParamTable(Args)
      checkNonEmptyParam(Args, "guid", "string")
      checkNonEmptyParam(Args, "milestone_name", "string")
      local Live = checkLiveParam(Args, false)
      
      if Data.Live and Live then
         makeApiRequest("/save_project_milestone",
            {guid=Args.guid, milestone_name=Args.milestone_name},
            Live)
      end
      
      return Args.milestone_name
   end
   
   function Obj:updateProject(Args)
      checkSelfParam(self)
      checkParamTable(Args)
      checkNonEmptyParam(Args, "source_guid", "string")
      checkNonEmptyParam(Args, "destination_guid", "string")
      checkNonEmptyParam(Args, "new_milestone_name", "string")
      checkNonEmptyParam(Args, "source_milestone_name", "string", true)
      checkNonEmptyParam(Args, "sample_data", "string", true)
      if Args.sample_data and Args.sample_data ~= 'append' and Args.sample_data ~= 'replace' then
         error("Parameter \"sample_data\" must be \"append\" or \"replace\"", 2)
      end
      local Other = checkParam(Args, "other", "table", true)
      -- Validate that the table has the function we need to complete the update.
      -- This isn't a very rigorous check, but it's good enough.
      if Other and (type(Other.importProject)        ~= "function" or
                    type(Other.saveProjectMilestone) ~= "function" or
                    type(Other.isLive)               ~= "function") then
         error('The argument given for the "other" parameter is not a valid ' ..
            "server object.", 2)
      end
      local Live = checkLiveParam(Args, false)
      
      local Target = Other or self
      local TargetLive = Live and Target:isLive()
      
      local Project = self:exportProject{
         guid=Args.source_guid,
         milestone_name=Args.source_milestone_name,
         sample_data=(Args.sample_data and true),
         live=Live
      }
      
      if not Live then Project = 'empty' end -- keep annotations working
      
      Target:importProject{
         guid=Args.destination_guid,
         project=Project,
         sample_data=Args.sample_data,
         live=TargetLive
      }
      
      return Target:saveProjectMilestone{
         guid=Args.destination_guid,
         milestone_name=Args.new_milestone_name, 
         live=TargetLive
      }
   end
   
   function Obj:isLive()
      return Data.Live
   end
   
   -- We need to set help data on the object here before returning because the
   -- usage of closures means that each server object has different copies of
   -- the same functions.
   if iguana.isTest() then
      setHelpData(Obj, ObjectHelp)
   end
   
   return Obj
end

-- Note: A recursive algorithm that clones any type of XML node could be
-- implemented here, but I don't think this is really needed for the typical
-- use case of the module.
function iguanaServer.cloneXmlNode(Args)
   checkParamTable(Args)
   local Source = checkParam(Args, "source", "userdata")
   local Dest = checkParam(Args, "dest", "userdata")
   
   local SourceType = Source:nodeType()
   if SourceType ~= xml.ELEMENT then
      error("Expected " .. xml.ELEMENT .. " for source node, got " ..
         SourceType .. ".", 2)
   end
   
   local NewNode = Dest:append(SourceType, Source:nodeName())
   -- Copy the attributes of the source node onto the new one.
   for i=1, #Source do
      local Child = Source[i]
      local ChildType = Child:nodeType()
      if ChildType ~= xml.ATTRIBUTE then
         error("Expected " .. xml.ATTRIBUTE .. " for child node, got " ..
            ChildType .. ".", 2)
      end
      
      NewNode:append(ChildType, Child:nodeName()):setInner(Child:nodeValue())
   end
   
   return NewNode
end

if iguana.isTest() then
   setHelpData(iguanaServer, ModuleHelp)
end

return iguanaServer
