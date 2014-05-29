require 'hl7.zsegment'
require 'file'

local Xml=[[
<Kin firstName='' lastName=''/>
]]

-- This illustrates how we can make a generic module for parsing Z segments and avoid the need to edit a vmd
-- for custom Z segments.
--
-- Because we don't know the grammar of the segments this module gives us the choice of pushing all the data
-- down to the lowest level leaf (compact=false)  This is safest but makes for verbose paths
-- Or we can keep the data at a higher level (assuming there are not sub fields and repeating fields)

function main(Data)
   -- This show the compact parsing mode
   local CompactZED = hl7.zsegment.parse{data=Data, compact=true}   
   local X = xml.parse{data=Xml}
   X.Kin.firstName = CompactZED.ZID[1][2][2][1]
  
   -- This shows the non compact parsing mode
   local ExpandedZED = hl7.zsegment.parse{data=Data, compact=false}
   X.Kin.firstName = ExpandedZED.ZID[1][2][2][1][1]
end