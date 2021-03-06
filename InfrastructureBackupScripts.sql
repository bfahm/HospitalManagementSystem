USE [master]
GO
/****** Object:  Database [HospitalMS]    Script Date: 12/16/2018 5:17:36 AM ******/
CREATE DATABASE [HospitalMS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HospitalMS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.TESTINSTANCE\MSSQL\DATA\HospitalMS.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'HospitalMS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.TESTINSTANCE\MSSQL\DATA\HospitalMS_log.ldf' , SIZE = 784KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [HospitalMS] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HospitalMS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HospitalMS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HospitalMS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HospitalMS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HospitalMS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HospitalMS] SET ARITHABORT OFF 
GO
ALTER DATABASE [HospitalMS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HospitalMS] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [HospitalMS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HospitalMS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HospitalMS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HospitalMS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HospitalMS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HospitalMS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HospitalMS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HospitalMS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HospitalMS] SET  ENABLE_BROKER 
GO
ALTER DATABASE [HospitalMS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HospitalMS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HospitalMS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HospitalMS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HospitalMS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HospitalMS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HospitalMS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HospitalMS] SET RECOVERY FULL 
GO
ALTER DATABASE [HospitalMS] SET  MULTI_USER 
GO
ALTER DATABASE [HospitalMS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HospitalMS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HospitalMS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HospitalMS] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'HospitalMS', N'ON'
GO
USE [HospitalMS]
GO
/****** Object:  StoredProcedure [dbo].[sp_calculate_days_till_date]    Script Date: 12/16/2018 5:17:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_calculate_days_till_date] 
@PatientID int
--,@Bill int OUT
AS
BEGIN
DECLARE @DaysSince int;
DECLARE @HisDayIn Date = (SELECT PdayIn FROM Ent_Patient where Pid = @PatientID);
DECLARE @HisDayOut Date= (SELECT PdayOut FROM Ent_Patient where Pid = @PatientID);

IF (@HisDayOut IS NULL)
BEGIN
	--SELECT @Bill = (
		SELECT DATEDIFF(Day,@HisDayIn,GETDATE()) as DateDiff
	--);
END

ELSE
BEGIN
	--SELECT @Bill = (
		SELECT DATEDIFF(Day,@HisDayIn,@HisDayOut) as DateDiff
	--);
END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_disadmit_patient]    Script Date: 12/16/2018 5:17:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_disadmit_patient]
@PatientID int,
@output int out
AS

BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE Ent_Patient SET PdayOut = GETDATE()
			WHERE Pid = @PatientID ;

			UPDATE Ent_Patient SET PisAssigned = 0
			WHERE Pid = @PatientID ;

			DELETE FROM Rel_Serves 
			WHERE Pid = @PatientID ;		--Its okay if no patients where found

			DELETE FROM Rel_Treats 
			WHERE Pid = @PatientID ;		--Its okay if no patients where found
		COMMIT TRANSACTION
		SET @output = 1;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		SET @output = -1;
	END CATCH
END







GO
/****** Object:  StoredProcedure [dbo].[sp_search_patients]    Script Date: 12/16/2018 5:17:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_search_patients]
@Id int = NULL,
@Name nvarchar(50) = NULL,
@Number nvarchar(50) = NULL,
@Count int out

AS
BEGIN
	SELECT * FROM Ent_Patient
	WHERE	(Pid = @Id OR @Id is NULL) AND
			(Pname = @Name OR @Name is NULL) AND
			(Pnumber = @Number OR @Number is NULL) 
			--AND(Pdisease = @Disease OR @Disease is NULL)

	SELECT @Count = (SELECT COUNT(*) FROM Ent_Patient
	WHERE	(Pid = @Id OR @Id is NULL) AND
			(Pname = @Name OR @Name is NULL) AND
			(Pnumber = @Number OR @Number is NULL))
	
END
GO
/****** Object:  Table [dbo].[Ent_Doctor]    Script Date: 12/16/2018 5:17:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ent_Doctor](
	[DocId] [int] IDENTITY(2000000,1) NOT NULL,
	[DocName] [varchar](50) NOT NULL,
	[WorksIn] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DocId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ent_Nurse]    Script Date: 12/16/2018 5:17:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ent_Nurse](
	[NurId] [int] IDENTITY(3000000,1) NOT NULL,
	[NurName] [varchar](50) NOT NULL,
	[WorksIn] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NurId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ent_Patient]    Script Date: 12/16/2018 5:17:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ent_Patient](
	[Pid] [int] IDENTITY(1000000,1) NOT NULL,
	[Pname] [varchar](50) NOT NULL,
	[Pnumber] [varchar](50) NULL,
	[Pdisease] [varchar](50) NOT NULL,
	[PdayIn] [date] NOT NULL,
	[PdayOut] [date] NULL,
	[PisAssigned] [bit] NOT NULL,
	[Pdep] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Pid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ent_Wardboy]    Script Date: 12/16/2018 5:17:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ent_Wardboy](
	[WarId] [int] IDENTITY(4000000,1) NOT NULL,
	[WarName] [varchar](50) NOT NULL,
	[Maintains] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[WarId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Hos_Departments]    Script Date: 12/16/2018 5:17:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Hos_Departments](
	[DepId] [int] IDENTITY(6000000,1) NOT NULL,
	[DepName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DepId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Hos_Room]    Script Date: 12/16/2018 5:17:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hos_Room](
	[RmId] [int] IDENTITY(5000000,1) NOT NULL,
	[RmType] [int] NOT NULL,
	[RmDep] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RmId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Hos_Room_Types]    Script Date: 12/16/2018 5:17:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Hos_Room_Types](
	[TypeId] [int] IDENTITY(1,1) NOT NULL,
	[TypeName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Rel_AdmittedIn]    Script Date: 12/16/2018 5:17:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rel_AdmittedIn](
	[RmId] [int] NOT NULL,
	[Pid] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RmId] ASC,
	[Pid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Pid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Rel_Serves]    Script Date: 12/16/2018 5:17:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rel_Serves](
	[NurId] [int] NOT NULL,
	[Pid] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NurId] ASC,
	[Pid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Rel_Treats]    Script Date: 12/16/2018 5:17:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Rel_Treats](
	[DocId] [int] NOT NULL,
	[Pid] [int] NOT NULL,
	[Treatment] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[DocId] ASC,
	[Pid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Pid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Ent_Doctor] ADD  DEFAULT ((6000000)) FOR [WorksIn]
GO
ALTER TABLE [dbo].[Ent_Nurse] ADD  DEFAULT ((6000000)) FOR [WorksIn]
GO
ALTER TABLE [dbo].[Ent_Patient] ADD  DEFAULT (getdate()) FOR [PdayIn]
GO
ALTER TABLE [dbo].[Ent_Patient] ADD  DEFAULT ((0)) FOR [PisAssigned]
GO
ALTER TABLE [dbo].[Ent_Patient] ADD  DEFAULT ((6000000)) FOR [Pdep]
GO
ALTER TABLE [dbo].[Ent_Wardboy] ADD  DEFAULT ((5000000)) FOR [Maintains]
GO
ALTER TABLE [dbo].[Hos_Room] ADD  DEFAULT ((6000000)) FOR [RmDep]
GO
ALTER TABLE [dbo].[Ent_Doctor]  WITH CHECK ADD  CONSTRAINT [FK_EntDoc_HosDep] FOREIGN KEY([WorksIn])
REFERENCES [dbo].[Hos_Departments] ([DepId])
GO
ALTER TABLE [dbo].[Ent_Doctor] CHECK CONSTRAINT [FK_EntDoc_HosDep]
GO
ALTER TABLE [dbo].[Ent_Nurse]  WITH CHECK ADD  CONSTRAINT [FK_EntNur_HosDep] FOREIGN KEY([WorksIn])
REFERENCES [dbo].[Hos_Departments] ([DepId])
GO
ALTER TABLE [dbo].[Ent_Nurse] CHECK CONSTRAINT [FK_EntNur_HosDep]
GO
ALTER TABLE [dbo].[Ent_Patient]  WITH CHECK ADD  CONSTRAINT [FK_EntPat_HosDep] FOREIGN KEY([Pdep])
REFERENCES [dbo].[Hos_Departments] ([DepId])
GO
ALTER TABLE [dbo].[Ent_Patient] CHECK CONSTRAINT [FK_EntPat_HosDep]
GO
ALTER TABLE [dbo].[Ent_Wardboy]  WITH CHECK ADD  CONSTRAINT [FK_EntWar_RoomId] FOREIGN KEY([Maintains])
REFERENCES [dbo].[Hos_Room] ([RmId])
GO
ALTER TABLE [dbo].[Ent_Wardboy] CHECK CONSTRAINT [FK_EntWar_RoomId]
GO
ALTER TABLE [dbo].[Hos_Room]  WITH CHECK ADD  CONSTRAINT [FK_HosRoom_RoomDep] FOREIGN KEY([RmDep])
REFERENCES [dbo].[Hos_Departments] ([DepId])
GO
ALTER TABLE [dbo].[Hos_Room] CHECK CONSTRAINT [FK_HosRoom_RoomDep]
GO
ALTER TABLE [dbo].[Hos_Room]  WITH CHECK ADD  CONSTRAINT [FK_HosRoom_RoomType] FOREIGN KEY([RmType])
REFERENCES [dbo].[Hos_Room_Types] ([TypeId])
GO
ALTER TABLE [dbo].[Hos_Room] CHECK CONSTRAINT [FK_HosRoom_RoomType]
GO
ALTER TABLE [dbo].[Rel_AdmittedIn]  WITH CHECK ADD  CONSTRAINT [FK_AdmittedIn_EntPat] FOREIGN KEY([Pid])
REFERENCES [dbo].[Ent_Patient] ([Pid])
GO
ALTER TABLE [dbo].[Rel_AdmittedIn] CHECK CONSTRAINT [FK_AdmittedIn_EntPat]
GO
ALTER TABLE [dbo].[Rel_AdmittedIn]  WITH CHECK ADD  CONSTRAINT [FK_AdmittedIn_RoomId] FOREIGN KEY([RmId])
REFERENCES [dbo].[Hos_Room] ([RmId])
GO
ALTER TABLE [dbo].[Rel_AdmittedIn] CHECK CONSTRAINT [FK_AdmittedIn_RoomId]
GO
ALTER TABLE [dbo].[Rel_Serves]  WITH CHECK ADD  CONSTRAINT [FK_Serves_EntNur] FOREIGN KEY([NurId])
REFERENCES [dbo].[Ent_Nurse] ([NurId])
GO
ALTER TABLE [dbo].[Rel_Serves] CHECK CONSTRAINT [FK_Serves_EntNur]
GO
ALTER TABLE [dbo].[Rel_Serves]  WITH CHECK ADD  CONSTRAINT [FK_Serves_EntPat] FOREIGN KEY([Pid])
REFERENCES [dbo].[Ent_Patient] ([Pid])
GO
ALTER TABLE [dbo].[Rel_Serves] CHECK CONSTRAINT [FK_Serves_EntPat]
GO
ALTER TABLE [dbo].[Rel_Treats]  WITH CHECK ADD  CONSTRAINT [FK_Treats_EntDoc] FOREIGN KEY([DocId])
REFERENCES [dbo].[Ent_Doctor] ([DocId])
GO
ALTER TABLE [dbo].[Rel_Treats] CHECK CONSTRAINT [FK_Treats_EntDoc]
GO
ALTER TABLE [dbo].[Rel_Treats]  WITH CHECK ADD  CONSTRAINT [FK_Treats_EntPat] FOREIGN KEY([Pid])
REFERENCES [dbo].[Ent_Patient] ([Pid])
GO
ALTER TABLE [dbo].[Rel_Treats] CHECK CONSTRAINT [FK_Treats_EntPat]
GO
USE [master]
GO
ALTER DATABASE [HospitalMS] SET  READ_WRITE 
GO
