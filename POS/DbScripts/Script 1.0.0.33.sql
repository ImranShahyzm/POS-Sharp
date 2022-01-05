
/****** Object:  StoredProcedure [dbo].[POSdata_MakeOrderInfoServer_SelectAll]    Script Date: 6/21/2021 1:15:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








Create procedure [dbo].[POSdata_MakeOrderInfoServer_SelectAll] 
@WhereClause nvarchar(Max),
@BoolMaster bit=0,
@DetailMaster bit=0,
@WhereClauseDetail nvarchar(Max)
as


if(@BoolMaster=1)
begin
exec('Select OrderID, RegisterDate, CName, CPhone, Address, CityName, Gender, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, WHID, CNIC, Neck, FFrontNeck, FBackNeck, Shoulder, 
                         FUpperBust, Bust, FUnderBust, ArmHole, SleeveLength, Muscle, Elbow, Cuff, Waist, Hip, BottomLength, Ankle, Remarks, RNo, IsTaxable, CustomerID, CardNumber, CardName, CashPayment, CardPayment, SaleManId, 
                         TaxAmount, GrossAmount, DiscountPercentage, DiscountAmount, DiscountTotal, OtherCharges, NetAmount, AmountReceive, AmountReturn, AmountInAccount, AmountReceivable, AmountPayable, DirectReturn, 
                         DeliveryDate from Posdata_MaketoOrderInfo'+ @WhereClause)
end
if (@DetailMaster=1)
begin
exec('
SELECT        OrderDetailID, Posdata_MaketoOrderDetail.OrderID, ItemId, Quantity, ItemRate, TaxPercentage, Posdata_MaketoOrderDetail.TaxAmount, Posdata_MaketoOrderDetail.DiscountPercentage, Posdata_MaketoOrderDetail.DiscountAmount, TotalAmount, ManaufacturingID, CartonSize, Carton, TotalQuantity, SchemeID, MinQuantity, isExchange, 
                         StockRate
FROM            Posdata_MaketoOrderDetail inner join Posdata_MaketoOrderInfo on Posdata_MaketoOrderInfo.OrderID=Posdata_MaketoOrderDetail.OrderID '+ @WhereClauseDetail)
end






