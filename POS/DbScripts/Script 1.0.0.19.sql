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
ALTER TABLE dbo.data_StockArrivalDetail ADD
	ItemCode int NULL
GO
ALTER TABLE dbo.data_StockArrivalDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


/****** Object:  StoredProcedure [dbo].[POSdata_StockArrivalInfo_Insert]    Script Date: 5/4/2021 11:51:15 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockArrivalInfo_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_StockArrivalInfo_Insert]
GO
/****** Object:  UserDefinedTableType [dbo].[data_StockArrivalDetail]    Script Date: 5/4/2021 11:51:15 AM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_StockArrivalDetail' AND ss.name = N'dbo')
DROP TYPE [dbo].[data_StockArrivalDetail]
GO
/****** Object:  UserDefinedTableType [dbo].[data_StockArrivalDetail]    Script Date: 5/4/2021 11:51:15 AM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_StockArrivalDetail' AND ss.name = N'dbo')
CREATE TYPE [dbo].[data_StockArrivalDetail] AS TABLE(
	ItemCode int NULL
	,[TrasnferDate] [datetime] NULL,
	[Remarks] [nvarchar](max) NULL,
	[ItemID] [int] NOT NULL,
	[Itenname] [nvarchar](500) NULL,
	[UOMName] [nvarchar](250) NULL,
	[TotalPOQuantity] [numeric](18, 3) NULL,
	[UsedQuantity] [numeric](18, 3) NULL,
	[TransferToWHID] [int] NULL,
	[StockTransferDetailID] [int] NULL,
	[Remaining] [numeric](18, 3) NULL,
	[Received] [numeric](18, 3) NULL
)
GO
/****** Object:  StoredProcedure [dbo].[POSdata_StockArrivalInfo_Insert]    Script Date: 5/4/2021 11:51:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockArrivalInfo_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_StockArrivalInfo_Insert] AS' 
END
GO



ALTER procedure [dbo].[POSdata_StockArrivalInfo_Insert] 
@ArrivalID int  output, 
@RefID int = null, 
@UserID int=null,
@CompanyID int = null, 
@FiscalID int = null,
@ArrivalDate date = null,
@ArrivalNo int=null, 
@IsTaxable bit=0,
@VehicleNo nvarchar(250)=null,
@ManualNo nvarchar(250)=null,

@data_StockArrivalDetail  data_StockArrivalDetail readonly 
as

declare @EditMode bit  = 0, @StockCheckDate date,@TransferToWHID int=null, @ToBranchID int=null
select @TransferToWHID=TransferToWHID,@ToBranchID=ToBranchID from data_RawStockTransfer where TransferIDRef=@RefID

if	 @ArrivalID = 0
BEGIN
	declare @MaxTable as MaxTable

	insert into @MaxTable	
	exec GetVoucherNoI @Fieldname=N'ArrivalNo',@TableName=N'data_StockArrivalInfo',@CheckTaxable= 1 ,@PrimaryKeyValue = @ArrivalID,@PrimaryKeyFieldName = '@ArrivalID' ,
	@voucherDate=@ArrivalDate,@voucherDateFieldName=N'ArrivalDate',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=@FiscalID, 
	@FiscalIDFieldName=N'FiscalID',@IsTaxable=0
	
	select @ArrivalNo = VoucherNo from @MaxTable


	set @StockCheckDate = @ArrivalDate

	Insert into data_StockArrivalInfo ( 
		EntryUserID , 
		EntryUserDateTime , 
		CompanyID , 
		FiscalID ,
		ArrivalDate , 
		ArrivalNo , 
	
	RefID,
		
		IsTaxable 
		,ArrivalToWHID,
		ToBranchID,
		ManualNo,
		VehicleNo
	

	 ) Values (
		@UserID , 
		GETDATE() ,
		@CompanyID , 
		@FiscalID ,
		@ArrivalDate , 
		@ArrivalNo,
		@RefID,
		@IsTaxable,
		@TransferToWHID,
		@ToBranchID,
		@ManualNo,
		@VehicleNo
	
	)	
	set @ArrivalID = @@IDENTITY
	
END

ELSE

BEGIN	


declare @SaveVoucherdate date , @IsVoucherNoMonthly bit
select @IsVoucherNoMonthly = IsVoucherNoMonthly from gen_SystemConfiguration where CompanyID =  @CompanyID

if @IsVoucherNoMonthly = 1
BEGIN
	select @SaveVoucherdate = ArrivalDate from data_StockArrivalInfo where ArrivalID = @ArrivalID

	if MONTH(@ArrivalDate) <> MONTH(@SaveVoucherdate) or  YEAR(@ArrivalDate) <> YEAR(@SaveVoucherdate)
	BEGIN
		insert into @MaxTable
			exec GetVoucherNoI @Fieldname=N'ArrivalNo',@TableName=N'data_StockArrivalInfo',@CheckTaxable= 1 ,@PrimaryKeyValue = @ArrivalID,@PrimaryKeyFieldName = '@ArrivalID' ,
			@voucherDate=@ArrivalDate,@voucherDateFieldName=N'ArrivalDate',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=@FiscalID, 
				@FiscalIDFieldName=N'FiscalID',@IsTaxable=0
	
		select @ArrivalNo = VoucherNo from @MaxTable

	END
END

	select @StockCheckDate = TransferDate from data_arrivalDate where arrivalID = @ArrivalID

	if @StockCheckDate > @ArrivalDate
	BEGIN
		set @StockCheckDate = @ArrivalDate
	END


	update data_StockArrivalInfo set	
	ModifyUserID = @UserID , 
	ModifyUserDateTime = GETDATE() , 
	CompanyID = @CompanyID , 
	FiscalID = @FiscalID ,
	ArrivalDate = @ArrivalDate , 
	ArrivalNo = @ArrivalNo  ,
	ArrivalToWHID=@TransferToWHID,ToBranchID=@ToBranchID,
	ManualNo=@ManualNo,
	VehicleNo=@VehicleNo
	where ArrivalID = @ArrivalID


	declare @ProductInflowSourceIDTable as data_ProductInflow	, @ItemsWarehouseBatchWise as ItemsWarehouseBatchWise
	insert into @ProductInflowSourceIDTable (SourceID) select ArrivalIDDetailID from data_StockArrivalDetail where ArrivalID = @ArrivalID



	update data_ProductInflow set IsDeleted = 1 where SourceName = 'POSSTOCK IN' and SourceID in (select SourceID from @ProductInflowSourceIDTable )
	
	
	delete from data_StockArrivalDetail where ArrivalID = @arrivalID
	set	@EditMode = 1
END
	

declare @RowID int,@ArrivalIDDetailID int ,@StockRate numeric(14,5) , @Quantity numeric(10,2),@ItemId int,@stockQty numeric(14,2),
@ItemName varchar(200),@ERRORMSG varchar(200)

 
--declare @jj as xml = (select * from @data_StockTransferDetail for xml auto)

declare firstcursor cursor for
select StockTransferDetailID from @data_StockArrivalDetail
open firstcursor
fetch next from firstcursor into @RowID
while @@FETCH_STATUS = 0
	begin
		declare @checkRate bit = 1
		select @ItemId = ItemId, @Quantity = Received  From @data_StockArrivalDetail  where StockTransferDetailID = @RowID
	Select @StockRate =StockRate from data_StockTransferRawDetail where StockTransferDetailID=@RowID

		Insert Into data_StockArrivalDetail (
		ArrivalID ,
		ItemId ,
		Quantity ,
		StockRate ,CartonQuantity,LooseQuantity,TransferDetailID
		) Select
		@ArrivalID ,
		ItemId ,
		Received ,
		@StockRate ,0,Received,StockTransferDetailID
		From @data_StockArrivalDetail where StockTransferDetailID = @RowID

		set @ArrivalIDDetailID = @@IDENTITY	
			
		
		declare @productInflowID int,@ProductOutflowID int

		
	
	

		exec data_ProductInflow_Insert @productInflowID output,@ItemId,@ArrivalIDDetailID,'POSSTOCK IN',@TransferToWHID, 
		@ArrivalDate ,@StockRate,@Quantity,@Quantity ,@FiscalID , @CompanyID , @IsTaxable,null,null,null,null,null,@ToBranchID,null

		select  @productInflowID as ProductInflowID,'POSSTOCK IN' as SourceName into #tempIn
		

	drop table #tempIn;

	FETCH NEXT FROM firstcursor INTO @RowID
	END

close firstcursor
deallocate firstcursor


--check Stock Available Or not of Inserted Item
if @EditMode = 1
BEGIN	
	set @ErrorMsg = ''
	exec CheckDeletedStock 'POSSTOCK IN', @ItemsWarehouseBatchWise , @ProductInflowSourceIDTable , @StockCheckDate , @ErrorMsg output, 
	@CompanyID , @IsTaxable
	if @ErrorMsg <> ''
	BEGIN
		RAISERROR (@ErrorMsg ,16 , 1);
		return
	END
	
	delete from data_ProductInflow where SourceName =  'POSSTOCK IN'  AND SourceID in (select SourceID from  @ProductInflowSourceIDTable ) and IsDeleted = 1
END





GO
