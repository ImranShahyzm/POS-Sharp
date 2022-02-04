IF NOT EXISTS (SELECT 1 FROM sys.columns 
				WHERE name = N'IsSynced' 
				and object_id = object_id(N'dbo.data_SalePosInfo'))
BEGIN
BEGIN TRANSACTION
	ALTER TABLE dbo.data_SalePosInfo ADD
	IsSynced tinyint NULL
COMMIT
END
GO


IF NOT EXISTS (SELECT 1 FROM sys.columns 
				WHERE name = N'IsSynced' 
				and object_id = object_id(N'dbo.data_SalePosReturnInfo'))
BEGIN
BEGIN TRANSACTION
	ALTER TABLE dbo.data_SalePosReturnInfo ADD
	IsSynced tinyint NULL
COMMIT
END
GO


IF NOT EXISTS (SELECT 1 FROM sys.columns 
				WHERE name = N'IsSynced' 
				and object_id = object_id(N'dbo.data_CashIn'))
BEGIN
BEGIN TRANSACTION
	ALTER TABLE dbo.data_CashIn ADD
	IsSynced tinyint NULL
COMMIT
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns 
				WHERE name = N'IsSynced' 
				and object_id = object_id(N'dbo.data_CashOut'))
BEGIN
BEGIN TRANSACTION
	ALTER TABLE dbo.data_CashOut ADD
	IsSynced tinyint NULL
COMMIT
END
GO

-- Server : DESKTOP-Q54D9J1 -- 









alter procedure [dbo].[POSdata_StockArrivalInfo_SelectAll] 
@WhereClause nvarchar(Max),
@BoolMaster bit=0,
@DetailMaster bit=0,
@WhereClauseDetail nvarchar(Max)
as

if(@BoolMaster=1)
begin
exec('select ArrivalID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, ArrivalDate, ArrivalNo, ArrivalFromWHID, ArrivalToWHID, FromBranchID, ToBranchID, IsTaxable, AccountVoucherID, 
                         Remarks, RefID, isManual, VehicleNo, ManualNo from data_StockArrivalInfo '+ @WhereClause)
end
if (@DetailMaster=1)
begin
exec('SELECT        ArrivalIDDetailID, data_StockArrivalDetail.ArrivalID, ItemId, Quantity, StockRate, CartonQuantity, LooseQuantity, TransferDetailID
FROM            data_StockArrivalDetail inner join data_StockArrivalInfo on data_StockArrivalInfo.ArrivalID=data_StockArrivalDetail.ArrivalID '+ @WhereClauseDetail)
end



Go








