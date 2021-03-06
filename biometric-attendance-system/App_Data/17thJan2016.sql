USE [master]
GO
/****** Object:  Database [BiometricsAttendanceSystem]    Script Date: 17-Jan-16 2:36:10 PM ******/
CREATE DATABASE [BiometricsAttendanceSystem]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BiometricsAttendanceSystem', FILENAME = N'E:\Program Files\Microsoft SQL Server\MSSQL12.MANDAL\MSSQL\DATA\BiometricsAttendanceSystem.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BiometricsAttendanceSystem_log', FILENAME = N'E:\Program Files\Microsoft SQL Server\MSSQL12.MANDAL\MSSQL\DATA\BiometricsAttendanceSystem_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
/****** Object:  StoredProcedure [dbo].[IsSingle]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spAddDuration]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spAddRole]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spAddShift]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spAssignAttendance]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spAssignHalfDayLeaveRemovingShortDayLeave]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spAssignLeave]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spAssignLeaveByFaculty]    Script Date: 17-Jan-16 2:36:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Software Incubator
-- Create date: 31st October 2015
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[spAssignLeaveByFaculty]
@departmentId int
AS
BEGIN
	SET NOCOUNT ON;

Select tblEmployeesMaster.Name , 
       tblLeaveAssignedPerSession.LeaveTypeId , 
	   tblLeaveAssignedPerSession.NoOfLeaves
	   from tblEmployeesMaster JOIN tblleaveAssignedPerSession 
	   ON  tblEmployeesMaster.Id = tblLeaveAssignedPerSession.EmployeeId
	   JOIN tblEmployees ON tblEmployees.EmployeeId = tblEmployeesMaster.Id 
	   And tblEmployees.DepartmentId = @departmentId
END



GO
/****** Object:  StoredProcedure [dbo].[spAssignLeaveByRole]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
	@createdAt datetime
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO 
	         tblLeaveAssignedByRole 
	VALUES( @roleId,@leaveId,@noOfLeaves,@isPromoted,@createdAt,@createdAt,0)
END





GO
/****** Object:  StoredProcedure [dbo].[spCreateDepartment]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spCreateEmployee]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
	@name nvarchar(MAX), 
	@gender nvarchar(MAX),
	@dateOfBirth datetime,
	@joiningDate datetime,
	@isDeleted bit,
	@createdOn datetime
AS
BEGIN

	SET NOCOUNT ON;

   INSERT INTO dbo.tblEmployeesMaster
          ( 
            FacultyId,
			Name,
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
			@name,
			@gender,
			@dateOfBirth,
			@joiningDate,
			@createdOn,
			null,
			@isDeleted
          ) 
	SELECT @@IDENTITY
END

GO
/****** Object:  StoredProcedure [dbo].[spCreateEmployeeTransc]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spCreateTypeOfLeave]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
			@createdOn,
			@updatedOn,
			@isDeleted)
    END



GO
/****** Object:  StoredProcedure [dbo].[spDeleteEmployee]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetActiveShift]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetAllDepartments]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetAllDurations]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
			TypeOfLeave,
			Duration
	FROM tblDuration
	WHERE
			IsDeleted = 0 
END

GO
/****** Object:  StoredProcedure [dbo].[spGetAllEmployees]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
			objtblEmployeesMaster.Name,
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
/****** Object:  StoredProcedure [dbo].[spGetAllEmployeesByDepartment]    Script Date: 17-Jan-16 2:36:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Software Incubator
-- Create date: 26th December 2015
-- Description:	Returns All Employees Of a Particular department
-- =============================================
CREATE PROCEDURE [dbo].[spGetAllEmployeesByDepartment] 
	@departmentId int = 0
AS
BEGIN
     SET NOCOUNT ON;
	 SELECT objtblEmployeesMaster.Id AS EmployeeId,
			objtblEmployeesMaster.Name AS Name,
			objtblRole.Id AS RoleId,
			objtblRole.Name AS RoleName,
			objtblDepartment.Id AS DepartmentId,
			objtblDepartment.Name AS DepartmentName
	 FROM tblEmployeesMaster objtblEmployeesMaster, tblEmployees objtblEmployees,tblRole objtblRole,tblDepartment objtblDepartment
 	 WHERE objtblEmployeesMaster.Id = objtblEmployees.EmployeeId
	 AND  objtblEmployeesMaster.IsDeleted = 0  
	 AND  objtblEmployees.RoleId = objtblRole.Id
	 AND  objtblEmployees.DepartmentId = @departmentId
	 AND objtblDepartment.Id = objtblEmployees.DepartmentId
END


GO
/****** Object:  StoredProcedure [dbo].[spGetAllLeavesAssignedByRole]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetAllRoles]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetAllShifts]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetAllTypeOfLeaves]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
	      Id,
		  Name
    FROM  tblTypeOfLeave
	WHERE IsDeleted = 0
END



GO
/****** Object:  StoredProcedure [dbo].[spGetAllTypeOfLeavesAssignedByRole]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
		  objTblRole.Name,
		  objTblTypeOfLeave.Name
    FROM  tblTypeOfLeave objTblTypeOfLeave, tblLeaveAssignedByRole objTblLeaveAssignedByRole , tblRole objTblRole
	WHERE objTblLeaveAssignedByRole.RoleId=objTblRole.Id
			AND
		  objTblLeaveAssignedByRole.LeaveTypeId = objTblTypeOfLeave.Id
END


GO
/****** Object:  StoredProcedure [dbo].[spGetDataForOldLeaves]    Script Date: 17-Jan-16 2:36:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Software Incubator
-- Create date: 08th January 2016
-- Description:	Returns All Data For Old Stock Leaves
-- =============================================
CREATE PROCEDURE [dbo].[spGetDataForOldLeaves] 
AS
BEGIN
     SET NOCOUNT ON;
SELECT tblEmployeesMaster.Id, Name ,[SLCount],[ELCount],[SessionStartDate],[SesssionEndDate] 
FROM [tblLeavesOldStock] right outer join tblEmployeesMaster 
On tblEmployeesMaster.Id = tblLeavesOldStock.EmployeeId

END


GO
/****** Object:  StoredProcedure [dbo].[spGetDayStatus]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetDepartmentById]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetEmployeeById]    Script Date: 17-Jan-16 2:36:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Software Incubator
-- Create date: 10th October 2015
-- Description:	Get Employee by Id
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeeById] 
	@employeeId bigint = 0
AS
BEGIN
	SET NOCOUNT ON;
	SELECT objtblEmployeesMaster.Id,
			objtblEmployeesMaster.Name,
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
/****** Object:  StoredProcedure [dbo].[spGetEmployeesDefaultersByDate]    Script Date: 17-Jan-16 2:36:10 PM ******/
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


SELECT tblEmployeesMaster.Id As EmployeeId, tblEmployeesMaster.Name,tblEmployees.RoleId,tblEmployees.DepartmentId From tblEmployeesMaster,tblEmployees
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
/****** Object:  StoredProcedure [dbo].[spGetEmployeesForBasicReport]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
	 SELECT        tblEmployeesMaster.Name AS Name, tblAttendance.EmployeeId, tblAttendance.EntryTime, tblAttendance.ExitTime, 
                   tblAttendance.Date
FROM          tblAttendance RIGHT OUTER JOIN   
              tblEmployeesMaster ON tblAttendance.EmployeeId = tblEmployeesMaster.Id
AND           tblAttendance.Date = @date

      
END



GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeesForDailyAttendanceReportByDeaprtment]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
    tblEmployeesMaster.Name AS Name,
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
		      tblEmployeesMaster.Name

END




GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeesForDailyAttendanceReportByEmployeeId]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
    tblEmployeesMaster.Name AS Name,
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
		      tblEmployeesMaster.Name

END




GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeesForDetailedReport]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
SELECT        tblEmployeesMaster.Name AS Name,tblEmployeesMaster.Id AS EmployeeId, Min(tblAttendance.EntryTime) AS EntryTime, Max(tblAttendance.ExitTime) AS ExitTime
FROM          tblAttendance RIGHT OUTER JOIN   
              tblEmployeesMaster ON tblAttendance.EmployeeId = tblEmployeesMaster.Id
AND           tblAttendance.Date = @date
GROUP BY
			  tblAttendance.EmployeeId,
			  tblEmployeesMaster.Id,
		      tblEmployeesMaster.Name
END



GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeesLateDateWise]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetEmployeesLeavingEarlyDateWise]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetEmployeesPresentByDepartmentDateWise]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
      ,objtblEmployeesMaster.Name
  FROM tblEmployeesMaster objtblEmployeesMaster, tblAttendance objtblAttendance, tblEmployees objtblEmployees
  WHERE objtblEmployeesMaster.IsDeleted = 0 
  AND   objtblEmployeesMaster.Id = objtblAttendance.EmployeeId 
  AND   objtblAttendance.Date = (CAST(@date AS date))
  AND   objtblEmployeesMaster.Id = objtblEmployees.EmployeeId
  AND   objtblEmployees.DepartmentId = @departmentId
  AND   objtblAttendance.ExitTime IS NULL
END


GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeesPresentDateWise]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
      ,objtblEmployeesMaster.Name
  FROM tblEmployeesMaster objtblEmployeesMaster, tblAttendance objtblAttendance
  WHERE objtblEmployeesMaster.IsDeleted = 0 
  AND   objtblEmployeesMaster.Id = objtblAttendance.EmployeeId 
  AND   objtblAttendance.Date = (CAST(@date AS date))
  AND   objtblAttendance.ExitTime IS NULL
END


GO
/****** Object:  StoredProcedure [dbo].[spGetEntriesDateAndEmployeeWise]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetEntriesDateWise]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetLeaveAssignedByRoleById]    Script Date: 17-Jan-16 2:36:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Software Incubator
-- Create date: 14th January 2016
-- Description:	Returns LeaveAssignedByRole by Id
-- =============================================
CREATE PROCEDURE [dbo].[spGetLeaveAssignedByRoleById] 
@id int
AS
BEGIN
     SET NOCOUNT ON;
	 SELECT Id, RoleId , LeaveTypeId, NoOfLeaves , IsPromoted from tblLeaveAssignedByRole
 	 WHERE Id = @id
END




GO
/****** Object:  StoredProcedure [dbo].[spGetLeavesAssignedToEmployeeSessionWise]    Script Date: 17-Jan-16 2:36:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Software Incubator
-- Create date: 11th November 2015
-- Description:	Get All  Leaves  Assigned to Employees in  running Session
-- =============================================
CREATE PROCEDURE [dbo].[spGetLeavesAssignedToEmployeeSessionWise] 
	-- Add the parameters for the stored procedure here
	@employeeId bigint,
	@session datetime
AS
BEGIN
SELECT tblTypeOfLeave.Id,tblTypeOfLeave.Name , COUNT(LeavetypeId)  AS count
From tblLeaveAssignedPerSession RIGHT OUTER JOIN  tblTypeOfLeave  
ON tblLeaveAssignedPerSession.LeaveTypeId = tblTypeOfLeave.Id
AND EmployeeId = @employeeId
AND @session >= SessionStartDate
AND @session <= SessionEndDate
Group BY LeavetypeId,tblTypeOfLeave.Id,tblTypeOfLeave.Name
END




GO
/****** Object:  StoredProcedure [dbo].[spGetLeavesAvailedByMonthEmployeeWise]    Script Date: 17-Jan-16 2:36:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Software Incubator
-- Create date: 11th November 2015
-- Description:	Get All  Leaves of Employees Taken That Month
-- =============================================
CREATE PROCEDURE [dbo].[spGetLeavesAvailedByMonthEmployeeWise] 
	-- Add the parameters for the stored procedure here
	@employeeId bigint,
	@monthStartDate datetime,
	@monthEndDate datetime
AS
BEGIN
SELECT tblTypeOfLeave.Id,tblTypeOfLeave.Name , COUNT(LeavetypeId)  AS count
From tblLeave RIGHT OUTER JOIN  tblTypeOfLeave  
ON tblLeave.LeaveTypeId = tblTypeOfLeave.Id 
AND EmployeeId = @employeeId
AND [Date] Between @monthStartDate  AND @monthEndDate
Group BY tblLeave.LeaveTypeId , tblTypeOfLeave.Id ,tblTypeOfLeave.Name
END




GO
/****** Object:  StoredProcedure [dbo].[spGetLeavesAvailedUptoPreviousMonthEmployeeWise]    Script Date: 17-Jan-16 2:36:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Software Incubator
-- Create date: 11th November 2015
-- Description:	Get All  Leaves of Employees Taken That Month
-- =============================================
CREATE PROCEDURE [dbo].[spGetLeavesAvailedUptoPreviousMonthEmployeeWise] 
	-- Add the parameters for the stored procedure here
	@employeeId bigint,
	@sessionStart datetime,
	@sessionEnd datetime,
	@monthStartDate datetime
AS
BEGIN
SELECT tblTypeOfLeave.Id,tblTypeOfLeave.Name , COUNT(LeavetypeId)  AS count
From tblLeave RIGHT OUTER JOIN  tblTypeOfLeave  
ON tblLeave.LeaveTypeId = tblTypeOfLeave.Id 
AND EmployeeId = @employeeId
AND [Date] Between @sessionStart  AND @sessionEnd
AND [Date] < @monthStartDate
Group BY tblLeave.LeaveTypeId , tblTypeOfLeave.Id, tblTypeOfLeave.Name
END




GO
/****** Object:  StoredProcedure [dbo].[spGetLeavesOldStockDepartmentWise]    Script Date: 17-Jan-16 2:36:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Software Incubator
-- Create date: 11th November 2015
-- Description:	Get All Old Stock of Leaves of Employees By Department
-- =============================================
CREATE PROCEDURE [dbo].[spGetLeavesOldStockDepartmentWise] 
	-- Add the parameters for the stored procedure here
	@departmentId int
AS
BEGIN
Select tblEmployeesMaster.Id, tblEmployeesMaster.Name, tblLeavesOldStock.SLCount , tblLeavesOldStock.ELCount 
from tblLeavesOldStock right outer join tblEmployeesMaster 
on tblEmployeesMaster.Id = tblLeavesOldStock.EmployeeId
join tblEmployees
on tblEmployeesMaster.Id = tblEmployees.EmployeeId
AND tblEmployees.DepartmentId = @departmentId
END




GO
/****** Object:  StoredProcedure [dbo].[spGetPunchRecordsOfEmployeeDateWise]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetRoleById]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetTotalDurationOfEmployeesDatewise]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spGetTypeOfLeaveById]    Script Date: 17-Jan-16 2:36:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Software Incubator
-- Create date: 03rd October 2015
-- Description:	Gets Type of Leave By Id
-- =============================================
CREATE PROCEDURE [dbo].[spGetTypeOfLeaveById] 
@leaveId int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT
		  Name
    FROM  tblTypeOfLeave
	WHERE Id =@leaveId AND IsDeleted = 0
END



GO
/****** Object:  StoredProcedure [dbo].[spGetTypeOfLeaveOfEmployeeByDate]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spIsEmployeeOnLeaveByDate]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spUpdateDepartment]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  StoredProcedure [dbo].[spUpdateDuration]    Script Date: 17-Jan-16 2:36:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Software Incubator
-- Create date: 15th Jan 2016
-- Description:	Updates Duration by Id
-- =============================================
CREATE PROCEDURE [dbo].[spUpdateDuration] 
@durationId int,
@duration time(7),
@updatedAt datetime
AS
BEGIN
     SET NOCOUNT ON;
	 UPDATE tblDuration SET Duration=@duration, UpdatedOn = @updatedAt
	 Where Id = @durationId
END





GO
/****** Object:  StoredProcedure [dbo].[spUpdateEmployeeByEmployeeId]    Script Date: 17-Jan-16 2:36:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SI
-- Create date: 29thSeptember2015
-- Description:	Creates a new Employee and returns Employee ID of created Employee 
-- =============================================
CREATE PROCEDURE [dbo].[spUpdateEmployeeByEmployeeId]
	-- Add the parameters for the stored procedure here
	@employeeId bigint,
	@gender nvarchar(MAX),
	@dateOfBirth datetime,
	@joiningDate datetime,
	@isDeleted bit,
	@updatedOn datetime,
	@password nvarchar(MAX),
	@roleId int,
	@departmentId int,
	@contactNumber bigint
AS
BEGIN

	SET NOCOUNT ON;

   UPDATE dbo.tblEmployeesMaster
   SET 	  Gender = @gender,
		  DateOfBirth = @dateOfBirth ,
		  JoiningDate = @joiningDate,
		  UpdatedAt = @updatedOn,
		  IsDeleted = 0
   WHERE Id = @employeeId
   
   UPDATE dbo.tblEmployees
   SET 	  [Password] = @password,
		  RoleId = @roleId ,
		  DepartmentId = @departmentId,
		  ContactNumber =@contactNumber,
		  UpdatedAt = @updatedOn,
		  IsDeleted = 0
   WHERE EmployeeId =@employeeId
END

GO
/****** Object:  StoredProcedure [dbo].[spUpdateLeave]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
@updatedAt datetime
AS
BEGIN
     SET NOCOUNT ON;
	 UPDATE tblTypeOfLeave SET Name=@name, UpdatedOn = @updatedAt
	 Where Id = @leaveId
END



GO
/****** Object:  StoredProcedure [dbo].[spUpdateRole]    Script Date: 17-Jan-16 2:36:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Software Incubator
-- Create date: 17th November 2015
-- Description:	Updates Role Name by Id
-- =============================================
CREATE PROCEDURE [dbo].[spUpdateRole] 
@roleId int,
@name nvarchar(MAX),
@updatedAt datetime
AS
BEGIN
     SET NOCOUNT ON;
	 UPDATE tblRole SET Name=@name, UpdatedOn = @updatedAt
	 Where Id = @roleId
END



GO
/****** Object:  Table [dbo].[tblAttendance]    Script Date: 17-Jan-16 2:36:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAttendance](
	[Sno] [bigint] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [bigint] NOT NULL,
	[Date] [datetime] NOT NULL,
	[EntryTime] [time](0) NOT NULL,
	[ExitTime] [time](0) NULL,
 CONSTRAINT [PK_tblAttendance] PRIMARY KEY CLUSTERED 
(
	[Sno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblDepartment]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  Table [dbo].[tblDuration]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  Table [dbo].[tblEmployees]    Script Date: 17-Jan-16 2:36:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblEmployees](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [bigint] NOT NULL,
	[ImagePath] [nvarchar](max) NULL,
	[Password] [nvarchar](max) NULL,
	[RoleId] [int] NULL,
	[DepartmentId] [int] NULL,
	[ContactNumber] [bigint] NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_tblEmployees_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblEmployeesMaster]    Script Date: 17-Jan-16 2:36:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblEmployeesMaster](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[FacultyId] [nvarchar](max) NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Gender] [nvarchar](max) NULL,
	[DateOfBirth] [datetime] NULL,
	[JoiningDate] [datetime] NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedAt] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_tblEmployees] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblHolidays]    Script Date: 17-Jan-16 2:36:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblHolidays](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NOT NULL,
	[Status] [int] NOT NULL,
	[NameOfHoliday] [nvarchar](50) NULL,
 CONSTRAINT [PK_dbo.tblDays] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblLeave]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  Table [dbo].[tblLeaveAssignedByRole]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
	[UpdatedAt] [datetime] NULL,
	[CreatedAt] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_tblLeaveAssignedByRole] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblLeaveAssignedPerSession]    Script Date: 17-Jan-16 2:36:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLeaveAssignedPerSession](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [bigint] NOT NULL,
	[LeaveTypeId] [int] NOT NULL,
	[NoOfLeaves] [int] NULL,
	[SessionStartDate] [date] NOT NULL,
	[SessionEndDate] [date] NOT NULL,
 CONSTRAINT [PK_tblLeaveAssignedPerSession] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblLeavesOldStock]    Script Date: 17-Jan-16 2:36:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLeavesOldStock](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [bigint] NOT NULL,
	[SLCount] [int] NOT NULL,
	[ELCount] [int] NOT NULL,
	[SessionStartDate] [date] NOT NULL,
	[SesssionEndDate] [date] NOT NULL,
 CONSTRAINT [PK_tblLeavesOldStock] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblRole]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  Table [dbo].[tblSession]    Script Date: 17-Jan-16 2:36:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSession](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SessionStartDate] [datetime] NULL,
	[SessionEndDate] [datetime] NULL,
 CONSTRAINT [PK_tblSession] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblShifts]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
/****** Object:  Table [dbo].[tblTypeOfLeave]    Script Date: 17-Jan-16 2:36:10 PM ******/
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
SET IDENTITY_INSERT [dbo].[tblAttendance] ON 

INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1, 1, CAST(0x0000A57700000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (2, 6, CAST(0x0000A57700000000 AS DateTime), CAST(0x00E8710000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (3, 7, CAST(0x0000A57700000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (4, 8, CAST(0x0000A57700000000 AS DateTime), CAST(0x00B06D0000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (5, 9, CAST(0x0000A57700000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (6, 10, CAST(0x0000A57700000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x0050270100000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (7, 11, CAST(0x0000A57700000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (8, 12, CAST(0x0000A57700000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (9, 13, CAST(0x0000A57700000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (10, 15, CAST(0x0000A57700000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (11, 16, CAST(0x0000A57700000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (12, 18, CAST(0x0000A57700000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (13, 19, CAST(0x0000A57700000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (14, 20, CAST(0x0000A57700000000 AS DateTime), CAST(0x0060720000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (15, 21, CAST(0x0000A57700000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (16, 22, CAST(0x0000A57700000000 AS DateTime), CAST(0x005C760000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (17, 23, CAST(0x0000A57700000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (18, 24, CAST(0x0000A57700000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (19, 25, CAST(0x0000A57700000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (20, 26, CAST(0x0000A57700000000 AS DateTime), CAST(0x009C720000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (21, 27, CAST(0x0000A57700000000 AS DateTime), CAST(0x005C760000000000 AS Time), CAST(0x0050270100000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (22, 28, CAST(0x0000A57700000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (23, 29, CAST(0x0000A57700000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (24, 30, CAST(0x0000A57700000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (25, 31, CAST(0x0000A57700000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (26, 32, CAST(0x0000A57700000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (27, 33, CAST(0x0000A57700000000 AS DateTime), CAST(0x00DC6E0000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (28, 34, CAST(0x0000A57700000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (29, 35, CAST(0x0000A57700000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (30, 36, CAST(0x0000A57700000000 AS DateTime), CAST(0x003C780000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (31, 37, CAST(0x0000A57700000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (32, 38, CAST(0x0000A57700000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (33, 40, CAST(0x0000A57700000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (34, 1, CAST(0x0000A57600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (35, 6, CAST(0x0000A57600000000 AS DateTime), CAST(0x009C720000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (36, 7, CAST(0x0000A57600000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (37, 8, CAST(0x0000A57600000000 AS DateTime), CAST(0x00CC6F0000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (38, 9, CAST(0x0000A57600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (39, 10, CAST(0x0000A57600000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00E0E20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (40, 11, CAST(0x0000A57600000000 AS DateTime), CAST(0x0058E30000000000 AS Time), CAST(0x0078FF0000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (41, 12, CAST(0x0000A57600000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (42, 13, CAST(0x0000A57600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (43, 15, CAST(0x0000A57600000000 AS DateTime), CAST(0x0020760000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (44, 16, CAST(0x0000A57600000000 AS DateTime), CAST(0x0014730000000000 AS Time), CAST(0x00D0E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (45, 18, CAST(0x0000A57600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (46, 19, CAST(0x0000A57600000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x0094E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (47, 20, CAST(0x0000A57600000000 AS DateTime), CAST(0x0014730000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (48, 21, CAST(0x0000A57600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (49, 22, CAST(0x0000A57600000000 AS DateTime), CAST(0x0020760000000000 AS Time), CAST(0x00D0E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (50, 23, CAST(0x0000A57600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (51, 24, CAST(0x0000A57600000000 AS DateTime), CAST(0x0050730000000000 AS Time), CAST(0x0094E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (52, 25, CAST(0x0000A57600000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x001CE30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (53, 26, CAST(0x0000A57600000000 AS DateTime), CAST(0x001C7A0000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (54, 27, CAST(0x0000A57600000000 AS DateTime), CAST(0x0098760000000000 AS Time), CAST(0x0050270100000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (55, 28, CAST(0x0000A57600000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (56, 29, CAST(0x0000A57600000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (57, 30, CAST(0x0000A57600000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (58, 31, CAST(0x0000A57600000000 AS DateTime), CAST(0x0050730000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (59, 32, CAST(0x0000A57600000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x00B4E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (60, 33, CAST(0x0000A57600000000 AS DateTime), CAST(0x00186F0000000000 AS Time), CAST(0x00B4E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (61, 34, CAST(0x0000A57600000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x0078E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (62, 35, CAST(0x0000A57600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (63, 36, CAST(0x0000A57600000000 AS DateTime), CAST(0x0088770000000000 AS Time), CAST(0x00B4E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (64, 37, CAST(0x0000A57600000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x00B4E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (65, 38, CAST(0x0000A57600000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x001CE30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (66, 40, CAST(0x0000A57600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (67, 1, CAST(0x0000A57500000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (68, 6, CAST(0x0000A57500000000 AS DateTime), CAST(0x0014730000000000 AS Time), CAST(0x00B4E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (69, 7, CAST(0x0000A57500000000 AS DateTime), CAST(0x0050730000000000 AS Time), CAST(0x001CE30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (70, 8, CAST(0x0000A57500000000 AS DateTime), CAST(0x00CC6F0000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (71, 9, CAST(0x0000A57500000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (72, 10, CAST(0x0000A57500000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x0050270100000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (73, 11, CAST(0x0000A57500000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (74, 12, CAST(0x0000A57500000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x00E0E20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (75, 13, CAST(0x0000A57500000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (76, 15, CAST(0x0000A57500000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (77, 16, CAST(0x0000A57500000000 AS DateTime), CAST(0x0050730000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (78, 18, CAST(0x0000A57500000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (79, 19, CAST(0x0000A57500000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (80, 20, CAST(0x0000A57500000000 AS DateTime), CAST(0x0014730000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (81, 21, CAST(0x0000A57500000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (82, 22, CAST(0x0000A57500000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (83, 23, CAST(0x0000A57500000000 AS DateTime), CAST(0x0020760000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (84, 24, CAST(0x0000A57500000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x001CE30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (85, 25, CAST(0x0000A57500000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (86, 26, CAST(0x0000A57500000000 AS DateTime), CAST(0x0014730000000000 AS Time), CAST(0x0038E50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (87, 27, CAST(0x0000A57500000000 AS DateTime), CAST(0x0088770000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (88, 28, CAST(0x0000A57500000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (89, 29, CAST(0x0000A57500000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (90, 30, CAST(0x0000A57500000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (91, 31, CAST(0x0000A57500000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (92, 32, CAST(0x0000A57500000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (93, 33, CAST(0x0000A57500000000 AS DateTime), CAST(0x00CC6F0000000000 AS Time), CAST(0x00E0E20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (94, 34, CAST(0x0000A57500000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x00D0E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (95, 35, CAST(0x0000A57500000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (96, 36, CAST(0x0000A57500000000 AS DateTime), CAST(0x00B4780000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (97, 37, CAST(0x0000A57500000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (98, 38, CAST(0x0000A57500000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (99, 40, CAST(0x0000A57500000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x0058E30000000000 AS Time))
GO
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (100, 1, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (101, 6, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (102, 7, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (103, 8, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (104, 9, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (105, 10, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (106, 11, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (107, 12, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (108, 13, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (109, 15, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (110, 16, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (111, 18, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (112, 19, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (113, 20, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (114, 21, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (115, 22, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (116, 23, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (117, 24, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (118, 25, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (119, 26, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (120, 27, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (121, 28, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (122, 29, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (123, 30, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (124, 31, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (125, 32, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (126, 33, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (127, 34, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (128, 35, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (129, 36, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (130, 37, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (131, 38, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (132, 40, CAST(0x0000A57400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (133, 1, CAST(0x0000A57300000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (134, 6, CAST(0x0000A57300000000 AS DateTime), CAST(0x0060720000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (135, 7, CAST(0x0000A57300000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (136, 8, CAST(0x0000A57300000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (137, 9, CAST(0x0000A57300000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (138, 10, CAST(0x0000A57300000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x00FCF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (139, 11, CAST(0x0000A57300000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x00B0F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (140, 12, CAST(0x0000A57300000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x00A4F10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (141, 13, CAST(0x0000A57300000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (142, 15, CAST(0x0000A57300000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x00B0F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (143, 16, CAST(0x0000A57300000000 AS DateTime), CAST(0x00D8720000000000 AS Time), CAST(0x0058F20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (144, 18, CAST(0x0000A57300000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (145, 19, CAST(0x0000A57300000000 AS DateTime), CAST(0x00FCF30000000000 AS Time), CAST(0x0078FF0000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (146, 20, CAST(0x0000A57300000000 AS DateTime), CAST(0x009C720000000000 AS Time), CAST(0x0038F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (147, 21, CAST(0x0000A57300000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (148, 22, CAST(0x0000A57300000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x00C0F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (149, 23, CAST(0x0000A57300000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x0038F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (150, 24, CAST(0x0000A57300000000 AS DateTime), CAST(0x0020760000000000 AS Time), CAST(0x0078F00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (151, 25, CAST(0x0000A57300000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x00ECF40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (152, 26, CAST(0x0000A57300000000 AS DateTime), CAST(0x00D8720000000000 AS Time), CAST(0x00B0F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (153, 27, CAST(0x0000A57300000000 AS DateTime), CAST(0x004C770000000000 AS Time), CAST(0x00D0F20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (154, 28, CAST(0x0000A57300000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x0038F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (155, 29, CAST(0x0000A57300000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x0038F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (156, 30, CAST(0x0000A57300000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x0038F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (157, 31, CAST(0x0000A57300000000 AS DateTime), CAST(0x0050730000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (158, 32, CAST(0x0000A57300000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x001CF20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (159, 33, CAST(0x0000A57300000000 AS DateTime), CAST(0x0044700000000000 AS Time), CAST(0x000CF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (160, 34, CAST(0x0000A57300000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (161, 35, CAST(0x0000A57300000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (162, 36, CAST(0x0000A57300000000 AS DateTime), CAST(0x0000780000000000 AS Time), CAST(0x0058F20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (163, 37, CAST(0x0000A57300000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00A4F10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (164, 38, CAST(0x0000A57300000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x0058F20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (165, 40, CAST(0x0000A57300000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (166, 1, CAST(0x0000A57200000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (167, 6, CAST(0x0000A57200000000 AS DateTime), CAST(0x009C720000000000 AS Time), CAST(0x0058F20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (168, 7, CAST(0x0000A57200000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x0094F20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (169, 8, CAST(0x0000A57200000000 AS DateTime), CAST(0x0034710000000000 AS Time), CAST(0x003CF00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (170, 9, CAST(0x0000A57200000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (171, 10, CAST(0x0000A57200000000 AS DateTime), CAST(0x00C4770000000000 AS Time), CAST(0x0084F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (172, 11, CAST(0x0000A57200000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x0084F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (173, 12, CAST(0x0000A57200000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x00D0F20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (174, 13, CAST(0x0000A57200000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (175, 15, CAST(0x0000A57200000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x00D0F20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (176, 16, CAST(0x0000A57200000000 AS DateTime), CAST(0x0050730000000000 AS Time), CAST(0x00D0F20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (177, 18, CAST(0x0000A57200000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (178, 19, CAST(0x0000A57200000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (179, 20, CAST(0x0000A57200000000 AS DateTime), CAST(0x0050730000000000 AS Time), CAST(0x00D0F20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (180, 21, CAST(0x0000A57200000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (181, 22, CAST(0x0000A57200000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x000CF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (182, 23, CAST(0x0000A57200000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x0048F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (183, 24, CAST(0x0000A57200000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x00D0F20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (184, 25, CAST(0x0000A57200000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x0084F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (185, 26, CAST(0x0000A57200000000 AS DateTime), CAST(0x00D4760000000000 AS Time), CAST(0x00FCF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (186, 27, CAST(0x0000A57200000000 AS DateTime), CAST(0x00D4760000000000 AS Time), CAST(0x00C0F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (187, 28, CAST(0x0000A57200000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x0048F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (188, 29, CAST(0x0000A57200000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x000CF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (189, 30, CAST(0x0000A57200000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x0084F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (190, 31, CAST(0x0000A57200000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x0038F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (191, 32, CAST(0x0000A57200000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0038F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (192, 33, CAST(0x0000A57200000000 AS DateTime), CAST(0x00F8700000000000 AS Time), CAST(0x00A4F10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (193, 34, CAST(0x0000A57200000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (194, 35, CAST(0x0000A57200000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (195, 36, CAST(0x0000A57200000000 AS DateTime), CAST(0x00C4770000000000 AS Time), CAST(0x0068F10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (196, 37, CAST(0x0000A57200000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x00F0F00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (197, 38, CAST(0x0000A57200000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (198, 40, CAST(0x0000A57200000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (199, 1, CAST(0x0000A57100000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
GO
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (200, 6, CAST(0x0000A57100000000 AS DateTime), CAST(0x0014730000000000 AS Time), CAST(0x00F0F00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (201, 7, CAST(0x0000A57100000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x00A4F10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (202, 8, CAST(0x0000A57100000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (203, 9, CAST(0x0000A57100000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (204, 10, CAST(0x0000A57100000000 AS DateTime), CAST(0x0088770000000000 AS Time), CAST(0x00FCF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (205, 11, CAST(0x0000A57100000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x0038F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (206, 12, CAST(0x0000A57100000000 AS DateTime), CAST(0x0098760000000000 AS Time), CAST(0x00B4F00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (207, 13, CAST(0x0000A57100000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (208, 15, CAST(0x0000A57100000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x0038F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (209, 16, CAST(0x0000A57100000000 AS DateTime), CAST(0x0050730000000000 AS Time), CAST(0x00D0F20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (210, 18, CAST(0x0000A57100000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (211, 19, CAST(0x0000A57100000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00FCF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (212, 20, CAST(0x0000A57100000000 AS DateTime), CAST(0x0050730000000000 AS Time), CAST(0x00FCF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (213, 21, CAST(0x0000A57100000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (214, 22, CAST(0x0000A57100000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x00FCF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (215, 23, CAST(0x0000A57100000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00FCF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (216, 24, CAST(0x0000A57100000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x00A4F10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (217, 25, CAST(0x0000A57100000000 AS DateTime), CAST(0x00C4770000000000 AS Time), CAST(0x0038F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (218, 26, CAST(0x0000A57100000000 AS DateTime), CAST(0x0050730000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (219, 27, CAST(0x0000A57100000000 AS DateTime), CAST(0x0098760000000000 AS Time), CAST(0x0038F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (220, 28, CAST(0x0000A57100000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x0074F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (221, 29, CAST(0x0000A57100000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x0074F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (222, 30, CAST(0x0000A57100000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0038F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (223, 31, CAST(0x0000A57100000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (224, 32, CAST(0x0000A57100000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x0094F20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (225, 33, CAST(0x0000A57100000000 AS DateTime), CAST(0x0008700000000000 AS Time), CAST(0x00C0F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (226, 34, CAST(0x0000A57100000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (227, 35, CAST(0x0000A57100000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (228, 36, CAST(0x0000A57100000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x00B0F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (229, 37, CAST(0x0000A57100000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x001CF20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (230, 38, CAST(0x0000A57100000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x000CF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (231, 40, CAST(0x0000A57100000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (232, 1, CAST(0x0000A57000000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (233, 6, CAST(0x0000A57000000000 AS DateTime), CAST(0x0024720000000000 AS Time), CAST(0x0000F00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (234, 7, CAST(0x0000A57000000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x00A4F10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (235, 8, CAST(0x0000A57000000000 AS DateTime), CAST(0x0034710000000000 AS Time), CAST(0x00ECF40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (236, 9, CAST(0x0000A57000000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (237, 10, CAST(0x0000A57000000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x0010EF0000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (238, 11, CAST(0x0000A57000000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x0038F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (239, 12, CAST(0x0000A57000000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x00B0F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (240, 13, CAST(0x0000A57000000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (241, 15, CAST(0x0000A57000000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x00B0F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (242, 16, CAST(0x0000A57000000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x00FCF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (243, 18, CAST(0x0000A57000000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (244, 19, CAST(0x0000A57000000000 AS DateTime), CAST(0x0020760000000000 AS Time), CAST(0x0038F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (245, 20, CAST(0x0000A57000000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x0038F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (246, 21, CAST(0x0000A57000000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (247, 22, CAST(0x0000A57000000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x0074F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (248, 23, CAST(0x0000A57000000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00FCF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (249, 24, CAST(0x0000A57000000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x00FCF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (250, 25, CAST(0x0000A57000000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00FCF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (251, 26, CAST(0x0000A57000000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x00B0F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (252, 27, CAST(0x0000A57000000000 AS DateTime), CAST(0x005C760000000000 AS Time), CAST(0x0028F50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (253, 28, CAST(0x0000A57000000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x00B0F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (254, 29, CAST(0x0000A57000000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x00B0F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (255, 30, CAST(0x0000A57000000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x0074F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (256, 31, CAST(0x0000A57000000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x0064F50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (257, 32, CAST(0x0000A57000000000 AS DateTime), CAST(0x0020760000000000 AS Time), CAST(0x0078F00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (258, 33, CAST(0x0000A57000000000 AS DateTime), CAST(0x00186F0000000000 AS Time), CAST(0x00E0F10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (259, 34, CAST(0x0000A57000000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (260, 35, CAST(0x0000A57000000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (261, 36, CAST(0x0000A57000000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x00A4F10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (262, 37, CAST(0x0000A57000000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x0078F00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (263, 38, CAST(0x0000A57000000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x001CF20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (264, 40, CAST(0x0000A57000000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (265, 1, CAST(0x0000A56F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (266, 6, CAST(0x0000A56F00000000 AS DateTime), CAST(0x00AC710000000000 AS Time), CAST(0x0058F20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (267, 7, CAST(0x0000A56F00000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x003CF00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (268, 8, CAST(0x0000A56F00000000 AS DateTime), CAST(0x0050730000000000 AS Time), CAST(0x00B4F00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (269, 9, CAST(0x0000A56F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (270, 10, CAST(0x0000A56F00000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x0050270100000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (271, 11, CAST(0x0000A56F00000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x0074F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (272, 12, CAST(0x0000A56F00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0084F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (273, 13, CAST(0x0000A56F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (274, 15, CAST(0x0000A56F00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0064F50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (275, 16, CAST(0x0000A56F00000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x0084F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (276, 18, CAST(0x0000A56F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (277, 19, CAST(0x0000A56F00000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x0094F20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (278, 20, CAST(0x0000A56F00000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x0074F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (279, 21, CAST(0x0000A56F00000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (280, 22, CAST(0x0000A56F00000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x0084F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (281, 23, CAST(0x0000A56F00000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x0074F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (282, 24, CAST(0x0000A56F00000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x0038F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (283, 25, CAST(0x0000A56F00000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x0074F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (284, 26, CAST(0x0000A56F00000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x00ECF40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (285, 27, CAST(0x0000A56F00000000 AS DateTime), CAST(0x0020760000000000 AS Time), CAST(0x00C0F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (286, 28, CAST(0x0000A56F00000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00FCF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (287, 29, CAST(0x0000A56F00000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x0084F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (288, 30, CAST(0x0000A56F00000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x001CF20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (289, 31, CAST(0x0000A56F00000000 AS DateTime), CAST(0x00D0F20000000000 AS Time), CAST(0x0078FF0000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (290, 32, CAST(0x0000A56F00000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x00E0F10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (291, 33, CAST(0x0000A56F00000000 AS DateTime), CAST(0x00A06E0000000000 AS Time), CAST(0x001CF20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (292, 34, CAST(0x0000A56F00000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x003CF00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (293, 35, CAST(0x0000A56F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (294, 36, CAST(0x0000A56F00000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x0078F00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (295, 37, CAST(0x0000A56F00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x003CF00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (296, 38, CAST(0x0000A56F00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0048F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (297, 40, CAST(0x0000A56F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (298, 1, CAST(0x0000A56E00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (299, 6, CAST(0x0000A56E00000000 AS DateTime), CAST(0x0014730000000000 AS Time), CAST(0x00B4F00000000000 AS Time))
GO
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (300, 7, CAST(0x0000A56E00000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x002CF10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (301, 8, CAST(0x0000A56E00000000 AS DateTime), CAST(0x0014730000000000 AS Time), CAST(0x0084F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (302, 9, CAST(0x0000A56E00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (303, 10, CAST(0x0000A56E00000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x00E0F10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (304, 11, CAST(0x0000A56E00000000 AS DateTime), CAST(0x0010770000000000 AS Time), CAST(0x0074F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (305, 12, CAST(0x0000A56E00000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x0068F10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (306, 13, CAST(0x0000A56E00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (307, 15, CAST(0x0000A56E00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0074F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (308, 16, CAST(0x0000A56E00000000 AS DateTime), CAST(0x0060720000000000 AS Time), CAST(0x00B0F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (309, 18, CAST(0x0000A56E00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (310, 19, CAST(0x0000A56E00000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (311, 20, CAST(0x0000A56E00000000 AS DateTime), CAST(0x0060720000000000 AS Time), CAST(0x0074F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (312, 21, CAST(0x0000A56E00000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (313, 22, CAST(0x0000A56E00000000 AS DateTime), CAST(0x005C760000000000 AS Time), CAST(0x00B0F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (314, 23, CAST(0x0000A56E00000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x0074F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (315, 24, CAST(0x0000A56E00000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x002CF10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (316, 25, CAST(0x0000A56E00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (317, 26, CAST(0x0000A56E00000000 AS DateTime), CAST(0x0060720000000000 AS Time), CAST(0x0038F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (318, 27, CAST(0x0000A56E00000000 AS DateTime), CAST(0x0088770000000000 AS Time), CAST(0x0038F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (319, 28, CAST(0x0000A56E00000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x00B0F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (320, 29, CAST(0x0000A56E00000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x0074F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (321, 30, CAST(0x0000A56E00000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00B0F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (322, 31, CAST(0x0000A56E00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (323, 32, CAST(0x0000A56E00000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00A4F10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (324, 33, CAST(0x0000A56E00000000 AS DateTime), CAST(0x00646E0000000000 AS Time), CAST(0x00ECF40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (325, 34, CAST(0x0000A56E00000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x002CF10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (326, 35, CAST(0x0000A56E00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (327, 36, CAST(0x0000A56E00000000 AS DateTime), CAST(0x00187E0000000000 AS Time), CAST(0x0094F20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (328, 37, CAST(0x0000A56E00000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x001CF20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (329, 38, CAST(0x0000A56E00000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (330, 40, CAST(0x0000A56E00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (331, 1, CAST(0x0000A56D00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (332, 6, CAST(0x0000A56D00000000 AS DateTime), CAST(0x00BC700000000000 AS Time), CAST(0x00B4F00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (333, 7, CAST(0x0000A56D00000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x0068F10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (334, 8, CAST(0x0000A56D00000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x00B4F00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (335, 9, CAST(0x0000A56D00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (336, 10, CAST(0x0000A56D00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x00E8BC0000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (337, 11, CAST(0x0000A56D00000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (338, 12, CAST(0x0000A56D00000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x001CF20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (339, 13, CAST(0x0000A56D00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (340, 15, CAST(0x0000A56D00000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x00B4F00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (341, 16, CAST(0x0000A56D00000000 AS DateTime), CAST(0x0024720000000000 AS Time), CAST(0x0004BF0000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (342, 18, CAST(0x0000A56D00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (343, 19, CAST(0x0000A56D00000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x00F0F00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (344, 20, CAST(0x0000A56D00000000 AS DateTime), CAST(0x00E8710000000000 AS Time), CAST(0x00B4F00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (345, 21, CAST(0x0000A56D00000000 AS DateTime), CAST(0x0024720000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (346, 22, CAST(0x0000A56D00000000 AS DateTime), CAST(0x0070710000000000 AS Time), CAST(0x002CF10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (347, 23, CAST(0x0000A56D00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (348, 24, CAST(0x0000A56D00000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x002CF10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (349, 25, CAST(0x0000A56D00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x003CF00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (350, 26, CAST(0x0000A56D00000000 AS DateTime), CAST(0x00E8710000000000 AS Time), CAST(0x00A4F10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (351, 27, CAST(0x0000A56D00000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x00B4F00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (352, 28, CAST(0x0000A56D00000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x002CF10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (353, 29, CAST(0x0000A56D00000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x0068F10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (354, 30, CAST(0x0000A56D00000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x0078F00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (355, 31, CAST(0x0000A56D00000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x001CF20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (356, 32, CAST(0x0000A56D00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0098EE0000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (357, 33, CAST(0x0000A56D00000000 AS DateTime), CAST(0x0080700000000000 AS Time), CAST(0x00F0F00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (358, 34, CAST(0x0000A56D00000000 AS DateTime), CAST(0x0050730000000000 AS Time), CAST(0x003CF00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (359, 35, CAST(0x0000A56D00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (360, 36, CAST(0x0000A56D00000000 AS DateTime), CAST(0x0088770000000000 AS Time), CAST(0x0078F00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (361, 37, CAST(0x0000A56D00000000 AS DateTime), CAST(0x0014730000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (362, 38, CAST(0x0000A56D00000000 AS DateTime), CAST(0x0024720000000000 AS Time), CAST(0x0068F10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (363, 40, CAST(0x0000A56D00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (364, 1, CAST(0x0000A56C00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (365, 6, CAST(0x0000A56C00000000 AS DateTime), CAST(0x00AC710000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (366, 7, CAST(0x0000A56C00000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x0094F20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (367, 8, CAST(0x0000A56C00000000 AS DateTime), CAST(0x0050730000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (368, 9, CAST(0x0000A56C00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (369, 10, CAST(0x0000A56C00000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x000CF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (370, 11, CAST(0x0000A56C00000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x0048F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (371, 12, CAST(0x0000A56C00000000 AS DateTime), CAST(0x0078F00000000000 AS Time), CAST(0x0078FF0000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (372, 13, CAST(0x0000A56C00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (373, 15, CAST(0x0000A56C00000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x0048F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (374, 16, CAST(0x0000A56C00000000 AS DateTime), CAST(0x00D8720000000000 AS Time), CAST(0x000CF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (375, 18, CAST(0x0000A56C00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (376, 19, CAST(0x0000A56C00000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x00D0F20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (377, 20, CAST(0x0000A56C00000000 AS DateTime), CAST(0x00D8720000000000 AS Time), CAST(0x0048F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (378, 21, CAST(0x0000A56C00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (379, 22, CAST(0x0000A56C00000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x000CF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (380, 23, CAST(0x0000A56C00000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x0048F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (381, 24, CAST(0x0000A56C00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0094F20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (382, 25, CAST(0x0000A56C00000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x0084F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (383, 26, CAST(0x0000A56C00000000 AS DateTime), CAST(0x0098760000000000 AS Time), CAST(0x00FCF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (384, 27, CAST(0x0000A56C00000000 AS DateTime), CAST(0x00C4770000000000 AS Time), CAST(0x00E0F10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (385, 28, CAST(0x0000A56C00000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x000CF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (386, 29, CAST(0x0000A56C00000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x000CF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (387, 30, CAST(0x0000A56C00000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x0084F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (388, 31, CAST(0x0000A56C00000000 AS DateTime), CAST(0x0014730000000000 AS Time), CAST(0x00B8740000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (389, 32, CAST(0x0000A56C00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x00A4F10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (390, 33, CAST(0x0000A56C00000000 AS DateTime), CAST(0x00906F0000000000 AS Time), CAST(0x0058F20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (391, 34, CAST(0x0000A56C00000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (392, 35, CAST(0x0000A56C00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (393, 36, CAST(0x0000A56C00000000 AS DateTime), CAST(0x0010770000000000 AS Time), CAST(0x00A4F10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (394, 37, CAST(0x0000A56C00000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x00E0F10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (395, 38, CAST(0x0000A56C00000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x00A4F10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (396, 40, CAST(0x0000A56C00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (397, 1, CAST(0x0000A56B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (398, 6, CAST(0x0000A56B00000000 AS DateTime), CAST(0x0070710000000000 AS Time), CAST(0x00E0F10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (399, 7, CAST(0x0000A56B00000000 AS DateTime), CAST(0x0014730000000000 AS Time), CAST(0x0084F30000000000 AS Time))
GO
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (400, 8, CAST(0x0000A56B00000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (401, 9, CAST(0x0000A56B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (402, 10, CAST(0x0000A56B00000000 AS DateTime), CAST(0x0050730000000000 AS Time), CAST(0x00D0F20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (403, 11, CAST(0x0000A56B00000000 AS DateTime), CAST(0x0084F30000000000 AS Time), CAST(0x0078FF0000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (404, 12, CAST(0x0000A56B00000000 AS DateTime), CAST(0x0098760000000000 AS Time), CAST(0x00FCF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (405, 13, CAST(0x0000A56B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (406, 15, CAST(0x0000A56B00000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x0084F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (407, 16, CAST(0x0000A56B00000000 AS DateTime), CAST(0x0014730000000000 AS Time), CAST(0x000CF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (408, 18, CAST(0x0000A56B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (409, 19, CAST(0x0000A56B00000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x000CF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (410, 20, CAST(0x0000A56B00000000 AS DateTime), CAST(0x0014730000000000 AS Time), CAST(0x00C0F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (411, 21, CAST(0x0000A56B00000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (412, 22, CAST(0x0000A56B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (413, 23, CAST(0x0000A56B00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (414, 24, CAST(0x0000A56B00000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x0038F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (415, 25, CAST(0x0000A56B00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x00C0F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (416, 26, CAST(0x0000A56B00000000 AS DateTime), CAST(0x0050730000000000 AS Time), CAST(0x0084F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (417, 27, CAST(0x0000A56B00000000 AS DateTime), CAST(0x0098760000000000 AS Time), CAST(0x0050270100000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (418, 28, CAST(0x0000A56B00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0048F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (419, 29, CAST(0x0000A56B00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0048F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (420, 30, CAST(0x0000A56B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (421, 31, CAST(0x0000A56B00000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x00FCF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (422, 32, CAST(0x0000A56B00000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x00D0F20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (423, 33, CAST(0x0000A56B00000000 AS DateTime), CAST(0x00DC6E0000000000 AS Time), CAST(0x0058F20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (424, 34, CAST(0x0000A56B00000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x001CF20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (425, 35, CAST(0x0000A56B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (426, 36, CAST(0x0000A56B00000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x00A4F10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (427, 37, CAST(0x0000A56B00000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x002CF10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (428, 38, CAST(0x0000A56B00000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x0048F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (429, 40, CAST(0x0000A56B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (430, 1, CAST(0x0000A56A00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (431, 6, CAST(0x0000A56A00000000 AS DateTime), CAST(0x009C720000000000 AS Time), CAST(0x0000F00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (432, 7, CAST(0x0000A56A00000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x0048F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (433, 8, CAST(0x0000A56A00000000 AS DateTime), CAST(0x0008700000000000 AS Time), CAST(0x0038F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (434, 9, CAST(0x0000A56A00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (435, 10, CAST(0x0000A56A00000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00FCF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (436, 11, CAST(0x0000A56A00000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x00C0F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (437, 12, CAST(0x0000A56A00000000 AS DateTime), CAST(0x0078780000000000 AS Time), CAST(0x0084F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (438, 13, CAST(0x0000A56A00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (439, 15, CAST(0x0000A56A00000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x00C0F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (440, 16, CAST(0x0000A56A00000000 AS DateTime), CAST(0x0014730000000000 AS Time), CAST(0x0084F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (441, 18, CAST(0x0000A56A00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (442, 19, CAST(0x0000A56A00000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x0084F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (443, 20, CAST(0x0000A56A00000000 AS DateTime), CAST(0x0014730000000000 AS Time), CAST(0x00C0F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (444, 21, CAST(0x0000A56A00000000 AS DateTime), CAST(0x0038F40000000000 AS Time), CAST(0x0078FF0000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (445, 22, CAST(0x0000A56A00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (446, 23, CAST(0x0000A56A00000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x00C0F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (447, 24, CAST(0x0000A56A00000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x0074F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (448, 25, CAST(0x0000A56A00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x00FCF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (449, 26, CAST(0x0000A56A00000000 AS DateTime), CAST(0x0014730000000000 AS Time), CAST(0x0074F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (450, 27, CAST(0x0000A56A00000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x00ECF40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (451, 28, CAST(0x0000A56A00000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x00FCF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (452, 29, CAST(0x0000A56A00000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x0038F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (453, 30, CAST(0x0000A56A00000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x0038F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (454, 31, CAST(0x0000A56A00000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x00B0F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (455, 32, CAST(0x0000A56A00000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x00C0F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (456, 33, CAST(0x0000A56A00000000 AS DateTime), CAST(0x0008700000000000 AS Time), CAST(0x0058F20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (457, 34, CAST(0x0000A56A00000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x0048F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (458, 35, CAST(0x0000A56A00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (459, 36, CAST(0x0000A56A00000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x00C0F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (460, 37, CAST(0x0000A56A00000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x0048F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (461, 38, CAST(0x0000A56A00000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x0038F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (462, 40, CAST(0x0000A56A00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (463, 1, CAST(0x0000A56900000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (464, 6, CAST(0x0000A56900000000 AS DateTime), CAST(0x0034710000000000 AS Time), CAST(0x00FCF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (465, 7, CAST(0x0000A56900000000 AS DateTime), CAST(0x0050730000000000 AS Time), CAST(0x0084F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (466, 8, CAST(0x0000A56900000000 AS DateTime), CAST(0x00CC6F0000000000 AS Time), CAST(0x00E0F10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (467, 9, CAST(0x0000A56900000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (468, 10, CAST(0x0000A56900000000 AS DateTime), CAST(0x0098760000000000 AS Time), CAST(0x0038F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (469, 11, CAST(0x0000A56900000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (470, 12, CAST(0x0000A56900000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (471, 13, CAST(0x0000A56900000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (472, 15, CAST(0x0000A56900000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x00FCF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (473, 16, CAST(0x0000A56900000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x002CF10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (474, 18, CAST(0x0000A56900000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (475, 19, CAST(0x0000A56900000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x0084F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (476, 20, CAST(0x0000A56900000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x00FCF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (477, 21, CAST(0x0000A56900000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (478, 22, CAST(0x0000A56900000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (479, 23, CAST(0x0000A56900000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x00FCF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (480, 24, CAST(0x0000A56900000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0038F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (481, 25, CAST(0x0000A56900000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x00FCF30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (482, 26, CAST(0x0000A56900000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x0074F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (483, 27, CAST(0x0000A56900000000 AS DateTime), CAST(0x0020760000000000 AS Time), CAST(0x0050270100000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (484, 28, CAST(0x0000A56900000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00C0F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (485, 29, CAST(0x0000A56900000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x0084F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (486, 30, CAST(0x0000A56900000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x0038F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (487, 31, CAST(0x0000A56900000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x0074F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (488, 32, CAST(0x0000A56900000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x00C0F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (489, 33, CAST(0x0000A56900000000 AS DateTime), CAST(0x00546F0000000000 AS Time), CAST(0x001CF20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (490, 34, CAST(0x0000A56900000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x0084F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (491, 35, CAST(0x0000A56900000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (492, 36, CAST(0x0000A56900000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x0048F30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (493, 37, CAST(0x0000A56900000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x00A4F10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (494, 38, CAST(0x0000A56900000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0074F40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (495, 40, CAST(0x0000A56900000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (496, 1, CAST(0x0000A56800000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (497, 6, CAST(0x0000A56800000000 AS DateTime), CAST(0x0070710000000000 AS Time), CAST(0x005CEE0000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (498, 7, CAST(0x0000A56800000000 AS DateTime), CAST(0x0024720000000000 AS Time), CAST(0x0064F50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (499, 8, CAST(0x0000A56800000000 AS DateTime), CAST(0x009C720000000000 AS Time), CAST(0x0090F60000000000 AS Time))
GO
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (500, 9, CAST(0x0000A56800000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (501, 10, CAST(0x0000A56800000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x0064F50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (502, 11, CAST(0x0000A56800000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x00A0F50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (503, 12, CAST(0x0000A56800000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (504, 13, CAST(0x0000A56800000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (505, 15, CAST(0x0000A56800000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x0028F50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (506, 16, CAST(0x0000A56800000000 AS DateTime), CAST(0x005C760000000000 AS Time), CAST(0x0028F50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (507, 18, CAST(0x0000A56800000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (508, 19, CAST(0x0000A56800000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x0028F50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (509, 20, CAST(0x0000A56800000000 AS DateTime), CAST(0x0098760000000000 AS Time), CAST(0x0028F50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (510, 21, CAST(0x0000A56800000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (511, 22, CAST(0x0000A56800000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x0064F50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (512, 23, CAST(0x0000A56800000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00A0F50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (513, 24, CAST(0x0000A56800000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00A0F50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (514, 25, CAST(0x0000A56800000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00DCF50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (515, 26, CAST(0x0000A56800000000 AS DateTime), CAST(0x005C760000000000 AS Time), CAST(0x00A0F50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (516, 27, CAST(0x0000A56800000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x0050270100000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (517, 28, CAST(0x0000A56800000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x0064F50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (518, 29, CAST(0x0000A56800000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (519, 30, CAST(0x0000A56800000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x0064F50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (520, 31, CAST(0x0000A56800000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x0028F50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (521, 32, CAST(0x0000A56800000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0028F50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (522, 33, CAST(0x0000A56800000000 AS DateTime), CAST(0x00A06E0000000000 AS Time), CAST(0x0094F20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (523, 34, CAST(0x0000A56800000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x00ECF40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (524, 35, CAST(0x0000A56800000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (525, 36, CAST(0x0000A56800000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x0018F60000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (526, 37, CAST(0x0000A56800000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0064F50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (527, 38, CAST(0x0000A56800000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x0054F60000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (528, 40, CAST(0x0000A56800000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (529, 1, CAST(0x0000A56700000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (530, 6, CAST(0x0000A56700000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x0094E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (531, 7, CAST(0x0000A56700000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x00FCE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (532, 8, CAST(0x0000A56700000000 AS DateTime), CAST(0x0080700000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (533, 9, CAST(0x0000A56700000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (534, 10, CAST(0x0000A56700000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (535, 11, CAST(0x0000A56700000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (536, 12, CAST(0x0000A56700000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (537, 13, CAST(0x0000A56700000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (538, 15, CAST(0x0000A56700000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (539, 16, CAST(0x0000A56700000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (540, 18, CAST(0x0000A56700000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (541, 19, CAST(0x0000A56700000000 AS DateTime), CAST(0x00D0E30000000000 AS Time), CAST(0x0078FF0000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (542, 20, CAST(0x0000A56700000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (543, 21, CAST(0x0000A56700000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (544, 22, CAST(0x0000A56700000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (545, 23, CAST(0x0000A56700000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x00D0E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (546, 24, CAST(0x0000A56700000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x0094E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (547, 25, CAST(0x0000A56700000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x00FCE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (548, 26, CAST(0x0000A56700000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0074E50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (549, 27, CAST(0x0000A56700000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (550, 28, CAST(0x0000A56700000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (551, 29, CAST(0x0000A56700000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (552, 30, CAST(0x0000A56700000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (553, 31, CAST(0x0000A56700000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (554, 32, CAST(0x0000A56700000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x00A4E20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (555, 33, CAST(0x0000A56700000000 AS DateTime), CAST(0x0080700000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (556, 34, CAST(0x0000A56700000000 AS DateTime), CAST(0x00D4760000000000 AS Time), CAST(0x00A4E20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (557, 35, CAST(0x0000A56700000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (558, 36, CAST(0x0000A56700000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00D0E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (559, 37, CAST(0x0000A56700000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x001CE30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (560, 38, CAST(0x0000A56700000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x00D0E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (561, 40, CAST(0x0000A56700000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (562, 1, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (563, 6, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (564, 7, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (565, 8, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (566, 9, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (567, 10, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (568, 11, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (569, 12, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (570, 13, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (571, 15, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (572, 16, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (573, 18, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (574, 19, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (575, 20, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (576, 21, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (577, 22, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (578, 23, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (579, 24, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (580, 25, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (581, 26, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (582, 27, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (583, 28, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (584, 29, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (585, 30, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (586, 31, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (587, 32, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (588, 33, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (589, 34, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (590, 35, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (591, 36, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (592, 37, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (593, 38, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (594, 40, CAST(0x0000A56600000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (595, 1, CAST(0x0000A56500000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (596, 6, CAST(0x0000A56500000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x00B4E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (597, 7, CAST(0x0000A56500000000 AS DateTime), CAST(0x005C760000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (598, 8, CAST(0x0000A56500000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (599, 9, CAST(0x0000A56500000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
GO
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (600, 10, CAST(0x0000A56500000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x00B4E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (601, 11, CAST(0x0000A56500000000 AS DateTime), CAST(0x0020760000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (602, 12, CAST(0x0000A56500000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (603, 13, CAST(0x0000A56500000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (604, 15, CAST(0x0000A56500000000 AS DateTime), CAST(0x0020760000000000 AS Time), CAST(0x00D0E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (605, 16, CAST(0x0000A56500000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (606, 18, CAST(0x0000A56500000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (607, 19, CAST(0x0000A56500000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (608, 20, CAST(0x0000A56500000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00D0E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (609, 21, CAST(0x0000A56500000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (610, 22, CAST(0x0000A56500000000 AS DateTime), CAST(0x0098760000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (611, 23, CAST(0x0000A56500000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (612, 24, CAST(0x0000A56500000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (613, 25, CAST(0x0000A56500000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x00D0E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (614, 26, CAST(0x0000A56500000000 AS DateTime), CAST(0x00D4760000000000 AS Time), CAST(0x0038E50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (615, 27, CAST(0x0000A56500000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x0050270100000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (616, 28, CAST(0x0000A56500000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (617, 29, CAST(0x0000A56500000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (618, 30, CAST(0x0000A56500000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (619, 31, CAST(0x0000A56500000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x0074E50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (620, 32, CAST(0x0000A56500000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (621, 33, CAST(0x0000A56500000000 AS DateTime), CAST(0x00DC6E0000000000 AS Time), CAST(0x0000E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (622, 34, CAST(0x0000A56500000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x00B4E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (623, 35, CAST(0x0000A56500000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (624, 36, CAST(0x0000A56500000000 AS DateTime), CAST(0x00907E0000000000 AS Time), CAST(0x00E0E20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (625, 37, CAST(0x0000A56500000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x0000E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (626, 38, CAST(0x0000A56500000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (627, 40, CAST(0x0000A56500000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (628, 1, CAST(0x0000A56400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (629, 6, CAST(0x0000A56400000000 AS DateTime), CAST(0x009C720000000000 AS Time), CAST(0x00E0E20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (630, 7, CAST(0x0000A56400000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (631, 8, CAST(0x0000A56400000000 AS DateTime), CAST(0x00906F0000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (632, 9, CAST(0x0000A56400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (633, 10, CAST(0x0000A56400000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x001CE30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (634, 11, CAST(0x0000A56400000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (635, 12, CAST(0x0000A56400000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (636, 13, CAST(0x0000A56400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (637, 15, CAST(0x0000A56400000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (638, 16, CAST(0x0000A56400000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (639, 18, CAST(0x0000A56400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (640, 19, CAST(0x0000A56400000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (641, 20, CAST(0x0000A56400000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (642, 21, CAST(0x0000A56400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (643, 22, CAST(0x0000A56400000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (644, 23, CAST(0x0000A56400000000 AS DateTime), CAST(0x0068790000000000 AS Time), CAST(0x00FCE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (645, 24, CAST(0x0000A56400000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (646, 25, CAST(0x0000A56400000000 AS DateTime), CAST(0x00C4770000000000 AS Time), CAST(0x00FCE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (647, 26, CAST(0x0000A56400000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x00FCE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (648, 27, CAST(0x0000A56400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (649, 28, CAST(0x0000A56400000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (650, 29, CAST(0x0000A56400000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (651, 30, CAST(0x0000A56400000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (652, 31, CAST(0x0000A56400000000 AS DateTime), CAST(0x0048E40000000000 AS Time), CAST(0x0078FF0000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (653, 32, CAST(0x0000A56400000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (654, 33, CAST(0x0000A56400000000 AS DateTime), CAST(0x0098B20000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (655, 34, CAST(0x0000A56400000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x003CE10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (656, 35, CAST(0x0000A56400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (657, 36, CAST(0x0000A56400000000 AS DateTime), CAST(0x0078780000000000 AS Time), CAST(0x00E8AD0000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (658, 37, CAST(0x0000A56400000000 AS DateTime), CAST(0x003C780000000000 AS Time), CAST(0x0000E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (659, 38, CAST(0x0000A56400000000 AS DateTime), CAST(0x0000780000000000 AS Time), CAST(0x00E8CB0000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (660, 40, CAST(0x0000A56400000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (661, 1, CAST(0x0000A56300000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (662, 6, CAST(0x0000A56300000000 AS DateTime), CAST(0x00E8710000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (663, 7, CAST(0x0000A56300000000 AS DateTime), CAST(0x0008700000000000 AS Time), CAST(0x001CE30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (664, 8, CAST(0x0000A56300000000 AS DateTime), CAST(0x00D8720000000000 AS Time), CAST(0x001CE30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (665, 9, CAST(0x0000A56300000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (666, 10, CAST(0x0000A56300000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (667, 11, CAST(0x0000A56300000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (668, 12, CAST(0x0000A56300000000 AS DateTime), CAST(0x00D4760000000000 AS Time), CAST(0x001CE30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (669, 13, CAST(0x0000A56300000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (670, 15, CAST(0x0000A56300000000 AS DateTime), CAST(0x00807F0000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (671, 16, CAST(0x0000A56300000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x0094E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (672, 18, CAST(0x0000A56300000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (673, 19, CAST(0x0000A56300000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (674, 20, CAST(0x0000A56300000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (675, 21, CAST(0x0000A56300000000 AS DateTime), CAST(0x00E8710000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (676, 22, CAST(0x0000A56300000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (677, 23, CAST(0x0000A56300000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (678, 24, CAST(0x0000A56300000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (679, 25, CAST(0x0000A56300000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (680, 26, CAST(0x0000A56300000000 AS DateTime), CAST(0x005C760000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (681, 27, CAST(0x0000A56300000000 AS DateTime), CAST(0x0020760000000000 AS Time), CAST(0x00B0E50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (682, 28, CAST(0x0000A56300000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (683, 29, CAST(0x0000A56300000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (684, 30, CAST(0x0000A56300000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (685, 31, CAST(0x0000A56300000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (686, 32, CAST(0x0000A56300000000 AS DateTime), CAST(0x0020760000000000 AS Time), CAST(0x0068E20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (687, 33, CAST(0x0000A56300000000 AS DateTime), CAST(0x00B06D0000000000 AS Time), CAST(0x0078E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (688, 34, CAST(0x0000A56300000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x0078E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (689, 35, CAST(0x0000A56300000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (690, 36, CAST(0x0000A56300000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x00B4E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (691, 37, CAST(0x0000A56300000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x0078E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (692, 38, CAST(0x0000A56300000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x001CE30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (693, 40, CAST(0x0000A56300000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (694, 1, CAST(0x0000A56200000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (695, 6, CAST(0x0000A56200000000 AS DateTime), CAST(0x0060720000000000 AS Time), CAST(0x0094E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (696, 7, CAST(0x0000A56200000000 AS DateTime), CAST(0x0020760000000000 AS Time), CAST(0x00D0E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (697, 8, CAST(0x0000A56200000000 AS DateTime), CAST(0x00E8710000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (698, 9, CAST(0x0000A56200000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (699, 10, CAST(0x0000A56200000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x0084E40000000000 AS Time))
GO
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (700, 11, CAST(0x0000A56200000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (701, 12, CAST(0x0000A56200000000 AS DateTime), CAST(0x0020760000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (702, 13, CAST(0x0000A56200000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (703, 15, CAST(0x0000A56200000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x0038E50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (704, 16, CAST(0x0000A56200000000 AS DateTime), CAST(0x00C4770000000000 AS Time), CAST(0x00FCE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (705, 18, CAST(0x0000A56200000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (706, 19, CAST(0x0000A56200000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (707, 20, CAST(0x0000A56200000000 AS DateTime), CAST(0x00C4770000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (708, 21, CAST(0x0000A56200000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (709, 22, CAST(0x0000A56200000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x00FCE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (710, 23, CAST(0x0000A56200000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (711, 24, CAST(0x0000A56200000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (712, 25, CAST(0x0000A56200000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (713, 26, CAST(0x0000A56200000000 AS DateTime), CAST(0x00C4770000000000 AS Time), CAST(0x00FCE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (714, 27, CAST(0x0000A56200000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (715, 28, CAST(0x0000A56200000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (716, 29, CAST(0x0000A56200000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (717, 30, CAST(0x0000A56200000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (718, 31, CAST(0x0000A56200000000 AS DateTime), CAST(0x0050730000000000 AS Time), CAST(0x0038E50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (719, 32, CAST(0x0000A56200000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (720, 33, CAST(0x0000A56200000000 AS DateTime), CAST(0x00906F0000000000 AS Time), CAST(0x00F0E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (721, 34, CAST(0x0000A56200000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x0078E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (722, 35, CAST(0x0000A56200000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (723, 36, CAST(0x0000A56200000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x00B4E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (724, 37, CAST(0x0000A56200000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x0078E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (725, 38, CAST(0x0000A56200000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (726, 40, CAST(0x0000A56200000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (727, 1, CAST(0x0000A56100000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (728, 6, CAST(0x0000A56100000000 AS DateTime), CAST(0x0050730000000000 AS Time), CAST(0x00A4E20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (729, 7, CAST(0x0000A56100000000 AS DateTime), CAST(0x0070710000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (730, 8, CAST(0x0000A56100000000 AS DateTime), CAST(0x0034710000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (731, 9, CAST(0x0000A56100000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (732, 10, CAST(0x0000A56100000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x00E0E20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (733, 11, CAST(0x0000A56100000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x00FCE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (734, 12, CAST(0x0000A56100000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (735, 13, CAST(0x0000A56100000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (736, 15, CAST(0x0000A56100000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (737, 16, CAST(0x0000A56100000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x002CE20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (738, 18, CAST(0x0000A56100000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (739, 19, CAST(0x0000A56100000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (740, 20, CAST(0x0000A56100000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (741, 21, CAST(0x0000A56100000000 AS DateTime), CAST(0x00F8700000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (742, 22, CAST(0x0000A56100000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (743, 23, CAST(0x0000A56100000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x00FCE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (744, 24, CAST(0x0000A56100000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00E0E20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (745, 25, CAST(0x0000A56100000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x00FCE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (746, 26, CAST(0x0000A56100000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x0038E50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (747, 27, CAST(0x0000A56100000000 AS DateTime), CAST(0x0020760000000000 AS Time), CAST(0x00D0E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (748, 28, CAST(0x0000A56100000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (749, 29, CAST(0x0000A56100000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (750, 30, CAST(0x0000A56100000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (751, 31, CAST(0x0000A56100000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (752, 32, CAST(0x0000A56100000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x00A4E20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (753, 33, CAST(0x0000A56100000000 AS DateTime), CAST(0x00A06E0000000000 AS Time), CAST(0x00F0E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (754, 34, CAST(0x0000A56100000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x003CE10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (755, 35, CAST(0x0000A56100000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (756, 36, CAST(0x0000A56100000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x00F0E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (757, 37, CAST(0x0000A56100000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (758, 38, CAST(0x0000A56100000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x00E0E20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (759, 40, CAST(0x0000A56100000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (760, 1, CAST(0x0000A56000000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (761, 6, CAST(0x0000A56000000000 AS DateTime), CAST(0x009C720000000000 AS Time), CAST(0x0068E20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (762, 7, CAST(0x0000A56000000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (763, 8, CAST(0x0000A56000000000 AS DateTime), CAST(0x009C720000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (764, 9, CAST(0x0000A56000000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (765, 10, CAST(0x0000A56000000000 AS DateTime), CAST(0x0084E40000000000 AS Time), CAST(0x0050270100000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (766, 11, CAST(0x0000A56000000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x00FCE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (767, 12, CAST(0x0000A56000000000 AS DateTime), CAST(0x005C760000000000 AS Time), CAST(0x0088E00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (768, 13, CAST(0x0000A56000000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (769, 15, CAST(0x0000A56000000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x00FCE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (770, 16, CAST(0x0000A56000000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (771, 18, CAST(0x0000A56000000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (772, 19, CAST(0x0000A56000000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (773, 20, CAST(0x0000A56000000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (774, 21, CAST(0x0000A56000000000 AS DateTime), CAST(0x0094E30000000000 AS Time), CAST(0x0078FF0000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (775, 22, CAST(0x0000A56000000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x00D0E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (776, 23, CAST(0x0000A56000000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00FCE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (777, 24, CAST(0x0000A56000000000 AS DateTime), CAST(0x0050730000000000 AS Time), CAST(0x0074E50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (778, 25, CAST(0x0000A56000000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00FCE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (779, 26, CAST(0x0000A56000000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (780, 27, CAST(0x0000A56000000000 AS DateTime), CAST(0x0098760000000000 AS Time), CAST(0x00FCE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (781, 28, CAST(0x0000A56000000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x00FCE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (782, 29, CAST(0x0000A56000000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x00FCE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (783, 30, CAST(0x0000A56000000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (784, 31, CAST(0x0000A56000000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (785, 32, CAST(0x0000A56000000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x0078E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (786, 33, CAST(0x0000A56000000000 AS DateTime), CAST(0x00DC6E0000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (787, 34, CAST(0x0000A56000000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x0078E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (788, 35, CAST(0x0000A56000000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (789, 36, CAST(0x0000A56000000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x00B4E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (790, 37, CAST(0x0000A56000000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x0078E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (791, 38, CAST(0x0000A56000000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00E0E20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (792, 40, CAST(0x0000A56000000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (793, 1, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (794, 6, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (795, 7, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (796, 8, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (797, 9, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (798, 10, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (799, 11, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
GO
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (800, 12, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (801, 13, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (802, 15, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (803, 16, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (804, 18, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (805, 19, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (806, 20, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (807, 21, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (808, 22, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (809, 23, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (810, 24, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (811, 25, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (812, 26, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (813, 27, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (814, 28, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (815, 29, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (816, 30, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (817, 31, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (818, 32, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (819, 33, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (820, 34, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (821, 35, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (822, 36, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (823, 37, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (824, 38, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (825, 40, CAST(0x0000A55F00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (826, 1, CAST(0x0000A55E00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (827, 6, CAST(0x0000A55E00000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x0078E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (828, 7, CAST(0x0000A55E00000000 AS DateTime), CAST(0x0050730000000000 AS Time), CAST(0x0068E20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (829, 8, CAST(0x0000A55E00000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (830, 9, CAST(0x0000A55E00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (831, 10, CAST(0x0000A55E00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x00A4E20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (832, 11, CAST(0x0000A55E00000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (833, 12, CAST(0x0000A55E00000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x00D0E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (834, 13, CAST(0x0000A55E00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (835, 15, CAST(0x0000A55E00000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (836, 16, CAST(0x0000A55E00000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x001CE30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (837, 18, CAST(0x0000A55E00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (838, 19, CAST(0x0000A55E00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (839, 20, CAST(0x0000A55E00000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (840, 21, CAST(0x0000A55E00000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (841, 22, CAST(0x0000A55E00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (842, 23, CAST(0x0000A55E00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (843, 24, CAST(0x0000A55E00000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x00A4E20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (844, 25, CAST(0x0000A55E00000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (845, 26, CAST(0x0000A55E00000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (846, 27, CAST(0x0000A55E00000000 AS DateTime), CAST(0x005C760000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (847, 28, CAST(0x0000A55E00000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (848, 29, CAST(0x0000A55E00000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (849, 30, CAST(0x0000A55E00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (850, 31, CAST(0x0000A55E00000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (851, 32, CAST(0x0000A55E00000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x0010E00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (852, 33, CAST(0x0000A55E00000000 AS DateTime), CAST(0x00186F0000000000 AS Time), CAST(0x0010E00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (853, 34, CAST(0x0000A55E00000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x0078E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (854, 35, CAST(0x0000A55E00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (855, 36, CAST(0x0000A55E00000000 AS DateTime), CAST(0x0088770000000000 AS Time), CAST(0x0088E00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (856, 37, CAST(0x0000A55E00000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (857, 38, CAST(0x0000A55E00000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (858, 40, CAST(0x0000A55E00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (859, 1, CAST(0x0000A55D00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (860, 6, CAST(0x0000A55D00000000 AS DateTime), CAST(0x0060720000000000 AS Time), CAST(0x00D0E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (861, 7, CAST(0x0000A55D00000000 AS DateTime), CAST(0x0020760000000000 AS Time), CAST(0x0074E50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (862, 8, CAST(0x0000A55D00000000 AS DateTime), CAST(0x0080700000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (863, 9, CAST(0x0000A55D00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (864, 10, CAST(0x0000A55D00000000 AS DateTime), CAST(0x004C770000000000 AS Time), CAST(0x003CE10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (865, 11, CAST(0x0000A55D00000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (866, 12, CAST(0x0000A55D00000000 AS DateTime), CAST(0x00D4760000000000 AS Time), CAST(0x00D0E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (867, 13, CAST(0x0000A55D00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (868, 15, CAST(0x0000A55D00000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x00B0E50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (869, 16, CAST(0x0000A55D00000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (870, 18, CAST(0x0000A55D00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (871, 19, CAST(0x0000A55D00000000 AS DateTime), CAST(0x00587A0000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (872, 20, CAST(0x0000A55D00000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (873, 21, CAST(0x0000A55D00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (874, 22, CAST(0x0000A55D00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (875, 23, CAST(0x0000A55D00000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (876, 24, CAST(0x0000A55D00000000 AS DateTime), CAST(0x0050730000000000 AS Time), CAST(0x00ECE50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (877, 25, CAST(0x0000A55D00000000 AS DateTime), CAST(0x0020760000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (878, 26, CAST(0x0000A55D00000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x00FCE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (879, 27, CAST(0x0000A55D00000000 AS DateTime), CAST(0x00D4760000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (880, 28, CAST(0x0000A55D00000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (881, 29, CAST(0x0000A55D00000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (882, 30, CAST(0x0000A55D00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (883, 31, CAST(0x0000A55D00000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x0074E50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (884, 32, CAST(0x0000A55D00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0094E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (885, 33, CAST(0x0000A55D00000000 AS DateTime), CAST(0x00DC6E0000000000 AS Time), CAST(0x0088E00000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (886, 34, CAST(0x0000A55D00000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x003CE10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (887, 35, CAST(0x0000A55D00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (888, 36, CAST(0x0000A55D00000000 AS DateTime), CAST(0x0098760000000000 AS Time), CAST(0x00E0E20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (889, 37, CAST(0x0000A55D00000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x003CE10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (890, 38, CAST(0x0000A55D00000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (891, 40, CAST(0x0000A55D00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (892, 1, CAST(0x0000A55C00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (893, 6, CAST(0x0000A55C00000000 AS DateTime), CAST(0x0050730000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (894, 7, CAST(0x0000A55C00000000 AS DateTime), CAST(0x009C720000000000 AS Time), CAST(0x003CE10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (895, 8, CAST(0x0000A55C00000000 AS DateTime), CAST(0x00F8700000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (896, 9, CAST(0x0000A55C00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (897, 10, CAST(0x0000A55C00000000 AS DateTime), CAST(0x0048E40000000000 AS Time), CAST(0x0050270100000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (898, 11, CAST(0x0000A55C00000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (899, 12, CAST(0x0000A55C00000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x0058E30000000000 AS Time))
GO
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (900, 13, CAST(0x0000A55C00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (901, 15, CAST(0x0000A55C00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (902, 16, CAST(0x0000A55C00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (903, 18, CAST(0x0000A55C00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (904, 19, CAST(0x0000A55C00000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (905, 20, CAST(0x0000A55C00000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (906, 21, CAST(0x0000A55C00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (907, 22, CAST(0x0000A55C00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (908, 23, CAST(0x0000A55C00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (909, 24, CAST(0x0000A55C00000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (910, 25, CAST(0x0000A55C00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (911, 26, CAST(0x0000A55C00000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x0038E50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (912, 27, CAST(0x0000A55C00000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x0050270100000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (913, 28, CAST(0x0000A55C00000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (914, 29, CAST(0x0000A55C00000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (915, 30, CAST(0x0000A55C00000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x0038E50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (916, 31, CAST(0x0000A55C00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (917, 32, CAST(0x0000A55C00000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (918, 33, CAST(0x0000A55C00000000 AS DateTime), CAST(0x00DC6E0000000000 AS Time), CAST(0x003CE10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (919, 34, CAST(0x0000A55C00000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x00A4E20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (920, 35, CAST(0x0000A55C00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (921, 36, CAST(0x0000A55C00000000 AS DateTime), CAST(0x0020760000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (922, 37, CAST(0x0000A55C00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (923, 38, CAST(0x0000A55C00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (924, 40, CAST(0x0000A55C00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (925, 1, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (926, 6, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (927, 7, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (928, 8, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (929, 9, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (930, 10, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (931, 11, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (932, 12, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (933, 13, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (934, 15, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (935, 16, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (936, 18, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (937, 19, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (938, 20, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (939, 21, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (940, 22, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (941, 23, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (942, 24, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (943, 25, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (944, 26, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (945, 27, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (946, 28, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (947, 29, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (948, 30, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (949, 31, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (950, 32, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (951, 33, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (952, 34, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (953, 35, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (954, 36, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (955, 37, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (956, 38, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (957, 40, CAST(0x0000A55B00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (958, 1, CAST(0x0000A55A00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (959, 6, CAST(0x0000A55A00000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x00F0E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (960, 7, CAST(0x0000A55A00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (961, 8, CAST(0x0000A55A00000000 AS DateTime), CAST(0x00AC710000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (962, 9, CAST(0x0000A55A00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (963, 10, CAST(0x0000A55A00000000 AS DateTime), CAST(0x000CE40000000000 AS Time), CAST(0x0050270100000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (964, 11, CAST(0x0000A55A00000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (965, 12, CAST(0x0000A55A00000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (966, 13, CAST(0x0000A55A00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (967, 15, CAST(0x0000A55A00000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0028E60000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (968, 16, CAST(0x0000A55A00000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (969, 18, CAST(0x0000A55A00000000 AS DateTime), CAST(0x0078780000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (970, 19, CAST(0x0000A55A00000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (971, 20, CAST(0x0000A55A00000000 AS DateTime), CAST(0x00C8730000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (972, 21, CAST(0x0000A55A00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (973, 22, CAST(0x0000A55A00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (974, 23, CAST(0x0000A55A00000000 AS DateTime), CAST(0x0020760000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (975, 24, CAST(0x0000A55A00000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (976, 25, CAST(0x0000A55A00000000 AS DateTime), CAST(0x0020760000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (977, 26, CAST(0x0000A55A00000000 AS DateTime), CAST(0x00AC710000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (978, 27, CAST(0x0000A55A00000000 AS DateTime), CAST(0x0020760000000000 AS Time), CAST(0x00A0E60000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (979, 28, CAST(0x0000A55A00000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x0058E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (980, 29, CAST(0x0000A55A00000000 AS DateTime), CAST(0x008C730000000000 AS Time), CAST(0x00A8B10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (981, 30, CAST(0x0000A55A00000000 AS DateTime), CAST(0x00F4740000000000 AS Time), CAST(0x00FCE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (982, 31, CAST(0x0000A55A00000000 AS DateTime), CAST(0x0050730000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (983, 32, CAST(0x0000A55A00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (984, 33, CAST(0x0000A55A00000000 AS DateTime), CAST(0x00FC6C0000000000 AS Time), CAST(0x00FCE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (985, 34, CAST(0x0000A55A00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (986, 35, CAST(0x0000A55A00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (987, 36, CAST(0x0000A55A00000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x00F0E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (988, 37, CAST(0x0000A55A00000000 AS DateTime), CAST(0x00E4750000000000 AS Time), CAST(0x00F0E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (989, 38, CAST(0x0000A55A00000000 AS DateTime), CAST(0x0020760000000000 AS Time), CAST(0x002CE20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (990, 40, CAST(0x0000A55A00000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (991, 1, CAST(0x0000A55900000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (992, 6, CAST(0x0000A55900000000 AS DateTime), CAST(0x0024720000000000 AS Time), CAST(0x00E0E20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (993, 7, CAST(0x0000A55900000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0094E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (994, 8, CAST(0x0000A55900000000 AS DateTime), CAST(0x00D8720000000000 AS Time), CAST(0x00ECE50000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (995, 9, CAST(0x0000A55900000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (996, 10, CAST(0x0000A55900000000 AS DateTime), CAST(0x00D0E30000000000 AS Time), CAST(0x0050270100000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (997, 11, CAST(0x0000A55900000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x0094E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (998, 12, CAST(0x0000A55900000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x00D0E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (999, 13, CAST(0x0000A55900000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
GO
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1000, 15, CAST(0x0000A55900000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x00FCE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1001, 16, CAST(0x0000A55900000000 AS DateTime), CAST(0x00C07B0000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1002, 18, CAST(0x0000A55900000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1003, 19, CAST(0x0000A55900000000 AS DateTime), CAST(0x0030750000000000 AS Time), CAST(0x00D0E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1004, 20, CAST(0x0000A55900000000 AS DateTime), CAST(0x00FC7B0000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1005, 21, CAST(0x0000A55900000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1006, 22, CAST(0x0000A55900000000 AS DateTime), CAST(0x006C750000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1007, 23, CAST(0x0000A55900000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1008, 24, CAST(0x0000A55900000000 AS DateTime), CAST(0x007C740000000000 AS Time), CAST(0x00D0E30000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1009, 25, CAST(0x0000A55900000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x00C0E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1010, 26, CAST(0x0000A55900000000 AS DateTime), CAST(0x00FC7B0000000000 AS Time), CAST(0x0028E60000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1011, 27, CAST(0x0000A55900000000 AS DateTime), CAST(0x0028E60000000000 AS Time), CAST(0x0050270100000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1012, 28, CAST(0x0000A55900000000 AS DateTime), CAST(0x00387C0000000000 AS Time), CAST(0x0084E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1013, 29, CAST(0x0000A55900000000 AS DateTime), CAST(0x00387C0000000000 AS Time), CAST(0x0048E40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1014, 30, CAST(0x0000A55900000000 AS DateTime), CAST(0x009C720000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1015, 31, CAST(0x0000A55900000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1016, 32, CAST(0x0000A55900000000 AS DateTime), CAST(0x00A8750000000000 AS Time), CAST(0x002CE20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1017, 33, CAST(0x0000A55900000000 AS DateTime), CAST(0x0050730000000000 AS Time), CAST(0x000CE40000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1018, 34, CAST(0x0000A55900000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x0000E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1019, 35, CAST(0x0000A55900000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1020, 36, CAST(0x0000A55900000000 AS DateTime), CAST(0x00B8740000000000 AS Time), CAST(0x0000E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1021, 37, CAST(0x0000A55900000000 AS DateTime), CAST(0x0040740000000000 AS Time), CAST(0x0000E10000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1022, 38, CAST(0x0000A55900000000 AS DateTime), CAST(0x0004740000000000 AS Time), CAST(0x00E0E20000000000 AS Time))
INSERT [dbo].[tblAttendance] ([Sno], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1023, 40, CAST(0x0000A55900000000 AS DateTime), CAST(0x0000000000000000 AS Time), CAST(0x0000000000000000 AS Time))
SET IDENTITY_INSERT [dbo].[tblAttendance] OFF
SET IDENTITY_INSERT [dbo].[tblDepartment] ON 

INSERT [dbo].[tblDepartment] ([Id], [Name], [CreatedOn], [UpdatedOn]) VALUES (1, N'ECE', CAST(0x0000A58400CF2060 AS DateTime), CAST(0x0000A58E012DF830 AS DateTime))
INSERT [dbo].[tblDepartment] ([Id], [Name], [CreatedOn], [UpdatedOn]) VALUES (2, N'CSE', CAST(0x0000A58400CF27A4 AS DateTime), CAST(0x0000A58400CF4829 AS DateTime))
INSERT [dbo].[tblDepartment] ([Id], [Name], [CreatedOn], [UpdatedOn]) VALUES (1002, N'IT', CAST(0x0000A5860116CE13 AS DateTime), CAST(0x0000A58A017DBED5 AS DateTime))
INSERT [dbo].[tblDepartment] ([Id], [Name], [CreatedOn], [UpdatedOn]) VALUES (1003, N'ME', CAST(0x0000A58A017E2C81 AS DateTime), CAST(0x0000A58A017E4203 AS DateTime))
INSERT [dbo].[tblDepartment] ([Id], [Name], [CreatedOn], [UpdatedOn]) VALUES (1004, N'Civil', CAST(0x0000A58B00AD5B04 AS DateTime), CAST(0x0000A58B00AD5B04 AS DateTime))
SET IDENTITY_INSERT [dbo].[tblDepartment] OFF
SET IDENTITY_INSERT [dbo].[tblDuration] ON 

INSERT [dbo].[tblDuration] ([Id], [Duration], [TypeOfLeave], [IsActive], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (3, CAST(0x07009CA6920C0000 AS Time), 3, 1, CAST(0x0000A57700000000 AS DateTime), NULL, 0)
INSERT [dbo].[tblDuration] ([Id], [Duration], [TypeOfLeave], [IsActive], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (4, CAST(0x0700A01187210000 AS Time), 4, 1, CAST(0x0000A57700000000 AS DateTime), NULL, 0)
SET IDENTITY_INSERT [dbo].[tblDuration] OFF
SET IDENTITY_INSERT [dbo].[tblEmployees] ON 

INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (1, 1, NULL, N'12345', 1, 1, 987654000, NULL, CAST(0x0000A585012E14D7 AS DateTime), 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (2, 2, NULL, N'12345', 3, 1, 987654321, NULL, CAST(0x0000A586010F5A36 AS DateTime), 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (3, 3, NULL, N'12345', 3, 1, 987654321, NULL, CAST(0x0000A586010F9329 AS DateTime), 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (4, 4, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (5, 5, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (6, 6, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (7, 7, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (8, 8, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (9, 9, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (10, 10, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (11, 11, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (12, 12, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (13, 13, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (14, 14, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (15, 15, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (16, 16, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (17, 17, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (18, 18, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (19, 19, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (20, 20, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (21, 21, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (22, 22, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (23, 23, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (24, 24, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (25, 25, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (26, 26, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (27, 27, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (28, 28, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (29, 29, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (30, 30, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (31, 31, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (32, 32, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (33, 33, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (34, 34, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (35, 35, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (36, 36, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (37, 37, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (38, 38, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (39, 39, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (40, 40, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployees] ([Id], [EmployeeId], [ImagePath], [Password], [RoleId], [DepartmentId], [ContactNumber], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (41, 41, NULL, NULL, 2, 1, NULL, NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[tblEmployees] OFF
SET IDENTITY_INSERT [dbo].[tblEmployeesMaster] ON 

INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (1, N'6', N'H.S. SIYAN', N'Male', CAST(0x0000A4D300000000 AS DateTime), CAST(0x0000A4D300000000 AS DateTime), NULL, CAST(0x0000A585012E14D7 AS DateTime), 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (2, N'7', N'SEEMA GARG', N'Female', CAST(0x0000A4D300000000 AS DateTime), CAST(0x0000A48F00000000 AS DateTime), NULL, CAST(0x0000A586010F5A36 AS DateTime), 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (3, N'8', N'AMIT GARG', N'Female', CAST(0x0000A54700000000 AS DateTime), CAST(0x0000A4D300000000 AS DateTime), NULL, CAST(0x0000A586010F9329 AS DateTime), 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (4, N'9', N'DEVESH SINGH', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (5, N'10', N'DR. R.V. PUROHIT', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (6, N'11', N'SUVARNA MAJUMDAR', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (7, N'12', N'NARESH KUMAR', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (8, N'13', N'JITENDER CHHABRA', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (9, N'15', N'RICHA SRIVASTAVA', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (10, N'16', N'RAJNI PARASHAR', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (11, N'18', N'SURENDRA KUMAR SINGH', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (12, N'19', N'RICHA', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (13, N'20', N'UMA SHARMA', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (14, N'21', N'SACHIN KUMAR GUPTA', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (15, N'22', N'APRA GUPTA', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (16, N'23', N'AANCHAL GUPTA', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (17, N'24', N'DUSHYANT SINGH CHAUHAN', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (18, N'25', N'NEETI GUPTA', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (19, N'26', N'ANUP KUMAR', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (20, N'27', N'HIMANSHU NAGPAL', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (21, N'28', N'ANSHITA AGARWAL', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (22, N'29', N'SAKSHI MITTAL', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (23, N'30', N'ABHIJEET UPADHYA', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (24, N'31', N'GOVIND NARAIN SHARMA', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (25, N'32', N'AWADH KUMAR', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (26, N'33', N'RAJEEV KUMAR TYAGI', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (27, N'34', N'RAJKUMAR', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (28, N'35', N'U.S. GAHLAUT', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (29, N'36', N'KISHANVEER SINGH', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (30, N'37', N'SATEESH VISHKARMA', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (31, N'38', N'VARUN KAUSHIK', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (32, N'40', N'HIMANSHU DWIVEDI', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (33, N'31', N'GOVIND NARAIN SHARMA', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (34, N'32', N'AWADH KUMAR', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (35, N'33', N'RAJEEV KUMAR TYAGI', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (36, N'34', N'RAJKUMAR', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (37, N'35', N'U.S. GAHLAUT', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (38, N'36', N'KISHANVEER SINGH', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (39, N'37', N'SATEESH VISHKARMA', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (40, N'38', N'VARUN KAUSHIK', NULL, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[tblEmployeesMaster] ([Id], [FacultyId], [Name], [Gender], [DateOfBirth], [JoiningDate], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (41, N'40', N'HIMANSHU DWIVEDI', NULL, NULL, NULL, NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[tblEmployeesMaster] OFF
SET IDENTITY_INSERT [dbo].[tblHolidays] ON 

INSERT [dbo].[tblHolidays] ([Id], [Date], [Status], [NameOfHoliday]) VALUES (3, CAST(0xF93A0B00 AS Date), 1, N'Demo')
INSERT [dbo].[tblHolidays] ([Id], [Date], [Status], [NameOfHoliday]) VALUES (1003, CAST(0xF53A0B00 AS Date), 1, N'Demo Holiday')
INSERT [dbo].[tblHolidays] ([Id], [Date], [Status], [NameOfHoliday]) VALUES (1004, CAST(0xF63A0B00 AS Date), 2, N'Weekly Off')
INSERT [dbo].[tblHolidays] ([Id], [Date], [Status], [NameOfHoliday]) VALUES (1005, CAST(0xF63A0B00 AS Date), 1, N'Holiday')
SET IDENTITY_INSERT [dbo].[tblHolidays] OFF
SET IDENTITY_INSERT [dbo].[tblLeave] ON 

INSERT [dbo].[tblLeave] ([Id], [EmployeeId], [Date], [LeaveTypeId], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (1, 2, CAST(0x0000A56A00000000 AS DateTime), 1, CAST(0x0000A58A00B7B0F4 AS DateTime), NULL, 0)
INSERT [dbo].[tblLeave] ([Id], [EmployeeId], [Date], [LeaveTypeId], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (2, 1, CAST(0x0000A56100000000 AS DateTime), 1, CAST(0x0000A58B00A8A3F3 AS DateTime), NULL, 0)
INSERT [dbo].[tblLeave] ([Id], [EmployeeId], [Date], [LeaveTypeId], [CreatedAt], [UpdatedAt], [IsDeleted]) VALUES (3, 1, CAST(0x0000A56800000000 AS DateTime), 4, CAST(0x0000A58B00B21958 AS DateTime), NULL, 1)
SET IDENTITY_INSERT [dbo].[tblLeave] OFF
SET IDENTITY_INSERT [dbo].[tblLeaveAssignedByRole] ON 

INSERT [dbo].[tblLeaveAssignedByRole] ([Id], [RoleId], [LeaveTypeId], [NoOfLeaves], [IsPromoted], [UpdatedAt], [CreatedAt], [IsDeleted]) VALUES (1, 1, 1, 5, 1, NULL, NULL, 0)
INSERT [dbo].[tblLeaveAssignedByRole] ([Id], [RoleId], [LeaveTypeId], [NoOfLeaves], [IsPromoted], [UpdatedAt], [CreatedAt], [IsDeleted]) VALUES (2, 1, 4, 5, 1, NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[tblLeaveAssignedByRole] OFF
SET IDENTITY_INSERT [dbo].[tblLeaveAssignedPerSession] ON 

INSERT [dbo].[tblLeaveAssignedPerSession] ([Id], [EmployeeId], [LeaveTypeId], [NoOfLeaves], [SessionStartDate], [SessionEndDate]) VALUES (2, 1, 1, 5, CAST(0x423A0B00 AS Date), CAST(0xAF3B0B00 AS Date))
INSERT [dbo].[tblLeaveAssignedPerSession] ([Id], [EmployeeId], [LeaveTypeId], [NoOfLeaves], [SessionStartDate], [SessionEndDate]) VALUES (4, 1, 3, 5, CAST(0x423A0B00 AS Date), CAST(0xAF3B0B00 AS Date))
INSERT [dbo].[tblLeaveAssignedPerSession] ([Id], [EmployeeId], [LeaveTypeId], [NoOfLeaves], [SessionStartDate], [SessionEndDate]) VALUES (5, 1, 4, 10, CAST(0x423A0B00 AS Date), CAST(0xAF3B0B00 AS Date))
INSERT [dbo].[tblLeaveAssignedPerSession] ([Id], [EmployeeId], [LeaveTypeId], [NoOfLeaves], [SessionStartDate], [SessionEndDate]) VALUES (6, 1, 5, 10, CAST(0xE6390B00 AS Date), CAST(0xAF3B0B00 AS Date))
INSERT [dbo].[tblLeaveAssignedPerSession] ([Id], [EmployeeId], [LeaveTypeId], [NoOfLeaves], [SessionStartDate], [SessionEndDate]) VALUES (7, 1, 7, 2, CAST(0xDB3A0B00 AS Date), CAST(0x483C0B00 AS Date))
SET IDENTITY_INSERT [dbo].[tblLeaveAssignedPerSession] OFF
SET IDENTITY_INSERT [dbo].[tblLeavesOldStock] ON 

INSERT [dbo].[tblLeavesOldStock] ([Id], [EmployeeId], [SLCount], [ELCount], [SessionStartDate], [SesssionEndDate]) VALUES (1, 1, 10, 10, CAST(0x423A0B00 AS Date), CAST(0xAF3B0B00 AS Date))
INSERT [dbo].[tblLeavesOldStock] ([Id], [EmployeeId], [SLCount], [ELCount], [SessionStartDate], [SesssionEndDate]) VALUES (2, 2, 5, 10, CAST(0x423A0B00 AS Date), CAST(0xAF3B0B00 AS Date))
INSERT [dbo].[tblLeavesOldStock] ([Id], [EmployeeId], [SLCount], [ELCount], [SessionStartDate], [SesssionEndDate]) VALUES (3, 3, 10, 5, CAST(0x423A0B00 AS Date), CAST(0xAF3B0B00 AS Date))
SET IDENTITY_INSERT [dbo].[tblLeavesOldStock] OFF
SET IDENTITY_INSERT [dbo].[tblRole] ON 

INSERT [dbo].[tblRole] ([Id], [Name], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (1, N'HOD', CAST(0x0000A48F00000000 AS DateTime), NULL, 0)
INSERT [dbo].[tblRole] ([Id], [Name], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (2, N'Admin', CAST(0x0000A52A00C3A58B AS DateTime), CAST(0x0000A52A00C3A58B AS DateTime), 0)
INSERT [dbo].[tblRole] ([Id], [Name], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (3, N'Faculty', CAST(0x0000A52A00CA7B44 AS DateTime), CAST(0x0000A52A00CA7B44 AS DateTime), 0)
INSERT [dbo].[tblRole] ([Id], [Name], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (4, N'Staff', CAST(0x0000A52A00CD5DAE AS DateTime), CAST(0x0000A58400CF822E AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[tblRole] OFF
SET IDENTITY_INSERT [dbo].[tblSession] ON 

INSERT [dbo].[tblSession] ([Id], [SessionStartDate], [SessionEndDate]) VALUES (1, CAST(0x0000A65500000000 AS DateTime), CAST(0x0000A7C100000000 AS DateTime))
INSERT [dbo].[tblSession] ([Id], [SessionStartDate], [SessionEndDate]) VALUES (2, CAST(0x0000A4E700000000 AS DateTime), CAST(0x0000A65400000000 AS DateTime))
INSERT [dbo].[tblSession] ([Id], [SessionStartDate], [SessionEndDate]) VALUES (3, CAST(0x0000A65500000000 AS DateTime), CAST(0x0000A7C100000000 AS DateTime))
SET IDENTITY_INSERT [dbo].[tblSession] OFF
SET IDENTITY_INSERT [dbo].[tblShifts] ON 

INSERT [dbo].[tblShifts] ([Id], [FirstHalfStart], [FirstHalfEnd], [SecondHalfStart], [SecondHalfEnd], [IsActive], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (2, CAST(0x070074053F470000 AS Time), CAST(0x0700E03495640000 AS Time), CAST(0x078076CD95640000 AS Time), CAST(0x070080461C860000 AS Time), 1, CAST(0x0000A54E00000000 AS DateTime), NULL, 0)
SET IDENTITY_INSERT [dbo].[tblShifts] OFF
SET IDENTITY_INSERT [dbo].[tblTypeOfLeave] ON 

INSERT [dbo].[tblTypeOfLeave] ([Id], [Name], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (1, N'Casual Leave', CAST(0x0000A57A00000000 AS DateTime), NULL, 0)
INSERT [dbo].[tblTypeOfLeave] ([Id], [Name], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (3, N'Earned Leave', CAST(0x0000A57A00000000 AS DateTime), CAST(0x0000A58A0188C82D AS DateTime), 0)
INSERT [dbo].[tblTypeOfLeave] ([Id], [Name], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (4, N'Short Leave', CAST(0x0000A57A00000000 AS DateTime), NULL, 0)
INSERT [dbo].[tblTypeOfLeave] ([Id], [Name], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (5, N'Half Day Leave', CAST(0x0000A57A00000000 AS DateTime), NULL, 0)
INSERT [dbo].[tblTypeOfLeave] ([Id], [Name], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (6, N'Sick Leave', CAST(0x0000A57A00000000 AS DateTime), NULL, 0)
INSERT [dbo].[tblTypeOfLeave] ([Id], [Name], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (7, N'Restricted Holiday', CAST(0x0000A57A00000000 AS DateTime), NULL, 0)
INSERT [dbo].[tblTypeOfLeave] ([Id], [Name], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (8, N'D Leave', CAST(0x0000A57A00000000 AS DateTime), NULL, 0)
INSERT [dbo].[tblTypeOfLeave] ([Id], [Name], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (11, N'Compensatory Off', CAST(0x0000A57A00000000 AS DateTime), NULL, 0)
INSERT [dbo].[tblTypeOfLeave] ([Id], [Name], [CreatedOn], [UpdatedOn], [IsDeleted]) VALUES (12, N'Demo', CAST(0x0000A58B00AD32D4 AS DateTime), CAST(0x0000A58B00AD32D4 AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[tblTypeOfLeave] OFF
/****** Object:  Index [IX_tblEmployees]    Script Date: 17-Jan-16 2:36:11 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblEmployees] ON [dbo].[tblEmployeesMaster]
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblEmployees] ADD  CONSTRAINT [DF_tblEmployees_DepartmentId]  DEFAULT ((1)) FOR [DepartmentId]
GO
ALTER TABLE [dbo].[tblEmployees] ADD  CONSTRAINT [DF_tblEmployees_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[tblEmployeesMaster] ADD  CONSTRAINT [DF_tblEmployeesMaster_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[tblLeaveAssignedByRole] ADD  CONSTRAINT [DF_tblLeaveAssignedByRole_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[tblAttendance]  WITH CHECK ADD  CONSTRAINT [FK_tblAttendance_tblEmployeesMaster] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[tblEmployeesMaster] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblAttendance] CHECK CONSTRAINT [FK_tblAttendance_tblEmployeesMaster]
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
ALTER TABLE [dbo].[tblLeave]  WITH CHECK ADD  CONSTRAINT [FK_tblLeave_tblEmployeesMaster] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[tblEmployeesMaster] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblLeave] CHECK CONSTRAINT [FK_tblLeave_tblEmployeesMaster]
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
ALTER TABLE [dbo].[tblLeaveAssignedPerSession]  WITH CHECK ADD  CONSTRAINT [FK_tblLeaveAssignedPerSession_tblEmployeesMaster] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[tblEmployeesMaster] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblLeaveAssignedPerSession] CHECK CONSTRAINT [FK_tblLeaveAssignedPerSession_tblEmployeesMaster]
GO
ALTER TABLE [dbo].[tblLeaveAssignedPerSession]  WITH CHECK ADD  CONSTRAINT [FK_tblLeaveAssignedPerSession_tblTypeOfLeave] FOREIGN KEY([LeaveTypeId])
REFERENCES [dbo].[tblTypeOfLeave] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblLeaveAssignedPerSession] CHECK CONSTRAINT [FK_tblLeaveAssignedPerSession_tblTypeOfLeave]
GO
ALTER TABLE [dbo].[tblLeavesOldStock]  WITH CHECK ADD  CONSTRAINT [FK_tblLeavesOldStock_tblEmployeesMaster] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[tblEmployeesMaster] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblLeavesOldStock] CHECK CONSTRAINT [FK_tblLeavesOldStock_tblEmployeesMaster]
GO
USE [master]
GO
ALTER DATABASE [BiometricsAttendanceSystem] SET  READ_WRITE 
GO
