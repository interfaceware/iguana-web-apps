-- This filter script removes everything from the queue except ADT (Admit/Discharge/Transfer) messages.

-- For each incoming message, Iguana will call the 'main' function. 
-- Its argument is a raw string containing the unparsed message.

require 'node'  -- Add the shared module 'node' to this script

function main(RawMsgIn)
   -- Keep this channel running even in the event of error
   iguana.stopOnError(false)
   
   -- Parse incoming raw messages with the hl7.parse function.
   -- This will return the parsed message 'MsgIn' and message type 'MsgType'
   local MsgIn, MsgType = hl7.parse{vmd='example/demo.vmd', data=RawMsgIn}
   
   -- Build the outgoing HL7 Message template
   local MsgOut = hl7.message{vmd='example/demo.vmd', name=MsgType}
   
   -- Copy all fields from MsgIn to MsgOut
   MsgOut:mapTree(MsgIn)
   
   -- Filter the parsed messages for ADT messages, discarding all the others.
   
   if MsgType == 'ADT' then
      -- Push ADT messages back into the queue.      
      -- NOTE: We use the shorthand :S() notation to convert the 
      -- parsed message back to a string. 
      queue.push{data=MsgOut:S()}
   end 
end
