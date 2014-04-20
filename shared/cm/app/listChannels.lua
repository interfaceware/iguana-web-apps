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
   border="0" title="" src="icon_%s.gif">
   <img alt="arrow" width="11" height="16" 
   border="0" title="" src="arrow.gif">
   <img alt="%s" width="38" height="16"
   border="0" title="" src="icon_%s.gif">]]
   
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
      '<a href=\"#Page=exportSummary&Name=%s\">Export</a>',
      Channel.Name:nodeValue())
   return Html
end

local function replaceSummaryBtn(Channel)
   local Html = string.format(
      '<a href=\"#Page=replaceChannel&Name=%s\">Replace</a>',
      Channel.Name:nodeValue())
   return Html
end

function cm.app.listChannels(Request, App)
   -- switch this to iguana.status once it's available
   local StatusXml = iguana.status()
   
   local Conf = xml.parse{data=StatusXml}.IguanaStatus
   
   local Results = {aaData={}, aoColumns={}}
   Results.aoColumns = {
      {['sTitle'] = 'Channel Name',   ['sType'] = 'string'},
      {['sTitle'] = 'Status', ['sType'] = 'html'},
      {['sTitle'] = 'Type',   ['sType'] = 'string'},
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
         exportSummaryBtn(Ch)}
   end
   
   return Results
end
