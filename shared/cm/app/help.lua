if not cm.app.help then cm.app.help = {} end

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
   ['png'] = 'img',
   ['xml'] = 'str'
}

local function FileTreeCompare(T1, T2)
   if T1.name < T2.name then return true 
   else return false end
end

local function EncodeData(Tnode)
   if Tnode.foss then Tnode.foss = filter.base64.enc(Tnode.foss) end
   if Tnode.trans then Tnode.trans = filter.base64.enc(Tnode.trans) end
   if Tnode.repo then Tnode.repo = filter.base64.enc(Tnode.repo) end
end

local function Merge(t1, t2)
   for k, v in pairs(t2) do
      if (type(v) == "table") and (type(t1[k] or false) == "table") then
         Merge(t1[k], t2[k])
      else
         t1[k] = v
      end
   end
   return t1
end

local function ThreeWayComp(S1, S2, S3)
   if (S1 == nil) then
      if (S2 == S3) then 
         return 'delete'
      else
         return nil, S2, S3, 012
      end
   elseif (S1 == S2) and (S2 == S3) then
      return 'delete'
   elseif (S1 == S2) and (S2 ~= S3) then
      if (S3 == nil) then 
         return S1, nil, nil, 110
      end
      return S1, nil, S3, 112
   elseif (S1 ~= S2) and (S2 == S3) then
      return S1, S2, nil, 122
   elseif (S1 == S3) and (S1~= S2) then
      return S1, S2, nil, 121
   elseif (S1 ~= S2) and (S2 ~= S3) and (S1 ~= S3) then
      if (S3 == nil) then 
         return S1, S2, nil, 120
      end
      return S1, S2, S3, 123 
   end
end
local function Step(Data, Name)
   if type(Data) == 'table' then
      return Data[Name]
   elseif type(Data) == 'string' then
      return Data..Name..'/'
   else
      return nil
   end
end

local function Retrieve(Data, Name)
   if type(Data) == 'table' then
      return Data[Name]
   elseif type(Data) == 'string' then
      local Rtn = os.fs.access(Data .. Name) and os.fs.readFile(Data .. Name) or nil
      return Rtn
   else
      return nil
   end
end
--Fossil > Trans > Repo
--[[The diff code coresponds to the uniquness of each file
    if foss = trans != repo, then diff = 112
    0 represents no data]]--

local function VerifyDifference(Files, Root, Fosroot, Control)
   local Filetree = {}
   for k, v in pairs(Files) do
      if type(v) == 'table' then
         local Treenode = {['type'] = 'folder', ['name'] = k, ['data'] = VerifyDifference(v, Step(Root, k), Step(Fosroot, k), Control)}
         if #Treenode.data >= 1 then
            Filetree[#Filetree + 1] = Treenode
         end
      else         
         local extentiontype = string.split(k, '%.')
         local extention = extentiontype[#extentiontype]
         extentiontype = #extentiontype > 1 and extentions[extention] or 'file' 
         local Tnode = {['type'] = extentiontype, ['name'] = k, ['extention'] = extention}  
         if Control == 'Old' then
            Tnode.trans = v
            Tnode.foss = Retrieve(Fosroot, k) or v
            Tnode.repo = Retrieve(Root, k) 
         else 
            Tnode.repo = v
            Tnode.trans = Retrieve(Root, k)
            Tnode.foss = Retrieve (Fosroot, k) or trans
         end
         trace(Tnode)
         Tnode.foss, Tnode.trans, Tnode.repo, Tnode.diff = ThreeWayComp(Tnode.foss, Tnode.trans, Tnode.repo)        
         if Tnode.foss ~= "delete" then
            if Tnode.type ~= 'str' then EncodeData(Tnode) end
            Filetree[#Filetree + 1] = Tnode
         end
      end
      trace(Filetree)
   end
   table.sort(Filetree, FileTreeCompare)
   trace(Filetree)
   return Filetree
end

function cm.app.help.importDiff(Request)
   local Data = json.parse{data=Request.body}
   local Root = cm.config.open()
   Root = os.fs.name.toNative(Root.config.locations[Data.repo + 1].Source)
   local Result = {}
   local R = {headers = Request.headers}
   local F = fossil.openNewInstance(Request)
   for K, V in pairs(Data.data) do 
      local config = iguana.channel.getTranslators(xml.parse{data=os.fs.readFile(Root .. V.name .. '.xml')})
      local ChannelData = {}
      for K2, V2 in pairs(config) do
         local TransName = V.name ..'_'.. K2
         local TempData 
         _, TempData = BuildTransZip(Root, TransName, nil, V.name)
         Merge(ChannelData, TempData)
      end
      local LocalData = iguana.channel.exists(V.name) and cm.app.exportlist(R, V) or nil
      Result[#Result + 1] = {['name'] = V.name, 
         ['data'] = VerifyDifference(ChannelData, LocalData, F.path) , ['type'] = 'channel'}
   end
   table.sort(Result, FileTreeCompare)
   return {['target'] = Root, ['data'] = Result}
end

function cm.app.help.exportDiff(Request)
   local Data = json.parse{data=Request.body}
   local Root = cm.config.open()
   Root = os.fs.name.toNative(Root.config.locations[Data.repo + 1].Source)
   local Result = {}
   local R = {headers  = Request.headers}
   local F = fossil.openNewInstance(Request)
   for K, V in pairs(Data.data) do      
      Result[#Result + 1] = {['name'] = V.name, 
         ['data'] = VerifyDifference(cm.app.exportlist(R, V), Root, F.path, 'Old'), ['type'] = 'channel'}
      if #Result[#Result].data == 0 then Result[#Result] = nil end
   end
   table.sort(Result, FileTreeCompare)
   return {['target'] = Root, ['data'] = Result}
end