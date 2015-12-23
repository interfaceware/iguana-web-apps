require 'stringutil'
require 'jsonhelp'
require 'database'

map = require 'athena.mapPatient'
-- In this channel we process the patients we get off the wire.
-- We'll enter the data into a set of database tables.  The database
-- tables are defined in a schema file called a 'vmd file'.
--
-- This can edited using a windows program called Chameleon that comes with Iguana.


function GetDatabase()
   return db.connect{api=db.SQLITE, name='patient_info'}
end
   
function main(Data)
   InitDb()
   local Patient = json.parse{data=Data}
   -- We instantiate a set of table rows to populate
   local T = db.tables{vmd='athena.vmd', name='Tables'}
   map.Patient(T.Patient[1], Patient)
   trace(T)
   local Database = GetDatabase()
   Database:merge{data=T}
end
