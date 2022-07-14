
/****** Object:  StoredProcedure [dbo].[data_SalePosReturnInfo_AutoAccountsInsert]    Script Date: 7/14/2022 4:04:48 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosReturnInfo_AutoAccountsInsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePosReturnInfo_AutoAccountsInsert]
GO
/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Insert]    Script Date: 7/14/2022 4:04:48 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePosInfo_Insert]
GO
/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_AutoAccountsInsert]    Script Date: 7/14/2022 4:04:48 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_AutoAccountsInsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePosInfo_AutoAccountsInsert]
GO
/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_AutoAccountsInsert]    Script Date: 7/14/2022 4:04:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_AutoAccountsInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_SalePosInfo_AutoAccountsInsert] AS' 
END
GO








ALTER proc [dbo].[data_SalePosInfo_AutoAccountsInsert]
@UserID int = null , 
@CompanyID int = null , 
@FiscalID int = null ,
@SaleDate date = null ,
@WHID int ,
@isTaxable bit=0,
@CounterID int=0,
@EditMode BIT=0
AS

--raiserror(' This Is Error',16,1)

declare @data_SalePosDetail  data_SalePosDetail
declare @SalePosID int 
declare Cur cursor for
select SalePosID from dbo.data_SalePosInfo where CompanyID = @CompanyID and CounterID = @CounterID 
AND dbo.data_SalePosInfo.AccountVoucherID IS NULL AND MONTH(dbo.data_SalePosInfo.SalePosDate)=MONTH(@SaleDate) AND YEAR(dbo.data_SalePosInfo.SalePosDate)=YEAR(@SaleDate)
open cur
fetch next from cur into @SalePosID

while @@FETCH_STATUS = 0
BEGIN



insert into @data_SalePosDetail  (RowID,
		ItemId,
		Quantity,
		ItemRate,
		TaxPercentage,
		TaxAmount,
		DiscountPercentage,
		DiscountAmount,
		TotalAmount,
		CartonSize,
		Carton,
		TotalQuantity,
		SchemeID,
		MinQuantity,
		isExchange,
		IMEINumber


)
select  SalePosDetailID,ItemId,
		Quantity,
		ItemRate,
		TaxPercentage,
		TaxAmount,
		DiscountPercentage,
		DiscountAmount,
		TotalAmount,
		CartonSize,
		Carton,
		TotalQuantity,
		SchemeID,
		MinQuantity,
		isExchange,
		IMEINumber
from dbo.data_SalePosDetail
where SalePosID = @SalePosID


declare @SaleInvoiceNo INT=0 , 
@SalePosDate DATE, 
@DiscountPercent numeric(8, 3) , 
@DiscountAmount numeric(10, 2) , 
@Remarks varchar(300)  , 
@AmountReceivable numeric(18, 2) , 
@NetAmount numeric(18, 2) , 

@GroupLevelID int , 
@CategoryLevelID int , 
@PaymentTermID int , 
@TransporterID int ,
@TransporterFreightAmount numeric(18, 2) 
select  
@WHID = WHID , 
@SalePosDate = SalePosDate , 
@SaleInvoiceNo = SalePOSNo , 
@DiscountAmount = DiscountAmount , 
@AmountReceivable = AmountReceivable , 
@NetAmount = NetAmount,
@FiscalID=FiscalID 
from dbo.data_SalePosInfo where SalePosID = @SalePosID

SELECT TOP 1 @FiscalID=Fiscalid FROM dbo.GLFiscalYear WHERE @SalePosDate BETWEEN dbo.GLFiscalYear.StartYear AND EndYear AND Companyid=@CompanyID

exec  data_SalePOSInfo_InsertAccountOffline @CounterID=@CounterID,@SalePosID = @SalePosID, @CompanyID = @CompanyID, @SalePosDate = @SalePosDate , @WHID = @WHID , 
@NetAmount = @NetAmount , @SaleInvoiceNo = @SaleInvoiceNo , @UserID = @UserID , @FiscalID = @FiscalID ,@EditMode = @EditMode,
@AmountReceivable = @AmountReceivable,@data_SalePosDetail=@data_SalePosDetail


delete from @data_SalePosDetail

fetch next from cur into @SalePosID

END

close cur
deallocate cur









GO
/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Insert]    Script Date: 7/14/2022 4:04:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_SalePosInfo_Insert] AS' 
END
GO


-- Server : desktop-q54d9j1 -- 

ALTER procedure [dbo].[data_SalePosInfo_Insert] 
@UserID int = null , 
@CompanyID int = null , 
@FiscalID int = null ,
@SalePosDate	date	=null,
@WHID	int	=null,
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
@data_SalePosDetail  data_SalePosDetail   readonly,
@SalePosID bigint output,
@CustomerPhone nvarchar(50)=null,
@CustomerName  nvarchar(50)=null,
@SaleInvoiceNo int=0,
@ExchangeAmount numeric(18, 3) =NULL,
@MenuId int =NULL,
@InvoiceType int= NULL,
@CardNumber nvarchar(MAX)=NULL,
@CardName nvarchar(1000)=NULL,
@CashPayment numeric(18, 3)=NULL,
@CardPayment numeric(18, 3)=NULL,
@SaleManId int=null,
@CustomerID int=null,
@RiderAmount numeric(18,3)=0,
@LinckedBill int =NULL,
@CounterID int=null,
@SalePosReturnID int=0 output


as
declare @returnSale bit=0
declare @IsTaxable bit =0
--set @SalePosDate=GETDATE()
declare @ISOfflineServer bit=0,@StylePOS nvarchar(50)=''

Select @StylePOS=POSStyle from gen_posConfiguration where CounterID=@CounterID

IF @StylePOS='POSPcWorldStyle'
BEGIN
Select  @ISOfflineServer=ISNULL(IsofflineServer,0) from gen_posConfiguration  where CounterID=@CounterID
END
ELSE 
BEGIN
Select  @ISOfflineServer=ISNULL(IsofflineServer,0) from gen_posConfiguration where WHID=@WHID
END
declare @MaxTable as MaxTable 
declare @MaxTable2 as MaxTable
if	 @DirectReturn = 0
BEGIN
	insert into @MaxTable
	--exec GetmaxNo 'SaleVoucherNo','data_SaleInfo', @CompanyID
	exec GetVoucherNoPosFoodMama @Fieldname=N'SalePOSNo',@TableName=N'data_SalePosInfo',@CheckTaxable= 0 ,@PrimaryKeyValue = @SalePosID,@PrimaryKeyFieldName = 'SalePosID' ,
	@voucherDate=@SalePOSDate,@voucherDateFieldName=N'SalePOSDate',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=@FiscalID, 
	@FiscalIDFieldName=N'FiscalID',@IsTaxable=@IsTaxable,@MenuId=@MenuId,@MenuFieldName=N'MenuId',@CounterID=@CounterID,@CounterField=N'CounterID'
	select @SaleInvoiceNo = VoucherNo from @MaxTable

	Insert into data_SalePosInfo ( 
		EntryUserID,
		EntryUserDateTime,
		CompanyID,
		FiscalID,
		SalePosDate,
		WHID,
		TaxAmount,
		GrossAmount,
		DiscountPercentage,
		DiscountAmount,
		DiscountTotal,
		OtherCharges,
		NetAmount,
		AmountReceive,
		AmountReturn,
		AmountInAccount,
		AmountReceivable,
		AmountPayable,
		CustomerPhone,
		CustomerName ,
		SalePOSNo,
		ExchangeAmount,
		MenuId,
		InvoiceType,
		CardNumber,
		CardName,
		CashPayment,
		CardPayment,
		SaleManId,
		RiderAmount,
		LinckedBill,
		CounterID
	)
	Values (
		@UserID , 
		GETDATE() ,
		@CompanyID,
		@FiscalID,
		@SalePosDate,
		@WHID,
		@TaxAmount,
		@GrossAmount,
		@DiscountPercentage,
		@DiscountAmount,
		@DiscountTotal,
		@OtherCharges,
		@NetAmount,
		@AmountReceive,
		@AmountReturn,
		@AmountInAccount,
		@AmountReceivable,
		@AmountPayable,
		@CustomerPhone,
		@CustomerName ,
		@SaleInvoiceNo,
		@ExchangeAmount,
		@MenuId,
		@InvoiceType,
		@CardNumber,
		@CardName,
		@CashPayment,
		@CardPayment,
		@SaleManId,
		@RiderAmount,
		@LinckedBill,
		@CounterID
		
	)	
	set @SalePosID = @@IDENTITY
	if @CustomerID is not null
	begin
	insert into posdata_CustomerInvoiceList (SalePosId,CustomerID) values(@SalePosID,@CustomerID)

	end
	if @InvoiceType is null or @InvoiceType=1
	begin
		EXEC [dbo].[data_Cash_Insert]
		@SourceID = @SalePosID,
		@SourceName = N'POS',
		@Amount = @AmountReceivable,
		@CashType = 1,
		@SalePosDate=@SalePosDate,
		@CounterID=@CounterID
	end

	if @RiderAmount>0
	begin
		declare @RemarkDetail nvarchar(Max)=''
		set @RemarkDetail='Amount Given to Rider against Bill No '+ Cast(@SaleInvoiceNo as nvarchar(100))+' Dated on '+Format(@SalePosDate,'dd-MMM-yyyy') 
		EXEC [dbo].[data_Cash_Insert]
		@SourceID = @SalePosID,
		@SourceName = N'POS',
		@Amount = @RiderAmount,
		@CashType = 0,
		@Remarks=@RemarkDetail,
		@SalePosDate=@SalePosDate,
		@CounterID=@CounterID
	end
		

---========== Sale End Here ================
---========================== Sale Stock In Working Start Here =============================
		


declare @RowID int,@SaleDetailID int ,@StockRate numeric(14,5) , @Quantity numeric(10,2),@ItemId int, @IsBatchItem bit=0, @stockQty numeric(14,2),@ItemName varchar(200), @IMEINumber nvarchar(1000), @IMEINumber1 nvarchar(1000), @IMEINumber2 nvarchar(1000), @ERRORMSG varchar(200), @AllowNegativeStock bit = 0,
		@MainTainInventory bit = 1,@DealCateGoryID int=0,@ItemCategoryID int=0,@BomId int,@ProductIntflowID int=0,
        @data_ManufacturingDetail  data_ManufacturingDetail  ,
        @data_ItemBatchDetail  data_ItemBatchDetail  ,
        @data_ItemBatchDetailFinish  data_ItemBatchDetail ,@ManufacturingID int=0,@isExchange bit=0

		Select @DealCateGoryID=POSDealsCategory , @AllowNegativeStock = AllowNegativeStock from gen_SystemConfiguration where CompanyID=@CompanyID 
		
declare Salecursor cursor for
select RowID from @data_SalePosDetail
open Salecursor
fetch next from Salecursor into @RowID
while @@FETCH_STATUS = 0
begin

	select @ItemId = ItemId, @Quantity=Quantity, @StockRate=ItemRate , @isExchange=isExchange, @IMEINumber=IMEINumber
	From @data_SalePosDetail
	where RowID = @RowID
		
	Select @ItemCategoryID=CategoryID,@MainTainInventory = MaintainInventory, @IsBatchItem=IsBatchItem from InventItems where ItemId=@ItemId

	SET @IMEINumber1 = NULL; SET @IMEINumber2 = NULL;

	IF @IMEINumber IS NOT NULL AND @IMEINumber <> ''
	BEGIN
		IF CHARINDEX(',', @IMEINumber) > 0
		BEGIN
			SET @IMEINumber1 = Substring(
								@IMEINumber, 
								1, 
								Charindex(',', @IMEINumber)-1
								);
			SET @IMEINumber2 = Substring(
								@IMEINumber, 
								Charindex(',', @IMEINumber)+1, 
								LEN(@IMEINumber)-Charindex(',', @IMEINumber)
								);
		END
		ELSE
		BEGIN
			SET @IMEINumber1 = @IMEINumber;
		END
		
	END
	
	IF @IsBatchItem = 1 AND @IMEINumber1 IS NOT NULL
	BEGIN
		INSERT INTO @data_ItemBatchDetail (RowID, Quantity, Param1, Param2, Param3)
		SELECT @RowID , @Quantity, @IMEINumber1, @IMEINumber2, NULL
	END

	Select @BomId=BOMID from gen_BOMInfo where ItemId=@ItemId
	if(@BomId>0)
	begin
		insert into @data_ManufacturingDetail (RowID,ItemId,BOMQuantity,ActualQuantity,WHID,StockRate,BOMFormulaQuantity) 
Select ROW_NUMBER() Over(  order by ItemID)-1 as ROwId,ItemId,Quantity,Quantity*@Quantity,@WHID,0 ,1 from gen_BOMDetail where BOMID=@BomId
exec data_ManufacturingInfo_Insert @ManufacturingID=@ManufacturingID output,@UserID=@UserID,@CompanyID=@CompanyID,@FiscalID=@FiscalID,@BomId=@BomId,@ItemId=@ItemId,@ManufacturingDate=@SalePosDate,@Quantity=@Quantity,@WHID=@WHID,@ManufacturingStyle='STYLE 1',@IsTaxable=@IsTaxable,@data_ManufacturingDetail=@data_ManufacturingDetail,@data_ItemBatchDetail=@data_ItemBatchDetail,@data_ItemBatchDetailFinish=@data_ItemBatchDetailFinish,@LooseQuantity=@Quantity
	end


		--if	 @returnSale = 0
		--BEGIN
		declare @checkRate bit = 1

		IF @MainTainInventory = 1
		BEGIN
			
			IF @IsBatchItem = 1 
			BEGIN
				exec CheckStock @ItemID = @ItemId ,
				@WHID = @WHID , 
				@StockDate = @SalePosDate , 
				@CompanyID = @CompanyID,		
				@RowID = @RowID ,
				@AllowNegativeStock = @AllowNegativeStock,
				@Quantity = @Quantity,
				@ERRORMSG = @ERRORMSG out,
				@checkRate = @checkRate out,
				@data_ItemBatchDetail =  @data_ItemBatchDetail ,
				@IsTaxable =  @IsTaxable

				if @ERRORMSG != ''
				BEGIN
					RAISERROR (@ERRORMSG , 16, 1 ) ;
					return
				END
			END
			ELSE
			BEGIN
				exec GetStockQuantity @ItemId ,@WHID , @SalePosDate , @stockQty output , @ItemName out , @CompanyID , '' , '' , 
				null , null , null , @IsBatchItem , @IsTaxable
				if ( @stockQty < @Quantity )
				BEGIN
						set @ERRORMSG = 'Stock is not enough of Item ' + @ItemName + ' Avaliable Stock '+  convert(varchar, @stockQty)	 + ' Required Quantity is ' + convert(varchar, @Quantity)	
						RAISERROR (@ERRORMSG , 16, 1 ) ;
						return
				END
			END
			
		END
			
		--END
	
		Insert Into data_SalePosDetail (
		SalePosID,
		ItemId,
		Quantity,
		ItemRate,
		TaxPercentage,
		TaxAmount,
		DiscountPercentage,
		DiscountAmount,
		TotalAmount,
		ManaufacturingID,
		CartonSize,
		Carton,
		TotalQuantity,
		SchemeID,
		MinQuantity,
		isExchange,
		IMEINumber
		) Select
		@SalePosID ,
		ItemId,
		Quantity,
		ItemRate,
		TaxPercentage,
		TaxAmount,
		DiscountPercentage,
		DiscountAmount,
		TotalAmount,@ManufacturingID,
		CartonSize,
		Carton,
		TotalQuantity,
		SchemeID,
		MinQuantity,
		isExchange,
		IMEINumber

		From @data_SalePosDetail where RowID = @RowID
		
		set @SaleDetailID = @@IDENTITY		

		declare @ProductOutflowID int
			if @MainTainInventory = 1 
			BEGIN		
				BEGIN
					exec GetWeightedRateForItem @ItemId, @WHID ,@SalePosDate ,@SalePosDate ,@StockRate output , @CompanyID , @IsTaxable
				END
				update data_SaleDetail set StockRate = @StockRate where SaleDetailID = @SaleDetailID
				if @isExchange=1
				begin
				set @Quantity=-1* @Quantity
				exec data_ProductInflow_Insert @ProductIntflowID output,@ItemId,@SaleDetailID,'POSEXCHANGE',@WHID, @SalePosDate ,@StockRate,@Quantity, 
				@Quantity,@FiscalID , @CompanyID , @IsTaxable
				exec tempInflowDataTable_Insert @ProductIntflowID ,'POSEXCHANGE'
				end
				else
				begin
				
				exec data_ProductOutflow_Insert @ProductOutflowID output,null,@ItemId,@SaleDetailID,'POS',@WHID, @SalePosDate ,@StockRate,@Quantity, 
				@FiscalID , @CompanyID , @IsTaxable , NULL, NULL, NULL, NULL, NULL, NULL, NULL
				, @RowID , @data_ItemBatchDetail
				exec tempOutflowDataTable_Insert @ProductOutflowID ,'POS'
				end
				Update data_salePosDetail set StockRate=@StockRate where SalePOSDetailID=@SaleDetailID
			END
	
	FETCH NEXT FROM Salecursor INTO @RowID
	END

close Salecursor
deallocate Salecursor



if @ISOfflineServer=1
begin

exec  data_SalePOSInfo_InsertAccountOffline @CounterID=@CounterID,@SalePosID = @SalePosID, @CompanyID = @CompanyID, @SalePosDate = @SalePosDate , @WHID = @WHID , 
@NetAmount = @NetAmount , @SaleInvoiceNo = @SaleInvoiceNo , @UserID = @UserID , @FiscalID = @FiscalID ,@EditMode = 0,
@AmountReceivable = @AmountReceivable,@data_SalePosDetail=@data_SalePosDetail

end
---========================== Sale Stock In Working End Here =============================


END
else
BEGIN
---========== Sale Return Start Here ================





--insert into @MaxTable2
--exec GetVoucherNoPosFoodMama @Fieldname=N'SalePOSNo',@TableName=N'data_SalePosReturnInfo',@CheckTaxable= 0 ,@PrimaryKeyValue = @SalePosReturnID,@PrimaryKeyFieldName = 'SalePosReturnID' ,
--	@voucherDate=@SalePOSDate,@voucherDateFieldName=N'SalePosReturnDate',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=@FiscalID, 
--	@FiscalIDFieldName=N'FiscalID',@IsTaxable=@IsTaxable,@MenuId=@MenuId,@MenuFieldName=N'MenuId',@CounterID=@CounterID,@CounterField=N'CounterID'
--	select @SaleInvoiceNo = VoucherNo from @MaxTable2






--declare @SalePosReturnID bigint=0
declare @SalePosReturnDetailID bigint=0
Insert into data_SalePosReturnInfo (
		SalePosID, 
		EntryUserID,
		EntryUserDateTime,
		CompanyID,
		FiscalID,
		SalePosReturnDate,
		WHID,
		TaxAmount,
		GrossAmount,
		DiscountPercentage,
		DiscountAmount,
		DiscountTotal,
		OtherCharges,
		NetAmount,
		AmountReceive,
		AmountReturn,
		AmountInAccount,
		AmountReceivable,
		AmountPayable,
		MenuId,
		InvoiceType,
		CounterID
		
	)
	values
	(
		@SalePosID,
		@UserID , 
		GETDATE() ,
		@CompanyID,
		@FiscalID,
		@SalePosDate,
		@WHID,
		@TaxAmount,
		@GrossAmount,
		@DiscountPercentage,
		@DiscountAmount,
		@DiscountTotal,
		@OtherCharges,
		@NetAmount,
		@AmountReceive,
		@AmountReturn,
		@AmountInAccount,
		@AmountReceivable,
		@AmountPayable,
		@MenuId,
		@InvoiceType,
		@CounterID
		
		)
	set @SalePosReturnID = SCOPE_IDENTITY()

	--Checking Total Cash Remaining 
DECLARE @Amount decimal(18,2)=0 
select @Amount=(select isnull(sum(Amount),0) as Amount from data_CashIn where Date=cast(GETDATE() as date))
-
(select isnull(sum(Amount),0) as Amount from data_CashOut where Date=cast(GETDATE() as date)) 
--select  @Amount
declare @ErrorMessage nvarchar(1000),@RemarksonDirectReturn nvarchar(Max)='Direct Sale Return'
if	@Amount>=@AmountPayable
begin
	EXEC [dbo].[data_Cash_Insert]
	@SourceID = @SalePosReturnID,
	@SourceName = N'POS RETURN',
	@Amount = @AmountPayable,
	@CashType = 0,
	@Remarks=@RemarksonDirectReturn,
	@SalePosDate=@SalePosDate,
	@CounterID=@CounterID
end
else
begin
set @ErrorMessage = 'Not have enough cash!'
	RAISERROR (@ErrorMessage , 16, 1 ) ;
	return
end
---========== Sale Return End Here ================
---========================== Sale Stock Return Working Start Here =============================
		 declare @productInflowID int
DECLARE @PractitionerId int
declare @PosSaleReturnDetailID int ,@PosStockRate numeric(14,5) , @PosQuantity numeric(10,2),@PosItemId int,@PosstockQty numeric(14,2), @RIMEINumber nvarchar(1000), @RIMEINumber1 nvarchar(1000), @RIMEINumber2 nvarchar(1000), @RIsBatchItem bit=0 , @Rdata_ItemBatchDetail  data_ItemBatchDetail
	
DECLARE MY_CURSOR CURSOR 
  LOCAL STATIC READ_ONLY FORWARD_ONLY
FOR 
select RowID from @data_SalePosDetail

OPEN MY_CURSOR
FETCH NEXT FROM MY_CURSOR INTO @PractitionerId
WHILE @@FETCH_STATUS = 0
BEGIN 
    --Do something with Id here
    --PRINT @PractitionerId
	select @PosItemId = ItemId,@PosQuantity=Quantity,@PosStockRate=ItemRate , @RIMEINumber=IMEINumber
    --@MainTainInventory = MaintainInventory,
	From @data_SalePosDetail	 where RowID = @PractitionerId

	Select @RIsBatchItem=IsBatchItem from InventItems where ItemId=@PosItemId

	SET @RIMEINumber1 = NULL; SET @RIMEINumber2 = NULL;

	IF @RIMEINumber IS NOT NULL AND @RIMEINumber <> ''
	BEGIN
		IF CHARINDEX(',', @RIMEINumber) > 0
		BEGIN
			SET @RIMEINumber1 = Substring(
								@RIMEINumber, 
								1, 
								Charindex(',', @RIMEINumber)-1
								);
			SET @RIMEINumber2 = Substring(
								@RIMEINumber, 
								Charindex(',', @RIMEINumber)+1, 
								LEN(@RIMEINumber)-Charindex(',', @RIMEINumber)
								);
		END
		ELSE
		BEGIN
			SET @RIMEINumber1 = @RIMEINumber;
		END
		
	END
	
	IF @RIsBatchItem = 1 AND @RIMEINumber1 IS NOT NULL
	BEGIN
		INSERT INTO @Rdata_ItemBatchDetail (RowID, Quantity, Param1, Param2, Param3)
		SELECT @PractitionerId , @PosQuantity, @RIMEINumber1, @RIMEINumber2, NULL
	END

		Insert Into data_SalePosReturnDetail (
		SalePosReturnID,
		SalePosDetailID,
		ItemId,
		Quantity,
		ItemRate,
		TaxPercentage,
		TaxAmount,
		DiscountPercentage,
		DiscountAmount,
		TotalAmount,
		SchemeID,
		MinQuantity,
		IMEINumber
		) Select
		@SalePosReturnID ,
		0,
		ItemId,
		Quantity,
		ItemRate,
		TaxPercentage,
		TaxAmount,
		DiscountPercentage,
		DiscountAmount,
		TotalAmount,
		SchemeID,
		MinQuantity,
		IMEINumber
		From @data_SalePosDetail 
		where RowID = @PractitionerId

	set @PosSaleReturnDetailID = SCOPE_IDENTITY()

	--watch this
	exec data_ProductInflow_Insert @productInflowID out,@PosItemId,@PosSaleReturnDetailID,'POS RETURN',@WHID, @SalePosDate , 
				@PosStockRate,@PosQuantity,@PosQuantity,@FiscalID , @CompanyID ,@IsTaxable, NULL, NULL, NULL, NULL, NULL, NULL, NULL
				, @PractitionerId , @Rdata_ItemBatchDetail
				exec tempInflowDataTable_Insert @productInflowID ,'POS RETURN'
	--watht this end
update data_SalePosReturnDetail set IsLog=1 where SalePosReturnDetailID=@PosSaleReturnDetailID


exec GetWeightedRateForItem @PosItemId, @WHID ,@SalePosDate ,@SalePosDate ,@PosStockRate output , @CompanyID , @IsTaxable
update data_SalePosReturnDetail set StockRate=@PosStockRate where SalePosReturnDetailID=@PosSaleReturnDetailID

    FETCH NEXT FROM MY_CURSOR INTO @PractitionerId
END
CLOSE MY_CURSOR
DEALLOCATE MY_CURSOR
-----------sale return


if @ISOfflineServer=1
begin

exec  data_SalePOSReturnInfo_InsertAccountOffline @CounterID=@CounterID,@SalePosReturnID=@SalePosReturnID, @SalePosID = @SalePosID, @CompanyID = @CompanyID, @SalePosDate = @SalePosDate , @WHID = @WHID , 
@NetAmount = @NetAmount , @SaleInvoiceNo = @SaleInvoiceNo , @UserID = @UserID , @FiscalID = @FiscalID ,@EditMode = 0,
 @AmountReceivable = @NetAmount,@data_SalePosDetail=@data_SalePosDetail

end

-----------
---========================== Sale Stock Return Working End Here =============================



END















GO
/****** Object:  StoredProcedure [dbo].[data_SalePosReturnInfo_AutoAccountsInsert]    Script Date: 7/14/2022 4:04:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosReturnInfo_AutoAccountsInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_SalePosReturnInfo_AutoAccountsInsert] AS' 
END
GO
-- Server : 103.86.135.181\SQLENTERPRISE -- 










ALTER proc [dbo].[data_SalePosReturnInfo_AutoAccountsInsert]
@UserID int = null , 
@CompanyID int = null , 
@FiscalID int = null ,
@SaleDate date = null ,
@WHID int ,
@isTaxable bit=0,
@CounterID int=0,
@EditMode BIT=0
AS

--raiserror(' This Is Error',16,1)

declare @data_SalePosDetail  data_SalePosDetail
declare @SalePosReturnID int 
declare Cur cursor for
select SalePosReturnID from dbo.data_SalePosReturnInfo where CompanyID = @CompanyID and CounterID = @CounterID 
AND dbo.data_SalePosReturnInfo.AccountVoucherID IS NULL
AND MONTH(SalePosReturnDate)=MONTH(@SaleDate)
AND Year(SalePosReturnDate)=Year(@SaleDate)
open cur
fetch next from cur into @SalePosReturnID

while @@FETCH_STATUS = 0
BEGIN



insert into @data_SalePosDetail  (RowID,
		SalePosDetailID,
		ItemId,
		Quantity,
		ItemRate,
		TaxPercentage,
		TaxAmount,
		DiscountPercentage,
		DiscountAmount,
		TotalAmount,
		CartonSize,
		Carton,
		TotalQuantity,
		SchemeID,
		MinQuantity , 
		IMEINumber


)
select  SalePosReturnDetailID,
SalePosDetailID,
		ItemId,
		Quantity,
		ItemRate,
		TaxPercentage,
		TaxAmount,
		DiscountPercentage,
		DiscountAmount,
		TotalAmount,
		CartonSize,
		Carton,
		TotalQuantity,
		SchemeID,
		MinQuantity , 
		IMEINumber
from dbo.data_SalePosReturnDetail
where SalePosReturnID = @SalePosReturnID


declare @SaleInvoiceNo INT=0 , 
@SalePosDate DATE, 
@DiscountPercent numeric(8, 3) , 
@DiscountAmount numeric(10, 2) , 
@Remarks varchar(300)  , 
@AmountReceivable numeric(18, 2) , 
@NetAmount numeric(18, 2) , 

@SalePosID int , 
@CategoryLevelID int , 
@PaymentTermID int , 
@TransporterID int ,
@TransporterFreightAmount numeric(18, 2) 
select  
@WHID = WHID , 
@SalePosDate = SalePosReturnDate , 
@SaleInvoiceNo = SalePOSNo , 
@DiscountAmount = DiscountAmount , 
@AmountReceivable = AmountReceivable , 
@NetAmount = NetAmount,
@FiscalID=FiscalID 
from dbo.data_SalePosReturnInfo where SalePosReturnID = @SalePosReturnID

SELECT TOP 1 @FiscalID=Fiscalid FROM dbo.GLFiscalYear WHERE @SalePosDate BETWEEN dbo.GLFiscalYear.StartYear AND EndYear AND Companyid=@CompanyID


exec  data_SalePOSReturnInfo_InsertAccountOffline @CounterID=@CounterID,@SalePosReturnID=@SalePosReturnID, @SalePosID = @SalePosID, @CompanyID = @CompanyID, @SalePosDate = @SalePosDate , @WHID = @WHID , 
@NetAmount = @NetAmount , @SaleInvoiceNo = @SaleInvoiceNo , @UserID = @UserID , @FiscalID = @FiscalID ,@EditMode = @EditMode,
 @AmountReceivable = @NetAmount,@data_SalePosDetail=@data_SalePosDetail


delete from @data_SalePosDetail

fetch next from cur into @SalePosReturnID

END

close cur
deallocate cur










GO
