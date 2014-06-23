-- This web service generates the JSON required to populate the dashboard.
if not cm.app.listChannels then cm.app.listChannels = {} end

local extentions = {
   ['js'] = true,
   ['html'] = true,
   ['lua'] = true,
   ['json'] = true,
   ['css'] = true,
   ['file'] = true,
   ['prj'] = true,
   ['xml'] = true
}

function cm.app.listChannels.list(Request, App)
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
      T.name[#T.name+1] = Ch.Name
      T.status[#T.status+1] = Ch.Status     
      T.source[#T.source+1] = Components[Ch.Source:nodeValue()];
      T.destination[#T.destination+1] = Components[Ch.Destination:nodeValue()];
   end
  
   return T
end

local function filetreecompare(t1, t2)
   if t1.name < t2.name then return true 
   else return false end
end

local function verifydifference(files, root)
   local filetree = {}
   trace(files)
   for k, v in pairs(files) do
      if type(v) == 'table' then
         local treenode = { ['type'] = 'folder', ['name'] = k, ['data'] = verifydifference(v, root..k..'/')}
         filetree[#filetree + 1] = treenode
      else
         trace(k)
         local extention = string.split(k, '%.')
         if(#extention > 1) then
            extention = extention[#extention]
         else
            extention = 'file'
         end
         local treenode = {['type'] = extention, ['name'] = k, ['newdata'] = v}
         if os.fs.access(root .. k) then
            local olddata = os.fs.readFile(root .. k)
            if oldata == v then
               treenode['status'] = 'same'
            else
               treenode['status'] = 'diff'
               treenode['olddata'] = olddata
            end
         else 
            treenode['status'] = 'noold'
         end
         if not extentions[treenode.type] then
            treenode.newdata = nil
            treenode.olddata = nil
         end
         filetree[#filetree + 1] = treenode
      end
      trace(v)
   end
   table.sort(filetree, filetreecompare)
   trace(filetree)
   return filetree
end

function cm.app.listChannels.exportDiff(Request)
   local Data = json.parse{data=Request.body}
   local root = cm.config.open()
   root = os.fs.name.toNative(root.config.locations[Data.repo + 1].Src)
   local Result = {}
   local R = {headers  = Request.headers}
   for k, v in pairs(Data.data) do      
      Result[#Result + 1] = {['name'] = v.name, ['data'] = verifydifference(cm.app.exportlist(R, v), root), ['type'] = 'channel'}
   end
   table.sort(Result, filetreecompare)
   return {['target'] = root, ['data'] = Result}
end

