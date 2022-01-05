
/****** Object:  StoredProcedure [dbo].[POSdata_CashInOutServer_SelectAll]    Script Date: 6/22/2021 10:13:54 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_CashInOutServer_SelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_CashInOutServer_SelectAll]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_CashInOutInsertServer_Insert]    Script Date: 6/22/2021 10:13:54 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_CashInOutInsertServer_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_CashInOutInsertServer_Insert]
GO
/****** Object:  Table [dbo].[data_CashOutServer]    Script Date: 6/22/2021 10:13:54 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_CashOutServer]') AND type in (N'U'))
DROP TABLE [dbo].[data_CashOutServer]
GO
/****** Object:  Table [dbo].[data_CashInServer]    Script Date: 6/22/2021 10:13:54 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_CashInServer]') AND type in (N'U'))
DROP TABLE [dbo].[data_CashInServer]
GO
/****** Object:  UserDefinedTableType [dbo].[data_CashOutServer]    Script Date: 6/22/2021 10:13:54 AM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_CashOutServer' AND ss.name = N'dbo')
DROP TYPE [dbo].[data_CashOutServer]
GO
/****** Object:  UserDefinedTableType [dbo].[data_CashInServer]    Script Date: 6/22/2021 10:13:54 AM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_CashInServer' AND ss.name = N'dbo')
DROP TYPE [dbo].[data_CashInServer]
GO
/****** Object:  UserDefinedTableType [dbo].[data_CashInServer]    Script Date: 6/22/2021 10:13:54 AM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_CashInServer' AND ss.name = N'dbo')
CREATE TYPE [dbo].[data_CashInServer] AS TABLE(
	[CashIn] [bigint] NULL,
	[SourceID] [bigint] NULL,
	[SourceName] [nvarchar](50) NULL,
	[Amount] [decimal](18, 2) NULL,
	[Date] [date] NULL,
	[TimeStamp] [datetime2](7) NULL,
	[Remarks] [nvarchar](max) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[data_CashOutServer]    Script Date: 6/22/2021 10:13:54 AM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_CashOutServer' AND ss.name = N'dbo')
CREATE TYPE [dbo].[data_CashOutServer] AS TABLE(
	[CashOut] [bigint] NULL,
	[SourceID] [bigint] NULL,
	[SourceName] [nvarchar](50) NULL,
	[Amount] [decimal](18, 2) NULL,
	[Date] [date] NULL,
	[TimeStamp] [datetime2](7) NULL,
	[Remarks] [nvarchar](max) NULL
)
GO
/****** Object:  Table [dbo].[data_CashInServer]    Script Date: 6/22/2021 10:13:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_CashInServer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[data_CashInServer](
	[CashIn] [bigint]  NULL,
	[SourceID] [bigint] NULL,
	[SourceName] [nvarchar](50) NULL,
	[Amount] [decimal](18, 2) NULL,
	[Date] [date] NULL,
	[TimeStamp] [datetime2](7) NULL,
	[Remarks] [nvarchar](max) NULL,
	[WHID] [int] NULL,
	)
END
GO
/****** Object:  Table [dbo].[data_CashOutServer]    Script Date: 6/22/2021 10:13:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_CashOutServer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[data_CashOutServer](
	[CashOut] [bigint]  NULL,
	[SourceID] [bigint] NULL,
	[SourceName] [nvarchar](50) NULL,
	[Amount] [decimal](18, 2) NULL,
	[Date] [date] NULL,
	[TimeStamp] [datetime2](7) NULL,
	[Remarks] [nvarchar](max) NULL,
	[WHID] [int] NULL,
 )
 END
GO
/****** Object:  StoredProcedure [dbo].[POSdata_CashInOutInsertServer_Insert]    Script Date: 6/22/2021 10:13:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_CashInOutInsertServer_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_CashInOutInsertServer_Insert] AS' 
END
GO







ALTER procedure [dbo].[POSdata_CashInOutInsertServer_Insert] 
@IsInserted int output ,
@data_CashInServer data_CashInServer readonly,
@data_cashoutServer  data_cashoutServer readonly,
@WHID int=0,
@FromDate date,
@ToDate date 
as

Delete from data_CashInServer where WHID=@WHID and [Date] between @FromDate and @ToDate 
Delete from data_CashOutServer where WHID=@WHID and [Date] between @FromDate and @ToDate 

insert into data_CashInServer(CashIn, SourceID, SourceName, Amount, Date, TimeStamp, Remarks, WHID)
Select  
CashIn, SourceID, SourceName, Amount, Date, TimeStamp, Remarks, @WHID
FROM            @data_CashInServer

insert into data_cashoutServer(CashOut, SourceID, SourceName, Amount, Date, TimeStamp, Remarks, WHID)
Select CashOut, SourceID, SourceName, Amount, Date, TimeStamp, Remarks, @WHID
FROM            @data_CashOutServer

set @IsInserted=1



GO
/****** Object:  StoredProcedure [dbo].[POSdata_CashInOutServer_SelectAll]    Script Date: 6/22/2021 10:13:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_CashInOutServer_SelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_CashInOutServer_SelectAll] AS' 
END
GO








ALTER procedure [dbo].[POSdata_CashInOutServer_SelectAll] 
@WhereClause nvarchar(Max),
@BoolMaster bit=0,
@DetailMaster bit=0,
@WhereClauseDetail nvarchar(Max)
as
if(@BoolMaster=1)
begin
exec('SELECT        CashIn, SourceID, SourceName, Amount, Date, TimeStamp, Remarks
FROM            data_CashIn'+ @WhereClause)
end
if (@DetailMaster=1)
begin
exec('
SELECT        CashOut, SourceID, SourceName, Amount, Date, TimeStamp, Remarks
FROM            data_CashOut '+ @WhereClauseDetail)
end







GO
