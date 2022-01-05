
/****** Object:  StoredProcedure [dbo].[Posdata_MaketoOrderInfo_loadSOPending]    Script Date: 6/30/2021 4:24:34 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Posdata_MaketoOrderInfo_loadSOPending]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Posdata_MaketoOrderInfo_loadSOPending]
GO
/****** Object:  StoredProcedure [dbo].[Posdata_MaketoOrderInfo_loadSO]    Script Date: 6/30/2021 4:24:34 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Posdata_MaketoOrderInfo_loadSO]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Posdata_MaketoOrderInfo_loadSO]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_MakeOrderInsertServer_Insert]    Script Date: 6/30/2021 4:24:34 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_MakeOrderInsertServer_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_MakeOrderInsertServer_Insert]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_MakeOrderInfoServer_SelectAll]    Script Date: 6/30/2021 4:24:34 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_MakeOrderInfoServer_SelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_MakeOrderInfoServer_SelectAll]
GO
/****** Object:  StoredProcedure [dbo].[data_StockDispatch_SelectAll]    Script Date: 6/30/2021 4:24:34 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockDispatch_SelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_StockDispatch_SelectAll]
GO
/****** Object:  StoredProcedure [dbo].[data_StockDispatch_Insert]    Script Date: 6/30/2021 4:24:34 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockDispatch_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_StockDispatch_Insert]
GO
/****** Object:  StoredProcedure [dbo].[data_StockDispatch_delete]    Script Date: 6/30/2021 4:24:34 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockDispatch_delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_StockDispatch_delete]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_data_StockDispatchDetail_InventItems]') AND parent_object_id = OBJECT_ID(N'[dbo].[data_StockDispatchDetail]'))
ALTER TABLE [dbo].[data_StockDispatchDetail] DROP CONSTRAINT [FK_data_StockDispatchDetail_InventItems]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_data_StockDispatchDetail_data_StockDispatch]') AND parent_object_id = OBJECT_ID(N'[dbo].[data_StockDispatchDetail]'))
ALTER TABLE [dbo].[data_StockDispatchDetail] DROP CONSTRAINT [FK_data_StockDispatchDetail_data_StockDispatch]
GO
/****** Object:  Table [dbo].[Posdata_MaketoOrderInfoServer]    Script Date: 6/30/2021 4:24:34 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Posdata_MaketoOrderInfoServer]') AND type in (N'U'))
DROP TABLE [dbo].[Posdata_MaketoOrderInfoServer]
GO
/****** Object:  Table [dbo].[Posdata_MaketoOrderDetailServer]    Script Date: 6/30/2021 4:24:34 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Posdata_MaketoOrderDetailServer]') AND type in (N'U'))
DROP TABLE [dbo].[Posdata_MaketoOrderDetailServer]
GO
/****** Object:  Table [dbo].[data_StockDispatchDetail]    Script Date: 6/30/2021 4:24:34 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockDispatchDetail]') AND type in (N'U'))
DROP TABLE [dbo].[data_StockDispatchDetail]
GO
/****** Object:  Table [dbo].[data_StockDispatch]    Script Date: 6/30/2021 4:24:34 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockDispatch]') AND type in (N'U'))
DROP TABLE [dbo].[data_StockDispatch]
GO
/****** Object:  UserDefinedTableType [dbo].[Posdata_MaketoOrderInfoServer]    Script Date: 6/30/2021 4:24:34 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'Posdata_MaketoOrderInfoServer' AND ss.name = N'dbo')
DROP TYPE [dbo].[Posdata_MaketoOrderInfoServer]
GO
/****** Object:  UserDefinedTableType [dbo].[Posdata_MaketoOrderDetailServer]    Script Date: 6/30/2021 4:24:34 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'Posdata_MaketoOrderDetailServer' AND ss.name = N'dbo')
DROP TYPE [dbo].[Posdata_MaketoOrderDetailServer]
GO
/****** Object:  UserDefinedTableType [dbo].[data_StockDispatchDetail]    Script Date: 6/30/2021 4:24:34 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_StockDispatchDetail' AND ss.name = N'dbo')
DROP TYPE [dbo].[data_StockDispatchDetail]
GO
/****** Object:  UserDefinedTableType [dbo].[data_StockDispatchDetail]    Script Date: 6/30/2021 4:24:34 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_StockDispatchDetail' AND ss.name = N'dbo')
CREATE TYPE [dbo].[data_StockDispatchDetail] AS TABLE(
	[RowID] [int] NULL,
	[ItemId] [int] NULL,
	[Quantity] [numeric](18, 3) NULL,
	[StockRate] [numeric](14, 5) NOT NULL,
	[CartonQuantity] [numeric](18, 3) NULL,
	[LooseQuantity] [numeric](18, 3) NULL,
	[ItemCode] [nvarchar](250) NULL,
	[ItemName] [nvarchar](250) NULL,
	[Remarks] [nvarchar](max) NULL,
	[TransferDetailID] [int] NULL,
	[TrackBranchID] [int] NULL,
	[OrderDetailID] [int] NULL,
	[OrderID] [int] NULL,
	[DeliveryDate] [nvarchar](250) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[Posdata_MaketoOrderDetailServer]    Script Date: 6/30/2021 4:24:34 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'Posdata_MaketoOrderDetailServer' AND ss.name = N'dbo')
CREATE TYPE [dbo].[Posdata_MaketoOrderDetailServer] AS TABLE(
	[OrderDetailID] [bigint] NULL,
	[OrderID] [bigint] NULL,
	[ItemId] [int] NULL,
	[Quantity] [numeric](18, 2) NULL,
	[ItemRate] [numeric](18, 2) NULL,
	[TaxPercentage] [numeric](18, 2) NULL,
	[TaxAmount] [numeric](18, 2) NULL,
	[DiscountPercentage] [numeric](18, 2) NULL,
	[DiscountAmount] [numeric](18, 2) NULL,
	[TotalAmount] [numeric](18, 2) NULL,
	[ManaufacturingID] [int] NULL,
	[CartonSize] [decimal](18, 3) NULL,
	[Carton] [decimal](18, 3) NULL,
	[TotalQuantity] [decimal](18, 3) NULL,
	[SchemeID] [int] NULL,
	[MinQuantity] [numeric](18, 3) NULL,
	[isExchange] [bit] NULL,
	[StockRate] [numeric](18, 3) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[Posdata_MaketoOrderInfoServer]    Script Date: 6/30/2021 4:24:34 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'Posdata_MaketoOrderInfoServer' AND ss.name = N'dbo')
CREATE TYPE [dbo].[Posdata_MaketoOrderInfoServer] AS TABLE(
	[OrderID] [int] NULL,
	[RegisterDate] [datetime] NULL,
	[CName] [nvarchar](1000) NULL,
	[CPhone] [nvarchar](1000) NULL,
	[Address] [nvarchar](max) NULL,
	[CityName] [nvarchar](500) NULL,
	[Gender] [nvarchar](100) NULL,
	[EntryUserID] [int] NULL,
	[EntryUserDateTime] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyUserDateTime] [datetime] NULL,
	[CompanyID] [int] NULL,
	[FiscalID] [int] NULL,
	[WHID] [int] NULL,
	[CNIC] [nvarchar](1000) NULL,
	[Neck] [nvarchar](50) NULL,
	[FFrontNeck] [nvarchar](50) NULL,
	[FBackNeck] [nvarchar](50) NULL,
	[Shoulder] [nvarchar](50) NULL,
	[FUpperBust] [nvarchar](50) NULL,
	[Bust] [nvarchar](50) NULL,
	[FUnderBust] [nvarchar](50) NULL,
	[ArmHole] [nvarchar](50) NULL,
	[SleeveLength] [nvarchar](50) NULL,
	[Muscle] [nvarchar](50) NULL,
	[Elbow] [nvarchar](50) NULL,
	[Cuff] [nvarchar](50) NULL,
	[Waist] [nvarchar](50) NULL,
	[Hip] [nvarchar](50) NULL,
	[BottomLength] [nvarchar](50) NULL,
	[Ankle] [nvarchar](50) NULL,
	[Remarks] [nvarchar](max) NULL,
	[RNo] [int] NULL,
	[IsTaxable] [bit] NULL,
	[CustomerID] [int] NULL,
	[CardNumber] [nvarchar](max) NULL,
	[CardName] [nvarchar](100) NULL,
	[CashPayment] [numeric](18, 3) NULL,
	[CardPayment] [numeric](18, 3) NULL,
	[SaleManId] [int] NULL,
	[TaxAmount] [numeric](18, 2) NULL,
	[GrossAmount] [numeric](18, 2) NULL,
	[DiscountPercentage] [numeric](18, 2) NULL,
	[DiscountAmount] [numeric](18, 2) NULL,
	[DiscountTotal] [numeric](18, 2) NULL,
	[OtherCharges] [numeric](18, 2) NULL,
	[NetAmount] [numeric](18, 2) NULL,
	[AmountReceive] [numeric](18, 2) NULL,
	[AmountReturn] [numeric](18, 2) NULL,
	[AmountInAccount] [numeric](18, 2) NULL,
	[AmountReceivable] [numeric](18, 2) NULL,
	[AmountPayable] [numeric](18, 2) NULL,
	[DirectReturn] [bit] NULL,
	[DeliveryDate] [datetime] NULL,
	[SalePosID] [int] NULL,
	[ImageActualPath] [nvarchar](max) NULL,
	[IsOrderSynced] [bit] NULL
)
GO
/****** Object:  Table [dbo].[data_StockDispatch]    Script Date: 6/30/2021 4:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockDispatch]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[data_StockDispatch](
	[StockDispatchID] [int] IDENTITY(1,1) NOT NULL,
	[EntryUserID] [int] NULL,
	[EntryUserDateTime] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyUserDateTime] [datetime] NULL,
	[CompanyID] [int] NULL,
	[FiscalID] [int] NULL,
	[DispatchDate] [date] NULL,
	[DispatchNo] [int] NULL,
	[DispatchFromWHID] [int] NULL,
	[DispatchToWHID] [int] NULL,
	[FromBranchID] [int] NULL,
	[ToBranchID] [int] NULL,
	[IsTaxable] [bit] NOT NULL CONSTRAINT [DF_data_StockDispatchrmation_IsTaxable]  DEFAULT ((0)),
	[AccountVoucherID] [int] NULL,
	[Remarks] [varchar](300) NULL,
	[TruckNumber] [nvarchar](250) NULL,
	[DriverName] [nvarchar](250) NULL,
	[DriverPhone] [nvarchar](250) NULL,
	[TrasnferID] [int] NULL,
	[TransferType] [int] NULL,
	[MakeOrderID] [int] NULL,
 CONSTRAINT [PK_data_StockDispatch] PRIMARY KEY CLUSTERED 
(
	[StockDispatchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[data_StockDispatchDetail]    Script Date: 6/30/2021 4:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockDispatchDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[data_StockDispatchDetail](
	[StockDispatchDetailID] [int] IDENTITY(1,1) NOT NULL,
	[StockDispatchID] [int] NULL,
	[ItemId] [int] NULL,
	[Quantity] [numeric](18, 3) NULL,
	[StockRate] [numeric](14, 5) NOT NULL CONSTRAINT [DF_data_StockDispatchDetail_StockRate]  DEFAULT ((0)),
	[CartonQuantity] [numeric](18, 3) NULL,
	[LooseQuantity] [numeric](18, 3) NULL,
	[ItemCode] [nvarchar](250) NULL,
	[ItemName] [nvarchar](250) NULL,
	[Remarks] [nvarchar](max) NULL,
	[TransferDetailID] [int] NULL,
	[TrackBranchID] [int] NULL,
	[OrderDetailID] [int] NULL,
	[OrderID] [int] NULL,
 CONSTRAINT [PK_data_StockDispatchDetail] PRIMARY KEY CLUSTERED 
(
	[StockDispatchDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Posdata_MaketoOrderDetailServer]    Script Date: 6/30/2021 4:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Posdata_MaketoOrderDetailServer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Posdata_MaketoOrderDetailServer](
	[OrderDetailID] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderID] [bigint] NULL,
	[ItemId] [int] NULL,
	[Quantity] [numeric](18, 2) NULL,
	[ItemRate] [numeric](18, 2) NULL,
	[TaxPercentage] [numeric](18, 2) NULL,
	[TaxAmount] [numeric](18, 2) NULL,
	[DiscountPercentage] [numeric](18, 2) NULL,
	[DiscountAmount] [numeric](18, 2) NULL,
	[TotalAmount] [numeric](18, 2) NULL,
	[ManaufacturingID] [int] NULL,
	[CartonSize] [decimal](18, 3) NULL,
	[Carton] [decimal](18, 3) NULL,
	[TotalQuantity] [decimal](18, 3) NULL,
	[SchemeID] [int] NULL,
	[MinQuantity] [numeric](18, 3) NULL,
	[isExchange] [bit] NULL,
	[StockRate] [numeric](18, 3) NULL,
	[TrackBranchID] [int] NULL,
 CONSTRAINT [PK_Posdata_MaketoOrderDetailServer] PRIMARY KEY CLUSTERED 
(
	[OrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Posdata_MaketoOrderInfoServer]    Script Date: 6/30/2021 4:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Posdata_MaketoOrderInfoServer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Posdata_MaketoOrderInfoServer](
	[OrderID] [int] NULL,
	[RegisterDate] [datetime] NULL,
	[CName] [nvarchar](1000) NULL,
	[CPhone] [nvarchar](1000) NULL,
	[Address] [nvarchar](max) NULL,
	[CityName] [nvarchar](500) NULL,
	[Gender] [nvarchar](100) NULL,
	[EntryUserID] [int] NULL,
	[EntryUserDateTime] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyUserDateTime] [datetime] NULL,
	[CompanyID] [int] NULL,
	[FiscalID] [int] NULL,
	[WHID] [int] NULL,
	[CNIC] [nvarchar](1000) NULL,
	[Neck] [nvarchar](50) NULL,
	[FFrontNeck] [nvarchar](50) NULL,
	[FBackNeck] [nvarchar](50) NULL,
	[Shoulder] [nvarchar](50) NULL,
	[FUpperBust] [nvarchar](50) NULL,
	[Bust] [nvarchar](50) NULL,
	[FUnderBust] [nvarchar](50) NULL,
	[ArmHole] [nvarchar](50) NULL,
	[SleeveLength] [nvarchar](50) NULL,
	[Muscle] [nvarchar](50) NULL,
	[Elbow] [nvarchar](50) NULL,
	[Cuff] [nvarchar](50) NULL,
	[Waist] [nvarchar](50) NULL,
	[Hip] [nvarchar](50) NULL,
	[BottomLength] [nvarchar](50) NULL,
	[Ankle] [nvarchar](50) NULL,
	[Remarks] [nvarchar](max) NULL,
	[RNo] [int] NULL,
	[IsTaxable] [bit] NULL,
	[CustomerID] [int] NULL,
	[CardNumber] [nvarchar](max) NULL,
	[CardName] [nvarchar](100) NULL,
	[CashPayment] [numeric](18, 3) NULL,
	[CardPayment] [numeric](18, 3) NULL,
	[SaleManId] [int] NULL,
	[TaxAmount] [numeric](18, 2) NULL,
	[GrossAmount] [numeric](18, 2) NULL,
	[DiscountPercentage] [numeric](18, 2) NULL,
	[DiscountAmount] [numeric](18, 2) NULL,
	[DiscountTotal] [numeric](18, 2) NULL,
	[OtherCharges] [numeric](18, 2) NULL,
	[NetAmount] [numeric](18, 2) NULL,
	[AmountReceive] [numeric](18, 2) NULL,
	[AmountReturn] [numeric](18, 2) NULL,
	[AmountInAccount] [numeric](18, 2) NULL,
	[AmountReceivable] [numeric](18, 2) NULL,
	[AmountPayable] [numeric](18, 2) NULL,
	[DirectReturn] [bit] NULL,
	[DeliveryDate] [datetime] NULL,
	[ImagePath] [varbinary](max) NULL,
	[SalePosID] [int] NULL,
	[ImageActualPath] [nvarchar](max) NULL,
	[IsOrderSynced] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_data_StockDispatchDetail_data_StockDispatch]') AND parent_object_id = OBJECT_ID(N'[dbo].[data_StockDispatchDetail]'))
ALTER TABLE [dbo].[data_StockDispatchDetail]  WITH CHECK ADD  CONSTRAINT [FK_data_StockDispatchDetail_data_StockDispatch] FOREIGN KEY([StockDispatchID])
REFERENCES [dbo].[data_StockDispatch] ([StockDispatchID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_data_StockDispatchDetail_data_StockDispatch]') AND parent_object_id = OBJECT_ID(N'[dbo].[data_StockDispatchDetail]'))
ALTER TABLE [dbo].[data_StockDispatchDetail] CHECK CONSTRAINT [FK_data_StockDispatchDetail_data_StockDispatch]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_data_StockDispatchDetail_InventItems]') AND parent_object_id = OBJECT_ID(N'[dbo].[data_StockDispatchDetail]'))
ALTER TABLE [dbo].[data_StockDispatchDetail]  WITH CHECK ADD  CONSTRAINT [FK_data_StockDispatchDetail_InventItems] FOREIGN KEY([ItemId])
REFERENCES [dbo].[InventItems] ([ItemId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_data_StockDispatchDetail_InventItems]') AND parent_object_id = OBJECT_ID(N'[dbo].[data_StockDispatchDetail]'))
ALTER TABLE [dbo].[data_StockDispatchDetail] CHECK CONSTRAINT [FK_data_StockDispatchDetail_InventItems]
GO
/****** Object:  StoredProcedure [dbo].[data_StockDispatch_delete]    Script Date: 6/30/2021 4:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockDispatch_delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_StockDispatch_delete] AS' 
END
GO


ALTER procedure [dbo].[data_StockDispatch_delete] @StockDispatchID int  as

	declare @AccountVoucherID int

	declare @ProductInflowSourceIDTable as data_ProductInflow, @ItemsWarehouseBatchWise as ItemsWarehouseBatchWise,@DispatchDate date , @CompanyID int ,
	@IsTaxable bit = 0

	select @AccountVoucherID = AccountVoucherID ,@DispatchDate =DispatchDate, @CompanyID = CompanyID ,
	@IsTaxable = IsTaxable from data_StockDispatch where StockDispatchID = @StockDispatchID


	insert into @ProductInflowSourceIDTable (SourceID)
	select StockDispatchDetailID from data_StockDispatchDetail where StockDispatchID = @StockDispatchID
	update data_ProductInflow set IsDeleted = 1 where SourceName = 'Dispatch IN' and SourceID in (select SourceID from @ProductInflowSourceIDTable )


	declare @ErrorMsg varchar(200) 
	set @ErrorMsg = ''
	exec CheckDeletedStock 'Dispatch IN', @ItemsWarehouseBatchWise , @ProductInflowSourceIDTable , @DispatchDate , @ErrorMsg output , @CompanyID , @IsTaxable
	if @ErrorMsg <> ''
	BEGIN
		RAISERROR (@ErrorMsg ,16 , 1);
		return
	END

	delete from data_ProductInflowBatch where SourceName =  'Dispatch IN'  AND SourceID in (select SourceID from  @ProductInflowSourceIDTable )	
	delete from data_ProductInflow where SourceName =  'Dispatch IN'  AND SourceID in (select SourceID from  @ProductInflowSourceIDTable )	

	delete from data_ProductOutflowBatch where SourceName = 'Dispatch OUT' and SourceID in (select StockDispatchDetailID from data_StockDispatchDetail where StockDispatchID = @StockDispatchID) 
	delete from data_ProductOutflow where SourceName = 'Dispatch OUT' and SourceID in (select StockDispatchDetailID from data_StockDispatchDetail where StockDispatchID = @StockDispatchID) 


	
	delete from data_StockDispatchDetail where StockDispatchID = @StockDispatchID	
	delete from data_StockDispatch where StockDispatchID = @StockDispatchID	
	--exec GLvMAIN_delete @AccountVoucherID






GO
/****** Object:  StoredProcedure [dbo].[data_StockDispatch_Insert]    Script Date: 6/30/2021 4:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockDispatch_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_StockDispatch_Insert] AS' 
END
GO

ALTER procedure [dbo].[data_StockDispatch_Insert] 
@StockDispatchID int  output , 
@UserID int = null , 
@CompanyID int = null , 
@FiscalID int = null ,
@DispatchDate date = null , 
@DispatchNo int = null , 
@DispatchFromWHID int = null , 
@DispatchToWHID int = null , 
@FromBranchID int = null , 
@ToBranchID int = null , 
@IsTaxable bit = null , 
@Remarks varchar(300) = null, 
@IsStockToShed	bit=0,
@DispatchToShedId int=null,
@data_StockDispatchDetail  data_StockDispatchDetail readonly ,
@data_ItemBatchDetail  data_ItemBatchDetail readonly,
@TruckNumber nvarchar(250) =NULL,
@DriverName NVARCHAR(250) =NULL,
@DriverPhone nvarchar(250) =Null
as

declare @EditMode bit  = 0, @StockCheckDate date,@IskhaakiSoft bit=0
Select @IskhaakiSoft =isKhaakiSoft from gen_SystemConfiguration where CompanyID=@CompanyID
if	 @StockDispatchID = 0
BEGIN
	declare @MaxTable as MaxTable

	insert into @MaxTable	
	exec GetVoucherNoI @Fieldname=N'DispatchNo',@TableName=N'data_StockDispatch',@CheckTaxable= 1 ,@PrimaryKeyValue = @StockDispatchID,@PrimaryKeyFieldName = 'StockDispatchID' ,
	@voucherDate=@DispatchDate,@voucherDateFieldName=N'DispatchDate',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=@FiscalID, 
	@FiscalIDFieldName=N'FiscalID',@IsTaxable=@IsTaxable
	select @DispatchNo = VoucherNo from @MaxTable


	set @StockCheckDate = @DispatchDate

	Insert into data_StockDispatch ( 
		EntryUserID , 
		EntryUserDateTime , 
		CompanyID , 
		FiscalID ,
		DispatchDate , 
		DispatchNo , 
		DispatchFromWHID , 
		DispatchToWHID , 
		FromBranchID , 
		ToBranchID , 
		IsTaxable , 
		Remarks,
	
		TruckNumber,
		DriverName ,
		DriverPhone 
	
	) Values (
		@UserID , 
		GETDATE() ,
		@CompanyID , 
		@FiscalID ,
		@DispatchDate , 
		@DispatchNo , 
		@DispatchFromWHID , 
		@DispatchToWHID , 
		@FromBranchID , 
		@ToBranchID , 
		@IsTaxable , 
		@Remarks,
	
		@TruckNumber,
		@DriverName ,
		@DriverPhone 
	)	
	set @StockDispatchID = @@IDENTITY
	
END

ELSE

BEGIN	


declare @SaveVoucherdate date , @IsVoucherNoMonthly bit
select @IsVoucherNoMonthly = IsVoucherNoMonthly from gen_SystemConfiguration where CompanyID =  @CompanyID

if @IsVoucherNoMonthly = 1
BEGIN
	select @SaveVoucherdate = DispatchDate from data_StockDispatch where StockDispatchID = @StockDispatchID

	if MONTH(@DispatchDate) <> MONTH(@SaveVoucherdate) or  YEAR(@DispatchDate) <> YEAR(@SaveVoucherdate)
	BEGIN
		insert into @MaxTable
		exec GetVoucherNoI @Fieldname=N'DispatchNo',@TableName=N'data_StockDispatch',@CheckTaxable= 1 ,@PrimaryKeyValue = @StockDispatchID,@PrimaryKeyFieldName = 'StockDispatchID' ,
		@voucherDate=@DispatchDate,@voucherDateFieldName=N'DispatchDate',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=@FiscalID, 
		@FiscalIDFieldName=N'FiscalID',@IsTaxable=@IsTaxable
		select @DispatchNo = VoucherNo from @MaxTable

	END
END

	select @StockCheckDate = DispatchDate from data_StockDispatch where StockDispatchID = @StockDispatchID

	if @StockCheckDate > @DispatchDate
	BEGIN
		set @StockCheckDate = @DispatchDate
	END


	update data_StockDispatch set	
	ModifyUserID = @UserID , 
	ModifyUserDateTime = GETDATE() , 
	CompanyID = @CompanyID , 
	FiscalID = @FiscalID ,
	DispatchDate = @DispatchDate , 
	DispatchNo = @DispatchNo , 
	DispatchFromWHID = @DispatchFromWHID , 
	DispatchToWHID = @DispatchToWHID , 
	FromBranchID = @FromBranchID , 
	ToBranchID = @ToBranchID , 
	IsTaxable = @IsTaxable , 
	Remarks = @Remarks,
	
	TruckNumber=@TruckNumber,
	DriverName=@DriverName ,
	DriverPhone =@DriverPhone



	where StockDispatchID = @StockDispatchID


	declare @ProductInflowSourceIDTable as data_ProductInflow	, @ItemsWarehouseBatchWise as ItemsWarehouseBatchWise
	insert into @ProductInflowSourceIDTable (SourceID) select StockDispatchDetailID from data_StockDispatchDetail where StockDispatchID = @StockDispatchID
	
	insert into @ItemsWarehouseBatchWise (ItemID,WHID,Param1,Param2,Param3)	
	select a.ItemId,@DispatchToWHID,b.Param1,b.Param2,b.Param3 from @data_StockDispatchDetail a left join 
	@data_ItemBatchDetail b on a.RowID = b.RowID

	update data_ProductInflow set IsDeleted = 1 where SourceName = 'Dispatch IN' and SourceID in (select SourceID from @ProductInflowSourceIDTable )
	delete from data_ProductOutflowBatch where SourceName =  'Dispatch OUT' and SourceID in (select StockDispatchDetailID from data_StockDispatchDetail where StockDispatchID = @StockDispatchID)
	delete from data_ProductOutflow where SourceName = 'Dispatch OUT' and SourceID in (select StockDispatchDetailID from data_StockDispatchDetail where StockDispatchID = @StockDispatchID)
	
	delete from data_StockDispatchDetail where StockDispatchID = @StockDispatchID
	set	@EditMode = 1
END
	

declare @RowID int,@StockDispatchDetailID int ,@StockRate numeric(14,5) , @Quantity numeric(10,2),@ItemId int,@stockQty numeric(14,2),
@ItemName varchar(200),@ERRORMSG varchar(200)

 
--declare @jj as xml = (select * from @data_StockDispatchDetail for xml auto)

declare firstcursor cursor for
select RowID from @data_StockDispatchDetail
open firstcursor
fetch next from firstcursor into @RowID
while @@FETCH_STATUS = 0
	begin
		declare @checkRate bit = 1
		select @ItemId = ItemId, @Quantity = Quantity,@StockRate =StockRate  From @data_StockDispatchDetail where RowID = @RowID
		
			exec CheckStock @ItemID = @ItemId ,
			@WHID = @DispatchFromWHID , 
			@StockDate = @DispatchDate , 
			@CompanyID = @CompanyID,			
			@RowID = @RowID ,
			@AllowNegativeStock = 0,
			@Quantity = @Quantity,
			@ERRORMSG = @ERRORMSG out,
			@checkRate = @checkRate out,
			@data_ItemBatchDetail =  @data_ItemBatchDetail ,
			@IsTaxable = @IsTaxable


			if @ERRORMSG != ''
			BEGIN
				RAISERROR (@ERRORMSG , 16, 1 ) ;
				return
			END

		--END

		Insert Into data_StockDispatchDetail (
		StockDispatchID ,
		ItemId ,
		Quantity ,
		StockRate ,CartonQuantity,LooseQuantity,
		ItemCode,
		ItemName,
		Remarks, TransferDetailID, TrackBranchID, OrderDetailID,OrderID
		) Select
		@StockDispatchID ,
		ItemId ,
		Quantity ,
		StockRate ,CartonQuantity,LooseQuantity,
		ItemCode,
		ItemName,Remarks, TransferDetailID, TrackBranchID, OrderDetailID,OrderID 
		From @data_StockDispatchDetail where RowID = @RowID

		set @StockDispatchDetailID = @@IDENTITY	
			
		
		declare @productInflowID int,@ProductOutflowID int

		
		exec GetWeightedRateForItem @ItemId, @DispatchFromWHID ,@DispatchDate ,@DispatchDate ,@StockRate output , @CompanyID , @IsTaxable
		update data_StockDispatchDetail set StockRate = @StockRate where StockDispatchDetailID = @StockDispatchDetailID
		exec data_ProductOutflow_Insert @ProductOutflowID output,null,@ItemId,@StockDispatchDetailID,'Dispatch OUT',@DispatchFromWHID, 
		@DispatchDate ,@StockRate,@Quantity,@FiscalID , @CompanyID , @IsTaxable,null,null,null,null,null,@FromBranchID

		select  @ProductOutflowID as ProductOutflowID,'Dispatch OUT' as SourceName into #tempOut
				
				if @IskhaakiSoft!=1
				begin
					exec data_ProductInflow_Insert @productInflowID output,@ItemId,@StockDispatchDetailID,'Dispatch IN',@DispatchToWHID, 
					@DispatchDate ,@StockRate,@Quantity,@Quantity ,@FiscalID , @CompanyID , @IsTaxable,null,null,null,null,null,@ToBranchID,@DispatchToShedId
				end
		select  @productInflowID as ProductInflowID,'Dispatch IN' as SourceName into #tempIn
		

		
		drop table #tempOut;
		drop table #tempIn;

	FETCH NEXT FROM firstcursor INTO @RowID
	END

close firstcursor
deallocate firstcursor


--check Stock Available Or not of Inserted Item
if @EditMode = 1
BEGIN	
	set @ErrorMsg = ''
	exec CheckDeletedStock 'Dispatch IN', @ItemsWarehouseBatchWise , @ProductInflowSourceIDTable , @StockCheckDate , @ErrorMsg output, 
	@CompanyID , @IsTaxable
	if @ErrorMsg <> ''
	BEGIN
		RAISERROR (@ErrorMsg ,16 , 1);
		return
	END
	delete from data_ProductInflowBatch where SourceName =  'Dispatch IN'  AND SourceID in (select SourceID from  @ProductInflowSourceIDTable )
	delete from data_ProductInflow where SourceName =  'Dispatch IN'  AND SourceID in (select SourceID from  @ProductInflowSourceIDTable ) and IsDeleted = 1
END



--Start Account Voucher

--exec data_StockDispatch_InsertAccount @StockDispatchID = @StockDispatchID, @CompanyID = @CompanyID, @DispatchDate = @DispatchDate , 
--@DispatchFromWHID = @DispatchFromWHID ,@DispatchToWHID = @DispatchToWHID , @DispatchNo = @DispatchNo , @UserID = @UserID ,
--@FiscalID = @FiscalID ,@EditMode = @EditMode ,@FromBranchID = @FromBranchID ,@ToBranchID = @ToBranchID, @Remarks = @Remarks,
--@IsTaxable=@IsTaxable,@data_StockDispatchDetail = @data_StockDispatchDetail,@ShedId=@DispatchToShedId

--End Account Voucher







GO
/****** Object:  StoredProcedure [dbo].[data_StockDispatch_SelectAll]    Script Date: 6/30/2021 4:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockDispatch_SelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_StockDispatch_SelectAll] AS' 
END
GO


ALTER procedure [dbo].[data_StockDispatch_SelectAll] 
@SelectMaster bit,
@SelectDetail bit,
@WhereClause varchar(4000),
@WhereClauseDetail varchar(4000)
as



if @SelectMaster = 1 
BEGIN
	exec('
	select FORMAT( DispatchDate ,''dd-MMM-yyyy'') as DispatchDateFormat , data_StockDispatch.*,InventWareHouse.WHDesc as FromLocation,ab.WHDesc as TOLocation,
Cast((Select sum(Quantity) from data_StockDispatchDetail where data_StockDispatchDetail.StockDispatchID=data_StockDispatch.StockDispatchID)as Int) as TotalQuantity,
Cast((Select sum(Quantity*inv.ItemSalesPrice) from data_StockDispatchDetail inner join InventItems inv on inv.ItemId=data_StockDispatchDetail.ItemId where data_StockDispatchDetail.StockDispatchID=data_StockDispatch.StockDispatchID)as Int) as TotalAmount
from data_StockDispatch
left join InventWareHouse on InventWareHouse.WHID=data_StockDispatch.DispatchFromWHID
left join InventWareHouse ab on ab.WHID=data_StockDispatch.DispatchToWHID
	 '+ @WhereClause)
END


if @SelectDetail = 1 
BEGIN

	exec('select data_StockDispatchDetail.*,fORMAT(DeliveryDate,''dd-MMM-yyyy'') as DeliveryDate,RNo  from data_StockDispatchDetail inner join Posdata_MaketoOrderInfoServer on Posdata_MaketoOrderInfoServer.OrderID=data_StockDispatchDetail.OrderID and Posdata_MaketoOrderInfoServer.WHID=data_StockDispatchDetail.TrackBranchID '+ @WhereClauseDetail)

END







GO
/****** Object:  StoredProcedure [dbo].[POSdata_MakeOrderInfoServer_SelectAll]    Script Date: 6/30/2021 4:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_MakeOrderInfoServer_SelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_MakeOrderInfoServer_SelectAll] AS' 
END
GO








ALTER procedure [dbo].[POSdata_MakeOrderInfoServer_SelectAll] 
@WhereClause nvarchar(Max),
@BoolMaster bit=0,
@DetailMaster bit=0,
@WhereClauseDetail nvarchar(Max)
as


if(@BoolMaster=1)
begin
exec('Select OrderID, RegisterDate, CName, CPhone, Address, CityName, Gender, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, WHID, CNIC, Neck, FFrontNeck, FBackNeck, Shoulder, 
                         FUpperBust, Bust, FUnderBust, ArmHole, SleeveLength, Muscle, Elbow, Cuff, Waist, Hip, BottomLength, Ankle, Remarks, RNo, IsTaxable, CustomerID, CardNumber, CardName, CashPayment, CardPayment, SaleManId, 
                         TaxAmount, GrossAmount, DiscountPercentage, DiscountAmount, DiscountTotal, OtherCharges, NetAmount, AmountReceive, AmountReturn, AmountInAccount, AmountReceivable, AmountPayable, DirectReturn, 
                        
						   DeliveryDate,
						 ImagePath,
						SalePosID,
						ImageActualPath,
							IsOrderSynced	
						 
						 from Posdata_MaketoOrderInfo'+ @WhereClause)
end
if (@DetailMaster=1)
begin
exec('
SELECT        OrderDetailID, Posdata_MaketoOrderDetail.OrderID, ItemId, Quantity, ItemRate, TaxPercentage, Posdata_MaketoOrderDetail.TaxAmount, Posdata_MaketoOrderDetail.DiscountPercentage, Posdata_MaketoOrderDetail.DiscountAmount, TotalAmount, ManaufacturingID, CartonSize, Carton, TotalQuantity, SchemeID, MinQuantity, isExchange, 
                         StockRate
FROM            Posdata_MaketoOrderDetail inner join Posdata_MaketoOrderInfo on Posdata_MaketoOrderInfo.OrderID=Posdata_MaketoOrderDetail.OrderID '+ @WhereClauseDetail)
end








GO
/****** Object:  StoredProcedure [dbo].[POSdata_MakeOrderInsertServer_Insert]    Script Date: 6/30/2021 4:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_MakeOrderInsertServer_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_MakeOrderInsertServer_Insert] AS' 
END
GO






ALTER procedure [dbo].[POSdata_MakeOrderInsertServer_Insert] 
@IsInserted int output ,
@Posdata_MaketoOrderInfoServer Posdata_MaketoOrderInfoServer readonly,
@Posdata_MaketoOrderDetailServer  Posdata_MaketoOrderDetailServer readonly,
@WHID int=0,
@OrderID int=0 
as

Delete from Posdata_MaketoOrderInfoServer where WHID=@WHID and OrderID=@OrderID
--Delete from data_ProductOutflow where SourceName='MakerOrder' and WHID=@WHID and SourceID in (Select OrderDetailID from Posdata_MaketoOrderDetailServer where TrackBranchID=@WHID and OrderID=@OrderID)
Delete from Posdata_MaketoOrderDetailServer where TrackBranchID=@WHID and OrderID=@OrderID
insert into Posdata_MaketoOrderInfoServer( OrderID, RegisterDate, CName, CPhone, Address, CityName, Gender, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, WHID, CNIC, Neck, FFrontNeck, FBackNeck, Shoulder, 
                         FUpperBust, Bust, FUnderBust, ArmHole, SleeveLength, Muscle, Elbow, Cuff, Waist, Hip, BottomLength, Ankle, Remarks, RNo, IsTaxable, CustomerID, CardNumber, CardName, CashPayment, CardPayment, SaleManId, 
                         TaxAmount, GrossAmount, DiscountPercentage, DiscountAmount, DiscountTotal, OtherCharges, NetAmount, AmountReceive, AmountReturn, AmountInAccount, AmountReceivable, AmountPayable, DirectReturn, 
                         DeliveryDate,
					
						SalePosID,
						ImageActualPath,
							IsOrderSynced	
	)
						 Select OrderID, RegisterDate, CName, CPhone, Address, CityName, Gender, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, WHID, CNIC, Neck, FFrontNeck, FBackNeck, Shoulder, 
                         FUpperBust, Bust, FUnderBust, ArmHole, SleeveLength, Muscle, Elbow, Cuff, Waist, Hip, BottomLength, Ankle, Remarks, RNo, IsTaxable, CustomerID, CardNumber, CardName, CashPayment, CardPayment, SaleManId, 
                         TaxAmount, GrossAmount, DiscountPercentage, DiscountAmount, DiscountTotal, OtherCharges, NetAmount, AmountReceive, AmountReturn, AmountInAccount, AmountReceivable, AmountPayable, DirectReturn, 
                         DeliveryDate,
						 
						SalePosID,
						ImageActualPath,
							IsOrderSynced	
						 
						 
						  from @Posdata_MaketoOrderInfoServer
insert into Posdata_MaketoOrderDetailServer(OrderID, ItemId, Quantity, ItemRate, TaxPercentage, TaxAmount, DiscountPercentage, DiscountAmount, TotalAmount, ManaufacturingID, CartonSize, Carton, TotalQuantity, SchemeID, MinQuantity, isExchange, 
                         StockRate, TrackBranchID)

SELECT        @OrderID, ItemId, Quantity, ItemRate, TaxPercentage, TaxAmount, DiscountPercentage, DiscountAmount, TotalAmount, ManaufacturingID, CartonSize, Carton, TotalQuantity, SchemeID, MinQuantity, isExchange, 
                         StockRate, @WHID
FROM            @Posdata_MaketoOrderDetailServer


set @IsInserted=1
--declare @ArrivalDate datetime=null,@CompanyId int=0,@FiscalID int=0
--Select @CompanyId=CompanyId,@FiscalID=FiscalID from gen_posConfiguration where WHID=@WHID
--select @ArrivalDate =RegisterDate from Posdata_MaketoOrderInfoServer where WHID=@WHID and OrderID=@OrderID
--insert into data_ProductOutflow  (ItemId, SourceID, SourceName, WHID, StockDate, StockRate, Quantity, FiscalID, CompanyID, IsTaxable)
--Select ItemId,OrderDetailID,'MakerOrder',@WHID,@ArrivalDate,Stockrate,Quantity,@FiscalID,@CompanyId,0from
--Posdata_MaketoOrderDetailServer where OrderID=@OrderID and TrackBranchID=@WHID




GO
/****** Object:  StoredProcedure [dbo].[Posdata_MaketoOrderInfo_loadSO]    Script Date: 6/30/2021 4:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Posdata_MaketoOrderInfo_loadSO]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Posdata_MaketoOrderInfo_loadSO] AS' 
END
GO
ALTER procedure [dbo].[Posdata_MaketoOrderInfo_loadSO] 
@WhereClause varchar(4000),
@EditClause varchar(2000)

as


exec('select DeliveryDate,TotalSOQuantity-UsedQuantity as Quantity,OrderDetailID,TrackBranchID,OrderID,a.ItemId,ItenName,ItemNumber,TotalSOQuantity,UsedQuantity,a.Remarks,InventItems.ItemSalesPrice as StockRate from
                (select * from (select Posdata_MaketoOrderDetailServer.OrderDetailID,TrackBranchID, Posdata_MaketoOrderInfoServer.WHID,Format(DeliveryDate,''dd-MMM-yyyy'') as DeliveryDate,Posdata_MaketoOrderInfoServer.OrderID,Posdata_MaketoOrderInfoServer.RNo,Posdata_MaketoOrderDetailServer.ItemId, 
                Posdata_MaketoOrderDetailServer.Quantity as TotalSOQuantity,Posdata_MaketoOrderInfoServer.RegisterDate,
                isnull((select sum(b.Quantity)  from data_StockDispatchDetail b where b.OrderDetailID = Posdata_MaketoOrderDetailServer.OrderDetailID and b.TrackBranchID= Posdata_MaketoOrderDetailServer.TrackBranchID '+ @EditClause +'
),0)
 as UsedQuantity,ISNULL(Posdata_MaketoOrderInfoServer.Remarks,''No Reamrks Addedd'') as Remarks 
                from Posdata_MaketoOrderInfoServer inner join Posdata_MaketoOrderDetailServer on Posdata_MaketoOrderInfoServer.OrderID = Posdata_MaketoOrderDetailServer.OrderID 
				and Posdata_MaketoOrderInfoServer.WHID=Posdata_MaketoOrderDetailServer.TrackBranchID
 ' + @WhereClause + ')  a where TotalSOQuantity-UsedQuantity > 0
                 )a inner join InventWareHouse b on a.WHID = b.WHID
				 inner join InventItems on InventItems.ItemId=a.ItemId'
				 )

 



 



GO
/****** Object:  StoredProcedure [dbo].[Posdata_MaketoOrderInfo_loadSOPending]    Script Date: 6/30/2021 4:24:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Posdata_MaketoOrderInfo_loadSOPending]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Posdata_MaketoOrderInfo_loadSOPending] AS' 
END
GO

ALTER procedure [dbo].[Posdata_MaketoOrderInfo_loadSOPending] 
@WhereClause varchar(4000),
@EditClause varchar(2000)

as


exec('select Distinct RNo as OrderNo,OrderID,WHDesc,a.WHID,Format(RegisterDate,''dd-MMM-yyyy'') as RegisterDate,DeliveryDate,TotalSOQuantity-UsedQuantity as Quantity,(TotalSOQuantity-UsedQuantity)*ItemSalesPrice as TotalAmount from
                (select * from (select Posdata_MaketoOrderDetailServer.OrderDetailID,TrackBranchID, Posdata_MaketoOrderInfoServer.WHID,Format(DeliveryDate,''dd-MMM-yyyy'') as DeliveryDate,Posdata_MaketoOrderInfoServer.OrderID,Posdata_MaketoOrderInfoServer.RNo,Posdata_MaketoOrderDetailServer.ItemId, 
                Posdata_MaketoOrderDetailServer.Quantity as TotalSOQuantity,Posdata_MaketoOrderInfoServer.RegisterDate,
                isnull((select sum(b.Quantity)  from data_StockDispatchDetail b where b.OrderDetailID = Posdata_MaketoOrderDetailServer.OrderDetailID and b.TrackBranchID= Posdata_MaketoOrderDetailServer.TrackBranchID '+ @EditClause +'
),0)
 as UsedQuantity,ISNULL(Posdata_MaketoOrderInfoServer.Remarks,''No Reamrks Addedd'') as Remarks 
                from Posdata_MaketoOrderInfoServer inner join Posdata_MaketoOrderDetailServer on Posdata_MaketoOrderInfoServer.OrderID = Posdata_MaketoOrderDetailServer.OrderID 
				and Posdata_MaketoOrderInfoServer.WHID=Posdata_MaketoOrderDetailServer.TrackBranchID
 ' + @WhereClause + ')  a where TotalSOQuantity-UsedQuantity > 0
                 )a inner join InventWareHouse b on a.WHID = b.WHID
				 inner join InventItems on InventItems.ItemId=a.ItemId'
				 )

 



GO
