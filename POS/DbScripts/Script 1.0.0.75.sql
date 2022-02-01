IF NOT EXISTS (SELECT 1 FROM sys.columns 
				WHERE name = N'IsBarcodePrinter' 
				and object_id = object_id(N'dbo.gen_PosConfiguration'))
BEGIN
BEGIN TRANSACTION
	ALTER TABLE dbo.gen_PosConfiguration ADD
	IsBarcodePrinter int NULL
COMMIT
END
GO

-----------
--Column_Name bit NOT NULL CONSTRAINT DF_GLUserGroupDetail_IsApprove DEFAULT 0
-----------OR

IF COL_LENGTH ('dbo.gen_PosConfiguration', 'IsBarcodePrinter') IS NULL
BEGIN
BEGIN TRANSACTION
	ALTER TABLE dbo.gen_PosConfiguration ADD  
	IsBarcodePrinter int Not NULL
COMMIT
END
GO

