-- This file generates the data required for the two data tables
-- in the server view

-- Notice the deliberate pattern of defining private helper functions here
-- This makes the code easier to maintain since we know this function is only
-- used locally.

require 'node'

local function ConvertXmlToLua(Xml)
   local T = {}
   T.server = {}
   T.channels = {}
   local S = T.server
   local Ch = T.channels
   local MT = Xml.IguanaStatus
   trace(MT)
   for i = 1, #MT do
      if MT[i]:nodeType() == 'attribute' then
         S[MT[i]:nodeName()] = MT[i]:nodeValue()
      else
         -- We have to check that we have a channel node
         if (MT[i]:nodeName() == 'Channel') then   
            local C = MT[i]
            local Cvars = {}
            for j = 1, #C do
               Cvars[C[j]:nodeName()] = C[j]:nodeValue()     
            end  
            Ch[C.Guid:S()] = Cvars
         end
      end
      
   end
   return T
end

function monitor.detail(Data)
   trace(Data)
   local C = monitor.connection()
   local D = C:query{sql=
      "SELECT name, ts, summary FROM status WHERE server_guid='" 
      .. Data.params.guid .. "'", live=true}
   local Xml
   if #D > 0 then 
     Xml = xml.parse(D[1].summary:S())
   end

   local Details = ConvertXmlToLua(Xml)
   local Summary = {
      ChannelsInfo = {aaData = {}}, 
      ServerInfo   = {aaData = {}}, 
   }
   -- Create chanels table headers.
   Summary.ServerInfo.aoColumns = {
      {['sTitle'] = 'Key',   ['sType'] = 'string', sWidth = '%40'},
      {['sTitle'] = 'Value', ['sType'] = 'string', sWidth = '%60'},
   }   
   -- Build up the servers info tables.
   local info = Details.server
   
   local CurrentTime = os.ts.time()
   Summary.Info = {Time=CurrentTime, AsString=os.ts.date("%c", CurrentTime)}
   
   Summary.ServerInfo.aaData = { 
      { 'Date Time', info.DateTime }, 
      { 'Channels', info.NumberOfChannels }, 
      { 'Running Channels', info.NumberOfRunningChannels },
      { 'Licensed Channels', info.NumberOfLicensedChannels },
      { 'Service Errs', info.TotalServiceErrors },
      { 'Version Valid', info.VersionValid },
      { 'Version Build Id', info.VersionBuildId },
      { 'Uptime', info.Uptime },
      { 'Disk Size MB', info.DiskSizeMB },
      { 'Disk Free MB', info.DiskFreeMB },
      { 'Disk Used MB', info.DiskUsedMB },
      { 'Logs Used', info.LogsUsedMB },
      { 'Logs Used Last Wk KB', info.LogsUsedLastWeekKB },
      { 'Logs Used Avg KB', info.LogsUsedAverageKB },
      { 'Logs Used Avg Last Wk KB', info.LogsUsedAverageLastWeekKB },
      { 'Logs Num Of Days', info.LogsNumberOfDays },
      { 'Age Of Oldest File', info.AgeOfOldestFile },
      { 'Iguana Id', info.IguanaId },
      { 'Log Dir', info.LogDirectory },
      { 'CPU Percent', info.CPUPercent },
      { 'Memory KB', info.MemoryKB },
      { 'Mem Rss KB', info.MemRssKB },
      { 'Open FD', info.OpenFD },
      { 'Server Name', info.ServerName },
      { 'Cores', info.Cores },
      { 'Permissions', info.Permissions },
      { 'Start Time', info.StartTime },
      { 'Thread Count', info.ThreadCount },
      { 'Sockets Open', info.SocketsOpen },
      { 'Sockets Limit', info.SocketsLimit },
   }

   -- Create chanels table headers.
   Summary.ChannelsInfo.aoColumns = {
      {['sTitle'] = 'Name',   ['sType'] = 'string'},
      {['sTitle'] = 'Status', ['sType'] = 'string'},
      {['sTitle'] = 'Type',   ['sType'] = 'string'},
      {['sTitle'] = 'Msgs Queued', ['sType'] = 'string'},
      {['sTitle'] = 'Total Errs',  ['sType'] = 'string'},
   }
   
   -- Build up the channels table.
   local Statuses = {
      on='status-green', 
      off='status-grey', 
      error='status-red', 
      transition='status-yellow'}
   local StatusHtml = '<div class="%s"></div>'
   
   local ComponentsHtml = [[
   <img alt="%s" width="38" height="16"'
   border="0" title="" src="/monitor/icon_%s.gif">
   <img alt="arrow" width="11" height="16" 
   border="0" title="" src="/monitor/arrow.gif">
   <img alt="%s" width="38" height="16"'
   border="0" title="" src="/monitor/icon_%s.gif">
   ]]
   
   local Components = {
      ['From Translator'] = 'TRANS',
      ['To Translator']   = 'TRANS',
      ['From File']  = 'FILE',
      ['To File']    = 'FILE',
      ['From HTTPS'] = 'HTTPS',
      ['To HTTPS']   = 'HTTPS',
      ['LLP Listener'] = 'LLP',
      ['LLP Client']   = 'LLP',
      ['From Channel'] = 'QUE',
      ['To Channel']   = 'QUE',
      ['To Plugin']    = 'PLG-N',
      ['From Plugin']  = 'PLG-N'}

   local Row = 1
   for _, Ch in pairs(Details.channels) do
      Summary.ChannelsInfo.aaData[Row] = {
         Ch.Name,
         string.format(StatusHtml, Statuses[Ch.Status]),
         string.format(ComponentsHtml, Components[Ch.Source], 
            Components[Ch.Source], Components[Ch.Destination], 
            Components[Ch.Destination]),
         Ch.MessagesQueued,
         Ch.TotalErrors
      }
      Row = Row + 1
   end
   
   return Summary
end