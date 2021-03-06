USE [master]
GO
/****** Object:  Database [BiometricAttendance]    Script Date: 08-Sep-15 5:01:53 PM ******/
CREATE DATABASE [BiometricAttendance]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BiometricAttendance', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\BiometricAttendance.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BiometricAttendance_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\BiometricAttendance_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BiometricAttendance] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BiometricAttendance].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BiometricAttendance] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BiometricAttendance] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BiometricAttendance] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BiometricAttendance] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BiometricAttendance] SET ARITHABORT OFF 
GO
ALTER DATABASE [BiometricAttendance] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BiometricAttendance] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [BiometricAttendance] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BiometricAttendance] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BiometricAttendance] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BiometricAttendance] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BiometricAttendance] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BiometricAttendance] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BiometricAttendance] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BiometricAttendance] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BiometricAttendance] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BiometricAttendance] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BiometricAttendance] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BiometricAttendance] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BiometricAttendance] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BiometricAttendance] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BiometricAttendance] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BiometricAttendance] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BiometricAttendance] SET RECOVERY FULL 
GO
ALTER DATABASE [BiometricAttendance] SET  MULTI_USER 
GO
ALTER DATABASE [BiometricAttendance] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BiometricAttendance] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BiometricAttendance] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BiometricAttendance] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [BiometricAttendance]
GO
/****** Object:  StoredProcedure [dbo].[spAddDomainValue]    Script Date: 08-Sep-15 5:01:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		SI
-- Create date: 13th August 2015
-- Description:	Add a new Domain Value
-- =============================================
CREATE PROCEDURE [dbo].[spAddDomainValue] 
	@name nvarchar(MAX), 
	@type int = 0,
	@createdOn datetime,
	@updatedOn datetime
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO dbo.tblDomainValues
          ( 
            Name,
			Type,
			CreatedOn,
			UpdatedOn
          ) 
     VALUES 
          ( 
            @name, 
	        @type,
			@createdOn,
			@updatedOn
          )

END

GO
/****** Object:  StoredProcedure [dbo].[spCreateEmployee]    Script Date: 08-Sep-15 5:01:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		SI
-- Create date: 13thAugust2015
-- Description:	Creates a new Employee and returns Employee ID of created Employee 
-- =============================================
CREATE PROCEDURE [dbo].[spCreateEmployee]
	-- Add the parameters for the stored procedure here
	@firstName nvarchar(MAX), 
	@middleName nvarchar(MAX),
	@lastName nvarchar(MAX),
	@dateOfBirth datetime,
	@imagePath nvarchar(MAX),
	@joiningDate datetime,
	@password nvarchar(MAX),
	@roleId int,
	@departmentId int,
	@createdOn datetime,
	@updatedOn datetime
AS
BEGIN

	SET NOCOUNT ON;

   INSERT INTO dbo.tblEmployees
          ( 
            FirstName,
			MiddleName,
			LastName,
			DateOfBirth,
			ImagePath,
			JoiningDate,
			Password,
			RoleId,
			DepartmentId,
			CreatedOn,
			UpdatedOn
          ) 
     VALUES 
          ( 
            @firstName, 
			@middleName,
			@lastName,
			@dateOfBirth,
			@imagePath,
			@joiningDate,
			@password,
			@roleId,
			@departmentId,
			@createdOn,
			@updatedOn
          ) 
	SELECT @@IDENTITY AS employeeID

END

GO
/****** Object:  StoredProcedure [dbo].[spDeleteEmployee]    Script Date: 08-Sep-15 5:01:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		SI
-- Create date: 16th August 2015
-- Description:	Deletes Employee by Given EmployeeID
-- =============================================
CREATE PROCEDURE [dbo].[spDeleteEmployee]
	@employeeId int
AS
BEGIN

	SET NOCOUNT ON;
	DELETE FROM tblEmployees
	WHERE Id = @employeeId
END

GO
/****** Object:  StoredProcedure [dbo].[spEntryAnEmployee]    Script Date: 08-Sep-15 5:01:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		SI
-- Create date: 23rd August 2015
-- Description:	Makes an entry for Employee
-- =============================================
CREATE PROCEDURE [dbo].[spEntryAnEmployee] 
	-- Add the parameters for the stored procedure here
	@employeeId int , 
	@dateTime datetime  
AS
BEGIN
	SET NOCOUNT ON;
      INSERT into tblAttendance (EmployeeId,Date,EntryTime) Values(@employeeId, cast(@dateTime as date), cast(@dateTime as time))
END

GO
/****** Object:  StoredProcedure [dbo].[spExitAnEmployee]    Script Date: 08-Sep-15 5:01:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		SI
-- Create date: 23rd August 2015
-- Description:	Exit an Employee
-- =============================================
CREATE PROCEDURE [dbo].[spExitAnEmployee] 
	-- Add the parameters for the stored procedure here
	@employeeId int, 
	@date date,
	@time time
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tblAttendance SET ExitTime = @time WHERE Date = @date AND EmployeeId = @employeeId
END

GO
/****** Object:  StoredProcedure [dbo].[spGenerateDailyReport]    Script Date: 08-Sep-15 5:01:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		SI
-- Create date: 15th August 2015
-- Description:	Generate Daily Report on Basis of Date
-- =============================================
CREATE PROCEDURE [dbo].[spGenerateDailyReport] 
	-- Add the parameters for the stored procedure here
	@date datetime 
AS
BEGIN

	SET NOCOUNT ON;

	SELECT 
	       Attendance.SNo,
		   Attendance.EmployeeId,
		   Employee.FirstName,
		   Employee.MiddleName,
		   Employee.LastName,
		   Attendance.Date,
		   Attendance.EntryTime,
		   Attendance.ExitTime
		   From tblEmployees Employee
		   INNER JOIN
		   tblAttendance Attendance 
		   ON Employee.Id = Attendance.EmployeeId
		   WHERE Attendance.Date = @date
		   ORDER BY Employee.FirstName,Employee.MiddleName,Employee.LastName
END

GO
/****** Object:  StoredProcedure [dbo].[spGenerateMonthlyReport]    Script Date: 08-Sep-15 5:01:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		SI
-- Create date: 16th August 2015
-- Description:	Generate Monthly Report
-- =============================================
CREATE PROCEDURE [dbo].[spGenerateMonthlyReport] 
	-- Add the parameters for the stored procedure here
	@month int 
AS

BEGIN

	SET NOCOUNT ON;
    SELECT 
	       Attendance.SNo,
		   Attendance.EmployeeId,
		   Employee.FirstName,
		   Employee.MiddleName,
		   Employee.LastName,
		   Attendance.Date,
		   Attendance.EntryTime,
		   Attendance.ExitTime
		   From tblEmployees Employee
		   INNER JOIN
		   tblAttendance Attendance 
		   ON Employee.Id = Attendance.EmployeeId
		   WHERE MONTH(Date) = @month
		   ORDER BY Attendance.Date,Employee.FirstName,Employee.MiddleName,Employee.LastName
END

GO
/****** Object:  StoredProcedure [dbo].[spGetAllEmployeeByRole]    Script Date: 08-Sep-15 5:01:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		SI
-- Create date: 14th August 2015
-- Description:	Get All Employees By Role
-- =============================================
CREATE PROCEDURE [dbo].[spGetAllEmployeeByRole] 
	-- Add the parameters for the stored procedure here
	@roleId int = 0
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
	        Id,
		    FirstName,
			MiddleName,
			LastName,
			DateOfBirth,
			ImagePath,
			JoiningDate,
			Password,
			RoleId,
			DepartmentId,
			CreatedOn,
			UpdatedOn
	 FROM tblEmployees WHERE Id = @roleId 
END

GO
/****** Object:  StoredProcedure [dbo].[spGetAllEmployees]    Script Date: 08-Sep-15 5:01:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		SI
-- Create date: 14th August 2015
-- Description:	Get All Employees
-- =============================================
CREATE PROCEDURE [dbo].[spGetAllEmployees] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	SET NOCOUNT ON;

        SELECT 
	        Id,
		    FirstName,
			MiddleName,
			LastName,
			DateOfBirth,
			ImagePath,
			JoiningDate,
			Password,
			RoleId,
			DepartmentId,
			CreatedOn,
		    UpdatedOn
	   FROM 
	       tblEmployees 
END

GO
/****** Object:  StoredProcedure [dbo].[spGetAttendanceStatus]    Script Date: 08-Sep-15 5:01:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		SI
-- Create date: 23rd August 2015
-- Description:	Manages Attendance. Make a Entry if no entry exists and Exit the employee it any exists.
-- =============================================
CREATE PROCEDURE [dbo].[spGetAttendanceStatus] 
	-- Add the parameters for the stored procedure here
	@employeeId int = 0, 
	@dateTime datetime = 0
AS
BEGIN
	SET NOCOUNT ON;
    SELECT COUNT(Sno) FROM tblAttendance WHERE EmployeeId = @employeeId AND Date = @dateTime;
END

GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeeByEmployeeId]    Script Date: 08-Sep-15 5:01:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		SI
-- Create date: 15th August
-- Description:	Get Employee Description by Id
-- =============================================
CREATE PROCEDURE [dbo].[spGetEmployeeByEmployeeId] 
	-- Add the parameters for the stored procedure here
	@ID bigint = 0
AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
	        Id,
		    FirstName,
			MiddleName,
			LastName,
			DateOfBirth,
			ImagePath,
			JoiningDate,
			Password,
			RoleId,
			DepartmentId,
			CreatedOn,
			UpdatedOn
	 FROM tblEmployees WHERE Id = @ID 
END

GO
/****** Object:  StoredProcedure [dbo].[spGetEntryStatus]    Script Date: 08-Sep-15 5:01:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		SI
-- Create date: 16th August 2015
-- Description:	Checks entry status of Employee
-- =============================================
CREATE PROCEDURE [dbo].[spGetEntryStatus] 
	-- Add the parameters for the stored procedure here
	@employeeId int, 
	@date datetime 
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @true BIT, @false BIT;
		
	SET @true = 1;
	SET @false = 0;

	IF ((SELECT COUNT(SNo) FROM tblAttendance WHERE Date = @date AND EmployeeId = @employeeId)>0)
		Select @true;
	ELSE
		Select @false;
END

GO
/****** Object:  StoredProcedure [dbo].[spGetExitStatus]    Script Date: 08-Sep-15 5:01:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		SI
-- Create date: 23rd August 2015
-- Description:	Checks exit status
-- =============================================
CREATE PROCEDURE [dbo].[spGetExitStatus] 
	@employeeId int, 
	@dateTime datetime 
AS
BEGIN
	SET NOCOUNT ON;
	SELECT ExitTime FROM tblAttendance WHERE EmployeeId= @employeeId AND Date = @dateTime
END

GO
/****** Object:  StoredProcedure [dbo].[spUpdateEmployeeById]    Script Date: 08-Sep-15 5:01:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		SI
-- Create date: 16thAugust
-- Description:	Updtaes an existing Emlpoyee
-- =============================================
CREATE PROCEDURE [dbo].[spUpdateEmployeeById] 
	-- Add the parameters for the stored procedure here
	
	@employeeId int,
	@firstName nvarchar(MAX), 
	@middleName nvarchar(MAX),
	@lastName nvarchar(MAX),
	@dateOfBirth datetime,
	@imagePath nvarchar(MAX),
	@joiningDate datetime,
	@password nvarchar(MAX),
	@roleId int,
	@departmentId int,
	@updatedOn datetime
AS
BEGIN
	UPDATE dbo.tblEmployees
          SET  
            FirstName = @firstName,
			MiddleName = @middleName,
			LastName = @lastName,
			DateOfBirth = @dateOfBirth,
			ImagePath = @imagePath,
			JoiningDate = @joiningDate,
			Password =@password,
			RoleId = @roleId,
			DepartmentId = @departmentId,
			UpdatedOn =@updatedOn
		 WHERE 
		    ID = @employeeId
END

GO
/****** Object:  Table [dbo].[tblAttendance]    Script Date: 08-Sep-15 5:01:54 PM ******/
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
/****** Object:  Table [dbo].[tblDomainValues]    Script Date: 08-Sep-15 5:01:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDomainValues](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Type] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tblDomainValues] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblEmployees]    Script Date: 08-Sep-15 5:01:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblEmployees](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](max) NOT NULL,
	[MiddleName] [nvarchar](max) NULL,
	[LastName] [nvarchar](max) NULL,
	[DateOfBirth] [datetime] NOT NULL,
	[ImagePath] [nvarchar](max) NULL,
	[JoiningDate] [datetime] NOT NULL,
	[Password] [nvarchar](max) NULL,
	[RoleId] [int] NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tblEmployees] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblLeave]    Script Date: 08-Sep-15 5:01:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLeave](
	[SNo] [bigint] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [bigint] NOT NULL,
	[Date] [datetime] NOT NULL,
	[LeaveId] [int] NOT NULL,
	[IsApproved] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_tblLeave] PRIMARY KEY CLUSTERED 
(
	[SNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tblLeaveAssigned]    Script Date: 08-Sep-15 5:01:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLeaveAssigned](
	[SNo] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [bigint] NOT NULL,
	[LeaveId] [int] NOT NULL,
	[LeaveEntitled] [int] NOT NULL,
 CONSTRAINT [PK_tblLeaveAssigned] PRIMARY KEY CLUSTERED 
(
	[SNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[tblAttendance] ON 

INSERT [dbo].[tblAttendance] ([SNo], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (1, 1, CAST(0x593A0B00 AS Date), CAST(0x076008B8578C0000 AS Time), CAST(0x0700000000000000 AS Time))
INSERT [dbo].[tblAttendance] ([SNo], [EmployeeId], [Date], [EntryTime], [ExitTime]) VALUES (2, 2, CAST(0x593A0B00 AS Date), CAST(0x0710387BC78D0000 AS Time), CAST(0x07D711C5D68D0000 AS Time))
SET IDENTITY_INSERT [dbo].[tblAttendance] OFF
SET IDENTITY_INSERT [dbo].[tblDomainValues] ON 

INSERT [dbo].[tblDomainValues] ([Id], [Name], [Type], [CreatedOn], [UpdatedOn]) VALUES (1, N'Admin', 1, CAST(0x0000A4F400000000 AS DateTime), NULL)
INSERT [dbo].[tblDomainValues] ([Id], [Name], [Type], [CreatedOn], [UpdatedOn]) VALUES (2, N'HOD', 1, CAST(0x0000A4D600000000 AS DateTime), NULL)
INSERT [dbo].[tblDomainValues] ([Id], [Name], [Type], [CreatedOn], [UpdatedOn]) VALUES (3, N'Faculty', 1, CAST(0x0000A4F400000000 AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[tblDomainValues] OFF
SET IDENTITY_INSERT [dbo].[tblEmployees] ON 

INSERT [dbo].[tblEmployees] ([Id], [FirstName], [MiddleName], [LastName], [DateOfBirth], [ImagePath], [JoiningDate], [Password], [RoleId], [DepartmentId], [CreatedOn], [UpdatedOn]) VALUES (1, N'Admin', NULL, NULL, CAST(0x00009F9700000000 AS DateTime), N'zxc', CAST(0x0000A82700000000 AS DateTime), N'password', 1, 2, CAST(0x0000A82300000000 AS DateTime), NULL)
INSERT [dbo].[tblEmployees] ([Id], [FirstName], [MiddleName], [LastName], [DateOfBirth], [ImagePath], [JoiningDate], [Password], [RoleId], [DepartmentId], [CreatedOn], [UpdatedOn]) VALUES (2, N'Aditi', NULL, NULL, CAST(0x00009F9700000000 AS DateTime), N'zxc', CAST(0x0000A82700000000 AS DateTime), N'password', 1, 2, CAST(0x0000A82300000000 AS DateTime), NULL)
INSERT [dbo].[tblEmployees] ([Id], [FirstName], [MiddleName], [LastName], [DateOfBirth], [ImagePath], [JoiningDate], [Password], [RoleId], [DepartmentId], [CreatedOn], [UpdatedOn]) VALUES (3, N'Anup', N'Kumar', N'Gupta', CAST(0x000085E400000000 AS DateTime), N'gyfy', CAST(0x0000A52F00000000 AS DateTime), N'fghfgh', 3, 1, CAST(0x0000A4FB01224E94 AS DateTime), CAST(0x0000A4FB01224E94 AS DateTime))
SET IDENTITY_INSERT [dbo].[tblEmployees] OFF
ALTER TABLE [dbo].[tblAttendance]  WITH CHECK ADD  CONSTRAINT [FK_tblAttendance_tblEmployees] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[tblEmployees] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblAttendance] CHECK CONSTRAINT [FK_tblAttendance_tblEmployees]
GO
ALTER TABLE [dbo].[tblEmployees]  WITH CHECK ADD  CONSTRAINT [FK_tblEmployees_tblDomainValues_DeptId] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[tblDomainValues] ([Id])
GO
ALTER TABLE [dbo].[tblEmployees] CHECK CONSTRAINT [FK_tblEmployees_tblDomainValues_DeptId]
GO
ALTER TABLE [dbo].[tblEmployees]  WITH CHECK ADD  CONSTRAINT [FK_tblEmployees_tblDomainValues_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[tblDomainValues] ([Id])
GO
ALTER TABLE [dbo].[tblEmployees] CHECK CONSTRAINT [FK_tblEmployees_tblDomainValues_RoleId]
GO
ALTER TABLE [dbo].[tblLeave]  WITH CHECK ADD  CONSTRAINT [FK_tblLeave_tblDomainValues] FOREIGN KEY([LeaveId])
REFERENCES [dbo].[tblDomainValues] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblLeave] CHECK CONSTRAINT [FK_tblLeave_tblDomainValues]
GO
ALTER TABLE [dbo].[tblLeave]  WITH CHECK ADD  CONSTRAINT [FK_tblLeave_tblEmployees] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[tblEmployees] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblLeave] CHECK CONSTRAINT [FK_tblLeave_tblEmployees]
GO
ALTER TABLE [dbo].[tblLeaveAssigned]  WITH CHECK ADD  CONSTRAINT [FK_tblLeaveAssigned_tblDomainValues_LeaveId] FOREIGN KEY([LeaveId])
REFERENCES [dbo].[tblDomainValues] ([Id])
GO
ALTER TABLE [dbo].[tblLeaveAssigned] CHECK CONSTRAINT [FK_tblLeaveAssigned_tblDomainValues_LeaveId]
GO
ALTER TABLE [dbo].[tblLeaveAssigned]  WITH CHECK ADD  CONSTRAINT [FK_tblLeaveAssigned_tblEmployees] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[tblEmployees] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblLeaveAssigned] CHECK CONSTRAINT [FK_tblLeaveAssigned_tblEmployees]
GO
USE [master]
GO
ALTER DATABASE [BiometricAttendance] SET  READ_WRITE 
GO
