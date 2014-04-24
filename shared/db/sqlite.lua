-- DB helpers can go here

function connect()
   return db.connect{api=db.SQLITE, name='bedmonitor', live=true}
end
