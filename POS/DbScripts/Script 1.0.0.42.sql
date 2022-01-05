
/****** Object:  StoredProcedure [dbo].[rpt_CashBookFoodMama]    Script Date: 7/28/2021 12:45:43 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpt_CashBookFoodMama]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpt_CashBookFoodMama]
GO
/****** Object:  StoredProcedure [dbo].[data_PosBillRecoveries_Insert]    Script Date: 7/28/2021 12:45:43 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_PosBillRecoveries_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_PosBillRecoveries_Insert]
GO
/****** Object:  StoredProcedure [dbo].[data_PosBillRecoveries_Insert]    Script Date: 7/28/2021 12:45:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_PosBillRecoveries_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_PosBillRecoveries_Insert] AS' 
END
GO



ALTER procedure [dbo].[data_PosBillRecoveries_Insert] 
@RecoveryID int  output , 
@RecoverdBy int = null , 
@CompanyID int = null , 
@WHID int = null ,
@RecoveryDate date=null,
@ReceoverdAmount numeric(18,3)=0,
@SalePosID int =null,
@BranchID int=null
as


if	 @RecoveryID = 0
BEGIN
	
	Insert into data_posBillRecoviers ( 
RecoveryDate, ReceoverdAmount, SalePosID, RecoverdBy, CompanyID, WHID, BranchID

	 ) Values (
	@RecoveryDate, @ReceoverdAmount, @SalePosID, @RecoverdBy, @CompanyID, @WHID, @BranchID
	)

	set @RecoveryID = @@IDENTITY
END

ELSE

BEGIN
	update data_posBillRecoviers set	
RecoveryDate=@RecoveryDate, ReceoverdAmount=@ReceoverdAmount, SalePosID=@SalePosID, RecoverdBy=@RecoverdBy, CompanyID=@CompanyID,
 WHID=@WHID, BranchID=@BranchID
	


	where RecoveryID = @RecoveryID

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



GO
/****** Object:  StoredProcedure [dbo].[rpt_CashBookFoodMama]    Script Date: 7/28/2021 12:45:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpt_CashBookFoodMama]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[rpt_CashBookFoodMama] AS' 
END
GO

ALTER procedure [dbo].[rpt_CashBookFoodMama] 
@FromDate date=null, 
@ToDate date=null 
as
(select ISNULL(data_SalePosInfo.SalePOSNo,(Select SalePOSNo from data_SalePosInfo inner join data_posBillRecoviers on data_posBillRecoviers.SalePosID=data_SalePosInfo.SalePosID  Where data_posBillRecoviers.RecoveryID=data_CashIn.SourceID and SourceName='BillRecovery')) as InvoiceNumber, SourceID,(SourceName +' '+ISNULL(Remarks,'')) as SourceName,Amount,FORMAT( [Date] ,'dd-MMM-yyyy') as Date,TimeStamp,Amount as Debit,0 as Credit,1 as CashType from data_CashIn left join data_SalePosInfo on data_SalePosInfo.SalePosID=SourceID and SourceName='POS'

where Date  between @FromDate and @ToDate)
union all
(select data_SalePosReturnInfo.SalePOSNo as InvoiceNumber, SourceID,SourceName,Amount,FORMAT( [Date] ,'dd-MMM-yyyy') as Date,TimeStamp,0 as Debit,Amount as Credit,0 as CashType from data_CashOut left join data_SalePosReturnInfo on data_SalePosReturnInfo.SalePosReturnID=SourceID and SourceName='POS RETURN'
where Date between @FromDate and @ToDate) 
order by TimeStamp asc


GO
