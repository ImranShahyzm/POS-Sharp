
/****** Object:  StoredProcedure [dbo].[PosApi_AllDisaptchesAgainstMakeOrders_Insert]    Script Date: 6/30/2021 4:28:56 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PosApi_AllDisaptchesAgainstMakeOrders_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PosApi_AllDisaptchesAgainstMakeOrders_Insert]
GO
/****** Object:  Table [dbo].[data_StockDispatchpos]    Script Date: 6/30/2021 4:28:56 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockDispatchpos]') AND type in (N'U'))
DROP TABLE [dbo].[data_StockDispatchpos]
GO
/****** Object:  Table [dbo].[data_StockDispatchDetailPos]    Script Date: 6/30/2021 4:28:56 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockDispatchDetailPos]') AND type in (N'U'))
DROP TABLE [dbo].[data_StockDispatchDetailPos]
GO
/****** Object:  UserDefinedTableType [dbo].[data_StockDispatchpos]    Script Date: 6/30/2021 4:28:56 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_StockDispatchpos' AND ss.name = N'dbo')
DROP TYPE [dbo].[data_StockDispatchpos]
GO
/****** Object:  UserDefinedTableType [dbo].[data_StockDispatchDetailPos]    Script Date: 6/30/2021 4:28:56 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_StockDispatchDetailPos' AND ss.name = N'dbo')
DROP TYPE [dbo].[data_StockDispatchDetailPos]
GO
/****** Object:  UserDefinedTableType [dbo].[data_StockDispatchDetailPos]    Script Date: 6/30/2021 4:28:56 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_StockDispatchDetailPos' AND ss.name = N'dbo')
CREATE TYPE [dbo].[data_StockDispatchDetailPos] AS TABLE(
	[StockDispatchDetailID] [int] NULL,
	[StockDispatchID] [int] NULL,
	[ItemId] [int] NULL,
	[Quantity] [numeric](18, 3) NULL,
	[StockRate] [numeric](14, 5) NULL,
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
/****** Object:  UserDefinedTableType [dbo].[data_StockDispatchpos]    Script Date: 6/30/2021 4:28:56 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_StockDispatchpos' AND ss.name = N'dbo')
CREATE TYPE [dbo].[data_StockDispatchpos] AS TABLE(
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
	[IsTaxable] [bit] NULL,
	[AccountVoucherID] [int] NULL,
	[Remarks] [varchar](300) NULL,
	[TruckNumber] [nvarchar](250) NULL,
	[DriverName] [nvarchar](250) NULL,
	[DriverPhone] [nvarchar](250) NULL,
	[TrasnferID] [int] NULL,
	[TransferType] [int] NULL,
	[MakeOrderID] [int] NULL,
	[FromLocation] [nvarchar](250) NULL,
	[ToLocation] [nvarchar](250) NULL,
	[TotalQuantity] [numeric](18, 3) NULL,
	[TotalAmount] [numeric](18, 3) NULL
)
GO
/****** Object:  Table [dbo].[data_StockDispatchDetailPos]    Script Date: 6/30/2021 4:28:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockDispatchDetailPos]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[data_StockDispatchDetailPos](
	[POSDispatchDetailID] [int] IDENTITY(1,1) NOT NULL,
	[StockDispatchDetailID] [int] NULL,
	[StockDispatchID] [int] NULL,
	[ItemId] [int] NULL,
	[Quantity] [numeric](18, 3) NULL,
	[StockRate] [numeric](14, 5) NULL,
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
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[data_StockDispatchpos]    Script Date: 6/30/2021 4:28:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockDispatchpos]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[data_StockDispatchpos](
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
	[IsTaxable] [bit] NOT NULL CONSTRAINT [DF_data_StockDispatchrmationPos_IsTaxable]  DEFAULT ((0)),
	[AccountVoucherID] [int] NULL,
	[Remarks] [varchar](300) NULL,
	[TruckNumber] [nvarchar](250) NULL,
	[DriverName] [nvarchar](250) NULL,
	[DriverPhone] [nvarchar](250) NULL,
	[TrasnferID] [int] NULL,
	[TransferType] [int] NULL,
	[MakeOrderID] [int] NULL,
	[FromLocation] [nvarchar](250) NULL,
	[ToLocation] [nvarchar](250) NULL,
	[TotalQuantity] [numeric](18, 3) NULL,
	[TotalAmount] [numeric](18, 3) NULL,
 CONSTRAINT [PK_data_StockDispatchPOS] PRIMARY KEY CLUSTERED 
(
	[PosDispatchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[PosApi_AllDisaptchesAgainstMakeOrders_Insert]    Script Date: 6/30/2021 4:28:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PosApi_AllDisaptchesAgainstMakeOrders_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[PosApi_AllDisaptchesAgainstMakeOrders_Insert] AS' 
END
GO




ALTER procedure [dbo].[PosApi_AllDisaptchesAgainstMakeOrders_Insert]
@StockTransferID int output,
@data_StockDispatchpos data_StockDispatchpos  readonly,
@data_StockDispatchDetailPos data_StockDispatchDetailPos readonly,
@WHID int=0,
@DateFrom date,
@DateTo date
as
begin
Delete a from data_StockDispatchDetailPos a inner join data_StockDispatchpos on a.StockDispatchID=data_StockDispatchpos.StockDispatchID
where  DispatchToWHID=@WHID and DispatchDate between @DateFrom and @Dateto 
Delete from data_StockDispatchpos where DispatchToWHID=@WHID and DispatchDate between @DateFrom and @Dateto 


insert into data_StockDispatchpos(   StockDispatchID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, DispatchDate, DispatchNo, DispatchFromWHID, DispatchToWHID, FromBranchID, ToBranchID, 
                         IsTaxable, AccountVoucherID, Remarks, TruckNumber, DriverName, DriverPhone, TrasnferID, TransferType, MakeOrderID, FromLocation, ToLocation, TotalQuantity, TotalAmount
)Select  StockDispatchID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, DispatchDate, DispatchNo, DispatchFromWHID, DispatchToWHID, FromBranchID, ToBranchID, 
							 IsTaxable, AccountVoucherID, Remarks, TruckNumber, DriverName, DriverPhone, TrasnferID, TransferType, MakeOrderID, FromLocation, ToLocation, TotalQuantity, TotalAmount from            @data_StockDispatchpos


insert into data_StockDispatchDetailPos (
StockDispatchDetailID, StockDispatchID, ItemId, Quantity, StockRate, CartonQuantity, LooseQuantity, ItemCode, ItemName, Remarks, TransferDetailID, TrackBranchID, OrderDetailID, OrderID, DeliveryDate, 
                         Rno
)

SELECT         StockDispatchDetailID, StockDispatchID, ItemId, Quantity, StockRate, CartonQuantity, LooseQuantity, ItemCode, ItemName, Remarks, TransferDetailID, TrackBranchID, OrderDetailID, OrderID, DeliveryDate, 
                         Rno
FROM            @data_StockDispatchDetailPos




SET @StockTransferID=1


End





GO
