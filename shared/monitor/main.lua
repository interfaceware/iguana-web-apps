-- This code generates the back end data for the summary of all the servers in
-- the monitor.

-- Notice how the helper functions are declared local - this is so that it's clear
-- they are only used locally and not throughout the application - just in this module.

local THRESHOLD = 900

local function ThresholdWarning(S, F) 
   if S > THRESHOLD then
      F = '<span class="alarm">' .. F .. '</span>'    
   end
   return F
end

local function TimeAgo(Seconds)
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
   return ThresholdWarning(Seconds, FT)
end

function monitor.main()
   local C = monitor.connection()
   local CurrentTime = os.ts.time()
   local S = C:query{sql="SELECT server_guid, ts, summary, name FROM status", live=true}
   local Summary = {aaData={}, Guids={}}
   for i=1, #S do 
      local Status = '<div class="status-green"></div>'
      local LastRefresh = os.ts.difftime(CurrentTime, tonumber(tostring(S[i].ts)))
      if (LastRefresh > THRESHOLD) then
         Status = '<div class="status-red"></div>'
      end
      Summary.aaData[i] = {'<a href="#Page=detail&Server=' .. S[i].server_guid:S() .. '">' .. S[i].name:S() .. '</a>', TimeAgo(LastRefresh), Status}
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