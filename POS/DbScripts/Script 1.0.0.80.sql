USE [PCWORLD_DB]
GO

/****** Object:  StoredProcedure [dbo].[rpt_CashBookCounterWise]    Script Date: 4/5/2022 11:55:30 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpt_CashBookCounterWise]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpt_CashBookCounterWise]
GO

/****** Object:  StoredProcedure [dbo].[rpt_CashBookCounterWise]    Script Date: 4/5/2022 11:55:30 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpt_CashBookCounterWise]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[rpt_CashBookCounterWise] AS' 
END
GO


ALTER procedure [dbo].[rpt_CashBookCounterWise] 
@FromDate date=null, 
@ToDate date=null ,
@CounterID int=0
as
(select ISNULL(data_SalePosInfo.SalePOSNo,(Select SalePOSNo from data_SalePosInfo inner join data_posBillRecoviers on data_posBillRecoviers.SalePosID=data_SalePosInfo.SalePosID  Where data_posBillRecoviers.RecoveryID=data_CashIn.SourceID and SourceName='BillRecovery')) as InvoiceNumber, SourceID,(SourceName +' '+ISNULL(Remarks,'')) as SourceName,Amount,FORMAT( [Date] ,'dd-MMM-yyyy') as Date,FORMAT([TimeStamp], 'dd-MMM-yyyy hh:mm tt') as TimeStamp,Amount as Debit,0 as Credit,1 as CashType from data_CashIn left join data_SalePosInfo on data_SalePosInfo.SalePosID=SourceID and SourceName='POS'

where Date  between @FromDate and @ToDate and data_CashIn.CounterID=@CounterID)
union all
(select data_SalePosReturnInfo.SalePOSNo as InvoiceNumber, SourceID,ISNULL(Remarks,SourceName) as SourceName,Amount,FORMAT( [Date] ,'dd-MMM-yyyy') as Date,FORMAT([TimeStamp], 'dd-MMM-yyyy hh:mm tt') as TimeStamp,0 as Debit,Amount as Credit,0 as CashType from data_CashOut left join data_SalePosReturnInfo on data_SalePosReturnInfo.SalePosReturnID=SourceID and SourceName='POS RETURN'
where Date between @FromDate and @ToDate and data_Cashout.CounterID=@CounterID) 
order by TimeStamp asc










GO


