

/****** Object:  StoredProcedure [dbo].[rpt_saleReturn_invoice]    Script Date: 08/24/2022 12:12:27 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpt_saleReturn_invoice]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpt_saleReturn_invoice]
GO

/****** Object:  StoredProcedure [dbo].[rpt_saleReturn_invoice]    Script Date: 08/24/2022 12:12:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpt_saleReturn_invoice]') AND type IN (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[rpt_saleReturn_invoice] AS' 
END
GO






ALTER PROCEDURE [dbo].[rpt_saleReturn_invoice] 
@SaleInvoice BIGINT=0 
AS
SELECT ISNULL(data_SalePosReturnDetail.Remarks,'')Remarks,CategoryName,InventItems.ItemNumber,InventWareHouse.PhoneNo,InventWareHouse.LocationAddress,InventWareHouse.WHDesc,
InventItems.ItenName,InventItems.UrduName,data_SalePosReturnInfo.customerName,data_SalePosReturnInfo.CustomerPhone,
data_SalePosReturnInfo.SalePosNo AS SalePosID,data_SalePosReturnInfo.SalePosReturnDate AS SalePOSDate,data_SalePosReturnInfo.TaxAmount, data_SalePosReturnInfo.GrossAmount, data_SalePosReturnDetail.DiscountPercentage, data_SalePosReturnInfo.DiscountAmount, 
data_SalePosReturnInfo.DiscountTotal, data_SalePosReturnInfo.OtherCharges, data_SalePosReturnInfo.NetAmount, data_SalePosReturnInfo.AmountReceive, 
data_SalePosReturnInfo.AmountReturn, data_SalePosReturnInfo.SalePosReturnID, data_SalePosReturnInfo.AmountInAccount, data_SalePosReturnInfo.AmountReceivable, 
data_SalePosReturnInfo.AmountPayable,GLCompany.*,
data_SalePosReturnDetail.ItemId,data_SalePosReturnDetail.Quantity,data_SalePosReturnDetail.ItemRate,data_SalePosReturnDetail.TotalAmount,data_SalePosReturnDetail.DiscountAmount AS DetailDiscount,
dbo.data_SalePosReturnDetail.IMEINumber
FROM data_SalePosReturnInfo 
INNER JOIN data_SalePosReturnDetail ON data_SalePosReturnInfo.SalePosReturnID=data_SalePosReturnDetail.SalePosReturnID
INNER JOIN InventItems ON data_SalePosReturnDetail.ItemId=InventItems.ItemId
INNER JOIN GLCompany ON GLCompany.Companyid=data_SalePosReturnInfo.CompanyID
INNER JOIN InventWareHouse ON InventWareHouse.WHID=data_SalePosReturnInfo.WHID
LEFT JOIN InventCategory ON InventCategory.CategoryID=InventItems.CategoryID
WHERE data_SalePosReturnInfo.SalePosReturnID=@SaleInvoice










GO


