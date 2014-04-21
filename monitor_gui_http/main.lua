local dash = require 'dashboard.store'
-- The main function is the first function called from Iguana.
-- The Data argument will contain the message to be processed.
function main(Data)
   iguana.stopOnError(false)
   dash.serveRequest(Data)
end

function LoadOtherFile(FileName)
   FileName = iguana.project.files()["other/"..FileName]
   local F = io.open(FileName, "rb")
   local C = F:read("*a")
   F:close()
   return C
end