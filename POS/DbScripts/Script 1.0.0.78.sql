
IF  EXISTS (SELECT 1 FROM dbo.sysobjects 
				WHERE id = OBJECT_ID(N'[FK_gen_SaleManInfo_gen_StationInfo]') AND type = 'F')
BEGIN
BEGIN TRANSACTION
   ALTER TABLE dbo.gen_SaleManInfo
   DROP CONSTRAINT FK_gen_SaleManInfo_gen_StationInfo
COMMIT
END
GO


/****** Object:  StoredProcedure [dbo].[POSdata_StockIssuancetoPosKitchenDetailInfo_Insert]    Script Date: 3/26/2022 2:09:29 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockIssuancetoPosKitchenDetailInfo_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_StockIssuancetoPosKitchenDetailInfo_Insert]
GO

/****** Object:  StoredProcedure [dbo].[POSdata_StockIssuancetoPosKitchenDetailInfo_Insert]    Script Date: 3/26/2022 2:09:29 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockIssuancetoPosKitchenDetailInfo_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_StockIssuancetoPosKitchenDetailInfo_Insert] AS' 
END
GO




ALTER procedure [dbo].[POSdata_StockIssuancetoPosKitchenDetailInfo_Insert] 
@IssuanceID int  output, 
@RefID int = null, 
@UserID int=null,
@CompanyID int = null, 
@FiscalID int = null,
@IssuanceDate date = null,
@IssuanceNo int=null, 
@IsTaxable bit=0,
@FromWHID int=0,
@LocationID int=null,
@VehicleNo nvarchar(250)=null,
@ManualNo nvarchar(250)=null,
@Remarks nvarchar(Max)=null,
@IssuanceType int=0,
@BranchID int=null,
@data_StockIssuancetoPosKitchenDetail  data_StockIssuancetoPosKitchenDetail readonly 
as

declare @EditMode bit  = 0, @StockCheckDate date 

if	 @IssuanceID = 0
BEGIN
	declare @MaxTable as MaxTable

	insert into @MaxTable	
	exec GetVoucherNoI @Fieldname=N'IssuanceNo',@TableName=N'data_StockIssuancetoPosKitchen',@CheckTaxable= 1 ,@PrimaryKeyValue = @IssuanceID,@PrimaryKeyFieldName = '@IssuanceID' ,
	@voucherDate=@IssuanceDate,@voucherDateFieldName=N'IssuanceDate',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=@FiscalID, 
	@FiscalIDFieldName=N'FiscalID',@IsTaxable=@IsTaxable
	
	select @IssuanceNo = VoucherNo from @MaxTable


	set @StockCheckDate = @IssuanceDate

	Insert into data_StockIssuancetoPosKitchen ( 
		EntryUserID , 
		EntryUserDateTime , 
		CompanyID , 
		FiscalID ,
		IssuanceDate , 
		IssuanceNo , 
		RefID,
		IsTaxable 
		,FromWHID,
		LocationID,
		isManual,
		Remarks,
		IssuanceType
	

	 ) Values (
		@UserID , 
		GETDATE() ,
		@CompanyID , 
		@FiscalID ,
		@IssuanceDate , 
		@IssuanceNo,
		@RefID,
		@IsTaxable,
		@FromWHID,
		@LocationID,
		1,
		@Remarks,
		@IssuanceType
	
	)	
	set @IssuanceID = @@IDENTITY
	
END

ELSE

BEGIN	


declare @SaveVoucherdate date , @IsVoucherNoMonthly bit
select @IsVoucherNoMonthly = IsVoucherNoMonthly from gen_SystemConfiguration where CompanyID =  @CompanyID

if @IsVoucherNoMonthly = 1
BEGIN
	select @SaveVoucherdate = IssuanceDate from data_StockIssuancetoPosKitchen where IssuanceID = @IssuanceID

	if MONTH(@IssuanceDate) <> MONTH(@SaveVoucherdate) or  YEAR(@IssuanceDate) <> YEAR(@SaveVoucherdate)
	BEGIN
		insert into @MaxTable
			exec GetVoucherNoI @Fieldname=N'IssuanceNo',@TableName=N'data_StockIssuancetoPosKitchen',@CheckTaxable= 1 ,@PrimaryKeyValue = @IssuanceID,@PrimaryKeyFieldName = '@IssuanceID' ,
			@voucherDate=@IssuanceDate,@voucherDateFieldName=N'IssuanceDate',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=@FiscalID, 
				@FiscalIDFieldName=N'FiscalID',@IsTaxable=0
	
		select @IssuanceNo = VoucherNo from @MaxTable

	END
END

	select @StockCheckDate = IssuanceDate from data_StockIssuancetoPosKitchen where IssuanceID = @IssuanceID

	if @StockCheckDate > @IssuanceDate
	BEGIN
		set @StockCheckDate = @IssuanceDate
	END


	update data_StockIssuancetoPosKitchen set	
	ModifyUserID = @UserID , 
	ModifyUserDateTime = GETDATE() , 
	CompanyID = @CompanyID , 
	FiscalID = @FiscalID ,
	IssuanceDate = @IssuanceDate , 
	IssuanceNo = @IssuanceNo  ,
	FromWHID=@FromWHID,
	LocationID=@LocationID,
	isManual=1,
	Remarks=@Remarks,
	IssuanceType=@IssuanceType
	where IssuanceID = @IssuanceID


	declare @ProductInflowSourceIDTable as data_ProductInflow	, @ItemsWarehouseBatchWise as ItemsWarehouseBatchWise
	insert into @ProductInflowSourceIDTable (SourceID) select IssuanceDetailID from data_StockIssuancetoPosKitchenDetail where IssuanceID = @IssuanceID



	update data_ProductInflow set IsDeleted = 1 where SourceName = 'KITCHENSTOCK IN' and SourceID in (select SourceID from @ProductInflowSourceIDTable )
	
	
	
		Delete from data_ProductOutflow where SourceName='POSSTOCKOUT' and SourceID in (select IssuanceDetailID from data_StockIssuancetoPosKitchenDetail where IssuanceID = @IssuanceID) 
	
	
	delete from data_StockIssuancetoPosKitchenDetail where IssuanceID = @IssuanceID
	set	@EditMode = 1
END
	

declare @RowID int,@IssuanceIDDetailID int ,@StockRate numeric(14,5) , @Quantity numeric(10,2),@ItemId int,@stockQty numeric(14,2),
@ItemName varchar(200),@ERRORMSG varchar(200),@MainTainInventory bit=0

 
--declare @jj as xml = (select * from @data_StockTransferDetail for xml auto)

declare firstcursor cursor for
select RowID from @data_StockIssuancetoPosKitchenDetail
open firstcursor
fetch next from firstcursor into @RowID
while @@FETCH_STATUS = 0
	begin
		declare @checkRate bit = 1
	
		Insert Into data_StockIssuancetoPosKitchenDetail (
		IssuanceID ,
		ItemId ,
		Quantity ,
		StockRate ,CartonQuantity,LooseQuantity,TransferDetailID
		) Select
		@IssuanceID ,
		ItemId ,
		Quantity ,
		StockRate ,0,		Quantity ,0
		From @data_StockIssuancetoPosKitchenDetail where RowID = @RowID

		set @IssuanceIDDetailID = @@IDENTITY	
			
		
		declare @productInflowID int,@ProductOutflowID int

		Select @StockRate=Stockrate,@Quantity=Quantity,@ItemId=ItemID From @data_StockIssuancetoPosKitchenDetail where RowID = @RowID
	Select @MainTainInventory=MaintainInventory from InventItems where ItemId=@ItemId
	if(@IssuanceType=0)
	begin

		exec data_ProductInflow_Insert @productInflowID output,@ItemId,@IssuanceIDDetailID,'KITCHENSTOCK IN',@FromWHID, 
		@IssuanceDate ,@StockRate,@Quantity,@Quantity ,@FiscalID , @CompanyID , @IsTaxable,@LocationID,null,null,null,null,@BranchID,null

		select  @productInflowID as ProductInflowID,'KITCHENSTOCK IN' as SourceName into #tempIn
		
		EXEC data_ProductOutflow_Insert @ProductOutflowID output,@productInflowID,@ItemId,@IssuanceIDDetailID,'POSSTOCKOUT',@FromWHID, 
		@IssuanceDate ,@StockRate,@Quantity,@FiscalID , @CompanyID , @IsTaxable,null,null,null,null,null,@BranchID,null
	drop table #tempIn;
	end
	if (@IssuanceType=2)
	begin
	exec GetStockQuantity @ItemId ,@FromWHID , @IssuanceDate , @stockQty output , @ItemName out , @CompanyID , '' , '' , 
			null , null , null , 1 , @IsTaxable
			if (( @stockQty < @Quantity ) and @MainTainInventory=1)
			BEGIN
					set @ERRORMSG = 'Stock is not enough of Item ' + @ItemName + ' Avaliable Stock '+  convert(varchar, @stockQty)	 + ' Required Quantity is ' + convert(varchar, @Quantity)	
					RAISERROR (@ERRORMSG , 16, 1 ) ;
					return
			END

		
		EXEC data_ProductOutflow_Insert @ProductOutflowID output,@productInflowID,@ItemId,@IssuanceIDDetailID,'POSSTOCKOUT',@FromWHID, 
		@IssuanceDate ,@StockRate,@Quantity,@FiscalID , @CompanyID , @IsTaxable,null,null,null,null,null,@BranchID,null
	end

	if (@IssuanceType=1)
	begin
	exec data_ProductInflow_Insert @productInflowID output,@ItemId,@IssuanceIDDetailID,'KITCHENSTOCK IN',@FromWHID, 
		@IssuanceDate ,@StockRate,@Quantity,@Quantity ,@FiscalID , @CompanyID , @IsTaxable,null,null,null,null,null,@BranchID,null

		
		EXEC data_ProductOutflow_Insert @ProductOutflowID output,@productInflowID,@ItemId,@IssuanceIDDetailID,'POSSTOCKOUT',@FromWHID, 
		@IssuanceDate ,@StockRate,@Quantity,@FiscalID , @CompanyID , @IsTaxable,@LocationID,null,null,null,null,@BranchID,null
	end

	

	FETCH NEXT FROM firstcursor INTO @RowID
	END

close firstcursor
deallocate firstcursor


--check Stock Available Or not of Inserted Item
if @EditMode = 1
BEGIN	
	set @ErrorMsg = ''
	exec CheckDeletedStock 'KITCHENSTOCK IN', @ItemsWarehouseBatchWise , @ProductInflowSourceIDTable , @StockCheckDate , @ErrorMsg output, 
	@CompanyID , @IsTaxable
	if @ErrorMsg <> ''
	BEGIN
		RAISERROR (@ErrorMsg ,16 , 1);
		return
	END
	
	delete from data_ProductInflow where SourceName =  'KITCHENSTOCK IN'  AND SourceID in (select SourceID from  @ProductInflowSourceIDTable ) and IsDeleted = 1
END





GO


