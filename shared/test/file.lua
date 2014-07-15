if not test then test = {} end
test.file = {}

require 'stringutil'
require 'cm.config'

ut = test.file

function ut.testToNative()
   os.fs.name.toNative('C://blah')
   return true
end

function ut.testFromNative()
   local CTemp = os.fs.name.fromNative("C:\\Temp")
   local InNative = os.fs.name.toNative(CTemp)
end

function ut.testOpenFile()
   local FileName = os.fs.tempDir().."test.txt"
   local F = io.open(FileName, "w")
   F:write('Hello world!')
   F:close()
   F = io.open(FileName, "r")
   local C = F:read("*a")
   F:close()
   unittest.assertEqual(C, 'Hello world!')
end

function ut.testGlob()
   local TempDir = os.fs.tempDir()..'futscracth/'
   os.fs.cleanDir(TempDir)
   trace(TempDir)
   if not os.fs.dirExists(TempDir) then
      os.fs.mkdir(TempDir)
   end
   for i=1, 10 do
      local FileName = TempDir..i..'.txt'
      os.fs.writeFile(FileName, tostring(i))      
   end
   local Count = 0
   local Expected={}
   local Actual = {}
   for K in os.fs.glob(TempDir..'*') do
      trace(K)
      Count = Count + 1
      Expected[TempDir..Count..'.txt'] = true
      Actual[K] = true
   end
 
   trace(Expected)
   trace(Actual)
   for K, _ in pairs(Expected) do
      trace(K)
      unittest.assertEqual(Actual[K], true)
   end
   
   unittest.assertEqual(Count, 10)
   os.fs.mkdir(TempDir..'blah',777)
  
   os.fs.cleanDir(TempDir)
end

function ut.testExecute()
   if os.isWindows() then
      local CreatedFile = os.execute{dir='D:/temp/', command='touch', arguments = 'gggg.txt'}
      local P = io.popen{dir='D:/temp/', command='dir', arguments='/b'}
      local Content = P:read("*a")
      P:close()
      local List = Content:split('\n')
      local FoundFile = false
      for i = 1, #List do 
         if List[i] == 'gggg.txt' then
            FoundFile = true
         end
      end
      local RemovedFile = os.remove('D:/temp/gggg.txt')
      local FileExists = os.fs.access('D:/temp/gggg.txt')
      unittest.assertEqual(0, CreatedFile)
      unittest.assertEqual(true, RemovedFile)
      unittest.assertEqual(true, FoundFile)
      unittest.assertEqual(false, FileExists)
   end
end

return test.file