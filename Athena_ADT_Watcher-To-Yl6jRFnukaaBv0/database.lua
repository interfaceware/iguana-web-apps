-- The purpose of this code is just to automatically create the SQLlite tables.  This is instead of going through
-- the context menu on athena.vmd to create the database tables that way.

function DoesTableExist(Database, Name)
   local R = Database:query{sql='SELECT * FROM sqlite_master WHERE type="table" and name="'..Name..'"', live=true}
   return #R == 1
end

function InitDb()
   local Database = GetDatabase()
   if not DoesTableExist(Database, "Patient") then
      Database:execute{sql="CREATE TABLE Patient (PatientId TEXT(255) NOT NULL ,FirstName TEXT(255),LastName TEXT(255),MiddleName TEXT(255),Sex TEXT(255),Address1 TEXT(255),Dob TEXT,Zip TEXT(255),City TEXT(255),DriversLicense TEXT(255),ContactMobilePhone TEXT(255),EmployerPhone TEXT(255),NextKinPhone TEXT(255),MobilePhone TEXT(255),Ssn TEXT(255),PRIMARY KEY (PatientId));", live=true}
   end
   if not DoesTableExist(Database, "PatientRace") then
      Database:execute{sql="CREATE TABLE PatientRace (PatientId TEXT(255) NOT NULL ,Race TEXT(255) NOT NULL ,PRIMARY KEY (PatientId,Race));", live=true}
   end
end