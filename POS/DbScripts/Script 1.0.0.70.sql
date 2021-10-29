
/****** Object:  StoredProcedure [dbo].[POSdata_SaleandReturnInfoServer_SelectAll]    Script Date: 10/20/2021 2:26:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







ALTER procedure [dbo].[POSdata_SaleandReturnInfoServer_SelectAll] 
@WhereClause nvarchar(Max),
@BoolMaster bit=0,
@DetailMaster bit=0,
@WhereClauseDetail nvarchar(Max),
@WhereClauseReturn nvarchar(Max),
@WhereClauseReturnDetail nvarchar(Max)='',
@isSales bit=1
as

if @isSales =1
begin

if(@BoolMaster=1)
begin
exec('SELECT        SalePosID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, SalePosDate, WHID, TaxAmount, GrossAmount, DiscountPercentage, DiscountAmount, DiscountTotal, OtherCharges, 
                         NetAmount, AmountReceive, AmountReturn, SalePosReturnID, AmountInAccount, AmountReceivable, AmountPayable, DirectReturn, MfgID, CustomerPhone, CustomerName, SalePOSNo, isTaxable, ExchangeAmount, MenuId, 
                         InvoiceType, CardNumber, CardName, CashPayment, CardPayment, SaleManId,CounterID,RiderAmount,LinckedBill
FROM            data_SalePosInfo '+ @WhereClause)
end
if (@DetailMaster=1)
begin
exec('SELECT        data_SalePosDetail.* FROM            data_SalePosDetail inner join data_SalePosInfo on data_SalePosInfo.SalePosID=data_SalePosDetail.SalePosID '+ @WhereClauseDetail)
end
end
else
begin
if(@BoolMaster=1)
begin
exec('select * from data_SalePosReturnInfo '+ @WhereClauseReturn)
end
if (@DetailMaster=1)
begin
exec('SELECT        SalePosReturnDetailID, SalePosDetailID, data_SalePosReturnDetail.SalePosReturnID, ItemId, Quantity, ItemRate, TaxPercentage, data_SalePosReturnDetail.TaxAmount, data_SalePosReturnDetail.DiscountPercentage, data_SalePosReturnDetail.DiscountAmount, TotalAmount, IsLog, CartonSize, Carton, TotalQuantity, SchemeID, 
                         MinQuantity,StockRate,0 as isExchange

FROM            data_SalePosReturnDetail inner join data_SalePosReturnInfo on data_SalePosReturnInfo.SalePosReturnID=data_SalePosReturnDetail.SalePosReturnID '+ @WhereClauseReturn)
end

end




Go


