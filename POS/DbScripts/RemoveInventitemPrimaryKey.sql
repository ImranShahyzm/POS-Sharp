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
ALTER TABLE dbo.data_PurchaseOrderDetail
	DROP CONSTRAINT FK_data_PurchaseOrderDetail_InventItems
GO
ALTER TABLE dbo.data_SaleTrackerDetail
	DROP CONSTRAINT FK_data_SaleTrackerDetail_InventItems
GO
ALTER TABLE dbo.data_SaleTrackerDetailParams
	DROP CONSTRAINT FK_data_SaleTrackerDetailParams_InventItems
GO
ALTER TABLE dbo.gen_SchemeDetailInfo
	DROP CONSTRAINT FK_gen_SchemeDetailInfo_InventItems
GO
ALTER TABLE dbo.data_InventItemsBarcode
	DROP CONSTRAINT FK_data_InventItemsBarcode_InventItems
GO
ALTER TABLE dbo.data_PurchaseRequisitionDetail
	DROP CONSTRAINT FK_data_PurchaseRequisitionDetail_InventItems
GO
ALTER TABLE dbo.data_InwardGatePassDetail
	DROP CONSTRAINT FK_data_InwardGatePassDetail_InventItems
GO
ALTER TABLE dbo.data_PurchaseReturnDetail
	DROP CONSTRAINT FK_data_PurchaseReturnDetail_InventItems
GO
ALTER TABLE dbo.adgen_InsuranceJobEstimateDetail
	DROP CONSTRAINT FK_adgen_InsuranceJobEstimateDetail_InventItems
GO
ALTER TABLE dbo.data_SODeductionDetail
	DROP CONSTRAINT FK_data_SODeductionDetail_InventItems
GO
ALTER TABLE dbo.data_StockInOutDetail
	DROP CONSTRAINT FK_data_StockInOutDetail_InventItems
GO
ALTER TABLE dbo.data_StockInOutDetailParams
	DROP CONSTRAINT FK_data_StockInOutDetailParams_InventItems
GO
ALTER TABLE dbo.Addata_JobCardInfocheckboxDetail
	DROP CONSTRAINT FK_Addata_JobCardInfocheckboxDetail_InventItems
GO
ALTER TABLE dbo.data_QuotationDetail
	DROP CONSTRAINT FK_data_QuotationDetail_InventItems
GO
ALTER TABLE dbo.Addata_JobCardInfolubricantDetail
	DROP CONSTRAINT FK_Addata_JobCardInfolubricantDetail_InventItems
GO
ALTER TABLE dbo.data_ManufacturingDetail
	DROP CONSTRAINT FK_data_ManufacturingDetail_InventItems
GO
ALTER TABLE dbo.Addata_JobCardInfoPartsDetail
	DROP CONSTRAINT FK_Addata_JobCardInfoPartsDetail_InventItems
GO
ALTER TABLE dbo.Addata_JobCardInfosubjobDetail
	DROP CONSTRAINT FK_Addata_JobCardInfosubjobDetail_InventItems
GO
ALTER TABLE dbo.PData_Hatchery
	DROP CONSTRAINT FK_PData_HatcheryInfo_InventItems
GO
ALTER TABLE dbo.data_ManufacturingDetailParams
	DROP CONSTRAINT FK_data_ManufacturingDetailParams_InventItems
GO
ALTER TABLE dbo.adgen_ScheduleMaintainceDetail
	DROP CONSTRAINT FK_adgen_ScheduleMaintainceDetail_InventItems
GO
ALTER TABLE dbo.Addata_JobCardInfosubpartsDetail
	DROP CONSTRAINT FK_Addata_JobCardInfosubpartsDetail_InventItems
GO
ALTER TABLE dbo.data_ManufacturingDetailParamsFG
	DROP CONSTRAINT FK_data_ManufacturingDetailParamsFG_InventItems
GO
ALTER TABLE dbo.data_StockTransferDetail
	DROP CONSTRAINT FK_data_StockTransferDetail_InventItems
GO
ALTER TABLE dbo.data_ManufacturingFormulaDetail
	DROP CONSTRAINT FK_data_ManufacturingFormulaDetail_InventItems
GO
ALTER TABLE dbo.pdata_inwardGatePassDetail
	DROP CONSTRAINT FK_pdata_inwardGatePassDetail_InventItems
GO
ALTER TABLE dbo.data_StockTransferDetailParams
	DROP CONSTRAINT FK_data_StockTransferDetailParams_InventItems
GO
ALTER TABLE dbo.data_ProductInflow
	DROP CONSTRAINT FK_data_ProductInflow_InventItems
GO
ALTER TABLE dbo.data_ProductInflowBatch
	DROP CONSTRAINT FK_data_ProductInflowBatch_InventItems
GO
ALTER TABLE dbo.data_ManufacturingInfo
	DROP CONSTRAINT FK_data_ManufacturingInfo_InventItems
GO
ALTER TABLE dbo.data_ProductOutflow
	DROP CONSTRAINT FK_data_ProductOutflow_InventItems
GO
ALTER TABLE dbo.Pdata_LayerActivitiesDetail
	DROP CONSTRAINT FK_Pdata_LayerActivitiesDetail_InventItems
GO
ALTER TABLE dbo.data_ManufacturingOverheadDetail
	DROP CONSTRAINT FK_data_ManufacturingOverheadDetail_InventItems
GO
ALTER TABLE dbo.data_ProductOutflowBatch
	DROP CONSTRAINT FK_data_ProductOutflowBatch_InventItems
GO
ALTER TABLE dbo.addata_SaleDetail
	DROP CONSTRAINT FK_addata_SaleInfoDetail_InventItems
GO
ALTER TABLE dbo.data_SaleDetail
	DROP CONSTRAINT FK_data_SaleDetail_InventItems
GO
ALTER TABLE dbo.pdata_outwardGatePassDetail
	DROP CONSTRAINT FK_pdata_outwardGatePassDetail_InventItems
GO
ALTER TABLE dbo.data_SaleDetailParams
	DROP CONSTRAINT FK_data_SaleDetailParams_InventItems
GO
ALTER TABLE dbo.addata_TrackerAssigmentDetail
	DROP CONSTRAINT FK_addata_TrackerAssigmentDetail_InventItems
GO
ALTER TABLE dbo.addata_TrackerAssigmentDetailParams
	DROP CONSTRAINT FK_addata_TrackerAssigmentDetailParams_InventItems
GO
ALTER TABLE dbo.data_ItemChangeDetail
	DROP CONSTRAINT FK_data_ItemChangeDetail_InventItems
GO
ALTER TABLE dbo.PData_PurchaseInfo
	DROP CONSTRAINT FK_PData_PurchaseInfo_InventItems
GO
ALTER TABLE dbo.data_ToolsIssuenceDetail
	DROP CONSTRAINT FK_data_ToolsIssuenceDetail_InventItems
GO
ALTER TABLE dbo.Pdata_SaleInfo
	DROP CONSTRAINT FK_Pdata_SaleInfo_InventItems
GO
ALTER TABLE dbo.data_PrReleaseOrder
	DROP CONSTRAINT FK_data_PrReleaseOrder_InventItems
GO
ALTER TABLE dbo.data_OutwardGatePassDetail
	DROP CONSTRAINT FK_data_OutwardGatePassDetail_InventItems
GO
ALTER TABLE dbo.data_ToolsReturnFormDetail
	DROP CONSTRAINT FK_data_ToolsReturnFormDetail_InventItems
GO
ALTER TABLE dbo.pdata_shedDataInflow
	DROP CONSTRAINT FK_pdata_shedDataInflow_InventItems
GO
ALTER TABLE dbo.data_SaleOrderDetail
	DROP CONSTRAINT FK_data_SaleOrderDetail_InventItems
GO
ALTER TABLE dbo.data_PurchaseDetail
	DROP CONSTRAINT FK_data_PurchaseDetail_InventItems
GO
ALTER TABLE dbo.pdata_shedDataOutflow
	DROP CONSTRAINT FK_pdata_shedDataOutflow_InventItems
GO
ALTER TABLE dbo.Pdata_StockFlockTransferDetail
	DROP CONSTRAINT FK_Pdata_StockFlockTransferDetail_InventItems
GO
ALTER TABLE dbo.data_PurchaseDetailParams
	DROP CONSTRAINT FK_data_PurchaseDetailParams_InventItems
GO
ALTER TABLE dbo.data_ZoneFreightDetail
	DROP CONSTRAINT FK_data_ZoneFreightDetail_InventItems
GO
ALTER TABLE dbo.data_SalePosDetail
	DROP CONSTRAINT FK_data_SalePosDetail_InventItems
GO
ALTER TABLE dbo.data_PertaFormDetail
	DROP CONSTRAINT FK_data_PertaFormDetail_InventItems
GO
ALTER TABLE dbo.data_SalePosReturnDetail
	DROP CONSTRAINT FK_data_SalePosReturnDetail_InventItems
GO
ALTER TABLE dbo.data_CounterPurchaseDetail
	DROP CONSTRAINT FK_data_CounterPurchaseDetail_InventItems
GO
ALTER TABLE dbo.gen_BOMDetail
	DROP CONSTRAINT FK_gen_BOMDetail_InventItems
GO
ALTER TABLE dbo.data_PertaFormInfo
	DROP CONSTRAINT FK_data_PertaFormInfo_InventItems
GO
ALTER TABLE dbo.data_DisassemblingDetail
	DROP CONSTRAINT FK_data_DisassemblingDetail_InventItems
GO
ALTER TABLE dbo.data_SaleReturnDetail
	DROP CONSTRAINT FK_data_SaleReturnDetail_InventItems
GO
ALTER TABLE dbo.data_PertaFormInfo
	DROP CONSTRAINT FK_data_PertaFormInfo_InventItems1
GO
ALTER TABLE dbo.gen_BOMInfo
	DROP CONSTRAINT FK_gen_BOMInfo_InventItems
GO
ALTER TABLE dbo.data_SaleReturnDetailParams
	DROP CONSTRAINT FK_data_SaleReturnDetailParams_InventItems
GO
ALTER TABLE dbo.data_DisassemblingDetailParams
	DROP CONSTRAINT FK_data_DisassemblingDetailParams_InventItems
GO
ALTER TABLE dbo.data_DisassemblingDetailParamsDG
	DROP CONSTRAINT FK_data_DisassemblingDetailParamsDG_InventItems
GO
ALTER TABLE dbo.gen_BOMPlanning
	DROP CONSTRAINT FK_gen_BOMPlanning_InventItems
GO
ALTER TABLE dbo.data_DisassemblingInfo
	DROP CONSTRAINT FK_data_DisassemblingInfo_InventItems
GO
ALTER TABLE dbo.data_pes_SalesManTargetDetail
	DROP CONSTRAINT FK_data_pes_SalesManTargetDetail_InventItems
GO
ALTER TABLE dbo.InventItems
	DROP CONSTRAINT PK_InventItems
GO
ALTER TABLE dbo.InventItems SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_pes_SalesManTargetDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_DisassemblingInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_BOMPlanning SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_DisassemblingDetailParamsDG SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_DisassemblingDetailParams SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_SaleReturnDetailParams SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_BOMInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_SaleReturnDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_DisassemblingDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_PertaFormInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_BOMDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_CounterPurchaseDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_SalePosReturnDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_PertaFormDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_SalePosDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ZoneFreightDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_PurchaseDetailParams SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Pdata_StockFlockTransferDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.pdata_shedDataOutflow SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_PurchaseDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_SaleOrderDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.pdata_shedDataInflow SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ToolsReturnFormDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_OutwardGatePassDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_PrReleaseOrder SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Pdata_SaleInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ToolsIssuenceDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.PData_PurchaseInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ItemChangeDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.addata_TrackerAssigmentDetailParams SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.addata_TrackerAssigmentDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_SaleDetailParams SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.pdata_outwardGatePassDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_SaleDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.addata_SaleDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ProductOutflowBatch SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ManufacturingOverheadDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Pdata_LayerActivitiesDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ProductOutflow SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ManufacturingInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ProductInflowBatch SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ProductInflow SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_StockTransferDetailParams SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.pdata_inwardGatePassDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ManufacturingFormulaDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_StockTransferDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ManufacturingDetailParamsFG SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Addata_JobCardInfosubpartsDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.adgen_ScheduleMaintainceDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ManufacturingDetailParams SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.PData_Hatchery SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Addata_JobCardInfosubjobDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Addata_JobCardInfoPartsDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ManufacturingDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Addata_JobCardInfolubricantDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_QuotationDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Addata_JobCardInfocheckboxDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_StockInOutDetailParams SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_StockInOutDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_SODeductionDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.adgen_InsuranceJobEstimateDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_PurchaseReturnDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_InwardGatePassDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_PurchaseRequisitionDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_InventItemsBarcode SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_SchemeDetailInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_SaleTrackerDetailParams SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_SaleTrackerDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_PurchaseOrderDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
