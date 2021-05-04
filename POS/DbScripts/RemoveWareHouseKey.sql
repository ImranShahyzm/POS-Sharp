/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_SaleReturnInfo
	DROP CONSTRAINT FK_data_SaleReturnInfo_InventWareHouse
GO
ALTER TABLE dbo.data_PurchaseRequisition
	DROP CONSTRAINT FK_data_PurchaseRequisition_InventWareHouse
GO
ALTER TABLE dbo.data_SaleTrackerInfo
	DROP CONSTRAINT FK_data_SaleTrackerInfo_InventWareHouse
GO
ALTER TABLE dbo.data_InwardGatePassInfo
	DROP CONSTRAINT FK_data_InwardGatePassInfo_InventWareHouse
GO
ALTER TABLE dbo.data_PurchaseReturnInfo
	DROP CONSTRAINT FK_data_PurchaseReturnInfo_InventWareHouse
GO
ALTER TABLE dbo.Pdata_FlockShedLayer
	DROP CONSTRAINT FK_Pdata_FlockShedLayer_InventWareHouse
GO
ALTER TABLE dbo.data_ManufacturingDetail
	DROP CONSTRAINT FK_data_ManufacturingDetail_InventWareHouse
GO
ALTER TABLE dbo.data_StockInOutInfo
	DROP CONSTRAINT FK_data_StockInOutInfo_InventWareHouse
GO
ALTER TABLE dbo.data_ProductInflow
	DROP CONSTRAINT FK_data_ProductInflow_InventWareHouse
GO
ALTER TABLE dbo.data_ManufacturingInfo
	DROP CONSTRAINT FK_data_ManufacturingInfo_InventWareHouse
GO
ALTER TABLE dbo.pdata_inwardGatePassInfo
	DROP CONSTRAINT FK_pdata_inwardGatePassInfo_InventWareHouse
GO
ALTER TABLE dbo.data_StockTransferInfo
	DROP CONSTRAINT FK_data_StockTransferInfo_InventWareHouse
GO
ALTER TABLE dbo.data_ProductOutflow
	DROP CONSTRAINT FK_data_ProductOutflow_InventWareHouse
GO
ALTER TABLE dbo.data_StockTransferInfo
	DROP CONSTRAINT FK_data_StockTransferInfo_InventWareHouse1
GO
ALTER TABLE dbo.Pdata_LayerActivitiesInfo
	DROP CONSTRAINT FK_Pdata_LayerActivitiesInfo_InventWareHouse
GO
ALTER TABLE dbo.pdata_outwardGatePassInfo
	DROP CONSTRAINT FK_pdata_outwardGatePassInfo_InventWareHouse
GO
ALTER TABLE dbo.gen_ItemsLocation
	DROP CONSTRAINT FK_gen_ItemsLocation_InventWareHouse
GO
ALTER TABLE dbo.addata_TrackerAssigmentinfo
	DROP CONSTRAINT FK_addata_TrackerAssigmentinfo_InventWareHouse
GO
ALTER TABLE dbo.pdata_shedDataInflow
	DROP CONSTRAINT FK_pdata_shedDataInflow_InventWareHouse
GO
ALTER TABLE dbo.pdata_shedDataOutflow
	DROP CONSTRAINT FK_pdata_shedDataOutflow_InventWareHouse
GO
ALTER TABLE dbo.data_CounterPurchase
	DROP CONSTRAINT FK_data_CounterPurchase_InventWareHouse
GO
ALTER TABLE dbo.data_DisassemblingDetail
	DROP CONSTRAINT FK_data_DisassemblingDetail_InventWareHouse
GO
ALTER TABLE dbo.data_PurchaseInfo
	DROP CONSTRAINT FK_data_PurchaseInfo_InventWareHouse
GO
ALTER TABLE dbo.gen_PosConfiguration
	DROP CONSTRAINT FK_gen_PosConfiguration_InventWareHouse
GO
ALTER TABLE dbo.GluserDetailWhid
	DROP CONSTRAINT FK_GluserDetailWhid_InventWareHouse
GO
ALTER TABLE dbo.data_PurchaseOrder
	DROP CONSTRAINT FK_data_PurchaseOrder_InventWareHouse
GO
ALTER TABLE dbo.data_DisassemblingInfo
	DROP CONSTRAINT FK_data_DisassemblingInfo_InventWareHouse
GO
ALTER TABLE dbo.InventWareHouse
	DROP CONSTRAINT PK_InventWareHouse
GO
ALTER TABLE dbo.InventWareHouse SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_DisassemblingInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_PurchaseOrder SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.GluserDetailWhid SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_PosConfiguration SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_PurchaseInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_DisassemblingDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_CounterPurchase SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.pdata_shedDataOutflow SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.pdata_shedDataInflow SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.addata_TrackerAssigmentinfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_ItemsLocation SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.pdata_outwardGatePassInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Pdata_LayerActivitiesInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ProductOutflow SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_StockTransferInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.pdata_inwardGatePassInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ManufacturingInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ProductInflow SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_StockInOutInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ManufacturingDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Pdata_FlockShedLayer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_PurchaseReturnInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_InwardGatePassInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_SaleTrackerInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_PurchaseRequisition SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_SaleReturnInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
