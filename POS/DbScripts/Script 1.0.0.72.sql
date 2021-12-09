

/****** Object:  StoredProcedure [dbo].[Posdata_MaketoOrderInfo_SelectAll]    Script Date: 12/9/2021 7:17:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





ALTER procedure [dbo].[Posdata_MaketoOrderInfo_SelectAll]
@SelectMaster bit,
@WhereClause varchar(4000),
@SelectDetail bit,
@WhereClauseDetail varchar(4000)
as

if @SelectMaster = 1
BEGIN
	exec('SELECT        OrderID, RegisterDate, CName, CPhone, Address, CityName, Gender, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, WHID, CNIC, Neck, FFrontNeck, FBackNeck, Shoulder, 
                         FUpperBust, Bust, FUnderBust, ArmHole, SleeveLength, Muscle, Elbow, Cuff, Waist, Hip, BottomLength, Ankle, Remarks, RNo, IsTaxable, CustomerID, CardNumber, CardName, CashPayment, CardPayment, SaleManId, 
                         TaxAmount, GrossAmount, DiscountPercentage, DiscountAmount, DiscountTotal, OtherCharges, NetAmount, AmountReceive, AmountReturn, AmountInAccount, AmountReceivable, AmountPayable, DirectReturn, DeliveryDate, 
                          SalePosID, ImageActualPath, IsOrderSynced
FROM            Posdata_MaketoOrderInfo '+ @WhereClause)
END

if @SelectDetail = 1
BEGIN
	exec('select Posdata_MaketoOrderDetail.*,InventItems.ItenName,ItemNumber from Posdata_MaketoOrderDetail inner join InventItems on InventItems.ItemId=Posdata_MaketoOrderDetail.ItemId inner join Posdata_MaketoOrderInfo on Posdata_MaketoOrderInfo.orderID=Posdata_MaketoOrderDetail.OrderID '+ @WhereClauseDetail)
END





GO


