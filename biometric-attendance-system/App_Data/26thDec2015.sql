USE [master]
GO
/****** Object:  Database [BiometricsAttendanceSystem]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[IsSingle]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 15th November 2015
-- Description:	Checks whether for particular role id and leave id there is only 1 entry
-- =============================================
CREATE PROCEDURE [dbo].[IsSingle] 
	-- Add the parameters for the stored procedure here
	@roleId int, 
	@leaveId datetime 
AS
BEGIN
	SET NOCOUNT ON;
	SELECT COUNT( Distinct Id)
	FROM tblLeaveAssignedByRole
	WHERE
	LeaveTypeId=@leaveId AND RoleId=@roleId
		 END
GO
/****** Object:  StoredProcedure [dbo].[NOTCHECKEDspGetEmployeesAbsentByDepartmentDateWise]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 11th November 2015
-- Description:	Generate Report By Department
-- =============================================
CREATE PROCEDURE [dbo].[NOTCHECKEDspGetEmployeesAbsentByDepartmentDateWise] 
	-- Add the parameters for the stored procedure here
	@departmentId int = 0, 
	@date datetime
AS
BEGIN
	SET NOCOUNT ON;
	SELECT 
       objtblEmployeesMaster.FacultyId
      ,objtblEmployeesMaster.FirstName
      ,objtblEmployeesMaster.MiddleName
      ,objtblEmployeesMaster.LastName
  FROM tblEmployeesMaster objtblEmployeesMaster, tblAttendance objtblAttendance, tblEmployees objtblEmployees
  WHERE objtblEmployeesMaster.IsDeleted = 0 
  AND   objtblEmployeesMaster.Id != objtblAttendance.EmployeeId 
  AND   objtblAttendance.Date = (CAST(@date AS date))
  AND   objtblEmployeesMaster.Id = objtblEmployees.EmployeeId
  AND   objtblEmployees.DepartmentId = @departmentId
END

GO
/****** Object:  StoredProcedure [dbo].[NOTCHECKEDspGetEmployeesAbsentDateWise]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Software Incubator
-- Create date: 11th November 2015
-- Description:	Generate Report By Department
-- =============================================
CREATE PROCEDURE [dbo].[NOTCHECKEDspGetEmployeesAbsentDateWise] 
	-- Add the parameters for the stored procedure here
	@date datetime
AS
BEGIN
	SET NOCOUNT ON;
	SELECT 
       objtblEmployeesMaster.FacultyId
      ,objtblEmployeesMaster.FirstName
      ,objtblEmployeesMaster.MiddleName
      ,objtblEmployeesMaster.LastName
  FROM tblEmployeesMaster objtblEmployeesMaster, tblAttendance objtblAttendance
  WHERE objtblEmployeesMaster.IsDeleted = 0 
  AND   objtblEmployeesMaster.Id != objtblAttendance.EmployeeId 
  AND   objtblAttendance.Date = (CAST(@date AS date))
END


GO
/****** Object:  StoredProcedure [dbo].[OLDspGetTypeOfLeaveOfEmployeeByDate]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Software Incubator
-- Create date: 21st December 2015
-- Description:	Get Type Of Leave Of Employee By Date
-- =============================================
CREATE PROCEDURE [dbo].[OLDspGetTypeOfLeaveOfEmployeeByDate] 
	-- Add the parameters for the stored procedure here
	@employeeId bigint, 
	@date date
	

AS
BEGIN
    SELECT Name FROM  tblTypeOfLeave WHERE Id in(
	
	SELECT  Distinct objTblLeave.LeaveTypeId
	FROM tblMultiDayLeave objtblMultiDayLeave , tblLeave objTblLeave
	WHERE
		 objTblLeave.Id = objtblMultiDayLeave.LeaveId AND
		 objTblLeave.EmployeeId = @employeeId AND
		 CAST(objTblMultiDayLeave.StartDate AS date) <= DATEADD(DAY, (0), CAST(@date AS date)) AND
		 CAST(objTblMultiDayLeave.EndDate AS date) >= DATEADD(DAY, (0), CAST(@date AS date))
		
	UNION
		 
	SELECT Distinct objTblLeave.LeaveTypeId
	FROM tblFullDayLeave objtblFullDayLeave , tblLeave objTblLeave
	WHERE
		 objTblLeave.Id = objtblFullDayLeave.LeaveId AND
		 objTblLeave.EmployeeId = @employeeId AND
		 CAST(objtblFullDayLeave.Date AS date) =  CAST(@date AS date)	 

	UNion

	SELECT Distinct objTblLeave.LeaveTypeId
	FROM tblDurationalLeave objtblDurationalLeave , tblLeave objTblLeave
	WHERE
		 objTblLeave.Id = objtblDurationalLeave.LeaveId AND
		 objTblLeave.EmployeeId = @employeeId AND
		 CAST(objtblDurationalLeave.Date AS date) =  CAST(@date AS date)
		 
	Union

	SELECT Distinct objTblLeave.LeaveTypeId
	FROM tblHalfDayLeave objtblHalfDayLeave , tblLeave objTblLeave
	WHERE
		 objTblLeave.Id = objtblHalfDayLeave.LeaveId AND
		 objTblLeave.EmployeeId = @employeeId AND
		 CAST(objtblHalfDayLeave.Date AS date) =  CAST(@date AS date)	 
		 )

END

GO
/****** Object:  StoredProcedure [dbo].[OLDspIsEmployeeOnLeaveByDate]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Software Incubator
-- Create date: 25th October 2015
-- Description:	Checks whether employee is on leave by Date
-- =============================================
CREATE PROCEDURE [dbo].[OLDspIsEmployeeOnLeaveByDate] 
	-- Add the parameters for the stored procedure here
	@employeeId bigint, 
	@date date
	

AS
BEGIN
DECLARE @count1 int,
    @count2 int,
	@count3 int,
	@count4 int
EXEC	spIsEmployeeOnDurationalLeaveByDate
		@employeeId = @employeeId,
		@date = @date,
		@count = @count1 OUTPUT

EXEC	spIsEmployeeOnFullDayLeaveByDate
		@employeeId = @employeeId,
		@date = @date,
		@count = @count2 OUTPUT

EXEC	spIsEmployeeOnHalfDayLeaveByDate
		@employeeId = @employeeId,
		@date = @date,
		@count = @count3 OUTPUT

EXEC	spIsEmployeeOnMultidayLeaveByDate
		@employeeId = @employeeId,
		@date = @date,
		@count = @count4 OUTPUT

SELECT	@count1 +@count2 + @count3 +@count4

END


GO
/****** Object:  StoredProcedure [dbo].[spAddDuration]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spAddRole]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spAddShift]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spAssignAttendance]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Inubator
-- Create date: 12th November 2015
-- Description:	Assigns a entry if there is no count 
--              in the table. If entry is there exist
--              out the Emp.
-- =============================================
CREATE PROCEDURE [dbo].[spAssignAttendance] 
	@employeeId bigint , 
	@dateTime datetime 
AS
BEGIN
	SET NOCOUNT ON;

	Declare @count int
	Declare @exitTime time

	SELECT @count = COUNT(SNo) FROM tblAttendance WHERE EmployeeId= @employeeId 
	AND    Date = CAST(@dateTime as DATE)

    If(@count = 0)
	  BEGIN
	   INSERT INTO tblAttendance values(@employeeId,CAST(@dateTime as DATE),CAST(@dateTime as TIME),Null)
	   SELECT 1
	  END

   else
	 BEGIN
		SELECT @exitTime = ExitTime FROM tblAttendance WHERE EmployeeId= @employeeId 
	    AND    Date = CAST(@dateTime as DATE)

	  if(@exitTime IS NULL)
		BEGIN
		   UPDATE tblAttendance 
		   SET ExitTime = CAST(@dateTime as TIME)
		   WHERE EmployeeId= @employeeId AND Date = CAST(@dateTime as DATE)
		   SELECT 2
		END
	 
	  else
	    BEGIN
	       INSERT INTO tblAttendance values(@employeeId,CAST(@dateTime as DATE),CAST(@dateTime as TIME),Null)
	       SELECT 1
		END
	END 
END

GO
/****** Object:  StoredProcedure [dbo].[spAssignDurationalLeave]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Software Incubator
-- Create date: 25th October 2015
-- Description:	Assign a Durational leave
-- =============================================
CREATE PROCEDURE [dbo].[spAssignDurationalLeave] 
	@employeeId bigint = 0, 
	@date datetime = 0,
	@leaveTypeId int,
	@DurationalId int,
	@createdAt datetime,
	@updatedAt datetime
AS
BEGIN
	SET NOCOUNT ON;
    declare @leaveId bigint
	INSERT INTO tblLeave values(@employeeId,@leaveTypeId,@createdAt,@updatedAt,0);
	SET @leaveId = @@IDENTITY
	INSERT INTO tblDurationalLeave values(@leaveId,@date,@DurationalId,@createdAt,@updatedAt);
END



GO
/****** Object:  StoredProcedure [dbo].[spAssignHalfDayLeave]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Software Incubator
-- Create date: 25th October 2015
-- Description:	Assign a Half day leave
-- =============================================
CREATE PROCEDURE [dbo].[spAssignHalfDayLeave] 
	@employeeId bigint = 0, 
	@date datetime = 0,
	@leaveTypeId int,
	@shift int,
	@shiftId int,
	@createdAt datetime,
	@updatedAt datetime
AS
BEGIN
	SET NOCOUNT ON;
    declare @leaveId bigint
	INSERT INTO tblLeave values(@employeeId,@leaveTypeId,@createdAt,@updatedAt,0);
	SET @leaveId = @@IDENTITY
	INSERT INTO tblHalfDayLeave values(@leaveId,@date,@shift,@shiftId,@createdAt,@updatedAt);
END


GO
/****** Object:  StoredProcedure [dbo].[spAssignHalfDayLeaveRemovingShortDayLeave]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 26th December 2015
-- Description:	Deletes the short leave for the employee and assigns a half day leave
-- =============================================
CREATE PROCEDURE [dbo].[spAssignHalfDayLeaveRemovingShortDayLeave] 
	-- Add the parameters for the stored procedure here
	@employeeId bigint = 0, 
	@date datetime = 0,
	@createdAt datetime
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE tblLeave
    SET isDeleted=1
    WHERE EmployeeId =@employeeId AND Date= @date AND LeaveTypeId =3;

	INSERT INTO tblLeave values(@employeeId,@date,4,@createdAt,NULL,0);
END

GO
/****** Object:  StoredProcedure [dbo].[spAssignLeave]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 25th October 2015
-- Description:	Assign a Full day leave
-- =============================================
CREATE PROCEDURE [dbo].[spAssignLeave] 
	-- Add the parameters for the stored procedure here
	@employeeId bigint = 0, 
	@date datetime = 0,
	@leaveTypeId int,
	@createdAt datetime
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO tblLeave values(@employeeId,@date,@leaveTypeId,@createdAt,NULL,0);
END

GO
/****** Object:  StoredProcedure [dbo].[spAssignLeaveByRole]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spAssignMultiDayLeave]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Software Incubator
-- Create date: 25th October 2015
-- Description:	Assign a Multi Day leave
-- =============================================
CREATE PROCEDURE [dbo].[spAssignMultiDayLeave] 
	@employeeId bigint = 0, 
	@date datetime = 0,
	@leaveTypeId int,
	@startDate datetime,
	@endDate datetime,
	@createdAt datetime,
	@updatedAt datetime
AS
BEGIN
	SET NOCOUNT ON;
    declare @leaveId bigint
	INSERT INTO tblLeave values(@employeeId,@leaveTypeId,@createdAt,@updatedAt,0);
	SET @leaveId = @@IDENTITY
	INSERT INTO tblMultiDayLeave values(@leaveId,@startDate,@endDate,@createdAt,@updatedAt);
END



GO
/****** Object:  StoredProcedure [dbo].[spCreateDepartment]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spCreateEmployee]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spCreateEmployeeTransc]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spCreateTypeOfLeave]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spDeleteEmployee]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetActiveShift]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 04th October 2015
-- Description:	Get all Shifts
-- =============================================
CREATE PROCEDURE [dbo].[spGetActiveShift]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT 
		Id,
		FirstHalfStart,
		FirstHalfEnd,
		SecondHalfStart,
		SecondHalfEnd
	FROM 
		tblShifts
	WHERE 
		IsDeleted =0 AND
		isActive =1
END

GO
/****** Object:  StoredProcedure [dbo].[spGetAllDepartments]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetAllDurations]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetAllEmployees]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetAllLeavesAssignedByRole]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
/****** Object:  StoredProcedure [dbo].[spGetAllRoles]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetAllShifts]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetAllTypeOfLeaves]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetAllTypeOfLeavesAssignedByRole]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 12th November 2015
-- Description:	Gets All Types of Leave Assigned By Role
-- =============================================
CREATE PROCEDURE [dbo].[spGetAllTypeOfLeavesAssignedByRole] 
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
	      objTblLeaveAssignedByRole.Id,
		  objTblLeaveAssignedByRole.RoleId,
		  objTblLeaveAssignedByRole.LeaveTypeId,
		  objTblLeaveAssignedByRole.NoOfLeaves,
		  objTblLeaveAssignedByRole.IsPromoted,
		  objTblLeaveAssignedByRole.Limit,
		  objTblRole.Name,
		  objTblTypeOfLeave.Name
    FROM  tblTypeOfLeave objTblTypeOfLeave, tblLeaveAssignedByRole objTblLeaveAssignedByRole , tblRole objTblRole
	WHERE objTblLeaveAssignedByRole.RoleId=objTblRole.Id
			AND
		  objTblLeaveAssignedByRole.LeaveTypeId = objTblTypeOfLeave.Id
END
GO
/****** Object:  StoredProcedure [dbo].[spGetDayStatus]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Software Incubator
-- Create date: 20th December 2015
-- Description:	
-- =============================================
Create PROCEDURE [dbo].[spGetDayStatus] 
	-- Add the parameters for the stored procedure here
	@date datetime
AS
BEGIN
	 SELECT        Status
FROM            tblSpecialDays
where Date = @date
END



GO
/****** Object:  StoredProcedure [dbo].[spGetDepartmentById]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 11th November 2015
-- Description:	Returns Department by Id
-- =============================================
CREATE PROCEDURE [dbo].[spGetDepartmentById] 
@departmentId int
AS
BEGIN
     SET NOCOUNT ON;
	 SELECT name from tblDepartment
 	 WHERE Id = @departmentId
END

GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeeByID]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetEmployeesDefaultersByDate]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Software Incubator
-- Create date: 19th November 2015
-- Description:	Gives list of defaulter employees by Date
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeesDefaultersByDate] 
	-- Add the parameters for the stored procedure here
	@date datetime
AS
BEGIN


SELECT tblEmployeesMaster.Id As EmployeeId, tblEmployeesMaster.FirstName, tblEmployeesMaster.MiddleName, tblEmployeesMaster.LastName,tblEmployees.RoleId,tblEmployees.DepartmentId From tblEmployeesMaster,tblEmployees
WHERE tblEmployeesMaster.IsDeleted =0 AND 
tblEmployeesMaster.Id = tblEmployees.EmployeeId AND
tblEmployeesMaster.Id NOT in
(
(SELECT DISTINCT(EmployeeId) FROM tblAttendance
WHERE		cast ([Date] as date) = CAST(@date as date) )

UNION

(SELECT DISTINCT(EmployeeId) FROM tblLeave 
WHERE Id in(
SELECT     tblFullDayLeave.LeaveId
FROM       tblFullDayLeave
WHERE		cast ([Date] as date) = CAST(@date as date) 
UNION
SELECT     tblMultiDayLeave.LeaveId
FROM       tblMultiDayLeave
WHERE		CAST (StartDate as date) <= CAST(@date as date) AND CAST (EndDate as date) >= CAST(@date as date)
UNION
SELECT     tblHalfDayLeave.LeaveId
FROM       tblHalfDayLeave
WHERE		cast ([Date] as date) = CAST(@date as date) 
UNION
SELECT     tblDurationalLeave.LeaveId
FROM       tblDurationalLeave
WHERE		cast ([Date] as date) = CAST(@date as date)) 
AND IsDeleted = 0)
)
END





GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeesDefaultersByDeapartmentDateWise]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Software Incubator
-- Create date: 19th November 2015
-- Description:	Gives list of defaulter employees by Department and date
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeesDefaultersByDeapartmentDateWise] 
	-- Add the parameters for the stored procedure here
	@date datetime,
	@departmentId int
AS
BEGIN


SELECT tblEmployeesMaster.Id As EmployeeId, tblEmployeesMaster.FirstName, tblEmployeesMaster.MiddleName, tblEmployeesMaster.LastName,tblEmployees.RoleId,tblEmployees.DepartmentId From tblEmployeesMaster,tblEmployees
WHERE tblEmployeesMaster.IsDeleted =0 AND 
tblEmployeesMaster.Id = tblEmployees.EmployeeId AND
tblEmployeesMaster.Id in
(
(SELECT DISTINCT(EmployeeId) FROM tblAttendance
WHERE		cast ([Date] as date) = CAST(@date as date) )

UNION

(SELECT DISTINCT(EmployeeId) FROM tblLeave 
WHERE Id in(
SELECT     tblFullDayLeave.LeaveId
FROM       tblFullDayLeave
WHERE		cast ([Date] as date) = CAST(@date as date) 
UNION
SELECT     tblMultiDayLeave.LeaveId
FROM       tblMultiDayLeave
WHERE		CAST (StartDate as date) <= CAST(@date as date) AND CAST (EndDate as date) >= CAST(@date as date)
UNION
SELECT     tblHalfDayLeave.LeaveId
FROM       tblHalfDayLeave
WHERE		cast ([Date] as date) = CAST(@date as date) 
UNION
SELECT     tblDurationalLeave.LeaveId
FROM       tblDurationalLeave
WHERE		cast ([Date] as date) = CAST(@date as date)) 
AND IsDeleted = 0)
)

AND tblEmployees.DepartmentId =@departmentId
AND tblEmployees.EmployeeId = tblEmployeesMaster.Id
END




GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeesForBasicReport]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Software Incubator
-- Create date: 19th December 2015
-- Description:	Get All Employees For Basic Report 
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeesForBasicReport] 
	-- Add the parameters for the stored procedure here
	@date datetime
AS
BEGIN
	 SELECT        tblEmployeesMaster.FirstName + ' ' + tblEmployeesMaster.MiddleName + ' ' + tblEmployeesMaster.LastName AS Name, tblAttendance.EmployeeId, tblAttendance.EntryTime, tblAttendance.ExitTime, 
                   tblAttendance.Date
FROM          tblAttendance RIGHT OUTER JOIN   
              tblEmployeesMaster ON tblAttendance.EmployeeId = tblEmployeesMaster.Id
AND           tblAttendance.Date = @date

      
END



GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeesForDailyAttendanceReportByDeaprtment]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:  	Software Incubator
-- Create date: 19th December 2015
-- Description:	Get All Employees For Basic Report sorted by Department
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeesForDailyAttendanceReportByDeaprtment]
-- Add the parameters for the stored procedure here
@date datetime,
@departmentId int
AS
BEGIN
  SELECT
  DISTINCT
    tblEmployeesMaster.FirstName + ' ' + tblEmployeesMaster.MiddleName + ' ' + tblEmployeesMaster.LastName AS Name,
    tblEmployeesMaster.Id,
    min(tblAttendance.EntryTime),
    max(tblAttendance.ExitTime)

  FROM tblEmployees,tblAttendance
  RIGHT OUTER JOIN tblEmployeesMaster
    ON tblAttendance.EmployeeId = tblEmployeesMaster.Id
    AND tblAttendance.Date = @date
  WHERE tblEmployees.DepartmentId = @departmentId
    GROUP BY
			  tblEmployeesMaster.Id,
		      tblEmployeesMaster.FirstName,
	    	  tblEmployeesMaster.MiddleName,
			  tblEmployeesMaster.LastName

END




GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeesForDailyAttendanceReportByEmployeeId]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:  	Software Incubator
-- Create date: 19th December 2015
-- Description:	Get All Employees For Basic Report sorted by EmployeeId
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeesForDailyAttendanceReportByEmployeeId]
-- Add the parameters for the stored procedure here
@date datetime,
@employeeId int
AS
BEGIN
   SELECT
  DISTINCT
    tblEmployeesMaster.FirstName + ' ' + tblEmployeesMaster.MiddleName + ' ' + tblEmployeesMaster.LastName AS Name,
    tblEmployeesMaster.Id,
    min(tblAttendance.EntryTime),
    max(tblAttendance.ExitTime)

  FROM tblEmployees,tblAttendance
  RIGHT OUTER JOIN tblEmployeesMaster
    ON tblAttendance.EmployeeId = tblEmployeesMaster.Id
    AND tblAttendance.Date = @date
  WHERE  tblEmployeesMaster.id =@employeeId
    GROUP BY
			  tblEmployeesMaster.Id,
		      tblEmployeesMaster.FirstName,
	    	  tblEmployeesMaster.MiddleName,
			  tblEmployeesMaster.LastName

END




GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeesForDetailedReport]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Software Incubator
-- Create date: 20th December 2015
-- Description:	Get All Employees For Detailed Report 
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeesForDetailedReport] 
	-- Add the parameters for the stored procedure here
	@date datetime
AS
BEGIN
SELECT        tblEmployeesMaster.FirstName + ' ' + tblEmployeesMaster.MiddleName + ' ' + tblEmployeesMaster.LastName AS Name,tblEmployeesMaster.Id AS EmployeeId, Min(tblAttendance.EntryTime) AS EntryTime, Max(tblAttendance.ExitTime) AS ExitTime
FROM          tblAttendance RIGHT OUTER JOIN   
              tblEmployeesMaster ON tblAttendance.EmployeeId = tblEmployeesMaster.Id
AND           tblAttendance.Date = @date
GROUP BY
			  tblAttendance.EmployeeId,
			  tblEmployeesMaster.Id,
		      tblEmployeesMaster.FirstName,
	    	  tblEmployeesMaster.MiddleName,
			  tblEmployeesMaster.LastName
END



GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeesLateByDepartmentDateWise]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Software Incubator
-- Create date: 11th November 2015
-- Description:	Get All Employees Late Datewise By Department
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeesLateByDepartmentDateWise] 
	-- Add the parameters for the stored procedure here
	@date datetime,
	@departmentId int
AS
BEGIN
	SELECT tblAttendance.EmployeeId,Min(tblAttendance.EntryTime) As EntryTime
	FROM
    tblAttendance,tblEmployeesMaster,tblEmployees
	WHERE
	tblAttendance.[Date] = @date AND tblEmployeesMaster.Id = tblAttendance.EmployeeId AND tblEmployees.DepartmentId =@departmentId
	AND tblEmployees.EmployeeId = tblEmployeesMaster.Id
	GROUP BY
    tblAttendance.EmployeeId
	HAVING MIN(tblAttendance.EntryTime) > N'08:30:00.0000000'
END




GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeesLateDateWise]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Software Incubator
-- Create date: 11th November 2015
-- Description:	Get All Employees Late Datewise
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeesLateDateWise] 
	-- Add the parameters for the stored procedure here
	@date datetime
AS
BEGIN
	SET NOCOUNT ON;

    SELECT tblAttendance.EmployeeId,Min(tblAttendance.EntryTime) As EntryTime
	FROM
    tblAttendance
	WHERE
	tblAttendance.[Date] = @date 
	GROUP BY
    tblAttendance.EmployeeId
	HAVING MIN(tblAttendance.EntryTime) > N'08:30:00.0000000'

END



GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeesLeavingEarlyByDepartmentDateWise]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Software Incubator
-- Create date: 11th November 2015
-- Description:	Get All Employees Leaving Early Datewise By Department
-- =============================================
Create PROCEDURE [dbo].[spGetEmployeesLeavingEarlyByDepartmentDateWise] 
	-- Add the parameters for the stored procedure here
	@date datetime,
	@departmentId int
AS
BEGIN
	SELECT tblAttendance.EmployeeId,Max(tblAttendance.ExitTime) As ExitTime
	FROM
    tblAttendance,tblEmployeesMaster,tblEmployees
	WHERE
	tblAttendance.[Date] = @date AND tblEmployeesMaster.Id = tblAttendance.EmployeeId AND tblEmployees.DepartmentId =@departmentId
	AND tblEmployees.EmployeeId = tblEmployeesMaster.Id
	GROUP BY
    tblAttendance.EmployeeId
	HAVING Max(tblAttendance.ExitTime) < N'04:00:00.0000000'
END




GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeesLeavingEarlyDateWise]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Software Incubator
-- Create date: 24th November 2015
-- Description:	Get All Employees Leaving Early Datewise
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeesLeavingEarlyDateWise] 
	-- Add the parameters for the stored procedure here
	@date datetime
AS
BEGIN
	SET NOCOUNT ON;

    SELECT tblAttendance.EmployeeId,Max(tblAttendance.ExitTime) As ExitTime
	FROM
    tblAttendance
	WHERE
	tblAttendance.[Date] = @date 
	GROUP BY
    tblAttendance.EmployeeId
	HAVING Max(tblAttendance.ExitTime) < N'04:00:00.0000000'

END



GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeesOnFullDayLeaveDateWise]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Software Incubator
-- Create date: 11th November 2015
-- Description:	Generate Report By Department
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeesOnFullDayLeaveDateWise] 
	-- Add the parameters for the stored procedure here
	@date datetime
AS
BEGIN
	SET NOCOUNT ON;
	SELECT 
       objtblEmployeesMaster.FacultyId
      ,objtblEmployeesMaster.FirstName
      ,objtblEmployeesMaster.MiddleName
      ,objtblEmployeesMaster.LastName
  FROM tblEmployeesMaster objtblEmployeesMaster,tblFullDayLeave objtblFullDayLeave ,tblLeave objTblLeave
  WHERE  
       objTblLeave.Id = objtblFullDayLeave.LeaveId
  AND  CAST(objtblFullDayLeave.Date AS date) =  CAST(@date AS date)
  AND  objtblEmployeesMaster.Id = objTblLeave.EmployeeId
  AND objtblEmployeesMaster.IsDeleted = 0 
  AND  objTblLeave.isDeleted = 0
END




GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeesOnLeaveByDate]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Software Incubator
-- Create date: 19th November 2015
-- Description:	Gives list of employees on leave by Date
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeesOnLeaveByDate] 
	-- Add the parameters for the stored procedure here
	@date datetime
AS
BEGIN
SELECT DISTINCT(EmployeeId) FROM tblLeave 
WHERE Id in(
SELECT     tblFullDayLeave.LeaveId
FROM       tblFullDayLeave
WHERE		cast ([Date] as date) = CAST(@date as date) 
UNION
SELECT     tblMultiDayLeave.LeaveId
FROM       tblMultiDayLeave
WHERE		CAST (StartDate as date) <= CAST(@date as date) AND CAST (EndDate as date) >= CAST(@date as date)
UNION
SELECT     tblHalfDayLeave.LeaveId
FROM       tblHalfDayLeave
WHERE		cast ([Date] as date) = CAST(@date as date) 
UNION
SELECT     tblDurationalLeave.LeaveId
FROM       tblDurationalLeave
WHERE		cast ([Date] as date) = CAST(@date as date))
END


GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeesPresentByDepartmentDateWise]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Software Incubator
-- Create date: 11th November 2015
-- Description:	Generate Report By Department
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeesPresentByDepartmentDateWise] 
	-- Add the parameters for the stored procedure here
	@departmentId int = 0, 
	@date datetime
AS
BEGIN
	SET NOCOUNT ON;
	SELECT 
       objtblEmployeesMaster.FacultyId
      ,objtblEmployeesMaster.FirstName
      ,objtblEmployeesMaster.MiddleName
      ,objtblEmployeesMaster.LastName
  FROM tblEmployeesMaster objtblEmployeesMaster, tblAttendance objtblAttendance, tblEmployees objtblEmployees
  WHERE objtblEmployeesMaster.IsDeleted = 0 
  AND   objtblEmployeesMaster.Id = objtblAttendance.EmployeeId 
  AND   objtblAttendance.Date = (CAST(@date AS date))
  AND   objtblEmployeesMaster.Id = objtblEmployees.EmployeeId
  AND   objtblEmployees.DepartmentId = @departmentId
  AND   objtblAttendance.ExitTime IS NULL
END


GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeesPresentDateWise]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Software Incubator
-- Create date: 11th November 2015
-- Description:	Get All Employees Present 
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeesPresentDateWise] 
	-- Add the parameters for the stored procedure here
	@date datetime
AS
BEGIN
	SET NOCOUNT ON;
	SELECT 
       objtblEmployeesMaster.FacultyId
      ,objtblEmployeesMaster.FirstName
      ,objtblEmployeesMaster.MiddleName
      ,objtblEmployeesMaster.LastName
  FROM tblEmployeesMaster objtblEmployeesMaster, tblAttendance objtblAttendance
  WHERE objtblEmployeesMaster.IsDeleted = 0 
  AND   objtblEmployeesMaster.Id = objtblAttendance.EmployeeId 
  AND   objtblAttendance.Date = (CAST(@date AS date))
  AND   objtblAttendance.ExitTime IS NULL
END


GO
/****** Object:  StoredProcedure [dbo].[spGetEntriesDateAndEmployeeWise]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Software Incubator
-- Create date: 20th December 2015
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[spGetEntriesDateAndEmployeeWise] 
	-- Add the parameters for the stored procedure here
	@employeeId int,
	@date datetime
AS
BEGIN
	 SELECT        EntryTime, ExitTime
FROM            tblAttendance
WHERE        (Date = @date) AND (EmployeeId = @employeeId)
END



GO
/****** Object:  StoredProcedure [dbo].[spGetEntriesDateWise]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Software Incubator
-- Create date: 20th December 2015
-- Description:	
-- =============================================
create PROCEDURE [dbo].[spGetEntriesDateWise] 
	-- Add the parameters for the stored procedure here
	@date datetime
AS
BEGIN
	SELECT        EmployeeId,EntryTime, ExitTime
FROM            tblAttendance
WHERE        (Date = @date)
END



GO
/****** Object:  StoredProcedure [dbo].[spGetPunchRecordsOfEmployeeDateWise]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Software Incubator
-- Create date: 21st December 2015
-- Description:	Get Punch Records Of Employee By Date
-- =============================================
CREATE PROCEDURE [dbo].[spGetPunchRecordsOfEmployeeDateWise] 
	-- Add the parameters for the stored procedure here
	@employeeId bigint,
	@date datetime
AS
BEGIN
	 SELECT        tblAttendance.EntryTime AS EntryTime, tblAttendance.ExitTime AS ExitTime
     FROM          tblAttendance 
	 WHERE         tblAttendance.[Date] = @date AND 
	               tblAttendance.EmployeeId = @employeeId
END



GO
/****** Object:  StoredProcedure [dbo].[spGetRoleById]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 12th November 2015
-- Description:	Returns Role by Id
-- =============================================
CREATE PROCEDURE [dbo].[spGetRoleById] 
@roleId int
AS
BEGIN
     SET NOCOUNT ON;
	 SELECT name from tblRole
 	 WHERE Id = @roleId
END

GO
/****** Object:  StoredProcedure [dbo].[spGetTotalDurationOfEmployeesDatewise]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Software Incubator
-- Create date: 20th December 2015
-- Description:	Get Total Duration of Employees Datewise in Minutes
-- =============================================
CREATE PROCEDURE [dbo].[spGetTotalDurationOfEmployeesDatewise] 
	-- Add the parameters for the stored procedure here
	@employeeId int,
	@date datetime
AS
BEGIN
	 SELECT        SUM(DATEDIFF(minute, EntryTime, ExitTime)) As Minutes
     FROM          tblAttendance 
	 WHERE         [Date] = @date AND
                   EmployeeId = @employeeId
END


GO
/****** Object:  StoredProcedure [dbo].[spGetTypeOfLeaveOfEmployeeByDate]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Software Incubator
-- Create date: 21st December 2015
-- Description:	Get Type Of Leave Of Employee By Date
-- =============================================
CREATE PROCEDURE [dbo].[spGetTypeOfLeaveOfEmployeeByDate] 
	-- Add the parameters for the stored procedure here
	@employeeId bigint, 
	@date date
	

AS
BEGIN
    SELECT 
	LeaveTypeId FROM tblLeave 
	WHERE 
	EmployeeId =  @employeeId AND
	[Date] = @date
END

GO
/****** Object:  StoredProcedure [dbo].[spIsEmployeeOnDurationalLeaveByDate]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
	@date datetime,
	@count int = NULL output
AS
BEGIN
	SET NOCOUNT ON;
	SELECT @count = COUNT( Distinct objtblDurationalLeave.Id)
	FROM tblDurationalLeave objtblDurationalLeave , tblLeave objTblLeave
	WHERE
		 objTblLeave.Id = objtblDurationalLeave.LeaveId AND
		 objTblLeave.EmployeeId = @employeeId AND
		 CAST(objtblDurationalLeave.Date AS date) =  CAST(@date AS date)
	RETURN @count
END

GO
/****** Object:  StoredProcedure [dbo].[spIsEmployeeOnFullDayLeaveByDate]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
	@date datetime,
	@count int = NULL output

AS
BEGIN
	SET NOCOUNT ON;
	SELECT @count = COUNT( Distinct objtblFullDayLeave.Id)
	FROM tblFullDayLeave objtblFullDayLeave , tblLeave objTblLeave
	WHERE
		 objTblLeave.Id = objtblFullDayLeave.LeaveId AND
		 objTblLeave.EmployeeId = @employeeId AND
		 CAST(objtblFullDayLeave.Date AS date) =  CAST(@date AS date)
   RETURN @count
END

GO
/****** Object:  StoredProcedure [dbo].[spIsEmployeeOnHalfDayLeaveByDate]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
	@date datetime,
	@count int = NULL OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	SELECT @count = COUNT( Distinct objtblHalfDayLeave.Id)
	FROM tblHalfDayLeave objtblHalfDayLeave , tblLeave objTblLeave
	WHERE
		 objTblLeave.Id = objtblHalfDayLeave.LeaveId AND
		 objTblLeave.EmployeeId = @employeeId AND
		 CAST(objtblHalfDayLeave.Date AS date) =  CAST(@date AS date)
	RETURN @count
END

GO
/****** Object:  StoredProcedure [dbo].[spIsEmployeeOnLeaveByDate]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Software Incubator
-- Create date: 25th October 2015
-- Description:	Checks whether employee is on leave by Date
-- =============================================
CREATE PROCEDURE [dbo].[spIsEmployeeOnLeaveByDate] 
	-- Add the parameters for the stored procedure here
	@employeeId bigint, 
	@date date
AS
BEGIN
     SELECT COUNT(id) 
	 FROM tblLeave
	 WHERE EmployeeId = @employeeId AND
	       [Date] = @date
END


GO
/****** Object:  StoredProcedure [dbo].[spIsEmployeeOnMultidayLeaveByDate]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 25th October 2015
-- Description:	Checks whether employee is on multiday leave by Date
-- =============================================
CREATE PROCEDURE [dbo].[spIsEmployeeOnMultidayLeaveByDate] 
	-- Add the parameters for the stored procedure here
	@employeeId bigint, 
	@date datetime,
	@count int = NULL OUTPUT

AS
BEGIN
	SET NOCOUNT ON;
	SELECT @count = COUNT( Distinct objTblMultiDayLeave.Id)
	FROM tblMultiDayLeave objTblMultiDayLeave , tblLeave objTblLeave
	WHERE
		 objTblLeave.Id = objTblMultiDayLeave.LeaveId AND
		 objTblLeave.EmployeeId = @employeeId AND
		 CAST(objTblMultiDayLeave.StartDate AS date) <= DATEADD(DAY, (0), CAST(@date AS date)) AND
		 CAST(objTblMultiDayLeave.EndDate AS date) >= DATEADD(DAY, (0), CAST(@date AS date))
	Return @count


END

GO
/****** Object:  StoredProcedure [dbo].[spUpdateDepartment]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 11th November 2015
-- Description:	Updates Department Name by Id
-- =============================================
CREATE PROCEDURE [dbo].[spUpdateDepartment] 
@departmentId int,
@name nvarchar(MAX),
@updatedAt datetime
AS
BEGIN
     SET NOCOUNT ON;
	 UPDATE tblDepartment SET Name=@name, UpdatedOn = @updatedAt
	 Where Id = @departmentId
END

GO
/****** Object:  StoredProcedure [dbo].[spUpdateLeave]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 17th November 2015
-- Description:	Updates Leave Name by Id
-- =============================================
CREATE PROCEDURE [dbo].[spUpdateLeave] 
@leaveId int,
@name nvarchar(MAX),
@updatedAt datetime,
@masterLeaveType int
AS
BEGIN
     SET NOCOUNT ON;
	 UPDATE tblTypeOfLeave SET Name=@name, UpdatedOn = @updatedAt, MasterLeaveType = @masterLeaveType
	 Where Id = @leaveId
END

GO
/****** Object:  Table [dbo].[tblAttendance]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  Table [dbo].[tblDepartment]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  Table [dbo].[tblDuration]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDuration](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Duration] [time](7) NOT NULL,
	[TypeOfLeave] [int] NOT NULL,
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
/****** Object:  Table [dbo].[tblDurationalLeave]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  Table [dbo].[tblEmployees]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  Table [dbo].[tblEmployeesMaster]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  Table [dbo].[tblFullDayLeave]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  Table [dbo].[tblHalfDayLeave]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblHalfDayLeave](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
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
/****** Object:  Table [dbo].[tblHolidays]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblHolidays](
	[SNO] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_dbo.tblDays] PRIMARY KEY CLUSTERED 
(
	[SNO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblLeave]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLeave](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [bigint] NOT NULL,
	[Date] [datetime] NOT NULL,
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
/****** Object:  Table [dbo].[tblLeaveAssignedByRole]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  Table [dbo].[tblLeaveDetailsMonthWise]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  Table [dbo].[tblMultiDayLeave]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMultiDayLeave](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
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
/****** Object:  Table [dbo].[tblRole]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  Table [dbo].[tblShifts]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
/****** Object:  Table [dbo].[tblTypeOfLeave]    Script Date: 26-Dec-15 2:44:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTypeOfLeave](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedOn] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_tblTypeOfLeave] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblTypeOfLeaveMaster]    Script Date: 26-Dec-15 2:44:09 PM ******/
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

INSERT [dbo].[tblAttendance] ([SNo], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1, 5, CAST(0xA93A0B00 AS Date), CAST(0x07305AB191460000 AS Time), CAST(0x0730ACB592850000 AS Time))
INSERT [dbo].[tblAttendance] ([SNo], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (2, 1, CAST(0xA93A0B00 AS Date), CAST(0x07301652F7470000 AS Time), CAST(0x07302293D4860000 AS Time))
INSERT [dbo].[tblAttendance] ([SNo], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (3, 5, CAST(0xA93A0B00 AS Date), CAST(0x07305AB191460000 AS Time), CAST(0x07302293D4860000 AS Time))
INSERT [dbo].[tblAttendance] ([SNo], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (4, 5, CAST(0xAB3A0B00 AS Date), CAST(0x0700000000000000 AS Time), CAST(0x0730A89061940000 AS Time))
INSERT [dbo].[tblAttendance] ([SNo], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (5, 5, CAST(0xAB3A0B00 AS Date), CAST(0x0700000000000000 AS Time), CAST(0x0730A89061940000 AS Time))
INSERT [dbo].[tblAttendance] ([SNo], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (7, 5, CAST(0xAB3A0B00 AS Date), CAST(0x0700000000000000 AS Time), CAST(0x0730A89061940000 AS Time))
INSERT [dbo].[tblAttendance] ([SNo], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (8, 5, CAST(0xAB3A0B00 AS Date), CAST(0x07008E1FBA6F0000 AS Time), CAST(0x0730A89061940000 AS Time))
INSERT [dbo].[tblAttendance] ([SNo], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (10, 5, CAST(0xAB3A0B00 AS Date), CAST(0x07A09CE0EF920000 AS Time), CAST(0x0730A89061940000 AS Time))
INSERT [dbo].[tblAttendance] ([SNo], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (11, 5, CAST(0xAB3A0B00 AS Date), CAST(0x07D01C8A54930000 AS Time), CAST(0x0730A89061940000 AS Time))
INSERT [dbo].[tblAttendance] ([SNo], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (12, 5, CAST(0xAB3A0B00 AS Date), CAST(0x0750FB9863940000 AS Time), CAST(0x0730A89061940000 AS Time))
INSERT [dbo].[tblAttendance] ([SNo], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (13, 5, CAST(0xAD3A0B00 AS Date), CAST(0x0700DCF3E9950000 AS Time), CAST(0x0790F2FDED950000 AS Time))
INSERT [dbo].[tblAttendance] ([SNo], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (15, 5, CAST(0xB23A0B00 AS Date), CAST(0x07F0C811075B0000 AS Time), CAST(0x0790B276135B0000 AS Time))
INSERT [dbo].[tblAttendance] ([SNo], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (16, 5, CAST(0xB23A0B00 AS Date), CAST(0x07F0C811075B0000 AS Time), CAST(0x0790B276135B0000 AS Time))
INSERT [dbo].[tblAttendance] ([SNo], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (17, 1, CAST(0xB23A0B00 AS Date), CAST(0x07F09BE0055B0000 AS Time), CAST(0x0790B276135B0000 AS Time))
INSERT [dbo].[tblAttendance] ([SNo], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (18, 1, CAST(0xB23A0B00 AS Date), CAST(0x07F0C811075B0000 AS Time), CAST(0x07703279065B0000 AS Time))
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
SET IDENTITY_INSERT [dbo].[tblDuration] ON 

INSERT [dbo].[tblDuration] ([Id], [Duration], [TypeOfLeave], [IsActive], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (3, CAST(0x07009CA6920C0000 AS Time), 3, 1, CAST(0x0000A57700000000 AS DateTime), NULL, 0)
INSERT [dbo].[tblDuration] ([Id], [Duration], [TypeOfLeave], [IsActive], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (4, CAST(0x0700A01187210000 AS Time), 4, 1, CAST(0x0000A57700000000 AS DateTime), NULL, 0)
SET IDENTITY_INSERT [dbo].[tblDuration] OFF
SET IDENTITY_INSERT [dbo].[tblEmployees] ON 

INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (1, 1, N'src', N'pass', 1, 1, 8800764516, CAST(0x0000A48F00000000 AS DateTime), CAST(0x0000A48F00000000 AS DateTime), 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (2, 5, N'Presentation1.png', N'12345', 1, 1, 8800764516, CAST(0x0000A52C00812172 AS DateTime), CAST(0x0000A52C00812172 AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[tblEmployees] OFF
SET IDENTITY_INSERT [dbo].[tblEmployeesMaster] ON 

INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [FirstName], [MiddleName], [LastName], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (1, N'1310062', N'Anup', N'Kumar', N'Gupta', N'Male', CAST(0x0000A48F00000000 AS DateTime), CAST(0x0000A48F00000000 AS DateTime), CAST(0x0000A48F00000000 AS DateTime), CAST(0x0000A48F00000000 AS DateTime), 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [FirstName], [MiddleName], [LastName], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (5, N'12346', N'Anup', N'Kumar', N'Gupta', N'Male', CAST(0x000085E400000000 AS DateTime), CAST(0x0000A54400000000 AS DateTime), CAST(0x0000A52C00812172 AS DateTime), CAST(0x0000A52C00812172 AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[tblEmployeesMaster] OFF
SET IDENTITY_INSERT [dbo].[tblHolidays] ON 

INSERT [dbo].[tblHolidays] ([SNO], [Date], [Status]) VALUES (1, CAST(0xAD3A0B00 AS Date), 1)
SET IDENTITY_INSERT [dbo].[tblHolidays] OFF
SET IDENTITY_INSERT [dbo].[tblLeave] ON 

INSERT [dbo].[tblLeave] ([Id], [EmployeeId], [Date], [LeaveTypeId], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (10010, 5, CAST(0x0000A57A00000000 AS DateTime), 1, CAST(0x0000A57A00000000 AS DateTime), NULL, 0)
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
SET IDENTITY_INSERT [dbo].[tblShifts] ON 

INSERT [dbo].[tblShifts] ([Id], [FirstHalfStart], [FirstHalfEnd], [SecondHalfStart], [SecondHalfEnd], [IsActive], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (2, CAST(0x070074053F470000 AS Time), CAST(0x0700E03495640000 AS Time), CAST(0x078076CD95640000 AS Time), CAST(0x070080461C860000 AS Time), 1, CAST(0x0000A54E00000000 AS DateTime), NULL, 0)
SET IDENTITY_INSERT [dbo].[tblShifts] OFF
SET IDENTITY_INSERT [dbo].[tblTypeOfLeave] ON 

INSERT [dbo].[tblTypeOfLeave] ([Id], [Name], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (1, N'Casual Leave', CAST(0x0000A57A00000000 AS DateTime), NULL, 0)
INSERT [dbo].[tblTypeOfLeave] ([Id], [Name], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (3, N'Emergency Leave', CAST(0x0000A57A00000000 AS DateTime), NULL, 0)
INSERT [dbo].[tblTypeOfLeave] ([Id], [Name], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (4, N'Short Leave', CAST(0x0000A57A00000000 AS DateTime), NULL, 0)
INSERT [dbo].[tblTypeOfLeave] ([Id], [Name], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (5, N'Half Day Leave', CAST(0x0000A57A00000000 AS DateTime), NULL, 0)
SET IDENTITY_INSERT [dbo].[tblTypeOfLeave] OFF
SET IDENTITY_INSERT [dbo].[tblTypeOfLeaveMaster] ON 

INSERT [dbo].[tblTypeOfLeaveMaster] ([Id], [Name]) VALUES (1, N'Full Day  ')
INSERT [dbo].[tblTypeOfLeaveMaster] ([Id], [Name]) VALUES (2, N'Half Day')
INSERT [dbo].[tblTypeOfLeaveMaster] ([Id], [Name]) VALUES (3, N'Short Leave')
INSERT [dbo].[tblTypeOfLeaveMaster] ([Id], [Name]) VALUES (4, N'Bulk Leave')
SET IDENTITY_INSERT [dbo].[tblTypeOfLeaveMaster] OFF
/****** Object:  Index [IX_tblEmployees]    Script Date: 26-Dec-15 2:44:09 PM ******/
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
ON UPDATE CASCADE
ON DELETE CASCADE
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
ON UPDATE CASCADE
ON DELETE CASCADE
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
USE [master]
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET  READ_WRITE 
GO
