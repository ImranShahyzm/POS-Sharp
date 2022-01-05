
/****** Object:  StoredProcedure [dbo].[PosApi_AllBillOfMaterials_Insert]    Script Date: 9/2/2021 1:36:04 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PosApi_AllBillOfMaterials_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PosApi_AllBillOfMaterials_Insert]
GO
/****** Object:  StoredProcedure [dbo].[pos_ApiGetBillOfMaterial_SelectAll]    Script Date: 9/2/2021 1:36:04 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pos_ApiGetBillOfMaterial_SelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pos_ApiGetBillOfMaterial_SelectAll]
GO
/****** Object:  UserDefinedTableType [dbo].[POSgen_BOMDetail]    Script Date: 9/2/2021 1:36:04 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'POSgen_BOMDetail' AND ss.name = N'dbo')
DROP TYPE [dbo].[POSgen_BOMDetail]
GO
/****** Object:  UserDefinedTableType [dbo].[gen_BOMInfo]    Script Date: 9/2/2021 1:36:04 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'gen_BOMInfo' AND ss.name = N'dbo')
DROP TYPE [dbo].[gen_BOMInfo]
GO
/****** Object:  UserDefinedTableType [dbo].[gen_BOMInfo]    Script Date: 9/2/2021 1:36:04 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'gen_BOMInfo' AND ss.name = N'dbo')
CREATE TYPE [dbo].[gen_BOMInfo] AS TABLE(
	[BOMID] [int] NULL,
	[EntryUserID] [int] NULL,
	[EntryUserDateTime] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyUserDateTime] [datetime] NULL,
	[CompanyID] [int] NULL,
	[BOMNo] [int] NULL,
	[ItemId] [int] NULL,
	[UOMId] [int] NULL,
	[BaseQuantity] [numeric](10, 3) NULL,
	[Remarks] [varchar](300) NULL,
	[DefaultBOM] [bit] NULL,
	[BranchID] [int] NULL,
	[Hours] [int] NULL,
	[PerHourProduction] [numeric](18, 3) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[POSgen_BOMDetail]    Script Date: 9/2/2021 1:36:04 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'POSgen_BOMDetail' AND ss.name = N'dbo')
CREATE TYPE [dbo].[POSgen_BOMDetail] AS TABLE(
	[BOMDetailID] [int] NULL,
	[BOMID] [int] NOT NULL,
	[ItemId] [int] NULL,
	[UOMId] [int] NULL,
	[Quantity] [numeric](10, 3) NULL,
	[Remarks] [varchar](300) NULL
)
GO
/****** Object:  StoredProcedure [dbo].[pos_ApiGetBillOfMaterial_SelectAll]    Script Date: 9/2/2021 1:36:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pos_ApiGetBillOfMaterial_SelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[pos_ApiGetBillOfMaterial_SelectAll] AS' 
END
GO


ALTER procedure [dbo].[pos_ApiGetBillOfMaterial_SelectAll]
@SelectMaster bit,
@SelectDetail bit,
@WhereClause varchar(4000),
@WhereClauseDetail varchar(4000)
as

if @SelectMaster = 1
BEGIN
	exec('select * from gen_BOMInfo '+ @WhereClause)
END


if @SelectDetail = 1
BEGIN
	exec('Select gen_BOMDetail.* from gen_BOMDetail inner join gen_BOMInfo on gen_BOMInfo.BOMID=gen_BOMDetail.BOMID '+ @WhereClauseDetail)
END


GO
/****** Object:  StoredProcedure [dbo].[PosApi_AllBillOfMaterials_Insert]    Script Date: 9/2/2021 1:36:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PosApi_AllBillOfMaterials_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[PosApi_AllBillOfMaterials_Insert] AS' 
END
GO




ALTER procedure [dbo].[PosApi_AllBillOfMaterials_Insert]
@StockTransferID int output,
@gen_BOMInfo gen_BOMInfo  readonly,
@POSgen_BOMDetail POSgen_BOMDetail readonly
as
begin

truncate table gen_BOMInfo
truncate table gen_BOMDetail

SET IDENTITY_INSERT gen_BOMInfo ON
insert into        gen_BOMInfo(BOMID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, BOMNo, ItemId, UOMId, BaseQuantity, Remarks, DefaultBOM, BranchID, Hours, PerHourProduction)

SELECT        BOMID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, BOMNo, ItemId, UOMId, BaseQuantity, Remarks, DefaultBOM, BranchID, Hours, PerHourProduction
FROM            @gen_BOMInfo


SET IDENTITY_INSERT gen_BOMInfo OFF


SET IDENTITY_INSERT gen_BOMDetail ON

insert into     gen_BOMDetail( BOMDetailID, BOMID, ItemId, UOMId, Quantity, Remarks)
SELECT        BOMDetailID, BOMID, ItemId, UOMId, Quantity, Remarks
FROM            @POSgen_BOMDetail


SET IDENTITY_INSERT gen_BOMDetail OFF

SET @StockTransferID=1
end

GO
