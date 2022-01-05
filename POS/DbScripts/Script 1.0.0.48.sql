
/****** Object:  StoredProcedure [dbo].[data_Cash_Insert]    Script Date: 9/2/2021 9:39:19 AM ******/
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
@FiscalID int=0,
@Remarks nvarchar(max)=null

--@CashInOut bigint output

as

if	 @CashType = 1
BEGIN
	Insert into data_CashIn( 
		SourceID,
		SourceName,
		Amount,
		Date,
		TimeStamp,
		Remarks
	)
	Values (
		@SourceID,
		@SourceName,
		@Amount,
		@SalePosDate,
		getdate(),
		@Remarks
	)	
	
--set @CashInOut = @@IDENTITY
END
else
BEGIN
declare @CashSource int=0,@ClosingTypeID int=0,@ClosingID int=@SourceID,@CashInOut int=0
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
		TimeStamp,
		Remarks
	)
	Values (
		@ClosingID,
		@SourceName,
		@Amount,
		@SalePosDate,
		getdate(),
		@Remarks
	)	
 set @CashInOut = @@IDENTITY
 
 end


 Go

 
/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Update]    Script Date: 9/2/2021 10:00:37 AM ******/
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
	delete from data_CashOut where SourceName='POS' and SourceID=@SalePosID
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


/****** Object:  StoredProcedure [dbo].[rpt_sale_invoice_Lincked]    Script Date: 9/2/2021 10:15:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER procedure [dbo].[rpt_sale_invoice_Lincked] 
@SaleInvoice bigint=0,
@LinckedBill int=0 
as
select CategoryName,InventItems.ItemNumber,InventWareHouse.PhoneNo,InventWareHouse.LocationAddress,InventWareHouse.WHDesc,
InventItems.ItenName,InventItems.UrduName,data_SalePosInfo.customerName,data_SalePosInfo.CustomerPhone,
data_SalePosInfo.SalePosNo as SalePosID,data_SalePosInfo.SalePosDate,data_SalePosInfo.TaxAmount, data_SalePosInfo.GrossAmount, data_SalePosDetail.DiscountPercentage, data_SalePosInfo.DiscountAmount, 
data_SalePosInfo.DiscountTotal, data_SalePosInfo.OtherCharges, data_SalePosInfo.NetAmount, data_SalePosInfo.AmountReceive, 
data_SalePosInfo.AmountReturn, data_SalePosInfo.SalePosReturnID, data_SalePosInfo.AmountInAccount, data_SalePosInfo.AmountReceivable, 
data_SalePosInfo.AmountPayable,GLCompany.*,
data_SalePosDetail.ItemId,data_SalePosDetail.Quantity,data_SalePosDetail.ItemRate,data_SalePosDetail.TotalAmount,data_SalePosDetail.DiscountAmount as DetailDiscount,
ISNULL(data_salePosInfo.LinckedBill,data_SalePosInfo.SalePosID) as LinkedBill
from data_SalePosInfo 
inner join data_SalePosDetail on data_SalePosInfo.SalePosID=data_SalePosDetail.SalePosID
inner join InventItems on data_SalePosDetail.ItemId=InventItems.ItemId
inner join GLCompany on GLCompany.Companyid=data_SalePosInfo.CompanyID
inner join InventWareHouse on InventWareHouse.WHID=data_SalePosInfo.WHID
left join InventCategory on InventCategory.CategoryID=InventItems.CategoryID
where data_SalePosInfo.SalePosID in (@LinckedBill) or data_SalePosInfo.SalePosID in (Select SalePosID from data_SalePosInfo where LinckedBill=@LinckedBill)
order by SalePosID



Go




/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Update]    Script Date: 9/2/2021 10:26:26 AM ******/
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
	delete from data_CashOut where SourceName='POS' and SourceID=@SalePosID
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









