﻿

/****** Object:  StoredProcedure [dbo].[get_POSStockMovement]    Script Date: 5/27/2021 1:10:17 PM ******/
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
where 0=0'+ @SALE +' group by data_SalePosDetail.ItemId

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
isnull(PosR.SaleReturnQuantity,0) as SalePosReturnQuantity,isnull(PosR.SaleReturnNetAmount,0) as SalePosReturnAmount
from InventItems 
left outer join #SaleTemp s on InventItems.ItemId=s.ItemId
left outer join #SaleReturnTemp sr on InventItems.ItemId=sr.ItemId
left outer join #PurchaseReturnTemp pr on InventItems.ItemId=pr.ItemId
left outer join #PosReturn PosR on InventItems.ItemId=PosR.ItemId
left join InventCategory cat on cat.CategoryID=InventItems.CategoryID
'+ @WC +')t where t.closingAmount>0
drop table #SaleTemp
drop table #SaleReturnTemp
drop table #PurchaseReturnTemp
drop table #PosReturn
'
exec (@SQL+''+@SQL1)
print (@SQL1)
end






GO


