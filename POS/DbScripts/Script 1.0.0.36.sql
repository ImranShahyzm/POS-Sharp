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
ALTER TABLE dbo.Posdata_MaketoOrderInfo ADD
	ImagePath varbinary(MAX) NULL
GO
ALTER TABLE dbo.Posdata_MaketoOrderInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


/****** Object:  StoredProcedure [dbo].[data_Cash_Insert]    Script Date: 6/23/2021 12:57:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









ALTER procedure [dbo].[data_Cash_Insert] 
@SourceID	bigint,
@SourceName	nvarchar(500),
@Amount	decimal(18,2),
@CashType bit=0,
@SalePosDate date=null,
@CompanyID int=0,
@UserID int=0,
@FiscalID int=0

--@CashInOut bigint output

as

if	 @CashType = 1
BEGIN
	Insert into data_CashIn( 
		SourceID,
		SourceName,
		Amount,
		Date,
		TimeStamp
	)
	Values (
		@SourceID,
		@SourceName,
		@Amount,
		@SalePosDate,
		getdate()
	)	
	
--set @CashInOut = @@IDENTITY
END
else
BEGIN
declare @CashSource int=0,@ClosingTypeID int=0,@ClosingID int=0,@CashInOut int=0
Select @CashSource=ISNULL(CashTypeSourceID,0) from gen_CashTypeSource where SourceName=@SourceName
Select @ClosingTypeID=ISNULL(ClosinngSource,0) from gen_PosConfiguration where CompanyID=@CompanyID
 if @ClosingTypeID=@CashSource and @ClosingTypeID>0
 begin
 exec  gen_PosCashClosing_Insert	@ClosingID=@ClosingID output,@CompanyID=@CompanyID,@ClosedBy=@UserID,@SourceID=@CashInOut,@ClosingDate=@SalePosDate,@FiscalID=@FiscalID,@ClosingAmount=@Amount
 end

Insert into data_CashOut( 
		SourceID,
		SourceName,
		Amount,
		Date,
		TimeStamp
	)
	Values (
		@ClosingID,
		@SourceName,
		@Amount,
		@SalePosDate,
		getdate()
	)	
 set @CashInOut = @@IDENTITY
 
 end



 gO

 
/****** Object:  StoredProcedure [dbo].[Posdata_MaketoOrderInfo_Insert]    Script Date: 6/23/2021 4:20:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
@Posdata_MaketoOrderDetail Posdata_MaketoOrderDetail readonly,
@ImagePath varbinary(MAX)= NULL
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
   CardName,
   ImagePath
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
   @CardName,
   @ImagePath
 
   )
	set @OrderID = @@IDENTITY
	
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
   ,IsTaxable
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
   ,@IsTaxable
 
   )
	set @CustomerID = @@IDENTITY

	
END

	
	
	

	
	--EXEC [dbo].[data_Cash_Insert]
	--	@SourceID = @OrderID,
	--	@SourceName = N'Make Order',
	--	@Amount = @AmountReceivable,
	--	@CashType = 1,
	--	@SalePosDate=@RegisterDate
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
		   CardName=@CardName,
		   ImagePath=@ImagePath
	where OrderID=@OrderID
	--Delete from data_ProductInflow where SourceName='ORDEREXCHANGE' and SourceID in (Select OrderDetailID from Posdata_MaketoOrderDetail where OrderID=@OrderID)
	--Delete from data_ProductOutflow where SourceName='ORDERSALE' and SourceID in (Select OrderDetailID from Posdata_MaketoOrderDetail where OrderID=@OrderID)
	Delete from Posdata_MaketoOrderDetail where OrderID=@OrderID
	--Delete from data_CashIn where SourceID=@OrderID and SourceName='Make Order'
	--EXEC [dbo].[data_Cash_Insert]
	--	@SourceID = @OrderID,
	--	@SourceName = N'Make Order',
	--	@Amount = @AmountReceivable,
	--	@CashType = 1,
	--	@SalePosDate=@RegisterDate
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

		
		Insert Into Posdata_MaketoOrderDetail (
		OrderID, ItemId, Quantity, ItemRate, TaxPercentage, TaxAmount, DiscountPercentage, DiscountAmount, TotalAmount, ManaufacturingID, CartonSize, Carton, TotalQuantity, SchemeID, MinQuantity, isExchange, 
                         StockRate

		) Select
		@OrderID, ItemId, Quantity, ItemRate, TaxPercentage, TaxAmount, DiscountPercentage, DiscountAmount, TotalAmount, @ManufacturingID, CartonSize, Carton, TotalQuantity, SchemeID, MinQuantity, isExchange, 
                         @StockRate
		From @Posdata_MaketoOrderDetail where RowID = @RowID
		
		set @SaleDetailID = @@IDENTITY		

--		declare @ProductOutflowID int

	FETCH NEXT FROM Salecursor INTO @RowID
	END

close Salecursor
deallocate Salecursor



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
	gO