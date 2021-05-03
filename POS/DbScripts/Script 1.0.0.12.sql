
/****** Object:  StoredProcedure [dbo].[data_PosBillRecoveries_Insert]    Script Date: 5/3/2021 12:39:11 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_PosBillRecoveries_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_PosBillRecoveries_Insert]
GO
/****** Object:  Table [dbo].[data_posBillRecoviers]    Script Date: 5/3/2021 12:39:11 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_posBillRecoviers]') AND type in (N'U'))
DROP TABLE [dbo].[data_posBillRecoviers]
GO
/****** Object:  Table [dbo].[data_posBillRecoviers]    Script Date: 5/3/2021 12:39:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_posBillRecoviers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[data_posBillRecoviers](
	[RecoveryID] [int] NULL,
	[RecoveryDate] [datetime] NULL,
	[ReceoverdAmount] [numeric](18, 3) NULL,
	[SalePosID] [int] NULL,
	[RecoverdBy] [int] NULL,
	[CompanyID] [int] NULL,
	[WHID] [int] NULL,
	[BranchID] [int] NULL,
	[CashInId] [int] NULL
) ON [PRIMARY]
END
GO
/****** Object:  StoredProcedure [dbo].[data_PosBillRecoveries_Insert]    Script Date: 5/3/2021 12:39:11 PM ******/
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






	EXEC [dbo].[data_Cash_Insert]
		@SourceID = @RecoveryID,
		@SourceName = N'BillRecovery',
		@Amount = @ReceoverdAmount,
		@CashType = 1,
		@SalePosDate=@RecoveryDate


GO
