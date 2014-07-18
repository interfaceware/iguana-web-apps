-- Utilities for "node" Values
function node:isEmptyChild(xArg, nCount)
   local lFound = nil
   local nFoundCount = 0
   if type(xArg) == 'string' then
      for nNode = 1, self:childCount() do
         if self[nNode]:nodeName() == xArg then
            nFoundCount = nFoundCount + 1
            if not nCount or nFoundCount == nCount then
               lFound = nNode
               break
            end
         end
      end
   elseif type(xArg) == 'number' then
      if self:childCount() >= xArg then
         lFound = true
      end
   end
   
   return lFound
end

function node:getRepeat(nMatch, sMatch)
   if nMatch and nMatch > 0 then
      for nGetRepeat = 1, #self do
         if self[nGetRepeat][nMatch]:S() == sMatch then
            return nGetRepeat
         end
      end
   end
end

function node:HL7TStoDateValue()
   if self:nodeValue() == '' then
      return ''
   else
      local sSelf = self:nodeValue()
      local sY = sSelf:sub(1,4)
      local sMo = sSelf:sub(5,6)
      if sMo == '' then
         sMo = '01'
      end
      local sD = sSelf:sub(7,8)
      if sD == '' then
         sD = '01'
      end   
      local sH = sSelf:sub(9,10)
      if sH == '' then
         sH = '00'
      end
      local sMi = sSelf:sub(11,12)
      local sS = sSelf:sub(13,14)
      return os.time({year=sY, month=sMo, day=sD, hour=sH, min=sMi, sec=sS})
   end
end

function node:HL7TStoDateString(sPattern)
   if self:nodeValue() == '' then
      return ''
   else
      local sSelf = self:nodeValue()
      local sY = sSelf:sub(1,4)
      local sMo = sSelf:sub(5,6)
      if sMo == '' then
         sMo = '01'
      end
      local sD = sSelf:sub(7,8)
      if sD == '' then
         sD = '01'
      end   
      local sH = sSelf:sub(9,10)
      if sH == '' then
         sH = '00'
      end
      local sMi = sSelf:sub(11,12)
      local sS = sSelf:sub(13,14)
      local tTime = os.time({year=sY, month=sMo, day=sD, hour=sH, min=sMi, sec=sS})
      return os.date(sPattern, tTime)
   end
end

function node:xAdd(sNodeName, sNodeValue, sNodeType)
   if self:nodeType() ~= 'element' then
      error('Not an XML node', 2)
      return nil
   else
      local xNode
      if sNodeType == 'E' then
         xNode = self:append(xml.ELEMENT, sNodeName)
      elseif sNodeType == 'A' then
         xNode = self:append(xml.ATTRIBUTE, sNodeName)
      elseif sNodeType == 'T' then
         xNode = self:append(xml.TEXT, sNodeName)
      elseif sNodeType == 'C' then
         xNode = self:append(xml.ELEMENT, sNodeName)
         xNode = xNode:append(xml.CDATA, sNodeName)
      else
         xNode = self:append(xml.ELEMENT, sNodeName)
      end
      
      if sNodeValue then         
         local s = sNodeValue .. ''
         if sNodeType ~= 'C' then           
            s = s:gsub('&', '&amp;')
            s = s:gsub('>', '&gt;')
            s = s:gsub('<', '&lt;')
            s = s:gsub('%%', '&#37;')
            s = s:gsub("'", '&apos;')
            s = s:gsub('"', '&quot;')
            s = s:gsub('\r', '&#xD;')
            s = s:gsub('\n', '&#xA;')
         end
         
         if pcall(function() xNode:setInner(s) end) then
         else
            xNode:setInner('Error: Binary content detected')
         end
      end
      return xNode
   end
end

function node:xGet(sNodeName)
   if self:nodeType() ~= 'element' then
      error('Not an xXML node', 2)
      return ''
   else
      if self[sNodeName] then
         return self[sNodeName][1]:S()
      else
         return ''
      end
   end
   
end

function node:xSet(sNodeValue)
   if self:nodeType() ~= 'element' then
      error('Not an xXML node', 2)
      return nil
   else
      if sNodeValue then
         if sNodeValue.nodeType then
            self:setInner(sNodeValue:S())
         else
            self:setInner(sNodeValue)
         end
      end
      return self
   end
end

function node:setSex()
   if self:nodeValue():upper() == 'M' then
      return 'Male'
   elseif self:nodeValue():upper() == 'F' then
      return 'Female'
   else
      return 'Unknown'
   end
end

function node:S()
   if self:isLeaf() then
      return self:nodeValue()
   else
      return tostring(self)
   end
end

function node:Q()
   if self:isLeaf() then
      return "'"..self:nodeValue():gsub("'", "''") .."'"
   else
      return "'"..tostring(self):gsub("'", "''").."'"
   end
end

function node:N()
   if self:isLeaf() then
      if tonumber(self:nodeValue()) == nil then
         return 0
      else
         return tonumber(self:nodeValue())
      end
   else
      error('Node is not a leaf.', 2)
   end
end

function node:cleanNode()
   if self:isLeaf() then
      return
   elseif self:nodeType() == 'field_repeated' then
      for nRepeat = 1, self:childCount() do
         self[nRepeat]:clearTrailing()
      end
      self:removeEmptyRepeats()
   elseif self:childCount() > 0 then 
      for nRepeat = 1, self:childCount() do
         self[nRepeat]:cleanNode()
      end
      self:clearTrailing()
   end
end

function node:toHL7Date()
   return self:S():gsub('[%s-:]', ''):left(8)
end

function node:toHL7TS()
   return self:S():gsub('[%s-:]', '')
end

function node:clearNode()
   if self:isLeaf() then
      error('Warning: Node is a leaf.', 2)
   else
      for nChild = self:childCount(), 1 , -1 do
         self:remove(nChild)
      end   
   end
end

function node:trimNode(nChildCount)
   if self:isLeaf() then
      error('Warning: Node is a leaf.', 2)
   else
      if not nChildCount then
         nChildCount = 0
      end
      for nChild = self:childCount(), nChildCount + 1 , -1 do
         self:remove(nChild)
      end
   end
end

function node:clearTrailing()
   for nChild = self:childCount(), 1 , -1 do
      if self[nChild]:isEmpty() then
         self:remove(nChild)
      else
         self[nChild]:clearTrailing()
      end
   end 
   return self
end

function node:isChild(xArg, nCount)
   local lFound = nil
   local nFoundCount = 0
   if type(xArg) == 'string' then
      for nNode = 1, self:childCount() do
         if not self[nNode]:isEmpty() and self[nNode]:nodeName() == xArg then
            nFoundCount = nFoundCount + 1
            if not nCount or nFoundCount == nCount then
               lFound = nNode
               break
            end
         end
      end
   elseif type(xArg) == 'number' then
      if self:childCount() >= xArg then
         lFound = true
      end
   end
   
   return lFound
end

function node:isEmpty()
   local lisEmpty = true
   if self and self:S() ~= '' then
      if self:nodeType():sub(1,7) ~= 'segment' or self:S():gsub('|', '') ~= self:nodeName() then
         lisEmpty = false
      end
   end
   return lisEmpty
end

function node:removeEmptyRepeats()
   if self:nodeType() == 'field_repeated' then
      local nRepeat = 1
      while nRepeat <= self:childCount() do
         if self[nRepeat]:isEmpty() then
            self:remove(nRepeat)
         else
            nRepeat = nRepeat + 1
         end
      end
   end
end

function node:repeatCount()
   if self:nodeType() == 'field_repeated' then
      local nCount = self:childCount()
      while nCount > 0 and self[nCount]:isEmpty() do
         nCount = nCount - 1
      end
      self:clearTrailing()
      return nCount
   else
      return 0
   end
end

-- node:getRepeat 
h = {}
h.Title = 'node:getRepeat'
h.Desc = 'Returns the repeat where a component matches a given value, such as "ID Type = MR"'
h.Usage = 'node:getRepeat(nComponentNumber, sMatchString)'
h.Parameters = {}
h.Parameters[1] = {}
h.Parameters[1].Component = {}
h.Parameters[1].Component.Desc = 'Number: the number of the component to compate to the value'
h.Parameters[1].Component.Opt = false
h.Parameters[1].MatchValue = {}
h.Parameters[1].MatchValue.Desc = 'String: the value in the component to be matched'
h.Parameters[1].Component.Opt = false
h.Returns = {}
h.Returns[1] = {}
h.Returns[1].Desc = 'Number: The count of the repeat where the value is in the specified component.'
help.set{input_function=node.getRepeat, help_data=h}

-- node.Q  
h = {}
h.Title = 'node:Q'
h.Desc = 'Returns the value of the node in quotes'
h.Usage = 'node:Q()'
h.Returns = {}
h.Returns[1] = {}
h.Returns[1].Desc = 'String: Value of node in quotes'
help.set{input_function=node.Q, help_data=h}

-- node.N  
h = {}
h.Title = 'node:N'
h.Desc = 'Returns the numerical value of the node'
h.Usage = 'node:Q()'
h.Returns = {}
h.Returns[1] = {}
h.Returns[1].Desc = 'Number: Value of node or nil if not a valid number'
help.set{input_function=node.N, help_data=h}

-- node.cleanNode  
h = {}
h.Title = 'node:cleanNode'
h.Desc = 'Iterates through node an cleans any empty trailing (sub)components or repeats'
h.Usage = 'node:cleanNode()'
help.set{input_function=node.cleanNode, help_data=h}

-- node.toHL7Date  
h = {}
h.Title = 'node:toHL7Date'
h.Desc = 'Returns date from a database in HL7 date string'
h.Usage = 'node:toHL7Date()'
h.Returns = {}
h.Returns[1] = {}
h.Returns[1].Desc = 'String: Value of database node in HL7 date format'
help.set{input_function=node.toHL7Date, help_data=h}

-- node.toHL7TS  
h = {}
h.Title = 'node:toHL7TS'
h.Desc = 'Returns a timestamp from a database in HL7 timestamp format'
h.Usage = 'node:toHL7TS()'
h.Returns = {}
h.Returns[1] = {}
h.Returns[1].Desc = 'String: Timestamp in HL7 format'
help.set{input_function=node.toHL7TS, help_data=h}

-- node.clearNode 
h = {}
h.Title = 'node:clearNode'
h.Desc = 'Clears all children from the node'
h.Usage = 'node:clearNode()'
help.set{input_function=node.clearNode, help_data=h}

-- node.trimNode 
h = {}
h.Title = 'node:trimNode'
h.Desc = 'Trims the children from a node'
h.Usage = 'node:trimNode(nMaxChildCount)'
h.Parameters = {}
h.Parameters[1] = {}
h.Parameters[1].ChildCount = {}
h.Parameters[1].ChildCount.Desc = 'Number: the number of children to preserve - trims all after this.'
h.Parameters[1].ChildCount.Opt = true
help.set{input_function=node.trimNode, help_data=h}

-- node.clearTrailing 
h = {}
h.Title = 'node:clearTrailing'
h.Desc = 'Clears all empty children from the end of the node'
h.Usage = 'node:clearTrailing()'
help.set{input_function=node.clearTrailing, help_data=h}

-- node.isChild 
h = {}
h.Title = 'node:isChild'
h.Desc = 'Identifies if a child exists by name or number'
h.Usage = 'node:isChild(sName) or node:isChild(nCount)'
h.Parameters = {}
h.Parameters[1] = {}
h.Parameters[1].ChildID = {}
h.Parameters[1].ChildID.Desc = 'String/Number: The name or count of the child'
h.Parameters[1].ChildID.Opt = false
h.Returns = {}
h.Returns[1] = {}
h.Returns[1].Desc = 'Number/Boolean: Returns true / false for numerical or the child number for name'
help.set{input_function=node.isChild, help_data=h}

-- node.isEmpty
h = {}
h.Title = 'node:isEmpty'
h.Desc = 'Checks if a node contains no value'
h.Usage = 'node:isEmpty()'
h.Returns = {}
h.Returns[1] = {}
h.Returns[1].Desc = 'Boolean: Returns true / false if the node is empty'
help.set{input_function=node.isEmpty, help_data=h}

-- node.removeEmptyRepeats
h = {}
h.Title = 'node:removeEmptyRepeats'
h.Desc = 'Removes any repeats with no value'
h.Usage = 'node:removeEmptyRepeats()'
help.set{input_function=node.removeEmptyRepeats, help_data=h}

-- node.repeatCount
h = {}
h.Title = 'node:repeatCount'
h.Desc = 'Returns the number of repeats in a node'
h.Usage = 'node:repeatCount()'
h.Returns = {}
h.Returns[1] = {}
h.Returns[1].Desc = 'Number: the number of repeats'
help.set{input_function=node.repeatCount, help_data=h}
