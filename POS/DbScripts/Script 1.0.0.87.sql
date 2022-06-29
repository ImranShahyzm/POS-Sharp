
alter procedure [dbo].[gen_PosConfiguration_Insert]
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


declare @AccountLevel tinyint , @GroupAccount int,@GLCAID int=0,@CounterAccount nvarchar(1000)=N'Cash Account at Counter No '+cast(@CounterID as nvarchar(50))
	
	select @GroupAccount = CashGroupCode , @AccountLevel = AccountLevel from gen_SystemConfiguration where CompanyID = @CompanyID
	exec AccountAutoInsertWithGroupAndLevel @GLCAID output , @CounterAccount , @CompanyID , @FiscalID , 1 , @AccountLevel ,@GroupAccount

	set @CashAccountPos=@GLCAID
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


