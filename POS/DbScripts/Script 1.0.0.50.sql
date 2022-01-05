
/****** Object:  StoredProcedure [dbo].[GetVoucherNoS]    Script Date: 9/2/2021 11:56:15 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create procedure [dbo].[POSGetVoucherNoSContinuos] 
@Fieldname varchar(100),
@TableName varchar(100),
@CheckTaxable bit,
@PrimaryKeyValue int,
@PrimaryKeyFieldName varchar(500),
@voucherDate date = null ,
@voucherDateFieldName varchar(30) = null,
@companyID int = 0 ,
@companyFieldName varchar(30) = 'CompanyID',
@FiscalID int = 0 ,
@FiscalIDFieldName varchar(30) = 'FiscalID',
@BranchID int = 0 ,
@BranchIDFieldName varchar(30) = 'BranchID',
@IsTaxable bit = 0 ,
@WhereClause varchar(2000) = ''

as

declare @sql nvarchar(4000),@WC nvarchar(4000)='' ,@vNo int

	if @PrimaryKeyValue > 0 
	BEGIN
		set @WC += ' and ' + @PrimaryKeyFieldName + ' <> ' + CONVERT(varchar(6), @PrimaryKeyValue)
	END

	if @companyID > 0 
	BEGIN
		set @WC += ' and ' + @companyFieldName + ' = ' + CONVERT(varchar(6), @companyID)
	END

	if @FiscalID > 0 
	BEGIN
		set @WC += ' and ' + @FiscalIDFieldName + ' = ' + CONVERT(varchar(6), @FiscalID)
	END
	if @BranchID > 0 
	BEGIN
		set @WC += ' and ' + @BranchIDFieldName + ' = ' + CONVERT(varchar(6), @BranchID)
	END
	set @WC += @WhereClause


	
	

	if @CheckTaxable = 1 
	BEGIN
		set @WC += ' and IsTaxable = ' + CONVERT(varchar, @IsTaxable)
	END


set @sql = 'select @vNo = min([from]) from (select (select isnull(max(CONVERT(numeric,'+ @Fieldname + '))+1,1) from '+ @TableName +' where '+ @Fieldname + ' < a.'+ @Fieldname + @WC + ') as [from],
     a.'+ @Fieldname + ' - 1 as [to]
  from '+ @TableName +' a where a.'+ @Fieldname + ' != 1'
	set @sql +=	@WC

	set @sql += ' and not exists (
        select 1 from '+ @TableName +' b where b.'+ @Fieldname + ' = a.'+ @Fieldname + ' - 1'
	
	set @sql +=	@WC

set @sql += '))a'

  --print(@sql)

  exec sp_executesql @sql ,N'@vNo int output', @vNo output

	if @vNo is null
	BEGIN
		set @sql = 'select @vNo = ISNULL(max(CONVERT(numeric,'+ @Fieldname + ')),0) +1  from '+ @TableName +' where 0 = 0 '
		set @sql +=	@WC

		exec sp_executesql @sql ,N'@vNo int output', @vNo output
	END

  select @vNo  as MaxNo

  
  
Go



/****** Object:  StoredProcedure [dbo].[POSdata_StockArrivalManualInfo_Insert]    Script Date: 9/2/2021 12:00:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[POSdata_StockArrivalManualInfo_InsertContinuosSeriel] 
@ArrivalID int  output, 
@RefID int = null, 
@UserID int=null,
@CompanyID int = null, 
@FiscalID int = null,
@ArrivalDate date = null,
@ArrivalNo int=null, 
@IsTaxable bit=0,
@TransferToWHID int=0,
@ToBranchID int=null,
@VehicleNo nvarchar(250)=null,
@ManualNo nvarchar(250)=null,
@Remarks nvarchar(Max)=null,

@data_StockArrivalManual  data_StockArrivalManual readonly 
as

declare @EditMode bit  = 0, @StockCheckDate date 
if	 @ArrivalID = 0
BEGIN
	declare @MaxTable as MaxTable

	insert into @MaxTable	
	exec POSGetVoucherNoSContinuos @Fieldname=N'ArrivalNo',@TableName=N'data_StockArrivalInfo',@CheckTaxable= 1 ,@PrimaryKeyValue = @ArrivalID,@PrimaryKeyFieldName = '@ArrivalID' ,
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
		isManual,
		ManualNo,
		VehicleNo,
		Remarks
	

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
		1,
		@ManualNo,
		@VehicleNo,
		@Remarks
	
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
			exec POSGetVoucherNoSContinuos @Fieldname=N'ArrivalNo',@TableName=N'data_StockArrivalInfo',@CheckTaxable= 1 ,@PrimaryKeyValue = @ArrivalID,@PrimaryKeyFieldName = '@ArrivalID' ,
			@voucherDate=@ArrivalDate,@voucherDateFieldName=N'ArrivalDate',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=@FiscalID, 
				@FiscalIDFieldName=N'FiscalID',@IsTaxable=0
	
		select @ArrivalNo = VoucherNo from @MaxTable

	END
END

	select @StockCheckDate = ArrivalDate from data_StockArrivalInfo where arrivalID = @ArrivalID

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
	isManual=1,
	ManualNo=@ManualNo,
	VehicleNo=@VehicleNo,
	Remarks=@Remarks
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
select RowID from @data_StockArrivalManual
open firstcursor
fetch next from firstcursor into @RowID
while @@FETCH_STATUS = 0
	begin
		declare @checkRate bit = 1
	
		Insert Into data_StockArrivalDetail (
		ArrivalID ,
		ItemId ,
		Quantity ,
		StockRate ,CartonQuantity,LooseQuantity,TransferDetailID
		) Select
		@ArrivalID ,
		ItemId ,
		Quantity ,
		StockRate ,0,		Quantity ,0
		From @data_StockArrivalManual where RowID = @RowID

		set @ArrivalIDDetailID = @@IDENTITY	
			
		
		declare @productInflowID int,@ProductOutflowID int

		Select @StockRate=Stockrate,@Quantity=Quantity,@ItemId=ItemID,@ItemName=Productname From @data_StockArrivalManual where RowID = @RowID
	
	

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


