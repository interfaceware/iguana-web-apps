-- This web service generates the JSON required to populate the dashboard.
function cm.app.listChannels(Request, App)
   local StatusXml = iguana.status()   
   local Conf = xml.parse{data=StatusXml}.IguanaStatus
   
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
   
   local T = {name={}, status={}, source={}, destination={}}
   for i=1, Conf:childCount('Channel') do
      local Ch = Conf:child('Channel', i)
      T.name[#T.name+1] = Ch.Name:nodeValue();
      T.status[#T.status+1] = Ch.Status:nodeValue();     
      T.source[#T.source+1] = Components[Ch.Source:nodeValue()];
      T.destination[#T.destination+1] = Components[Ch.Destination:nodeValue()];
   end
   
   return T
end
