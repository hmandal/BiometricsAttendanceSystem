USE [BiometricsAttendanceSystem]
GO
/****** Object:  StoredProcedure [dbo].[spCreateEmployee]    Script Date: 08-Oct-15 6:24:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		SI
-- Create date: 29thSeptember2015
-- Description:	Creates a new Employee and returns Employee ID of created Employee 
-- =============================================
ALTER PROCEDURE [dbo].[spCreateEmployee]
	-- Add the parameters for the stored procedure here
	@facultyId nvarchar(MAX),
	@firstName nvarchar(MAX), 
	@middleName nvarchar(MAX),
	@lastName nvarchar(MAX),
	@gender nvarchar(MAX),
	@dateOfBirth datetime,
	@imagePath nvarchar(MAX),
	@joiningDate datetime,
	@password nvarchar(MAX),
	@roleId int,
	@departmentId int,
	@contactNumber int,
	@isDeleted bit,
	@createdAt datetime,
	@updatedAt datetime
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
			@createdAt,
			@updatedAt,
			@isDeleted
          ) 
	Declare @employeeId AS INT
	SET @employeeId = (SELECT @@IDENTITY AS employeeId)
	INSERT INTO dbo.tblEmployees
          ( 
            EmployeeId,
			ImagePath,
			Password,
			RoleId,
			DepartmentId,
			ContactNumber,
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
			@contactNumber,
			@createdAt,
			@updatedAt,
			@isDeleted
          ) 
END

