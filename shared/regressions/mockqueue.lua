local mockqueue = {}

local i = 1
local R= {}
local E= {}
local CurrentInput
local Success = {}

function mockqueue.reset()
   i = 1
   R = {}
end


function mockqueue.push(T)
   R[CurrentInput].output = tostring(T.data)   
end


function mockqueue.setCurrent(Input, Index, Name)
   CurrentInput = tostring(Input)
   R[Input]={output='filtered', i=Index, name=Name}
end

function mockqueue.setExpected(Expected)
   E = Expected   
end   

function mockqueue.results()
   return R
end

function mockqueue.compare()
   
end


return mockqueue