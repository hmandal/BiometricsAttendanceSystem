USE [master]
GO
/****** Object:  Database [BiometricsAttendanceSystem]    Script Date: 31-Oct-15 6:22:57 PM ******/
CREATE DATABASE [BiometricsAttendanceSystem]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BiometricsAttendanceSystem', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\BiometricsAttendanceSystem.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BiometricsAttendanceSystem_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\BiometricsAttendanceSystem_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BiometricsAttendanceSystem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET ARITHABORT OFF 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET RECOVERY FULL 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET  MULTI_USER 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [BiometricsAttendanceSystem]
GO
/****** Object:  StoredProcedure [dbo].[IsEmployeeOnMultidayLeaveByDate]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 25th October 2015
-- Description:	Checks whether employee is on multiday leave by Date
-- =============================================
CREATE PROCEDURE [dbo].[IsEmployeeOnMultidayLeaveByDate] 
	-- Add the parameters for the stored procedure here
	@employeeId bigint, 
	@date datetime 
AS
BEGIN
	SET NOCOUNT ON;
	SELECT COUNT( Distinct objTblMultiDayLeave.Id)
	FROM tblMultiDayLeave objTblMultiDayLeave , tblLeave objTblLeave
	WHERE
		 objTblLeave.Id = objTblMultiDayLeave.LeaveId AND
		 objTblLeave.EmployeeId = @employeeId AND
		 CAST(objTblMultiDayLeave.StartDate AS date) <= DATEADD(DAY, (0), CAST(@date AS date)) AND
		 CAST(objTblMultiDayLeave.EndDate AS date) >= DATEADD(DAY, (0), CAST(@date AS date))
END

GO
/****** Object:  StoredProcedure [dbo].[spAddDuration]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 04th October 2015
-- Description:	Add an entry to Duration Table
-- =============================================
CREATE PROCEDURE [dbo].[spAddDuration] 
	-- Add the parameters for the stored procedure here
	@duration time(7),
	@isActive bit,
	@createdOn datetime,
	@updatedOn datetime,
	@isDeleted bit
AS
BEGIN
	SET NOCOUNT ON;
    INSERT INTO 
     tblDuration 
	 VALUES(
			@duration,
			@isActive,
			@createdOn,
			@updatedOn,
			@isDeleted
		   )
END

GO
/****** Object:  StoredProcedure [dbo].[spAddRole]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 04th October 2015
-- Description:	Add a new role
-- =============================================
CREATE PROCEDURE [dbo].[spAddRole] 
	-- Add the parameters for the stored procedure here
	@name nvarchar(Max), 
	@createdOn datetime,
    @updatedOn datetime,
    @isDeleted bit
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO 
	tblRole 
	VALUES(
		@name,
		@createdOn,
		@updatedOn,
		@isDeleted
		)
END

GO
/****** Object:  StoredProcedure [dbo].[spAddShift]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 04th October 2015
-- Description:	Add a new Shift entry
-- =============================================
CREATE PROCEDURE [dbo].[spAddShift] (
	@firstHalfStart datetime,
	@firstHalfEnd datetime,
	@secondHalfStart datetime,
	@secondHalfEnd datetime,
	@isActive bit,
	@createdOn datetime,
	@updatedOn datetime,
	@isDeleted bit)
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO 
		tblShifts 
	VALUES(
			@firstHalfStart,	
			@firstHalfEnd,
			@secondHalfStart,
			@secondHalfEnd,
			@isActive,
			@createdOn,
			@updatedOn,
			@isDeleted)
END

GO
/****** Object:  StoredProcedure [dbo].[spAssignFullDayLeave]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 25th October 2015
-- Description:	Assign a Full day leave
-- =============================================
CREATE PROCEDURE [dbo].[spAssignFullDayLeave] 
	-- Add the parameters for the stored procedure here
	@employeeId bigint = 0, 
	@date datetime = 0,
	@leaveTypeId int,
	@createdAt datetime,
	@updatedAt datetime
AS
BEGIN
	SET NOCOUNT ON;
    declare @leaveId int
	INSERT INTO tblLeave values(@employeeId,@leaveTypeId,@createdAt,@updatedAt,0);
	SET @leaveId = @@IDENTITY
	INSERT INTO tblFullDayLeave values(@leaveId,@date,@createdAt,@updatedAt);
END

GO
/****** Object:  StoredProcedure [dbo].[spAssignLeaveByRole]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 31st October 2015
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[spAssignLeaveByRole] 
	-- Add the parameters for the stored procedure here
	@leaveId int = 0, 
	@roleId int = 0,
	@noOfLeaves int = 0,
	@isPromoted bit,
	@limit int
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO 
	         tblLeaveAssignedByRole 
	VALUES( @leaveId, @roleId,@noOfLeaves,@isPromoted,@limit)
END

GO
/****** Object:  StoredProcedure [dbo].[spCreateDepartment]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 02nd October 2015
-- Description:	Creates a new Department Entry
-- =============================================
CREATE PROCEDURE [dbo].[spCreateDepartment] 
	-- Add the parameters for the stored procedure here
	@name nvarchar(Max), 
	@createdOn datetime,
	@updatedOn datetime
AS
BEGIN
	SET NOCOUNT ON;
	SELECT @name, @createdOn
	INSERT INTO tblDepartment 
	VALUES(
	@name,
	@createdOn,
	@updatedOn)
END

GO
/****** Object:  StoredProcedure [dbo].[spCreateEmployee]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SI
-- Create date: 29thSeptember2015
-- Description:	Creates a new Employee and returns Employee ID of created Employee 
-- =============================================
CREATE PROCEDURE [dbo].[spCreateEmployee]
	-- Add the parameters for the stored procedure here
	@facultyId nvarchar(MAX),
	@firstName nvarchar(MAX), 
	@middleName nvarchar(MAX),
	@lastName nvarchar(MAX),
	@gender nvarchar(MAX),
	@dateOfBirth datetime,
	@joiningDate datetime,
	@isDeleted bit,
	@createdOn datetime,
	@updatedOn datetime
AS
BEGIN

	SET NOCOUNT ON;

   INSERT INTO dbo.tblEmployeesMaster
          ( 
            FacultyId,
			FirstName,
			MiddleName,
			LastName,
			Gender,
			DateOfBirth,
			JoiningDate,
			CreatedAt,
			UpdatedAt,
			IsDeleted
          ) 
     VALUES 
          ( 
            @facultyId,
			@firstName, 
			@middleName,
			@lastName,
			@gender,
			@dateOfBirth,
			@joiningDate,
			@createdOn,
			@updatedOn,
			@isDeleted
          ) 
	SELECT @@IDENTITY
END

GO
/****** Object:  StoredProcedure [dbo].[spCreateEmployeeTransc]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SI
-- Create date: 29thSeptember2015
-- Description:	Creates a new Employee and returns Employee ID of created Employee 
-- =============================================
CREATE PROCEDURE [dbo].[spCreateEmployeeTransc]
	-- Add the parameters for the stored procedure here
	@employeeId bigint,
	@imagepath nvarchar(MAX), 
	@password nvarchar(MAX),
	@departmentId int,
	@roleId int,
	@contactNumber bigint,
	@isDeleted bit,
	@createdAt datetime,
	@updatedAt datetime
AS
BEGIN

   SET NOCOUNT ON;

   INSERT INTO dbo.tblEmployees
          ( 
            EmployeeId,
			ImagePath,
			[Password],
			RoleId,
			DepartmentId,
			CreatedAt,
			UpdatedAt,
			IsDeleted
          ) 
     VALUES 
          ( 
            @employeeId,
			@imagePath, 
			@password,
			@roleId,
			@departmentId,
			@createdAt,
			@updatedAt,
			@isDeleted
          ) 
END

GO
/****** Object:  StoredProcedure [dbo].[spCreateTypeOfLeave]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 03rd October 2015
-- Description:	Add a new type of Leave
-- =============================================
CREATE PROCEDURE [dbo].[spCreateTypeOfLeave] 
	-- Add the parameters for the stored procedure here
	@name nvarchar(MAX), 
	@masterLeaveType int,
	@createdOn datetime,
	@updatedOn datetime,
	@isDeleted bit
AS
BEGIN
	SET NOCOUNT ON;
			INSERT INTO 
			tblTypeOfLeave 
			VALUES (
			@name,
			@masterLeaveType,
			@createdOn,
			@updatedOn,
			@isDeleted)
    END

GO
/****** Object:  StoredProcedure [dbo].[spDeleteEmployee]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 10th Oct 2015
-- Description:	Deletes an Employee
-- =============================================
CREATE PROCEDURE [dbo].[spDeleteEmployee] 
	@employeeID bigint = 0 
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE  tblEmployeesMaster
	SET  IsDeleted = 1
	WHERE Id = @employeeID

	UPDATE  tblEmployees
	SET  IsDeleted = 1
	WHERE EmployeeId = @employeeID
END

GO
/****** Object:  StoredProcedure [dbo].[spGetAllDepartments]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 03rd October 2015
-- Description:	Returns all Departments
-- =============================================
CREATE PROCEDURE [dbo].[spGetAllDepartments] 
	
AS
BEGIN

	SET NOCOUNT ON;
	SELECT 
			Id,
			Name 
	FROM    tblDepartment
END

GO
/****** Object:  StoredProcedure [dbo].[spGetAllDurations]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 04th October 2015
-- Description:	Returns list of durations 
-- =============================================
CREATE PROCEDURE [dbo].[spGetAllDurations] 
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
			Id,
			Duration
	FROM tblDuration
	WHERE
			IsDeleted = 0 
END

GO
/****** Object:  StoredProcedure [dbo].[spGetAllEmployees]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 09th October 2015
-- Description:	Returns All Employees
-- =============================================
CREATE PROCEDURE [dbo].[spGetAllEmployees] 
AS
BEGIN
     SET NOCOUNT ON;
	 SELECT objtblEmployeesMaster.Id,
	        --objtblEmployeesMaster.FacultyId,
			objtblEmployeesMaster.FirstName,
			objtblEmployeesMaster.MiddleName,
			objtblEmployeesMaster.LastName,
			objtblEmployeesMaster.Gender,
			objtblEmployeesMaster.DateOfBirth,
			objtblEmployeesMaster.JoiningDate,
			objtblEmployees.ImagePath,
			objtblEmployees.ContactNumber,
			objtblEmployees.[Password],
			objtblRole.Id,
			objtblRole.Name,
			objtblDepartment.Id,
			objtblDepartment.Name
	 FROM tblEmployeesMaster objtblEmployeesMaster, tblEmployees objtblEmployees,tblRole objtblRole,tblDepartment objtblDepartment
 	 WHERE objtblEmployeesMaster.Id = objtblEmployees.EmployeeId
	 AND  objtblEmployeesMaster.IsDeleted = 0  
	 AND  objtblEmployees.RoleId = objtblRole.Id
	 AND  objtblEmployees.DepartmentId = objtblDepartment.Id
END

GO
/****** Object:  StoredProcedure [dbo].[spGetAllLeavesAssignedByRole]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 31st October 2015
-- Description:	Get All Leave Assigned By Role 
-- =============================================
CREATE PROCEDURE [dbo].[spGetAllLeavesAssignedByRole] 
AS
BEGIN
	SET NOCOUNT ON;

   SELECT objTblLeaveAssignedByRole.[Id]
      ,objTblRole.Name as RoleName
      ,objtblTypeOfLeave.Name as LeaveName
      ,objTblLeaveAssignedByRole.[NoOfLeaves]
      ,objTblLeaveAssignedByRole.[IsPromoted]
      ,objTblLeaveAssignedByRole.[Limit] 
  FROM tblLeaveAssignedByRole objTblLeaveAssignedByRole, tblRole objTblRole, tblTypeOfLeave objtblTypeOfLeave
  WHERE objTblLeaveAssignedByRole.RoleId = objTblRole.Id AND
        objTblLeaveAssignedByRole.LeaveTypeId = objtblTypeOfLeave.Id                         

END

GO
/****** Object:  StoredProcedure [dbo].[spGetAllRoles]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 04th October 2015
-- Description:	Get all roles
-- =============================================
CREATE PROCEDURE [dbo].[spGetAllRoles] 
AS
BEGIN
	SET NOCOUNT ON;
	SELECT 
		Id,
		Name 
	FROM 
	    tblRole
	WHERE
		IsDeleted = 0
END

GO
/****** Object:  StoredProcedure [dbo].[spGetAllShifts]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 04th October 2015
-- Description:	Get all Shifts
-- =============================================
CREATE PROCEDURE [dbo].[spGetAllShifts]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT 
		Id,
		FirstHalfStart,
		FirstHalfEnd,
		SecondHalfStart,
		SecondHalfEnd,
		isActive 
	FROM 
		tblShifts
	WHERE 
		IsDeleted =0
END

GO
/****** Object:  StoredProcedure [dbo].[spGetAllTypeOfLeaves]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 03rd October 2015
-- Description:	Gets All Types of Leave
-- =============================================
CREATE PROCEDURE [dbo].[spGetAllTypeOfLeaves] 
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
	      objTblTypeOfLeave.Id,
		  objTblTypeOfLeave.Name,
		  objTblTypeOfLeave.MasterLeaveType,
		  objTblTypeOfLeaveMaster.Name
    FROM  tblTypeOfLeave objTblTypeOfLeave, tblTypeOfLeaveMaster objTblTypeOfLeaveMaster
	WHERE objTblTypeOfLeave.IsDeleted = 0 
	      AND
		  objTblTypeOfLeave.MasterLeaveType = objTblTypeOfLeaveMaster.Id
END

GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeeByID]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 10th October 2015
-- Description:	Get Employee by Id
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeeByID] 
	@employeeId bigint = 0
AS
BEGIN
	SET NOCOUNT ON;
	SELECT objtblEmployeesMaster.Id,
	        --objtblEmployeesMaster.FacultyId,
			objtblEmployeesMaster.FirstName,
			objtblEmployeesMaster.MiddleName,
			objtblEmployeesMaster.LastName,
			objtblEmployeesMaster.Gender,
			objtblEmployeesMaster.DateOfBirth,
			objtblEmployeesMaster.JoiningDate,
			objtblEmployees.ImagePath,
			objtblEmployees.ContactNumber,
			objtblEmployees.[Password],
			objtblRole.Id,
			objtblRole.Name,
			objtblDepartment.Id,
			objtblDepartment.Name
	 FROM tblEmployeesMaster objtblEmployeesMaster, tblEmployees objtblEmployees,tblRole objtblRole,tblDepartment objtblDepartment
 	 WHERE objtblEmployeesMaster.Id = objtblEmployees.EmployeeId
	 AND  objtblEmployeesMaster.IsDeleted = 0  
	 AND  objtblEmployees.RoleId = objtblRole.Id
	 AND  objtblEmployees.DepartmentId = objtblDepartment.Id
	 AND  objtblEmployeesMaster.Id = @employeeId
END

GO
/****** Object:  StoredProcedure [dbo].[spIsEmployeeOnDurationalLeaveByDate]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 25th October 2015
-- Description:	Checks whether employee is on durational leave by Date
-- =============================================
CREATE PROCEDURE [dbo].[spIsEmployeeOnDurationalLeaveByDate] 
	-- Add the parameters for the stored procedure here
	@employeeId bigint, 
	@date datetime 
AS
BEGIN
	SET NOCOUNT ON;
	SELECT COUNT( Distinct objtblDurationalLeave.Id)
	FROM tblDurationalLeave objtblDurationalLeave , tblLeave objTblLeave
	WHERE
		 objTblLeave.Id = objtblDurationalLeave.LeaveId AND
		 objTblLeave.EmployeeId = @employeeId AND
		 CAST(objtblDurationalLeave.Date AS date) =  CAST(@date AS date)
END

GO
/****** Object:  StoredProcedure [dbo].[spIsEmployeeOnFullDayLeaveByDate]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 25th October 2015
-- Description:	Checks whether employee is on full day leave by Date
-- =============================================
CREATE PROCEDURE [dbo].[spIsEmployeeOnFullDayLeaveByDate] 
	-- Add the parameters for the stored procedure here
	@employeeId bigint, 
	@date datetime 
AS
BEGIN
	SET NOCOUNT ON;
	SELECT COUNT( Distinct objtblFullDayLeave.Id)
	FROM tblFullDayLeave objtblFullDayLeave , tblLeave objTblLeave
	WHERE
		 objTblLeave.Id = objtblFullDayLeave.LeaveId AND
		 objTblLeave.EmployeeId = @employeeId AND
		 CAST(objtblFullDayLeave.Date AS date) =  CAST(@date AS date)
END

GO
/****** Object:  StoredProcedure [dbo].[spIsEmployeeOnHalfDayLeaveByDate]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 25th October 2015
-- Description:	Checks whether employee is on half day leave by Date
-- =============================================
CREATE PROCEDURE [dbo].[spIsEmployeeOnHalfDayLeaveByDate] 
	-- Add the parameters for the stored procedure here
	@employeeId bigint, 
	@date datetime 
AS
BEGIN
	SET NOCOUNT ON;
	SELECT COUNT( Distinct objtblHalfDayLeave.Id)
	FROM tblHalfDayLeave objtblHalfDayLeave , tblLeave objTblLeave
	WHERE
		 objTblLeave.Id = objtblHalfDayLeave.LeaveId AND
		 objTblLeave.EmployeeId = @employeeId AND
		 CAST(objtblHalfDayLeave.Date AS date) =  CAST(@date AS date)
END

GO
/****** Object:  Table [dbo].[tblAttendance]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAttendance](
	[SNo] [bigint] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [bigint] NOT NULL,
	[Date] [date] NOT NULL,
	[EntryTime] [time](7) NULL,
	[ExitTime] [time](7) NULL,
 CONSTRAINT [PK_tblAttendance] PRIMARY KEY CLUSTERED 
(
	[SNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblDepartment]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDepartment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tblDepartment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblDuration]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDuration](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Duration] [time](7) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedOn] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_tblSHLDuration] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblDurationalLeave]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDurationalLeave](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[LeaveId] [bigint] NOT NULL,
	[Date] [datetime] NOT NULL,
	[DurationId] [int] NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NULL,
 CONSTRAINT [PK_tblDurationalLeave] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblEmployees]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblEmployees](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [bigint] NOT NULL,
	[ImagePath] [nvarchar](max) NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
	[RoleId] [int] NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[ContactNumber] [bigint] NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_tblEmployees_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblEmployeesMaster]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblEmployeesMaster](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[FacultyId] [nvarchar](max) NOT NULL,
	[FirstName] [nvarchar](max) NOT NULL,
	[MiddleName] [nvarchar](max) NULL,
	[LastName] [nvarchar](max) NULL,
	[Gender] [nvarchar](max) NOT NULL,
	[DateOfBirth] [datetime] NOT NULL,
	[JoiningDate] [datetime] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_tblEmployees] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblFullDayLeave]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFullDayLeave](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[LeaveId] [bigint] NOT NULL,
	[Date] [datetime] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NULL,
 CONSTRAINT [PK_tblFullDayLeave] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblHalfDayLeave]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblHalfDayLeave](
	[Id] [bigint] NOT NULL,
	[LeaveId] [bigint] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Shift] [int] NOT NULL,
	[ShiftId] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NULL,
 CONSTRAINT [PK_tblHalfDayLeave] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblLeave]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLeave](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [bigint] NOT NULL,
	[LeaveTypeId] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_tblLeave] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblLeaveAssignedByRole]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLeaveAssignedByRole](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NOT NULL,
	[LeaveTypeId] [int] NOT NULL,
	[NoOfLeaves] [int] NOT NULL,
	[IsPromoted] [bit] NOT NULL,
	[Limit] [int] NOT NULL,
 CONSTRAINT [PK_tblLeaveAssignedByRole] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblLeaveDetailsMonthWise]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLeaveDetailsMonthWise](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [bigint] NOT NULL,
	[Month] [date] NOT NULL,
	[LeaveId] [int] NOT NULL,
	[LeavesAllotedForMonth] [int] NOT NULL,
	[LeavesTakentForMonth] [int] NOT NULL,
 CONSTRAINT [PK_tblLeaveDetailsMonthWise] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblMultiDayLeave]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMultiDayLeave](
	[Id] [bigint] NOT NULL,
	[LeaveId] [bigint] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NULL,
 CONSTRAINT [PK_tblMultiDayLeave] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblRole]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRole](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedOn] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_tblRole] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblShifts]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblShifts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstHalfStart] [time](7) NOT NULL,
	[FirstHalfEnd] [time](7) NOT NULL,
	[SecondHalfStart] [time](7) NOT NULL,
	[SecondHalfEnd] [time](7) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedOn] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_tblShifts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblTypeOfLeave]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTypeOfLeave](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[MasterLeaveType] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedOn] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_tblTypeOfLeave] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblTypeOfLeaveMaster]    Script Date: 31-Oct-15 6:22:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTypeOfLeaveMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tblTypeOfLeaveMaster] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[tblAttendance] ON 

INSERT [dbo].[tblAttendance] ([SNo], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1, 1, CAST(0x883A0B00 AS Date), CAST(0x070040230E430000 AS Time), CAST(0x070080461C860000 AS Time))
SET IDENTITY_INSERT [dbo].[tblAttendance] OFF
SET IDENTITY_INSERT [dbo].[tblDepartment] ON 

INSERT [dbo].[tblDepartment] ([Id], [Name], [CreatedOn], [UpdatedOn]) VALUES (1, N'CSE', CAST(0x0000A48F00000000 AS DateTime), NULL)
INSERT [dbo].[tblDepartment] ([Id], [Name], [CreatedOn], [UpdatedOn]) VALUES (2, N'IT', CAST(0x0000A48F00000000 AS DateTime), NULL)
INSERT [dbo].[tblDepartment] ([Id], [Name], [CreatedOn], [UpdatedOn]) VALUES (3, N'EC', CAST(0x0000A528017DCEE7 AS DateTime), CAST(0x0000A528017DCEE7 AS DateTime))
INSERT [dbo].[tblDepartment] ([Id], [Name], [CreatedOn], [UpdatedOn]) VALUES (4, N'EN', CAST(0x0000A528017DE933 AS DateTime), CAST(0x0000A528017DE933 AS DateTime))
INSERT [dbo].[tblDepartment] ([Id], [Name], [CreatedOn], [UpdatedOn]) VALUES (5, N'CIVIL', CAST(0x0000A528017F1C0F AS DateTime), CAST(0x0000A528017F1C0F AS DateTime))
INSERT [dbo].[tblDepartment] ([Id], [Name], [CreatedOn], [UpdatedOn]) VALUES (6, N'CIVIL', CAST(0x0000A528017F1F07 AS DateTime), CAST(0x0000A528017F1F07 AS DateTime))
INSERT [dbo].[tblDepartment] ([Id], [Name], [CreatedOn], [UpdatedOn]) VALUES (7, N'ME', CAST(0x0000A5280189C908 AS DateTime), CAST(0x0000A5280189C908 AS DateTime))
INSERT [dbo].[tblDepartment] ([Id], [Name], [CreatedOn], [UpdatedOn]) VALUES (8, N'dummy', CAST(0x0000A52A00C9EE8B AS DateTime), CAST(0x0000A52A00C9EE8B AS DateTime))
INSERT [dbo].[tblDepartment] ([Id], [Name], [CreatedOn], [UpdatedOn]) VALUES (9, N'dummy1', CAST(0x0000A52A00CA55E6 AS DateTime), CAST(0x0000A52A00CA55E6 AS DateTime))
INSERT [dbo].[tblDepartment] ([Id], [Name], [CreatedOn], [UpdatedOn]) VALUES (10, N'dummy1', CAST(0x0000A52A00CA5A0B AS DateTime), CAST(0x0000A52A00CA5A0B AS DateTime))
INSERT [dbo].[tblDepartment] ([Id], [Name], [CreatedOn], [UpdatedOn]) VALUES (11, N'dummy2', CAST(0x0000A52A00CD35B1 AS DateTime), CAST(0x0000A52A00CD35B1 AS DateTime))
INSERT [dbo].[tblDepartment] ([Id], [Name], [CreatedOn], [UpdatedOn]) VALUES (12, N'zxv', CAST(0x0000A52A00CD4785 AS DateTime), CAST(0x0000A52A00CD4785 AS DateTime))
INSERT [dbo].[tblDepartment] ([Id], [Name], [CreatedOn], [UpdatedOn]) VALUES (13, N'Dept', CAST(0x0000A52B007DAB29 AS DateTime), CAST(0x0000A52B007DAB29 AS DateTime))
INSERT [dbo].[tblDepartment] ([Id], [Name], [CreatedOn], [UpdatedOn]) VALUES (14, N'Dummy Final', CAST(0x0000A52B007E9F50 AS DateTime), CAST(0x0000A52B007E9F50 AS DateTime))
INSERT [dbo].[tblDepartment] ([Id], [Name], [CreatedOn], [UpdatedOn]) VALUES (15, N'Dummy Final', CAST(0x0000A52B007EA43F AS DateTime), CAST(0x0000A52B007EA43F AS DateTime))
INSERT [dbo].[tblDepartment] ([Id], [Name], [CreatedOn], [UpdatedOn]) VALUES (16, N'Dummy Department', CAST(0x0000A53300FF18DB AS DateTime), CAST(0x0000A53300FF18DB AS DateTime))
SET IDENTITY_INSERT [dbo].[tblDepartment] OFF
SET IDENTITY_INSERT [dbo].[tblEmployees] ON 

INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (1, 1, N'src', N'pass', 1, 1, 8800764516, CAST(0x0000A48F00000000 AS DateTime), CAST(0x0000A48F00000000 AS DateTime), 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (2, 5, N'Presentation1.png', N'12345', 1, 1, 8800764516, CAST(0x0000A52C00812172 AS DateTime), CAST(0x0000A52C00812172 AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[tblEmployees] OFF
SET IDENTITY_INSERT [dbo].[tblEmployeesMaster] ON 

INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [FirstName], [MiddleName], [LastName], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (1, N'1310062', N'Anup', N'Kumar', N'Gupta', N'Male', CAST(0x0000A48F00000000 AS DateTime), CAST(0x0000A48F00000000 AS DateTime), CAST(0x0000A48F00000000 AS DateTime), CAST(0x0000A48F00000000 AS DateTime), 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [FirstName], [MiddleName], [LastName], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (5, N'12346', N'Anup', N'Kumar', N'Gupta', N'Male', CAST(0x000085E400000000 AS DateTime), CAST(0x0000A54400000000 AS DateTime), CAST(0x0000A52C00812172 AS DateTime), CAST(0x0000A52C00812172 AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[tblEmployeesMaster] OFF
SET IDENTITY_INSERT [dbo].[tblFullDayLeave] ON 

INSERT [dbo].[tblFullDayLeave] ([Id], [LeaveId], [Date], [CreatedAt], [UpdatedAt]) VALUES (1, 1, CAST(0x0000A41700000000 AS DateTime), CAST(0x0000A41700000000 AS DateTime), CAST(0x0000A41700000000 AS DateTime))
SET IDENTITY_INSERT [dbo].[tblFullDayLeave] OFF
SET IDENTITY_INSERT [dbo].[tblLeave] ON 

INSERT [dbo].[tblLeave] ([Id], [EmployeeId], [LeaveTypeId], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (1, 5, 1, CAST(0x0000A41700000000 AS DateTime), CAST(0x0000A41700000000 AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[tblLeave] OFF
SET IDENTITY_INSERT [dbo].[tblLeaveAssignedByRole] ON 

INSERT [dbo].[tblLeaveAssignedByRole] ([Id], [RoleId], [LeaveTypeId], [NoOfLeaves], [IsPromoted], [Limit]) VALUES (1, 1, 1, 5, 1, 5)
SET IDENTITY_INSERT [dbo].[tblLeaveAssignedByRole] OFF
SET IDENTITY_INSERT [dbo].[tblRole] ON 

INSERT [dbo].[tblRole] ([Id], [Name], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (1, N'HOD', CAST(0x0000A48F00000000 AS DateTime), NULL, 0)
INSERT [dbo].[tblRole] ([Id], [Name], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (2, N'Admin', CAST(0x0000A52A00C3A58B AS DateTime), CAST(0x0000A52A00C3A58B AS DateTime), 0)
INSERT [dbo].[tblRole] ([Id], [Name], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (3, N'Faculty', CAST(0x0000A52A00CA7B44 AS DateTime), CAST(0x0000A52A00CA7B44 AS DateTime), 0)
INSERT [dbo].[tblRole] ([Id], [Name], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (4, N'Dummy', CAST(0x0000A52A00CD5DAE AS DateTime), CAST(0x0000A52A00CD5DAE AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[tblRole] OFF
SET IDENTITY_INSERT [dbo].[tblTypeOfLeave] ON 

INSERT [dbo].[tblTypeOfLeave] ([Id], [Name], [MasterLeaveType], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (1, N'Casual Leave', 1, CAST(0x0000A5280188EC44 AS DateTime), CAST(0x0000A5280188ED70 AS DateTime), 0)
INSERT [dbo].[tblTypeOfLeave] ([Id], [Name], [MasterLeaveType], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (1009, N'Emergency Leave', 1, CAST(0x0000A41300000000 AS DateTime), NULL, 0)
INSERT [dbo].[tblTypeOfLeave] ([Id], [Name], [MasterLeaveType], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (1010, N'SL', 3, CAST(0x0000A41300000000 AS DateTime), NULL, 0)
INSERT [dbo].[tblTypeOfLeave] ([Id], [Name], [MasterLeaveType], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (1011, N'Summer Break', 4, CAST(0x0000A41300000000 AS DateTime), NULL, 0)
SET IDENTITY_INSERT [dbo].[tblTypeOfLeave] OFF
SET IDENTITY_INSERT [dbo].[tblTypeOfLeaveMaster] ON 

INSERT [dbo].[tblTypeOfLeaveMaster] ([Id], [Name]) VALUES (1, N'Full Day  ')
INSERT [dbo].[tblTypeOfLeaveMaster] ([Id], [Name]) VALUES (2, N'Half Day')
INSERT [dbo].[tblTypeOfLeaveMaster] ([Id], [Name]) VALUES (3, N'Short Leave')
INSERT [dbo].[tblTypeOfLeaveMaster] ([Id], [Name]) VALUES (4, N'Bulk Leave')
SET IDENTITY_INSERT [dbo].[tblTypeOfLeaveMaster] OFF
/****** Object:  Index [IX_tblEmployees]    Script Date: 31-Oct-15 6:22:57 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblEmployees] ON [dbo].[tblEmployeesMaster]
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblAttendance]  WITH CHECK ADD  CONSTRAINT [FK_tblAttendance_tblEmployees] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[tblEmployeesMaster] ([Id])
GO
ALTER TABLE [dbo].[tblAttendance] CHECK CONSTRAINT [FK_tblAttendance_tblEmployees]
GO
ALTER TABLE [dbo].[tblDurationalLeave]  WITH CHECK ADD  CONSTRAINT [FK_tblDurationalLeave_tblDuration] FOREIGN KEY([DurationId])
REFERENCES [dbo].[tblDuration] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblDurationalLeave] CHECK CONSTRAINT [FK_tblDurationalLeave_tblDuration]
GO
ALTER TABLE [dbo].[tblDurationalLeave]  WITH CHECK ADD  CONSTRAINT [FK_tblDurationalLeave_tblLeave] FOREIGN KEY([LeaveId])
REFERENCES [dbo].[tblLeave] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblDurationalLeave] CHECK CONSTRAINT [FK_tblDurationalLeave_tblLeave]
GO
ALTER TABLE [dbo].[tblEmployees]  WITH CHECK ADD  CONSTRAINT [FK_tblEmployees_tblDepartment] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[tblDepartment] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEmployees] CHECK CONSTRAINT [FK_tblEmployees_tblDepartment]
GO
ALTER TABLE [dbo].[tblEmployees]  WITH CHECK ADD  CONSTRAINT [FK_tblEmployees_tblEmployeesMaster] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[tblEmployeesMaster] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEmployees] CHECK CONSTRAINT [FK_tblEmployees_tblEmployeesMaster]
GO
ALTER TABLE [dbo].[tblEmployees]  WITH CHECK ADD  CONSTRAINT [FK_tblEmployees_tblRole] FOREIGN KEY([RoleId])
REFERENCES [dbo].[tblRole] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEmployees] CHECK CONSTRAINT [FK_tblEmployees_tblRole]
GO
ALTER TABLE [dbo].[tblFullDayLeave]  WITH CHECK ADD  CONSTRAINT [FK_tblFullDayLeave_tblLeave] FOREIGN KEY([LeaveId])
REFERENCES [dbo].[tblLeave] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblFullDayLeave] CHECK CONSTRAINT [FK_tblFullDayLeave_tblLeave]
GO
ALTER TABLE [dbo].[tblHalfDayLeave]  WITH CHECK ADD  CONSTRAINT [FK_tblHalfDayLeave_tblLeave] FOREIGN KEY([LeaveId])
REFERENCES [dbo].[tblLeave] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblHalfDayLeave] CHECK CONSTRAINT [FK_tblHalfDayLeave_tblLeave]
GO
ALTER TABLE [dbo].[tblHalfDayLeave]  WITH CHECK ADD  CONSTRAINT [FK_tblHalfDayLeave_tblShifts] FOREIGN KEY([ShiftId])
REFERENCES [dbo].[tblShifts] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblHalfDayLeave] CHECK CONSTRAINT [FK_tblHalfDayLeave_tblShifts]
GO
ALTER TABLE [dbo].[tblLeave]  WITH CHECK ADD  CONSTRAINT [FK_tblLeave_tblEmployees] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[tblEmployeesMaster] ([Id])
GO
ALTER TABLE [dbo].[tblLeave] CHECK CONSTRAINT [FK_tblLeave_tblEmployees]
GO
ALTER TABLE [dbo].[tblLeave]  WITH CHECK ADD  CONSTRAINT [FK_tblLeave_tblTypeOfLeave] FOREIGN KEY([LeaveTypeId])
REFERENCES [dbo].[tblTypeOfLeave] ([Id])
GO
ALTER TABLE [dbo].[tblLeave] CHECK CONSTRAINT [FK_tblLeave_tblTypeOfLeave]
GO
ALTER TABLE [dbo].[tblLeaveAssignedByRole]  WITH CHECK ADD  CONSTRAINT [FK_tblLeaveAssignedByRole_tblRole] FOREIGN KEY([RoleId])
REFERENCES [dbo].[tblRole] ([Id])
GO
ALTER TABLE [dbo].[tblLeaveAssignedByRole] CHECK CONSTRAINT [FK_tblLeaveAssignedByRole_tblRole]
GO
ALTER TABLE [dbo].[tblLeaveAssignedByRole]  WITH CHECK ADD  CONSTRAINT [FK_tblLeaveAssignedByRole_tblTypeOfLeave] FOREIGN KEY([LeaveTypeId])
REFERENCES [dbo].[tblTypeOfLeave] ([Id])
GO
ALTER TABLE [dbo].[tblLeaveAssignedByRole] CHECK CONSTRAINT [FK_tblLeaveAssignedByRole_tblTypeOfLeave]
GO
ALTER TABLE [dbo].[tblLeaveDetailsMonthWise]  WITH CHECK ADD  CONSTRAINT [FK_tblLeaveDetailsMonthWise_tblEmployeesMaster] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[tblEmployeesMaster] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblLeaveDetailsMonthWise] CHECK CONSTRAINT [FK_tblLeaveDetailsMonthWise_tblEmployeesMaster]
GO
ALTER TABLE [dbo].[tblLeaveDetailsMonthWise]  WITH CHECK ADD  CONSTRAINT [FK_tblLeaveDetailsMonthWise_tblTypeOfLeave] FOREIGN KEY([LeaveId])
REFERENCES [dbo].[tblTypeOfLeave] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblLeaveDetailsMonthWise] CHECK CONSTRAINT [FK_tblLeaveDetailsMonthWise_tblTypeOfLeave]
GO
ALTER TABLE [dbo].[tblMultiDayLeave]  WITH CHECK ADD  CONSTRAINT [FK_tblMultiDayLeave_tblLeave] FOREIGN KEY([LeaveId])
REFERENCES [dbo].[tblLeave] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblMultiDayLeave] CHECK CONSTRAINT [FK_tblMultiDayLeave_tblLeave]
GO
ALTER TABLE [dbo].[tblTypeOfLeave]  WITH CHECK ADD  CONSTRAINT [FK_tblTypeOfLeave_tblTypeOfLeaveMaster] FOREIGN KEY([MasterLeaveType])
REFERENCES [dbo].[tblTypeOfLeaveMaster] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblTypeOfLeave] CHECK CONSTRAINT [FK_tblTypeOfLeave_tblTypeOfLeaveMaster]
GO
USE [master]
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET  READ_WRITE 
GO
