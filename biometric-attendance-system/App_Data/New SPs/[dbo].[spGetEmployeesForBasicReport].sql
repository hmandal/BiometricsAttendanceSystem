USE [BiometricsAttendanceSystem]
GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeesPresentDateWise]    Script Date: 19/12/2015 04:26:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Software Incubator
-- Create date: 19th December 2015
-- Description:	Get All Employees For Basic Report 
-- =============================================
Create PROCEDURE [dbo].[spGetEmployeesForBasicReport] 
	-- Add the parameters for the stored procedure here
	@date datetime
AS
BEGIN
	SELECT        tblEmployeesMaster.FirstName + ' ' + tblEmployeesMaster.MiddleName + ' ' + tblEmployeesMaster.LastName AS Name, tblAttendance.EmployeeId, tblAttendance.EntryTime, tblAttendance.ExitTime, 
                         tblAttendance.Date
FROM            tblAttendance INNER JOIN
                         tblEmployeesMaster ON tblAttendance.EmployeeId = tblEmployeesMaster.Id
						 where tblAttendance.Date = @date
      
END


