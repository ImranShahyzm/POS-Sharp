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
	ShiftID int NULL
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
	ShiftID int NULL
GO
ALTER TABLE dbo.data_CashOut SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


/****** Object:  StoredProcedure [dbo].[data_Cash_Insert]    Script Date: 10/12/2021 1:44:38 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_Cash_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_Cash_Insert]
GO
/****** Object:  StoredProcedure [dbo].[data_Cash_Insert]    Script Date: 10/12/2021 1:44:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_Cash_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_Cash_Insert] AS' 
END
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
@CounterID int =NULL,
@ShiftID int =NULL

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




GO
