# Hospital Managment System
### DBMS Task

##### Database Deployment on your own PC:

 1. Optionally Drop `DropDB.sql` any previous databases named `HospitalMS` if any - *run with caution*
 2. Create a new Database `CreateDB`
 3. Run all the queries in `DeployDB` - You will have all the infrastructure ready for data input right away, refer to Logical Data entry steps **to avoid errors**.

##### Data Setup:

**Hospital Departments** are already filled with the most common Hospital Departments worldwide, So, **Nurses and Doctors data** should be entered right away.
Next, **Patients data** should be entered - *no dependencies here also*.

Upon entering Wardboys data, there should be **Rooms First**, where they should serve.

**Finally,** there would be a green light to startup the hospital and have:

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

4. Enter Hospital Room Data
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
	Departments 	IDs start with 6xxxxxxx		entity_name: Hos_Departments

To Search for an ID for a specific Entity:

    SELECT * FROM [entity_name]