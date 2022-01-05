/****** Object:  StoredProcedure [dbo].[get_POSStockMovement]    Script Date: 5/19/2021 3:42:27 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[get_POSStockMovement]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[get_POSStockMovement]
GO
/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_SelectAll]    Script Date: 5/19/2021 3:42:27 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_SelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePosInfo_SelectAll]
GO
/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_SelectAll]    Script Date: 5/19/2021 3:42:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_SelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_SalePosInfo_SelectAll] AS'
END
GO


ALTER procedure [dbo].[data_SalePosInfo_SelectAll]
@SelectMaster bit=1,
@SelectDetail bit=1,
@InvoiceNo bigint,
@SaleDate date=null,
@MenuId int=0

as

declare @ReturnSaleID bigint
select @ReturnSaleID=SalePosID from data_SalePosInfo where SalePosNo=@InvoiceNo and SalePosDate=@SaleDate
if((Select count(*) from data_SalePosReturnInfo where SalePosID=@ReturnSaleID)>0)
begin
			RAISERROR ('Already Sale Return has been Added..' , 16, 1 ) ;
			return
end
declare @WhereClause nvarchar(4000),@WhereClauseDetail nvarchar(4000)
set @WhereClause=' '
set @WhereClauseDetail=' '
if(@ReturnSaleID is null)
	begin
		set @ReturnSaleID=0
	end
if @ReturnSaleID!=0
	begin
		set @WhereClause=' where SalePOSNo='+cast(@InvoiceNo as nvarchar(10))
		set @WhereClause=Cast(@WhereClause as nvarchar(4000)) +' and SalePOSDate='''+cast(@SaleDate as nvarchar(50))+''''
		if @MenuId>0
		begin
		set @WhereClause=Cast(@WhereClause as nvarchar(4000)) +' and MenuID='''+cast(@MenuId as nvarchar(50))+''''
		end
		print @whereClause
		exec('select * from data_SalePosInfo '+ @WhereClause)
		exec('select InventItems.ItemNumber,InventItems.ItenName,data_SalePosDetail.* from data_SalePosDetail inner join InventItems on data_SalePosDetail.ItemId=InventItems.ItemId inner join data_SalePosInfo on data_salePosInfo.SalePosID=data_salePosDetail.SalePosID '+ @WhereClause)
	end
	else
	begin
		set @WhereClause=' where LogSourceID=0 and SalePosReturnID='+cast(@ReturnSaleID as nvarchar(10))
		set @WhereClauseDetail=' where IsLog=0 and SalePosReturnID='+cast(@ReturnSaleID as nvarchar(10))
		if @MenuId>0
		begin
		set @WhereClause=Cast(@WhereClause as nvarchar(4000)) +' and MenuID='''+cast(@MenuId as nvarchar(50))+''''
		end
		exec('select * from data_SalePosReturnInfo '+ @WhereClause)
		exec('select InventItems.ItemNumber, InventItems.ItenName,data_SalePosReturnDetail.* from data_SalePosReturnDetail inner join InventItems on data_SalePosReturnDetail.ItemId=InventItems.ItemId '+ @WhereClauseDetail)
	end












GO
/****** Object:  StoredProcedure [dbo].[get_POSStockMovement]    Script Date: 5/19/2021 3:42:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[get_POSStockMovement]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[get_POSStockMovement] AS'
END
GO



ALTER procedure [dbo].[get_POSStockMovement]

@PURCHASERETURN nvarchar(4000) = '',
@SALE nvarchar(4000) = '',
@SALERETURN nvarchar(4000) = '',
@FromDate nvarchar(100)=NULL,
@ToDate nvarchar(100)=NULL,
@WC nvarchar(4000) = '',
@CompanyID nvarchar(50)=''
as
begin
declare @SQL nvarchar(max)
declare @SQL1 nvarchar(max)

set @SQL = '
--------------------------- Sale ----------------------------
select sum(Quantity) as SaleQuantity,sum((data_SalePosDetail.Quantity*ItemRate)-data_SalePosDetail.DiscountAmount) as SaleNetAmount,data_SalePosDetail.ItemId
into #SaleTemp
from data_SalePosInfo inner join data_SalePosDetail on data_SalePosInfo.SalePosID = data_SalePosDetail.SalePOsID
where 0=0'+ @SALE +' group by data_SalePosDetail.ItemId

--------------------------- Sale Return ----------------------------
select sum(Quantity) as SaleReturnQuantity,sum(data_StockArrivalDetail.StockRate*Quantity) as SaleReturnNetAmount,data_StockArrivalDetail.ItemId
into #SaleReturnTemp
from data_StockArrivalInfo inner join data_StockArrivalDetail on data_StockArrivalInfo.ArrivalID = data_StockArrivalDetail.ArrivalID
where 0=0  '+ @SALERETURN +'group by data_StockArrivalDetail.ItemId


--------------------------- Purchase Return ----------------------------
select sum(Quantity) as PurchaseReturnQuantity,sum(data_StockIssuancetoPosKitchenDetail.StockRate * Quantity) as PurchaseReturnNetAmount,data_StockIssuancetoPosKitchenDetail.ItemId
into #PurchaseReturnTemp
from data_StockIssuancetoPosKitchen inner join data_StockIssuancetoPosKitchenDetail on data_StockIssuancetoPosKitchen.IssuanceID = data_StockIssuancetoPosKitchenDetail.IssuanceID
where 0=0  '+ @PURCHASERETURN +' group by data_StockIssuancetoPosKitchenDetail.ItemId'
set @SQL1='
--------------------------- Sale ----------------------------

Select * from(select cat.CategoryID,cat.CategoryName,ItemNumber,InventItems.ItemId,InventItems.ItenName,
dbo.GetOpeningStockQuantity(InventItems.ItemId,0,'+@FromDate+',0,inventItems.CompanyID,0) as OpeningAmount,
dbo.GetOpeningStockQuantity(InventItems.ItemId,0,'+ @ToDate +',0,inventItems.CompanyID,0) as ClosingAmount,
isnull(s.SaleQuantity,0) as SaleQuantity,isnull(s.SaleNetAmount,0) as SaleNetAmount,
isnull(sr.SaleReturnQuantity,0) as SaleReturnQuantity,isnull(sr.SaleReturnNetAmount,0) as SaleReturnNetAmount,
isnull(pr.PurchaseReturnQuantity,0) as PurchaseReturnQuantity,isnull(pr.PurchaseReturnNetAmount,0) as PurchaseReturnNetAmount
from InventItems
left outer join #SaleTemp s on InventItems.ItemId=s.ItemId
left outer join #SaleReturnTemp sr on InventItems.ItemId=sr.ItemId
left outer join #PurchaseReturnTemp pr on InventItems.ItemId=pr.ItemId
left join InventCategory cat on cat.CategoryID=InventItems.CategoryID
'+ @WC +')t where t.closingAmount>0
drop table #SaleTemp
drop table #SaleReturnTemp
drop table #PurchaseReturnTemp
'
exec (@SQL+''+@SQL1)
print (@SQL1)
end





GO



/****** Object:  StoredProcedure [dbo].[data_SalePosReturnInfo_Insert]    Script Date: 5/19/2021 3:47:57 PM ******/
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
@InvoiceType int=0
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
		InvoiceType
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
	@InvoiceType

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