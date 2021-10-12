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
ALTER TABLE dbo.data_CashIn ADD
	CounterID int NULL
GO
ALTER TABLE dbo.data_CashIn SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
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
ALTER TABLE dbo.data_CashOut ADD
	CounterID int NULL
GO
ALTER TABLE dbo.data_CashOut SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


/****** Object:  StoredProcedure [dbo].[data_Cash_Insert]    Script Date: 10/11/2021 4:37:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









ALTER procedure [dbo].[data_Cash_Insert] 
@SourceID	bigint,
@SourceName	nvarchar(500),
@Amount	decimal(18,2),
@CashType bit=0,
@SalePosDate date=null,
@CompanyID int=0,
@UserID int=0,
@FiscalID int=0,
@Remarks nvarchar(max)=null,
@CounterID int =NULL

--@CashInOut bigint output

as

if	 @CashType = 1
BEGIN
	Insert into data_CashIn( 
		SourceID,
		SourceName,
		Amount,
		Date,
		TimeStamp,
		Remarks,
		CounterID
	)
	Values (
		@SourceID,
		@SourceName,
		@Amount,
		@SalePosDate,
		getdate(),
		@Remarks,
		@CounterID
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
		CounterID
	)
	Values (
		@ClosingID,
		@SourceName,
		@Amount,
		@SalePosDate,
		getdate(),
		@Remarks,
		@CounterID
	)	
 set @CashInOut = @@IDENTITY
 
 end



Go

/****** Object:  StoredProcedure [dbo].[rpt_CashBookFoodMama]    Script Date: 10/11/2021 4:47:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[rpt_CashBookCounterWise] 
@FromDate date=null, 
@ToDate date=null ,
@CounterID int=0
as
(select ISNULL(data_SalePosInfo.SalePOSNo,(Select SalePOSNo from data_SalePosInfo inner join data_posBillRecoviers on data_posBillRecoviers.SalePosID=data_SalePosInfo.SalePosID  Where data_posBillRecoviers.RecoveryID=data_CashIn.SourceID and SourceName='BillRecovery')) as InvoiceNumber, SourceID,(SourceName +' '+ISNULL(Remarks,'')) as SourceName,Amount,FORMAT( [Date] ,'dd-MMM-yyyy') as Date,TimeStamp,Amount as Debit,0 as Credit,1 as CashType from data_CashIn left join data_SalePosInfo on data_SalePosInfo.SalePosID=SourceID and SourceName='POS'

where Date  between @FromDate and @ToDate and data_CashIn.CounterID=@CounterID)
union all
(select data_SalePosReturnInfo.SalePOSNo as InvoiceNumber, SourceID,ISNULL(Remarks,SourceName) as SourceName,Amount,FORMAT( [Date] ,'dd-MMM-yyyy') as Date,TimeStamp,0 as Debit,Amount as Credit,0 as CashType from data_CashOut left join data_SalePosReturnInfo on data_SalePosReturnInfo.SalePosReturnID=SourceID and SourceName='POS RETURN'
where Date between @FromDate and @ToDate and data_Cashout.CounterID=@CounterID) 
order by TimeStamp asc
Go







