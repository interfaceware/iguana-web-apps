-- This web service generates the JSON required to populate the dashboard.
if not cm.app.listChannels then cm.app.listChannels = {} end

local extentions = {
   ['js'] = 'str',
   ['img'] = 'img',
   ['html'] = 'str',
   ['lua'] = 'str',
   ['json'] = 'str',
   ['css'] = 'str',
   ['file'] = 'str',
   ['prj'] = 'str',
   ['xml'] = 'str',
   ['vmd'] = 'str',
   ['gif'] = 'img',
   ['png'] = 'img'
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

local function FileTreeCompare(T1, T2)
   if T1.name < T2.name then return true 
   else return false end
end

local function EncodeData(Tnode)
   if Tnode.foss then Tnode.foss = 'data:image/'..Tnode.extention ..';base64,'..filter.base64.enc(Tnode.foss) end
   if Tnode.trans then Tnode.trans = 'data:image/'..Tnode.extention ..';base64,'..filter.base64.enc(Tnode.trans) end
   if Tnode.old then Tnode.old = 'data:image/'..Tnode.extention ..';base64,'..filter.base64.enc(Tnode.old) end
end

local function ThreeWayComp(S1, S2, S3)
   if (S1 == S2) and (S2 == S3) then
      return 'delete'
   elseif (S1 == S2) and (S2 ~= S3) then
      if (S3 == nil) then 
         return S1, nil, nil, 100
      end
      return S1, nil, S3, 112
   elseif (S1 ~= S2) and (S2 == S3) then
      return S1, S2, nil, 122
   elseif (S1 == S3) and (S1~= S2) then
      return S1, S2, nil, 121
   elseif (S1 ~= S2) and (S2 ~= S3) and (S1 ~= S3) then
      return S1, S2, S3, 123 
   end
end

--Fossil > Trans > Folder
--[[The diff code coresponds to he uniquness of each file
    if foss = trans != fold, then diff = 112
    0 represents no data]]--
local function VerifyDifference(Files, Root, Fosroot)
   local Filetree = {}
   trace(Filetree)
   for k, v in pairs(Files) do
      if type(v) == 'table' then
         local Treenode = {['type'] = 'folder', ['name'] = k, ['data'] = VerifyDifference(v, Root..k..'/', Fosroot..k..'/')}
         if #Treenode.data >= 1 then
            Filetree[#Filetree + 1] = Treenode
         end
      else         
         local extentiontype = string.split(k, '%.')
         local extention = extentiontype[#extentiontype]
         if(#extentiontype > 1) then
            extentiontype = extentions[extention]
         else
            extentiontype = 'file'
         end
         local Tnode = {['type'] = extentiontype, ['name'] = k, ['trans'] = v, ['extention'] = extention}        
         Tnode.foss = os.fs.access(Fosroot .. k) and os.fs.readFile(Fosroot..k)
         Tnode.old = os.fs.access(Root .. k) and os.fs.readFile(Root .. k) or nil
         Tnode.foss, Tnode.trans, Tnode.old, Tnode.diff = ThreeWayComp(Tnode.foss, Tnode.trans, Tnode.old)
         trace(Tnode.foss)
         if Tnode.foss ~= "delete" then
            if extentiontype == "img" then
               EncodeData(Tnode)
            elseif extentiontype == "file" then
               Tnode.foss, Tnode.old, Tnode.trans = nil, nil, nil   
            end
            trace(Tnode)
            Filetree[#Filetree + 1] = Tnode
         end
      end
      trace(Filetree)
   end
   table.sort(Filetree, FileTreeCompare)
   trace(Filetree)
   return Filetree
end
function cm.app.listChannels.importDiff(Request)
   local Data = json.parase{data=Request.body}
   local Root = cm.config.open()
   Root = os.fs.name.toNative(Root.config.location[Data.repo + 1].Sourcce)
   local Result = {}
   local R = {headers = Request.headers}
end
function cm.app.listChannels.exportDiff(Request)
   local Data = json.parse{data=Request.body}
   local Root = cm.config.open()
   Root = os.fs.name.toNative(Root.config.locations[Data.repo + 1].Source)
   local Result = {}
   local R = {headers  = Request.headers}
   local F = fossil.openNewInstance(Request)
   for k, v in pairs(Data.data) do      
      Result[#Result + 1] = {['name'] = v.name, ['data'] = VerifyDifference(cm.app.exportlist(R, v), Root, F.path), ['type'] = 'channel'}
      if #Result[#Result].data == 0 then Result[#Result] = nil end
   end
   table.sort(Result, FileTreeCompare)
   return {['target'] = Root, ['data'] = Result}
end