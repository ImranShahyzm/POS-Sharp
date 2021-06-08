
/****** Object:  StoredProcedure [dbo].[POSdata_StockReturntoServer_SelectAll]    Script Date: 5/29/2021 11:36:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







Create procedure [dbo].[POSdata_StockReturntoServer_SelectAll] 
@WhereClause nvarchar(Max),
@BoolMaster bit=0,
@DetailMaster bit=0,
@WhereClauseDetail nvarchar(Max),
@WhereClauseReturn nvarchar(Max),
@WhereClauseReturnDetail nvarchar(Max)='',
@isSales bit=1
as
begin

if(@BoolMaster=1)
begin
exec('Select * from data_StockIssuancetoPosKitchen '+ @WhereClause)
end
if (@DetailMaster=1)
begin
exec('Select ddt.* from data_StockIssuancetoPosKitchenDetail ddt
inner join data_StockIssuancetoPosKitchen  on data_StockIssuancetoPosKitchen.IssuanceID=ddt.IssuanceID
 '+ @WhereClauseDetail)
end


end











