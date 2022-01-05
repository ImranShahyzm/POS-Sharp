
/****** Object:  StoredProcedure [dbo].[POSdata_StockDispatchTrasnferFetch_SelectAll]    Script Date: 9/11/2021 1:41:42 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockDispatchTrasnferFetch_SelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_StockDispatchTrasnferFetch_SelectAll]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_StockDispatchFetch_SelectAll]    Script Date: 9/11/2021 1:41:42 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockDispatchFetch_SelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_StockDispatchFetch_SelectAll]
GO
/****** Object:  Table [dbo].[data_StockDispatchAgainstTransferPOS]    Script Date: 9/11/2021 1:41:42 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockDispatchAgainstTransferPOS]') AND type in (N'U'))
DROP TABLE [dbo].[data_StockDispatchAgainstTransferPOS]
GO
/****** Object:  Table [dbo].[data_StockDispatchAgainstTransferDetailPOS]    Script Date: 9/11/2021 1:41:42 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockDispatchAgainstTransferDetailPOS]') AND type in (N'U'))
DROP TABLE [dbo].[data_StockDispatchAgainstTransferDetailPOS]
GO
/****** Object:  UserDefinedTableType [dbo].[data_StockDispatchAgainstTransferPOS]    Script Date: 9/11/2021 1:41:42 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_StockDispatchAgainstTransferPOS' AND ss.name = N'dbo')
DROP TYPE [dbo].[data_StockDispatchAgainstTransferPOS]
GO
/****** Object:  UserDefinedTableType [dbo].[data_StockDispatchAgainstTransferDetailPOS]    Script Date: 9/11/2021 1:41:42 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_StockDispatchAgainstTransferDetailPOS' AND ss.name = N'dbo')
DROP TYPE [dbo].[data_StockDispatchAgainstTransferDetailPOS]
GO
/****** Object:  UserDefinedTableType [dbo].[data_StockDispatchAgainstTransferDetailPOS]    Script Date: 9/11/2021 1:41:42 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_StockDispatchAgainstTransferDetailPOS' AND ss.name = N'dbo')
CREATE TYPE [dbo].[data_StockDispatchAgainstTransferDetailPOS] AS TABLE(
	[StockDispatchDetailID] [int] NULL,
	[StockDispatchID] [int] NULL,
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
	[DeliveryDate] [nvarchar](250) NULL,
	[Rno] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[data_StockDispatchAgainstTransferPOS]    Script Date: 9/11/2021 1:41:42 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_StockDispatchAgainstTransferPOS' AND ss.name = N'dbo')
CREATE TYPE [dbo].[data_StockDispatchAgainstTransferPOS] AS TABLE(
	[StockDispatchID] [int] NULL,
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
	[IsTaxable] [bit] NOT NULL,
	[AccountVoucherID] [int] NULL,
	[Remarks] [varchar](300) NULL,
	[TruckNumber] [nvarchar](250) NULL,
	[DriverName] [nvarchar](250) NULL,
	[DriverPhone] [nvarchar](250) NULL,
	[StockTransferID] [int] NULL,
	[TransferType] [int] NULL,
	[MakeOrderID] [int] NULL,
	[FromLocation] [nvarchar](250) NULL,
	[ToLocation] [nvarchar](250) NULL,
	[TotalQuantity] [numeric](18, 3) NULL,
	[TotalAmount] [numeric](18, 3) NULL
)
GO
/****** Object:  Table [dbo].[data_StockDispatchAgainstTransferDetailPOS]    Script Date: 9/11/2021 1:41:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockDispatchAgainstTransferDetailPOS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[data_StockDispatchAgainstTransferDetailPOS](
	[POSDispatchDetailID] [int] IDENTITY(1,1) NOT NULL,
	[StockDispatchDetailID] [int] NULL,
	[StockDispatchID] [int] NULL,
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
	[DeliveryDate] [nvarchar](250) NULL,
	[Rno] [int] NULL,
 CONSTRAINT [PK_data_StockDispatchAgainstTransferDetailPOS] PRIMARY KEY CLUSTERED 
(
	[POSDispatchDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[data_StockDispatchAgainstTransferPOS]    Script Date: 9/11/2021 1:41:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockDispatchAgainstTransferPOS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[data_StockDispatchAgainstTransferPOS](
	[PosDispatchID] [int] IDENTITY(1,1) NOT NULL,
	[StockDispatchID] [int] NULL,
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
	[IsTaxable] [bit] NOT NULL,
	[AccountVoucherID] [int] NULL,
	[Remarks] [varchar](300) NULL,
	[TruckNumber] [nvarchar](250) NULL,
	[DriverName] [nvarchar](250) NULL,
	[DriverPhone] [nvarchar](250) NULL,
	[StockTransferID] [int] NULL,
	[TransferType] [int] NULL,
	[MakeOrderID] [int] NULL,
	[FromLocation] [nvarchar](250) NULL,
	[ToLocation] [nvarchar](250) NULL,
	[TotalQuantity] [numeric](18, 3) NULL,
	[TotalAmount] [numeric](18, 3) NULL,
 CONSTRAINT [PK_data_StockDispatchAgainstTransferPOS] PRIMARY KEY CLUSTERED 
(
	[PosDispatchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[POSdata_StockDispatchFetch_SelectAll]    Script Date: 9/11/2021 1:41:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockDispatchFetch_SelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_StockDispatchFetch_SelectAll] AS' 
END
GO


ALTER procedure [dbo].[POSdata_StockDispatchFetch_SelectAll] 
@SelectMaster bit,
@SelectDetail bit,
@WhereClause varchar(4000),
@WhereClauseDetail varchar(4000)
as



if @SelectMaster = 1 
BEGIN
	exec('
	select data_StockDispatch.*,InventWareHouse.WHDesc as FromLocation,ab.WHDesc as TOLocation,
Cast((Select sum(Quantity) from data_StockDispatchDetail where data_StockDispatchDetail.StockDispatchID=data_StockDispatch.StockDispatchID)as Int) as TotalQuantity,
Cast((Select sum(Quantity*inv.ItemSalesPrice) from data_StockDispatchDetail inner join InventItems inv on inv.ItemId=data_StockDispatchDetail.ItemId where data_StockDispatchDetail.StockDispatchID=data_StockDispatch.StockDispatchID)as Int) as TotalAmount
from data_StockDispatch
left join InventWareHouse on InventWareHouse.WHID=data_StockDispatch.DispatchFromWHID
left join InventWareHouse ab on ab.WHID=data_StockDispatch.DispatchToWHID
	 '+ @WhereClause)
END


if @SelectDetail = 1 
BEGIN

	exec('select data_StockDispatchDetail.*,fORMAT(DeliveryDate,''dd-MMM-yyyy'') as DeliveryDate,RNo  from data_StockDispatchDetail inner join Posdata_MaketoOrderInfoServer on Posdata_MaketoOrderInfoServer.OrderID=data_StockDispatchDetail.OrderID and Posdata_MaketoOrderInfoServer.WHID=data_StockDispatchDetail.TrackBranchID 
	inner join data_StockDispatch on data_StockDispatch.StockDispatchID=data_StockDispatchDetail.StockDispatchID
	'+ @WhereClauseDetail)

END








GO
/****** Object:  StoredProcedure [dbo].[POSdata_StockDispatchTrasnferFetch_SelectAll]    Script Date: 9/11/2021 1:41:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockDispatchTrasnferFetch_SelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_StockDispatchTrasnferFetch_SelectAll] AS' 
END
GO



ALTER procedure [dbo].[POSdata_StockDispatchTrasnferFetch_SelectAll] 
@SelectMaster bit,
@SelectDetail bit,
@WhereClause varchar(4000),
@WhereClauseDetail varchar(4000)
as



if @SelectMaster = 1 
BEGIN
	exec('
	select data_StockDispatchAgainstTransfer.*,InventWareHouse.WHDesc as FromLocation,ab.WHDesc as TOLocation,
Cast((Select sum(Quantity) from data_StockDispatchAgainstTransferDetail where data_StockDispatchAgainstTransferDetail.StockDispatchID=data_StockDispatchAgainstTransfer.StockDispatchID)as Int) as TotalQuantity,
Cast((Select sum(Quantity*inv.ItemSalesPrice) from data_StockDispatchAgainstTransferDetail inner join InventItems inv on inv.ItemId=data_StockDispatchAgainstTransferDetail.ItemId where data_StockDispatchAgainstTransferDetail.StockDispatchID=data_StockDispatchAgainstTransfer.StockDispatchID)as Int) as TotalAmount
from data_StockDispatchAgainstTransfer
left join InventWareHouse on InventWareHouse.WHID=data_StockDispatchAgainstTransfer.DispatchFromWHID
left join InventWareHouse ab on ab.WHID=data_StockDispatchAgainstTransfer.DispatchToWHID

	 '+ @WhereClause)
END


if @SelectDetail = 1 
BEGIN

	exec('
select data_StockDispatchAgainstTransferDetail.*,fORMAT(TransferDate,''dd-MMM-yyyy'') as DeliveryDate,TransferNo as RNo  from data_StockDispatchAgainstTransferDetail  inner join data_StockTransferDetail on data_StockTransferDetail.StockTransferDetailID=data_StockDispatchAgainstTransferDetail.TransferDetailID inner join data_StockTransferInfo on data_StockTransferInfo.StockTransferID=data_StockTransferDetail.StockTransferID

inner join data_StockDispatchAgainstTransfer on data_StockDispatchAgainstTransfer.StockDispatchID=data_StockDispatchAgainstTransferDetail.StockDispatchID'+ @WhereClauseDetail)

END









GO
