dup = require 'dup'

function main(Data)
   iguana.logInfo("Duplicate filter received message!")
   
   --lookback_amount is the amount of previous messages to lookback through for a duplicate.
   local Success = dup.isDuplicate{data=Data, lookback_amount= 800}
  
   if Success then
      iguana.logInfo('Found a Duplicate!')
      return    
   end

   queue.push{data=Data}
end