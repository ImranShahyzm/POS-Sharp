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
ALTER TABLE dbo.tblPos_CustomerData ADD
	Profession nvarchar(MAX) NULL
GO
ALTER TABLE dbo.tblPos_CustomerData SET (LOCK_ESCALATION = TABLE)
GO
COMMIT



/****** Object:  StoredProcedure [dbo].[Posdata_MaketoOrderInfo_SelectAll]    Script Date: 6/18/2021 12:49:59 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Posdata_MaketoOrderInfo_SelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Posdata_MaketoOrderInfo_SelectAll]
GO
/****** Object:  StoredProcedure [dbo].[Posdata_MaketoOrderInfo_Insert]    Script Date: 6/18/2021 12:49:59 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Posdata_MaketoOrderInfo_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Posdata_MaketoOrderInfo_Insert]
GO
/****** Object:  Table [dbo].[Posdata_MaketoOrderInfo]    Script Date: 6/18/2021 12:49:59 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Posdata_MaketoOrderInfo]') AND type in (N'U'))
DROP TABLE [dbo].[Posdata_MaketoOrderInfo]
GO
/****** Object:  Table [dbo].[Posdata_MaketoOrderDetail]    Script Date: 6/18/2021 12:49:59 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Posdata_MaketoOrderDetail]') AND type in (N'U'))
DROP TABLE [dbo].[Posdata_MaketoOrderDetail]
GO
/****** Object:  UserDefinedTableType [dbo].[Posdata_MaketoOrderDetail]    Script Date: 6/18/2021 12:49:59 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'Posdata_MaketoOrderDetail' AND ss.name = N'dbo')
DROP TYPE [dbo].[Posdata_MaketoOrderDetail]
GO
/****** Object:  UserDefinedTableType [dbo].[Posdata_MaketoOrderDetail]    Script Date: 6/18/2021 12:49:59 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'Posdata_MaketoOrderDetail' AND ss.name = N'dbo')
CREATE TYPE [dbo].[Posdata_MaketoOrderDetail] AS TABLE(
	[RowID] [int] NULL,
	[ItemId] [int] NULL,
	[Quantity] [numeric](18, 3) NULL,
	[ItemRate] [numeric](18, 3) NULL,
	[TaxPercentage] [numeric](18, 3) NULL,
	[TaxAmount] [numeric](18, 3) NULL,
	[DiscountPercentage] [numeric](18, 3) NULL,
	[DiscountAmount] [numeric](18, 3) NULL,
	[TotalAmount] [numeric](18, 3) NULL,
	[CartonSize] [decimal](18, 3) NULL,
	[Carton] [decimal](18, 3) NULL,
	[TotalQuantity] [decimal](18, 3) NULL,
	[SalePosDetailID] [int] NULL,
	[SchemeID] [int] NULL,
	[MinQuantity] [numeric](18, 3) NULL,
	[isExchange] [bit] NULL
)
GO
/****** Object:  Table [dbo].[Posdata_MaketoOrderDetail]    Script Date: 6/18/2021 12:49:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Posdata_MaketoOrderDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Posdata_MaketoOrderDetail](
	[OrderDetailID] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderID] [bigint] NULL,
	[ItemId] [int] NULL,
	[Quantity] [numeric](18, 2) NULL,
	[ItemRate] [numeric](18, 2) NULL,
	[TaxPercentage] [numeric](18, 2) NULL,
	[TaxAmount] [numeric](18, 2) NULL,
	[DiscountPercentage] [numeric](18, 2) NULL CONSTRAINT [DF_Posdata_MaketoOrderDetail_DiscountPercentage]  DEFAULT ((0)),
	[DiscountAmount] [numeric](18, 2) NULL CONSTRAINT [DF_Posdata_MaketoOrderDetail_DiscountAmount]  DEFAULT ((0)),
	[TotalAmount] [numeric](18, 2) NULL,
	[ManaufacturingID] [int] NULL,
	[CartonSize] [decimal](18, 3) NULL,
	[Carton] [decimal](18, 3) NULL,
	[TotalQuantity] [decimal](18, 3) NULL,
	[SchemeID] [int] NULL,
	[MinQuantity] [numeric](18, 3) NULL,
	[isExchange] [bit] NULL,
	[StockRate] [numeric](18, 3) NULL,
 CONSTRAINT [PK_Posdata_MaketoOrderDetail] PRIMARY KEY CLUSTERED 
(
	[OrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Posdata_MaketoOrderInfo]    Script Date: 6/18/2021 12:49:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Posdata_MaketoOrderInfo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Posdata_MaketoOrderInfo](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
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
 CONSTRAINT [PK_Posdata_MaketoOrder] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  StoredProcedure [dbo].[Posdata_MaketoOrderInfo_Insert]    Script Date: 6/18/2021 12:49:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Posdata_MaketoOrderInfo_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Posdata_MaketoOrderInfo_Insert] AS' 
END
GO

ALTER procedure [dbo].[Posdata_MaketoOrderInfo_Insert] 

@OrderID int  output ,
@RegisterDate datetime =NULL,
@CName nvarchar(1000) =NULL,
@CPhone nvarchar(1000) =NULL,
@Address nvarchar(max) =NULL,
@CityName nvarchar(500) =NULL,
@Gender nvarchar(100) =NULL,
@UserID int =NULL,
@CompanyID int =NULL,
@FiscalID int =NULL,
@WHID int =NULL,
@CNIC nvarchar(1000) =NULL,
@Neck nvarchar(50) =NULL,
@FFrontNeck nvarchar(50) =NULL,
@FBackNeck nvarchar(50) =NULL,
@Shoulder nvarchar(50) =NULL,
@FUpperBust nvarchar(50) =NULL,
@Bust nvarchar(50) =NULL,
@FUnderBust nvarchar(50) =NULL,
@ArmHole nvarchar(50) =NULL,
@SleeveLength nvarchar(50) =NULL,
@Muscle nvarchar(50) =NULL,
@Elbow nvarchar(50) =NULL,
@Cuff nvarchar(50) =NULL,
@Waist nvarchar(50) =NULL,
@Hip nvarchar(50) =NULL,
@BottomLength nvarchar(50) =NULL,
@Ankle nvarchar(50) =NULL,
@Remarks nvarchar(max) =NULL,
@RNo int =NULL,
@IsTaxable bit =0,
@BranchId int =0,
@CustomerID int=0,
@CardNumber nvarchar(MAX)=NULL,
@CardName nvarchar(1000)=NULL,
@CashPayment numeric(18, 3)=NULL,
@CardPayment numeric(18, 3)=NULL,
@SaleManId int=null,
@TaxAmount			decimal(18, 2)	=null,
@GrossAmount		decimal(18, 2)	=null,
@DiscountPercentage	decimal(18, 2)	=null,
@DiscountAmount		decimal(18, 2)	=null,
@DiscountTotal		decimal(18, 2)	=null,
@OtherCharges		decimal(18, 2)	=null,
@NetAmount			decimal(18, 2)	=null,
@AmountReceive		decimal(18, 2)	=null,
@AmountReturn		decimal(18, 2)	=null,
@AmountInAccount	decimal(18, 2)	=null,
@AmountReceivable	decimal(18, 2)	=null,
@AmountPayable		decimal(18, 2)	=null,
@DirectReturn	biT=0,
@DeliveryDate datetime=null,
@Posdata_MaketoOrderDetail Posdata_MaketoOrderDetail readonly
as
declare @EditMode bit  = 0

if	 @OrderID = 0
BEGIN
INSERT INTO Posdata_MaketoOrderInfo
           (
	RegisterDate
   ,CName
   ,CPhone
   ,Address
   ,CityName
   ,Gender
   ,EntryUserID
   ,EntryUserDateTime
   ,CompanyID
   ,FiscalID
   ,WHID
   ,CNIC
   ,Neck
   ,FFrontNeck
   ,FBackNeck
   ,Shoulder
   ,FUpperBust
   ,Bust
   ,FUnderBust
   ,ArmHole
   ,SleeveLength
   ,Muscle
   ,Elbow
   ,Cuff
   ,Waist
   ,Hip
   ,BottomLength
   ,Ankle
   ,Remarks
   ,RNo
   ,IsTaxable,
   CustomerID
   ,TaxAmount
   ,GrossAmount
   ,DiscountPercentage
   ,DiscountAmount
   ,DiscountTotal
   ,OtherCharges
   ,NetAmount
   ,AmountReceive
   ,AmountReturn
   ,AmountInAccount
   ,AmountReceivable
   ,AmountPayable
   ,DirectReturn,
   SaleManId,
   DeliveryDate,
   CashPayment,
   CardPayment,
   CardNumber,
   CardName
   )
   values(
   
   
	@RegisterDate
   ,N''+@CName
   ,@CPhone
   ,N''+@Address
   ,N''+@CityName
   ,@Gender
   ,@UserID
   ,GETDATE()
   ,@CompanyID
   ,@FiscalID
   ,@WHID
   ,@CNIC
   ,N''+@Neck
   ,N''+@FFrontNeck
   ,N''+@FBackNeck
   ,N''+@Shoulder
   ,N''+@FUpperBust
   ,N''+@Bust
   ,N''+@FUnderBust
   ,N''+@ArmHole
   ,N''+@SleeveLength
   ,N''+@Muscle
   ,N''+@Elbow
   ,N''+@Cuff
   ,N''+@Waist
   ,N''+@Hip
   ,N''+@BottomLength
   ,N''+@Ankle
   ,N''+@Remarks
   ,@RNo
   ,@IsTaxable,
   @CustomerID
   ,@TaxAmount
   ,@GrossAmount
   ,@DiscountPercentage
   ,@DiscountAmount
   ,@DiscountTotal
   ,@OtherCharges
   ,@NetAmount
   ,@AmountReceive
   ,@AmountReturn
   ,@AmountInAccount
   ,@AmountReceivable
   ,@AmountPayable
   ,@DirectReturn,
   @SaleManId,
   @DeliveryDate,
   @CashPayment,
   @CardPayment,
   @CardNumber,
   @CardName
 
   )
	set @OrderID = @@IDENTITY
	update tblPos_CustomerData set	
		
		   CName				=N''+@CName
		   ,CPhone				=@CPhone
		   ,Address				=N''+@Address
		   ,CityName			=N''+@CityName
		   ,Gender				=@Gender
		   ,ModifyUserID			=@UserID
		   ,ModifyUserDateTime	=GETDATE()
		   ,CompanyID			=@CompanyID
		   ,FiscalID			=@FiscalID
		   ,WHID				=@WHID
		   ,CNIC				=@CNIC
		   ,Neck				=N''+@Neck
		   ,FFrontNeck			=N''+@FFrontNeck
		   ,FBackNeck			=N''+@FBackNeck
		   ,Shoulder			=N''+@Shoulder
		   ,FUpperBust			=N''+@FUpperBust
		   ,Bust				=N''+@Bust
		   ,FUnderBust			=N''+@FUnderBust
		   ,ArmHole				=N''+@ArmHole
		   ,SleeveLength		=N''+@SleeveLength
		   ,Muscle				=N''+@Muscle
		   ,Elbow				=N''+@Elbow
		   ,Cuff				=N''+@Cuff
		   ,Waist				=N''+@Waist
		   ,Hip					=N''+@Hip
		   ,BottomLength		=N''+@BottomLength
		   ,Ankle				=N''+@Ankle
		   ,Remarks				=N''+@Remarks
		   ,IsTaxable			=@IsTaxable
	where CustomerID=@CustomerID

	
	EXEC [dbo].[data_Cash_Insert]
		@SourceID = @OrderID,
		@SourceName = N'Make Order',
		@Amount = @AmountReceivable,
		@CashType = 1,
		@SalePosDate=@RegisterDate
END

ELSE

BEGIN	

	update Posdata_MaketoOrderInfo set	
			RegisterDate		=@RegisterDate
		   ,CName				=N''+@CName
		   ,CPhone				=@CPhone
		   ,Address				=N''+@Address
		   ,CityName			=N''+@CityName
		   ,Gender				=@Gender
		   ,ModifyUserID			=@UserID
		   ,ModifyUserDateTime	=GETDATE()
		   ,CompanyID			=@CompanyID
		   ,FiscalID			=@FiscalID
		   ,WHID				=@WHID
		   ,CNIC				=@CNIC
		   ,Neck				=N''+@Neck
		   ,FFrontNeck			=N''+@FFrontNeck
		   ,FBackNeck			=N''+@FBackNeck
		   ,Shoulder			=N''+@Shoulder
		   ,FUpperBust			=N''+@FUpperBust
		   ,Bust				=N''+@Bust
		   ,FUnderBust			=N''+@FUnderBust
		   ,ArmHole				=N''+@ArmHole
		   ,SleeveLength		=N''+@SleeveLength
		   ,Muscle				=N''+@Muscle
		   ,Elbow				=N''+@Elbow
		   ,Cuff				=N''+@Cuff
		   ,Waist				=N''+@Waist
		   ,Hip					=N''+@Hip
		   ,BottomLength		=N''+@BottomLength
		   ,Ankle				=N''+@Ankle
		   ,Remarks				=N''+@Remarks
		   ,IsTaxable			=@IsTaxable
		   ,TaxAmount			=@TaxAmount
		   ,GrossAmount			=@GrossAmount
		   ,DiscountPercentage	=@DiscountPercentage
		   ,DiscountAmount		=@DiscountAmount
		   ,DiscountTotal		=@DiscountTotal
		   ,OtherCharges			=@OtherCharges
		   ,NetAmount			=@NetAmount
		   ,AmountReceive		=@AmountReceive
		   ,AmountReturn			=@AmountReturn
		   ,AmountInAccount		=@AmountInAccount
		   ,AmountReceivable	=@AmountReceivable
		   ,AmountPayable		=@AmountPayable
		   ,DirectReturn		=@DirectReturn,
		   SaleManId=@SaleManId,
		  DeliveryDate=@DeliveryDate,
		   CustomerID=@CustomerID,
		   CashPayment=@CashPayment,
		   CardPayment=@cardPayment,
		   CardNumber=@CardNumber,
		   CardName=@CardName
	where OrderID=@OrderID
	Delete from data_ProductInflow where SourceName='ORDEREXCHANGE' and SourceID in (Select OrderDetailID from Posdata_MaketoOrderDetail where OrderID=@OrderID)
	Delete from data_ProductOutflow where SourceName='ORDERSALE' and SourceID in (Select OrderDetailID from Posdata_MaketoOrderDetail where OrderID=@OrderID)
	Delete from Posdata_MaketoOrderDetail where OrderID=@OrderID
	Delete from data_CashIn where SourceID=@OrderID and SourceName='Make Order'
	EXEC [dbo].[data_Cash_Insert]
		@SourceID = @OrderID,
		@SourceName = N'Make Order',
		@Amount = @AmountReceivable,
		@CashType = 1,
		@SalePosDate=@RegisterDate
	set	@EditMode = 1
END

	




declare @RowID int,@SaleDetailID int ,@StockRate numeric(14,5) , @Quantity numeric(10,2),@ItemId int,@stockQty numeric(14,2),@ItemName varchar(200),@ERRORMSG varchar(200),
		@MainTainInventory bit = 1,@DealCateGoryID int=0,@ItemCategoryID int=0,@BomId int,@ProductIntflowID int=0,
        @data_ManufacturingDetail  data_ManufacturingDetail  ,
        @data_ItemBatchDetail  data_ItemBatchDetail  ,
        @data_ItemBatchDetailFinish  data_ItemBatchDetail ,@ManufacturingID int=0,@isExchange bit=0
		Select @DealCateGoryID=POSDealsCategory from gen_SystemConfiguration where CompanyID=@CompanyID
		
declare Salecursor cursor for
select RowID from @Posdata_MaketoOrderDetail
open Salecursor
fetch next from Salecursor into @RowID
while @@FETCH_STATUS = 0
	begin

	select @ItemId = ItemId,@Quantity=Quantity,@StockRate=ItemRate ,@isExchange=isExchange
    
	From @Posdata_MaketoOrderDetail		 where RowID = @RowID
		
		Select @ItemCategoryID=CategoryID,@MainTainInventory = MaintainInventory from InventItems where ItemId=@ItemId

		Select @BomId=BOMID from gen_BOMInfo where ItemId=@ItemId
		if(@BomId>0 and @ItemCategoryID=@DealCateGoryID)
		begin
		insert into @data_ManufacturingDetail (RowID,ItemId,BOMQuantity,ActualQuantity,WHID,StockRate,BOMFormulaQuantity) 
Select ROW_NUMBER() Over(  order by ItemID)-1 as ROwId,ItemId,Quantity,Quantity*@Quantity,@WHID,0 ,1 from gen_BOMDetail where BOMID=@BomId
exec data_ManufacturingInfo_Insert @ManufacturingID=@ManufacturingID output,@UserID=@UserID,@CompanyID=@CompanyID,@FiscalID=@FiscalID,@BomId=@BomId,@ItemId=@ItemId,@ManufacturingDate=@RegisterDate,@Quantity=@Quantity,@WHID=@WHID,@ManufacturingStyle='STYLE 1',@IsTaxable=@IsTaxable,@data_ManufacturingDetail=@data_ManufacturingDetail,@data_ItemBatchDetail=@data_ItemBatchDetail,@data_ItemBatchDetailFinish=@data_ItemBatchDetailFinish,@LooseQuantity=@Quantity		end
		--if	 @returnSale = 0
		--BEGIN
			exec GetStockQuantity @ItemId ,@WHID , @RegisterDate , @stockQty output , @ItemName out , @CompanyID , '' , '' , 
			null , null , null , 1 , @IsTaxable
			if (( @stockQty < @Quantity ) and @MainTainInventory=1)
			BEGIN
					set @ERRORMSG = 'Stock is not enough of Item ' + @ItemName + ' Avaliable Stock '+  convert(varchar, @stockQty)	 + ' Required Quantity is ' + convert(varchar, @Quantity)	
					RAISERROR (@ERRORMSG , 16, 1 ) ;
					return
			END
		--END
	
		Insert Into Posdata_MaketoOrderDetail (
		OrderID, ItemId, Quantity, ItemRate, TaxPercentage, TaxAmount, DiscountPercentage, DiscountAmount, TotalAmount, ManaufacturingID, CartonSize, Carton, TotalQuantity, SchemeID, MinQuantity, isExchange, 
                         StockRate

		) Select
		@OrderID, ItemId, Quantity, ItemRate, TaxPercentage, TaxAmount, DiscountPercentage, DiscountAmount, TotalAmount, @ManufacturingID, CartonSize, Carton, TotalQuantity, SchemeID, MinQuantity, isExchange, 
                         @StockRate
		From @Posdata_MaketoOrderDetail where RowID = @RowID
		
		set @SaleDetailID = @@IDENTITY		

		declare @ProductOutflowID int
			if @MainTainInventory = 1 
			BEGIN		
				BEGIN
					exec GetWeightedRateForItem @ItemId, @WHID ,@RegisterDate ,@RegisterDate ,@StockRate output , @CompanyID , @IsTaxable
				END
				update Posdata_MaketoOrderDetail set StockRate = @StockRate where OrderdetailID = @SaleDetailID
				if @isExchange=1
				begin
				set @Quantity=-1* @Quantity
				exec data_ProductInflow_Insert @ProductIntflowID output,@ItemId,@SaleDetailID,'ORDEREXCHANGE',@WHID, @RegisterDate ,@StockRate,@Quantity, 
				@Quantity,@FiscalID , @CompanyID , @IsTaxable
				exec tempInflowDataTable_Insert @ProductIntflowID ,'ORDEREXCHANGE'
				end
				else
				begin
				exec data_ProductOutflow_Insert @ProductOutflowID output,null,@ItemId,@SaleDetailID,'ORDERSALE',@WHID, @RegisterDate ,@StockRate,@Quantity, 
				@FiscalID , @CompanyID , @IsTaxable
				exec tempOutflowDataTable_Insert @ProductOutflowID ,'ORDERSALE'
				end
				
			END
	
	FETCH NEXT FROM Salecursor INTO @RowID
	END

close Salecursor
deallocate Salecursor



GO
/****** Object:  StoredProcedure [dbo].[Posdata_MaketoOrderInfo_SelectAll]    Script Date: 6/18/2021 12:49:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Posdata_MaketoOrderInfo_SelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Posdata_MaketoOrderInfo_SelectAll] AS' 
END
GO




ALTER procedure [dbo].[Posdata_MaketoOrderInfo_SelectAll]
@SelectMaster bit,
@WhereClause varchar(4000),
@SelectDetail bit,
@WhereClauseDetail varchar(4000)
as

if @SelectMaster = 1
BEGIN
	exec('select * from Posdata_MaketoOrderInfo '+ @WhereClause)
END

if @SelectDetail = 1
BEGIN
	exec('select Posdata_MaketoOrderDetail.*,InventItems.ItenName,ItemNumber from Posdata_MaketoOrderDetail inner join InventItems on InventItems.ItemId=Posdata_MaketoOrderDetail.ItemId '+ @WhereClauseDetail)
END




GO




/****** Object:  StoredProcedure [dbo].[PosData_tblCustomerData_Insert]    Script Date: 6/18/2021 12:50:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[PosData_tblCustomerData_Insert] 

@CustomerID int  output ,
@RegisterDate datetime =NULL,
@CName nvarchar(1000) =NULL,
@CPhone nvarchar(1000) =NULL,
@Address nvarchar(max) =NULL,
@CityName nvarchar(500) =NULL,
@Gender nvarchar(100) =NULL,
@UserID int =NULL,
@CompanyID int =NULL,
@FiscalID int =NULL,
@WHID int =NULL,
@CNIC nvarchar(1000) =NULL,
@Neck nvarchar(50) =NULL,
@FFrontNeck nvarchar(50) =NULL,
@FBackNeck nvarchar(50) =NULL,
@Shoulder nvarchar(50) =NULL,
@FUpperBust nvarchar(50) =NULL,
@Bust nvarchar(50) =NULL,
@FUnderBust nvarchar(50) =NULL,
@ArmHole nvarchar(50) =NULL,
@SleeveLength nvarchar(50) =NULL,
@Muscle nvarchar(50) =NULL,
@Elbow nvarchar(50) =NULL,
@Cuff nvarchar(50) =NULL,
@Waist nvarchar(50) =NULL,
@Hip nvarchar(50) =NULL,
@BottomLength nvarchar(50) =NULL,
@Ankle nvarchar(50) =NULL,
@Remarks nvarchar(max) =NULL,
@RNo int =NULL,
@IsTaxable bit =0,
@BranchId int =0,
@Profession nvarchar(Max)= NULL
as
declare @EditMode bit  = 0

if	 @CustomerID = 0
BEGIN
INSERT INTO tblPos_CustomerData
           (
	RegisterDate
   ,CName
   ,CPhone
   ,Address
   ,CityName
   ,Gender
   ,EntryUserID
   ,EntryUserDateTime
   ,CompanyID
   ,FiscalID
   ,WHID
   ,CNIC
   ,Neck
   ,FFrontNeck
   ,FBackNeck
   ,Shoulder
   ,FUpperBust
   ,Bust
   ,FUnderBust
   ,ArmHole
   ,SleeveLength
   ,Muscle
   ,Elbow
   ,Cuff
   ,Waist
   ,Hip
   ,BottomLength
   ,Ankle
   ,Remarks
   ,RNo
   ,IsTaxable,
   Profession
   )
   values(
   
   
	@RegisterDate
   ,N''+@CName
   ,@CPhone
   ,N''+@Address
   ,N''+@CityName
   ,@Gender
   ,@UserID
   ,GETDATE()
   ,@CompanyID
   ,@FiscalID
   ,@WHID
   ,@CNIC
   ,N''+@Neck
   ,N''+@FFrontNeck
   ,N''+@FBackNeck
   ,N''+@Shoulder
   ,N''+@FUpperBust
   ,N''+@Bust
   ,N''+@FUnderBust
   ,N''+@ArmHole
   ,N''+@SleeveLength
   ,N''+@Muscle
   ,N''+@Elbow
   ,N''+@Cuff
   ,N''+@Waist
   ,N''+@Hip
   ,N''+@BottomLength
   ,N''+@Ankle
   ,N''+@Remarks
   ,@RNo
   ,@IsTaxable,
   N''+@Profession
 
   )
	set @CustomerID = @@IDENTITY
	
END

ELSE

BEGIN	

	update tblPos_CustomerData set	
			RegisterDate		=@RegisterDate
		   ,CName				=N''+@CName
		   ,CPhone				=@CPhone
		   ,Address				=N''+@Address
		   ,CityName			=N''+@CityName
		   ,Gender				=@Gender
		   ,ModifyUserID			=@UserID
		   ,ModifyUserDateTime	=GETDATE()
		   ,CompanyID			=@CompanyID
		   ,FiscalID			=@FiscalID
		   ,WHID				=@WHID
		   ,CNIC				=@CNIC
		   ,Neck				=N''+@Neck
		   ,FFrontNeck			=N''+@FFrontNeck
		   ,FBackNeck			=N''+@FBackNeck
		   ,Shoulder			=N''+@Shoulder
		   ,FUpperBust			=N''+@FUpperBust
		   ,Bust				=N''+@Bust
		   ,FUnderBust			=N''+@FUnderBust
		   ,ArmHole				=N''+@ArmHole
		   ,SleeveLength		=N''+@SleeveLength
		   ,Muscle				=N''+@Muscle
		   ,Elbow				=N''+@Elbow
		   ,Cuff				=N''+@Cuff
		   ,Waist				=N''+@Waist
		   ,Hip					=N''+@Hip
		   ,BottomLength		=N''+@BottomLength
		   ,Ankle				=N''+@Ankle
		   ,Remarks				=N''+@Remarks
		   ,IsTaxable			=@IsTaxable,
		   Profession=N''+@Profession
	where CustomerID=@CustomerID

	set	@EditMode = 1
END

	