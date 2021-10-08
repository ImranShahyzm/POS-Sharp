
/****** Object:  StoredProcedure [dbo].[rpt_sale_invoice]    Script Date: 10/8/2021 3:48:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



Create procedure [dbo].[rpt_saleReturn_invoice] 
@SaleInvoice bigint=0 
as
select CategoryName,InventItems.ItemNumber,InventWareHouse.PhoneNo,InventWareHouse.LocationAddress,InventWareHouse.WHDesc,
InventItems.ItenName,InventItems.UrduName,data_SalePosReturnInfo.customerName,data_SalePosReturnInfo.CustomerPhone,
data_SalePosReturnInfo.SalePosNo as SalePosID,data_SalePosReturnInfo.SalePosReturnDate as SalePOSDate,data_SalePosReturnInfo.TaxAmount, data_SalePosReturnInfo.GrossAmount, data_SalePosReturnDetail.DiscountPercentage, data_SalePosReturnInfo.DiscountAmount, 
data_SalePosReturnInfo.DiscountTotal, data_SalePosReturnInfo.OtherCharges, data_SalePosReturnInfo.NetAmount, data_SalePosReturnInfo.AmountReceive, 
data_SalePosReturnInfo.AmountReturn, data_SalePosReturnInfo.SalePosReturnID, data_SalePosReturnInfo.AmountInAccount, data_SalePosReturnInfo.AmountReceivable, 
data_SalePosReturnInfo.AmountPayable,GLCompany.*,
data_SalePosReturnDetail.ItemId,data_SalePosReturnDetail.Quantity,data_SalePosReturnDetail.ItemRate,data_SalePosReturnDetail.TotalAmount,data_SalePosReturnDetail.DiscountAmount as DetailDiscount
from data_SalePosReturnInfo 
inner join data_SalePosReturnDetail on data_SalePosReturnInfo.SalePosReturnID=data_SalePosReturnDetail.SalePosReturnID
inner join InventItems on data_SalePosReturnDetail.ItemId=InventItems.ItemId
inner join GLCompany on GLCompany.Companyid=data_SalePosReturnInfo.CompanyID
inner join InventWareHouse on InventWareHouse.WHID=data_SalePosReturnInfo.WHID
left join InventCategory on InventCategory.CategoryID=InventItems.CategoryID
where data_SalePosReturnInfo.SalePosID=@SaleInvoice







Go







