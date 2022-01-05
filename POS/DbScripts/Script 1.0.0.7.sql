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
ALTER TABLE dbo.data_SalePosDetail ADD
	isExchange bit NULL
GO
ALTER TABLE dbo.data_SalePosDetail SET (LOCK_ESCALATION = TABLE)
GO
COMMIT



/****** Object:  StoredProcedure [dbo].[data_SalePosReturnInfo_Insert]    Script Date: 4/29/2021 1:59:48 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosReturnInfo_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePosReturnInfo_Insert]
GO
/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_SelectAll]    Script Date: 4/29/2021 1:59:48 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_SelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePosInfo_SelectAll]
GO
/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Insert]    Script Date: 4/29/2021 1:59:48 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePosInfo_Insert]
GO
/****** Object:  UserDefinedTableType [dbo].[data_SalePosDetail]    Script Date: 4/29/2021 1:59:48 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_SalePosDetail' AND ss.name = N'dbo')
DROP TYPE [dbo].[data_SalePosDetail]
GO
/****** Object:  UserDefinedTableType [dbo].[data_SalePosDetail]    Script Date: 4/29/2021 1:59:48 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_SalePosDetail' AND ss.name = N'dbo')
CREATE TYPE [dbo].[data_SalePosDetail] AS TABLE(
	[RowID] [int] NULL,
	[ItemId] [int] NULL,
	[Quantity] [numeric](18, 3) NULL,
	[ItemRate] [numeric](18, 3) NULL,
	[TaxPercentage] [numeric](18, 3) NULL,
	[TaxAmount] [numeric](18, 3) NULL,
	[DiscountPercentage] [numeric](18, 3) NULL,
	[DiscountAmount] [numeric](18, 3) NULL,
	[TotalAmount] [numeric](18, 3) NULL,
	[CartonSize] [decimal](18, 3) NULL,
	[Carton] [decimal](18, 3) NULL,
	[TotalQuantity] [decimal](18, 3) NULL,
	[SalePosDetailID] [int] NULL,
	[SchemeID] [int] NULL,
	[MinQuantity] [numeric](18, 3) NULL,
	isExchange bit Null
)
GO
/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Insert]    Script Date: 4/29/2021 1:59:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_SalePosInfo_Insert] AS' 
END
GO









ALTER procedure [dbo].[data_SalePosInfo_Insert] 
@UserID int = null , 
@CompanyID int = null , 
@FiscalID int = null ,
@SalePosDate	date	=null,
@WHID	int	=null,
@TaxAmount			decimal(18, 2)	=null,
@GrossAmount		decimal(18, 2)	=null,
@DiscountPercentage	decimal(18, 2)	=null,
@DiscountAmount		decimal(18, 2)	=null,
@DiscountTotal		decimal(18, 2)	=null,
@OtherCharges		decimal(18, 2)	=null,
@NetAmount			decimal(18, 2)	=null,
@AmountReceive		decimal(18, 2)	=null,
@AmountReturn		decimal(18, 2)	=null,
@AmountInAccount	decimal(18, 2)	=null,
@AmountReceivable	decimal(18, 2)	=null,
@AmountPayable		decimal(18, 2)	=null,
@DirectReturn	biT=0,
@data_SalePosDetail  data_SalePosDetail   readonly,
@SalePosID bigint output,
@CustomerPhone nvarchar(50)=null,
@CustomerName  nvarchar(50)=null,
@SaleInvoiceNo int=0
as
declare @returnSale bit=0
declare @IsTaxable bit =0
--set @SalePosDate=GETDATE()

declare @MaxTable as MaxTable 
declare @MaxTable2 as MaxTable
if	 @DirectReturn = 0
BEGIN
	insert into @MaxTable
	--exec GetmaxNo 'SaleVoucherNo','data_SaleInfo', @CompanyID
	exec GetVoucherNoPos @Fieldname=N'SalePOSNo',@TableName=N'data_SalePosInfo',@CheckTaxable= 0 ,@PrimaryKeyValue = @SalePosID,@PrimaryKeyFieldName = 'SalePosID' ,
	@voucherDate=@SalePOSDate,@voucherDateFieldName=N'SalePOSDate',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=@FiscalID, 
	@FiscalIDFieldName=N'FiscalID',@IsTaxable=@IsTaxable
	select @SaleInvoiceNo = VoucherNo from @MaxTable

	Insert into data_SalePosInfo ( 
		EntryUserID,
		EntryUserDateTime,
		CompanyID,
		FiscalID,
		SalePosDate,
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
		SalePOSNo
	)
	Values (
		@UserID , 
		GETDATE() ,
		@CompanyID,
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
		@SaleInvoiceNo
		
	)	
	set @SalePosID = @@IDENTITY

	EXEC [dbo].[data_Cash_Insert]
		@SourceID = @SalePosID,
		@SourceName = N'POS',
		@Amount = @AmountReceivable,
		@CashType = 1,
		@SalePosDate=@SalePosDate


---========== Sale End Here ================
---========================== Sale Stock In Working Start Here =============================
		


declare @RowID int,@SaleDetailID int ,@StockRate numeric(14,5) , @Quantity numeric(10,2),@ItemId int,@stockQty numeric(14,2),@ItemName varchar(200),@ERRORMSG varchar(200),
		@MainTainInventory bit = 1,@DealCateGoryID int=0,@ItemCategoryID int=0,@BomId int,@ProductIntflowID int=0,
        @data_ManufacturingDetail  data_ManufacturingDetail  ,
        @data_ItemBatchDetail  data_ItemBatchDetail  ,
        @data_ItemBatchDetailFinish  data_ItemBatchDetail ,@ManufacturingID int=0,@isExchange bit=0
		Select @DealCateGoryID=POSDealsCategory from gen_SystemConfiguration where CompanyID=@CompanyID
		
declare Salecursor cursor for
select RowID from @data_SalePosDetail
open Salecursor
fetch next from Salecursor into @RowID
while @@FETCH_STATUS = 0
	begin

	select @ItemId = ItemId,@Quantity=Quantity,@StockRate=ItemRate ,@isExchange=isExchange
    
	From @data_SalePosDetail		 where RowID = @RowID
		
		Select @ItemCategoryID=CategoryID,@MainTainInventory = MaintainInventory from InventItems where ItemId=@ItemId

		Select @BomId=BOMID from gen_BOMInfo where ItemId=@ItemId
		if(@BomId>0 and @ItemCategoryID=@DealCateGoryID)
		begin
		insert into @data_ManufacturingDetail (RowID,ItemId,BOMQuantity,ActualQuantity,WHID,StockRate,BOMFormulaQuantity) 
Select ROW_NUMBER() Over(  order by ItemID)-1 as ROwId,ItemId,Quantity,Quantity*@Quantity,@WHID,0 ,1 from gen_BOMDetail where BOMID=@BomId
exec data_ManufacturingInfo_Insert @ManufacturingID=@ManufacturingID output,@UserID=@UserID,@CompanyID=@CompanyID,@FiscalID=@FiscalID,@BomId=@BomId,@ItemId=@ItemId,@ManufacturingDate=@SalePosDate,@Quantity=@Quantity,@WHID=@WHID,@ManufacturingStyle='STYLE 1',@IsTaxable=@IsTaxable,@data_ManufacturingDetail=@data_ManufacturingDetail,@data_ItemBatchDetail=@data_ItemBatchDetail,@data_ItemBatchDetailFinish=@data_ItemBatchDetailFinish,@LooseQuantity=@Quantity		end
		--if	 @returnSale = 0
		--BEGIN
			exec GetStockQuantity @ItemId ,@WHID , @SalePosDate , @stockQty output , @ItemName out , @CompanyID , '' , '' , 
			null , null , null , 1 , @IsTaxable
			if (( @stockQty < @Quantity ) and @MainTainInventory=1)
			BEGIN
					set @ERRORMSG = 'Stock is not enough of Item ' + @ItemName + ' Avaliable Stock '+  convert(varchar, @stockQty)	 + ' Required Quantity is ' + convert(varchar, @Quantity)	
					RAISERROR (@ERRORMSG , 16, 1 ) ;
					return
			END
		--END
	
		Insert Into data_SalePosDetail (
		SalePosID,
		ItemId,
		Quantity,
		ItemRate,
		TaxPercentage,
		TaxAmount,
		DiscountPercentage,
		DiscountAmount,
		TotalAmount,
		ManaufacturingID,
		CartonSize,
		Carton,
		TotalQuantity,
		SchemeID,
		MinQuantity,
		isExchange
		) Select
		@SalePosID ,
		ItemId,
		Quantity,
		ItemRate,
		TaxPercentage,
		TaxAmount,
		DiscountPercentage,
		DiscountAmount,
		TotalAmount,@ManufacturingID,
		CartonSize,
		Carton,
		TotalQuantity,
		SchemeID,
		MinQuantity,
		isExchange

		From @data_SalePosDetail where RowID = @RowID
		
		set @SaleDetailID = @@IDENTITY		

		declare @ProductOutflowID int
			if @MainTainInventory = 1 
			BEGIN		
				BEGIN
					exec GetWeightedRateForItem @ItemId, @WHID ,@SalePosDate ,@SalePosDate ,@StockRate output , @CompanyID , @IsTaxable
				END
				update data_SaleDetail set StockRate = @StockRate where SaleDetailID = @SaleDetailID
				if @isExchange=1
				begin
				
				exec data_ProductInflow_Insert @ProductIntflowID output,null,@ItemId,@SaleDetailID,'POSEXCHANGE',@WHID, @SalePosDate ,@StockRate,@Quantity, 
				@FiscalID , @CompanyID , @IsTaxable
				end
				else
				begin
				exec data_ProductOutflow_Insert @ProductOutflowID output,null,@ItemId,@SaleDetailID,'POS',@WHID, @SalePosDate ,@StockRate,@Quantity, 
				@FiscalID , @CompanyID , @IsTaxable
				end
				exec tempOutflowDataTable_Insert @ProductOutflowID ,'POS'
			END
	
	FETCH NEXT FROM Salecursor INTO @RowID
	END

close Salecursor
deallocate Salecursor


---========================== Sale Stock In Working End Here =============================


END
else
BEGIN
---========== Sale Return Start Here ================
declare @SalePosReturnID bigint=0
declare @SalePosReturnDetailID bigint=0
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
		AmountPayable
	)
	values
	(
		@SalePosID,
		@UserID , 
		GETDATE() ,
		@CompanyID,
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
		@AmountPayable
		)
	set @SalePosReturnID = SCOPE_IDENTITY()

	--Checking Total Cash Remaining 
DECLARE @Amount decimal(18,2)=0 
select @Amount=(select isnull(sum(Amount),0) as Amount from data_CashIn where Date=cast(GETDATE() as date))
-
(select isnull(sum(Amount),0) as Amount from data_CashOut where Date=cast(GETDATE() as date)) 
--select  @Amount
declare @ErrorMessage nvarchar(1000)
if	@Amount>@AmountPayable
begin
	EXEC [dbo].[data_Cash_Insert]
	@SourceID = @SalePosReturnID,
	@SourceName = N'POS Return',
	@Amount = @AmountPayable,
	@CashType = 0
end
else
begin
set @ErrorMessage = 'Not have enough cash!'
	RAISERROR (@ErrorMessage , 16, 1 ) ;
	return
end
---========== Sale Return End Here ================
---========================== Sale Stock Return Working Start Here =============================
		 declare @productInflowID int
DECLARE @PractitionerId int
declare @PosSaleReturnDetailID int ,@PosStockRate numeric(14,5) , @PosQuantity numeric(10,2),@PosItemId int,@PosstockQty numeric(14,2)
	
DECLARE MY_CURSOR CURSOR 
  LOCAL STATIC READ_ONLY FORWARD_ONLY
FOR 
select RowID from @data_SalePosDetail

OPEN MY_CURSOR
FETCH NEXT FROM MY_CURSOR INTO @PractitionerId
WHILE @@FETCH_STATUS = 0
BEGIN 
    --Do something with Id here
    --PRINT @PractitionerId
	select @PosItemId = ItemId,@PosQuantity=Quantity,@PosStockRate=ItemRate 
    --@MainTainInventory = MaintainInventory,
	From @data_SalePosDetail	 where RowID = @PractitionerId



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
		SchemeID,
		MinQuantity
		) Select
		@SalePosReturnID ,
		0,
		ItemId,
		Quantity,
		ItemRate,
		TaxPercentage,
		TaxAmount,
		DiscountPercentage,
		DiscountAmount,
		TotalAmount,
		SchemeID,
		MinQuantity
		From @data_SalePosDetail 
		where RowID = @PractitionerId

	set @PosSaleReturnDetailID = SCOPE_IDENTITY()

	--watch this
	exec data_ProductInflow_Insert @productInflowID out,@PosItemId,@PosSaleReturnDetailID,'POS RETURN',@WHID, @SalePosDate , 
				@PosStockRate,@PosQuantity,@PosQuantity,@FiscalID , @CompanyID ,@IsTaxable
				exec tempInflowDataTable_Insert @productInflowID ,'POS RETURN'
	--watht this end
update data_SalePosReturnDetail set IsLog=1 where SalePosReturnDetailID=@PosSaleReturnDetailID

    FETCH NEXT FROM MY_CURSOR INTO @PractitionerId
END
CLOSE MY_CURSOR
DEALLOCATE MY_CURSOR

---========================== Sale Stock Return Working End Here =============================



END



















GO
/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_SelectAll]    Script Date: 4/29/2021 1:59:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_SelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_SalePosInfo_SelectAll] AS' 
END
GO


ALTER procedure [dbo].[data_SalePosInfo_SelectAll] 
@SelectMaster bit=1,
@SelectDetail bit=1,
@InvoiceNo bigint,
@SaleDate date=null

as

declare @ReturnSaleID bigint
select @ReturnSaleID=SalePosID from data_SalePosInfo where SalePosNo=@InvoiceNo and SalePosDate=@SaleDate
if((Select count(*) from data_SalePosReturnInfo where SalePosID=@ReturnSaleID)>0)
begin
			RAISERROR ('Already Sale Return has been Added..' , 16, 1 ) ;
			return
end
declare @WhereClause nvarchar(4000),@WhereClauseDetail nvarchar(4000)
set @WhereClause=' '
set @WhereClauseDetail=' '
if(@ReturnSaleID is null)
	begin 
		set @ReturnSaleID=0
	end
if @ReturnSaleID!=0 
	begin
		set @WhereClause=' where SalePOSNo='+cast(@InvoiceNo as nvarchar(10))
		set @WhereClause=Cast(@WhereClause as nvarchar(4000)) +' and SalePOSDate='''+cast(@SaleDate as nvarchar(50))+''''
		print @whereClause
		exec('select * from data_SalePosInfo '+ @WhereClause)
		exec('select InventItems.ItenName,data_SalePosDetail.* from data_SalePosDetail inner join InventItems on data_SalePosDetail.ItemId=InventItems.ItemId inner join data_SalePosInfo on data_salePosInfo.SalePosID=data_salePosDetail.SalePosID '+ @WhereClause)
	end
	else
	begin
		set @WhereClause=' where LogSourceID=0 and SalePosReturnID='+cast(@ReturnSaleID as nvarchar(10))
		set @WhereClauseDetail=' where IsLog=0 and SalePosReturnID='+cast(@ReturnSaleID as nvarchar(10))
		exec('select * from data_SalePosReturnInfo '+ @WhereClause)
		exec('select InventItems.ItenName,data_SalePosReturnDetail.* from data_SalePosReturnDetail inner join InventItems on data_SalePosReturnDetail.ItemId=InventItems.ItemId '+ @WhereClauseDetail)
	end
	









GO
/****** Object:  StoredProcedure [dbo].[data_SalePosReturnInfo_Insert]    Script Date: 4/29/2021 1:59:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosReturnInfo_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_SalePosReturnInfo_Insert] AS' 
END
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
@SaleInvoiceNo int=0
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
exec GetVoucherNoPos @Fieldname=N'SalePOSNo',@TableName=N'data_SalePosReturnInfo',@CheckTaxable= 0 ,@PrimaryKeyValue = @SalePosReturnID,@PrimaryKeyFieldName = 'SalePosReturnID' ,
	@voucherDate=@SalePOSDate,@voucherDateFieldName=N'SalePosReturnDate',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=@FiscalID, 
	@FiscalIDFieldName=N'FiscalID',@IsTaxable=@IsTaxable
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
		SalePOSNo
	)
	Select 
	SalePosID, 
	EntryUserID,
	EntryUserDateTime,
	CompanyID,
	FiscalID,
	SalePosDate,
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
	@SaleInvoiceNo

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
DECLARE @PractitionerId int
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
if(@ManufacturingID>0)
begin
exec data_ManufacturingInfo_delete @ManufacturingID=@ManufacturingID
end
    FETCH NEXT FROM MY_CURSOR INTO @PractitionerId
END
CLOSE MY_CURSOR
DEALLOCATE MY_CURSOR






		--update data_SalePosInfo set
		--ModifyUserID=@UserID , 
		--ModifyUserDateTime=GETDATE() ,
		--CompanyID=@CompanyID,
		--FiscalID=@FiscalID,
		--SalePosDate=@SalePosDate,
		--WHID=@WHID,
		--TaxAmount=@TaxAmount,
		--GrossAmount=@GrossAmount,
		--DiscountPercentage=@DiscountPercentage,
		--DiscountAmount=@DiscountAmount,
		--DiscountTotal=@DiscountTotal,
		--OtherCharges=@OtherCharges,
		--NetAmount=@NetAmount,
		--AmountReceive=@AmountReceive,
		--AmountReturn=@AmountReturn,
		--AmountInAccount=@AmountInAccount,
		--AmountReceivable=@AmountReceivable,
		--AmountPayable=@AmountPayable
		--where SalePosID=@SalePosID
		
		--delete from data_ProductOutflow where SourceName = 'POS' and SourceID in (select SalePosDetailID from data_SalePosDetail where SalePosID =@SaleID) 
		--delete data_SalePosDetail where SalePosID=@SalePosID
		DECLARE @Amount decimal(18,2)=0 
		Select @AmountPayable=sum(TotalAmount) from @data_SalePosDetail
		select @Amount=(select isnull(sum(Amount),0) as Amount from data_CashIn where Date=cast(GETDATE() as date))
                                  -
         (select isnull(sum(Amount),0) as Amount from data_CashOut where Date=cast(GETDATE() as date)) 
		 --select @Amount
		declare @ErrorMessage nvarchar(1000)
		if @AmountReceivable=0
		begin
			if	@Amount>@AmountPayable
			begin
				EXEC [dbo].[data_Cash_Insert]
				@SourceID = @SalePosID,
				@SourceName = N'POS Return',
				@Amount = @AmountPayable,
				@CashType = 0,
				@SalePosDate=@SalePosDate
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
			@CashType = 1
		end
		







--declare @RowID int,@SaleDetailID int ,@StockRate numeric(14,5) , @Quantity numeric(10,2),@ItemId int,@stockQty numeric(14,2),@ItemName varchar(200),@ERRORMSG varchar(200),
--		@MainTainInventory bit = 1
 
--declare firstcursor cursor for
--select RowID from @data_SalePosDetail
--open firstcursor
--fetch next from firstcursor into @RowID
--while @@FETCH_STATUS = 0
--	begin

--	select @ItemId = ItemId,@Quantity=Quantity,@StockRate=ItemRate 
--    --@MainTainInventory = MaintainInventory,
--	From @data_SalePosDetail		 where RowID = @RowID
		
--		set @SalePosDate=GETDATE()
		
--		--if	 @returnSale = 0
--		--BEGIN
--			exec GetStockQuantity @ItemId ,@WHID , @SalePosDate , @stockQty output , @ItemName out , @CompanyID , '' , '' , 
--			null , null , null , 1 , @IsTaxable
--			if  @stockQty < @Quantity 
--			BEGIN
--					set @ERRORMSG = 'Stock is not enough of Item ' + @ItemName + ' Avaliable Stock '+  convert(varchar, @stockQty)	 + ' Required Quantity is ' + convert(varchar, @Quantity)	
--					RAISERROR (@ERRORMSG , 16, 1 ) ;
--					return
--			END
--		--END
	
--		Insert Into data_SalePosDetail (
--		SalePosID,
--		ItemId,
--		Quantity,
--		ItemRate,
--		TaxPercentage,
--		TaxAmount,
--		DiscountPercentage,
--		DiscountAmount,
--		TotalAmount
--		) Select
--		@SalePosID ,
--		ItemId,
--		Quantity,
--		ItemRate,
--		TaxPercentage,
--		TaxAmount,
--		DiscountPercentage,
--		DiscountAmount,
--		TotalAmount
--		From @data_SalePosDetail where RowID = @RowID
		
--		set @SalePosDetailID = SCOPE_IDENTITY()		

--		declare @ProductOutflowID int
		
--			if @MainTainInventory = 1 
--			BEGIN		
--				BEGIN
--					exec GetWeightedRateForItem @ItemId, @WHID ,@SalePosDate ,@SalePosDate ,@StockRate output , @CompanyID , @IsTaxable
--				END
--				--update data_SaleDetail set StockRate = @StockRate where SaleDetailID = @SalePosReturnID
--				exec data_ProductOutflow_Insert @ProductOutflowID output,null,@ItemId,@SalePosDetailID,'POS',@WHID, @SalePosDate ,@StockRate,@Quantity, 
--				@FiscalID , @CompanyID , @IsTaxable
--				exec tempOutflowDataTable_Insert @ProductOutflowID ,'POS'
--			END
		

--	FETCH NEXT FROM firstcursor INTO @RowID
--	END

--close firstcursor
--deallocate firstcursor


--set @SalePosID =@SalePosReturnID
select @SalePosID


GO
