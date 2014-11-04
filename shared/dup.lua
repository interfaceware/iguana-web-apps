-- Duplicate module.  When a channel first starts or you edit this script this module will query the history of
-- messages off the channel log.  After that it maintains a linked list of MD5 hashes of messages in memory.  The algorithms
-- are intended to be efficient - lookups done using a hashmap and maintaining the list of messages to expire using a linked list.
-- Since the whole thing operates in memory after startup it should be fast and the use of MD5 hashes rather than storing the raw
-- messages themselves limits the amount of memory overhead.

local dup = {}

dup.UserName='admin'
dup.Password='password'

local Queue = {}
Queue.__index = Queue

function Queue.create()
  local q = {}
  setmetatable(q,Queue)
  q.size = 0
  q.head = nil
  q.tail = nil
  return q
end

-- Add node at end of queue
function Queue:enqueue(node)
  if self.size > 0 then
      self.tail.next = node
  else
      self.head      = node
  end
  self.tail = node
  self.size = self.size + 1
end

-- Remove node from front of queue and return it
function Queue:dequeue()
   if self.size > 0 then
      local removed = self.head
      self.head     = self.head.next
      self.size     = self.size - 1
      if self.size == 0 then self.tail = nil end
      return removed
   end
end

-- Retrieve node from front of queue without removing 
function Queue:peek()
   if self.size > 0 then return self.head end
end

-- Create a new Log Message node
function createMsgNode(Hash)
   return {hash=Hash, next=nil}
end

local function storeMessages(X)
   local LoggedMessage, LoggedMessageHash, LoggedMessageStamp = nil, nil, nil
   local numMessages = X.export:childCount('message')
   for i = numMessages, 1, -1  do
      LoggedMessage      = X.export:child("message", i).data:nodeValue()
      LoggedMessageHash  = util.md5(LoggedMessage)
      LoggedMessageStamp = X.export:child("message", i).time_stamp:nodeValue()
      
      --Store Message data in lookup and queue
      dup.lookup[LoggedMessageHash] = LoggedMessageStamp
      dup.queue:enqueue(createMsgNode(LoggedMessageHash)) 
   end    
   trace(dup.queue)   
end

local function fetchMessages(LookbackAmount)
   local protocol = iguana.webInfo().web_config.use_https and 'https' or 'http'
   local port     = iguana.webInfo().web_config.port
   trace(protocol) trace(port)
  
   local X = net.http.get{
      url    =  protocol .. '://localhost:' .. port .. '/api_query',         
      parameters = {
         username = dup.UserName, 
         password = dup.Password, 
         source = iguana.channelName(), 
         limit = LookbackAmount,
         type= 'messages',
         deleted = false,
         unique = 'true',
         reverse = 'true' 
      },
      live = true
   }
   X = xml.parse{data=X}
   return X
end

local function refreshStoredMessages(LookbackAmount)
   -- Remove oldest message so queue size equals lookback amount.
   if(dup.queue.size > LookbackAmount) then
      local removedMsg = dup.queue:dequeue()
      dup.lookup[removedMsg.hash] = nil
   end
end
   
local function getCurrentTimestamp()
   local  CurrentTime      = os.ts.gmtime()  
   local  CurrentTimestamp = os.ts.date("%Y/%m/%d %X", CurrentTime)
   return CurrentTimestamp
end

dup.lookup = {}
dup.queue = Queue.create()

function dup.isDuplicate(Params)
   -- Uncomment line below when testing annotations. 
   -- Will force queue to always be empty so fetch/store annotations
   -- can be viewed. 
   -- dup.queue = Queue.create()
   local Hash           = util.md5(Params.data)
   local LookbackAmount = Params.lookback_amount
   -- Populate in memory structures with lookbackAmount # of messages. 
   -- Messages are retrived from API in a table sorted newest -> oldest.
   if(dup.queue.size == 0) then
      iguana.logInfo('dup.lua: Fetching Initial Messages!')
      local messages = fetchMessages(LookbackAmount)
      iguana.logInfo('dup.lua: Storing Initial Messages!')
      storeMessages(messages)
      iguana.logInfo('dup.lua: Finished Initial fetch/store of '
         .. dup.queue.size .. ' messages!')
   else  
      refreshStoredMessages(LookbackAmount)
   end
   --Check if current message is in lookup table
   if dup.lookup[Hash] then
      return true
   else
      local timeStamp = getCurrentTimestamp()
      dup.lookup[Hash] = timeStamp
      dup.queue:enqueue(createMsgNode(Hash))
      trace(dup.queue.size)
      return false 
   end   
end

return dup