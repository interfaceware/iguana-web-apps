-- The main function is the first function called from Iguana.
-- The Data argument will contain the message to be processed.
local test = require 'test'

function main(Data)
   iguana.stopOnError(false)
   test.serveRequest(Data)
end