
/****** Object:  StoredProcedure [dbo].[PosApi_AllInevntory_Insert]    Script Date: 5/4/2021 9:45:54 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PosApi_AllInevntory_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PosApi_AllInevntory_Insert]
GO
/****** Object:  UserDefinedTableType [dbo].[POSAPI_InventItems]    Script Date: 5/4/2021 9:45:54 AM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'POSAPI_InventItems' AND ss.name = N'dbo')
DROP TYPE [dbo].[POSAPI_InventItems]
GO
/****** Object:  UserDefinedTableType [dbo].[InventUOM]    Script Date: 5/4/2021 9:45:54 AM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'InventUOM' AND ss.name = N'dbo')
DROP TYPE [dbo].[InventUOM]
GO
/****** Object:  UserDefinedTableType [dbo].[InventItemGroup]    Script Date: 5/4/2021 9:45:54 AM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'InventItemGroup' AND ss.name = N'dbo')
DROP TYPE [dbo].[InventItemGroup]
GO
/****** Object:  UserDefinedTableType [dbo].[InventCategory]    Script Date: 5/4/2021 9:45:54 AM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'InventCategory' AND ss.name = N'dbo')
DROP TYPE [dbo].[InventCategory]
GO
/****** Object:  UserDefinedTableType [dbo].[gen_ItemMainGroupInfo]    Script Date: 5/4/2021 9:45:54 AM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'gen_ItemMainGroupInfo' AND ss.name = N'dbo')
DROP TYPE [dbo].[gen_ItemMainGroupInfo]
GO
/****** Object:  UserDefinedTableType [dbo].[gen_ItemMainGroupInfo]    Script Date: 5/4/2021 9:45:54 AM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'gen_ItemMainGroupInfo' AND ss.name = N'dbo')
CREATE TYPE [dbo].[gen_ItemMainGroupInfo] AS TABLE(
	[ItemMainGroupID] [int] NULL,
	[EntryUserID] [int] NULL,
	[EntryUserDateTime] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyUserDateTime] [datetime] NULL,
	[CompanyID] [int] NULL,
	[ItemMainGroupName] [nvarchar](50) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[InventCategory]    Script Date: 5/4/2021 9:45:54 AM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'InventCategory' AND ss.name = N'dbo')
CREATE TYPE [dbo].[InventCategory] AS TABLE(
	[CategoryID] [int] NULL,
	[CategoryName] [nvarchar](300) NULL,
	[ItemGroupID] [int] NULL,
	[CompanyID] [int] NULL,
	[StockAccount] [int] NULL,
	[SaleAccount] [int] NULL,
	[CGSAccount] [int] NULL,
	[MainCategory] [bit] NULL,
	[Description] [nvarchar](max) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[InventItemGroup]    Script Date: 5/4/2021 9:45:55 AM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'InventItemGroup' AND ss.name = N'dbo')
CREATE TYPE [dbo].[InventItemGroup] AS TABLE(
	[ItemGroupID] [int] NULL,
	[ItemGroupName] [nvarchar](50) NULL,
	[CompanyID] [int] NULL,
	[ItemMainGroupID] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[InventUOM]    Script Date: 5/4/2021 9:45:55 AM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'InventUOM' AND ss.name = N'dbo')
CREATE TYPE [dbo].[InventUOM] AS TABLE(
	[UOMId] [int] NULL,
	[UOMName] [nvarchar](50) NULL,
	[Scale] [decimal](9, 4) NULL,
	[CompanyID] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[POSAPI_InventItems]    Script Date: 5/4/2021 9:45:55 AM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'POSAPI_InventItems' AND ss.name = N'dbo')
CREATE TYPE [dbo].[POSAPI_InventItems] AS TABLE(
	[ItemId] [int] NULL,
	[CategoryID] [int] NULL,
	[ItemNumber] [bigint] NULL,
	[ItenName] [nvarchar](300) NULL,
	[UOMId] [int] NULL,
	[ItemBrandId] [int] NULL,
	[MaintainInventory] [bit] NULL,
	[ItemPacking] [int] NULL,
	[ItemSalesPrice] [decimal](18, 3) NULL,
	[ItemPurchasePrice] [decimal](18, 3) NULL,
	[ItemStatus] [bit] NULL,
	[ItemPurchaseGL] [int] NULL,
	[ItemPurReturnGL] [int] NULL,
	[ItemSalesGL] [int] NULL,
	[ItemSaleReturnGL] [int] NULL,
	[ItemImage] [nvarchar](max) NULL,
	[CompanyID] [int] NULL,
	[TaxGroupID] [int] NULL,
	[WeightedRate] [numeric](14, 5) NOT NULL,
	[WHID] [int] NULL,
	[ItemType] [varchar](10) NULL,
	[ManualNumber] [nvarchar](50) NULL,
	[CartonSize] [numeric](10, 5) NOT NULL,
	[ProductWeightCode] [int] NULL,
	[MainItem] [bit] NULL,
	[Remarks] [nvarchar](500) NULL,
	[ItemVarientId] [int] NULL,
	[ColorID] [int] NULL,
	[UrduName] [nvarchar](50) NULL,
	[BardanaID] [int] NULL,
	[Make] [nvarchar](50) NULL,
	[ItemModel] [nvarchar](50) NULL,
	[Range] [nvarchar](50) NULL,
	[SerialNo] [nvarchar](50) NULL,
	[Accessories] [nvarchar](max) NULL,
	[Property] [nvarchar](50) NULL,
	[FixAsset] [bit] NULL,
	[CompanyName] [int] NULL,
	[WholeSaleRate] [numeric](18, 3) NULL,
	[ReOrderLevel] [numeric](18, 3) NULL,
	[ItemGroupID] [int] NULL,
	[ItemMainGroupID] [int] NULL,
	SubCategoryID	int	NULL,
	AttributeId	int	NULL,
	SeasonType	int	NULL,
	RegisterInevntoryDate	datetime	NULL,
	isFinish	bit	NULL
)
GO
/****** Object:  StoredProcedure [dbo].[PosApi_AllInevntory_Insert]    Script Date: 5/4/2021 9:45:55 AM ******/
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
@gen_ItemSubCategoryInfo gen_ItemSubCategoryInfo readonly
as
begin

truncate table InventItems
truncate table inventUOM
truncate table inventCategory
truncate table gen_ItemMainGroupInfo
truncate table  InventItemGroup
truncate table gen_ItemSubCategoryInfo

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


GO
