



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