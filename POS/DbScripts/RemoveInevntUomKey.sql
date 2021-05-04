﻿/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
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
ALTER TABLE dbo.gen_BOMDetail
	DROP CONSTRAINT FK_gen_BOMDetail_InventUOM
GO
ALTER TABLE dbo.gen_BOMInfo
	DROP CONSTRAINT FK_gen_BOMInfo_InventUOM
GO
ALTER TABLE dbo.gen_BOMPlanning
	DROP CONSTRAINT FK_gen_BOMPlanning_InventUOM
GO
ALTER TABLE dbo.InventUOM
	DROP CONSTRAINT PK_InventUOM
GO
ALTER TABLE dbo.InventUOM SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_BOMPlanning SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_BOMInfo SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.gen_BOMDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT