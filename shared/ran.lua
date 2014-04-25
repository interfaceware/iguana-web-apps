ran = {}

function ran.scrubMSH(MSH)
   MSH[3][1] = ran.choose(ran.Application)
   MSH[4][1] = ran.choose(ran.Facility)
   MSH[5][1] = 'Main HIS'
   MSH[6][1] = 'St. Micheals'
   MSH[7][1] = ran.TimeStamp()
   MSH[9][1] = 'ADT'
   MSH[9][2] = ran.choose(ran.Event)
   MSH[10] = util.guid(256)
   MSH[11][1] = 'P'
   MSH[12][1] = '2.6'
   MSH:S()
end

function ran.scrubEVN(EVN)
   EVN[2][1] = ran.TimeStamp()
   EVN[6][1] = ran.TimeStamp()
end

function ran.scrubPID(PID)
   PID[3][1][1] = math.random(9999999)
   ran.NameAndSex(PID)
   PID[5][1][1][1] = ran.lastName()
   PID[7][1] = ran.Date()
   PID[10][1][1] = ran.choose(ran.Race)
   PID[18][1] = ran.AcctNo()
   PID[11][1][3], PID[11][1][4] = ran.location()
   PID[11][1][5] = math.random(99999)
   PID[11][1][1][1] = math.random(999)..
      ' '..ran.choose(ran.Street)
   PID[19] = ran.SSN()
   PID:S()
end

function ran.PV1(PV1)
   PV1[8][1][2][1] = ran.lastName()
   PV1[8][1][3] = ran.firstName()
   PV1[8][1][4] = 'F'
   PV1[19][1] = math.random(9999999)
   PV1[44][1] = ran.TimeStamp()
   PV1[3][1] = "emergency_room"
   PV1[3][3] = ran.choose(ran.BedEmerg)
   --[[
   PV1[3][1] = ran.choose(ran.PointOfCare)
   if PV1[3][1]:S() == 'emergency_room' then
      PV1[3][3] = ran.choose(ran.BedEmerg)
   elseif PV1[3][1]:S() == 'burn_ward' then
      PV1[3][3] = ran.choose(ran.BedBurn)
   elseif PV1[3][1]:S() == 'intensive_care_unit' then
      PV1[3][3] = ran.choose(ran.BedICU)
   elseif PV1[3][1]:S() == 'long_term_care' then
      PV1[3][3] = ran.choose(ran.BedLTC)
   elseif PV1[3][1]:S() == 'acute_cardiovascular_unit' then
      PV1[3][3] = ran.choose(ran.BedCardio)
   elseif PV1[3][1]:S() == 'childrens_ward' then
      PV1[3][3] = ran.choose(ran.BedChildrens)
   end
   --]]
   PV1:S()
end

function ran.NK1(NK1)
   for i = 1, math.random(6) do
      NK1[i][1] = i
      ran.Kin(NK1[i])
   end
end

function ran.Kin(NK1)
   NK1[2][1][1][1] = ran.lastName()  
   NK1[2][1][2] = ran.firstName()
   NK1[3][1] = ran.choose(ran.Relation)
end

ran.Sex = {'M', 'F'}

ran.LastNames = {'Muir','Smith','Adams','Garland', 'Meade', 'Fitzgerald', 'White'}
ran.MaleNames = {'Fred','Jim','Gary','John'}
ran.FemaleNames = {'Mary','Sabrina','Tracy'}
ran.Race = {'AI', 'EU', 'Mixed', 'Martian', 'Unknown'}
ran.Street = {'Delphi Cres.', 'Miller Lane', 'Yonge St.', 'Main Rd.'}
ran.Relation = {'Grandchild', 'Second Cousin', 'Sibling', 'Parent'}
ran.Event = {'A01', 'A03', 'A04', 'A05', 'A06', 'A07', 'A08'}
ran.Facility = {'Lab', 'E&R'}
ran.Application = { 'AcmeMed', 'MedPoke', 'CowZing' }

--
-- Random values for Bed Monitor app
--
--ran.PointOfCare = {'emergency_room', 'burn_ward', 'intensive_care_unit', 'long_term_care','acute_cardiovascular_unit', 'childrens_ward'}
ran.BedEmerg = {'100', '101', '102', '103', '104', '105', '106', '107', '108', '109'}
ran.BedBurn  = {'110' ,'111' ,'112' ,'113' ,'114' ,'115' ,'116' ,'117' ,'118' ,'119'}
ran.BedICU = {'120' ,'121' ,'122' ,'123' ,'124' ,'125' ,'126' ,'127' ,'128' ,'129'}
ran.BedLTC = {'130' ,'131' ,'132' ,'133' ,'134' ,'135' ,'136' ,'137' ,'138' ,'139'}
ran.BedCardio = {'140' ,'141' ,'142' ,'143' ,'144' ,'145' ,'146' ,'147' ,'148' ,'149'}
ran.BedChildrens = {'150' ,'151' ,'152' ,'153' ,'154' ,'155' ,'156' ,'157' ,'158' ,'159'}

ran.Conditions = {'Heart Palpitations', 'Dizziness', 'Numbness', 'Blurred Vision', 'Acute Stomach Pain', 'Stroke', 'Tuberculosis', 'Vomiting', 'Head Trauma', 'Lacerations', 'Burns', 'Poisoning'}

function ran.lastName() return ran.choose(ran.LastNames) end

function ran.choose(T)
   return T[math.random(#T)]
end

function ran.NameAndSex(PID)
   if math.random(2) == 1 then
      PID[8] = 'M'
      PID[5][1][2] = ran.choose(ran.MaleNames)
   else   
      PID[8] = 'F'
      PID[5][1][2] = ran.choose(ran.FemaleNames)      
   end
end

function ran.firstName()
   if math.random(2) == 1 then
      return ran.choose(ran.MaleNames)
   else   
      return ran.choose(ran.FemaleNames)      
   end
end

function ran.Date()
   local T = os.date('*t')
  
   local newDate = '19'..rand(T.year,99,2)..
   rand(T.month,12,2)..
   rand(T.day,29,2)
   
   return newDate
end

function ran.TimeStamp()
   local T = os.date('*t')
   
   local newDate = '20'..rand(T.year,tostring(T.year):sub(-2),2)..
   rand(T.month,12,2)..
   rand(T.day,29,2)..
   rand(T.hour,12,2)..
   rand(T.min,60,2)..
   rand(T.sec,60,2)
   
   return newDate
end

function ran.AcctNo()
   return math.random(99)..'-'..math.random(999)..'-'..math.random(999)
end

ran.Locations = { {'Chicago', 'IL'}, {'Toronto', 'ON'}, {'ST. LOUIS', 'MO'}, {'LA', 'CA'} }

function ran.location()
   local R = ran.choose(ran.Locations)
   return R[1], R[2]
end

function ran.SSN()
   return math.random(999)..'-'
          ..math.random(999)..'-'
          ..math.random(999)
end

function ran.addWeight(Out)
   local OBX = Out.OBX[#Out.OBX+1]
   OBX[3][1] = ''
   OBX[3][1] = 'WT'
   OBX[5][1][1] = math.random(100) + 30
   OBX[6][1] = 'pounds'
   return OBX
end
   
function ran.addHeight(Out)
   local OBX = Out.OBX[#Out.OBX+1]
   OBX[3][1] = 'HT'
   OBX[3][2] = 'HEIGHT'
   OBX[5][1][1] = math.random(100) + 20
   OBX[6][1] = 'cm'
   return OBX
end

function ran.addCondition(Out)
   local OBX = Out.OBX[#Out.OBX+1]
   OBX[3][1] = 'CD'
   OBX[3][2] = 'CONDITION'
   OBX[5][1][2] = ran.choose(ran.Conditions)
   return OBX
end

function ran.RandomMessage()
   local Out = hl7.message{vmd='ran/demo.vmd', name='ADT'} 
   ran.scrubMSH(Out.MSH)
   ran.scrubEVN(Out.EVN)
   ran.scrubPID(Out.PID)
   ran.PV1(Out.PV1)
   ran.NK1(Out.NK1)
   ran.addWeight(Out)
   ran.addHeight(Out)
   ran.addCondition(Out)
   return Out:S()   
end

function rand(In, Max, Size)
   
   local Result = tostring((In + math.random(Max)) % Max)
   if '0' == Result then
      Result = '1'
   end
   
   while Size > Result:len() do
      Result = '0'..Result
   end
   
   return Result
end

