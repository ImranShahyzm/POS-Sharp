
/****** Object:  StoredProcedure [dbo].[rpt_CashBookCounterWise]    Script Date: 3/28/2022 6:55:06 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpt_CashBookCounterWise]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpt_CashBookCounterWise]
GO
/****** Object:  StoredProcedure [dbo].[POSGetVoucherNoSContinuos]    Script Date: 3/28/2022 6:55:06 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSGetVoucherNoSContinuos]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSGetVoucherNoSContinuos]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_StockArrivalManualInfo_InsertContinuosSeriel]    Script Date: 3/28/2022 6:55:06 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockArrivalManualInfo_InsertContinuosSeriel]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_StockArrivalManualInfo_InsertContinuosSeriel]
GO
/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Insert]    Script Date: 3/28/2022 6:55:06 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePosInfo_Insert]
GO
/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Insert]    Script Date: 3/28/2022 6:55:06 PM ******/
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
@CounterID int=null

as
declare @returnSale bit=0
declare @IsTaxable bit =0
--set @SalePosDate=GETDATE()

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
		


declare @RowID int,@SaleDetailID int ,@StockRate numeric(14,5) , @Quantity numeric(10,2),@ItemId int,@stockQty numeric(14,2),@ItemName varchar(200),@ERRORMSG varchar(200),
		@MainTainInventory bit = 1,@DealCateGoryID int=0,@ItemCategoryID int=0,@BomId int,@ProductIntflowID int=0,
        @data_ManufacturingDetail  data_ManufacturingDetail  ,
        @data_ItemBatchDetail  data_ItemBatchDetail  ,
        @data_ItemBatchDetailFinish  data_ItemBatchDetail ,@ManufacturingID int=0,@isExchange bit=0
		Select @DealCateGoryID=POSDealsCategory from gen_SystemConfiguration where CompanyID=@CompanyID
		
declare Salecursor cursor for
select RowID from @data_SalePosDetail
open Salecursor
fetch next from Salecursor into @RowID
while @@FETCH_STATUS = 0
	begin

	select @ItemId = ItemId,@Quantity=Quantity,@StockRate=ItemRate ,@isExchange=isExchange
    
	From @data_SalePosDetail		 where RowID = @RowID
		
		Select @ItemCategoryID=CategoryID,@MainTainInventory = MaintainInventory from InventItems where ItemId=@ItemId

		Select @BomId=BOMID from gen_BOMInfo where ItemId=@ItemId
		if(@BomId>0)
		begin
		insert into @data_ManufacturingDetail (RowID,ItemId,BOMQuantity,ActualQuantity,WHID,StockRate,BOMFormulaQuantity) 
Select ROW_NUMBER() Over(  order by ItemID)-1 as ROwId,ItemId,Quantity,Quantity*@Quantity,@WHID,0 ,1 from gen_BOMDetail where BOMID=@BomId
exec data_ManufacturingInfo_Insert @ManufacturingID=@ManufacturingID output,@UserID=@UserID,@CompanyID=@CompanyID,@FiscalID=@FiscalID,@BomId=@BomId,@ItemId=@ItemId,@ManufacturingDate=@SalePosDate,@Quantity=@Quantity,@WHID=@WHID,@ManufacturingStyle='STYLE 1',@IsTaxable=@IsTaxable,@data_ManufacturingDetail=@data_ManufacturingDetail,@data_ItemBatchDetail=@data_ItemBatchDetail,@data_ItemBatchDetailFinish=@data_ItemBatchDetailFinish,@LooseQuantity=@Quantity		end
		--if	 @returnSale = 0
		--BEGIN
			exec GetStockQuantity @ItemId ,@WHID , @SalePosDate , @stockQty output , @ItemName out , @CompanyID , '' , '' , 
			null , null , null , 1 , @IsTaxable
			if (( @stockQty < @Quantity ) and @MainTainInventory=1)
			BEGIN
					set @ERRORMSG = 'Stock is not enough of Item ' + @ItemName + ' Avaliable Stock '+  convert(varchar, @stockQty)	 + ' Required Quantity is ' + convert(varchar, @Quantity)	
					RAISERROR (@ERRORMSG , 16, 1 ) ;
					return
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
		isExchange
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
		isExchange

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
				@FiscalID , @CompanyID , @IsTaxable
				exec tempOutflowDataTable_Insert @ProductOutflowID ,'POS'
				end
				Update data_salePosDetail set StockRate=@StockRate where SalePOSDetailID=@SaleDetailID
			END
	
	FETCH NEXT FROM Salecursor INTO @RowID
	END

close Salecursor
deallocate Salecursor


declare @ISOfflineServer bit=0
Select  @ISOfflineServer=ISNULL(IsofflineServer,0) from gen_posConfiguration where WHID=@WHID

if @ISOfflineServer=1
begin

exec  data_SalePOSInfo_InsertAccountOffline @SalePosID = @SalePosID, @CompanyID = @CompanyID, @SalePosDate = @SalePosDate , @WHID = @WHID , 
@NetAmount = @NetAmount , @SaleInvoiceNo = @SaleInvoiceNo , @UserID = @UserID , @FiscalID = @FiscalID ,@EditMode = 0,
@AmountReceivable = @AmountReceivable

end
---========================== Sale Stock In Working End Here =============================


END
else
BEGIN
---========== Sale Return Start Here ================
declare @SalePosReturnID bigint=0
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
		InvoiceType
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
		@InvoiceType
		)
	set @SalePosReturnID = SCOPE_IDENTITY()

	--Checking Total Cash Remaining 
DECLARE @Amount decimal(18,2)=0 
select @Amount=(select isnull(sum(Amount),0) as Amount from data_CashIn where Date=cast(GETDATE() as date))
-
(select isnull(sum(Amount),0) as Amount from data_CashOut where Date=cast(GETDATE() as date)) 
--select  @Amount
declare @ErrorMessage nvarchar(1000),@RemarksonDirectReturn nvarchar(Max)='Direct Sale Return'
if	@Amount>@AmountPayable
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
declare @PosSaleReturnDetailID int ,@PosStockRate numeric(14,5) , @PosQuantity numeric(10,2),@PosItemId int,@PosstockQty numeric(14,2)
	
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
	select @PosItemId = ItemId,@PosQuantity=Quantity,@PosStockRate=ItemRate 
    --@MainTainInventory = MaintainInventory,
	From @data_SalePosDetail	 where RowID = @PractitionerId



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
		MinQuantity
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
		MinQuantity
		From @data_SalePosDetail 
		where RowID = @PractitionerId

	set @PosSaleReturnDetailID = SCOPE_IDENTITY()

	--watch this
	exec data_ProductInflow_Insert @productInflowID out,@PosItemId,@PosSaleReturnDetailID,'POS RETURN',@WHID, @SalePosDate , 
				@PosStockRate,@PosQuantity,@PosQuantity,@FiscalID , @CompanyID ,@IsTaxable
				exec tempInflowDataTable_Insert @productInflowID ,'POS RETURN'
	--watht this end
update data_SalePosReturnDetail set IsLog=1 where SalePosReturnDetailID=@PosSaleReturnDetailID

    FETCH NEXT FROM MY_CURSOR INTO @PractitionerId
END
CLOSE MY_CURSOR
DEALLOCATE MY_CURSOR

---========================== Sale Stock Return Working End Here =============================



END










GO
/****** Object:  StoredProcedure [dbo].[POSdata_StockArrivalManualInfo_InsertContinuosSeriel]    Script Date: 3/28/2022 6:55:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockArrivalManualInfo_InsertContinuosSeriel]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_StockArrivalManualInfo_InsertContinuosSeriel] AS' 
END
GO




ALTER procedure [dbo].[POSdata_StockArrivalManualInfo_InsertContinuosSeriel] 
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
	exec POSGetVoucherNoSContinuos @Fieldname=N'ArrivalNo',@TableName=N'data_StockArrivalInfo',@CheckTaxable= 1 ,@PrimaryKeyValue = @ArrivalID,@PrimaryKeyFieldName = '@ArrivalID' ,
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
			exec POSGetVoucherNoSContinuos @Fieldname=N'ArrivalNo',@TableName=N'data_StockArrivalInfo',@CheckTaxable= 1 ,@PrimaryKeyValue = @ArrivalID,@PrimaryKeyFieldName = '@ArrivalID' ,
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
/****** Object:  StoredProcedure [dbo].[POSGetVoucherNoSContinuos]    Script Date: 3/28/2022 6:55:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSGetVoucherNoSContinuos]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSGetVoucherNoSContinuos] AS' 
END
GO

ALTER procedure [dbo].[POSGetVoucherNoSContinuos] 
@Fieldname varchar(100),
@TableName varchar(100),
@CheckTaxable bit,
@PrimaryKeyValue int,
@PrimaryKeyFieldName varchar(500),
@voucherDate date = null ,
@voucherDateFieldName varchar(30) = null,
@companyID int = 0 ,
@companyFieldName varchar(30) = 'CompanyID',
@FiscalID int = 0 ,
@FiscalIDFieldName varchar(30) = 'FiscalID',
@BranchID int = 0 ,
@BranchIDFieldName varchar(30) = 'BranchID',
@IsTaxable bit = 0 ,
@WhereClause varchar(2000) = ''

as

declare @sql nvarchar(4000),@WC nvarchar(4000)='' ,@vNo int

	if @PrimaryKeyValue > 0 
	BEGIN
		set @WC += ' and ' + @PrimaryKeyFieldName + ' <> ' + CONVERT(varchar(6), @PrimaryKeyValue)
	END

	if @companyID > 0 
	BEGIN
		set @WC += ' and ' + @companyFieldName + ' = ' + CONVERT(varchar(6), @companyID)
	END

	if @FiscalID > 0 
	BEGIN
		set @WC += ' and ' + @FiscalIDFieldName + ' = ' + CONVERT(varchar(6), @FiscalID)
	END
	if @BranchID > 0 
	BEGIN
		set @WC += ' and ' + @BranchIDFieldName + ' = ' + CONVERT(varchar(6), @BranchID)
	END
	set @WC += @WhereClause


	
	

	if @CheckTaxable = 1 
	BEGIN
		set @WC += ' and IsTaxable = ' + CONVERT(varchar, @IsTaxable)
	END


set @sql = 'select @vNo = min([from]) from (select (select isnull(max(CONVERT(numeric,'+ @Fieldname + '))+1,1) from '+ @TableName +' where '+ @Fieldname + ' < a.'+ @Fieldname + @WC + ') as [from],
     a.'+ @Fieldname + ' - 1 as [to]
  from '+ @TableName +' a where a.'+ @Fieldname + ' != 1'
	set @sql +=	@WC

	set @sql += ' and not exists (
        select 1 from '+ @TableName +' b where b.'+ @Fieldname + ' = a.'+ @Fieldname + ' - 1'
	
	set @sql +=	@WC

set @sql += '))a'

  --print(@sql)

  exec sp_executesql @sql ,N'@vNo int output', @vNo output

	if @vNo is null
	BEGIN
		set @sql = 'select @vNo = ISNULL(max(CONVERT(numeric,'+ @Fieldname + ')),0) +1  from '+ @TableName +' where 0 = 0 '
		set @sql +=	@WC

		exec sp_executesql @sql ,N'@vNo int output', @vNo output
	END

  select @vNo  as MaxNo

  
  

GO
/****** Object:  StoredProcedure [dbo].[rpt_CashBookCounterWise]    Script Date: 3/28/2022 6:55:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpt_CashBookCounterWise]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[rpt_CashBookCounterWise] AS' 
END
GO

ALTER procedure [dbo].[rpt_CashBookCounterWise] 
@FromDate date=null, 
@ToDate date=null ,
@CounterID int=0
as
(select ISNULL(data_SalePosInfo.SalePOSNo,(Select SalePOSNo from data_SalePosInfo inner join data_posBillRecoviers on data_posBillRecoviers.SalePosID=data_SalePosInfo.SalePosID  Where data_posBillRecoviers.RecoveryID=data_CashIn.SourceID and SourceName='BillRecovery')) as InvoiceNumber, SourceID,(SourceName +' '+ISNULL(Remarks,'')) as SourceName,Amount,FORMAT( [Date] ,'dd-MMM-yyyy') as Date,TimeStamp,Amount as Debit,0 as Credit,1 as CashType from data_CashIn left join data_SalePosInfo on data_SalePosInfo.SalePosID=SourceID and SourceName='POS'

where Date  between @FromDate and @ToDate and data_CashIn.CounterID=@CounterID)
union all
(select data_SalePosReturnInfo.SalePOSNo as InvoiceNumber, SourceID,ISNULL(Remarks,SourceName) as SourceName,Amount,FORMAT( [Date] ,'dd-MMM-yyyy') as Date,TimeStamp,0 as Debit,Amount as Credit,0 as CashType from data_CashOut left join data_SalePosReturnInfo on data_SalePosReturnInfo.SalePosReturnID=SourceID and SourceName='POS RETURN'
where Date between @FromDate and @ToDate and data_Cashout.CounterID=@CounterID) 
order by TimeStamp asc









GO
