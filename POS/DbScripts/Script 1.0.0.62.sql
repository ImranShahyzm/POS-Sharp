
/****** Object:  StoredProcedure [dbo].[data_SalePOSReturnInfo_InsertAccountOffline]    Script Date: 10/8/2021 3:41:27 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePOSReturnInfo_InsertAccountOffline]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePOSReturnInfo_InsertAccountOffline]
GO
/****** Object:  StoredProcedure [dbo].[data_SalePosReturnInfo_Insert]    Script Date: 10/8/2021 3:41:27 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosReturnInfo_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePosReturnInfo_Insert]
GO
/****** Object:  StoredProcedure [dbo].[data_SalePOSInfo_InsertAccountOffline]    Script Date: 10/8/2021 3:41:27 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePOSInfo_InsertAccountOffline]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePOSInfo_InsertAccountOffline]
GO
/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Insert]    Script Date: 10/8/2021 3:41:27 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePosInfo_Insert]
GO
/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Insert]    Script Date: 10/8/2021 3:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_SalePosInfo_Insert] AS' 
END
GO
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
	@FiscalIDFieldName=N'FiscalID',@IsTaxable=@IsTaxable,@MenuId=@MenuId,@MenuFieldName=N'MenuId'
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
		@SalePosDate=@SalePosDate
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
		@SalePosDate=@SalePosDate
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
declare @ErrorMessage nvarchar(1000)
if	@Amount>@AmountPayable
begin
	EXEC [dbo].[data_Cash_Insert]
	@SourceID = @SalePosReturnID,
	@SourceName = N'POS Return',
	@Amount = @AmountPayable,
	@CashType = 0
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
/****** Object:  StoredProcedure [dbo].[data_SalePOSInfo_InsertAccountOffline]    Script Date: 10/8/2021 3:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePOSInfo_InsertAccountOffline]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_SalePOSInfo_InsertAccountOffline] AS' 
END
GO






ALTER procedure [dbo].[data_SalePOSInfo_InsertAccountOffline] 
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
@EditMode bit=0


as 

declare @GLvDetail as GLvDetail ,@vID int, @vType int , @PartyGLID int , @WHGLID int , @VoucherNo varchar(10),@MasterDescription varchar(200),
@RoundingAccount int ,@DrTotal numeric(14,3),@CrTotal numeric(14,3),@CashAccount int, @SaleReturnAccount int, @Total numeric(14,3),
@StockConfig tinyint,@DescriptionStyle nvarchar(50),@Description nvarchar(500) = '', @TradeDiscountAccount int=0
,@FreightDiscountAccount int=0,@LoadingUnloadingAccount int=0,@OtherServicesAccount int=0


select @vType =SaleVoucherTypeID,@CashAccount = CashAccount,@RoundingAccount=RoundingAccount
 from gen_SystemConfiguration 
where CompanyID = @CompanyID

Select @CashAccount=CashAccountPOS from gen_posConfiguration where WHID=@WHID

set @MasterDescription = 'POS Sale Voucher No ' + CONVERT(varchar, @SaleInvoiceNo)

declare @SaleAmount numeric(18, 3) ,@StockAmount numeric(18,3)

if @EditMode = 1
BEGIN
	select @vID = AccountVoucherID from data_salePosInfo where SalePOSID = @SALEPOSID 	
END
else
BEGIN
	set @vID = 0	
	--exec GLvMAIN_MaxVoucherNo @CompanyID,@vType, @VoucherNo output , @FiscalID,@IsTaxable,@vDate
END





	select sum(TotalAmount) as DtSoldAmount,InventCategory.StockAccount,InventCategory.CGSAccount,InventCategory.SaleAccount , 0 as DTypeID,0 as DvaluesID,sum(Quantity * StockRate) StockAmount into #temp
	from Data_salePosDetail p join InventItems on p.ItemId = InventItems.ItemId join InventCategory on InventItems.CategoryID = InventCategory.CategoryID where SalePosID=@SalePOSID
	group by InventCategory.CategoryID,InventCategory.StockAccount,InventCategory.CGSAccount,InventCategory.SaleAccount

	select @StockAmount = sum(StockAmount) from #temp
	select @SaleAmount = sum(DtSoldAmount) from #temp
	
	
	insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
	select CGSAccount , DTypeID,DvaluesID,@MasterDescription ,StockAmount from #temp
	insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,cr)
	select StockAccount , DTypeID,DvaluesID,@MasterDescription ,StockAmount from #temp



	insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,cr)
	select SaleAccount , DTypeID,DvaluesID,@MasterDescription ,DtSoldAmount from #temp

insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
values(@CashAccount,0,0,@MasterDescription, @AmountReceivable)





Select @DrTotal=sum(dr),@CrTotal=sum(cr) from @GLvDetail
	if @DrTotal - @CrTotal > 0
	BEGIN
		insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,cr)
		values(@RoundingAccount,0,0,@MasterDescription,@DrTotal - @CrTotal)

	END
	else if  @DrTotal - @CrTotal < 0
	BEGIN
		insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
		values(@RoundingAccount,0,0,@MasterDescription, @CrTotal - @DrTotal)

	END

set @Total = @NetAmount + @StockAmount




exec GLvMAIN_Insert  @GLvDetail=@GLvDetail , @vID = @vID output ,@vType =@vType ,@vNO = @VoucherNo , @vDate = @SalePosDate ,@vremarks =@MasterDescription ,@FiscalID = @FiscalID , @Comp_Id =@CompanyID,
	 @vUserID=@UserID,@TotalDr = @Total , @TotalCr = @Total , @ReadOnly = 1, @BranchID=null,@IsTaxable = 0

	 update data_SalePosInfo set AccountVoucherID = @vID where SALEPOSID = @SALEPOSID















GO
/****** Object:  StoredProcedure [dbo].[data_SalePosReturnInfo_Insert]    Script Date: 10/8/2021 3:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosReturnInfo_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_SalePosReturnInfo_Insert] AS' 
END
GO









ALTER procedure [dbo].[data_SalePosReturnInfo_Insert] 
@UserID int = null , 
@CompanyID int = null , 
@FiscalID int = null ,
@SalePosDate	date	=null,
@WHID	int	=null,
@TaxAmount	decimal(18, 2)	=null,
@GrossAmount	decimal(18, 2)	=null,
@DiscountPercentage	decimal(18, 2)	=null,
@DiscountAmount	decimal(18, 2)	=null,
@DiscountTotal	decimal(18, 2)	=null,
@OtherCharges	decimal(18, 2)	=null,
@NetAmount	decimal(18, 2)	=null,
@AmountReceive	decimal(18, 2)	=null,
@AmountReturn	decimal(18, 2)	=null,
@AmountInAccount	decimal(18, 2)=null,
@AmountReceivable	decimal(18, 2)	=null,
@AmountPayable	decimal(18, 2)	=null,
@data_SalePosDetail  data_SalePosDetail   readonly,
@SalePosID bigint output,
@CustomerPhone nvarchar(50)=null,
@CustomerName  nvarchar(50)=null,
@SaleInvoiceNo int=0,
@MenuId int=0,
@InvoiceType int=0,
@CustomerID int=null,
@RiderAmount numeric(18,3)=0,
@LinckedBill int =NULL,
@SaleManId int =NULL,
@CounterID int=NULL
as
declare @returnSale bit=0
declare @IsTaxable bit =0
declare @SalePosReturnID bigint=0
declare @SalePosReturnDetailID bigint=0
declare @SalePosDetailID bigint=0

declare @MaxTable as MaxTable 
declare @MaxTable2 as MaxTable

declare  @SaleID bigint
set @SaleID=@SalePosID
--set @SalePOSReturnID=1

declare @WhereClause1 nvarchar(4000),@WhereClauseDetail1 nvarchar(4000),@ReturnSaleID bigint
set @WhereClause1=' '
select @SalePosID=SalePosID from data_SalePosInfo where saleposNo=@SaleInvoiceNo and SalePosDate=@SalePosDate
--if(@ReturnSaleID is null)
--	begin 
--		set @ReturnSaleID=0
--	end
--	if @ReturnSaleID=0 
--	begin
--	set @WhereClause1='select * from data_SalePosDetail where SalePosID='+cast(@SalePosID as nvarchar(10));
--	end
--	else
--	begin
--		set @WhereClause1='select * from data_SalePosReturnDetail where IsLog=0 and SalePosReturnID='+cast(@ReturnSaleID as nvarchar(10));
--	end

declare @IsLog bit
select @IsLog=IsLogActive from gen_systemConfiguration where CompanyID=@CompanyID


if(@SalePosID>0)
begin
exec GetVoucherNoPos @Fieldname=N'SalePOSNo',@TableName=N'data_SalePosReturnInfo',@CheckTaxable= 0 ,@PrimaryKeyValue = @SalePosReturnID,@PrimaryKeyFieldName = 'SalePosReturnID' ,
	@voucherDate=@SalePOSDate,@voucherDateFieldName=N'SalePosReturnDate',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=@FiscalID, 
	@FiscalIDFieldName=N'FiscalID',@IsTaxable=@IsTaxable
	select @SaleInvoiceNo = VoucherNo from @MaxTable

--This Will Record Sale Replace or Sale Edit

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
		CustomerPhone,
		CustomerName ,
		SalePOSNo,
		MenuId,
		InvoiceType,
		SaleManId,
		CounterID
	)
	Select 
	SalePosID, 
	EntryUserID,
	EntryUserDateTime,
	CompanyID,
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
	@MenuId,
	@InvoiceType,
	@SaleManId,
	@CounterID

	from data_SalePosInfo
	where SalePosID=@SalePosID
	set @SalePosReturnID = SCOPE_IDENTITY()
	

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
		CartonSize,
		Carton,
		TotalQuantity,
		SchemeID,
		MinQuantity

		) Select
		@SalePosReturnID ,
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
		MinQuantity

		From @data_SalePosDetail 
		
end





		 declare @productInflowID int
DECLARE @PractitionerId int,@StockRate numeric(18,3)=0
declare @PosSaleReturnDetailID int ,@PosStockRate numeric(14,5) , @PosQuantity numeric(10,2),@PosItemId int,@PosstockQty numeric(14,2),@ManufacturingID int=0
	
DECLARE MY_CURSOR CURSOR 
  LOCAL STATIC READ_ONLY FORWARD_ONLY
FOR 
SELECT SalePosReturnDetailID from data_SalePosReturnInfo inner join data_SalePosReturnDetail 
on data_SalePosReturnInfo.SalePosReturnID=data_SalePosReturnDetail.SalePosReturnID 
where data_SalePosReturnDetail.IsLog=0 and  data_SalePosReturnInfo.SalePosID=@SalePosID

OPEN MY_CURSOR
FETCH NEXT FROM MY_CURSOR INTO @PractitionerId
WHILE @@FETCH_STATUS = 0
BEGIN 
    --Do something with Id here
    PRINT @PractitionerId
	SELECT @PosSaleReturnDetailID=SalePosReturnDetailID,@PosItemId=ItemId,@PosStockRate=ItemRate,@PosQuantity=Quantity,
	@SalePosDetailID=SalePosDetailID 
from data_SalePosReturnInfo inner join data_SalePosReturnDetail 
on data_SalePosReturnInfo.SalePosReturnID=data_SalePosReturnDetail.SalePosReturnID 
where data_SalePosReturnDetail.IsLog=0 and SalePosReturnDetailID=@PractitionerId
Select @ManufacturingID=ManaufacturingID from data_SalePosDetail where SalePosDetailID=@SalePosDetailID

	--watch this
	exec data_ProductInflow_Insert @productInflowID out,@PosItemId,@PosSaleReturnDetailID,'POS RETURN',@WHID, @SalePosDate , 
				@PosStockRate,@PosQuantity,@PosQuantity,@FiscalID , @CompanyID ,@IsTaxable
				exec tempInflowDataTable_Insert @productInflowID ,'POS RETURN'
	--watht this end
update data_SalePosReturnDetail set IsLog=1 where SalePosReturnDetailID=@PosSaleReturnDetailID


	exec GetWeightedRateForItem @PosItemId, @WHID ,@SalePosDate ,@SalePosDate ,@StockRate output , @CompanyID , @IsTaxable
			

update data_SalePosReturnDetail set StockRate=@StockRate where SalePosReturnDetailID=@PosSaleReturnDetailID



if(@ManufacturingID>0)
begin
exec data_ManufacturingInfo_delete @ManufacturingID=@ManufacturingID
end
    FETCH NEXT FROM MY_CURSOR INTO @PractitionerId
END
CLOSE MY_CURSOR
DEALLOCATE MY_CURSOR


declare @ISOfflineServer bit=0
Select  @ISOfflineServer=ISNULL(IsofflineServer,0) from gen_posConfiguration where WHID=@WHID

if @ISOfflineServer=1
begin

exec  data_SalePOSReturnInfo_InsertAccountOffline @SalePosReturnID=@SalePosReturnID, @SalePosID = @SalePosID, @CompanyID = @CompanyID, @SalePosDate = @SalePosDate , @WHID = @WHID , 
@NetAmount = @NetAmount , @SaleInvoiceNo = @SaleInvoiceNo , @UserID = @UserID , @FiscalID = @FiscalID ,@EditMode = 0,
 @AmountReceivable = @NetAmount

end




		DECLARE @Amount decimal(18,2)=0 
		Select @AmountPayable=@NetAmount
		select @Amount=(select isnull(sum(Amount),0) as Amount from data_CashIn where Date=cast(GETDATE() as date))
                                  -
         (select isnull(sum(Amount),0) as Amount from data_CashOut where Date=cast(GETDATE() as date)) 
		 --select @Amount
		declare @ErrorMessage nvarchar(1000)
		if @AmountPayable>0
		begin
			if	@Amount>@AmountPayable
			begin
				EXEC [dbo].[data_Cash_Insert]
				@SourceID = @SalePosID,
				@SourceName = N'POS Return',
				@Amount = @AmountPayable,
				@CashType = 0,
				@SalePosDate=@SalePosDate
			end
			else
				begin
				set @ErrorMessage = 'Not have enough cash!'
					RAISERROR (@ErrorMessage , 16, 1 ) ;
					return
				end
		end
		else
		begin
			EXEC [dbo].[data_Cash_Insert]
			@SourceID = @SalePosID,
			@SourceName = N'POS Replace',
			@Amount = @AmountReceivable,
			@CashType = 1
		end
		











select @SalePosID
GO
/****** Object:  StoredProcedure [dbo].[data_SalePOSReturnInfo_InsertAccountOffline]    Script Date: 10/8/2021 3:41:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePOSReturnInfo_InsertAccountOffline]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_SalePOSReturnInfo_InsertAccountOffline] AS' 
END
GO







ALTER procedure [dbo].[data_SalePOSReturnInfo_InsertAccountOffline] 
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
@SalePosID bigint =0,
@SalePosReturnID int=0,
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
@EditMode bit=0


as 

declare @GLvDetail as GLvDetail ,@vID int, @vType int , @PartyGLID int , @WHGLID int , @VoucherNo varchar(10),@MasterDescription varchar(200),
@RoundingAccount int ,@DrTotal numeric(14,3),@CrTotal numeric(14,3),@CashAccount int, @SaleReturnAccount int, @Total numeric(14,3),
@StockConfig tinyint,@DescriptionStyle nvarchar(50),@Description nvarchar(500) = '', @TradeDiscountAccount int=0
,@FreightDiscountAccount int=0,@LoadingUnloadingAccount int=0,@OtherServicesAccount int=0


select @vType =SaleReturnVoucherTypeID,@CashAccount = CashAccount,@RoundingAccount=RoundingAccount
 from gen_SystemConfiguration 
where CompanyID = @CompanyID

Select @CashAccount=CashAccountPOS from gen_posConfiguration where WHID=@WHID

set @MasterDescription = 'POS Sale Return No ' + CONVERT(varchar, @SaleInvoiceNo)

declare @SaleAmount numeric(18, 3) ,@StockAmount numeric(18,3)

if @EditMode = 1
BEGIN
	select @vID = AccountVoucherID from data_SalePosReturnInfo where SalePosReturnID = @SalePosReturnID 	
END
else
BEGIN
	set @vID = 0	
	--exec GLvMAIN_MaxVoucherNo @CompanyID,@vType, @VoucherNo output , @FiscalID,@IsTaxable,@vDate
END





	select sum(p.TotalAmount) as DtSoldAmount,InventCategory.StockAccount,InventCategory.CGSAccount,InventCategory.SaleAccount , 0 as DTypeID,0 as DvaluesID,sum(p.Quantity * p.StockRate) StockAmount into #temp
	from data_SalePosReturnDetail p join InventItems on p.ItemId = InventItems.ItemId join InventCategory on InventItems.CategoryID = InventCategory.CategoryID
	
	 where SalePosReturnID=@SalePosReturnID
	group by InventCategory.CategoryID,InventCategory.StockAccount,InventCategory.CGSAccount,InventCategory.SaleAccount

	select @StockAmount = sum(StockAmount) from #temp
	select @SaleAmount = sum(DtSoldAmount) from #temp
	
	insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
	select StockAccount , DTypeID,DvaluesID,@MasterDescription ,StockAmount from #temp

	insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,cr)
	select CGSAccount , DTypeID,DvaluesID,@MasterDescription ,StockAmount from #temp


	insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
	select SaleAccount , DTypeID,DvaluesID,@MasterDescription ,DtSoldAmount from #temp

insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,cr)
values(@CashAccount,0,0,@MasterDescription, @AmountReceivable)





Select @DrTotal=sum(dr),@CrTotal=sum(cr) from @GLvDetail
	if @DrTotal - @CrTotal > 0
	BEGIN
		insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,cr)
		values(@RoundingAccount,0,0,@MasterDescription,@DrTotal - @CrTotal)

	END
	else if  @DrTotal - @CrTotal < 0
	BEGIN
		insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
		values(@RoundingAccount,0,0,@MasterDescription, @CrTotal - @DrTotal)

	END

set @Total = @NetAmount + @StockAmount




exec GLvMAIN_Insert  @GLvDetail=@GLvDetail , @vID = @vID output ,@vType =@vType ,@vNO = @VoucherNo , @vDate = @SalePosDate ,@vremarks =@MasterDescription ,@FiscalID = @FiscalID , @Comp_Id =@CompanyID,
	 @vUserID=@UserID,@TotalDr = @Total , @TotalCr = @Total , @ReadOnly = 1, @BranchID=null,@IsTaxable = 0

	 update data_SalePosReturnInfo set AccountVoucherID = @vID where SalePOsReturnID = @SalePOSReturnID
















GO
