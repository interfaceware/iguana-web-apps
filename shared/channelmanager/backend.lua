require 'iguanaServer'

channelmanager.backend = {}

-- Private helpers
local function statuses()
   local StatusHtml = '<div class="%s"></div>'
   local Statuses = {
      on='status-green', 
      off='status-grey', 
      error='status-red', 
      transition='status-yellow'}
   return StatusHtml, Statuses
end

local function components()
   local ComponentsHtml =
   [[<img alt="%s" width="38" height="16"
   border="0" title="" src="/channelmanager/icon_%s.gif">
   <img alt="arrow" width="11" height="16" 
   border="0" title="" src="/channelmanager/arrow.gif">
   <img alt="%s" width="38" height="16"
   border="0" title="" src="/channelmanager/icon_%s.gif">]]
   
   local Components = {
      ['From Translator'] = 'TRANS',
      ['To Translator']   = 'TRANS',
      ['From File']  = 'FILE',
      ['To File']    = 'FILE',
      ['To Database'] = 'DB',
      ['From Database'] = 'DB',
      ['From HTTPS'] = 'HTTPS',
      ['To HTTPS']   = 'HTTPS',
      ['LLP Listener'] = 'LLP',
      ['LLP Client']   = 'LLP',
      ['From Channel'] = 'QUE',
      ['To Channel']   = 'QUE',
      ['To Plugin']    = 'PLG-N',
      ['From Plugin']  = 'PLG-N'}
   
   return ComponentsHtml, Components
end

local function exportSummaryBtn(Channel)
   local Html = string.format(
      '<a href=\"%s#Page=exportSummary&Name=%s\">Export</a>',
      app.config.approot, Channel.Name:nodeValue())
   return Html
end

local function replaceSummaryBtn(Channel)
   local Html = string.format(
      '<a href=\"%s#Page=replaceChannel&Name=%s\">Replace</a>',
      app.config.approot, Channel.Name:nodeValue())
   return Html
end

-- End helpers
--

-- -- -- -- -- --

--
-- The App
--

function channelmanager.default()
   return channelmanager.presentation["/channelmanager/index.html"]
end

function channelmanager.backend.listChannels(Request)
   -- switch this to iguana.status once it's available
   local StatusXml = iguana.status()
   
   local Conf = xml.parse{data=StatusXml}.IguanaStatus
   
   local Results = {aaData={}, aoColumns={}}
   Results.aoColumns = {
      {['sTitle'] = 'Name',   ['sType'] = 'string'},
      {['sTitle'] = 'Status', ['sType'] = 'html'},
      {['sTitle'] = 'Type',   ['sType'] = 'string'},
      {['sTitle'] = 'Msgs Queued', ['sType'] = 'string'},
      {['sTitle'] = 'Total Errs',  ['sType'] = 'string'},
      {['sTitle'] = 'Export',  ['sType'] = 'html'}}
   
   local StatusHtml, Statuses = statuses()
   ComponentsHtml, Components = components()
   
   for i=1, Conf:childCount('Channel') do
      local Ch = Conf:child('Channel', i)
      Results.aaData[i] = {
         Ch.Name:nodeValue(), 
         string.format(
            StatusHtml, 
            Statuses[Ch.Status:nodeValue()]), 
         string.format(
            ComponentsHtml, 
            Components[Ch.Source:nodeValue()],
            Components[Ch.Source:nodeValue()], 
            Components[Ch.Destination:nodeValue()], 
            Components[Ch.Destination:nodeValue()]),
         Ch.MessagesQueued:nodeValue(),
         Ch.TotalErrors:nodeValue(),
         exportSummaryBtn(Ch)}
   end
   
   return Results
end

function channelmanager.backend.importList(R) 
   local L = {}
   for K, V in os.fs.glob(channelmanager.config.channelExportPath..'/*.xml') do
      local N = K:split("/")
      N = N[#N]
      N = N:sub(1, #N-4)
      L[#L+1] = N
   end
   return L
end

function channelmanager.backend.importChannel(Request)
   channelmanager.backend.import.action(Request)

   return {ok=true}
end

-- Only returning the infomration on the export path
-- It's important that we make the web api of this application modular and orthonal
function channelmanager.backend.info(Request)
   return {ExportPath = app.config.channelExportPath}
end

return app