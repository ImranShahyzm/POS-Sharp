IF NOT EXISTS (SELECT 1 FROM sys.columns 
				WHERE name = N'ApiIpAddress' 
				and object_id = object_id(N'dbo.gen_PosConfiguration'))
BEGIN
BEGIN TRANSACTION
	ALTER TABLE dbo.gen_PosConfiguration ADD
	ApiIpAddress nvarchar(1000) NULL
COMMIT
END
GO


/****** Object:  StoredProcedure [dbo].[gen_posConfiguration_SelectAll]    Script Date: 6/22/2022 1:35:50 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[gen_posConfiguration_SelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[gen_posConfiguration_SelectAll]
GO
/****** Object:  StoredProcedure [dbo].[gen_PosConfiguration_Insert]    Script Date: 6/22/2022 1:35:50 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[gen_PosConfiguration_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[gen_PosConfiguration_Insert]
GO
/****** Object:  StoredProcedure [dbo].[gen_PosConfiguration_Insert]    Script Date: 6/22/2022 1:35:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[gen_PosConfiguration_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[gen_PosConfiguration_Insert] AS' 
END
GO




-- Server : DESKTOP-Q54D9J1 -- 






ALTER procedure [dbo].[gen_PosConfiguration_Insert]
@ConfigID int  output 
,@CompanyID  int=NULL
,@WHID  int=NULL
,@FiscalID  int=NULL
,@AppID  int=NULL
,@ClosingType  int=NULL
,@ClosinngSource  int=NULL
,@RevenueAccountPOS  int =NULL
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
,@ApiIpAddress nvarchar(1000)=NULL
,@ISFbrConnectivity bit=0
,@POSID int=0,
@NoOfInvoicePrint int=1,
@BillPreFix nvarchar(500)='D'
as
if	 @ConfigID = 0
BEGIN
   
   Select @CounterID=Max(CounterID) from gen_PosConfiguration
			set @CounterID=isnull(@CounterID,0)+1
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
ELSE
BEGIN
	update gen_PosConfiguration

	set
			
         
          
        
         
            RevenueAccountPOS 	=@RevenueAccountPOS
       
           , CashAccountPos 	=@CashAccountPos 
          
           , POSStyle 			=@POSStyle 
         
           , CounterTitle 		=@CounterTitle 
           , IsofflineServer 	=@IsofflineServer 
           , OpeningSourceID 	=@OpeningSourceID 
           , ClosingSourceID 	=@ClosingSourceID 
		   , ApiIpAddress=@ApiIpAddress
		,	ISFbrConnectivity=@ISFbrConnectivity
		,NoOfInvoicePrint=@NoOfInvoicePrint
		,	POSID=@POSID
		,BillPreFix=@BillPreFix
	    where ConfigID = @ConfigID
END


GO
/****** Object:  StoredProcedure [dbo].[gen_posConfiguration_SelectAll]    Script Date: 6/22/2022 1:35:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[gen_posConfiguration_SelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[gen_posConfiguration_SelectAll] AS' 
END
GO




ALTER procedure [dbo].[gen_posConfiguration_SelectAll] 
@CounterID int=0,
@WhereClause nvarchar(Max)=''
as
begin

		
		exec('Select gen_PosConfiguration.*,GLCompany.Title,InventWareHouse.LocationAddress from gen_PosConfiguration inner join GLCompany
on GLCompany.Companyid=gen_PosConfiguration.CompanyID
inner join InventWareHouse on InventWareHouse.WHID=gen_PosConfiguration.WHID where 0=0 '+ @WhereClause)
		
	end
	


GO
