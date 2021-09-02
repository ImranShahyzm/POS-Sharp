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
ALTER TABLE dbo.data_posBillRecoviers ADD
	RiderAmountRecovery numeric(18, 3) NULL
GO
ALTER TABLE dbo.data_posBillRecoviers SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

/****** Object:  StoredProcedure [dbo].[data_PosBillRecoveries_Insert]    Script Date: 9/2/2021 10:34:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER procedure [dbo].[data_PosBillRecoveries_Insert] 
@RecoveryID int  output , 
@RecoverdBy int = null , 
@CompanyID int = null , 
@WHID int = null ,
@RecoveryDate date=null,
@ReceoverdAmount numeric(18,3)=0,
@SalePosID int =null,
@BranchID int=null,
@RiderAmountRecovery numeric(18,3)=0
as


if	 @RecoveryID = 0
BEGIN
	
	Insert into data_posBillRecoviers ( 
RecoveryDate, ReceoverdAmount, SalePosID, RecoverdBy, CompanyID, WHID, BranchID,RiderAmountRecovery

	 ) Values (
	@RecoveryDate, @ReceoverdAmount, @SalePosID, @RecoverdBy, @CompanyID, @WHID, @BranchID,@RiderAmountRecovery
	)

	set @RecoveryID = @@IDENTITY
END

ELSE

BEGIN
	update data_posBillRecoviers set	
RecoveryDate=@RecoveryDate, ReceoverdAmount=@ReceoverdAmount, SalePosID=@SalePosID, RecoverdBy=@RecoverdBy, CompanyID=@CompanyID,
 WHID=@WHID, BranchID=@BranchID,RiderAmountRecovery=@RiderAmountRecovery
	


	where RecoveryID = @RecoveryID
	delete from data_CashIn where SourceName='BillRecovery' and SourceID=@RecoveryID

END


declare @PosDate nvarchar(Max)=''
Select @PosDate =' Dated on ' +Format(SalePosDate,'dd-MMM-yyyy') from data_SalePosInfo where SalePosID=@SalePosID

	EXEC [dbo].[data_Cash_Insert]
		@SourceID = @RecoveryID,
		@SourceName = N'BillRecovery',
		@Amount = @ReceoverdAmount,
		@CashType = 1,
		@SalePosDate=@RecoveryDate,
		@Remarks=@PosDate

		if @RiderAmountRecovery>0
		begin
		Select @PosDate ='Exchange Amount Recovered against Bill Dated on ' +Format(SalePosDate,'dd-MMM-yyyy') from data_SalePosInfo where SalePosID=@SalePosID

		EXEC [dbo].[data_Cash_Insert]
		@SourceID = @RecoveryID,
		@SourceName = N'BillRecovery',
		@Amount = @RiderAmountRecovery,
		@CashType = 1,
		@SalePosDate=@RecoveryDate,
		@Remarks=@PosDate

		end


Go
