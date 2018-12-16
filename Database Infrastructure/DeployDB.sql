	USE HospitalMS
	GO

	-- -----------------------------------------------------------------------------------------------------------------------------------------------------------

	CREATE TABLE Hos_Departments(
		DepId		INT			NOT NULL PRIMARY KEY IDENTITY(6000000,1),
		DepName		VARCHAR(50)	NOT NULL,
		)


	USE [HospitalMS]
	GO
	SET IDENTITY_INSERT [dbo].[Hos_Departments] ON 

	INSERT [dbo].[Hos_Departments] ([DepId], [DepName]) VALUES (6000000, N'Out-Patient Clinic')
	INSERT [dbo].[Hos_Departments] ([DepId], [DepName]) VALUES (6000001, N'Anesthetics')
	INSERT [dbo].[Hos_Departments] ([DepId], [DepName]) VALUES (6000002, N'Cardiology')
	INSERT [dbo].[Hos_Departments] ([DepId], [DepName]) VALUES (6000003, N'Critical care')
	INSERT [dbo].[Hos_Departments] ([DepId], [DepName]) VALUES (6000004, N'Dentistry')
	INSERT [dbo].[Hos_Departments] ([DepId], [DepName]) VALUES (6000005, N'Ear, Nose, and Throat')
	INSERT [dbo].[Hos_Departments] ([DepId], [DepName]) VALUES (6000006, N'Emergency')
	INSERT [dbo].[Hos_Departments] ([DepId], [DepName]) VALUES (6000007, N'General surgery')
	INSERT [dbo].[Hos_Departments] ([DepId], [DepName]) VALUES (6000008, N'Gynecology')
	INSERT [dbo].[Hos_Departments] ([DepId], [DepName]) VALUES (6000009, N'Internal Medicine')
	INSERT [dbo].[Hos_Departments] ([DepId], [DepName]) VALUES (6000010, N'Laboratory')
	INSERT [dbo].[Hos_Departments] ([DepId], [DepName]) VALUES (6000011, N'Neurology')
	INSERT [dbo].[Hos_Departments] ([DepId], [DepName]) VALUES (6000012, N'Ophthalmology')
	INSERT [dbo].[Hos_Departments] ([DepId], [DepName]) VALUES (6000013, N'Orthopedic')
	INSERT [dbo].[Hos_Departments] ([DepId], [DepName]) VALUES (6000014, N'Pediatric')
	INSERT [dbo].[Hos_Departments] ([DepId], [DepName]) VALUES (6000015, N'Pharmacy')
	INSERT [dbo].[Hos_Departments] ([DepId], [DepName]) VALUES (6000016, N'Physiotherapy')
	INSERT [dbo].[Hos_Departments] ([DepId], [DepName]) VALUES (6000017, N'Radiology')
	INSERT [dbo].[Hos_Departments] ([DepId], [DepName]) VALUES (6000018, N'Urology')
	SET IDENTITY_INSERT [dbo].[Hos_Departments] OFF

	-- -----------------------------------------------------------------------------------------------------------------------------------------------------------

	CREATE TABLE Ent_Patient(
		Pid			INT			IDENTITY(1000000,1) NOT NULL PRIMARY KEY,
		Pname		VARCHAR(50)	NOT NULL,
		Pnumber		VARCHAR(50),											--Maybe the patient is child, or for some reason doesn't have a telephone number
		Pdisease	VARCHAR(50)	NOT NULL,
		PdayIn		DATE		NOT NULL	DEFAULT GETDATE(),
		PdayOut		DATE,													--Maybe it is still not known for that patient when will he recover
		PisAssigned BIT NOT NULL DEFAULT 0,
		Pdep		INT			NOT NULL DEFAULT 6000000,					--If a value is not given, she's at OPC

		CONSTRAINT FK_EntPat_HosDep 
		FOREIGN KEY (Pdep) 
		REFERENCES Hos_Departments (DepId)
	)

	


	-- -----------------------------------------------------------------------------------------------------------------------------------------------------------

	CREATE TABLE Ent_Doctor(
		DocId			INT			IDENTITY(2000000,1) NOT NULL PRIMARY KEY,
		DocName			VARCHAR(50)	NOT NULL,
		WorksIn			INT			NOT NULL DEFAULT 6000000,					--If a value is not given, he's a GP, he can work in the OPC
	
		CONSTRAINT FK_EntDoc_HosDep 
		FOREIGN KEY (WorksIn) 
		REFERENCES Hos_Departments (DepId)
		)

	/*ALTER TABLE Ent_Doctor ADD CONSTRAINT FK_EntDoc_HosDep
	FOREIGN KEY (WorksIn) References Hos_Departments(DepId)*/					--Another way for FK

	-- -----------------------------------------------------------------------------------------------------------------------------------------------------------

	CREATE TABLE Ent_Nurse(
		NurId			INT			IDENTITY(3000000,1) NOT NULL PRIMARY KEY,
		NurName			VARCHAR(50)	NOT NULL,
		WorksIn			INT			NOT NULL DEFAULT 6000000,					--If a value is not given, she's at OPC
	
		CONSTRAINT FK_EntNur_HosDep 
		FOREIGN KEY (WorksIn) 
		REFERENCES Hos_Departments (DepId)
		)

	/*ALTER TABLE Ent_Doctor ADD CONSTRAINT FK_EntDoc_HosDep
	FOREIGN KEY (WorksIn) References Hos_Departments(DepId)*/					--Another way for FK

	-- -----------------------------------------------------------------------------------------------------------------------------------------------------------

	/*Works In Relationship was replaced with a column in the tables Nurses & Doctors for simplicity,
	  since any new Worker will be immediately assigned to a department, or just the GP*/

	-- -----------------------------------------------------------------------------------------------------------------------------------------------------------

	CREATE TABLE Rel_Serves(
		NurId		INT	NOT NULL,
		Pid			INT	NOT NULL,

		CONSTRAINT FK_Serves_EntNur 
		FOREIGN KEY (NurId) 
		REFERENCES Ent_Nurse (NurId),

		CONSTRAINT FK_Serves_EntPat 
		FOREIGN KEY (Pid) 
		REFERENCES Ent_Patient (Pid),
		
		PRIMARY KEY (NurId, Pid)
		)

	-- -----------------------------------------------------------------------------------------------------------------------------------------------------------

	CREATE TABLE Rel_Treats(
		DocId		INT	NOT NULL,
		Pid			INT	NOT NULL	UNIQUE,										-- When a patient is being treated by one doctor,
		Treatment	VARCHAR(200),												-- it should not be reentered and paired with another doctor

		CONSTRAINT FK_Treats_EntDoc 
		FOREIGN KEY (DocId) 
		REFERENCES Ent_Doctor (DocId),

		CONSTRAINT FK_Treats_EntPat 
		FOREIGN KEY (Pid) 
		REFERENCES Ent_Patient (Pid),

		PRIMARY KEY (DocId, Pid)
		)

	-- -----------------------------------------------------------------------------------------------------------------------------------------------------------

	CREATE TABLE Hos_Room_Types(
		TypeId		INT			IDENTITY(1,1) NOT NULL PRIMARY KEY,
		TypeName	VARCHAR(50)	NOT NULL
		)

	INSERT INTO Hos_Room_Types Values('Ward')
	INSERT INTO Hos_Room_Types Values('ICU')
	INSERT INTO Hos_Room_Types Values('OPT')

	-- -----------------------------------------------------------------------------------------------------------------------------------------------------------

	CREATE TABLE Hos_Room(
		RmId		INT			IDENTITY(5000000,1) NOT NULL PRIMARY KEY,
		RmType		INT			NOT NULL,
		RmDep		INT			NULL DEFAULT 6000000,							--Optional Relation if a specific room is related ONLY to a specific department
																				--If not related, let it be a general room, namely OPC room (also for simplicity)
		CONSTRAINT FK_HosRoom_RoomType 
		FOREIGN KEY (RmType) 
		REFERENCES Hos_Room_Types (TypeId),

		CONSTRAINT FK_HosRoom_RoomDep 
		FOREIGN KEY (RmDep) 
		REFERENCES Hos_Departments (DepId)
		)



DECLARE @index int = 0;
WHILE (@index<5)
BEGIN
	INSERT INTO Hos_Room VALUES (1, 6000000)
	INSERT INTO Hos_Room VALUES (2, 6000000)
	INSERT INTO Hos_Room VALUES (3, 6000000)
	
	INSERT INTO Hos_Room VALUES (2, 6000001)
	
	
	INSERT INTO Hos_Room VALUES (2, 6000002)
	INSERT INTO Hos_Room VALUES (3, 6000002)
	INSERT INTO Hos_Room VALUES (1, 6000003)
	INSERT INTO Hos_Room VALUES (2, 6000003)
	INSERT INTO Hos_Room VALUES (3, 6000003)
	INSERT INTO Hos_Room VALUES (1, 6000004)
	INSERT INTO Hos_Room VALUES (2, 6000004)
	INSERT INTO Hos_Room VALUES (3, 6000004)
	INSERT INTO Hos_Room VALUES (1, 6000005)
	INSERT INTO Hos_Room VALUES (2, 6000005)
	INSERT INTO Hos_Room VALUES (3, 6000005)
	INSERT INTO Hos_Room VALUES (1, 6000006)
	INSERT INTO Hos_Room VALUES (2, 6000006)
	INSERT INTO Hos_Room VALUES (3, 6000006)
	INSERT INTO Hos_Room VALUES (1, 6000007)
	INSERT INTO Hos_Room VALUES (2, 6000007)
	INSERT INTO Hos_Room VALUES (3, 6000007)
	INSERT INTO Hos_Room VALUES (1, 6000008)
	INSERT INTO Hos_Room VALUES (2, 6000008)
	INSERT INTO Hos_Room VALUES (3, 6000008)
	INSERT INTO Hos_Room VALUES (1, 6000009)
	INSERT INTO Hos_Room VALUES (2, 6000009)
	INSERT INTO Hos_Room VALUES (3, 6000009)
	


	INSERT INTO Hos_Room VALUES (1, 6000011)
	INSERT INTO Hos_Room VALUES (2, 6000011)
	INSERT INTO Hos_Room VALUES (3, 6000011)
	INSERT INTO Hos_Room VALUES (1, 6000012)
	INSERT INTO Hos_Room VALUES (2, 6000012)
	INSERT INTO Hos_Room VALUES (3, 6000012)
	INSERT INTO Hos_Room VALUES (1, 6000013)
	INSERT INTO Hos_Room VALUES (2, 6000013)
	INSERT INTO Hos_Room VALUES (3, 6000013)
	INSERT INTO Hos_Room VALUES (1, 6000014)
	INSERT INTO Hos_Room VALUES (2, 6000014)
	INSERT INTO Hos_Room VALUES (3, 6000014)
	


	INSERT INTO Hos_Room VALUES (1, 6000016)
	INSERT INTO Hos_Room VALUES (2, 6000016)
	INSERT INTO Hos_Room VALUES (3, 6000016)
	INSERT INTO Hos_Room VALUES (1, 6000017)
	INSERT INTO Hos_Room VALUES (2, 6000017)
	INSERT INTO Hos_Room VALUES (3, 6000017)
	INSERT INTO Hos_Room VALUES (1, 6000018)
	INSERT INTO Hos_Room VALUES (2, 6000018)
	INSERT INTO Hos_Room VALUES (3, 6000018)

SET @index = @index +1;
END

	-- -----------------------------------------------------------------------------------------------------------------------------------------------------------

	CREATE TABLE Rel_AdmittedIn(
		RmId		INT	NOT NULL,
		Pid			INT	NOT NULL	UNIQUE,										-- When a patient is being treated by one doctor,
																				-- it should not be reentered and paired with another doctor
		CONSTRAINT FK_AdmittedIn_RoomId 
		FOREIGN KEY (RmId) 
		REFERENCES Hos_Room (RmId),

		CONSTRAINT FK_AdmittedIn_EntPat 
		FOREIGN KEY (Pid) 
		REFERENCES Ent_Patient (Pid),

		PRIMARY KEY (RmId, Pid)
		)

	-- -----------------------------------------------------------------------------------------------------------------------------------------------------------

	CREATE TABLE Ent_Wardboy(
		WarId			INT			IDENTITY(4000000,1) NOT NULL PRIMARY KEY,
		WarName			VARCHAR(50)	NOT NULL,
		Maintains		INT			NOT NULL DEFAULT 5000000,
	
		CONSTRAINT FK_EntWar_RoomId 
		FOREIGN KEY (Maintains) 
		REFERENCES Hos_Room (RmId)
		)

	/*Maintains Relationship was replaced with a column in the table Wardboy for simplicity,
	  since any new Worker will be immediately assigned to a room*/