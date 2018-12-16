# Hospital Managment System
### DBMS Task

##### Database Deployment on your own PC:

 1. Optionally Drop `DropDB.sql` any previous databases named `HospitalMS` if any - *run with caution*
 2. Create a new Database `CreateDB`
 3. Run all the queries in `DeployDB` - You will have all the infrastructure ready for data input right away, refer to Logical Data entry steps **to avoid errors**.
 4. Create all the Stored Procedures to be used in the ASP.net project correctly.
	 - `StoredProcedureCalculateDays.sql` for bill calculations
	 - `StoredProcedureDisadmittPatient` for patient deletion from database - **NOTE**: *this script contains a transaction* 
	 - `StoredProcedureSearchPatients` for searching patients effeciently, without entering all the needed Entity attributs.
 5.  `BasicInsertions` for initiallizing the database by test data.
 6. `KillATransaction` just contains the code needed if the system is halted by an ongoing transaction. Don't use it unless needed.

##### Backend Server Deployment on your own PC:

 - Just place the folder in a suitable place on your hard disk and open the solution using the `.sln` file. Then run the *Debugger* on Visual Studio 2017.
 - This will initialize the solution with the needed packages if they are installed.

##### Introductory Youtube Video: https://youtu.be/ww1DwIGYCaw

##### ER Model for the database:

![ERD Model](https://i.imgur.com/mMz6e2S.png)

##### Data Setup (Direct Insertions via SQL Server):

**Database** is already filled with the most common Hospital Departments worldwide and is initialized with about 200 room of different types. So, **Nurses, Doctors, Wardboys, and Patients data** should be entered right away.

**Next,** there would be a green light to startup the hospital and have:

 - Patients ***ADMITTED*** to Rooms
 - Doctors ***TREAT*** Patients
 - Nurses ***SERVE*** Patients  
 
##### Logical Data Entry Steps:

1. Enter Nurse Data
`INSERT INTO Ent_Nurse (NurName, WorksIn) VALUES (.., ..);`
2. Enter Doctors Data
`INSERT INTO Ent_Doctor (DocName, WorksIn) VALUES (.., ..);`

	##### `WorksIn`: Takes Values from 6000000 to 6000018 (Each Department has a value 6xxxx01 to 6xxxx18, and 6xxxx00 is a general Department for unknown info)

3. Enter Patients Data
`INSERT INTO Ent_Patient (Pname, Pnumber, Pdisease, PdayIn, PdayOut) VALUES (.., .., .., .., ..);`
	##### `PdatOut`, `Pnumber` are optional

4. Enter Hospital Room Data (*For additional rooms*)
`INSERT INTO Hos_Room (RmType, RmDep) VALUES (.., ..);`
	##### `RmType`: Takes values 1, 2, and 3 for Ward, ICU, and OPT respectivly
	##### `RmDep`: is an optional Field, Takes values from 6000000 to 6000018

5. Enter Wardboys data
`INSERT INTO Ent_Wardboy (WarName, Maintains) VALUES (.., ..);`

6. Enter Admission Data
`INSERT INTO Rel_AdmittedIn (RmId, Pid) VALUES (.., ..);`
	##### `RmId`: Room ID from step 4
	##### `Pid`: Patient ID from step 3

7. Enter Treatment Data
`INSERT INTO Rel_Treats (DocId, Pid, Treatment) VALUES (.., .., ..);`
	##### `DocId`: Doctor Id from step 2
	##### `Pid`: Patient Id from step 3
Treatment: Optional field, used as a 'notes about treatment and medicine' field

8. Enter Service Data
`INSERT INTO Rel_Serves (NurId, Pid) VALUES (.., ..);`
	##### `NurId`: Nurse Id from step 1
	##### `Pid`: Patient Id from step 3




NOTE: 	All IDs in the database are automatically generated, the database is supposed to hold 999,999 data entry in each table.

	Patients 		IDs start with 1xxxxxxx		entity_name: Ent_Patient
	Doctors			IDs start with 2xxxxxxx		entity_name: Ent_Doctor 
	Nurses   		IDs start with 3xxxxxxx		entity_name: Ent_Nurse 
	Wardboys 		IDs start with 4xxxxxxx		entity_name: Ent_Wardboy 
	Room     		IDs start with 5xxxxxxx		entity_name: Hos_Room 
	Departments 		IDs start with 6xxxxxxx		entity_name: Hos_Departments

To Search for an ID for a specific Entity:

    SELECT * FROM [entity_name]
------------------
*Features of the web interface to be added in the next README.md update.*
