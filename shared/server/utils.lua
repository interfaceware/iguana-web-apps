
local utils = {}

function utils.loadOtherFile(FileName)   
   FileName = iguana.project.files()["other/"..FileName:sub(17)]
   if FileName then
      local F = io.open(FileName, "rb")
      local C = F:read("*a")
      F:close()
      return C
   end
end

function utils.loadSharedFile(FileName)
   FileName = iguana.project.files()["shared/"..FileName]
   if FileName then
      local F = io.open(FileName, "r")
      local C = F:read("*a")
      F:close()
      return C
   end
end

return utils
