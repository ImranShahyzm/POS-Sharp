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
ALTER TABLE dbo.gen_BrokerInformation
	DROP CONSTRAINT FK_gen_BrokerInformation_GLUser1
GO
ALTER TABLE dbo.addata_VehicleSaleInformation
	DROP CONSTRAINT FK_addata_VehicleSaleInformation_GLUser
GO
ALTER TABLE dbo.data_SaleReturnInfo
	DROP CONSTRAINT FK_data_SaleReturnInfo_GLUser
GO
ALTER TABLE dbo.gen_ItemMainGroupInfo
	DROP CONSTRAINT FK_gen_ItemMainGroupInfo_GLUser
GO
ALTER TABLE dbo.gen_SaleManInfo
	DROP CONSTRAINT FK_gen_SaleManInfo_GLUser
GO
ALTER TABLE dbo.addata_VehicleSaleInformation
	DROP CONSTRAINT FK_addata_VehicleSaleInformation_GLUser1
GO
ALTER TABLE dbo.data_SaleReturnInfo
	DROP CONSTRAINT FK_data_SaleReturnInfo_GLUser1
GO
ALTER TABLE dbo.gen_ItemMainGroupInfo
	DROP CONSTRAINT FK_gen_ItemMainGroupInfo_GLUser1
GO
ALTER TABLE dbo.gen_SaleManInfo
	DROP CONSTRAINT FK_gen_SaleManInfo_GLUser1
GO
ALTER TABLE dbo.data_pes_SalesManTargetInfo
	DROP CONSTRAINT FK_data_pes_SalesManTargetInfo_GLUser
GO
ALTER TABLE dbo.data_FeesChallansInfo
	DROP CONSTRAINT FK_data_FeesChallansInfo_GLUser
GO
ALTER TABLE dbo.gen_CashInformation
	DROP CONSTRAINT FK_gen_CashInformation_GLUser
GO
ALTER TABLE dbo.data_FeesChallansInfo
	DROP CONSTRAINT FK_data_FeesChallansInfo_GLUser1
GO
ALTER TABLE dbo.gen_CashInformation
	DROP CONSTRAINT FK_gen_CashInformation_GLUser1
GO
ALTER TABLE dbo.data_pes_TargetAssigningInfo
	DROP CONSTRAINT FK_data_pes_TargetAssigningInfo_GLUser
GO
ALTER TABLE dbo.data_GeneralSaleBookingInfo
	DROP CONSTRAINT FK_data_GeneralSaleBookingInfo_GLUser
GO
ALTER TABLE dbo.gen_CategoryLevel
	DROP CONSTRAINT FK_gen_CategoryLevel_GLUser
GO
ALTER TABLE dbo.gen_CategoryLevel
	DROP CONSTRAINT FK_gen_CategoryLevel_GLUser1
GO
ALTER TABLE dbo.addata_VehicleTransferInformation
	DROP CONSTRAINT FK_addata_VehicleTransferInformation_GLUser
GO
ALTER TABLE dbo.addata_VehicleTransferInformation
	DROP CONSTRAINT FK_addata_VehicleTransferInformation_GLUser1
GO
ALTER TABLE dbo.data_PurchaseRequisition
	DROP CONSTRAINT FK_data_PurchaseRequisition_GLUser
GO
ALTER TABLE dbo.gen_SchemeInfo
	DROP CONSTRAINT FK_gen_SchemeInformation_GLUser
GO
ALTER TABLE dbo.data_PurchaseRequisition
	DROP CONSTRAINT FK_data_PurchaseRequisition_GLUser1
GO
ALTER TABLE dbo.gen_SchemeInfo
	DROP CONSTRAINT FK_gen_SchemeInformation_GLUser1
GO
ALTER TABLE dbo.gen_CheckBookInfo
	DROP CONSTRAINT FK_gen_CheckBookInfo_GLUser
GO
ALTER TABLE dbo.addata_CustomerInfo
	DROP CONSTRAINT FK_addata_CustomerInfo_GLUser
GO
ALTER TABLE dbo.data_InventItemsBarcode
	DROP CONSTRAINT FK_data_InventItemsBarcode_GLUser
GO
ALTER TABLE dbo.gen_CheckBookInfo
	DROP CONSTRAINT FK_gen_CheckBookInfo_GLUser1
GO
ALTER TABLE dbo.adgen_ActivityTypeInfo
	DROP CONSTRAINT FK_adgen_ActivityTypeInfo_GLUser
GO
ALTER TABLE dbo.addata_CustomerInfo
	DROP CONSTRAINT FK_addata_CustomerInfo_GLUser1
GO
ALTER TABLE dbo.adgen_ActivityTypeInfo
	DROP CONSTRAINT FK_adgen_ActivityTypeInfo_GLUser1
GO
ALTER TABLE dbo.data_PlotsBooking
	DROP CONSTRAINT FK_data_PlotsBooking_GLUser
GO
ALTER TABLE dbo.data_SaleTrackerInfo
	DROP CONSTRAINT FK_data_SaleTrackerInfo_GLUser
GO
ALTER TABLE dbo.data_SaleTrackerInfo
	DROP CONSTRAINT FK_data_SaleTrackerInfo_GLUser1
GO
ALTER TABLE dbo.addata_CustomerInvoiceInfo
	DROP CONSTRAINT FK_addata_CustomerInvoiceInfo_GLUser
GO
ALTER TABLE dbo.gen_ClassAssignToTeacherInfo
	DROP CONSTRAINT FK_gen_ClassAssignToTeacherInfo_GLUser
GO
ALTER TABLE dbo.data_ShippingSaleInfo
	DROP CONSTRAINT FK_data_ShippingSaleInfo_GLUser
GO
ALTER TABLE dbo.addata_CustomerInvoiceInfo
	DROP CONSTRAINT FK_addata_CustomerInvoiceInfo_GLUser1
GO
ALTER TABLE dbo.gen_ClassAssignToTeacherInfo
	DROP CONSTRAINT FK_gen_ClassAssignToTeacherInfo_GLUser1
GO
ALTER TABLE dbo.data_PlotsDefine
	DROP CONSTRAINT FK_data_PlotsDefine_GLUser
GO
ALTER TABLE dbo.gen_StockInOutType
	DROP CONSTRAINT FK_gen_StockInOutType_GLUser
GO
ALTER TABLE dbo.gen_StockInOutType
	DROP CONSTRAINT FK_gen_StockInOutType_GLUser1
GO
ALTER TABLE dbo.gen_ClassInfo
	DROP CONSTRAINT FK_gen_ClassInfo_GLUser
GO
ALTER TABLE dbo.gen_ClassInfo
	DROP CONSTRAINT FK_gen_ClassInfo_GLUser1
GO
ALTER TABLE dbo.data_PlotsGenerate
	DROP CONSTRAINT FK_data_PlotsGenerate_GLUser
GO
ALTER TABLE dbo.addata_DispatchInformation
	DROP CONSTRAINT FK_addata_DispatchInformation_GLUser
GO
ALTER TABLE dbo.gen_CustomerEquipmentInfo
	DROP CONSTRAINT FK_gen_CustomerEquipmentInfo_GLUser
GO
ALTER TABLE dbo.addata_DispatchInformation
	DROP CONSTRAINT FK_addata_DispatchInformation_GLUser1
GO
ALTER TABLE dbo.gen_CustomerEquipmentInfo
	DROP CONSTRAINT FK_gen_CustomerEquipmentInfo_GLUser1
GO
ALTER TABLE dbo.gen_StudentInfo
	DROP CONSTRAINT FK_gen_StudentInfo_GLUser
GO
ALTER TABLE dbo.data_InwardGatePassInfo
	DROP CONSTRAINT FK_data_InwardGatePassInfo_GLUser
GO
ALTER TABLE dbo.adgen_InsuranceJobEstimateInfo
	DROP CONSTRAINT FK_adgen_InsuranceJobEstimateInfo_GLUser
GO
ALTER TABLE dbo.data_PlotsInstallments
	DROP CONSTRAINT FK_data_PlotsInstallments_GLUser
GO
ALTER TABLE dbo.gen_StudentInfo
	DROP CONSTRAINT FK_gen_StudentInfo_GLUser1
GO
ALTER TABLE dbo.data_InwardGatePassInfo
	DROP CONSTRAINT FK_data_InwardGatePassInfo_GLUser1
GO
ALTER TABLE dbo.gen_DepartmentInfo
	DROP CONSTRAINT FK_gen_DepartmentInfo_GLUser
GO
ALTER TABLE dbo.adgen_InsuranceJobEstimateInfo
	DROP CONSTRAINT FK_adgen_InsuranceJobEstimateInfo_GLUser1
GO
ALTER TABLE dbo.addata_generalGatePassInfo
	DROP CONSTRAINT FK_addata_generalGatePassInfo_GLUser
GO
ALTER TABLE dbo.gen_DepartmentInfo
	DROP CONSTRAINT FK_gen_DepartmentInfo_GLUser1
GO
ALTER TABLE dbo.addata_generalGatePassInfo
	DROP CONSTRAINT FK_addata_generalGatePassInfo_GLUser1
GO
ALTER TABLE dbo.data_PurchaseReturnInfo
	DROP CONSTRAINT FK_data_PurchaseReturnInfo_GLUser
GO
ALTER TABLE dbo.data_PurchaseReturnInfo
	DROP CONSTRAINT FK_data_PurchaseReturnInfo_GLUser1
GO
ALTER TABLE dbo.gen_DesignationInfo
	DROP CONSTRAINT FK_gen_DesignationInfo_GLUser
GO
ALTER TABLE dbo.Mdata_SurveyInfo
	DROP CONSTRAINT FK_Mdata_SurveyInfo_GLUser
GO
ALTER TABLE dbo.gen_DesignationInfo
	DROP CONSTRAINT FK_gen_DesignationInfo_GLUser1
GO
ALTER TABLE dbo.adgen_JobInsuranceEstApprovalInfo
	DROP CONSTRAINT FK_adgen_JobInsuranceEstApprovalInfo_GLUser
GO
ALTER TABLE dbo.adgen_JobInsuranceEstApprovalInfo
	DROP CONSTRAINT FK_adgen_JobInsuranceEstApprovalInfo_GLUser1
GO
ALTER TABLE dbo.gen_SubjectAssignInfo
	DROP CONSTRAINT FK_gen_SubjectAssignInfo_GLUser
GO
ALTER TABLE dbo.gen_SubjectAssignInfo
	DROP CONSTRAINT FK_gen_SubjectAssignInfo_GLUser1
GO
ALTER TABLE dbo.Pdata_FlockShedLayer
	DROP CONSTRAINT FK_Pdata_FlockShedLayer_GLUser
GO
ALTER TABLE dbo.data_LoanInfo
	DROP CONSTRAINT FK_data_LoanInfo_GLUser
GO
ALTER TABLE dbo.gen_SubjectInfo
	DROP CONSTRAINT FK_gen_SubjectInfo_GLUser
GO
ALTER TABLE dbo.data_LoanInfo
	DROP CONSTRAINT FK_data_LoanInfo_GLUser1
GO
ALTER TABLE dbo.gen_SubjectInfo
	DROP CONSTRAINT FK_gen_SubjectInfo_GLUser1
GO
ALTER TABLE dbo.adgen_SaleServiceInfo
	DROP CONSTRAINT FK_adgen_SaleServiceInfo_GLUser
GO
ALTER TABLE dbo.data_PlotsSize
	DROP CONSTRAINT FK_data_PlotsSize_GLUser
GO
ALTER TABLE dbo.adgen_SaleServiceInfo
	DROP CONSTRAINT FK_adgen_SaleServiceInfo_GLUser1
GO
ALTER TABLE dbo.data_StockInOutInfo
	DROP CONSTRAINT FK_data_StockInOutInfo_GLUser
GO
ALTER TABLE dbo.data_StockInOutInfo
	DROP CONSTRAINT FK_data_StockInOutInfo_GLUser1
GO
ALTER TABLE dbo.PData_Hatchery
	DROP CONSTRAINT FK_PData_HatcheryInfo_GLUser
GO
ALTER TABLE dbo.gen_SubPartiesInfo
	DROP CONSTRAINT FK_gen_SubPartyInfo_GLUser
GO
ALTER TABLE dbo.gen_EmployeeIncrementInfo
	DROP CONSTRAINT FK_gen_EmployeeIncrementInfo_GLUser
GO
ALTER TABLE dbo.gen_SubPartiesInfo
	DROP CONSTRAINT FK_gen_SubPartyInfo_GLUser1
GO
ALTER TABLE dbo.gen_EmployeeIncrementInfo
	DROP CONSTRAINT FK_gen_EmployeeIncrementInfo_GLUser1
GO
ALTER TABLE dbo.data_QuotationInfo
	DROP CONSTRAINT FK_gen_QuotationInfo_GLUser
GO
ALTER TABLE dbo.data_QuotationInfo
	DROP CONSTRAINT FK_gen_QuotationInfo_GLUser1
GO
ALTER TABLE dbo.Pdata_HatcheryMachineInfo
	DROP CONSTRAINT FK_Pdata_HatcheryMachineInfo_GLUser
GO
ALTER TABLE dbo.data_PlotsToken
	DROP CONSTRAINT FK_data_PlotsToken_GLUser
GO
ALTER TABLE dbo.Pdata_HatcheryMachineInfo
	DROP CONSTRAINT FK_Pdata_HatcheryMachineInfo_GLUser1
GO
ALTER TABLE dbo.adgen_ScheduleMaintainenceInfo
	DROP CONSTRAINT FK_adgen_ScheduleMaintainenceInfo_GLUser
GO
ALTER TABLE dbo.gen_EmployeeInfo
	DROP CONSTRAINT FK_gen_EmployeeInfo_GLUser
GO
ALTER TABLE dbo.adgen_ScheduleMaintainenceInfo
	DROP CONSTRAINT FK_adgen_ScheduleMaintainenceInfo_GLUser1
GO
ALTER TABLE dbo.gen_EmployeeInfo
	DROP CONSTRAINT FK_gen_EmployeeInfo_GLUser1
GO
ALTER TABLE dbo.adgen_VarientInfo
	DROP CONSTRAINT FK_adgen_VarientInfo_GLUser
GO
ALTER TABLE dbo.data_ReelProductionInfo
	DROP CONSTRAINT FK_data_ReelProductionInfo_GLUser
GO
ALTER TABLE dbo.data_ManufacturingInfo
	DROP CONSTRAINT FK_data_ManufacturingInfo_GLUser
GO
ALTER TABLE dbo.adgen_VarientInfo
	DROP CONSTRAINT FK_adgen_VarientInfo_GLUser1
GO
ALTER TABLE dbo.addata_RecoveryInfo
	DROP CONSTRAINT FK_addata_RecoveryInfo_GLUser
GO
ALTER TABLE dbo.data_ReelProductionInfo
	DROP CONSTRAINT FK_data_ReelProductionInfo_GLUser1
GO
ALTER TABLE dbo.data_ManufacturingInfo
	DROP CONSTRAINT FK_data_ManufacturingInfo_GLUser1
GO
ALTER TABLE dbo.addata_RecoveryInfo
	DROP CONSTRAINT FK_addata_RecoveryInfo_GLUser1
GO
ALTER TABLE dbo.adgen_VehicleGroup
	DROP CONSTRAINT FK_adgen_VehicleGroup_GLUser
GO
ALTER TABLE dbo.data_StockTransferInfo
	DROP CONSTRAINT FK_data_StockTransferInfo_GLUser
GO
ALTER TABLE dbo.pdata_inwardGatePassInfo
	DROP CONSTRAINT FK_pdata_inwardGatePassInfo_GLUser
GO
ALTER TABLE dbo.adgen_VehicleGroup
	DROP CONSTRAINT FK_adgen_VehicleGroup_GLUser1
GO
ALTER TABLE dbo.data_StockTransferInfo
	DROP CONSTRAINT FK_data_StockTransferInfo_GLUser1
GO
ALTER TABLE dbo.pdata_inwardGatePassInfo
	DROP CONSTRAINT FK_pdata_inwardGatePassInfo_GLUser1
GO
ALTER TABLE dbo.gen_EmployeeLeaveInfo
	DROP CONSTRAINT FK_gen_EmployeeLeaveInfo_GLUser
GO
ALTER TABLE dbo.gen_EmployeeLeaveInfo
	DROP CONSTRAINT FK_gen_EmployeeLeaveInfo_GLUser1
GO
ALTER TABLE dbo.adgen_VehicleInfo
	DROP CONSTRAINT FK_adgen_VehicleInfo_GLUser
GO
ALTER TABLE dbo.data_SaleAdjustmentInfo
	DROP CONSTRAINT FK_data_SaleAdjustmentInfo_GLUser
GO
ALTER TABLE dbo.adgen_VehicleInfo
	DROP CONSTRAINT FK_adgen_VehicleInfo_GLUser1
GO
ALTER TABLE dbo.gen_EmployeeLeaveTypeInfo
	DROP CONSTRAINT FK_gen_EmployeeLeaveTypeInfo_GLUser
GO
ALTER TABLE dbo.gen_EmployeeLeaveTypeInfo
	DROP CONSTRAINT FK_gen_EmployeeLeaveTypeInfo_GLUser1
GO
ALTER TABLE dbo.Pdata_LayerActivitiesInfo
	DROP CONSTRAINT FK_Pdata_LayerActivitiesInfo_GLUser
GO
ALTER TABLE dbo.data_ManufacturingOverheadInfo
	DROP CONSTRAINT FK_data_ManufacturingOverheadInfo_GLUser
GO
ALTER TABLE dbo.adgen_VehicleRegistrationInfo
	DROP CONSTRAINT FK_adgen_VehicleRegistrationInfo_GLUser
GO
ALTER TABLE dbo.data_StudentsAttendanceInfo
	DROP CONSTRAINT FK_data_StudentsAttendanceInfo_GLUser
GO
ALTER TABLE dbo.data_ManufacturingOverheadInfo
	DROP CONSTRAINT FK_data_ManufacturingOverheadInfo_GLUser1
GO
ALTER TABLE dbo.gen_Event
	DROP CONSTRAINT FK_gen_Event_GLUser
GO
ALTER TABLE dbo.adgen_VehicleRegistrationInfo
	DROP CONSTRAINT FK_adgen_VehicleRegistrationInfo_GLUser1
GO
ALTER TABLE dbo.data_StudentsAttendanceInfo
	DROP CONSTRAINT FK_data_StudentsAttendanceInfo_GLUser1
GO
ALTER TABLE dbo.data_ProgramRegistration
	DROP CONSTRAINT FK_data_ProgramRegistration_GLUser
GO
ALTER TABLE dbo.gen_Event
	DROP CONSTRAINT FK_gen_Event_GLUser1
GO
ALTER TABLE dbo.addata_SaleInfo
	DROP CONSTRAINT FK_addata_SaleInfo_GLUser
GO
ALTER TABLE dbo.data_ProgramRegistration
	DROP CONSTRAINT FK_data_ProgramRegistration_GLUser1
GO
ALTER TABLE dbo.addata_SaleInfo
	DROP CONSTRAINT FK_addata_SaleInfo_GLUser1
GO
ALTER TABLE dbo.gen_GradeDefine
	DROP CONSTRAINT FK_gen_GradeDefine_GLUser
GO
ALTER TABLE dbo.gen_GradeDefine
	DROP CONSTRAINT FK_gen_GradeDefine_GLUser1
GO
ALTER TABLE dbo.addata_StockReturnFromJobCardInfo
	DROP CONSTRAINT FK_addata_StockReturnFromJobCardInfo_GLUser
GO
ALTER TABLE dbo.addata_StockReturnFromJobCardInfo
	DROP CONSTRAINT FK_addata_StockReturnFromJobCardInfo_GLUser1
GO
ALTER TABLE dbo.data_ProjectCosting
	DROP CONSTRAINT FK_data_ProjectCosting_GLUser
GO
ALTER TABLE dbo.gen_GroupLevel
	DROP CONSTRAINT FK_gen_GroupLevel_GLUser
GO
ALTER TABLE dbo.data_ProjectCosting
	DROP CONSTRAINT FK_data_ProjectCosting_GLUser1
GO
ALTER TABLE dbo.gen_GroupLevel
	DROP CONSTRAINT FK_gen_GroupLevel_GLUser1
GO
ALTER TABLE dbo.data_TestAssignToClassInfo
	DROP CONSTRAINT FK_data_TestAssignToClassInfo_GLUser
GO
ALTER TABLE dbo.pdata_outwardGatePassInfo
	DROP CONSTRAINT FK_pdata_outwardGatePassInfo_GLUser
GO
ALTER TABLE dbo.data_MarksUploadInfo
	DROP CONSTRAINT FK_data_MarksUploadInfo_GLUser
GO
ALTER TABLE dbo.data_TestAssignToClassInfo
	DROP CONSTRAINT FK_data_TestAssignToClassInfo_GLUser1
GO
ALTER TABLE dbo.pdata_outwardGatePassInfo
	DROP CONSTRAINT FK_pdata_outwardGatePassInfo_GLUser1
GO
ALTER TABLE dbo.data_MarksUploadInfo
	DROP CONSTRAINT FK_data_MarksUploadInfo_GLUser1
GO
ALTER TABLE dbo.data_AttendanceInfo
	DROP CONSTRAINT FK_data_AttendanceInfo_GLUser
GO
ALTER TABLE dbo.gen_IncentiveInformation
	DROP CONSTRAINT FK_gen_IncentiveInformation_GLUser
GO
ALTER TABLE dbo.data_AttendanceInfo
	DROP CONSTRAINT FK_data_AttendanceInfo_GLUser1
GO
ALTER TABLE dbo.gen_IncentiveInformation
	DROP CONSTRAINT FK_gen_IncentiveInformation_GLUser1
GO
ALTER TABLE dbo.data_ProjectsPhases
	DROP CONSTRAINT FK_data_ProjectsPhases_GLUser
GO
ALTER TABLE dbo.data_SaleDistributionRecoveryInfo
	DROP CONSTRAINT FK_data_SaleDistributionRecoveryInfo_GLUser
GO
ALTER TABLE dbo.data_ToolsIssuence
	DROP CONSTRAINT FK_data_ToolsIssuence_GLUser
GO
ALTER TABLE dbo.data_SaleDistributionRecoveryInfo
	DROP CONSTRAINT FK_data_SaleDistributionRecoveryInfo_GLUser1
GO
ALTER TABLE dbo.PData_PurchaseInfo
	DROP CONSTRAINT FK_PData_PurchaseInfo_GLUser
GO
ALTER TABLE dbo.data_ProjectsRegistration
	DROP CONSTRAINT FK_data_ProjectsRegistration_GLUser
GO
ALTER TABLE dbo.data_ToolsIssuence
	DROP CONSTRAINT FK_data_ToolsIssuence_GLUser1
GO
ALTER TABLE dbo.data_MisplExchangeSaleInfo
	DROP CONSTRAINT FK_data_MisplExchangeSaleInfo_GLUser
GO
ALTER TABLE dbo.data_ItemChangeInfo
	DROP CONSTRAINT FK_data_ItemChangeInfo_GLUser
GO
ALTER TABLE dbo.data_MisplExchangeSaleInfo
	DROP CONSTRAINT FK_data_MisplExchangeSaleInfo_GLUser1
GO
ALTER TABLE dbo.data_ItemChangeInfo
	DROP CONSTRAINT FK_data_ItemChangeInfo_GLUser1
GO
ALTER TABLE dbo.gen_JobCardType
	DROP CONSTRAINT FK_gen_JobCardType_GLUser
GO
ALTER TABLE dbo.data_CertificateInfo
	DROP CONSTRAINT FK_data_CertificateInfo_GLUser
GO
ALTER TABLE dbo.data_PrReleaseOrder
	DROP CONSTRAINT FK_data_PrReleaseOrder_GLUser
GO
ALTER TABLE dbo.gen_JobCardType
	DROP CONSTRAINT FK_gen_JobCardType_GLUser1
GO
ALTER TABLE dbo.data_CertificateInfo
	DROP CONSTRAINT FK_data_CertificateInfo_GLUser1
GO
ALTER TABLE dbo.addata_TrackerAssigmentinfo
	DROP CONSTRAINT FK_addata_TrackerAssigmentinfo_GLUser
GO
ALTER TABLE dbo.addata_TrackerAssigmentinfo
	DROP CONSTRAINT FK_addata_TrackerAssigmentinfo_GLUser1
GO
ALTER TABLE dbo.gen_MachineAttdendanceInfo
	DROP CONSTRAINT FK_gen_MachineAttdendanceInfo_GLUser
GO
ALTER TABLE dbo.gen_MachineAttdendanceInfo
	DROP CONSTRAINT FK_gen_MachineAttdendanceInfo_GLUser1
GO
ALTER TABLE dbo.data_ChallanFeesRecoveryInfo
	DROP CONSTRAINT FK_data_ChallanFeesRecoveryInfo_GLUser
GO
ALTER TABLE dbo.data_ChallanFeesRecoveryInfo
	DROP CONSTRAINT FK_data_ChallanFeesRecoveryInfo_GLUser1
GO
ALTER TABLE dbo.gen_MasterEquipmentInfo
	DROP CONSTRAINT FK_gen_MasterEquipmentInfo_GLUser
GO
ALTER TABLE dbo.data_ContainersGatePass
	DROP CONSTRAINT FK_data_ContainersGatePass_GLUser
GO
ALTER TABLE dbo.gen_MasterEquipmentInfo
	DROP CONSTRAINT FK_gen_MasterEquipmentInfo_GLUser1
GO
ALTER TABLE dbo.data_UserRegistration
	DROP CONSTRAINT FK_data_UserRegistration_GLUser
GO
ALTER TABLE dbo.addata_VehicleDeliveryInfo
	DROP CONSTRAINT FK_addata_VehicleDeliveryInfo_GLUser
GO
ALTER TABLE dbo.data_PaperProductionInfo
	DROP CONSTRAINT FK_data_PaperProductionInfo_GLUser
GO
ALTER TABLE dbo.gen_ParentsInfo
	DROP CONSTRAINT FK_gen_ParentsInfo_GLUser
GO
ALTER TABLE dbo.addata_VehicleDeliveryInfo
	DROP CONSTRAINT FK_addata_VehicleDeliveryInfo_GLUser1
GO
ALTER TABLE dbo.data_PaperProductionInfo
	DROP CONSTRAINT FK_data_PaperProductionInfo_GLUser1
GO
ALTER TABLE dbo.gen_ParentsInfo
	DROP CONSTRAINT FK_gen_ParentsInfo_GLUser1
GO
ALTER TABLE dbo.gen_TaxGroupInfo
	DROP CONSTRAINT FK_gen_TaxGroupInfo_GLUser
GO
ALTER TABLE dbo.gen_TaxGroupInfo
	DROP CONSTRAINT FK_gen_TaxGroupInfo_GLUser1
GO
ALTER TABLE dbo.Pdata_StockFlockTransferInfo
	DROP CONSTRAINT FK_Pdata_StockFlockTransferInfo_GLUser
GO
ALTER TABLE dbo.gen_TaxInfo
	DROP CONSTRAINT FK_gen_TaxInfo_GLUser
GO
ALTER TABLE dbo.data_CounterPurchase
	DROP CONSTRAINT FK_data_CounterPurchase_GLUser
GO
ALTER TABLE dbo.gen_TaxInfo
	DROP CONSTRAINT FK_gen_TaxInfo_GLUser1
GO
ALTER TABLE dbo.data_PayRollInfo
	DROP CONSTRAINT FK_data_PayRollInfo_GLUser
GO
ALTER TABLE dbo.data_CounterPurchase
	DROP CONSTRAINT FK_data_CounterPurchase_GLUser1
GO
ALTER TABLE dbo.addata_VehiclePaymentInformation
	DROP CONSTRAINT FK_addata_VehiclePaymentInformation_GLUser
GO
ALTER TABLE dbo.data_PayRollInfo
	DROP CONSTRAINT FK_data_PayRollInfo_GLUser1
GO
ALTER TABLE dbo.addata_VehiclePaymentInformation
	DROP CONSTRAINT FK_addata_VehiclePaymentInformation_GLUser1
GO
ALTER TABLE dbo.data_SalePosInfo
	DROP CONSTRAINT FK_data_SalePosInfo_GLUser
GO
ALTER TABLE dbo.data_SalePosInfo
	DROP CONSTRAINT FK_data_SalePosInfo_GLUser1
GO
ALTER TABLE dbo.tblMachineUsers
	DROP CONSTRAINT FK_tblMachineUsers_GLUser
GO
ALTER TABLE dbo.gen_TestInfo
	DROP CONSTRAINT FK_gen_TestInfo_GLUser
GO
ALTER TABLE dbo.gen_BankInformation
	DROP CONSTRAINT FK_gen_BankInformation_GLUser
GO
ALTER TABLE dbo.tblMachineUsers
	DROP CONSTRAINT FK_tblMachineUsers_GLUser1
GO
ALTER TABLE dbo.gen_TestInfo
	DROP CONSTRAINT FK_gen_TestInfo_GLUser1
GO
ALTER TABLE dbo.gen_PartyGroup
	DROP CONSTRAINT FK_gen_PartyGroup_GLUser
GO
ALTER TABLE dbo.gen_BankInformation
	DROP CONSTRAINT FK_gen_BankInformation_GLUser1
GO
ALTER TABLE dbo.gen_PartyGroup
	DROP CONSTRAINT FK_gen_PartyGroup_GLUser1
GO
ALTER TABLE dbo.data_SalePosReturnInfo
	DROP CONSTRAINT FK_data_SalePosReturnInfo_GLUser
GO
ALTER TABLE dbo.gen_PaymentMode
	DROP CONSTRAINT FK_gen_PaymentMode_GLUser
GO
ALTER TABLE dbo.data_SalePosReturnInfo
	DROP CONSTRAINT FK_data_SalePosReturnInfo_GLUser1
GO
ALTER TABLE dbo.data_PertaFormInfo
	DROP CONSTRAINT FK_data_PertaFormInfo_GLUser
GO
ALTER TABLE dbo.gen_PaymentMode
	DROP CONSTRAINT FK_gen_PaymentMode_GLUser1
GO
ALTER TABLE dbo.addata_VehicleReceiveInformation
	DROP CONSTRAINT FK_addata_VehicleReceiveInformation_GLUser
GO
ALTER TABLE dbo.addata_VehicleReceiveInformation
	DROP CONSTRAINT FK_addata_VehicleReceiveInformation_GLUser1
GO
ALTER TABLE dbo.data_PurchaseInfo
	DROP CONSTRAINT FK_data_PurchaseInfo_GLUser
GO
ALTER TABLE dbo.gen_PaymentTerm
	DROP CONSTRAINT FK_gen_PaymentTerm_GLUser
GO
ALTER TABLE dbo.gen_BOMInfo
	DROP CONSTRAINT FK_gen_BOMInfo_GLUser
GO
ALTER TABLE dbo.data_PurchaseInfo
	DROP CONSTRAINT FK_data_PurchaseInfo_GLUser1
GO
ALTER TABLE dbo.gen_PaymentTerm
	DROP CONSTRAINT FK_gen_PaymentTerm_GLUser1
GO
ALTER TABLE dbo.gen_BOMInfo
	DROP CONSTRAINT FK_gen_BOMInfo_GLUser1
GO
ALTER TABLE dbo.gen_Pes_SaleManInfo
	DROP CONSTRAINT FK_gen_Pes_SaleManInfo_GLUser
GO
ALTER TABLE dbo.gen_Pes_SaleManInfo
	DROP CONSTRAINT FK_gen_Pes_SaleManInfo_GLUser1
GO
ALTER TABLE dbo.gen_BOMPlanning
	DROP CONSTRAINT FK_gen_BOMPlanning_GLUser
GO
ALTER TABLE dbo.addata_VehicleRecoveryInformation
	DROP CONSTRAINT FK_addata_VehicleRecoveryInformation_GLUser
GO
ALTER TABLE dbo.gen_BOMPlanning
	DROP CONSTRAINT FK_gen_BOMPlanning_GLUser1
GO
ALTER TABLE dbo.addata_VehicleRecoveryInformation
	DROP CONSTRAINT FK_addata_VehicleRecoveryInformation_GLUser1
GO
ALTER TABLE dbo.GLUserBranchDetail
	DROP CONSTRAINT FK_GLUserBranchDetail_GLUser
GO
ALTER TABLE dbo.data_pes_PRVoucherInfo
	DROP CONSTRAINT FK_data_pes_PRVoucherInfo_GLUser
GO
ALTER TABLE dbo.GluserDetailWhid
	DROP CONSTRAINT FK_GluserDetailWhid_GLUser
GO
ALTER TABLE dbo.data_pes_PRVoucherInfo
	DROP CONSTRAINT FK_data_pes_PRVoucherInfo_GLUser1
GO
ALTER TABLE dbo.data_DisassemblingInfo
	DROP CONSTRAINT FK_data_DisassemblingInfo_GLUser
GO
ALTER TABLE dbo.data_PurchaseOrder
	DROP CONSTRAINT FK_data_PurchaseOrder_GLUser
GO
ALTER TABLE dbo.data_pes_SalesManExpense
	DROP CONSTRAINT FK_data_pes_SalesManExpense_GLUser
GO
ALTER TABLE dbo.data_DisassemblingInfo
	DROP CONSTRAINT FK_data_DisassemblingInfo_GLUser1
GO
ALTER TABLE dbo.gen_BranchInfo
	DROP CONSTRAINT FK_gen_BranchInfo_GLUser
GO
ALTER TABLE dbo.data_PurchaseOrder
	DROP CONSTRAINT FK_data_PurchaseOrder_GLUser1
GO
ALTER TABLE dbo.gen_BranchInfo
	DROP CONSTRAINT FK_gen_BranchInfo_GLUser1
GO
ALTER TABLE dbo.adgen_ColorInfo
	DROP CONSTRAINT FK_adgen_ColorInfo_GLUser
GO
ALTER TABLE dbo.adgen_ColorInfo
	DROP CONSTRAINT FK_adgen_ColorInfo_GLUser1
GO
ALTER TABLE dbo.gen_BrokerInformation
	DROP CONSTRAINT FK_gen_BrokerInformation_GLUser
GO
ALTER TABLE dbo.GLUser
	DROP CONSTRAINT PK_GLUser
GO
ALTER TABLE dbo.GLUser SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.adgen_ColorInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_BranchInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_pes_SalesManExpense SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_PurchaseOrder SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_DisassemblingInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.GluserDetailWhid SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_pes_PRVoucherInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.GLUserBranchDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.addata_VehicleRecoveryInformation SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_BOMPlanning SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_Pes_SaleManInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_BOMInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_PaymentTerm SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_PurchaseInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.addata_VehicleReceiveInformation SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_PertaFormInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_PaymentMode SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_SalePosReturnInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_PartyGroup SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_BankInformation SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_TestInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.tblMachineUsers SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_SalePosInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.addata_VehiclePaymentInformation SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_PayRollInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_CounterPurchase SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_TaxInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Pdata_StockFlockTransferInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_TaxGroupInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_ParentsInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_PaperProductionInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.addata_VehicleDeliveryInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_UserRegistration SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ContainersGatePass SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_MasterEquipmentInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ChallanFeesRecoveryInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_MachineAttdendanceInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.addata_TrackerAssigmentinfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_PrReleaseOrder SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_CertificateInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_JobCardType SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ItemChangeInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_MisplExchangeSaleInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ProjectsRegistration SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.PData_PurchaseInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ToolsIssuence SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_SaleDistributionRecoveryInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ProjectsPhases SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_IncentiveInformation SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_AttendanceInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_MarksUploadInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.pdata_outwardGatePassInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_TestAssignToClassInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_GroupLevel SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ProjectCosting SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.addata_StockReturnFromJobCardInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_GradeDefine SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.addata_SaleInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ProgramRegistration SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_Event SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_StudentsAttendanceInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.adgen_VehicleRegistrationInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ManufacturingOverheadInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Pdata_LayerActivitiesInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_EmployeeLeaveTypeInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_SaleAdjustmentInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.adgen_VehicleInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_EmployeeLeaveInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.pdata_inwardGatePassInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_StockTransferInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.adgen_VehicleGroup SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.addata_RecoveryInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ManufacturingInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ReelProductionInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.adgen_VarientInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_EmployeeInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.adgen_ScheduleMaintainenceInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_PlotsToken SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Pdata_HatcheryMachineInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_QuotationInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_EmployeeIncrementInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_SubPartiesInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.PData_Hatchery SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_StockInOutInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_PlotsSize SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.adgen_SaleServiceInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_SubjectInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_LoanInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Pdata_FlockShedLayer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_SubjectAssignInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.adgen_JobInsuranceEstApprovalInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.Mdata_SurveyInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_DesignationInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_PurchaseReturnInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.addata_generalGatePassInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_DepartmentInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_PlotsInstallments SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.adgen_InsuranceJobEstimateInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_InwardGatePassInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_StudentInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_CustomerEquipmentInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.addata_DispatchInformation SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_PlotsGenerate SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_ClassInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_StockInOutType SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_PlotsDefine SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_ShippingSaleInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_ClassAssignToTeacherInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.addata_CustomerInvoiceInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_SaleTrackerInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_PlotsBooking SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.adgen_ActivityTypeInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_InventItemsBarcode SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.addata_CustomerInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_CheckBookInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_SchemeInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_PurchaseRequisition SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.addata_VehicleTransferInformation SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_CategoryLevel SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_GeneralSaleBookingInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_pes_TargetAssigningInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_CashInformation SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_FeesChallansInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_pes_SalesManTargetInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_SaleManInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_ItemMainGroupInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_SaleReturnInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.addata_VehicleSaleInformation SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_BrokerInformation SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
