
function main(Message)
   local In = hl7.parse{vmd='example/demo.vmd', data=Message}
   local Out = hl7.message{vmd='example/demo.vmd', 
              name=In:nodeName()}
   Out:mapTree(In)
   Out.MSH[3][1] = 'Acme'
   queue.push{data=Out}
end