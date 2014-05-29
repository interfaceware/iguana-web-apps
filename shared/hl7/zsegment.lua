hl7.zsegment = {}

require 'stringutil'
require 'file'

local function RegisterHelp(Func, Path)
   if not iguana.isTest() then return end
   local HelpData = iguana.project.files()[Path]
   local T = json.parse{data=os.fs.readFile(HelpData)}
   help.set{input_function=Func, help_data=T}   
end


local function ParseDelim(Data, DelimArray, Index, Compact)
   if Index == 0 then
      return Data
   end
   local Children = Data:split(DelimArray[Index])
   local Result = {}
   if #Children > 1  then
      for i =1, #Children do
         Result[i] = ParseDelim(Children[i], DelimArray, Index-1, Compact)   
      end
   else
      if Compact then
         Result = ParseDelim(Data, DelimArray, Index-1, Compact)
      else
         Result[1] = ParseDelim(Data, DelimArray, Index-1, Compact)
      end
   end
   
   return Result
end

local function AddZSegment(List, Segment, Compact)
   local Fields = Segment:split('|')
   local SegmentName = Fields[1]
   for i=2, #Fields do 
      Fields[i-1] = ParseDelim(Fields[i], {'&','^','~'}, 3, Compact)
   end
   if not List[SegmentName] then
      List[SegmentName] = {} 
   end
   List[SegmentName][#List[SegmentName]+1] = Fields
end

function hl7.zsegment.parse(T)
   local Segments = T.data:split("\r")
   local ZSegments = {}
   for i = 1,#Segments do
      if Segments[i]:sub(1,1) == 'Z' then
         AddZSegment(ZSegments, Segments[i], T.compact)
      end
   end
   return ZSegments
end

RegisterHelp(hl7.zsegment.parse, "other/hl7/zsegment/parse.json")

