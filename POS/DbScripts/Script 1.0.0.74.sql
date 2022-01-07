
IF NOT EXISTS (SELECT 1 FROM sys.columns 
				WHERE name = N'NoOfInvoicePrint' 
				and object_id = object_id(N'dbo.gen_PosConfiguration'))
BEGIN
BEGIN TRANSACTION
	ALTER TABLE dbo.gen_PosConfiguration ADD
	NoOfInvoicePrint tinyint NOT NULL CONSTRAINT DF_gen_PosConfiguration_NoOfInvoicePrint DEFAULT 1
COMMIT
END
GO

