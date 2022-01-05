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
ALTER TABLE dbo.gen_ItemVariantInfo ADD
	avc int NULL
GO
ALTER TABLE dbo.gen_ItemVariantInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

/****** Object:  Table [dbo].[gen_ItemVariantInfo]    Script Date: 5/4/2021 10:06:06 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE Type [dbo].[gen_ItemVariantInfo] as Table(
	[ItemVariantInfoId] [int] NULL,
	[EntryUserID] [int] NULL,
	[EntryUserDateTime] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyUserDateTime] [datetime] NULL,
	[CompanyID] [int] NULL,
	[VariantDescription] [nvarchar](500) NULL,
	[SalePrice] [numeric](18, 3) NULL,
	[PurchasePrice] [numeric](18, 3) NULL,
	[avc] [int] NULL)
GO



/****** Object:  StoredProcedure [dbo].[PosApi_AllInevntory_Insert]    Script Date: 5/4/2021 10:07:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
@gen_ItemVariantInfo gen_ItemVariantInfo readonly
as
begin

truncate table InventItems
truncate table inventUOM
truncate table inventCategory
truncate table gen_ItemMainGroupInfo
truncate table  InventItemGroup
truncate table gen_ItemSubCategoryInfo
truncate table gen_ItemAttributeInfo

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


