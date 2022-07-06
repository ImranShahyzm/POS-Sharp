

IF NOT EXISTS (SELECT 1 FROM sys.columns 
				WHERE name = N'IsSessionHandling' 
				and object_id = object_id(N'dbo.gen_PosConfiguration'))
BEGIN
BEGIN TRANSACTION
	ALTER TABLE dbo.gen_PosConfiguration ADD
	IsSessionHandling bit NULL
COMMIT
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.columns 
				WHERE name = N'NoOfInvoicePrint' 
				and object_id = object_id(N'dbo.gen_PosConfiguration'))
BEGIN
BEGIN TRANSACTION
	ALTER TABLE dbo.gen_PosConfiguration ADD
	NoOfInvoicePrint TINYINT NULL
COMMIT
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns 
				WHERE name = N'SystemColumnDt' 
				and object_id = object_id(N'dbo.gen_PosConfiguration'))
BEGIN
BEGIN TRANSACTION
	ALTER TABLE dbo.gen_PosConfiguration ADD
	SystemColumnDt NVARCHAR(Max)
COMMIT
END
GO

UPDATE gen_PosConfiguration SET SystemColumnDt= 'TMR69aFW0Og='


Go






alter procedure [dbo].[data_Cash_Insert] 
@SourceID	bigint,
@SourceName	nvarchar(500),
@Amount	decimal(18,2),
@CashType bit=0,
@SalePosDate date=null,
@CompanyID int=0,
@UserID int=0,
@FiscalID int=0,
@Remarks nvarchar(max)=null,
@CounterID int =NULL,
@ShiftID int =NULL

--@CashInOut bigint output

as
declare @OpCashSourceID int,@ClosingCashSourceID int,@RunningSessionID int=0,@IsSessionHandling bit=0
Select @OpCashSourceID=OpeningSourceID,@ClosingCashSourceID=ClosingSourceID,@RunningSessionID=ISNULl(RunningSessionID,0) ,@IsSessionHandling=ISNULL(IsSessionHandling,0) FROM gen_PosConfiguration where 
 CounterID=@CounterID
  IF @IsSessionHandling=1
 begin
if @CounterID>0
begin
	if @RunningSessionID<=0 and @SourceID=@OpCashSourceID
	begin

		exec POSdata_SessionHandling_Insert @RunningSessionID output,@CounterID=@CounterID,@isClosingReportGenerated=0
	end
	else if @RunningSessionID>0 and @SourceID=@OpCashSourceID
	begin
		RAISERROR ('Another Session is Already Running Plz Close first to Open new One...' , 16, 1 ) ;
	return
	end
	if @RunningSessionID=0
	begin
	RAISERROR ('None of the Session Currently Running Plz Open new One...' , 16, 1 ) ;
	return
	end
	set @ShiftID=@RunningSessionID
	if @RunningSessionID>0 and @SourceID=@ClosingCashSourceID
	begin
		exec POSdata_SessionHandling_Insert @RunningSessionID output,@CounterID=@CounterID,@isClosingReportGenerated=0
	end
end
END

if	 @CashType = 1
BEGIN

	Insert into data_CashIn( 
		SourceID,
		SourceName,
		Amount,
		Date,
		TimeStamp,
		Remarks,
		CounterID,
		ShiftID
	)
	Values (
		@SourceID,
		@SourceName,
		@Amount,
		@SalePosDate,
		getdate(),
		@Remarks,
		@CounterID,
		@ShiftID
	)
		
	
--set @CashInOut = @@IDENTITY
END
else
BEGIN
declare @CashSource int=0,@ClosingTypeID int=0,@ClosingID int=@SourceID,@CashInOut int=0
Select @CashSource=ISNULL(CashTypeSourceID,0) from gen_CashTypeSource where SourceName=@SourceName
Select @ClosingTypeID=ISNULL(ClosinngSource,0) from gen_PosConfiguration where CompanyID=@CompanyID
 if @ClosingTypeID=@CashSource and @ClosingTypeID>0
 begin
 exec  gen_PosCashClosing_Insert	@ClosingID=@ClosingID output,@CompanyID=@CompanyID,@ClosedBy=@UserID,@SourceID=@CashInOut,@ClosingDate=@SalePosDate,@FiscalID=@FiscalID,@ClosingAmount=@Amount
 end

Insert into data_CashOut( 
		SourceID,
		SourceName,
		Amount,
		Date,
		TimeStamp,
		Remarks,
		CounterID,
		ShiftID
	)
	Values (
		@ClosingID,
		@SourceName,
		@Amount,
		@SalePosDate,
		getdate(),
		@Remarks,
		@CounterID,
		@ShiftID
	)	
 set @CashInOut = @@IDENTITY
 
 end



Go





-- Server : DESKTOP-Q54D9J1 -- 






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
@BillPreFix nvarchar(500)='D',
@SystemColumnDt NVARCHAR(MAX)='',
@IsSessionHandling BIT=NULL
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
		   ,NoOfInvoicePrint,
		   SystemColumnDt,
		   IsSessionHandling
		   )
	 VALUES ( @CompanyID, @WHID, @FiscalID, 1, @ClosingType, @ClosinngSource, @RevenueAccountPOS, @BranchID, @CashAccountPos, 1, 0, NULL, NULL, N'POSPcWorldStyle', @CounterID, N''+@CounterPCName, N'New - COUNTER '+cast(@CounterID as nvarchar(50)), 1, 1, 4, 1,@SystemColumnDt,@IsSessionHandling
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
		,BillPreFix=@BillPreFix,
		SystemColumnDt=@SystemColumnDt,
		IsSessionHandling=@IsSessionHandling
	    where ConfigID = @ConfigID
END

GO






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
@BillPreFix nvarchar(500)='D',
@SystemColumnDt NVARCHAR(MAX)='',
@IsSessionHandling BIT=NULL
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
		   ,NoOfInvoicePrint,
		   SystemColumnDt,
		   IsSessionHandling
		   )
	 VALUES ( @CompanyID, @WHID, @FiscalID, 1, @ClosingType, @ClosinngSource, @RevenueAccountPOS, @BranchID, @CashAccountPos, 1, 0, NULL, NULL, N'POSPcWorldStyle', @CounterID, N''+@CounterPCName, N'New - COUNTER '+cast(@CounterID as nvarchar(50)), 1, 1, 4, 1,N''+@SystemColumnDt,@IsSessionHandling
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
		,BillPreFix=@BillPreFix,
		SystemColumnDt=N''+@SystemColumnDt,
		IsSessionHandling=@IsSessionHandling
	    where ConfigID = @ConfigID
		/****For All Counters Updating SystemColumns...*****/
		UPDATE gen_PosConfiguration SET SystemColumnDt=N''+@SystemColumnDt WHERE 0=0

END

Go
