

/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Cancel]    Script Date: 6/2/2021 1:15:29 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure[dbo].[data_SalePosInfo_Cancel]
@UserID int = null , 
@CompanyID int = null , 
@FiscalID int = null ,
@SalePosDate date = null,
@WHID   int	=null,
@TaxAmount decimal (18, 2)	=null,
@GrossAmount decimal (18, 2)	=null,
@DiscountPercentage decimal (18, 2)	=null,
@DiscountAmount decimal (18, 2)	=null,
@DiscountTotal decimal (18, 2)	=null,
@OtherCharges decimal (18, 2)	=null,
@NetAmount decimal (18, 2)	=null,
@AmountReceive decimal (18, 2)	=null,
@AmountReturn decimal (18, 2)	=null,
@AmountInAccount decimal (18, 2)	=null,
@AmountReceivable decimal (18, 2)	=null,
@AmountPayable decimal (18, 2)	=null,
@DirectReturn bit = 0,
@data_SalePosDetail  data_SalePosDetail readonly,
@SalePosID bigint output,
@CustomerPhone nvarchar(50)=null,
@CustomerName nvarchar(50)=null,
@SaleInvoiceNo int=0,
@ExchangeAmount numeric(18, 3) =NULL,
@MenuId int =NULL,
@InvoiceType int= NULL,
@CardNumber nvarchar(MAX)=NULL,
@CardName nvarchar(1000)=NULL,
@CashPayment numeric(18, 3)=NULL,
@CardPayment numeric(18, 3)=NULL,
@SaleManId int=null

as
declare @returnSale bit=0
declare @IsTaxable bit =0
--set @SalePosDate = GETDATE()

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
		DirectReturn=1
	where SalePosID = @SalePosID
--delete from data_CashIn where SourceName='POS' and SourceID = @SalePosID
Delete from data_ProductInflow where SourceName='POSEXCHANGE' and SourceID in (Select SalePosDetailID from data_SalePosDetail where SalePosID=@SalePosID)
Delete from data_ProductOutflow where SourceName='POS' and SourceID in (Select SalePosDetailID from data_SalePosDetail where SalePosID=@SalePosID)
Delete from data_SalePosDetail where SalePosID=@SalePosID
    EXEC[dbo].[data_Cash_Insert]
@SourceID = @SalePosID,
		@SourceName = N'INVOICE CANCELLED',
		@Amount = @AmountReceivable,
		@CashType = 0,
		@SalePosDate=@SalePosDate

		


---========== Sale End Here ================
---========================== Sale Stock In Working Start Here =============================
		
end

declare @RowID int,@SaleDetailID int ,@StockRate numeric(14,5) , @Quantity numeric(10,2),@ItemId int,@stockQty numeric(14,2),@ItemName varchar(200),@ERRORMSG varchar(200),
		@MainTainInventory bit = 1, @DealCateGoryID int=0,@ItemCategoryID int=0,@BomId int,@ProductIntflowID int=0,
        @data_ManufacturingDetail data_ManufacturingDetail,
        @data_ItemBatchDetail  data_ItemBatchDetail  ,
        @data_ItemBatchDetailFinish data_ItemBatchDetail, @ManufacturingID int=0,@isExchange bit = 0

        Select @DealCateGoryID = POSDealsCategory from gen_SystemConfiguration where CompanyID = @CompanyID


declare Salecursor cursor for
select RowID from @data_SalePosDetail
open Salecursor
fetch next from Salecursor into @RowID
while @@FETCH_STATUS = 0
	begin

--	select @ItemId = ItemId, @Quantity = Quantity, @StockRate = ItemRate, @isExchange = isExchange

--  From @data_SalePosDetail         where RowID = @RowID

--      Select @ItemCategoryID = CategoryID, @MainTainInventory = MaintainInventory from InventItems where ItemId = @ItemId

   --      Select @BomId = BOMID from gen_BOMInfo where ItemId = @ItemId
     --      if(@BomId>0 and @ItemCategoryID = @DealCateGoryID)
--		begin
--		insert into @data_ManufacturingDetail(RowID, ItemId, BOMQuantity, ActualQuantity, WHID, StockRate, BOMFormulaQuantity)
--Select ROW_NUMBER() Over(order by ItemID)-1 as ROwId,ItemId,Quantity,Quantity* @Quantity, @WHID,0 ,1 from gen_BOMDetail where BOMID = @BomId
--exec data_ManufacturingInfo_Insert @ManufacturingID=@ManufacturingID output, @UserID = @UserID, @CompanyID = @CompanyID, @FiscalID = @FiscalID, @BomId = @BomId, @ItemId = @ItemId, @ManufacturingDate = @SalePosDate, @Quantity = @Quantity, @WHID = @WHID, @ManufacturingStyle = 'STYLE 1', @IsTaxable = @IsTaxable, @data_ManufacturingDetail = @data_ManufacturingDetail, @data_ItemBatchDetail = @data_ItemBatchDetail, @data_ItemBatchDetailFinish = @data_ItemBatchDetailFinish, @LooseQuantity = @Quantity      end
--		--if	 @returnSale = 0
--		--BEGIN
--			exec GetStockQuantity @ItemId ,@WHID , @SalePosDate , @stockQty output, @ItemName out , @CompanyID , '' , '' , 
--			null , null , null , 1 , @IsTaxable
--			if ((@stockQty<@Quantity ) and @MainTainInventory=1)
--			BEGIN
--					set @ERRORMSG = 'Stock is not enough of Item ' + @ItemName + ' Avaliable Stock '+  convert(varchar, @stockQty)	 + ' Required Quantity is ' + convert(varchar, @Quantity)
--					RAISERROR(@ERRORMSG , 16, 1 );
--					return
--			END
--		--END

        Insert Into data_SalePosDetail(
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
        @SalePosID,
        ItemId,
        Quantity,
        ItemRate,
        TaxPercentage,
        TaxAmount,
        DiscountPercentage,
        DiscountAmount,
        TotalAmount, @ManufacturingID,
        CartonSize,
        Carton,
        TotalQuantity,
        SchemeID,
        MinQuantity,
        isExchange


        From @data_SalePosDetail where RowID = @RowID


        set @SaleDetailID = @@IDENTITY		

		--declare @ProductOutflowID int
		--	if @MainTainInventory = 1 
		--	BEGIN		
		--		BEGIN
		--			exec GetWeightedRateForItem @ItemId, @WHID ,@SalePosDate ,@SalePosDate ,@StockRate output, @CompanyID, @IsTaxable
		--		END
		--		update data_SalePosDetail set StockRate = @StockRate where SalePosDetailID = @SaleDetailID
        --      if @isExchange=1
		--		begin
		--		set @Quantity = -1 * @Quantity
        --      exec data_ProductInflow_Insert @ProductIntflowID output, @ItemId, @SaleDetailID,'POSEXCHANGE',@WHID, @SalePosDate ,@StockRate,@Quantity, 
		--		@Quantity,@FiscalID , @CompanyID , @IsTaxable
		--		exec tempInflowDataTable_Insert @ProductIntflowID ,'POSEXCHANGE'
		--		end
		--		else
		--		begin
		--		exec data_ProductOutflow_Insert @ProductOutflowID output,null,@ItemId,@SaleDetailID,'POS',@WHID, @SalePosDate ,@StockRate,@Quantity, 
		--		@FiscalID , @CompanyID , @IsTaxable
		--		exec tempOutflowDataTable_Insert @ProductOutflowID ,'POS'
		--		end
				
		--	END

    FETCH NEXT FROM Salecursor INTO @RowID
    END

close Salecursor
deallocate Salecursor

---========================== Sale Stock In Working End Here =============================



GO





/****** Object:  StoredProcedure [dbo].[get_POSStockMovement]    Script Date: 6/2/2021 1:16:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER procedure [dbo].[get_POSStockMovement] 

@PURCHASERETURN nvarchar(4000) = '',
@SALE nvarchar(4000) = '',
@SALERETURN nvarchar(4000) = '',
@StockRETURN nvarchar(4000) = '',
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
where 0=0 and data_SalePosInfo.DirectReturn=0 '+ @SALE +' group by data_SalePosDetail.ItemId

--------------------------- Sale Return ----------------------------
select sum(Quantity) as SaleReturnQuantity,sum(data_StockArrivalDetail.StockRate*Quantity) as SaleReturnNetAmount,data_StockArrivalDetail.ItemId 
into #SaleReturnTemp 
from data_StockArrivalInfo inner join data_StockArrivalDetail on data_StockArrivalInfo.ArrivalID = data_StockArrivalDetail.ArrivalID
where 0=0  '+ @StockRETURN +' group by data_StockArrivalDetail.ItemId

select sum(Quantity) as SaleReturnQuantity,sum(data_SalePosReturnDetail.ItemRate*Quantity) as SaleReturnNetAmount,data_SalePosReturnDetail.ItemId 
into #PosReturn
from data_SalePosReturnInfo inner join data_SalePosReturnDetail on data_SalePosReturnInfo.SalePosReturnID = data_SalePosReturnDetail.SalePosReturnID
where 0=0 '+ @SALERETURN +' group by data_SalePosReturnDetail.ItemId


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
isnull(pr.PurchaseReturnQuantity,0) as PurchaseReturnQuantity,isnull(pr.PurchaseReturnNetAmount,0) as PurchaseReturnNetAmount,
isnull(PosR.SaleReturnQuantity,0) as SalePosReturnQuantity,isnull(PosR.SaleReturnNetAmount,0) as SalePosReturnAmount,InventItems.ItemSalesPrice as RetailPrice
from InventItems 
left outer join #SaleTemp s on InventItems.ItemId=s.ItemId
left outer join #SaleReturnTemp sr on InventItems.ItemId=sr.ItemId
left outer join #PurchaseReturnTemp pr on InventItems.ItemId=pr.ItemId
left outer join #PosReturn PosR on InventItems.ItemId=PosR.ItemId
left join InventCategory cat on cat.CategoryID=InventItems.CategoryID
'+ @WC +')t
drop table #SaleTemp
drop table #SaleReturnTemp
drop table #PurchaseReturnTemp
drop table #PosReturn
'
exec (@SQL+''+@SQL1)
print (@SQL1)
end


Go






/****** Object:  StoredProcedure [dbo].[rpt_sale_invoice]    Script Date: 6/2/2021 3:19:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER procedure [dbo].[rpt_sale_invoice] 
@SaleInvoice bigint=0 
as
select InventItems.ItemNumber,InventWareHouse.PhoneNo,InventWareHouse.LocationAddress,InventWareHouse.WHDesc,
InventItems.ItenName,InventItems.UrduName,data_SalePosInfo.customerName,data_SalePosInfo.CustomerPhone,
data_SalePosInfo.SalePosNo as SalePosID,Format(data_SalePosInfo.SalePosDate , 'dd-MMM-yyyy') as SalePosDate,data_SalePosInfo.TaxAmount, data_SalePosInfo.GrossAmount, data_SalePosDetail.DiscountPercentage, data_SalePosInfo.DiscountAmount, 
data_SalePosInfo.DiscountTotal, data_SalePosInfo.OtherCharges, data_SalePosInfo.NetAmount, data_SalePosInfo.AmountReceive, 
data_SalePosInfo.AmountReturn, data_SalePosInfo.SalePosReturnID, data_SalePosInfo.AmountInAccount, data_SalePosInfo.AmountReceivable, 
data_SalePosInfo.AmountPayable,data_SalePosInfo.EntryUserDateTime,GLCompany.*,
data_SalePosDetail.ItemId,data_SalePosDetail.Quantity,data_SalePosDetail.ItemRate,data_SalePosDetail.TotalAmount,data_SalePosDetail.DiscountAmount as DetailDiscount
from data_SalePosInfo 
inner join data_SalePosDetail on data_SalePosInfo.SalePosID=data_SalePosDetail.SalePosID
inner join InventItems on data_SalePosDetail.ItemId=InventItems.ItemId
inner join GLCompany on GLCompany.Companyid=data_SalePosInfo.CompanyID
inner join InventWareHouse on InventWareHouse.WHID=data_SalePosInfo.WHID
where data_SalePosInfo.SalePosID=@SaleInvoice




Go