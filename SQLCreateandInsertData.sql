USE [DBTestMerge]
GO

---***** Create a simple table to store some data in bulk

IF  EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[Student]') AND type in (N'U'))
DROP TABLE [dbo].[Student]
GO

CREATE TABLE [dbo].[Student](
	[id] [bigint] NOT NULL,
	[code] [varchar](500) NULL,
	[name] [varchar](500) NULL,
	[address] [varchar](500) NULL
) ON [PRIMARY]
GO




 truncate table [dbo].[Student]
---************ Insert bulk data using a while loop **********
BEGIN TRY

BEGIN TRANSACTION TR
DECLARE @flag as INT
SET @flag=1;

WHILE(@flag<=500)
BEGIN
Insert into [dbo].[Student](
	[id] ,
	[code] ,
	[name] ,
	[address] 
) Values
(@flag,
NEWID(),
'Saurov Halder ' + CONVERT(varchar(100),@flag),
'My adress is Kolkata -- ' +CONVERT(varchar(100),@flag));

SET @flag=@flag+1;

END

COMMIT TRAN TR
--SELECT COUNT(1) from dbo.Student
--SELECT * from dbo.Student
END TRY

BEGIN CATCH
ROLLBACK TRAN TR
PRint error_message()
END CATCH