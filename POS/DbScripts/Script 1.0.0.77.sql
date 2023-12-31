﻿
/****** Object:  StoredProcedure [dbo].[rpt_SaleFbr_Return_invoice]    Script Date: 2/7/2022 8:00:01 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpt_SaleFbr_Return_invoice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpt_SaleFbr_Return_invoice]
GO
/****** Object:  StoredProcedure [dbo].[rpt_SaleFbr_Return_invoice]    Script Date: 2/7/2022 8:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpt_SaleFbr_Return_invoice]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[rpt_SaleFbr_Return_invoice] AS' 
END
GO
-- Server : DESKTOP-Q54D9J1 -- 






ALTER procedure [dbo].[rpt_SaleFbr_Return_invoice]
@SaleInvoice bigint=0 
as
select CategoryName,InventItems.ItemNumber,InventWareHouse.PhoneNo,InventWareHouse.LocationAddress,InventWareHouse.WHDesc,
InventItems.ItenName,InventItems.UrduName,data_SalePosReturnInfo.customerName,data_SalePosReturnInfo.CustomerPhone,
data_SalePosReturnInfo.SalePosNo as SalePosID,data_SalePosReturnInfo.SalePosReturnDate as SalePOSDate,data_SalePosReturnInfo.TaxAmount, data_SalePosReturnInfo.GrossAmount, data_SalePosReturnDetail.DiscountPercentage, data_SalePosReturnInfo.DiscountAmount, 
data_SalePosReturnInfo.DiscountTotal, data_SalePosReturnInfo.OtherCharges, data_SalePosReturnInfo.NetAmount, data_SalePosReturnInfo.AmountReceive, 
data_SalePosReturnInfo.AmountReturn, data_SalePosReturnInfo.SalePosReturnID, data_SalePosReturnInfo.AmountInAccount, data_SalePosReturnInfo.AmountReceivable, 
data_SalePosReturnInfo.AmountPayable,GLCompany.*,
data_SalePosReturnDetail.ItemId,data_SalePosReturnDetail.Quantity,data_SalePosReturnDetail.ItemRate,data_SalePosReturnDetail.TotalAmount,data_SalePosReturnDetail.DiscountAmount as DetailDiscount,FBR_InvoiceMaster.InvoiceNumber,FBR_InvoiceMaster.imagePath,
gen_PosConfiguration.POSID,gen_PosConfiguration.BillPreFix,data_SalePosReturnDetail.TaxPercentage,data_SalePosReturnDetail.TaxAmount as DtTaxAmount
from data_SalePosReturnInfo 
inner join data_SalePosReturnDetail on data_SalePosReturnInfo.SalePosReturnID=data_SalePosReturnDetail.SalePosReturnID
 left join
FBR_InvoiceMaster on FBR_InvoiceMaster.SalePOSID=data_SalePosReturnInfo.SalePosID
inner join InventItems on data_SalePosReturnDetail.ItemId=InventItems.ItemId
inner join GLCompany on GLCompany.Companyid=data_SalePosReturnInfo.CompanyID
inner join InventWareHouse on InventWareHouse.WHID=data_SalePosReturnInfo.WHID
left join InventCategory on InventCategory.CategoryID=InventItems.CategoryID
inner join gen_PosConfiguration on gen_PosConfiguration.CounterID=data_SalePosReturnInfo.CounterID
where data_SalePosReturnInfo.SalePosID=@SaleInvoice

















GO


-- Server : DESKTOP-Q54D9J1 -- 

alter procedure [dbo].[rpt_Fbr_sale_invoice] 
@SaleInvoice bigint=0 
as
select CategoryName,InventItems.ItemNumber,InventWareHouse.PhoneNo,InventWareHouse.LocationAddress,InventWareHouse.WHDesc,
InventItems.ItenName,InventItems.UrduName,data_SalePosInfo.customerName,data_SalePosInfo.CustomerPhone,
data_SalePosInfo.SalePosNo as SalePosID,data_SalePosInfo.SalePosDate,data_SalePosInfo.TaxAmount, data_SalePosInfo.GrossAmount, data_SalePosDetail.DiscountPercentage, data_SalePosInfo.DiscountAmount, 
data_SalePosInfo.DiscountTotal, data_SalePosInfo.OtherCharges, data_SalePosInfo.NetAmount, data_SalePosInfo.AmountReceive, 
data_SalePosInfo.AmountReturn, data_SalePosInfo.SalePosReturnID, data_SalePosInfo.AmountInAccount, data_SalePosInfo.AmountReceivable, 
data_SalePosInfo.AmountPayable,GLCompany.*,
data_SalePosDetail.ItemId,data_SalePosDetail.Quantity,data_SalePosDetail.ItemRate,data_SalePosDetail.TotalAmount,data_SalePosDetail.DiscountAmount as DetailDiscount,FBR_InvoiceMaster.InvoiceNumber,FBR_InvoiceMaster.imagePath,
gen_PosConfiguration.POSID,gen_PosConfiguration.BillPreFix,
data_SalePosDetail.TaxPercentage,data_SalePosDetail.TaxAmount as DtTaxAmount
from data_SalePosInfo left join
FBR_InvoiceMaster on FBR_InvoiceMaster.SalePOSID=data_SalePosInfo.SalePosID
inner join data_SalePosDetail on data_SalePosInfo.SalePosID=data_SalePosDetail.SalePosID
inner join InventItems on data_SalePosDetail.ItemId=InventItems.ItemId
inner join GLCompany on GLCompany.Companyid=data_SalePosInfo.CompanyID
inner join InventWareHouse on InventWareHouse.WHID=data_SalePosInfo.WHID
left join InventCategory on InventCategory.CategoryID=InventItems.CategoryID
inner join gen_PosConfiguration on gen_PosConfiguration.CounterID=data_SalePosInfo.CounterID
where data_SalePosInfo.SalePosID=@SaleInvoice


Go













