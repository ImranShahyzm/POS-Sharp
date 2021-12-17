
IF NOT EXISTS (SELECT 1 FROM sys.columns 
				WHERE name = N'ISFbrConnectivity' 
				and object_id = object_id(N'dbo.gen_PosConfiguration'))
BEGIN
BEGIN TRANSACTION
	ALTER TABLE dbo.gen_PosConfiguration ADD
	ISFbrConnectivity int NULL
COMMIT
END
GO



IF NOT EXISTS (SELECT 1 FROM sys.columns 
				WHERE name = N'USIN' 
				and object_id = object_id(N'dbo.gen_PosConfiguration'))
BEGIN
BEGIN TRANSACTION
	ALTER TABLE dbo.gen_PosConfiguration ADD
	USIN nvarchar(50) NULL
COMMIT
END
GO


IF NOT EXISTS (SELECT 1 FROM sys.columns 
				WHERE name = N'POSID' 
				and object_id = object_id(N'dbo.gen_PosConfiguration'))
BEGIN
BEGIN TRANSACTION
	ALTER TABLE dbo.gen_PosConfiguration ADD
	POSID bigInt NULL
COMMIT
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns 
				WHERE name = N'BillPreFix' 
				and object_id = object_id(N'dbo.gen_PosConfiguration'))
BEGIN
BEGIN TRANSACTION
	ALTER TABLE dbo.gen_PosConfiguration ADD
	BillPreFix nvarchar(50) NULL
COMMIT
END
GO




/****** Object:  StoredProcedure [dbo].[rpt_Fbr_sale_invoice]    Script Date: 12/17/2021 7:31:01 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpt_Fbr_sale_invoice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpt_Fbr_sale_invoice]
GO
/****** Object:  StoredProcedure [dbo].[FBR_InvoiceMasterSelectAll]    Script Date: 12/17/2021 7:31:01 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FBR_InvoiceMasterSelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[FBR_InvoiceMasterSelectAll]
GO
/****** Object:  StoredProcedure [dbo].[Fbr_InvoiceMaster_Insert]    Script Date: 12/17/2021 7:31:01 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fbr_InvoiceMaster_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Fbr_InvoiceMaster_Insert]
GO
/****** Object:  Table [dbo].[FBR_InvoiceMaster]    Script Date: 12/17/2021 7:31:01 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FBR_InvoiceMaster]') AND type in (N'U'))
DROP TABLE [dbo].[FBR_InvoiceMaster]
GO
/****** Object:  Table [dbo].[FBR_InvoiceDetail]    Script Date: 12/17/2021 7:31:01 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FBR_InvoiceDetail]') AND type in (N'U'))
DROP TABLE [dbo].[FBR_InvoiceDetail]
GO
/****** Object:  UserDefinedTableType [dbo].[FBR_InvoiceDetail]    Script Date: 12/17/2021 7:31:01 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'FBR_InvoiceDetail' AND ss.name = N'dbo')
DROP TYPE [dbo].[FBR_InvoiceDetail]
GO
/****** Object:  UserDefinedTableType [dbo].[FBR_InvoiceDetail]    Script Date: 12/17/2021 7:31:01 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'FBR_InvoiceDetail' AND ss.name = N'dbo')
CREATE TYPE [dbo].[FBR_InvoiceDetail] AS TABLE(
	[SIDDetailID] [int] NULL,
	[SID] [int] NULL,
	[ItemCode] [varchar](50) NOT NULL,
	[ItemName] [varchar](150) NULL,
	[PCTCode] [varchar](8) NOT NULL,
	[Quantity] [numeric](18, 3) NOT NULL,
	[TaxRate] [numeric](18, 3) NOT NULL,
	[SaleValue] [numeric](18, 3) NULL,
	[Discount] [numeric](18, 3) NULL,
	[FurtherTax] [numeric](18, 3) NULL,
	[TaxCharged] [numeric](18, 3) NULL,
	[TotalAmount] [numeric](18, 3) NULL,
	[InvoiceType] [int] NULL,
	[RefUSIN] [varchar](50) NULL
)
GO
/****** Object:  Table [dbo].[FBR_InvoiceDetail]    Script Date: 12/17/2021 7:31:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FBR_InvoiceDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FBR_InvoiceDetail](
	[SIDDetailID] [int] IDENTITY(1,1) NOT NULL,
	[SID] [int] NULL,
	[ItemCode] [varchar](50) NOT NULL,
	[ItemName] [varchar](150) NULL,
	[PCTCode] [varchar](8) NOT NULL,
	[Quantity] [numeric](18, 3) NOT NULL,
	[TaxRate] [numeric](18, 3) NOT NULL,
	[SaleValue] [numeric](18, 3) NULL,
	[Discount] [numeric](18, 3) NULL,
	[FurtherTax] [numeric](18, 3) NULL,
	[TaxCharged] [numeric](18, 3) NULL,
	[TotalAmount] [numeric](18, 3) NULL,
	[InvoiceType] [int] NULL,
	[RefUSIN] [varchar](50) NULL,
 CONSTRAINT [PK_FBR_InvoiceDetail] PRIMARY KEY CLUSTERED 
(
	[SIDDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FBR_InvoiceMaster]    Script Date: 12/17/2021 7:31:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FBR_InvoiceMaster]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FBR_InvoiceMaster](
	[SID] [int] IDENTITY(1,1) NOT NULL,
	[SalePOSID] [int] NOT NULL,
	[InvoiceNumber] [varchar](30) NULL,
	[POSID] [bigint] NOT NULL,
	[USIN] [varchar](50) NOT NULL,
	[RefUSIN] [varchar](50) NULL,
	[DateTime] [datetime] NOT NULL,
	[BuyerName] [varchar](150) NULL,
	[BuyerNTN] [varchar](9) NULL,
	[BuyerCNIC] [varchar](13) NULL,
	[BuyerPhoneNumber] [varchar](20) NULL,
	[TotalSaleValue] [numeric](18, 3) NOT NULL,
	[TotalTaxCharged] [numeric](18, 3) NOT NULL,
	[TotalQuantity] [numeric](18, 3) NOT NULL,
	[Discount] [numeric](18, 3) NULL,
	[FurtherTax] [numeric](18, 3) NULL,
	[TotalBillAmount] [numeric](18, 3) NOT NULL,
	[PaymentMode] [int] NOT NULL,
	[InvoiceType] [int] NULL,
	[isSynced] [bit] NULL,
	[FBRInvoiceNumber] [nvarchar](max) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CounterID] [int] NULL,
	[CompanyID] [int] NULL,
	[WHID] [int] NULL,
	[SaleSerielNo] [int] NULL,
	[FISCALID] [int] NULL,
	[IsTaxable] [bit] NULL,
	[imagePath] [nvarchar](max) NULL,
 CONSTRAINT [PK_FBR_InvoiceMaster] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[Fbr_InvoiceMaster_Insert]    Script Date: 12/17/2021 7:31:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fbr_InvoiceMaster_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Fbr_InvoiceMaster_Insert] AS' 
END
GO



ALTER procedure [dbo].[Fbr_InvoiceMaster_Insert] 
@sid INT OUTPUT,
@SalePOSID  int=null,
@InvoiceNumber  varchar(30)=null
,@POSID  bigint=null
,@USIN  varchar(50)=null
,@RefUSIN  varchar(50)=null
,@DateTime  datetime=null
,@BuyerName  varchar(150)=null
,@BuyerNTN  varchar(9)=null
,@BuyerCNIC  varchar(13)=null
,@BuyerPhoneNumber  varchar(20)=null
,@TotalSaleValue  numeric(18 ,3)=null
,@TotalTaxCharged  numeric(18 ,3)=null
,@TotalQuantity  numeric(18 ,3)=null
,@Discount  numeric(18 ,3)=null
,@FurtherTax  numeric(18 ,3)=null
,@TotalBillAmount  numeric(18 ,3)=null
,@PaymentMode  int=null
,@InvoiceType  int=null
,@isSynced  bit=null
,@FBRInvoiceNumber  nvarchar(max)=null
,@CreatedBy  int=null
,@CreatedDate  datetime=null
,@CounterID  int=null
,@CompanyID  int=null
,@WHID  int=null
,@SaleSerielNo  int=0,
@FBR_InvoiceDetail FBR_InvoiceDetail readonly,
@imagePath nvarchar(MAX) NULL

as
declare @returnSale bit=0
declare @IsTaxable bit =0
--set @SalePosDate=GETDATE()

declare @MaxTable as MaxTable 
declare @MaxTable2 as MaxTable
if	 @sid = 0
BEGIN
	insert into @MaxTable
	--exec GetmaxNo 'SaleVoucherNo','Fbr_InvoiceMaster', @CompanyID
	exec GetVoucherNoSale @Fieldname=N'SaleSerielNo',@TableName=N'Fbr_InvoiceMaster',@CheckTaxable= 1 ,@PrimaryKeyValue = @SID,@PrimaryKeyFieldName = 'SID' ,
	@voucherDate=@DateTime,@voucherDateFieldName=N'DateTime',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=0, 
	@FiscalIDFieldName=N'FiscalID',@IsTaxable=0
	select @SaleSerielNo = VoucherNo from @MaxTable
	

	Insert into Fbr_InvoiceMaster ( 
			
			[SalePOSID]
           ,[InvoiceNumber]
           ,[POSID]
           ,[USIN]
           ,[RefUSIN]
           ,[DateTime]
           ,[BuyerName]
           ,[BuyerNTN]
           ,[BuyerCNIC]
           ,[BuyerPhoneNumber]
           ,[TotalSaleValue]
           ,[TotalTaxCharged]
           ,[TotalQuantity]
           ,[Discount]
           ,[FurtherTax]
           ,[TotalBillAmount]
           ,[PaymentMode]
           ,[InvoiceType]
           ,[isSynced]
           ,[FBRInvoiceNumber]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[CounterID]
           ,[CompanyID]
           ,[WHID]
           ,[SaleSerielNo],
		   imagePath,
		   FISCALID,
		   IsTaxable
		   
	)
	Values (
			@SalePOSID
           ,@InvoiceNumber
           ,@POSID
           ,@USIN
           ,@RefUSIN
           ,@DateTime
           ,@BuyerName
           ,@BuyerNTN
           ,@BuyerCNIC
           ,@BuyerPhoneNumber
           ,@TotalSaleValue
           ,@TotalTaxCharged
           ,@TotalQuantity
           ,@Discount
           ,@FurtherTax
           ,@TotalBillAmount
           ,@PaymentMode
           ,@InvoiceType
           ,@isSynced
           ,@FBRInvoiceNumber
           ,@CreatedBy
           ,@CreatedDate
           ,@CounterID
           ,@CompanyID
           ,@WHID
           ,@SaleSerielNo,
		   @imagePath,
		   0
		   ,
		   0
		   
	)	
	set @sid = @@IDENTITY
	
	END
	else

	begin

	Update FBR_InvoiceMaster set

	[SalePOSID]			=@SalePOSID
	,[InvoiceNumber]	=@InvoiceNumber
	,[POSID]			=@POSID
	,[USIN]				=@USIN
	,[RefUSIN]			=@RefUSIN
	,[DateTime]			=@DateTime
	,[BuyerName]		=@BuyerName
	,[BuyerNTN]			=@BuyerNTN
	,[BuyerCNIC]		=@BuyerCNIC
	,[BuyerPhoneNumber]	=@BuyerPhoneNumber
	,[TotalSaleValue]	=@TotalSaleValue
	,[TotalTaxCharged]	=@TotalTaxCharged
	,[TotalQuantity]	=@TotalQuantity
	,[Discount]			=@Discount
	,[FurtherTax]		=@FurtherTax
	,[TotalBillAmount]	=@TotalBillAmount
	,[PaymentMode]		=@PaymentMode
	,[InvoiceType]		=@InvoiceType
	,[isSynced]			=@isSynced
	,[FBRInvoiceNumber]	=@FBRInvoiceNumber
	,[CounterID]		=@CounterID
	,[CompanyID]		=@CompanyID
	,[WHID]				=@WHID,
	imagePath=@imagePath
	where [SID]=@sid
	delete from FBR_InvoiceDetail where [SID]=@sid
	END
		insert into FBR_InvoiceDetail( SID, ItemCode, ItemName, PCTCode, Quantity, TaxRate, SaleValue, Discount, FurtherTax, TaxCharged, TotalAmount, InvoiceType, RefUSIN)
		Select SID, ItemCode, ItemName, PCTCode, Quantity, TaxRate, SaleValue, Discount, FurtherTax, TaxCharged, TotalAmount, InvoiceType, RefUSIN from @FBR_InvoiceDetail		



GO
/****** Object:  StoredProcedure [dbo].[FBR_InvoiceMasterSelectAll]    Script Date: 12/17/2021 7:31:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FBR_InvoiceMasterSelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[FBR_InvoiceMasterSelectAll] AS' 
END
GO



ALTER procedure [dbo].[FBR_InvoiceMasterSelectAll] 
@SelectMaster bit,
@SelectDetail bit,
@WhereClause varchar(4000),
@WhereClauseDetail varchar(4000)

as
if @SelectMaster = 1 
BEGIN
	exec('select * from FBR_InvoiceMaster '+ @WhereClause)

	END
	
if @SelectDetail = 1 
BEGIN

exec('select * from FBR_InvoiceDetail '+ @WhereClause)


END

  
  


GO
/****** Object:  StoredProcedure [dbo].[rpt_Fbr_sale_invoice]    Script Date: 12/17/2021 7:31:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpt_Fbr_sale_invoice]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[rpt_Fbr_sale_invoice] AS' 
END
GO







ALTER procedure [dbo].[rpt_Fbr_sale_invoice] 
@SaleInvoice bigint=0 
as
select CategoryName,InventItems.ItemNumber,InventWareHouse.PhoneNo,InventWareHouse.LocationAddress,InventWareHouse.WHDesc,
InventItems.ItenName,InventItems.UrduName,data_SalePosInfo.customerName,data_SalePosInfo.CustomerPhone,
data_SalePosInfo.SalePosNo as SalePosID,data_SalePosInfo.SalePosDate,data_SalePosInfo.TaxAmount, data_SalePosInfo.GrossAmount, data_SalePosDetail.DiscountPercentage, data_SalePosInfo.DiscountAmount, 
data_SalePosInfo.DiscountTotal, data_SalePosInfo.OtherCharges, data_SalePosInfo.NetAmount, data_SalePosInfo.AmountReceive, 
data_SalePosInfo.AmountReturn, data_SalePosInfo.SalePosReturnID, data_SalePosInfo.AmountInAccount, data_SalePosInfo.AmountReceivable, 
data_SalePosInfo.AmountPayable,GLCompany.*,
data_SalePosDetail.ItemId,data_SalePosDetail.Quantity,data_SalePosDetail.ItemRate,data_SalePosDetail.TotalAmount,data_SalePosDetail.DiscountAmount as DetailDiscount,FBR_InvoiceMaster.InvoiceNumber,FBR_InvoiceMaster.imagePath,
gen_PosConfiguration.POSID,gen_PosConfiguration.BillPreFix
from data_SalePosInfo left join
FBR_InvoiceMaster on FBR_InvoiceMaster.SalePOSID=data_SalePosInfo.SalePosID
inner join data_SalePosDetail on data_SalePosInfo.SalePosID=data_SalePosDetail.SalePosID
inner join InventItems on data_SalePosDetail.ItemId=InventItems.ItemId
inner join GLCompany on GLCompany.Companyid=data_SalePosInfo.CompanyID
inner join InventWareHouse on InventWareHouse.WHID=data_SalePosInfo.WHID
left join InventCategory on InventCategory.CategoryID=InventItems.CategoryID
inner join gen_PosConfiguration on gen_PosConfiguration.CounterID=data_SalePosInfo.CounterID
where data_SalePosInfo.SalePosID=@SaleInvoice
















GO
