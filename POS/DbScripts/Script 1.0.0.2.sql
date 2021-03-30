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
ALTER TABLE dbo.gen_PosConfiguration ADD
	BranchID int NULL
GO
ALTER TABLE dbo.gen_PosConfiguration SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

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
ALTER TABLE dbo.gen_PosConfiguration ADD
	CashAccountPos int NULL
GO
ALTER TABLE dbo.gen_PosConfiguration SET (LOCK_ESCALATION = TABLE)
GO
COMMIT



/****** Object:  StoredProcedure [dbo].[POSData_StockRawTrasnfer_load]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSData_StockRawTrasnfer_load]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSData_StockRawTrasnfer_load]
GO
/****** Object:  StoredProcedure [dbo].[POSData_StockInwardRem_load]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSData_StockInwardRem_load]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSData_StockInwardRem_load]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_StockArrivalManualInfo_Insert]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockArrivalManualInfo_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_StockArrivalManualInfo_Insert]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_StockArrivalInfoServer_Insert]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockArrivalInfoServer_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_StockArrivalInfoServer_Insert]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_StockArrivalInfo_SelectAll]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockArrivalInfo_SelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_StockArrivalInfo_SelectAll]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_StockArrivalInfo_Insert]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockArrivalInfo_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_StockArrivalInfo_Insert]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_StockArrival_delete]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockArrival_delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_StockArrival_delete]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleReturnInfoServer_InsertAccount]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleReturnInfoServer_InsertAccount]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_SaleReturnInfoServer_InsertAccount]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleReturnInfoServer_Insert]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleReturnInfoServer_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_SaleReturnInfoServer_Insert]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleandReturnInfoServer_SelectAll]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleandReturnInfoServer_SelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_SaleandReturnInfoServer_SelectAll]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleandReturnInfoServer_InsertAccount]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleandReturnInfoServer_InsertAccount]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_SaleandReturnInfoServer_InsertAccount]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleandReturnInfoServer_Insert]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleandReturnInfoServer_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_SaleandReturnInfoServer_Insert]
GO
/****** Object:  StoredProcedure [dbo].[POSAPI_StockRaw_Insert]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSAPI_StockRaw_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSAPI_StockRaw_Insert]
GO
/****** Object:  StoredProcedure [dbo].[PosApi_RawMaterialStock_Insert]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PosApi_RawMaterialStock_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PosApi_RawMaterialStock_Insert]
GO
/****** Object:  StoredProcedure [dbo].[data_RawStockArrival_SelectAll]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_RawStockArrival_SelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_RawStockArrival_SelectAll]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_data_StockArrivalInfo_gen_BranchInfo]') AND parent_object_id = OBJECT_ID(N'[dbo].[data_StockArrivalInfo]'))
ALTER TABLE [dbo].[data_StockArrivalInfo] DROP CONSTRAINT [FK_data_StockArrivalInfo_gen_BranchInfo]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_data_StockArrivalInfo_data_StockArrivalInfo]') AND parent_object_id = OBJECT_ID(N'[dbo].[data_StockArrivalInfo]'))
ALTER TABLE [dbo].[data_StockArrivalInfo] DROP CONSTRAINT [FK_data_StockArrivalInfo_data_StockArrivalInfo]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_data_StockArrivalInformation_IsTaxable]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[dataPOS_StockArrival] DROP CONSTRAINT [DF_data_StockArrivalInformation_IsTaxable]
END

GO
/****** Object:  Table [dbo].[POSdata_StockArrivalInfoServer]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockArrivalInfoServer]') AND type in (N'U'))
DROP TABLE [dbo].[POSdata_StockArrivalInfoServer]
GO
/****** Object:  Table [dbo].[POSdata_StockArrivalDetailServer]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockArrivalDetailServer]') AND type in (N'U'))
DROP TABLE [dbo].[POSdata_StockArrivalDetailServer]
GO
/****** Object:  Table [dbo].[pos_ServerVouchers]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pos_ServerVouchers]') AND type in (N'U'))
DROP TABLE [dbo].[pos_ServerVouchers]
GO
/****** Object:  Table [dbo].[dataPOS_StockArrival]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dataPOS_StockArrival]') AND type in (N'U'))
DROP TABLE [dbo].[dataPOS_StockArrival]
GO
/****** Object:  Table [dbo].[data_StockTransferRawDetail]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockTransferRawDetail]') AND type in (N'U'))
DROP TABLE [dbo].[data_StockTransferRawDetail]
GO
/****** Object:  Table [dbo].[data_StockArrivalInfo]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockArrivalInfo]') AND type in (N'U'))
DROP TABLE [dbo].[data_StockArrivalInfo]
GO
/****** Object:  Table [dbo].[data_StockArrivalDetail]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockArrivalDetail]') AND type in (N'U'))
DROP TABLE [dbo].[data_StockArrivalDetail]
GO
/****** Object:  Table [dbo].[data_SalePosReturnInfoServer]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosReturnInfoServer]') AND type in (N'U'))
DROP TABLE [dbo].[data_SalePosReturnInfoServer]
GO
/****** Object:  Table [dbo].[data_SalePosReturnDetailServer]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosReturnDetailServer]') AND type in (N'U'))
DROP TABLE [dbo].[data_SalePosReturnDetailServer]
GO
/****** Object:  Table [dbo].[data_SalePosInfoServer]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfoServer]') AND type in (N'U'))
DROP TABLE [dbo].[data_SalePosInfoServer]
GO
/****** Object:  Table [dbo].[data_SalePosDetailServer]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosDetailServer]') AND type in (N'U'))
DROP TABLE [dbo].[data_SalePosDetailServer]
GO
/****** Object:  Table [dbo].[data_RawStockTransfer]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_RawStockTransfer]') AND type in (N'U'))
DROP TABLE [dbo].[data_RawStockTransfer]
GO
/****** Object:  UserDefinedTableType [dbo].[POSdata_StockArrivalInfoServer]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'POSdata_StockArrivalInfoServer' AND ss.name = N'dbo')
DROP TYPE [dbo].[POSdata_StockArrivalInfoServer]
GO
/****** Object:  UserDefinedTableType [dbo].[POSdata_StockArrivalDetailServer]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'POSdata_StockArrivalDetailServer' AND ss.name = N'dbo')
DROP TYPE [dbo].[POSdata_StockArrivalDetailServer]
GO
/****** Object:  UserDefinedTableType [dbo].[data_StockTransferRawDetail]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_StockTransferRawDetail' AND ss.name = N'dbo')
DROP TYPE [dbo].[data_StockTransferRawDetail]
GO
/****** Object:  UserDefinedTableType [dbo].[data_StockArrivalManual]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_StockArrivalManual' AND ss.name = N'dbo')
DROP TYPE [dbo].[data_StockArrivalManual]
GO
/****** Object:  UserDefinedTableType [dbo].[data_StockArrivalDetail]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_StockArrivalDetail' AND ss.name = N'dbo')
DROP TYPE [dbo].[data_StockArrivalDetail]
GO
/****** Object:  UserDefinedTableType [dbo].[data_SalePosReturnInfoServer]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_SalePosReturnInfoServer' AND ss.name = N'dbo')
DROP TYPE [dbo].[data_SalePosReturnInfoServer]
GO
/****** Object:  UserDefinedTableType [dbo].[data_SalePosReturnDetailServer]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_SalePosReturnDetailServer' AND ss.name = N'dbo')
DROP TYPE [dbo].[data_SalePosReturnDetailServer]
GO
/****** Object:  UserDefinedTableType [dbo].[data_SalePosInfoServer]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_SalePosInfoServer' AND ss.name = N'dbo')
DROP TYPE [dbo].[data_SalePosInfoServer]
GO
/****** Object:  UserDefinedTableType [dbo].[data_SalePosDetailServer]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_SalePosDetailServer' AND ss.name = N'dbo')
DROP TYPE [dbo].[data_SalePosDetailServer]
GO
/****** Object:  UserDefinedTableType [dbo].[data_RawStockTransfer]    Script Date: 3/29/2021 4:32:36 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_RawStockTransfer' AND ss.name = N'dbo')
DROP TYPE [dbo].[data_RawStockTransfer]
GO
/****** Object:  UserDefinedTableType [dbo].[data_RawStockTransfer]    Script Date: 3/29/2021 4:32:36 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_RawStockTransfer' AND ss.name = N'dbo')
CREATE TYPE [dbo].[data_RawStockTransfer] AS TABLE(
	[StockTransferID] [int] NULL,
	[TransferDate] [date] NULL,
	[TransferNo] [int] NULL,
	[TransferFromWHID] [int] NULL,
	[TransferToWHID] [int] NULL,
	[FromBranchID] [int] NULL,
	[ToBranchID] [int] NULL,
	[Remarks] [varchar](300) NULL,
	[IsStockToShed] [bit] NULL,
	[FiscalID] [int] NULL,
	[CompanyID] [int] NULL,
	[WHID] [int] NULL,
	[USERID] [int] NULL,
	[ISTaxable] [nvarchar](50) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[data_SalePosDetailServer]    Script Date: 3/29/2021 4:32:36 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_SalePosDetailServer' AND ss.name = N'dbo')
CREATE TYPE [dbo].[data_SalePosDetailServer] AS TABLE(
	[SalePosDetailID] [bigint] NULL,
	[SalePosID] [bigint] NULL,
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
	[TotalQuantity] [decimal](18, 3) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[data_SalePosInfoServer]    Script Date: 3/29/2021 4:32:36 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_SalePosInfoServer' AND ss.name = N'dbo')
CREATE TYPE [dbo].[data_SalePosInfoServer] AS TABLE(
	[SalePosID] [bigint] NOT NULL,
	[EntryUserID] [int] NULL,
	[EntryUserDateTime] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyUserDateTime] [datetime] NULL,
	[CompanyID] [int] NULL,
	[FiscalID] [int] NULL,
	[SalePosDate] [date] NULL,
	[WHID] [int] NULL,
	[TaxAmount] [decimal](18, 2) NULL,
	[GrossAmount] [decimal](18, 2) NULL,
	[DiscountPercentage] [decimal](18, 2) NULL,
	[DiscountAmount] [decimal](18, 2) NULL,
	[DiscountTotal] [decimal](18, 2) NULL,
	[OtherCharges] [decimal](18, 2) NULL,
	[NetAmount] [decimal](18, 2) NULL,
	[AmountReceive] [decimal](18, 2) NULL,
	[AmountReturn] [float] NULL,
	[SalePosReturnID] [bigint] NULL,
	[AmountInAccount] [decimal](18, 2) NULL,
	[AmountReceivable] [decimal](18, 2) NULL,
	[AmountPayable] [decimal](18, 2) NULL,
	[DirectReturn] [bit] NULL,
	[MfgID] [int] NULL,
	[CustomerPhone] [nvarchar](50) NULL,
	[CustomerName] [nvarchar](50) NULL,
	[SalePOSNo] [int] NULL,
	[isTaxable] [bit] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[data_SalePosReturnDetailServer]    Script Date: 3/29/2021 4:32:36 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_SalePosReturnDetailServer' AND ss.name = N'dbo')
CREATE TYPE [dbo].[data_SalePosReturnDetailServer] AS TABLE(
	[SalePosReturnDetailID] [bigint] NULL,
	[SalePosDetailID] [bigint] NULL,
	[SalePosReturnID] [bigint] NULL,
	[ItemId] [int] NULL,
	[Quantity] [numeric](18, 2) NULL,
	[ItemRate] [numeric](18, 2) NULL,
	[TaxPercentage] [numeric](18, 2) NULL,
	[TaxAmount] [numeric](18, 2) NULL,
	[DiscountPercentage] [numeric](18, 2) NULL,
	[DiscountAmount] [numeric](18, 2) NULL,
	[TotalAmount] [numeric](18, 2) NULL,
	[IsLog] [bit] NULL,
	[CartonSize] [decimal](18, 3) NULL,
	[Carton] [decimal](18, 3) NULL,
	[TotalQuantity] [decimal](18, 3) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[data_SalePosReturnInfoServer]    Script Date: 3/29/2021 4:32:36 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_SalePosReturnInfoServer' AND ss.name = N'dbo')
CREATE TYPE [dbo].[data_SalePosReturnInfoServer] AS TABLE(
	[SalePosReturnID] [bigint] NULL,
	[SalePosID] [bigint] NULL,
	[EntryUserID] [int] NULL,
	[EntryUserDateTime] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyUserDateTime] [datetime] NULL,
	[CompanyID] [int] NULL,
	[FiscalID] [int] NULL,
	[SalePosReturnDate] [date] NULL,
	[WHID] [int] NULL,
	[TaxAmount] [decimal](18, 2) NULL,
	[GrossAmount] [decimal](18, 2) NULL,
	[DiscountPercentage] [decimal](18, 2) NULL,
	[DiscountAmount] [decimal](18, 2) NULL,
	[DiscountTotal] [decimal](18, 2) NULL,
	[OtherCharges] [decimal](18, 2) NULL,
	[NetAmount] [decimal](18, 2) NULL,
	[AmountReceive] [decimal](18, 2) NULL,
	[AmountReturn] [decimal](18, 2) NULL,
	[LogSourceID] [bigint] NULL,
	[AmountInAccount] [decimal](18, 2) NULL,
	[AmountReceivable] [decimal](18, 2) NULL,
	[AmountPayable] [decimal](18, 2) NULL,
	[CustomerPhone] [nvarchar](50) NULL,
	[CustomerName] [nvarchar](50) NULL,
	[SalePOSNo] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[data_StockArrivalDetail]    Script Date: 3/29/2021 4:32:36 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_StockArrivalDetail' AND ss.name = N'dbo')
CREATE TYPE [dbo].[data_StockArrivalDetail] AS TABLE(
	[TrasnferDate] [datetime] NULL,
	[Remarks] [nvarchar](max) NULL,
	[ItemID] [int] NOT NULL,
	[Itenname] [nvarchar](500) NULL,
	[UOMName] [nvarchar](250) NULL,
	[TotalPOQuantity] [numeric](18, 3) NULL,
	[UsedQuantity] [numeric](18, 3) NULL,
	[TransferToWHID] [int] NULL,
	[StockTransferDetailID] [int] NULL,
	[Remaining] [numeric](18, 3) NULL,
	[Received] [numeric](18, 3) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[data_StockArrivalManual]    Script Date: 3/29/2021 4:32:36 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_StockArrivalManual' AND ss.name = N'dbo')
CREATE TYPE [dbo].[data_StockArrivalManual] AS TABLE(
	[RowID] [int] NULL,
	[ItemID] [int] NULL,
	[Productname] [nvarchar](500) NULL,
	[Quantity] [numeric](18, 3) NULL,
	[StockRate] [numeric](18, 3) NULL,
	[NetAmount] [numeric](18, 3) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[data_StockTransferRawDetail]    Script Date: 3/29/2021 4:32:36 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_StockTransferRawDetail' AND ss.name = N'dbo')
CREATE TYPE [dbo].[data_StockTransferRawDetail] AS TABLE(
	[StockTransferDetailID] [int] NULL,
	[StockTransferID] [int] NULL,
	[ItemId] [int] NULL,
	[Quantity] [numeric](18, 3) NULL,
	[StockRate] [numeric](14, 5) NULL,
	[CartonQuantity] [numeric](18, 3) NULL,
	[LooseQuantity] [numeric](18, 3) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[POSdata_StockArrivalDetailServer]    Script Date: 3/29/2021 4:32:36 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'POSdata_StockArrivalDetailServer' AND ss.name = N'dbo')
CREATE TYPE [dbo].[POSdata_StockArrivalDetailServer] AS TABLE(
	[ArrivalIDDetailID] [int] NULL,
	[ArrivalID] [int] NULL,
	[ItemId] [int] NULL,
	[Quantity] [numeric](18, 3) NULL,
	[StockRate] [numeric](14, 5) NOT NULL,
	[CartonQuantity] [numeric](18, 3) NULL,
	[LooseQuantity] [numeric](18, 3) NULL,
	[TransferDetailID] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[POSdata_StockArrivalInfoServer]    Script Date: 3/29/2021 4:32:36 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'POSdata_StockArrivalInfoServer' AND ss.name = N'dbo')
CREATE TYPE [dbo].[POSdata_StockArrivalInfoServer] AS TABLE(
	[ArrivalID] [int] NOT NULL,
	[EntryUserID] [int] NULL,
	[EntryUserDateTime] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyUserDateTime] [datetime] NULL,
	[CompanyID] [int] NULL,
	[FiscalID] [int] NULL,
	[ArrivalDate] [date] NULL,
	[ArrivalNo] [int] NULL,
	[ArrivalFromWHID] [int] NULL,
	[ArrivalToWHID] [int] NULL,
	[FromBranchID] [int] NULL,
	[ToBranchID] [int] NULL,
	[IsTaxable] [bit] NULL,
	[AccountVoucherID] [int] NULL,
	[Remarks] [nvarchar](max) NULL,
	[RefID] [int] NULL,
	[isManual] [bit] NULL,
	[VehicleNo] [nvarchar](250) NULL,
	[ManualNo] [nvarchar](250) NULL
)
GO
/****** Object:  Table [dbo].[data_RawStockTransfer]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_RawStockTransfer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[data_RawStockTransfer](
	[StockTransferID] [int] IDENTITY(1,1) NOT NULL,
	[EntryUserID] [int] NULL,
	[EntryUserDateTime] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyUserDateTime] [datetime] NULL,
	[CompanyID] [int] NULL,
	[FiscalID] [int] NULL,
	[TransferDate] [date] NULL,
	[TransferNo] [int] NULL,
	[TransferFromWHID] [int] NULL,
	[TransferToWHID] [int] NULL,
	[FromBranchID] [int] NULL,
	[ToBranchID] [int] NULL,
	[IsTaxable] [bit] NULL,
	[AccountVoucherID] [int] NULL,
	[Remarks] [varchar](300) NULL,
	[IsStockToShed] [bit] NULL,
	[TransferToShedId] [int] NULL,
	[TransferIDRef] [int] NULL,
 CONSTRAINT [PK_data_RawStockTransfer] PRIMARY KEY CLUSTERED 
(
	[StockTransferID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[data_SalePosDetailServer]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosDetailServer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[data_SalePosDetailServer](
	[SalePosDetailID] [bigint] NULL,
	[SalePosID] [bigint] NULL,
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
	[TotalQuantity] [decimal](18, 3) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[data_SalePosInfoServer]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfoServer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[data_SalePosInfoServer](
	[SalePosID] [bigint] NOT NULL,
	[EntryUserID] [int] NULL,
	[EntryUserDateTime] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyUserDateTime] [datetime] NULL,
	[CompanyID] [int] NULL,
	[FiscalID] [int] NULL,
	[SalePosDate] [date] NULL,
	[WHID] [int] NULL,
	[TaxAmount] [decimal](18, 2) NULL,
	[GrossAmount] [decimal](18, 2) NULL,
	[DiscountPercentage] [decimal](18, 2) NULL,
	[DiscountAmount] [decimal](18, 2) NULL,
	[DiscountTotal] [decimal](18, 2) NULL,
	[OtherCharges] [decimal](18, 2) NULL,
	[NetAmount] [decimal](18, 2) NULL,
	[AmountReceive] [decimal](18, 2) NULL,
	[AmountReturn] [float] NULL,
	[SalePosReturnID] [bigint] NULL,
	[AmountInAccount] [decimal](18, 2) NULL,
	[AmountReceivable] [decimal](18, 2) NULL,
	[AmountPayable] [decimal](18, 2) NULL,
	[DirectReturn] [bit] NULL,
	[MfgID] [int] NULL,
	[CustomerPhone] [nvarchar](50) NULL,
	[CustomerName] [nvarchar](50) NULL,
	[SalePOSNo] [int] NULL,
	[isTaxable] [bit] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[data_SalePosReturnDetailServer]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosReturnDetailServer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[data_SalePosReturnDetailServer](
	[SalePosReturnDetailID] [bigint] NULL,
	[SalePosDetailID] [bigint] NULL,
	[SalePosReturnID] [bigint] NULL,
	[ItemId] [int] NULL,
	[Quantity] [numeric](18, 2) NULL,
	[ItemRate] [numeric](18, 2) NULL,
	[TaxPercentage] [numeric](18, 2) NULL,
	[TaxAmount] [numeric](18, 2) NULL,
	[DiscountPercentage] [numeric](18, 2) NULL,
	[DiscountAmount] [numeric](18, 2) NULL,
	[TotalAmount] [numeric](18, 2) NULL,
	[IsLog] [bit] NULL,
	[CartonSize] [decimal](18, 3) NULL,
	[Carton] [decimal](18, 3) NULL,
	[TotalQuantity] [decimal](18, 3) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[data_SalePosReturnInfoServer]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosReturnInfoServer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[data_SalePosReturnInfoServer](
	[SalePosReturnID] [bigint] NULL,
	[SalePosID] [bigint] NULL,
	[EntryUserID] [int] NULL,
	[EntryUserDateTime] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyUserDateTime] [datetime] NULL,
	[CompanyID] [int] NULL,
	[FiscalID] [int] NULL,
	[SalePosReturnDate] [date] NULL,
	[WHID] [int] NULL,
	[TaxAmount] [decimal](18, 2) NULL,
	[GrossAmount] [decimal](18, 2) NULL,
	[DiscountPercentage] [decimal](18, 2) NULL,
	[DiscountAmount] [decimal](18, 2) NULL,
	[DiscountTotal] [decimal](18, 2) NULL,
	[OtherCharges] [decimal](18, 2) NULL,
	[NetAmount] [decimal](18, 2) NULL,
	[AmountReceive] [decimal](18, 2) NULL,
	[AmountReturn] [decimal](18, 2) NULL,
	[LogSourceID] [bigint] NULL,
	[AmountInAccount] [decimal](18, 2) NULL,
	[AmountReceivable] [decimal](18, 2) NULL,
	[AmountPayable] [decimal](18, 2) NULL,
	[CustomerPhone] [nvarchar](50) NULL,
	[CustomerName] [nvarchar](50) NULL,
	[SalePOSNo] [int] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[data_StockArrivalDetail]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockArrivalDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[data_StockArrivalDetail](
	[ArrivalIDDetailID] [int] IDENTITY(1,1) NOT NULL,
	[ArrivalID] [int] NULL,
	[ItemId] [int] NULL,
	[Quantity] [numeric](18, 3) NULL,
	[StockRate] [numeric](14, 5) NOT NULL,
	[CartonQuantity] [numeric](18, 3) NULL,
	[LooseQuantity] [numeric](18, 3) NULL,
	[TransferDetailID] [int] NULL,
 CONSTRAINT [PK_data_StockArrivalDetail] PRIMARY KEY CLUSTERED 
(
	[ArrivalIDDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[data_StockArrivalInfo]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockArrivalInfo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[data_StockArrivalInfo](
	[ArrivalID] [int] IDENTITY(1,1) NOT NULL,
	[EntryUserID] [int] NULL,
	[EntryUserDateTime] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyUserDateTime] [datetime] NULL,
	[CompanyID] [int] NULL,
	[FiscalID] [int] NULL,
	[ArrivalDate] [date] NULL,
	[ArrivalNo] [int] NULL,
	[ArrivalFromWHID] [int] NULL,
	[ArrivalToWHID] [int] NULL,
	[FromBranchID] [int] NULL,
	[ToBranchID] [int] NULL,
	[IsTaxable] [bit] NULL,
	[AccountVoucherID] [int] NULL,
	[Remarks] [nvarchar](max) NULL,
	[RefID] [int] NULL,
	[isManual] [bit] NULL,
	[VehicleNo] [nvarchar](250) NULL,
	[ManualNo] [nvarchar](250) NULL,
 CONSTRAINT [PK_data_StockArrivalInfo_1] PRIMARY KEY CLUSTERED 
(
	[ArrivalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[data_StockTransferRawDetail]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockTransferRawDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[data_StockTransferRawDetail](
	[StockTransferDetailID] [int] NOT NULL,
	[StockTransferID] [int] NULL,
	[ItemId] [int] NULL,
	[Quantity] [numeric](18, 3) NULL,
	[StockRate] [numeric](14, 5) NULL,
	[CartonQuantity] [numeric](18, 3) NULL,
	[LooseQuantity] [numeric](18, 3) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[dataPOS_StockArrival]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dataPOS_StockArrival]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[dataPOS_StockArrival](
	[ArrivalID] [int] IDENTITY(1,1) NOT NULL,
	[EntryUserID] [int] NULL,
	[EntryUserDateTime] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyUserDateTime] [datetime] NULL,
	[CompanyID] [int] NULL,
	[FiscalID] [int] NULL,
	[ArrivalDate] [date] NULL,
	[ArrivalNo] [int] NULL,
	[ArrivalFromWHID] [int] NULL,
	[ArrivalToWHID] [int] NULL,
	[FromBranchID] [int] NULL,
	[ToBranchID] [int] NULL,
	[IsTaxable] [bit] NOT NULL,
	[AccountVoucherID] [int] NULL,
	[Remarks] [nvarchar](max) NULL,
 CONSTRAINT [PK_data_StockArrivalInfo] PRIMARY KEY CLUSTERED 
(
	[ArrivalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[pos_ServerVouchers]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pos_ServerVouchers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[pos_ServerVouchers](
	[VoucherID] [int] IDENTITY(1,1) NOT NULL,
	[WHID] [int] NULL,
	[AccountVoucherID] [int] NULL,
	[VoucherDate] [datetime] NULL,
	[VoucherSource] [nvarchar](350) NULL,
 CONSTRAINT [PK_pos_ServerVouchers] PRIMARY KEY CLUSTERED 
(
	[VoucherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[POSdata_StockArrivalDetailServer]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockArrivalDetailServer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[POSdata_StockArrivalDetailServer](
	[ArrivalIDDetailID] [int] NOT NULL,
	[ArrivalID] [int] NULL,
	[ItemId] [int] NULL,
	[Quantity] [numeric](18, 3) NULL,
	[StockRate] [numeric](14, 5) NOT NULL,
	[CartonQuantity] [numeric](18, 3) NULL,
	[LooseQuantity] [numeric](18, 3) NULL,
	[TransferDetailID] [int] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[POSdata_StockArrivalInfoServer]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockArrivalInfoServer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[POSdata_StockArrivalInfoServer](
	[ArrivalID] [int] NOT NULL,
	[EntryUserID] [int] NULL,
	[EntryUserDateTime] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyUserDateTime] [datetime] NULL,
	[CompanyID] [int] NULL,
	[FiscalID] [int] NULL,
	[ArrivalDate] [date] NULL,
	[ArrivalNo] [int] NULL,
	[ArrivalFromWHID] [int] NULL,
	[ArrivalToWHID] [int] NULL,
	[FromBranchID] [int] NULL,
	[ToBranchID] [int] NULL,
	[IsTaxable] [bit] NULL,
	[AccountVoucherID] [int] NULL,
	[Remarks] [nvarchar](max) NULL,
	[RefID] [int] NULL,
	[isManual] [bit] NULL,
	[VehicleNo] [nvarchar](250) NULL,
	[ManualNo] [nvarchar](250) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[DF_data_StockArrivalInformation_IsTaxable]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[dataPOS_StockArrival] ADD  CONSTRAINT [DF_data_StockArrivalInformation_IsTaxable]  DEFAULT ((0)) FOR [IsTaxable]
END

GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_data_StockArrivalInfo_data_StockArrivalInfo]') AND parent_object_id = OBJECT_ID(N'[dbo].[data_StockArrivalInfo]'))
ALTER TABLE [dbo].[data_StockArrivalInfo]  WITH CHECK ADD  CONSTRAINT [FK_data_StockArrivalInfo_data_StockArrivalInfo] FOREIGN KEY([ArrivalID])
REFERENCES [dbo].[data_StockArrivalInfo] ([ArrivalID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_data_StockArrivalInfo_data_StockArrivalInfo]') AND parent_object_id = OBJECT_ID(N'[dbo].[data_StockArrivalInfo]'))
ALTER TABLE [dbo].[data_StockArrivalInfo] CHECK CONSTRAINT [FK_data_StockArrivalInfo_data_StockArrivalInfo]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_data_StockArrivalInfo_gen_BranchInfo]') AND parent_object_id = OBJECT_ID(N'[dbo].[data_StockArrivalInfo]'))
ALTER TABLE [dbo].[data_StockArrivalInfo]  WITH CHECK ADD  CONSTRAINT [FK_data_StockArrivalInfo_gen_BranchInfo] FOREIGN KEY([FromBranchID])
REFERENCES [dbo].[gen_BranchInfo] ([BranchID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_data_StockArrivalInfo_gen_BranchInfo]') AND parent_object_id = OBJECT_ID(N'[dbo].[data_StockArrivalInfo]'))
ALTER TABLE [dbo].[data_StockArrivalInfo] CHECK CONSTRAINT [FK_data_StockArrivalInfo_gen_BranchInfo]
GO
/****** Object:  StoredProcedure [dbo].[data_RawStockArrival_SelectAll]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_RawStockArrival_SelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_RawStockArrival_SelectAll] AS' 
END
GO





ALTER procedure [dbo].[data_RawStockArrival_SelectAll] 
@WhereClause nvarchar(Max)
as

exec('select * from data_RawStockTransfer '+ @WhereClause)












GO
/****** Object:  StoredProcedure [dbo].[PosApi_RawMaterialStock_Insert]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PosApi_RawMaterialStock_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[PosApi_RawMaterialStock_Insert] AS' 
END
GO



ALTER procedure [dbo].[PosApi_RawMaterialStock_Insert]
@StockTransferID int output,
@data_RawStockTransfer data_RawStockTransfer  readonly
as
delete from data_RawStockTransfer
	Insert Into data_RawStockTransfer (
	 EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, TransferDate, TransferNo, TransferFromWHID, TransferToWHID, FromBranchID, ToBranchID,
                        Remarks, IsStockToShed, TransferIDRef
		)
		 Select
		UserId,
		Getdate() ,
		null ,
		null,
	 CompanyID, FiscalID, TransferDate, TransferNo, TransferFromWHID, TransferToWHID, FromBranchID, ToBranchID, 
                        Remarks, IsStockToShed,StockTransferID	From @data_RawStockTransfer
	 set @StockTransferID=@@IDENTITY
GO
/****** Object:  StoredProcedure [dbo].[POSAPI_StockRaw_Insert]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSAPI_StockRaw_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSAPI_StockRaw_Insert] AS' 
END
GO

ALTER procedure [dbo].[POSAPI_StockRaw_Insert] 
 @StockTransferID int output,
@data_StockTransferRawDetail  data_StockTransferRawDetail readonly 
as

declare @EditMode bit  = 0, @StockCheckDate date
	delete from data_StockTransferRawDetail where StockTransferID = @StockTransferID

		Insert Into data_StockTransferRawDetail(
		StockTransferDetailID,
		StockTransferID ,
		ItemId ,
		Quantity ,
		StockRate ,CartonQuantity,LooseQuantity
		) Select
		StockTransferDetailID,
		@StockTransferID ,
		ItemId ,
		Quantity ,
		StockRate ,CartonQuantity,LooseQuantity
		From @data_StockTransferRawDetail 
		
GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleandReturnInfoServer_Insert]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleandReturnInfoServer_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_SaleandReturnInfoServer_Insert] AS' 
END
GO






ALTER procedure [dbo].[POSdata_SaleandReturnInfoServer_Insert] 
@IsInserted int output ,
@data_SalePosInfoServer data_SalePosInfoServer readonly,
@data_SalePosDetailServer  data_SalePosDetailServer readonly,
@DateFrom Date=null,
@DateTo Date=null,
@CompanyID int=null,
@WHID int=null 
as


Delete from data_SalePosDetailServer where SalePosID in (Select SalePosID from data_SalePosInfoServer where WHID=@WHID and (SalePosDate between @DateFrom and @DateTo) and CompanyID=@CompanyID)
Delete from data_SalePosInfoServer  where WHID=@WHID and (SalePosDate between @DateFrom and @DateTo) and CompanyID=@CompanyID

insert into    data_SalePosInfoServer( SalePosID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, SalePosDate, WHID, TaxAmount, GrossAmount, DiscountPercentage, DiscountAmount, DiscountTotal, OtherCharges, 
                         NetAmount, AmountReceive, AmountReturn, SalePosReturnID, AmountInAccount, AmountReceivable, AmountPayable, DirectReturn, MfgID, CustomerPhone, CustomerName, SalePOSNo, isTaxable)
						 Select 
						 SalePosID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, SalePosDate, WHID, TaxAmount, GrossAmount, DiscountPercentage, DiscountAmount, DiscountTotal, OtherCharges, 
                         NetAmount, AmountReceive, AmountReturn, SalePosReturnID, AmountInAccount, AmountReceivable, AmountPayable, DirectReturn, MfgID, CustomerPhone, CustomerName, SalePOSNo, isTaxable
						 from @data_SalePosInfoServer
insert into data_SalePosDetailServer        (SalePosDetailID, SalePosID, ItemId, Quantity, ItemRate, TaxPercentage, TaxAmount, DiscountPercentage, DiscountAmount, TotalAmount, ManaufacturingID, CartonSize, Carton, TotalQuantity
)

SELECT        SalePosDetailID, SalePosID, ItemId, Quantity, ItemRate, TaxPercentage, TaxAmount, DiscountPercentage, DiscountAmount, TotalAmount, ManaufacturingID, CartonSize, Carton, TotalQuantity
FROM            @data_SalePosDetailServer


set @IsInserted=1

exec POSdata_SaleandReturnInfoServer_InsertAccount @IsInserted=@IsInserted,@data_SalePosInfoServer=@data_SalePosInfoServer,@data_SalePosDetailServer=@data_SalePosDetailServer,@DateFrom=@DateFrom,@DateTo=@DateTo,@CompanyID=@CompanyID,@WHID=@WHID



GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleandReturnInfoServer_InsertAccount]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleandReturnInfoServer_InsertAccount]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_SaleandReturnInfoServer_InsertAccount] AS' 
END
GO







ALTER procedure [dbo].[POSdata_SaleandReturnInfoServer_InsertAccount] 
@IsInserted int output ,
@data_SalePosInfoServer data_SalePosInfoServer readonly,
@data_SalePosDetailServer  data_SalePosDetailServer readonly,
@DateFrom Date=null,
@DateTo Date=null,
@CompanyID int=null,
@WHID int=null 
as

declare @TotalSaleAmount numeric(18,3), @GLvDetail as GLvDetail ,@vID int = 0 ,@FiscalID int,@RevenuePOS int,@CashPos int,@vType int=null
select @TotalSaleAmount=sum(ItemRate*Quantity) from @data_SalePosDetailServer
Select @RevenuePOS=RevenueAccountPOS,@CashPos=CashAccountPos,@FiscalID=FiscalID from gen_PosConfiguration where WHID=@WHID and CompanyID=@CompanyID


if((Select Count(*) from GLVoucherType where Title='POSCRV' and Companyid=@CompanyID)>0)
begin
	Select @vType=Voucherid from GLVoucherType  where Title='POSCRV' and Companyid=@CompanyID
end
else
begin
insert into GLVoucherType (Title,Description,SystemType,Companyid)
values('POSCRV','System Generated POS Voucher please Do not Change its title',1,@CompanyID)

Select @vType=Voucherid from GLVoucherType  where Title='POSCRV' and Companyid=@CompanyID
update gen_SystemConfiguration set POSCashVoucher=@vType
end

declare @AccountVoucherID int
Select @AccountVoucherID =AccountVoucherID from  pos_ServerVouchers where WHID=@WHID and VoucherDate=@DateFrom and VoucherSource='POSSALE'
exec GLvMAIN_delete @vId=@AccountVoucherID
insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
values(@CashPos,0,0,'Total Sale From '+Cast(@DateFrom as nvarchar(50))+' To '+ cast(@DateTo as nvarchar(50))+' ',@TotalSaleAmount)
insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,cr)
values(@RevenuePOS,0,0,'Total Sale From '+Cast(@DateFrom as nvarchar(50))+' To '+ cast(@DateTo as nvarchar(50))+' ',@TotalSaleAmount)
declare @UserId int=null,@BranchID int 
select @BranchID=BranchID from InventWareHouse where WHID=@WHID

exec GLvMAIN_Insert  @GLvDetail=@GLvDetail , @vID = @vID output ,@vType =@vType , @vDate = @DateFrom ,@vremarks ='Syncing Data Voucher ' ,@FiscalID = @FiscalID , @Comp_Id =@CompanyID,
	 @vUserID=@UserID,@TotalDr = @TotalSaleAmount , @TotalCr = @TotalSaleAmount , @ReadOnly = 1, @BranchID=@BranchID

	insert into pos_ServerVouchers(WHID, AccountVoucherID, VoucherDate, VoucherSource
) values(@WHID,@vID,@DateFrom,'POSSALE')



GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleandReturnInfoServer_SelectAll]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleandReturnInfoServer_SelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_SaleandReturnInfoServer_SelectAll] AS' 
END
GO







ALTER procedure [dbo].[POSdata_SaleandReturnInfoServer_SelectAll] 
@WhereClause nvarchar(Max),
@BoolMaster bit=0,
@DetailMaster bit=0,
@WhereClauseDetail nvarchar(Max),
@WhereClauseReturn nvarchar(Max),
@WhereClauseReturnDetail nvarchar(Max)='',
@isSales bit=1
as

if @isSales =1
begin

if(@BoolMaster=1)
begin
exec('select * from data_SalePosInfo '+ @WhereClause)
end
if (@DetailMaster=1)
begin
exec('SELECT        SalePosDetailID, data_SalePosDetail.SalePosID, ItemId, Quantity, ItemRate, TaxPercentage, data_SalePosDetail.TaxAmount, data_SalePosDetail.DiscountPercentage, data_SalePosDetail.DiscountAmount, TotalAmount, ManaufacturingID, CartonSize, Carton, TotalQuantity
FROM            data_SalePosDetail inner join data_SalePosInfo on data_SalePosInfo.SalePosID=data_SalePosDetail.SalePosID '+ @WhereClauseDetail)
end
end
else
begin
if(@BoolMaster=1)
begin
exec('select * from data_SalePosReturnInfo '+ @WhereClauseReturn)
end
if (@DetailMaster=1)
begin
exec('SELECT        SalePosReturnDetailID, SalePosDetailID, data_SalePosReturnDetail.SalePosReturnID, ItemId, Quantity, ItemRate, TaxPercentage, data_SalePosReturnDetail.TaxAmount, data_SalePosReturnDetail.DiscountPercentage, data_SalePosReturnDetail.DiscountAmount, TotalAmount, IsLog, CartonSize, Carton, TotalQuantity
FROM            data_SalePosReturnDetail inner join data_SalePosReturnInfo on data_SalePosReturnInfo.SalePosReturnID=data_SalePosReturnDetail.SalePosReturnID '+ @WhereClauseReturn)
end

end












GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleReturnInfoServer_Insert]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleReturnInfoServer_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_SaleReturnInfoServer_Insert] AS' 
END
GO







ALTER procedure [dbo].[POSdata_SaleReturnInfoServer_Insert] 
@IsInserted int output ,
@data_SalePosReturnInfoServer data_SalePosReturnInfoServer readonly,
@data_SalePosReturnDetailServer  data_SalePosReturnDetailServer readonly,
@DateFrom Date=null,
@DateTo Date=null,
@CompanyID int=null,
@WHID int=null 
as


Delete from data_SalePosReturnDetailServer where SalePosReturnID in (Select SalePosReturnID from data_SalePosReturnInfoServer where WHID=@WHID and (SalePosReturnDate between @DateFrom and @DateTo) and CompanyID=@CompanyID)
Delete from data_SalePosReturnInfoServer  where WHID=@WHID and (SalePosReturnDate between @DateFrom and @DateTo) and CompanyID=@CompanyID

insert into    data_SalePosReturnInfoServer(   SalePosReturnID, SalePosID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, SalePosReturnDate, WHID, TaxAmount, GrossAmount, DiscountPercentage, DiscountAmount, 
                         DiscountTotal, OtherCharges, NetAmount, AmountReceive, AmountReturn, LogSourceID, AmountInAccount, AmountReceivable, AmountPayable, CustomerPhone, CustomerName, SalePOSNo)
						 Select 
						  SalePosReturnID, SalePosID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, SalePosReturnDate, WHID, TaxAmount, GrossAmount, DiscountPercentage, DiscountAmount, 
                         DiscountTotal, OtherCharges, NetAmount, AmountReceive, AmountReturn, LogSourceID, AmountInAccount, AmountReceivable, AmountPayable, CustomerPhone, CustomerName, SalePOSNo
						 from @data_SalePosReturnInfoServer
insert into data_SalePosReturnDetailServer        (SalePosReturnDetailID, SalePosDetailID, SalePosReturnID, ItemId, Quantity, ItemRate, TaxPercentage, TaxAmount, DiscountPercentage, DiscountAmount, TotalAmount, IsLog, CartonSize, Carton, TotalQuantity
)

SELECT      SalePosReturnDetailID, SalePosDetailID, SalePosReturnID, ItemId, Quantity, ItemRate, TaxPercentage, TaxAmount, DiscountPercentage, DiscountAmount, TotalAmount, IsLog, CartonSize, Carton, TotalQuantity
FROM            @data_SalePosReturnDetailServer


set @IsInserted=1

exec POSdata_SaleReturnInfoServer_InsertAccount @IsInserted=@IsInserted,@data_SalePosReturnInfoServer=@data_SalePosReturnInfoServer,@data_SalePosReturnDetailServer=@data_SalePosReturnDetailServer,@DateFrom=@DateFrom,@DateTo=@DateTo,@CompanyID=@CompanyID,@WHID=@WHID




GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleReturnInfoServer_InsertAccount]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleReturnInfoServer_InsertAccount]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_SaleReturnInfoServer_InsertAccount] AS' 
END
GO







ALTER procedure [dbo].[POSdata_SaleReturnInfoServer_InsertAccount] 
@IsInserted int output ,
@data_SalePosReturnInfoServer data_SalePosReturnInfoServer readonly,
@data_SalePosReturnDetailServer  data_SalePosReturnDetailServer readonly,
@DateFrom Date=null,
@DateTo Date=null,
@CompanyID int=null,
@WHID int=null 
as

declare @TotalSaleAmount numeric(18,3), @GLvDetail as GLvDetail ,@vID int = 0 ,@FiscalID int,@RevenuePOS int,@CashPos int,@vType int=null
select @TotalSaleAmount=sum(ItemRate*Quantity) from @data_SalePosReturnDetailServer
Select @RevenuePOS=RevenueAccountPOS,@CashPos=CashAccountPos,@FiscalID=FiscalID from gen_PosConfiguration where WHID=@WHID and CompanyID=@CompanyID


if((Select Count(*) from GLVoucherType where Title='POSCPV' and Companyid=@CompanyID)>0)
begin
	Select @vType=Voucherid from GLVoucherType  where Title='POSCPV' and Companyid=@CompanyID
end
else
begin
insert into GLVoucherType (Title,Description,SystemType,Companyid)
values('POSCPV','System Generated POS Return Voucher please Do not Change its title',1,@CompanyID)

Select @vType=Voucherid from GLVoucherType  where Title='POSCPV' and Companyid=@CompanyID

end

declare @AccountVoucherID int
Select @AccountVoucherID =AccountVoucherID from  pos_ServerVouchers where WHID=@WHID and VoucherDate=@DateFrom and VoucherSource='POSSALERETURN'
exec GLvMAIN_delete @vId=@AccountVoucherID
insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,cr)
values(@CashPos,0,0,'Total Sale Return From '+Cast(@DateFrom as nvarchar(50))+' To '+ cast(@DateTo as nvarchar(50))+' ',@TotalSaleAmount)
insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
values(@RevenuePOS,0,0,'Total Sale Return From '+Cast(@DateFrom as nvarchar(50))+' To '+ cast(@DateTo as nvarchar(50))+' ',@TotalSaleAmount)
declare @UserId int=null,@BranchID int 
select @BranchID=BranchID from InventWareHouse where WHID=@WHID

exec GLvMAIN_Insert  @GLvDetail=@GLvDetail , @vID = @vID output ,@vType =@vType , @vDate = @DateFrom ,@vremarks ='Syncing Data Voucher ' ,@FiscalID = @FiscalID , @Comp_Id =@CompanyID,
	 @vUserID=@UserID,@TotalDr = @TotalSaleAmount , @TotalCr = @TotalSaleAmount , @ReadOnly = 1, @BranchID=@BranchID

	insert into pos_ServerVouchers(WHID, AccountVoucherID, VoucherDate, VoucherSource
) values(@WHID,@vID,@DateFrom,'POSSALERETURN')



GO
/****** Object:  StoredProcedure [dbo].[POSdata_StockArrival_delete]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockArrival_delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_StockArrival_delete] AS' 
END
GO


ALTER procedure [dbo].[POSdata_StockArrival_delete] @ArrivalID int  as

	declare @AccountVoucherID int
	

	declare @ProductInflowSourceIDTable as data_ProductInflow, @ItemsWarehouseBatchWise as ItemsWarehouseBatchWise,@PurchaseDate date , 
	@CompanyID int , @IsTaxable bit = 0
	
	select @PurchaseDate=ArrivalDate , @AccountVoucherID = AccountVoucherID , @CompanyID = CompanyID ,
	 @IsTaxable = IsTaxable from  data_StockArrivalInfo where ArrivalID = @ArrivalID

	insert into @ProductInflowSourceIDTable (SourceID)
	select ArrivalIDDetailID from data_StockArrivalDetail where ArrivalID = @ArrivalID

	
	update data_ProductInflow set IsDeleted = 1 where SourceName = 'POSSTOCK IN' and SourceID in (select SourceID from @ProductInflowSourceIDTable )

	declare @ErrorMsg varchar(200) 
	set @ErrorMsg = ''
	exec CheckDeletedStock 'POSSTOCK IN', @ItemsWarehouseBatchWise , @ProductInflowSourceIDTable , @PurchaseDate , @ErrorMsg output , @CompanyID , @IsTaxable
	if @ErrorMsg <> ''
	BEGIN
		RAISERROR (@ErrorMsg ,16 , 1);
		return
	END
	
	delete from data_ProductInflow where SourceName =  'POSSTOCK IN'  AND SourceID in (select SourceID from  @ProductInflowSourceIDTable )	
	
	
	delete from data_StockArrivalDetail where ArrivalID =  @ArrivalID
	delete from data_StockArrivalInfo where ArrivalID = @ArrivalID
	

	
	








GO
/****** Object:  StoredProcedure [dbo].[POSdata_StockArrivalInfo_Insert]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockArrivalInfo_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_StockArrivalInfo_Insert] AS' 
END
GO



ALTER procedure [dbo].[POSdata_StockArrivalInfo_Insert] 
@ArrivalID int  output, 
@RefID int = null, 
@UserID int=null,
@CompanyID int = null, 
@FiscalID int = null,
@ArrivalDate date = null,
@ArrivalNo int=null, 
@IsTaxable bit=0,
@VehicleNo nvarchar(250)=null,
@ManualNo nvarchar(250)=null,

@data_StockArrivalDetail  data_StockArrivalDetail readonly 
as

declare @EditMode bit  = 0, @StockCheckDate date,@TransferToWHID int=null, @ToBranchID int=null
select @TransferToWHID=TransferToWHID,@ToBranchID=ToBranchID from data_RawStockTransfer where TransferIDRef=@RefID

if	 @ArrivalID = 0
BEGIN
	declare @MaxTable as MaxTable

	insert into @MaxTable	
	exec GetVoucherNoI @Fieldname=N'ArrivalNo',@TableName=N'data_StockArrivalInfo',@CheckTaxable= 1 ,@PrimaryKeyValue = @ArrivalID,@PrimaryKeyFieldName = '@ArrivalID' ,
	@voucherDate=@ArrivalDate,@voucherDateFieldName=N'ArrivalDate',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=@FiscalID, 
	@FiscalIDFieldName=N'FiscalID',@IsTaxable=0
	
	select @ArrivalNo = VoucherNo from @MaxTable


	set @StockCheckDate = @ArrivalDate

	Insert into data_StockArrivalInfo ( 
		EntryUserID , 
		EntryUserDateTime , 
		CompanyID , 
		FiscalID ,
		ArrivalDate , 
		ArrivalNo , 
	
	RefID,
		
		IsTaxable 
		,ArrivalToWHID,
		ToBranchID,
		ManualNo,
		VehicleNo
	

	 ) Values (
		@UserID , 
		GETDATE() ,
		@CompanyID , 
		@FiscalID ,
		@ArrivalDate , 
		@ArrivalNo,
		@RefID,
		@IsTaxable,
		@TransferToWHID,
		@ToBranchID,
		@ManualNo,
		@VehicleNo
	
	)	
	set @ArrivalID = @@IDENTITY
	
END

ELSE

BEGIN	


declare @SaveVoucherdate date , @IsVoucherNoMonthly bit
select @IsVoucherNoMonthly = IsVoucherNoMonthly from gen_SystemConfiguration where CompanyID =  @CompanyID

if @IsVoucherNoMonthly = 1
BEGIN
	select @SaveVoucherdate = ArrivalDate from data_StockArrivalInfo where ArrivalID = @ArrivalID

	if MONTH(@ArrivalDate) <> MONTH(@SaveVoucherdate) or  YEAR(@ArrivalDate) <> YEAR(@SaveVoucherdate)
	BEGIN
		insert into @MaxTable
			exec GetVoucherNoI @Fieldname=N'ArrivalNo',@TableName=N'data_StockArrivalInfo',@CheckTaxable= 1 ,@PrimaryKeyValue = @ArrivalID,@PrimaryKeyFieldName = '@ArrivalID' ,
			@voucherDate=@ArrivalDate,@voucherDateFieldName=N'ArrivalDate',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=@FiscalID, 
				@FiscalIDFieldName=N'FiscalID',@IsTaxable=0
	
		select @ArrivalNo = VoucherNo from @MaxTable

	END
END

	select @StockCheckDate = TransferDate from data_arrivalDate where arrivalID = @ArrivalID

	if @StockCheckDate > @ArrivalDate
	BEGIN
		set @StockCheckDate = @ArrivalDate
	END


	update data_StockArrivalInfo set	
	ModifyUserID = @UserID , 
	ModifyUserDateTime = GETDATE() , 
	CompanyID = @CompanyID , 
	FiscalID = @FiscalID ,
	ArrivalDate = @ArrivalDate , 
	ArrivalNo = @ArrivalNo  ,
	ArrivalToWHID=@TransferToWHID,ToBranchID=@ToBranchID,
	ManualNo=@ManualNo,
	VehicleNo=@VehicleNo
	where ArrivalID = @ArrivalID


	declare @ProductInflowSourceIDTable as data_ProductInflow	, @ItemsWarehouseBatchWise as ItemsWarehouseBatchWise
	insert into @ProductInflowSourceIDTable (SourceID) select ArrivalIDDetailID from data_StockArrivalDetail where ArrivalID = @ArrivalID



	update data_ProductInflow set IsDeleted = 1 where SourceName = 'POSSTOCK IN' and SourceID in (select SourceID from @ProductInflowSourceIDTable )
	
	
	delete from data_StockArrivalDetail where ArrivalID = @arrivalID
	set	@EditMode = 1
END
	

declare @RowID int,@ArrivalIDDetailID int ,@StockRate numeric(14,5) , @Quantity numeric(10,2),@ItemId int,@stockQty numeric(14,2),
@ItemName varchar(200),@ERRORMSG varchar(200)

 
--declare @jj as xml = (select * from @data_StockTransferDetail for xml auto)

declare firstcursor cursor for
select StockTransferDetailID from @data_StockArrivalDetail
open firstcursor
fetch next from firstcursor into @RowID
while @@FETCH_STATUS = 0
	begin
		declare @checkRate bit = 1
		select @ItemId = ItemId, @Quantity = Received  From @data_StockArrivalDetail  where StockTransferDetailID = @RowID
	Select @StockRate =StockRate from data_StockTransferRawDetail where StockTransferDetailID=@RowID

		Insert Into data_StockArrivalDetail (
		ArrivalID ,
		ItemId ,
		Quantity ,
		StockRate ,CartonQuantity,LooseQuantity,TransferDetailID
		) Select
		@ArrivalID ,
		ItemId ,
		Received ,
		@StockRate ,0,Received,StockTransferDetailID
		From @data_StockArrivalDetail where StockTransferDetailID = @RowID

		set @ArrivalIDDetailID = @@IDENTITY	
			
		
		declare @productInflowID int,@ProductOutflowID int

		
	
	

		exec data_ProductInflow_Insert @productInflowID output,@ItemId,@ArrivalIDDetailID,'POSSTOCK IN',@TransferToWHID, 
		@ArrivalDate ,@StockRate,@Quantity,@Quantity ,@FiscalID , @CompanyID , @IsTaxable,null,null,null,null,null,@ToBranchID,null

		select  @productInflowID as ProductInflowID,'POSSTOCK IN' as SourceName into #tempIn
		

	drop table #tempIn;

	FETCH NEXT FROM firstcursor INTO @RowID
	END

close firstcursor
deallocate firstcursor


--check Stock Available Or not of Inserted Item
if @EditMode = 1
BEGIN	
	set @ErrorMsg = ''
	exec CheckDeletedStock 'POSSTOCK IN', @ItemsWarehouseBatchWise , @ProductInflowSourceIDTable , @StockCheckDate , @ErrorMsg output, 
	@CompanyID , @IsTaxable
	if @ErrorMsg <> ''
	BEGIN
		RAISERROR (@ErrorMsg ,16 , 1);
		return
	END
	
	delete from data_ProductInflow where SourceName =  'POSSTOCK IN'  AND SourceID in (select SourceID from  @ProductInflowSourceIDTable ) and IsDeleted = 1
END





GO
/****** Object:  StoredProcedure [dbo].[POSdata_StockArrivalInfo_SelectAll]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockArrivalInfo_SelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_StockArrivalInfo_SelectAll] AS' 
END
GO






ALTER procedure [dbo].[POSdata_StockArrivalInfo_SelectAll] 
@WhereClause nvarchar(Max),
@BoolMaster bit=0,
@DetailMaster bit=0,
@WhereClauseDetail nvarchar(Max)
as

if(@BoolMaster=1)
begin
exec('select * from data_StockArrivalInfo '+ @WhereClause)
end
if (@DetailMaster=1)
begin
exec('SELECT        ArrivalIDDetailID, data_StockArrivalDetail.ArrivalID, ItemId, Quantity, StockRate, CartonQuantity, LooseQuantity, TransferDetailID
FROM            data_StockArrivalDetail inner join data_StockArrivalInfo on data_StockArrivalInfo.ArrivalID=data_StockArrivalDetail.ArrivalID '+ @WhereClauseDetail)
end













GO
/****** Object:  StoredProcedure [dbo].[POSdata_StockArrivalInfoServer_Insert]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockArrivalInfoServer_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_StockArrivalInfoServer_Insert] AS' 
END
GO





ALTER procedure [dbo].[POSdata_StockArrivalInfoServer_Insert] 
@IsInserted int output ,
@POSdata_StockArrivalInfoServer POSdata_StockArrivalInfoServer readonly,
@POSdata_StockArrivalDetailServer  POSdata_StockArrivalDetailServer readonly 
as

Delete from POSdata_StockArrivalInfoServer where POSdata_StockArrivalInfoServer.ArrivalID in (Select ArrivalID from @POSdata_StockArrivalInfoServer)
Delete from POSdata_StockArrivalDetailServer where POSdata_StockArrivalDetailServer.ArrivalIDDetailID in (Select ArrivalIDDetailID from @POSdata_StockArrivalDetailServer)

insert into POSdata_StockArrivalInfoServer ( ArrivalID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, ArrivalDate, ArrivalNo, ArrivalFromWHID, ArrivalToWHID, FromBranchID, ToBranchID, IsTaxable, AccountVoucherID, 
                         Remarks, RefID, isManual, VehicleNo, ManualNo)
						 select  ArrivalID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, ArrivalDate, ArrivalNo, ArrivalFromWHID, ArrivalToWHID, FromBranchID, ToBranchID, IsTaxable, AccountVoucherID, 
                         Remarks, RefID, isManual, VehicleNo, ManualNo from @POSdata_StockArrivalInfoServer

insert into POSdata_StockArrivalDetailServer       ( ArrivalIDDetailID, ArrivalID, ItemId, Quantity, StockRate, CartonQuantity, LooseQuantity, TransferDetailID
)
Select ArrivalIDDetailID, ArrivalID, ItemId, Quantity, StockRate, CartonQuantity, LooseQuantity, TransferDetailID FROM            @POSdata_StockArrivalDetailServer

set @IsInserted=1


GO
/****** Object:  StoredProcedure [dbo].[POSdata_StockArrivalManualInfo_Insert]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockArrivalManualInfo_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_StockArrivalManualInfo_Insert] AS' 
END
GO



ALTER procedure [dbo].[POSdata_StockArrivalManualInfo_Insert] 
@ArrivalID int  output, 
@RefID int = null, 
@UserID int=null,
@CompanyID int = null, 
@FiscalID int = null,
@ArrivalDate date = null,
@ArrivalNo int=null, 
@IsTaxable bit=0,
@TransferToWHID int=0,
@ToBranchID int=null,
@VehicleNo nvarchar(250)=null,
@ManualNo nvarchar(250)=null,
@Remarks nvarchar(Max)=null,

@data_StockArrivalManual  data_StockArrivalManual readonly 
as

declare @EditMode bit  = 0, @StockCheckDate date 
if	 @ArrivalID = 0
BEGIN
	declare @MaxTable as MaxTable

	insert into @MaxTable	
	exec GetVoucherNoI @Fieldname=N'ArrivalNo',@TableName=N'data_StockArrivalInfo',@CheckTaxable= 1 ,@PrimaryKeyValue = @ArrivalID,@PrimaryKeyFieldName = '@ArrivalID' ,
	@voucherDate=@ArrivalDate,@voucherDateFieldName=N'ArrivalDate',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=@FiscalID, 
	@FiscalIDFieldName=N'FiscalID',@IsTaxable=0
	
	select @ArrivalNo = VoucherNo from @MaxTable


	set @StockCheckDate = @ArrivalDate

	Insert into data_StockArrivalInfo ( 
		EntryUserID , 
		EntryUserDateTime , 
		CompanyID , 
		FiscalID ,
		ArrivalDate , 
		ArrivalNo , 
	
	RefID,
		
		IsTaxable 
		,ArrivalToWHID,
		ToBranchID,
		isManual,
		ManualNo,
		VehicleNo,
		Remarks
	

	 ) Values (
		@UserID , 
		GETDATE() ,
		@CompanyID , 
		@FiscalID ,
		@ArrivalDate , 
		@ArrivalNo,
		@RefID,
		@IsTaxable,
		@TransferToWHID,
		@ToBranchID,
		1,
		@ManualNo,
		@VehicleNo,
		@Remarks
	
	)	
	set @ArrivalID = @@IDENTITY
	
END

ELSE

BEGIN	


declare @SaveVoucherdate date , @IsVoucherNoMonthly bit
select @IsVoucherNoMonthly = IsVoucherNoMonthly from gen_SystemConfiguration where CompanyID =  @CompanyID

if @IsVoucherNoMonthly = 1
BEGIN
	select @SaveVoucherdate = ArrivalDate from data_StockArrivalInfo where ArrivalID = @ArrivalID

	if MONTH(@ArrivalDate) <> MONTH(@SaveVoucherdate) or  YEAR(@ArrivalDate) <> YEAR(@SaveVoucherdate)
	BEGIN
		insert into @MaxTable
			exec GetVoucherNoI @Fieldname=N'ArrivalNo',@TableName=N'data_StockArrivalInfo',@CheckTaxable= 1 ,@PrimaryKeyValue = @ArrivalID,@PrimaryKeyFieldName = '@ArrivalID' ,
			@voucherDate=@ArrivalDate,@voucherDateFieldName=N'ArrivalDate',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=@FiscalID, 
				@FiscalIDFieldName=N'FiscalID',@IsTaxable=0
	
		select @ArrivalNo = VoucherNo from @MaxTable

	END
END

	select @StockCheckDate = ArrivalDate from data_StockArrivalInfo where arrivalID = @ArrivalID

	if @StockCheckDate > @ArrivalDate
	BEGIN
		set @StockCheckDate = @ArrivalDate
	END


	update data_StockArrivalInfo set	
	ModifyUserID = @UserID , 
	ModifyUserDateTime = GETDATE() , 
	CompanyID = @CompanyID , 
	FiscalID = @FiscalID ,
	ArrivalDate = @ArrivalDate , 
	ArrivalNo = @ArrivalNo  ,
	ArrivalToWHID=@TransferToWHID,ToBranchID=@ToBranchID,
	isManual=1,
	ManualNo=@ManualNo,
	VehicleNo=@VehicleNo,
	Remarks=@Remarks
	where ArrivalID = @ArrivalID


	declare @ProductInflowSourceIDTable as data_ProductInflow	, @ItemsWarehouseBatchWise as ItemsWarehouseBatchWise
	insert into @ProductInflowSourceIDTable (SourceID) select ArrivalIDDetailID from data_StockArrivalDetail where ArrivalID = @ArrivalID



	update data_ProductInflow set IsDeleted = 1 where SourceName = 'POSSTOCK IN' and SourceID in (select SourceID from @ProductInflowSourceIDTable )
	
	
	delete from data_StockArrivalDetail where ArrivalID = @arrivalID
	set	@EditMode = 1
END
	

declare @RowID int,@ArrivalIDDetailID int ,@StockRate numeric(14,5) , @Quantity numeric(10,2),@ItemId int,@stockQty numeric(14,2),
@ItemName varchar(200),@ERRORMSG varchar(200)

 
--declare @jj as xml = (select * from @data_StockTransferDetail for xml auto)

declare firstcursor cursor for
select RowID from @data_StockArrivalManual
open firstcursor
fetch next from firstcursor into @RowID
while @@FETCH_STATUS = 0
	begin
		declare @checkRate bit = 1
	
		Insert Into data_StockArrivalDetail (
		ArrivalID ,
		ItemId ,
		Quantity ,
		StockRate ,CartonQuantity,LooseQuantity,TransferDetailID
		) Select
		@ArrivalID ,
		ItemId ,
		Quantity ,
		StockRate ,0,		Quantity ,0
		From @data_StockArrivalManual where RowID = @RowID

		set @ArrivalIDDetailID = @@IDENTITY	
			
		
		declare @productInflowID int,@ProductOutflowID int

		Select @StockRate=Stockrate,@Quantity=Quantity,@ItemId=ItemID,@ItemName=Productname From @data_StockArrivalManual where RowID = @RowID
	
	

		exec data_ProductInflow_Insert @productInflowID output,@ItemId,@ArrivalIDDetailID,'POSSTOCK IN',@TransferToWHID, 
		@ArrivalDate ,@StockRate,@Quantity,@Quantity ,@FiscalID , @CompanyID , @IsTaxable,null,null,null,null,null,@ToBranchID,null

		select  @productInflowID as ProductInflowID,'POSSTOCK IN' as SourceName into #tempIn
		

	drop table #tempIn;

	FETCH NEXT FROM firstcursor INTO @RowID
	END

close firstcursor
deallocate firstcursor


--check Stock Available Or not of Inserted Item
if @EditMode = 1
BEGIN	
	set @ErrorMsg = ''
	exec CheckDeletedStock 'POSSTOCK IN', @ItemsWarehouseBatchWise , @ProductInflowSourceIDTable , @StockCheckDate , @ErrorMsg output, 
	@CompanyID , @IsTaxable
	if @ErrorMsg <> ''
	BEGIN
		RAISERROR (@ErrorMsg ,16 , 1);
		return
	END
	
	delete from data_ProductInflow where SourceName =  'POSSTOCK IN'  AND SourceID in (select SourceID from  @ProductInflowSourceIDTable ) and IsDeleted = 1
END





GO
/****** Object:  StoredProcedure [dbo].[POSData_StockInwardRem_load]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSData_StockInwardRem_load]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSData_StockInwardRem_load] AS' 
END
GO
ALTER procedure [dbo].[POSData_StockInwardRem_load] 
@WhereClause varchar(4000),
@EditClause varchar(2000)

as


exec('
select  *,(TotalPOQuantity-UsedQuantity) as Remaining,(TotalPOQuantity-UsedQuantity) as Received from (select data_RawStockTransfer.TransferDate,data_RawStockTransfer.Remarks, data_StockTransferRawDetail.ItemId,InventItems.ItenName,InventUOM.UOMName, data_StockTransferRawDetail.Quantity as TotalPOQuantity,
isnull((select sum(b.Quantity)  from data_StockArrivalDetail b where b.TransferDetailID  =
 data_StockTransferRawDetail.StockTransferDetailID  '+ @EditClause +'

),0) as UsedQuantity,
data_RawStockTransfer.TransferToWHID,data_StockTransferRawDetail.StockTransferDetailID
from data_RawStockTransfer inner join data_StockTransferRawDetail on data_RawStockTransfer.TransferIDRef = data_StockTransferRawDetail.stockTransferID 
left join InventItems on InventItems.ItemId=data_StockTransferRawDetail.ItemId 
 left join InventUOM on InventUOM.UOMId=InventItems.UOMId 
' + @WhereClause + ') a where TotalPOQuantity-UsedQuantity > 0')

 



 



GO
/****** Object:  StoredProcedure [dbo].[POSData_StockRawTrasnfer_load]    Script Date: 3/29/2021 4:32:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSData_StockRawTrasnfer_load]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSData_StockRawTrasnfer_load] AS' 
END
GO

ALTER procedure [dbo].[POSData_StockRawTrasnfer_load] 
@WhereClause varchar(4000),
@EditClause varchar(2000)

as


exec('
select  StockTransferID,Format(TransferDate,''dd-MMM-yyyy'') as TrasnferDate,TransferNo,WHDesc,Remarks from (select WHDesc,data_RawStockTransfer.TransferNo,data_RawStockTransfer.TransferIDRef as StockTransferID,data_RawStockTransfer.TransferDate,data_RawStockTransfer.Remarks, data_StockTransferRawDetail.ItemId,InventItems.ItenName,InventUOM.UOMName, isnull(data_StockTransferRawDetail.Quantity,1000) as TotalPOQuantity,
isnull((select sum(b.Quantity)  from data_StockArrivalDetail b where b.TransferDetailID  =
 data_StockTransferRawDetail.StockTransferDetailID  '+ @EditClause +'

),0) as UsedQuantity,
data_RawStockTransfer.TransferToWHID,data_StockTransferRawDetail.StockTransferDetailID
from data_RawStockTransfer left join data_StockTransferRawDetail on data_RawStockTransfer.TransferIDRef = data_StockTransferRawDetail.stockTransferID 
left join InventItems on InventItems.ItemId=data_StockTransferRawDetail.ItemId 
left join InventWareHouse on InventWareHouse.WHID=data_RawStockTransfer.TransferToWHID
 left join InventUOM on InventUOM.UOMId=InventItems.UOMId 
' + @WhereClause + ') a where TotalPOQuantity-UsedQuantity > 0')

 



 




GO
