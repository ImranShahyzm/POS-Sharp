/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_SaleManInfo ADD
	SectorID int NULL
GO
ALTER TABLE dbo.gen_SaleManInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

/****** Object:  StoredProcedure [dbo].[PosApi_AllSalesMan_Insert]    Script Date: 9/2/2021 5:07:59 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PosApi_AllSalesMan_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PosApi_AllSalesMan_Insert]
GO
/****** Object:  UserDefinedTableType [dbo].[POS_gen_SaleManInfo]    Script Date: 9/2/2021 5:07:59 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'POS_gen_SaleManInfo' AND ss.name = N'dbo')
DROP TYPE [dbo].[POS_gen_SaleManInfo]
GO
/****** Object:  UserDefinedTableType [dbo].[POS_gen_SaleManInfo]    Script Date: 9/2/2021 5:07:59 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'POS_gen_SaleManInfo' AND ss.name = N'dbo')
CREATE TYPE [dbo].[POS_gen_SaleManInfo] AS TABLE(
	[SaleManInfoID] [int] NULL,
	[EntryUserID] [int] NULL,
	[EntryUserDateTime] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyUserDateTime] [datetime] NULL,
	[CompanyID] [int] NULL,
	[StationID] [int] NULL,
	[SaleManName] [nvarchar](50) NULL,
	[TargetAmount] [int] NULL,
	[SalesPersonGlId] [int] NULL,
	[DOB] [datetime] NULL,
	[DateOfJoin] [datetime] NULL,
	[FatherName] [nvarchar](200) NULL,
	[CNIC] [nvarchar](200) NULL,
	[RegionalManager] [nvarchar](200) NULL,
	[RegionName] [nvarchar](200) NULL,
	[ResignDate] [datetime] NULL,
	[isLeft] [bit] NULL,
	[PhoneNo] [nvarchar](100) NULL,
	[SalesPersonEmail] [nvarchar](100) NULL,
	[SaleManUrduName] [nvarchar](200) NULL,
	[WHID] [int] NULL,
	SectorID int NULL
)
GO
/****** Object:  StoredProcedure [dbo].[PosApi_AllSalesMan_Insert]    Script Date: 9/2/2021 5:07:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PosApi_AllSalesMan_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[PosApi_AllSalesMan_Insert] AS' 
END
GO




ALTER procedure [dbo].[PosApi_AllSalesMan_Insert]
@StockTransferID int output,
@POS_gen_SaleManInfo POS_gen_SaleManInfo  readonly
as
begin

truncate table gen_SaleManInfo


SET IDENTITY_INSERT gen_SaleManInfo ON
insert into        gen_SaleManInfo(SaleManInfoID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, StationID, SaleManName, TargetAmount, SalesPersonGlId, DOB, DateOfJoin, FatherName, CNIC, RegionalManager, 
                         RegionName, ResignDate, isLeft, PhoneNo, SalesPersonEmail, SaleManUrduName, WHID,SectorID
)
Select SaleManInfoID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, StationID, SaleManName, TargetAmount, SalesPersonGlId, DOB, DateOfJoin, FatherName, CNIC, RegionalManager, 
                         RegionName, ResignDate, isLeft, PhoneNo, SalesPersonEmail, SaleManUrduName, WHID,SectorID
 from @POS_gen_SaleManInfo


SET IDENTITY_INSERT gen_SaleManInfo OFF

SET @StockTransferID=1


End



GO
