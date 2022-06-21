IF NOT EXISTS (SELECT 1 FROM sys.columns 
				WHERE name = N'NoOfCountersAllowed' 
				and object_id = object_id(N'dbo.gen_SystemConfiguration'))
BEGIN
BEGIN TRANSACTION
	ALTER TABLE dbo.gen_SystemConfiguration ADD
	NoOfCountersAllowed tinyint NULL
COMMIT
END
GO


IF COL_LENGTH ('dbo.gen_SystemConfiguration', 'NoOfCountersAllowed') IS NULL
BEGIN
BEGIN TRANSACTION
	ALTER TABLE dbo.gen_SystemConfiguration ADD  
	NoOfCountersAllowed tinyint NOT NULL
COMMIT
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns 
				WHERE name = N'SoftwareExpiryDate' 
				and object_id = object_id(N'dbo.gen_SystemConfiguration'))
BEGIN
BEGIN TRANSACTION
	ALTER TABLE dbo.gen_SystemConfiguration ADD
	SoftwareExpiryDate Date NULL
COMMIT
END
GO


/****** Object:  StoredProcedure [dbo].[gen_PosConfiguration_Insert]    Script Date: 6/21/2022 1:13:31 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[gen_PosConfiguration_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[gen_PosConfiguration_Insert]
GO
/****** Object:  StoredProcedure [dbo].[gen_PosConfiguration_Insert]    Script Date: 6/21/2022 1:13:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[gen_PosConfiguration_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[gen_PosConfiguration_Insert] AS' 
END
GO




ALTER procedure [dbo].[gen_PosConfiguration_Insert]
@ConfigID int  output 
,@CompanyID  int=NULL
,@WHID  int=NULL
,@FiscalID  int=NULL
,@AppID  int=NULL
,@ClosingType  int=NULL
,@ClosinngSource  int=NULL
,@RevenueAccountPOS  int 
,@BranchID  int=NULL
,@CashAccountPos  int=NULL
,@LocationID  int=NULL
,@isKhaakiSoft  bit=NULL
,@DiscountGL  int=NULL
,@CostAcccount  int=NULL
,@POSStyle  nvarchar(250)=null
,@CounterID  int=1
,@CounterPCName   nvarchar(max)=''
,@CounterTitle   nvarchar(max)=''
,@IsofflineServer  bit=NULL
,@OpeningSourceID  int=NULL
,@ClosingSourceID  int=NULL
,@RunningSessionID  int=NULL

as
if	 @ConfigID = 0
BEGIN
   
   Select @CounterID=Max(CounterID) from gen_PosConfiguration
			set @CounterID=isnull(@CounterID,1)
Select @CompanyID=CompanyID,@Whid=DefaultWHID from gen_SystemConfiguration
Select Top 1 @FiscalID=Fiscalid from GLFiscalYear where Companyid=@CompanyID order by EndYear desc


	Insert into gen_PosConfiguration (
			[CompanyID]
           ,[WHID]
           ,[FiscalID]
           ,[AppID]
           ,[ClosingType]
           ,[ClosinngSource]
           ,[RevenueAccountPOS]
           ,[BranchID]
           ,[CashAccountPos]
           ,[LocationID]
           ,[isKhaakiSoft]
           ,[DiscountGL]
           ,[CostAcccount]
           ,[POSStyle]
           ,[CounterID]
           ,[CounterPCName]
           ,[CounterTitle]
           ,[IsofflineServer]
           ,[OpeningSourceID]
           ,[ClosingSourceID]
		   ,NoOfInvoicePrint
		   )
	 VALUES ( @CompanyID, @WHID, @FiscalID, 1, @ClosingType, @ClosinngSource, @RevenueAccountPOS, @BranchID, @CashAccountPos, 1, 0, NULL, NULL, N'POSPcWorldStyle', @CounterID, N''+@CounterPCName, N'New - COUNTER '+cast(@CounterID as nvarchar(50)), 1, 1, 4, 1
	 )
							 
	set @ConfigID = @@IDENTITY
END
--ELSE
--BEGIN
	
--	    where Config = @ConfigurationID
--END


GO

	