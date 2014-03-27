local zip = {}

function zip.expand(FileName, Dir)
   local Command = 'unzip '
   if (Dir) then
      Command = Command..' -u -d '..Dir..' '
   end
   Command = Command..FileName
   local P =io.popen(Command)
   local R =''
   repeat 
      D = P:read('*a')
      R = R..D
   until D == '' 
      
   P:close()
   return R
end

return zip