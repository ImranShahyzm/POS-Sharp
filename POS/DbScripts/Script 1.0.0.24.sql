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
ALTER TABLE dbo.adgen_ColorInfo
	DROP CONSTRAINT FK_adgen_ColorInfo_GLCompany
GO
ALTER TABLE dbo.GLCompany SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.addata_VehicleTransferInformation
	DROP CONSTRAINT FK_addata_VehicleTransferInformation_adgen_ColorInfo
GO
ALTER TABLE dbo.addata_DispatchInformation
	DROP CONSTRAINT FK_addata_DispatchInformation_adgen_ColorInfo
GO
ALTER TABLE dbo.adgen_VehicleRegistrationInfo
	DROP CONSTRAINT FK_adgen_VehicleRegistrationInfo_adgen_ColorInfo
GO
ALTER TABLE dbo.addata_VehicleReceiveInformation
	DROP CONSTRAINT FK_addata_VehicleReceiveInformation_adgen_ColorInfo
GO
ALTER TABLE dbo.addata_VehicleSaleInformation
	DROP CONSTRAINT FK_addata_VehicleSaleInformation_adgen_ColorInfo
GO
ALTER TABLE dbo.adgen_ColorInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.addata_VehicleSaleInformation SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.addata_VehicleReceiveInformation SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.adgen_VehicleRegistrationInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.addata_DispatchInformation SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.addata_VehicleTransferInformation SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


Go



/****** Object:  StoredProcedure [dbo].[PosApi_AllInevntory_Insert]    Script Date: 5/18/2021 2:55:41 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PosApi_AllInevntory_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PosApi_AllInevntory_Insert]
GO
/****** Object:  StoredProcedure [dbo].[pos_ApiGetInventory_SelectAll]    Script Date: 5/18/2021 2:55:41 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pos_ApiGetInventory_SelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pos_ApiGetInventory_SelectAll]
GO
/****** Object:  UserDefinedTableType [dbo].[adgen_ColorInfo]    Script Date: 5/18/2021 2:55:41 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'adgen_ColorInfo' AND ss.name = N'dbo')
DROP TYPE [dbo].[adgen_ColorInfo]
GO
/****** Object:  UserDefinedTableType [dbo].[adgen_ColorInfo]    Script Date: 5/18/2021 2:55:41 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'adgen_ColorInfo' AND ss.name = N'dbo')
CREATE TYPE [dbo].[adgen_ColorInfo] AS TABLE(
	[ColorID] [int] NULL,
	[EntryUserID] [int] NULL,
	[EntryUserDateTime] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyUserDateTime] [datetime] NULL,
	[CompanyID] [int] NULL,
	[ColorTitle] [nvarchar](50) NULL
)
GO
/****** Object:  StoredProcedure [dbo].[pos_ApiGetInventory_SelectAll]    Script Date: 5/18/2021 2:55:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pos_ApiGetInventory_SelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[pos_ApiGetInventory_SelectAll] AS' 
END
GO


ALTER procedure [dbo].[pos_ApiGetInventory_SelectAll]
@SelectMaster bit,
@SelectDetail bit,
@WhereClause varchar(4000),
@WhereClauseDetail varchar(4000)
as

if @SelectMaster = 1
BEGIN
	exec('select * from InventItems '+ @WhereClause)
END


if @SelectDetail = 1
BEGIN
	exec('Select * from inventCategory '+ @WhereClauseDetail)
END

if @SelectDetail = 1
BEGIN
	exec('Select * from gen_ItemMainGroupInfo '+ @WhereClauseDetail)
END
if @SelectDetail = 1
BEGIN
	exec('Select * from InventItemGroup '+ @WhereClauseDetail)
END

if @SelectDetail = 1
BEGIN
	exec('Select * from InventUOm '+ @WhereClauseDetail)
END

if @SelectDetail = 1
BEGIN
	exec('Select * from gen_ItemAttributeInfo '+ @WhereClauseDetail)
END
if @SelectDetail = 1
BEGIN
	exec('Select * from gen_ItemSubCategoryInfo '+ @WhereClauseDetail)
END

if @SelectDetail = 1
BEGIN
	exec('Select * from gen_ItemVariantInfo '+ @WhereClauseDetail)
END

if @SelectDetail = 1
BEGIN
	exec('Select * from adgen_ColorInfo '+ @WhereClauseDetail)
END


GO
/****** Object:  StoredProcedure [dbo].[PosApi_AllInevntory_Insert]    Script Date: 5/18/2021 2:55:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PosApi_AllInevntory_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[PosApi_AllInevntory_Insert] AS' 
END
GO



ALTER procedure [dbo].[PosApi_AllInevntory_Insert]
@StockTransferID int output,
@POSAPI_InventItems POSAPI_InventItems  readonly,
@gen_ItemMainGroupInfo gen_ItemMainGroupInfo readonly,
@InventItemGroup InventItemGroup readonly,
@inventCategory inventCategory readonly,
@inventUOM inventUOM readonly,
@gen_ItemSubCategoryInfo gen_ItemSubCategoryInfo readonly,
@gen_ItemAttributeInfo gen_ItemAttributeInfo readonly,
@gen_ItemVariantInfo gen_ItemVariantInfo readonly,
@adgen_ColorInfo adgen_ColorInfo readonly
as
begin

truncate table InventItems
truncate table inventUOM
truncate table inventCategory
truncate table gen_ItemMainGroupInfo
truncate table  InventItemGroup
truncate table gen_ItemSubCategoryInfo
truncate table gen_ItemAttributeInfo
truncate table gen_ItemVariantInfo
truncate table adgen_ColorInfo
SET IDENTITY_INSERT gen_ItemMainGroupInfo ON
insert into        gen_ItemMainGroupInfo(ItemMainGroupID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, ItemMainGroupName)

Select * from @gen_ItemMainGroupInfo


SET IDENTITY_INSERT gen_ItemMainGroupInfo OFF


SET IDENTITY_INSERT InventItemGroup ON

insert into     InventItemGroup(ItemGroupID, ItemGroupName, CompanyID, ItemMainGroupID)
Select ItemGroupID, ItemGroupName, CompanyID, ItemMainGroupID
FROM            @InventItemGroup
SET IDENTITY_INSERT InventItemGroup OFF

SET IDENTITY_INSERT InventCategory ON

insert into   InventCategory(      CategoryID, CategoryName, ItemGroupID, CompanyID,  MainCategory, Description
)Select CategoryID, CategoryName, ItemGroupID, CompanyID,  MainCategory, Description FROM            @InventCategory


SET IDENTITY_INSERT InventCategory OFF

SET IDENTITY_INSERT gen_ItemSubCategoryInfo ON

insert into   gen_ItemSubCategoryInfo(    SubCategoryId, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, SubCatDescription
)Select SubCategoryId, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, SubCatDescription FROM @gen_ItemSubCategoryInfo
SET IDENTITY_INSERT gen_ItemSubCategoryInfo OFF

SET IDENTITY_INSERT gen_ItemVariantInfo ON

insert into   gen_ItemVariantInfo(ItemVariantInfoId, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, VariantDescription, SalePrice, PurchasePrice, avc
)Select ItemVariantInfoId, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, VariantDescription, SalePrice, PurchasePrice, avc FROM @gen_ItemVariantInfo
SET IDENTITY_INSERT gen_ItemVariantInfo OFF

SET IDENTITY_INSERT gen_ItemAttributeInfo ON

insert into   gen_ItemAttributeInfo(AttributeId, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, AttribDescription
)Select AttributeId, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, AttribDescription FROM @gen_ItemAttributeInfo
SET IDENTITY_INSERT gen_ItemAttributeInfo OFF



SET IDENTITY_INSERT InventUOM ON

insert into InventUOM(UOMId, UOMName, Scale, CompanyID)
Select UOMId, UOMName, Scale, CompanyID
FROM            @InventUOM




SET IDENTITY_INSERT InventUOM OFF



SET IDENTITY_INSERT adgen_ColorInfo ON


insert into adgen_ColorInfo(ColorID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, ColorTitle)
Select ColorID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, ColorTitle
FROM            @adgen_ColorInfo




SET IDENTITY_INSERT adgen_ColorInfo OFF





--********** Finally Inserting Items Now ****************--
ALTER TABLE [dbo].[InventItems] DROP CONSTRAINT [DF_InventItems_CartonSize1_1]
ALTER TABLE [dbo].[InventItems] DROP CONSTRAINT [DF_InventItems_FixAsset]
ALTER TABLE [dbo].[InventItems] DROP CONSTRAINT [DF_InventItems_ItemPurchasePrice]
ALTER TABLE [dbo].[InventItems] DROP CONSTRAINT [DF_InventItems_ItemSalesPrice]
ALTER TABLE [dbo].[InventItems] DROP CONSTRAINT [DF_InventItems_ItemStatus]
ALTER TABLE [dbo].[InventItems] DROP CONSTRAINT [DF_InventItems_MainCategory]
ALTER TABLE [dbo].[InventItems] DROP CONSTRAINT [DF_InventItems_WeightedRate]

SET IDENTITY_INSERT InventItems ON
insert into InventItems     (ItemId, CategoryID, ItemNumber, ItenName, UOMId,  MaintainInventory, ItemPacking, ItemSalesPrice, ItemPurchasePrice, ItemStatus,
ItemImage, CompanyID, WeightedRate, WHID, ItemType, ManualNumber, CartonSize, ProductWeightCode, MainItem, Remarks, ItemVarientId, ColorID, UrduName, BardanaID, Make, ItemModel, Range, SerialNo,
Accessories, Property, FixAsset, CompanyName, WholeSaleRate, ReOrderLevel,ItemGroupID,ItemMainGroupID,
SubCategoryID,
AttributeId	,
SeasonType	,
RegisterInevntoryDate,
isFinisH
)
select ItemId, CategoryID, ItemNumber, ItenName, UOMId,  MaintainInventory, ItemPacking, ItemSalesPrice, ItemPurchasePrice, ItemStatus,
ItemImage, CompanyID, WeightedRate, WHID, ItemType, ManualNumber, CartonSize, ProductWeightCode, MainItem, Remarks, ItemVarientId, ColorID, UrduName, BardanaID, Make, ItemModel, Range, SerialNo,
Accessories, Property, FixAsset, CompanyName, WholeSaleRate, ReOrderLevel,ItemGroupID,ItemMainGroupID,SubCategoryID,AttributeId	,SeasonType	,RegisterInevntoryDate,isFinisH from @POSAPI_InventItems

ALTER TABLE [dbo].[InventItems] add CONSTRAINT [DF_InventItems_CartonSize1_1] DEFAULT ((0)) FOR [CartonSize]
ALTER TABLE [dbo].[InventItems] add CONSTRAINT [DF_InventItems_FixAsset] DEFAULT ((0)) FOR [FixAsset]
ALTER TABLE [dbo].[InventItems] add CONSTRAINT [DF_InventItems_ItemPurchasePrice] DEFAULT ((0)) FOR [ItemPurchasePrice]
ALTER TABLE [dbo].[InventItems] add CONSTRAINT [DF_InventItems_ItemSalesPrice] DEFAULT ((0)) FOR [ItemSalesPrice]
ALTER TABLE [dbo].[InventItems] add CONSTRAINT [DF_InventItems_ItemStatus] DEFAULT ((0)) FOR [ItemStatus]
ALTER TABLE [dbo].[InventItems] add CONSTRAINT [DF_InventItems_MainCategory] DEFAULT ((0)) FOR [MainItem]
ALTER TABLE [dbo].[InventItems] add CONSTRAINT [DF_InventItems_WeightedRate] DEFAULT ((0)) FOR [WeightedRate]

SET IDENTITY_INSERT InventItems OFF
end

SET @StockTransferID=1





GO
