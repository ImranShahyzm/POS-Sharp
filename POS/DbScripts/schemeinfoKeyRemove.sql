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
ALTER TABLE dbo.data_SaleDetail
	DROP CONSTRAINT FK_data_SaleDetail_gen_Pes_SchemeInfo
GO
ALTER TABLE dbo.data_Pes_PRVoucherDetail
	DROP CONSTRAINT FK_data_Pes_PRVoucherDetail_gen_Pes_SchemeInfo
GO
ALTER TABLE dbo.data_pes_SalesManTargetDetail
	DROP CONSTRAINT FK_data_pes_SalesManTargetDetail_gen_Pes_SchemeInfo
GO
ALTER TABLE dbo.gen_Pes_SchemeInfo
	DROP CONSTRAINT PK_gen_Pes_SchemeTypeInfo
GO
ALTER TABLE dbo.gen_Pes_SchemeInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_pes_SalesManTargetDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_Pes_PRVoucherDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.data_SaleDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
