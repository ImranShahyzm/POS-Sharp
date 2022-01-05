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
ALTER TABLE dbo.gen_PosConfiguration ADD
	OpeningSourceID int NULL,
	ClosingSourceID int NULL,
	RunningSessionID int NULL
GO
ALTER TABLE dbo.gen_PosConfiguration SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

/****** Object:  StoredProcedure [dbo].[data_SalePosReturnInfo_Insert]    Script Date: 10/14/2021 10:56:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









ALTER procedure [dbo].[data_SalePosReturnInfo_Insert] 
@UserID int = null , 
@CompanyID int = null , 
@FiscalID int = null ,
@SalePosDate	date	=null,
@WHID	int	=null,
@TaxAmount	decimal(18, 2)	=null,
@GrossAmount	decimal(18, 2)	=null,
@DiscountPercentage	decimal(18, 2)	=null,
@DiscountAmount	decimal(18, 2)	=null,
@DiscountTotal	decimal(18, 2)	=null,
@OtherCharges	decimal(18, 2)	=null,
@NetAmount	decimal(18, 2)	=null,
@AmountReceive	decimal(18, 2)	=null,
@AmountReturn	decimal(18, 2)	=null,
@AmountInAccount	decimal(18, 2)=null,
@AmountReceivable	decimal(18, 2)	=null,
@AmountPayable	decimal(18, 2)	=null,
@data_SalePosDetail  data_SalePosDetail   readonly,
@SalePosID bigint output,
@CustomerPhone nvarchar(50)=null,
@CustomerName  nvarchar(50)=null,
@SaleInvoiceNo int=0,
@MenuId int=0,
@InvoiceType int=0,
@CustomerID int=null,
@RiderAmount numeric(18,3)=0,
@LinckedBill int =NULL,
@SaleManId int =NULL,
@CounterID int=NULL
as
declare @returnSale bit=0
declare @IsTaxable bit =0
declare @SalePosReturnID bigint=0
declare @SalePosReturnDetailID bigint=0
declare @SalePosDetailID bigint=0

declare @MaxTable as MaxTable 
declare @MaxTable2 as MaxTable

declare  @SaleID bigint
set @SaleID=@SalePosID
--set @SalePOSReturnID=1

declare @WhereClause1 nvarchar(4000),@WhereClauseDetail1 nvarchar(4000),@ReturnSaleID bigint
set @WhereClause1=' '
select @SalePosID=SalePosID from data_SalePosInfo where saleposNo=@SaleInvoiceNo and SalePosDate=@SalePosDate
--if(@ReturnSaleID is null)
--	begin 
--		set @ReturnSaleID=0
--	end
--	if @ReturnSaleID=0 
--	begin
--	set @WhereClause1='select * from data_SalePosDetail where SalePosID='+cast(@SalePosID as nvarchar(10));
--	end
--	else
--	begin
--		set @WhereClause1='select * from data_SalePosReturnDetail where IsLog=0 and SalePosReturnID='+cast(@ReturnSaleID as nvarchar(10));
--	end

declare @IsLog bit
select @IsLog=IsLogActive from gen_systemConfiguration where CompanyID=@CompanyID


if(@SalePosID>0)
begin
exec GetVoucherNoPosFoodMama @Fieldname=N'SalePOSNo',@TableName=N'data_SalePosReturnInfo',@CheckTaxable= 0 ,@PrimaryKeyValue = @SalePosReturnID,@PrimaryKeyFieldName = 'SalePosReturnID' ,
	@voucherDate=@SalePOSDate,@voucherDateFieldName=N'SalePosReturnDate',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=@FiscalID, 
	@FiscalIDFieldName=N'FiscalID',@IsTaxable=@IsTaxable,@MenuId=@MenuId,@MenuFieldName=N'MenuId',@CounterID=@CounterID,@CounterField=N'CounterID'
	select @SaleInvoiceNo = VoucherNo from @MaxTable

--This Will Record Sale Replace or Sale Edit

Insert into data_SalePosReturnInfo (
		SalePosID, 
		EntryUserID,
		EntryUserDateTime,
		CompanyID,
		FiscalID,
		SalePosReturnDate,
		WHID,
		TaxAmount,
		GrossAmount,
		DiscountPercentage,
		DiscountAmount,
		DiscountTotal,
		OtherCharges,
		NetAmount,
		AmountReceive,
		AmountReturn,
		AmountInAccount,
		AmountReceivable,
		AmountPayable,
		CustomerPhone,
		CustomerName ,
		SalePOSNo,
		MenuId,
		InvoiceType,
		SaleManId,
		CounterID
	)
	Select 
	SalePosID, 
	EntryUserID,
	GETDATE(),
	CompanyID,
	@FiscalID,
	@SalePosDate,
	@WHID,
	@TaxAmount,
	@GrossAmount,
	@DiscountPercentage,
	@DiscountAmount,
	@DiscountTotal,
	@OtherCharges,
	@NetAmount,
	@AmountReceive,
	@AmountReturn,
	@AmountInAccount,
	@AmountReceivable,
	@AmountPayable,
	@CustomerPhone,
	@CustomerName ,
	@SaleInvoiceNo,
	@MenuId,
	@InvoiceType,
	@SaleManId,
	@CounterID

	from data_SalePosInfo
	where SalePosID=@SalePosID
	set @SalePosReturnID = SCOPE_IDENTITY()
	

	Insert Into data_SalePosReturnDetail (
		SalePosReturnID,
		SalePosDetailID,
		ItemId,
		Quantity,
		ItemRate,
		TaxPercentage,
		TaxAmount,
		DiscountPercentage,
		DiscountAmount,
		TotalAmount,
		CartonSize,
		Carton,
		TotalQuantity,
		SchemeID,
		MinQuantity

		) Select
		@SalePosReturnID ,
		SalePosDetailID,
		ItemId,
		Quantity,
		ItemRate,
		TaxPercentage,
		TaxAmount,
		DiscountPercentage,
		DiscountAmount,
		TotalAmount,
	
		CartonSize,
		Carton,
		TotalQuantity,
		SchemeID,
		MinQuantity

		From @data_SalePosDetail 
		
end





		 declare @productInflowID int
DECLARE @PractitionerId int,@StockRate numeric(18,3)=0
declare @PosSaleReturnDetailID int ,@PosStockRate numeric(14,5) , @PosQuantity numeric(10,2),@PosItemId int,@PosstockQty numeric(14,2),@ManufacturingID int=0
	
DECLARE MY_CURSOR CURSOR 
  LOCAL STATIC READ_ONLY FORWARD_ONLY
FOR 
SELECT SalePosReturnDetailID from data_SalePosReturnInfo inner join data_SalePosReturnDetail 
on data_SalePosReturnInfo.SalePosReturnID=data_SalePosReturnDetail.SalePosReturnID 
where data_SalePosReturnDetail.IsLog=0 and  data_SalePosReturnInfo.SalePosID=@SalePosID

OPEN MY_CURSOR
FETCH NEXT FROM MY_CURSOR INTO @PractitionerId
WHILE @@FETCH_STATUS = 0
BEGIN 
    --Do something with Id here
    PRINT @PractitionerId
	SELECT @PosSaleReturnDetailID=SalePosReturnDetailID,@PosItemId=ItemId,@PosStockRate=ItemRate,@PosQuantity=Quantity,
	@SalePosDetailID=SalePosDetailID 
from data_SalePosReturnInfo inner join data_SalePosReturnDetail 
on data_SalePosReturnInfo.SalePosReturnID=data_SalePosReturnDetail.SalePosReturnID 
where data_SalePosReturnDetail.IsLog=0 and SalePosReturnDetailID=@PractitionerId
Select @ManufacturingID=ManaufacturingID from data_SalePosDetail where SalePosDetailID=@SalePosDetailID

	--watch this
	exec data_ProductInflow_Insert @productInflowID out,@PosItemId,@PosSaleReturnDetailID,'POS RETURN',@WHID, @SalePosDate , 
				@PosStockRate,@PosQuantity,@PosQuantity,@FiscalID , @CompanyID ,@IsTaxable
				exec tempInflowDataTable_Insert @productInflowID ,'POS RETURN'
	--watht this end
update data_SalePosReturnDetail set IsLog=1 where SalePosReturnDetailID=@PosSaleReturnDetailID


	exec GetWeightedRateForItem @PosItemId, @WHID ,@SalePosDate ,@SalePosDate ,@StockRate output , @CompanyID , @IsTaxable
			

update data_SalePosReturnDetail set StockRate=@StockRate where SalePosReturnDetailID=@PosSaleReturnDetailID



if(@ManufacturingID>0)
begin
exec data_ManufacturingInfo_delete @ManufacturingID=@ManufacturingID
end
    FETCH NEXT FROM MY_CURSOR INTO @PractitionerId
END
CLOSE MY_CURSOR
DEALLOCATE MY_CURSOR


declare @ISOfflineServer bit=0
Select  @ISOfflineServer=ISNULL(IsofflineServer,0) from gen_posConfiguration where WHID=@WHID

if @ISOfflineServer=1
begin

exec  data_SalePOSReturnInfo_InsertAccountOffline @SalePosReturnID=@SalePosReturnID, @SalePosID = @SalePosID, @CompanyID = @CompanyID, @SalePosDate = @SalePosDate , @WHID = @WHID , 
@NetAmount = @NetAmount , @SaleInvoiceNo = @SaleInvoiceNo , @UserID = @UserID , @FiscalID = @FiscalID ,@EditMode = 0,
 @AmountReceivable = @NetAmount

end




		DECLARE @Amount decimal(18,2)=0 
		Select @AmountPayable=@NetAmount
		select @Amount=(select isnull(sum(Amount),0) as Amount from data_CashIn where Date=cast(GETDATE() as date))
                                  -
         (select isnull(sum(Amount),0) as Amount from data_CashOut where Date=cast(GETDATE() as date)) 
		 --select @Amount
		declare @ErrorMessage nvarchar(1000)
		if @AmountPayable>0
		begin
			if	@Amount>@AmountPayable
			begin
				EXEC [dbo].[data_Cash_Insert]
				@SourceID = @SalePosID,
				@SourceName = N'POS Return',
				@Amount = @AmountPayable,
				@CashType = 0,
				@SalePosDate=@SalePosDate,
				@CounterID=@CounterID
			end
			else
				begin
				set @ErrorMessage = 'Not have enough cash!'
					RAISERROR (@ErrorMessage , 16, 1 ) ;
					return
				end
		end
		else
		begin
			EXEC [dbo].[data_Cash_Insert]
			@SourceID = @SalePosID,
			@SourceName = N'POS Replace',
			@Amount = @AmountReceivable,
			@CashType = 1,
			@CounterID=@CounterID
		end
		











select @SalePosID
Go

/****** Object:  StoredProcedure [dbo].[POSdata_SessionHandling_Insert]    Script Date: 10/14/2021 11:05:11 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SessionHandling_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_SessionHandling_Insert]
GO
/****** Object:  StoredProcedure [dbo].[data_Cash_Insert]    Script Date: 10/14/2021 11:05:11 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_Cash_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_Cash_Insert]
GO
/****** Object:  Table [dbo].[POSdata_SessionHandling]    Script Date: 10/14/2021 11:05:11 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SessionHandling]') AND type in (N'U'))
DROP TABLE [dbo].[POSdata_SessionHandling]
GO
/****** Object:  Table [dbo].[POSdata_SessionHandling]    Script Date: 10/14/2021 11:05:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SessionHandling]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[POSdata_SessionHandling](
	[SessionID] [int] IDENTITY(1,1) NOT NULL,
	[SessionStartTime] [datetime] NULL,
	[SessionClosingTime] [datetime] NULL,
	[CounterID] [int] NULL,
	[isClosingReportGenerated] [int] NULL,
 CONSTRAINT [PK_POSdata_SessionHandling] PRIMARY KEY CLUSTERED 
(
	[SessionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  StoredProcedure [dbo].[data_Cash_Insert]    Script Date: 10/14/2021 11:05:11 AM ******/
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
declare @OpCashSourceID int,@ClosingCashSourceID int,@RunningSessionID int=0
Select @OpCashSourceID=OpeningSourceID,@ClosingCashSourceID=ClosingSourceID,@RunningSessionID=RunningSessionID from gen_PosConfiguration where 
 CounterID=@CounterID
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
/****** Object:  StoredProcedure [dbo].[POSdata_SessionHandling_Insert]    Script Date: 10/14/2021 11:05:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SessionHandling_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_SessionHandling_Insert] AS' 
END
GO
ALTER procedure [dbo].[POSdata_SessionHandling_Insert]

@SessionID int output , 
@CounterID int =null,
@isClosingReportGenerated int=0
as
if	 @SessionID = 0
BEGIN

	Insert into  POSdata_SessionHandling (
SessionStartTime, 
CounterID,
isClosingReportGenerated	 
)
 Values (
	
	Getdate() ,
	@CounterID,
	@isClosingReportGenerated
	)
	set @SessionID = @@IDENTITY
update gen_PosConfiguration set RunningSessionID=@SessionID where CounterID=@CounterID
END


ELSE

BEGIN



	update POSdata_SessionHandling set	
	SessionClosingTime=GETDATE()
	where SessionID = @SessionID
update gen_PosConfiguration set RunningSessionID=0 where CounterID=@CounterID
END

GO



IF  EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'vw_posSessionWiseOpClosing', NULL,NULL))
EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPaneCount' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_posSessionWiseOpClosing'

GO
IF  EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'vw_posSessionWiseOpClosing', NULL,NULL))
EXEC sys.sp_dropextendedproperty @name=N'MS_DiagramPane1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_posSessionWiseOpClosing'

GO
/****** Object:  View [dbo].[vw_posSessionWiseOpClosing]    Script Date: 10/14/2021 4:22:46 PM ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_posSessionWiseOpClosing]'))
DROP VIEW [dbo].[vw_posSessionWiseOpClosing]
GO
/****** Object:  View [dbo].[vw_posSessionWiseOpClosing]    Script Date: 10/14/2021 4:22:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_posSessionWiseOpClosing]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [dbo].[vw_posSessionWiseOpClosing]
AS
SELECT        SessionStartTime, SessionClosingTime, CounterID, SessionID, SourceName, DebitAmount, CreditAmount
FROM            (SELECT        dbo.POSdata_SessionHandling.SessionStartTime, dbo.POSdata_SessionHandling.SessionClosingTime, dbo.data_CashIn.CounterID, dbo.POSdata_SessionHandling.SessionID, dbo.data_CashIn.SourceName, 
                                                    SUM(dbo.data_CashIn.Amount) AS DebitAmount, 0 AS CreditAmount
                          FROM            dbo.POSdata_SessionHandling INNER JOIN
                                                    dbo.data_CashIn ON dbo.data_CashIn.ShiftID = dbo.POSdata_SessionHandling.SessionID
                          WHERE        (dbo.POSdata_SessionHandling.SessionClosingTime IS NOT NULL) AND (dbo.data_CashIn.SourceName <> ''POS'')
                          GROUP BY dbo.data_CashIn.SourceName, dbo.POSdata_SessionHandling.SessionID, dbo.data_CashIn.CounterID, dbo.POSdata_SessionHandling.SessionStartTime, dbo.POSdata_SessionHandling.SessionClosingTime
                          UNION ALL
                          SELECT        POSdata_SessionHandling_1.SessionStartTime, POSdata_SessionHandling_1.SessionClosingTime, dbo.data_CashOut.CounterID, POSdata_SessionHandling_1.SessionID, dbo.data_CashOut.SourceName, 
                                                   0 AS DebitAmount, SUM(dbo.data_CashOut.Amount) AS CreditAmount
                          FROM            dbo.POSdata_SessionHandling AS POSdata_SessionHandling_1 INNER JOIN
                                                   dbo.data_CashOut ON dbo.data_CashOut.ShiftID = POSdata_SessionHandling_1.SessionID
                          WHERE        (POSdata_SessionHandling_1.SessionClosingTime IS NOT NULL) AND (dbo.data_CashOut.SourceName <> ''POS RETURN'')
                          GROUP BY dbo.data_CashOut.SourceName, POSdata_SessionHandling_1.SessionID, dbo.data_CashOut.CounterID, POSdata_SessionHandling_1.SessionStartTime, POSdata_SessionHandling_1.SessionClosingTime) AS T

' 
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'vw_posSessionWiseOpClosing', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "T"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 232
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_posSessionWiseOpClosing'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'vw_posSessionWiseOpClosing', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_posSessionWiseOpClosing'
GO
