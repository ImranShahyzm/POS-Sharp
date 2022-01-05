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
ALTER TABLE dbo.data_SalePosReturnInfo ADD
	SaleManId int NULL
GO
ALTER TABLE dbo.data_SalePosReturnInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


/****** Object:  StoredProcedure [dbo].[data_SalePosReturnInfo_Insert]    Script Date: 9/1/2021 5:13:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
@SaleManId int =NULL
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
		SaleManId
	)
	Select 
	SalePosID, 
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
	@SaleInvoiceNo,
	@MenuId,
	@InvoiceType,
	@SaleManId

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
DECLARE @PractitionerId int
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
if(@ManufacturingID>0)
begin
exec data_ManufacturingInfo_delete @ManufacturingID=@ManufacturingID
end
    FETCH NEXT FROM MY_CURSOR INTO @PractitionerId
END
CLOSE MY_CURSOR
DEALLOCATE MY_CURSOR






		--update data_SalePosInfo set
		--ModifyUserID=@UserID , 
		--ModifyUserDateTime=GETDATE() ,
		--CompanyID=@CompanyID,
		--FiscalID=@FiscalID,
		--SalePosDate=@SalePosDate,
		--WHID=@WHID,
		--TaxAmount=@TaxAmount,
		--GrossAmount=@GrossAmount,
		--DiscountPercentage=@DiscountPercentage,
		--DiscountAmount=@DiscountAmount,
		--DiscountTotal=@DiscountTotal,
		--OtherCharges=@OtherCharges,
		--NetAmount=@NetAmount,
		--AmountReceive=@AmountReceive,
		--AmountReturn=@AmountReturn,
		--AmountInAccount=@AmountInAccount,
		--AmountReceivable=@AmountReceivable,
		--AmountPayable=@AmountPayable
		--where SalePosID=@SalePosID
		
		--delete from data_ProductOutflow where SourceName = 'POS' and SourceID in (select SalePosDetailID from data_SalePosDetail where SalePosID =@SaleID) 
		--delete data_SalePosDetail where SalePosID=@SalePosID
		DECLARE @Amount decimal(18,2)=0 
		Select @AmountPayable=sum(TotalAmount)-@DiscountTotal from @data_SalePosDetail
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
		







--declare @RowID int,@SaleDetailID int ,@StockRate numeric(14,5) , @Quantity numeric(10,2),@ItemId int,@stockQty numeric(14,2),@ItemName varchar(200),@ERRORMSG varchar(200),
--		@MainTainInventory bit = 1
 
--declare firstcursor cursor for
--select RowID from @data_SalePosDetail
--open firstcursor
--fetch next from firstcursor into @RowID
--while @@FETCH_STATUS = 0
--	begin

--	select @ItemId = ItemId,@Quantity=Quantity,@StockRate=ItemRate 
--    --@MainTainInventory = MaintainInventory,
--	From @data_SalePosDetail		 where RowID = @RowID
		
--		set @SalePosDate=GETDATE()
		
--		--if	 @returnSale = 0
--		--BEGIN
--			exec GetStockQuantity @ItemId ,@WHID , @SalePosDate , @stockQty output , @ItemName out , @CompanyID , '' , '' , 
--			null , null , null , 1 , @IsTaxable
--			if  @stockQty < @Quantity 
--			BEGIN
--					set @ERRORMSG = 'Stock is not enough of Item ' + @ItemName + ' Avaliable Stock '+  convert(varchar, @stockQty)	 + ' Required Quantity is ' + convert(varchar, @Quantity)	
--					RAISERROR (@ERRORMSG , 16, 1 ) ;
--					return
--			END
--		--END
	
--		Insert Into data_SalePosDetail (
--		SalePosID,
--		ItemId,
--		Quantity,
--		ItemRate,
--		TaxPercentage,
--		TaxAmount,
--		DiscountPercentage,
--		DiscountAmount,
--		TotalAmount
--		) Select
--		@SalePosID ,
--		ItemId,
--		Quantity,
--		ItemRate,
--		TaxPercentage,
--		TaxAmount,
--		DiscountPercentage,
--		DiscountAmount,
--		TotalAmount
--		From @data_SalePosDetail where RowID = @RowID
		
--		set @SalePosDetailID = SCOPE_IDENTITY()		

--		declare @ProductOutflowID int
		
--			if @MainTainInventory = 1 
--			BEGIN		
--				BEGIN
--					exec GetWeightedRateForItem @ItemId, @WHID ,@SalePosDate ,@SalePosDate ,@StockRate output , @CompanyID , @IsTaxable
--				END
--				--update data_SaleDetail set StockRate = @StockRate where SaleDetailID = @SalePosReturnID
--				exec data_ProductOutflow_Insert @ProductOutflowID output,null,@ItemId,@SalePosDetailID,'POS',@WHID, @SalePosDate ,@StockRate,@Quantity, 
--				@FiscalID , @CompanyID , @IsTaxable
--				exec tempOutflowDataTable_Insert @ProductOutflowID ,'POS'
--			END
		

--	FETCH NEXT FROM firstcursor INTO @RowID
--	END

--close firstcursor
--deallocate firstcursor


--set @SalePosID =@SalePosReturnID
select @SalePosID

Go


/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Update]    Script Date: 9/1/2021 5:32:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[data_SalePosInfo_Update] 
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
@LinckedBill int =NULL

as
declare @returnSale bit=0
declare @IsTaxable bit =0
--set @SalePosDate=GETDATE()

declare @MaxTable as MaxTable 
declare @MaxTable2 as MaxTable
if	 @SalePosID > 0
BEGIN
	
	Update  data_SalePosInfo set 
		ModifyUserID=@UserID,
		ModifyUserDateTime=GETDATE(),
		CompanyID=@CompanyID,
		FiscalID=@FiscalID,
		SalePosDate=@SalePosDate,
		WHID=@WHID,
		TaxAmount=@TaxAmount,
		GrossAmount=@GrossAmount,
		DiscountPercentage=@DiscountPercentage,
		DiscountAmount=@DiscountAmount,
		DiscountTotal=@DiscountTotal,
		OtherCharges=@OtherCharges,
		NetAmount=@NetAmount,
		AmountReceive=@AmountReceive,
		AmountReturn=@AmountReturn,
		AmountInAccount=@AmountInAccount,
		AmountReceivable=@AmountReceivable,
		AmountPayable=@AmountPayable,
		CustomerPhone=@CustomerPhone,
		CustomerName=@CustomerName,
		
		ExchangeAmount=@ExchangeAmount,
		MenuId=@MenuId,
		InvoiceType=@InvoiceType,
		CardNumber=@CardNumber,
		CardName=@CardName,
		CashPayment=@CashPayment,
		CardPayment=@CardPayment,
		SaleManId=@SaleManId,
		RiderAmount=@RiderAmount,
		LinckedBill=@LinckedBill
	where SalePosID=@SalePosID
delete from data_CashIn where SourceName='POS' and SourceID=@SalePosID
Delete from data_ProductInflow where SourceName='POSEXCHANGE' and SourceID in (Select SalePosDetailID from data_SalePosDetail where SalePosID=@SalePosID)
Delete from data_ProductOutflow where SourceName='POS' and SourceID in (Select SalePosDetailID from data_SalePosDetail where SalePosID=@SalePosID)
Delete from data_SalePosDetail where SalePosID=@SalePosID
	EXEC [dbo].[data_Cash_Insert]
		@SourceID = @SalePosID,
		@SourceName = N'POS',
		@Amount = @AmountReceivable,
		@CashType = 1,
		@SalePosDate=@SalePosDate
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
		
end

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
		if(@BomId>0 and @ItemCategoryID=@DealCateGoryID)
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
				update data_SalePosDetail set StockRate = @StockRate where SalePosDetailID = @SaleDetailID
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
				
			END
	
	FETCH NEXT FROM Salecursor INTO @RowID
	END

close Salecursor
deallocate Salecursor


---========================== Sale Stock In Working End Here =============================


Go






