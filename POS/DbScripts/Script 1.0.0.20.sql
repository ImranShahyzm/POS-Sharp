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
ALTER TABLE dbo.data_StockTransferRawDetail ADD
	ItemCode nvarchar(250) NULL,
	ItemName nvarchar(250) NULL
GO
ALTER TABLE dbo.data_StockTransferRawDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


/****** Object:  StoredProcedure [dbo].[POSAPI_StockRaw_Insert]    Script Date: 5/4/2021 11:31:21 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSAPI_StockRaw_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSAPI_StockRaw_Insert]
GO
/****** Object:  UserDefinedTableType [dbo].[data_StockTransferRawDetail]    Script Date: 5/4/2021 11:31:21 AM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_StockTransferRawDetail' AND ss.name = N'dbo')
DROP TYPE [dbo].[data_StockTransferRawDetail]
GO
/****** Object:  UserDefinedTableType [dbo].[data_StockTransferRawDetail]    Script Date: 5/4/2021 11:31:21 AM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_StockTransferRawDetail' AND ss.name = N'dbo')
CREATE TYPE [dbo].[data_StockTransferRawDetail] AS TABLE(
	[StockTransferDetailID] [int] NULL,
	[StockTransferID] [int] NULL,
	[ItemId] [int] NULL,
	[Quantity] [numeric](18, 3) NULL,
	[StockRate] [numeric](14, 5) NULL,
	[CartonQuantity] [numeric](18, 3) NULL,
	[LooseQuantity] [numeric](18, 3) NULL,
	ItemCode nvarchar(250) NULL,
	ItemName nvarchar(250) NULL
)
GO
/****** Object:  StoredProcedure [dbo].[POSAPI_StockRaw_Insert]    Script Date: 5/4/2021 11:31:21 AM ******/
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
		StockRate ,CartonQuantity,LooseQuantity,ItemCode,
	ItemName
		) Select
		StockTransferDetailID,
		@StockTransferID ,
		ItemId ,
		Quantity ,
		StockRate ,CartonQuantity,LooseQuantity,
		ItemCode,
	ItemName
		From @data_StockTransferRawDetail 
		
GO
