require 'node'
local dashboard = {}
dashboard.store = {}

ds = dashboard.store

ds.threshold = 900

function ds.connection()
   return db.connect{api=db.SQLITE, name='status'}
end

function ds.reset(C)
   local C = ds.connection()
   C:execute{sql=[[DROP TABLE IF EXISTS status]], live=true}
   C:execute{sql=[[CREATE TABLE status (
      server_guid TEXT NOT NULL,
      name TEXT,
      ts INTEGER,
      summary TEXT,
      status INTEGER,
      PRIMARY KEY (server_guid))]], live=true} 
   return {status='OK'}
end

function ds.init()
   local Connection = ds.connection()
   local Result = Connection:query{sql='SELECT * FROM sqlite_master WHERE type="table" and name="status"', live=true}
   Connection:close()
   if #Result == 0 then
      ds.reset();
   end
end

function ds.mapRequest(T, R)
   T.server_guid = R.guid
   T.ts = os.ts.time()
   T.summary = R.summary
   T.status = R.retcode
   T.name = R.name
   return T
end

function node.S(N) return tostring(N) end

function ds.receiveData(R)
   local C = ds.connection()
   local T = db.tables{vmd='status.vmd', name='Message'}
   local Data = json.parse{data=R.body}
   ds.mapRequest(T.status[1], Data)
   C:merge{data=T, live=true}
   return {status='OK'}
end

function ds.summary()
   local C = ds.connection()
   local CurrentTime = os.ts.time()
   local S = C:query{sql="SELECT server_guid, ts, summary, name FROM status", live=true}
   local Summary = {aaData={}, Guids={}}
   for i=1, #S do 
      local Status = '<div class="status-green"></div>'
      local LastRefresh = os.ts.difftime(CurrentTime, tonumber(tostring(S[i].ts)))
      if (LastRefresh > ds.threshold) then
         Status = '<div class="status-red"></div>'
      end
      Summary.aaData[i] = {'<a href="#Server=' .. S[i].server_guid:S() .. '">' .. S[i].name:S() .. '</a>', ds.timeago(LastRefresh), Status}
      Summary.Guids[i] = S[i].server_guid:S()
   end
   Summary.Info = {Time=CurrentTime, AsString=os.ts.date("%c", CurrentTime)}
   Summary.aoColumns = {
      {['sTitle'] = 'Name', ['sType'] = 'string'},
      {['sTitle'] = 'Last Refresh', ['sType'] = 'html'},
      {['sTitle'] = 'Status', ['sType'] = 'string'}
   }
   return Summary
end

function ds.detail(Data)
   trace(Data)
   local C = ds.connection()

   local D = C:query{sql=
      "SELECT name, ts, summary FROM status WHERE server_guid='" 
      .. Data.get_params.guid .. "'", live=true}

   local Xml
   if #D > 0 then 
     Xml = xml.parse(D[1].summary:S())
   end

   local Details = ds.convertXmlToLua(Xml)
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
   
--[[   Summary.ServerInfo.bAutoWidth = false
   Summary.ServerInfo.bPaginate = false
   Summary.ServerInfo.bFilter = false
   Summary.ServerInfo.bInfo = false ]]
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

function ds.timeago(Seconds)
   local mf = math.floor
   local FT = 'Less than a minute ago'
   if Seconds < 60 then
   -- leave FT alone
   elseif Seconds < 120 then
      FT = 'About a minute ago'
   elseif Seconds < 7200 then
      FT = mf(Seconds / 60) .. ' minutes ago'
   elseif Seconds < 2*86400 then
      FT = mf(Seconds / 3600) .. ' hours ago'
   else
      FT = mf(Seconds / 84600) .. ' days ago'
   end
   return ds.warn(Seconds, FT)
end

function ds.warn(S, F) 
   if S > ds.threshold then
      F = '<span class="alarm">' .. F .. '</span>'    
   end
   return F
end

function ds.default(R)
   return dashboard.presentation.main(R)
end

function ds.css(R)
   return dashboard.presentation.css(R)
end

ds.Actions={
   ['send']=ds.receiveData,
   ['summary']=ds.summary,
   ['detail']=ds.detail,
   ['reset']=ds.reset
}

local ContentTypeMap = {
   ['.js']  = 'application/x-javascript',
   ['.css'] = 'text/css',
   ['.gif'] = 'image/gif'
}

function ds.entity(Location) 
   local Ext = Location:match('.*(%.%a+)$')
   local Entity = ContentTypeMap[Ext]
   return Entity or 'text/plain'
end

function ds.convertXmlToLua(Xml)
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
         local C = MT[i]
         local Cvars = {}
         for j = 1, #C do
            Cvars[C[j]:nodeName()] = C[j]:nodeValue()     
         end
         Ch[C.Guid:S()] = Cvars
      end
      
   end
   return T
end

-- Find the method for the action.
function ds.serveRequest(Data)
   local R = net.http.parseRequest{data=Data}
   trace(R.location)
   local Action = ActionTable[R.location]
   if (Action) then
      local Result = Action(R)
      Result = json.serialize{data=Result}
      net.http.respond{body=Result, entity_type='text/json'}   
      return
   end
   
   local Resource = dashboard.presentation.ResourceTable[R.location]
   trace(Resource)
   if (Resource) then
      local Body = dashboard.presentation.template(R.location, Resource)      
      net.http.respond{body=Body, entity_type=ds.entity(R.location)} 
      return
   end
   
   local ResourceFile = dashboard.presentation.loadOther(R.location)
   if (ResourceFile) then
      net.http.respond{body=ResourceFile, entity_type=ds.entity(R.location)}
      return
   end
   -- Default page
   net.http.respond{body=ds.default(R)}
end

return dashboard.store