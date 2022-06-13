

IF NOT EXISTS (SELECT 1 FROM sys.columns 
				WHERE name = N'IMEINumber' 
				and object_id = object_id(N'dbo.data_SalePosDetail'))
BEGIN
BEGIN TRANSACTION
	ALTER TABLE dbo.data_SalePosDetail ADD
	IMEINumber nvarchar(1000) NULL
COMMIT
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.columns 
				WHERE name = N'IMEINumber' 
				and object_id = object_id(N'dbo.data_SalePosReturnDetail'))
BEGIN
BEGIN TRANSACTION
	ALTER TABLE dbo.data_SalePosReturnDetail ADD
	IMEINumber nvarchar(1000) NULL
COMMIT
END
GO

/****** Object:  StoredProcedure [dbo].[GetStockQuantityItemBatchWise]    Script Date: 6/7/2022 2:32:02 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetStockQuantityItemBatchWise]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetStockQuantityItemBatchWise]
GO

/****** Object:  StoredProcedure [dbo].[GetStockQuantityItemBatchWise]    Script Date: 6/7/2022 2:32:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetStockQuantityItemBatchWise]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetStockQuantityItemBatchWise] AS' 
END
GO


ALTER PROCEDURE [dbo].[GetStockQuantityItemBatchWise]
(
@ItemIDs nvarchar(max) ,
@WHID int=0 , 
@StockDate date , 
@CompanyID int ,
@SourceName varchar(70) ='', 
@EditWC varchar(500) ='' ,
@IsTaxable bit = 0 
)
AS
BEGIN

declare @SQL nvarchar(max) = ''

	 
set @SQL = 'select  ISNULL(sum(Quantity),0) as Quantity, Param1 , Param2 , Param3, 
Param1 + ISNULL('','' + Param2 , '''') IMEINumberVal,
Param1 + ISNULL('','' + Param2 , '''') IMEINumber, ItemId
from (select b.Quantity ,b.Param1,b.Param2,b.Param3,b.ItemId from data_ProductInflow a join data_ProductInflowBatch b 
on a.ProductInflowID = b.ProductInflowID  where IsDeleted = 0 and b.ItemId is not null'

if (@ItemIDs IS NOT NULL)
BEGIN
	set @SQL += ' and a.ItemId IN (SELECT splitdata FROM [dbo].[fnSplitString1]('''+@ItemIDs+''', '','') ) ';
END

if @WHID > 0 
BEGIN
	set @SQL += ' and WHID = '+ CONVERT (nvarchar, @WHID)
END

set @SQL += ' and CompanyID = ' + CONVERT (nvarchar, @CompanyID)
set @SQL += ' and IsTaxable = ' + CONVERT (nvarchar, @IsTaxable)
set @SQL += ' and StockDate <= ''' + CONVERT(nvarchar, @StockDate) 
set @SQL += ''''

if @EditWC <> ''
BEGIN

	set @SQL += ' and a.ProductInflowID not in (select ProductInflowID from data_ProductInflow where SourceName = ''' + @SourceName
	set @SQL += ''' and SourceID in ( ' + @EditWC
	set @SQL += '))'

END

set @SQL += ' union all '
set @SQL += ' select  -b.Quantity,b.Param1,b.Param2,b.Param3,b.ItemId from data_ProductOutflow a join  
data_ProductOutflowBatch b on a.ProductOutflowID = b.ProductOutflowID 
where b.ItemId is not null'

if (@ItemIDs IS NOT NULL)
BEGIN
	set @SQL += ' and a.ItemId IN (SELECT splitdata FROM [dbo].[fnSplitString1]('''+@ItemIDs+''', '','') ) ';
END

if @WHID > 0 
BEGIN
	set @SQL += ' and WHID = '+ CONVERT (nvarchar, @WHID)
END

set @SQL += ' and CompanyID = ' + CONVERT (nvarchar, @CompanyID)
set @SQL += ' and IsTaxable = ' + CONVERT (nvarchar, @IsTaxable)
set @SQL += ' and StockDate <= ''' + CONVERT(nvarchar, @StockDate) 
set @SQL += ''''

if @EditWC <> ''
BEGIN
	set @SQL += ' and a.ProductOutflowID not in (select ProductOutflowID from data_ProductOutflow where SourceName = ''' + @SourceName
	set @SQL += ''' and SourceID  in ( ' + @EditWC
	set @SQL += ' ))'	
END

set @SQL += ') a 
group by Param1,Param2,Param3,ItemId
having ISNULL(sum(Quantity),0) > 0
'

EXEC(@SQL);


END

GO



/****** Object:  StoredProcedure [dbo].[GetBatchStockQuantity_IMEISearch]    Script Date: 6/9/2022 2:11:22 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBatchStockQuantity_IMEISearch]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetBatchStockQuantity_IMEISearch]
GO

/****** Object:  StoredProcedure [dbo].[GetBatchStockQuantity_IMEISearch]    Script Date: 6/9/2022 2:11:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBatchStockQuantity_IMEISearch]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetBatchStockQuantity_IMEISearch] AS' 
END
GO



ALTER PROCEDURE [dbo].[GetBatchStockQuantity_IMEISearch]
(
@WHID int=0 , 
@WhereClause nvarchar(max) = '' ,
@CompanyID int
)
AS
BEGIN

declare @SQL nvarchar(max) = ''

set @SQL = 'select  Param1 , Param2 , Param3,
Param1 + ISNULL('','' + Param2 , '''') IMEINumber, a.ItemId , ISNULL(sum(Quantity),0) as Quantity
from (select b.Quantity ,b.Param1,b.Param2,b.Param3,b.ItemId from data_ProductInflow a join data_ProductInflowBatch b 
on a.ProductInflowID = b.ProductInflowID  where IsDeleted = 0 and b.ItemId is not null'

set @SQL += @WhereClause;

if @WHID > 0 
BEGIN
	set @SQL += ' and WHID = '+ CONVERT (nvarchar, @WHID)
END

set @SQL += ' and CompanyID = ' + CONVERT (nvarchar, @CompanyID)



set @SQL += ' union all '
set @SQL += ' select  -b.Quantity,b.Param1,b.Param2,b.Param3,b.ItemId from data_ProductOutflow a join  
data_ProductOutflowBatch b on a.ProductOutflowID = b.ProductOutflowID 
where b.ItemId is not null'

set @SQL += @WhereClause;

if @WHID > 0 
BEGIN
	set @SQL += ' and WHID = '+ CONVERT (nvarchar, @WHID)
END

set @SQL += ' and CompanyID = ' + CONVERT (nvarchar, @CompanyID)


set @SQL += ') a 
group by Param1,Param2,Param3,a.ItemId 
having ISNULL(sum(Quantity),0) > 0
'

EXEC(@SQL);


END


GO



/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_SelectAll]    Script Date: 6/13/2022 12:37:35 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_SelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePosInfo_SelectAll]
GO

/****** Object:  StoredProcedure [dbo].[data_SalePosReturnInfo_Insert]    Script Date: 6/13/2022 12:37:35 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosReturnInfo_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePosReturnInfo_Insert]
GO

/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Update]    Script Date: 6/13/2022 12:37:35 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePosInfo_Update]
GO

/****** Object:  StoredProcedure [dbo].[data_SalePOSReturnInfo_InsertAccountOffline]    Script Date: 6/13/2022 12:37:35 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePOSReturnInfo_InsertAccountOffline]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePOSReturnInfo_InsertAccountOffline]
GO

/****** Object:  StoredProcedure [dbo].[data_SalePOSInfo_InsertAccountOffline]    Script Date: 6/13/2022 12:37:35 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePOSInfo_InsertAccountOffline]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePOSInfo_InsertAccountOffline]
GO

/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Cancel]    Script Date: 6/13/2022 12:37:35 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_Cancel]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePosInfo_Cancel]
GO

/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Insert]    Script Date: 6/13/2022 12:37:35 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePosInfo_Insert]
GO



/****** Object:  UserDefinedTableType [dbo].[data_SalePosDetail]    Script Date: 6/7/2022 3:00:11 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_SalePosDetail' AND ss.name = N'dbo')
DROP TYPE [dbo].[data_SalePosDetail]
GO

/****** Object:  UserDefinedTableType [dbo].[data_SalePosDetail]    Script Date: 6/7/2022 3:00:11 PM ******/
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
	[isExchange] [bit] NULL,
	[IMEINumber] [nvarchar](1000) NULL
)
GO


/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Insert]    Script Date: 6/13/2022 12:37:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_SalePosInfo_Insert] AS' 
END
GO




-- Server : desktop-q54d9j1 -- 

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
@SaleInvoiceNo int=0,
@ExchangeAmount numeric(18, 3) =NULL,
@MenuId int =NULL,
@InvoiceType int= NULL,
@CardNumber nvarchar(MAX)=NULL,
@CardName nvarchar(1000)=NULL,
@CashPayment numeric(18, 3)=NULL,
@CardPayment numeric(18, 3)=NULL,
@SaleManId int=null,
@CustomerID int=null,
@RiderAmount numeric(18,3)=0,
@LinckedBill int =NULL,
@CounterID int=null,
@SalePosReturnID int=0 output


as
declare @returnSale bit=0
declare @IsTaxable bit =0
--set @SalePosDate=GETDATE()
declare @ISOfflineServer bit=0,@StylePOS nvarchar(50)=''

Select @StylePOS=POSStyle from gen_posConfiguration where CounterID=@CounterID

IF @StylePOS='POSPcWorldStyle'
BEGIN
Select  @ISOfflineServer=ISNULL(IsofflineServer,0) from gen_posConfiguration  where CounterID=@CounterID
END
ELSE 
BEGIN
Select  @ISOfflineServer=ISNULL(IsofflineServer,0) from gen_posConfiguration where WHID=@WHID
END
declare @MaxTable as MaxTable 
declare @MaxTable2 as MaxTable
if	 @DirectReturn = 0
BEGIN
	insert into @MaxTable
	--exec GetmaxNo 'SaleVoucherNo','data_SaleInfo', @CompanyID
	exec GetVoucherNoPosFoodMama @Fieldname=N'SalePOSNo',@TableName=N'data_SalePosInfo',@CheckTaxable= 0 ,@PrimaryKeyValue = @SalePosID,@PrimaryKeyFieldName = 'SalePosID' ,
	@voucherDate=@SalePOSDate,@voucherDateFieldName=N'SalePOSDate',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=@FiscalID, 
	@FiscalIDFieldName=N'FiscalID',@IsTaxable=@IsTaxable,@MenuId=@MenuId,@MenuFieldName=N'MenuId',@CounterID=@CounterID,@CounterField=N'CounterID'
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
		SalePOSNo,
		ExchangeAmount,
		MenuId,
		InvoiceType,
		CardNumber,
		CardName,
		CashPayment,
		CardPayment,
		SaleManId,
		RiderAmount,
		LinckedBill,
		CounterID
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
		@SaleInvoiceNo,
		@ExchangeAmount,
		@MenuId,
		@InvoiceType,
		@CardNumber,
		@CardName,
		@CashPayment,
		@CardPayment,
		@SaleManId,
		@RiderAmount,
		@LinckedBill,
		@CounterID
		
	)	
	set @SalePosID = @@IDENTITY
	if @CustomerID is not null
	begin
	insert into posdata_CustomerInvoiceList (SalePosId,CustomerID) values(@SalePosID,@CustomerID)

	end
	if @InvoiceType is null or @InvoiceType=1
	begin
		EXEC [dbo].[data_Cash_Insert]
		@SourceID = @SalePosID,
		@SourceName = N'POS',
		@Amount = @AmountReceivable,
		@CashType = 1,
		@SalePosDate=@SalePosDate,
		@CounterID=@CounterID
	end

	if @RiderAmount>0
	begin
		declare @RemarkDetail nvarchar(Max)=''
		set @RemarkDetail='Amount Given to Rider against Bill No '+ Cast(@SaleInvoiceNo as nvarchar(100))+' Dated on '+Format(@SalePosDate,'dd-MMM-yyyy') 
		EXEC [dbo].[data_Cash_Insert]
		@SourceID = @SalePosID,
		@SourceName = N'POS',
		@Amount = @RiderAmount,
		@CashType = 0,
		@Remarks=@RemarkDetail,
		@SalePosDate=@SalePosDate,
		@CounterID=@CounterID
	end
		

---========== Sale End Here ================
---========================== Sale Stock In Working Start Here =============================
		


declare @RowID int,@SaleDetailID int ,@StockRate numeric(14,5) , @Quantity numeric(10,2),@ItemId int, @IsBatchItem bit=0, @stockQty numeric(14,2),@ItemName varchar(200), @IMEINumber nvarchar(1000), @IMEINumber1 nvarchar(1000), @IMEINumber2 nvarchar(1000), @ERRORMSG varchar(200), @AllowNegativeStock bit = 0,
		@MainTainInventory bit = 1,@DealCateGoryID int=0,@ItemCategoryID int=0,@BomId int,@ProductIntflowID int=0,
        @data_ManufacturingDetail  data_ManufacturingDetail  ,
        @data_ItemBatchDetail  data_ItemBatchDetail  ,
        @data_ItemBatchDetailFinish  data_ItemBatchDetail ,@ManufacturingID int=0,@isExchange bit=0

		Select @DealCateGoryID=POSDealsCategory , @AllowNegativeStock = AllowNegativeStock from gen_SystemConfiguration where CompanyID=@CompanyID 
		
declare Salecursor cursor for
select RowID from @data_SalePosDetail
open Salecursor
fetch next from Salecursor into @RowID
while @@FETCH_STATUS = 0
begin

	select @ItemId = ItemId, @Quantity=Quantity, @StockRate=ItemRate , @isExchange=isExchange, @IMEINumber=IMEINumber
	From @data_SalePosDetail
	where RowID = @RowID
		
	Select @ItemCategoryID=CategoryID,@MainTainInventory = MaintainInventory, @IsBatchItem=IsBatchItem from InventItems where ItemId=@ItemId

	SET @IMEINumber1 = NULL; SET @IMEINumber2 = NULL;

	IF @IMEINumber IS NOT NULL AND @IMEINumber <> ''
	BEGIN
		IF CHARINDEX(',', @IMEINumber) > 0
		BEGIN
			SET @IMEINumber1 = Substring(
								@IMEINumber, 
								1, 
								Charindex(',', @IMEINumber)-1
								);
			SET @IMEINumber2 = Substring(
								@IMEINumber, 
								Charindex(',', @IMEINumber)+1, 
								LEN(@IMEINumber)-Charindex(',', @IMEINumber)
								);
		END
		ELSE
		BEGIN
			SET @IMEINumber1 = @IMEINumber;
		END
		
	END
	
	IF @IsBatchItem = 1 AND @IMEINumber1 IS NOT NULL
	BEGIN
		INSERT INTO @data_ItemBatchDetail (RowID, Quantity, Param1, Param2, Param3)
		SELECT @RowID , @Quantity, @IMEINumber1, @IMEINumber2, NULL
	END

	Select @BomId=BOMID from gen_BOMInfo where ItemId=@ItemId
	if(@BomId>0)
	begin
		insert into @data_ManufacturingDetail (RowID,ItemId,BOMQuantity,ActualQuantity,WHID,StockRate,BOMFormulaQuantity) 
Select ROW_NUMBER() Over(  order by ItemID)-1 as ROwId,ItemId,Quantity,Quantity*@Quantity,@WHID,0 ,1 from gen_BOMDetail where BOMID=@BomId
exec data_ManufacturingInfo_Insert @ManufacturingID=@ManufacturingID output,@UserID=@UserID,@CompanyID=@CompanyID,@FiscalID=@FiscalID,@BomId=@BomId,@ItemId=@ItemId,@ManufacturingDate=@SalePosDate,@Quantity=@Quantity,@WHID=@WHID,@ManufacturingStyle='STYLE 1',@IsTaxable=@IsTaxable,@data_ManufacturingDetail=@data_ManufacturingDetail,@data_ItemBatchDetail=@data_ItemBatchDetail,@data_ItemBatchDetailFinish=@data_ItemBatchDetailFinish,@LooseQuantity=@Quantity
	end


		--if	 @returnSale = 0
		--BEGIN
		declare @checkRate bit = 1

		IF @MainTainInventory = 1
		BEGIN
			
			IF @IsBatchItem = 1 
			BEGIN
				exec CheckStock @ItemID = @ItemId ,
				@WHID = @WHID , 
				@StockDate = @SalePosDate , 
				@CompanyID = @CompanyID,		
				@RowID = @RowID ,
				@AllowNegativeStock = @AllowNegativeStock,
				@Quantity = @Quantity,
				@ERRORMSG = @ERRORMSG out,
				@checkRate = @checkRate out,
				@data_ItemBatchDetail =  @data_ItemBatchDetail ,
				@IsTaxable =  @IsTaxable

				if @ERRORMSG != ''
				BEGIN
					RAISERROR (@ERRORMSG , 16, 1 ) ;
					return
				END
			END
			ELSE
			BEGIN
				exec GetStockQuantity @ItemId ,@WHID , @SalePosDate , @stockQty output , @ItemName out , @CompanyID , '' , '' , 
				null , null , null , @IsBatchItem , @IsTaxable
				if ( @stockQty < @Quantity )
				BEGIN
						set @ERRORMSG = 'Stock is not enough of Item ' + @ItemName + ' Avaliable Stock '+  convert(varchar, @stockQty)	 + ' Required Quantity is ' + convert(varchar, @Quantity)	
						RAISERROR (@ERRORMSG , 16, 1 ) ;
						return
				END
			END
			
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
		isExchange,
		IMEINumber
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
		isExchange,
		IMEINumber

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
				set @Quantity=-1* @Quantity
				exec data_ProductInflow_Insert @ProductIntflowID output,@ItemId,@SaleDetailID,'POSEXCHANGE',@WHID, @SalePosDate ,@StockRate,@Quantity, 
				@Quantity,@FiscalID , @CompanyID , @IsTaxable
				exec tempInflowDataTable_Insert @ProductIntflowID ,'POSEXCHANGE'
				end
				else
				begin
				
				exec data_ProductOutflow_Insert @ProductOutflowID output,null,@ItemId,@SaleDetailID,'POS',@WHID, @SalePosDate ,@StockRate,@Quantity, 
				@FiscalID , @CompanyID , @IsTaxable , NULL, NULL, NULL, NULL, NULL, NULL, NULL
				, @RowID , @data_ItemBatchDetail
				exec tempOutflowDataTable_Insert @ProductOutflowID ,'POS'
				end
				Update data_salePosDetail set StockRate=@StockRate where SalePOSDetailID=@SaleDetailID
			END
	
	FETCH NEXT FROM Salecursor INTO @RowID
	END

close Salecursor
deallocate Salecursor



if @ISOfflineServer=1
begin

exec  data_SalePOSInfo_InsertAccountOffline @CounterID=@CounterID,@SalePosID = @SalePosID, @CompanyID = @CompanyID, @SalePosDate = @SalePosDate , @WHID = @WHID , 
@NetAmount = @NetAmount , @SaleInvoiceNo = @SaleInvoiceNo , @UserID = @UserID , @FiscalID = @FiscalID ,@EditMode = 0,
@AmountReceivable = @AmountReceivable,@data_SalePosDetail=@data_SalePosDetail

end
---========================== Sale Stock In Working End Here =============================


END
else
BEGIN
---========== Sale Return Start Here ================





--insert into @MaxTable2
--exec GetVoucherNoPosFoodMama @Fieldname=N'SalePOSNo',@TableName=N'data_SalePosReturnInfo',@CheckTaxable= 0 ,@PrimaryKeyValue = @SalePosReturnID,@PrimaryKeyFieldName = 'SalePosReturnID' ,
--	@voucherDate=@SalePOSDate,@voucherDateFieldName=N'SalePosReturnDate',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=@FiscalID, 
--	@FiscalIDFieldName=N'FiscalID',@IsTaxable=@IsTaxable,@MenuId=@MenuId,@MenuFieldName=N'MenuId',@CounterID=@CounterID,@CounterField=N'CounterID'
--	select @SaleInvoiceNo = VoucherNo from @MaxTable2






--declare @SalePosReturnID bigint=0
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
		AmountPayable,
		MenuId,
		InvoiceType
		
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
		@AmountPayable,
		@MenuId,
		@InvoiceType
		
		)
	set @SalePosReturnID = SCOPE_IDENTITY()

	--Checking Total Cash Remaining 
DECLARE @Amount decimal(18,2)=0 
select @Amount=(select isnull(sum(Amount),0) as Amount from data_CashIn where Date=cast(GETDATE() as date))
-
(select isnull(sum(Amount),0) as Amount from data_CashOut where Date=cast(GETDATE() as date)) 
--select  @Amount
declare @ErrorMessage nvarchar(1000),@RemarksonDirectReturn nvarchar(Max)='Direct Sale Return'
if	@Amount>@AmountPayable
begin
	EXEC [dbo].[data_Cash_Insert]
	@SourceID = @SalePosReturnID,
	@SourceName = N'POS RETURN',
	@Amount = @AmountPayable,
	@CashType = 0,
	@Remarks=@RemarksonDirectReturn,
	@SalePosDate=@SalePosDate,
	@CounterID=@CounterID
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
declare @PosSaleReturnDetailID int ,@PosStockRate numeric(14,5) , @PosQuantity numeric(10,2),@PosItemId int,@PosstockQty numeric(14,2), @RIMEINumber nvarchar(1000), @RIMEINumber1 nvarchar(1000), @RIMEINumber2 nvarchar(1000), @RIsBatchItem bit=0 , @Rdata_ItemBatchDetail  data_ItemBatchDetail
	
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
	select @PosItemId = ItemId,@PosQuantity=Quantity,@PosStockRate=ItemRate , @RIMEINumber=IMEINumber
    --@MainTainInventory = MaintainInventory,
	From @data_SalePosDetail	 where RowID = @PractitionerId

	Select @RIsBatchItem=IsBatchItem from InventItems where ItemId=@PosItemId

	SET @RIMEINumber1 = NULL; SET @RIMEINumber2 = NULL;

	IF @RIMEINumber IS NOT NULL AND @RIMEINumber <> ''
	BEGIN
		IF CHARINDEX(',', @RIMEINumber) > 0
		BEGIN
			SET @RIMEINumber1 = Substring(
								@RIMEINumber, 
								1, 
								Charindex(',', @RIMEINumber)-1
								);
			SET @RIMEINumber2 = Substring(
								@RIMEINumber, 
								Charindex(',', @RIMEINumber)+1, 
								LEN(@RIMEINumber)-Charindex(',', @RIMEINumber)
								);
		END
		ELSE
		BEGIN
			SET @RIMEINumber1 = @RIMEINumber;
		END
		
	END
	
	IF @RIsBatchItem = 1 AND @RIMEINumber1 IS NOT NULL
	BEGIN
		INSERT INTO @Rdata_ItemBatchDetail (RowID, Quantity, Param1, Param2, Param3)
		SELECT @PractitionerId , @PosQuantity, @RIMEINumber1, @RIMEINumber2, NULL
	END

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
		MinQuantity,
		IMEINumber
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
		MinQuantity,
		IMEINumber
		From @data_SalePosDetail 
		where RowID = @PractitionerId

	set @PosSaleReturnDetailID = SCOPE_IDENTITY()

	--watch this
	exec data_ProductInflow_Insert @productInflowID out,@PosItemId,@PosSaleReturnDetailID,'POS RETURN',@WHID, @SalePosDate , 
				@PosStockRate,@PosQuantity,@PosQuantity,@FiscalID , @CompanyID ,@IsTaxable, NULL, NULL, NULL, NULL, NULL, NULL, NULL
				, @PractitionerId , @Rdata_ItemBatchDetail
				exec tempInflowDataTable_Insert @productInflowID ,'POS RETURN'
	--watht this end
update data_SalePosReturnDetail set IsLog=1 where SalePosReturnDetailID=@PosSaleReturnDetailID


exec GetWeightedRateForItem @PosItemId, @WHID ,@SalePosDate ,@SalePosDate ,@PosStockRate output , @CompanyID , @IsTaxable
update data_SalePosReturnDetail set StockRate=@PosStockRate where SalePosReturnDetailID=@PosSaleReturnDetailID

    FETCH NEXT FROM MY_CURSOR INTO @PractitionerId
END
CLOSE MY_CURSOR
DEALLOCATE MY_CURSOR
-----------sale return


if @ISOfflineServer=1
begin

exec  data_SalePOSReturnInfo_InsertAccountOffline @CounterID=@CounterID,@SalePosReturnID=@SalePosReturnID, @SalePosID = @SalePosID, @CompanyID = @CompanyID, @SalePosDate = @SalePosDate , @WHID = @WHID , 
@NetAmount = @NetAmount , @SaleInvoiceNo = @SaleInvoiceNo , @UserID = @UserID , @FiscalID = @FiscalID ,@EditMode = 0,
 @AmountReceivable = @NetAmount,@data_SalePosDetail=@data_SalePosDetail

end

-----------
---========================== Sale Stock Return Working End Here =============================



END














GO

/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Cancel]    Script Date: 6/13/2022 12:37:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_Cancel]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_SalePosInfo_Cancel] AS' 
END
GO



ALTER procedure[dbo].[data_SalePosInfo_Cancel]
@UserID int = null , 
@CompanyID int = null , 
@FiscalID int = null ,
@SalePosDate date = null,
@WHID   int	=null,
@TaxAmount decimal (18, 2)	=null,
@GrossAmount decimal (18, 2)	=null,
@DiscountPercentage decimal (18, 2)	=null,
@DiscountAmount decimal (18, 2)	=null,
@DiscountTotal decimal (18, 2)	=null,
@OtherCharges decimal (18, 2)	=null,
@NetAmount decimal (18, 2)	=null,
@AmountReceive decimal (18, 2)	=null,
@AmountReturn decimal (18, 2)	=null,
@AmountInAccount decimal (18, 2)	=null,
@AmountReceivable decimal (18, 2)	=null,
@AmountPayable decimal (18, 2)	=null,
@DirectReturn bit = 0,
@data_SalePosDetail  data_SalePosDetail readonly,
@SalePosID bigint output,
@CustomerPhone nvarchar(50)=null,
@CustomerName nvarchar(50)=null,
@SaleInvoiceNo int=0,
@ExchangeAmount numeric(18, 3) =NULL,
@MenuId int =NULL,
@InvoiceType int= NULL,
@CardNumber nvarchar(MAX)=NULL,
@CardName nvarchar(1000)=NULL,
@CashPayment numeric(18, 3)=NULL,
@CardPayment numeric(18, 3)=NULL,
@SaleManId int=null

as
declare @returnSale bit=0
declare @IsTaxable bit =0
--set @SalePosDate = GETDATE()

declare @MaxTable as MaxTable
declare @MaxTable2 as MaxTable
if	 @SalePosID > 0
BEGIN

    Update  data_SalePosInfo set

        ModifyUserID=@UserID,
		ModifyUserDateTime=GETDATE(),
		CompanyID=@CompanyID,
		FiscalID=@FiscalID,
		SalePosDate=@SalePosDate,
		WHID=@WHID,
		TaxAmount=@TaxAmount,
		GrossAmount=@GrossAmount,
		DiscountPercentage=@DiscountPercentage,
		DiscountAmount=@DiscountAmount,
		DiscountTotal=@DiscountTotal,
		OtherCharges=@OtherCharges,
		NetAmount=@NetAmount,
		AmountReceive=@AmountReceive,
		AmountReturn=@AmountReturn,
		AmountInAccount=@AmountInAccount,
		AmountReceivable=@AmountReceivable,
		AmountPayable=@AmountPayable,
		CustomerPhone=@CustomerPhone,
		CustomerName=@CustomerName,
		
		ExchangeAmount=@ExchangeAmount,
		MenuId=@MenuId,
		InvoiceType=@InvoiceType,
		CardNumber=@CardNumber,
		CardName=@CardName,
		CashPayment=@CashPayment,
		CardPayment=@CardPayment,
		SaleManId=@SaleManId,
		DirectReturn=1
	where SalePosID = @SalePosID
--delete from data_CashIn where SourceName='POS' and SourceID = @SalePosID
Delete from data_ProductInflow where SourceName='POSEXCHANGE' and SourceID in (Select SalePosDetailID from data_SalePosDetail where SalePosID=@SalePosID)
Delete from data_ProductOutflowBatch where SourceName='POS' and SourceID in (Select SalePosDetailID from data_SalePosDetail where SalePosID=@SalePosID)
Delete from data_ProductOutflow where SourceName='POS' and SourceID in (Select SalePosDetailID from data_SalePosDetail where SalePosID=@SalePosID)
Delete from data_SalePosDetail where SalePosID=@SalePosID
    EXEC[dbo].[data_Cash_Insert]
@SourceID = @SalePosID,
		@SourceName = N'INVOICE CANCELLED',
		@Amount = @AmountReceivable,
		@CashType = 0,
		@SalePosDate=@SalePosDate

		


---========== Sale End Here ================
---========================== Sale Stock In Working Start Here =============================
		
end

declare @RowID int,@SaleDetailID int ,@StockRate numeric(14,5) , @Quantity numeric(10,2),@ItemId int,@stockQty numeric(14,2),@ItemName varchar(200),@ERRORMSG varchar(200),
		@MainTainInventory bit = 1, @DealCateGoryID int=0,@ItemCategoryID int=0,@BomId int,@ProductIntflowID int=0,
        @data_ManufacturingDetail data_ManufacturingDetail,
        @data_ItemBatchDetail  data_ItemBatchDetail  ,
        @data_ItemBatchDetailFinish data_ItemBatchDetail, @ManufacturingID int=0,@isExchange bit = 0

        Select @DealCateGoryID = POSDealsCategory from gen_SystemConfiguration where CompanyID = @CompanyID


declare Salecursor cursor for
select RowID from @data_SalePosDetail
open Salecursor
fetch next from Salecursor into @RowID
while @@FETCH_STATUS = 0
	begin

--	select @ItemId = ItemId, @Quantity = Quantity, @StockRate = ItemRate, @isExchange = isExchange

--  From @data_SalePosDetail         where RowID = @RowID

--      Select @ItemCategoryID = CategoryID, @MainTainInventory = MaintainInventory from InventItems where ItemId = @ItemId

   --      Select @BomId = BOMID from gen_BOMInfo where ItemId = @ItemId
     --      if(@BomId>0 and @ItemCategoryID = @DealCateGoryID)
--		begin
--		insert into @data_ManufacturingDetail(RowID, ItemId, BOMQuantity, ActualQuantity, WHID, StockRate, BOMFormulaQuantity)
--Select ROW_NUMBER() Over(order by ItemID)-1 as ROwId,ItemId,Quantity,Quantity* @Quantity, @WHID,0 ,1 from gen_BOMDetail where BOMID = @BomId
--exec data_ManufacturingInfo_Insert @ManufacturingID=@ManufacturingID output, @UserID = @UserID, @CompanyID = @CompanyID, @FiscalID = @FiscalID, @BomId = @BomId, @ItemId = @ItemId, @ManufacturingDate = @SalePosDate, @Quantity = @Quantity, @WHID = @WHID, @ManufacturingStyle = 'STYLE 1', @IsTaxable = @IsTaxable, @data_ManufacturingDetail = @data_ManufacturingDetail, @data_ItemBatchDetail = @data_ItemBatchDetail, @data_ItemBatchDetailFinish = @data_ItemBatchDetailFinish, @LooseQuantity = @Quantity      end
--		--if	 @returnSale = 0
--		--BEGIN
--			exec GetStockQuantity @ItemId ,@WHID , @SalePosDate , @stockQty output, @ItemName out , @CompanyID , '' , '' , 
--			null , null , null , 1 , @IsTaxable
--			if ((@stockQty<@Quantity ) and @MainTainInventory=1)
--			BEGIN
--					set @ERRORMSG = 'Stock is not enough of Item ' + @ItemName + ' Avaliable Stock '+  convert(varchar, @stockQty)	 + ' Required Quantity is ' + convert(varchar, @Quantity)
--					RAISERROR(@ERRORMSG , 16, 1 );
--					return
--			END
--		--END

        Insert Into data_SalePosDetail(
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
        isExchange,
		IMEINumber

        ) Select
        @SalePosID,
        ItemId,
        Quantity,
        ItemRate,
        TaxPercentage,
        TaxAmount,
        DiscountPercentage,
        DiscountAmount,
        TotalAmount, @ManufacturingID,
        CartonSize,
        Carton,
        TotalQuantity,
        SchemeID,
        MinQuantity,
        isExchange,
		IMEINumber


        From @data_SalePosDetail where RowID = @RowID


        set @SaleDetailID = @@IDENTITY		

		--declare @ProductOutflowID int
		--	if @MainTainInventory = 1 
		--	BEGIN		
		--		BEGIN
		--			exec GetWeightedRateForItem @ItemId, @WHID ,@SalePosDate ,@SalePosDate ,@StockRate output, @CompanyID, @IsTaxable
		--		END
		--		update data_SalePosDetail set StockRate = @StockRate where SalePosDetailID = @SaleDetailID
        --      if @isExchange=1
		--		begin
		--		set @Quantity = -1 * @Quantity
        --      exec data_ProductInflow_Insert @ProductIntflowID output, @ItemId, @SaleDetailID,'POSEXCHANGE',@WHID, @SalePosDate ,@StockRate,@Quantity, 
		--		@Quantity,@FiscalID , @CompanyID , @IsTaxable
		--		exec tempInflowDataTable_Insert @ProductIntflowID ,'POSEXCHANGE'
		--		end
		--		else
		--		begin
		--		exec data_ProductOutflow_Insert @ProductOutflowID output,null,@ItemId,@SaleDetailID,'POS',@WHID, @SalePosDate ,@StockRate,@Quantity, 
		--		@FiscalID , @CompanyID , @IsTaxable
		--		exec tempOutflowDataTable_Insert @ProductOutflowID ,'POS'
		--		end
				
		--	END

    FETCH NEXT FROM Salecursor INTO @RowID
    END

close Salecursor
deallocate Salecursor

---========================== Sale Stock In Working End Here =============================





GO

/****** Object:  StoredProcedure [dbo].[data_SalePOSInfo_InsertAccountOffline]    Script Date: 6/13/2022 12:37:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePOSInfo_InsertAccountOffline]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_SalePOSInfo_InsertAccountOffline] AS' 
END
GO









ALTER procedure [dbo].[data_SalePOSInfo_InsertAccountOffline] 
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
@SaleInvoiceNo int=0,
@ExchangeAmount numeric(18, 3) =NULL,
@MenuId int =NULL,
@InvoiceType int= NULL,
@CardNumber nvarchar(MAX)=NULL,
@CardName nvarchar(1000)=NULL,
@CashPayment numeric(18, 3)=NULL,
@CardPayment numeric(18, 3)=NULL,
@SaleManId int=null,
@CustomerID int=null,
@RiderAmount numeric(18,3)=0,
@LinckedBill int =NULL,
@CounterID int=null,
@EditMode bit=0


as 

declare @GLvDetail as GLvDetail ,@vID int, @vType int , @PartyGLID int , @WHGLID int , @VoucherNo varchar(10),@MasterDescription varchar(200),
@RoundingAccount int ,@DrTotal numeric(14,3),@CrTotal numeric(14,3),@CashAccount int, @SaleReturnAccount int, @Total numeric(14,3),
@StockConfig tinyint,@DescriptionStyle nvarchar(50),@Description nvarchar(500) = '', @TradeDiscountAccount int=0
,@FreightDiscountAccount int=0,@LoadingUnloadingAccount int=0,@OtherServicesAccount int=0,@StylePOS nvarchar(50)=''


select @vType =SaleVoucherTypeID,@CashAccount = CashAccount,@RoundingAccount=RoundingAccount
 from gen_SystemConfiguration 
where CompanyID = @CompanyID
Select @StylePOS=POSStyle from gen_posConfiguration where CounterID=@CounterID

IF @StylePOS='POSPcWorldStyle'
BEGIN
Select @CashAccount=CashAccountPOS from gen_posConfiguration where CounterID=@CounterID
END
ELSE 
BEGIN
Select @CashAccount=CashAccountPOS from gen_posConfiguration where WHID=@WHID

END

set @MasterDescription = 'POS Sale Voucher No ' + CONVERT(varchar, @SaleInvoiceNo)
select
		 @MasterDescription += ' and Sale of ' + STUFF((select ',' 		  
		+ CONVERT(varchar(10),CONVERT(numeric(18,0),Quantity))+' '  + ItenName +'@'+CONVERT(varchar(10),CONVERT(numeric(18,0), ItemRate)) --+ ','
		From @data_SalePosDetail as D join InventItems on InventItems.ItemId=D.ItemId  FOR XML PATH('')),1,1,'')

declare @SaleAmount numeric(18, 3) ,@StockAmount numeric(18,3)

if @EditMode = 1
BEGIN
	select @vID = AccountVoucherID from data_salePosInfo where SalePOSID = @SALEPOSID 	
END
else
BEGIN
	set @vID = 0	
	--exec GLvMAIN_MaxVoucherNo @CompanyID,@vType, @VoucherNo output , @FiscalID,@IsTaxable,@vDate
END





	select sum(TotalAmount) as DtSoldAmount,InventCategory.StockAccount,InventCategory.CGSAccount,InventCategory.SaleAccount , 0 as DTypeID,0 as DvaluesID,sum(Quantity * StockRate) StockAmount into #temp
	from Data_salePosDetail p join InventItems on p.ItemId = InventItems.ItemId join InventCategory on InventItems.CategoryID = InventCategory.CategoryID where SalePosID=@SalePOSID
	group by InventCategory.CategoryID,InventCategory.StockAccount,InventCategory.CGSAccount,InventCategory.SaleAccount

	select @StockAmount = sum(StockAmount) from #temp
	select @SaleAmount = sum(DtSoldAmount) from #temp
	
	if @StockAmount>0
	begin
	insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
	select CGSAccount , DTypeID,DvaluesID,@MasterDescription ,StockAmount from #temp
	insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,cr)
	select StockAccount , DTypeID,DvaluesID,@MasterDescription ,StockAmount from #temp
	end

if @SaleAmount>0
	begin
	insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,cr)
	select SaleAccount , DTypeID,DvaluesID,@MasterDescription ,DtSoldAmount from #temp
	end
insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
values(@CashAccount,0,0,@MasterDescription, @AmountReceivable)





Select @DrTotal=sum(dr),@CrTotal=sum(cr) from @GLvDetail
	if @DrTotal - @CrTotal > 0
	BEGIN
		insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,cr)
		values(@RoundingAccount,0,0,@MasterDescription,@DrTotal - @CrTotal)

	END
	else if  @DrTotal - @CrTotal < 0
	BEGIN
		insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
		values(@RoundingAccount,0,0,@MasterDescription, @CrTotal - @DrTotal)

	END

set @Total = @NetAmount + @StockAmount




exec GLvMAIN_Insert  @GLvDetail=@GLvDetail , @vID = @vID output ,@vType =@vType ,@vNO = @VoucherNo , @vDate = @SalePosDate ,@vremarks =@MasterDescription ,@FiscalID = @FiscalID , @Comp_Id =@CompanyID,
	 @vUserID=@UserID,@TotalDr = @Total , @TotalCr = @Total , @ReadOnly = 1, @BranchID=null,@IsTaxable = 0

	 update data_SalePosInfo set AccountVoucherID = @vID where SALEPOSID = @SALEPOSID


















GO

/****** Object:  StoredProcedure [dbo].[data_SalePOSReturnInfo_InsertAccountOffline]    Script Date: 6/13/2022 12:37:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePOSReturnInfo_InsertAccountOffline]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_SalePOSReturnInfo_InsertAccountOffline] AS' 
END
GO





ALTER procedure [dbo].[data_SalePOSReturnInfo_InsertAccountOffline] 
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
@SalePosID bigint =0,
@SalePosReturnID int=0,
@CustomerPhone nvarchar(50)=null,
@CustomerName  nvarchar(50)=null,
@SaleInvoiceNo int=0,
@ExchangeAmount numeric(18, 3) =NULL,
@MenuId int =NULL,
@InvoiceType int= NULL,
@CardNumber nvarchar(MAX)=NULL,
@CardName nvarchar(1000)=NULL,
@CashPayment numeric(18, 3)=NULL,
@CardPayment numeric(18, 3)=NULL,
@SaleManId int=null,
@CustomerID int=null,
@RiderAmount numeric(18,3)=0,
@LinckedBill int =NULL,
@CounterID int=null,
@EditMode bit=0


as 

declare @GLvDetail as GLvDetail ,@vID int, @vType int , @PartyGLID int , @WHGLID int , @VoucherNo varchar(10),@MasterDescription varchar(200),
@RoundingAccount int ,@DrTotal numeric(14,3),@CrTotal numeric(14,3),@CashAccount int, @SaleReturnAccount int, @Total numeric(14,3),
@StockConfig tinyint,@DescriptionStyle nvarchar(50),@Description nvarchar(500) = '', @TradeDiscountAccount int=0
,@FreightDiscountAccount int=0,@LoadingUnloadingAccount int=0,@OtherServicesAccount int=0,@StylePOS nvarchar(50) = ''


select @vType =SaleReturnVoucherTypeID,@CashAccount = CashAccount,@RoundingAccount=RoundingAccount
 from gen_SystemConfiguration 
where CompanyID = @CompanyID

Select @StylePOS=POSStyle from gen_posConfiguration where CounterID=@CounterID

IF @StylePOS='POSPcWorldStyle'
BEGIN
Select @CashAccount=CashAccountPOS from gen_posConfiguration where CounterID=@CounterID
END
ELSE 
BEGIN
Select @CashAccount=CashAccountPOS from gen_posConfiguration where WHID=@WHID

END
if @SaleInvoiceNo>0
begin
set @MasterDescription = 'POS Sale Voucher No ' + CONVERT(varchar, @SaleInvoiceNo)
end
else 
begin
set @MasterDescription = 'Direct Sale Return ' 
end
select
		 @MasterDescription += ' and Return of ' + STUFF((select ',' 		  
		+ CONVERT(varchar(10),CONVERT(numeric(18,0),Quantity))+' '  + ItenName +'@'+CONVERT(varchar(10),CONVERT(numeric(18,0), ItemRate)) --+ ','
		From @data_SalePosDetail as D join InventItems on InventItems.ItemId=D.ItemId  FOR XML PATH('')),1,1,'')
declare @SaleAmount numeric(18, 3) ,@StockAmount numeric(18,3)

if @EditMode = 1
BEGIN
	select @vID = AccountVoucherID from data_SalePosReturnInfo where SalePosReturnID = @SalePosReturnID 	
END
else
BEGIN
	set @vID = 0	
	--exec GLvMAIN_MaxVoucherNo @CompanyID,@vType, @VoucherNo output , @FiscalID,@IsTaxable,@vDate
END





	select sum(p.TotalAmount) as DtSoldAmount,InventCategory.StockAccount,InventCategory.CGSAccount,InventCategory.SaleAccount , 0 as DTypeID,0 as DvaluesID,sum(p.Quantity * isnull(p.StockRate,0)) StockAmount into #temp
	from data_SalePosReturnDetail p join InventItems on p.ItemId = InventItems.ItemId join InventCategory on InventItems.CategoryID = InventCategory.CategoryID
	
	 where SalePosReturnID=@SalePosReturnID
	group by InventCategory.CategoryID,InventCategory.StockAccount,InventCategory.CGSAccount,InventCategory.SaleAccount

	select @StockAmount = sum(StockAmount) from #temp
	select @SaleAmount = sum(DtSoldAmount) from #temp
	if @StockAmount>0
	begin
	insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
	select StockAccount , DTypeID,DvaluesID,@MasterDescription ,StockAmount from #temp

	insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,cr)
	select CGSAccount , DTypeID,DvaluesID,@MasterDescription ,StockAmount from #temp
	end
	if @SaleAmount>0
	begin
	insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
	select SaleAccount , DTypeID,DvaluesID,@MasterDescription ,DtSoldAmount from #temp
	end
insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,cr)
values(@CashAccount,0,0,@MasterDescription, @AmountReceivable)





Select @DrTotal=sum(dr),@CrTotal=sum(cr) from @GLvDetail
	if @DrTotal - @CrTotal > 0
	BEGIN
		insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,cr)
		values(@RoundingAccount,0,0,@MasterDescription,@DrTotal - @CrTotal)

	END
	else if  @DrTotal - @CrTotal < 0
	BEGIN
		insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
		values(@RoundingAccount,0,0,@MasterDescription, @CrTotal - @DrTotal)

	END

set @Total = @NetAmount + @StockAmount




exec GLvMAIN_Insert  @GLvDetail=@GLvDetail , @vID = @vID output ,@vType =@vType ,@vNO = @VoucherNo , @vDate = @SalePosDate ,@vremarks =@MasterDescription ,@FiscalID = @FiscalID , @Comp_Id =@CompanyID,
	 @vUserID=@UserID,@TotalDr = @Total , @TotalCr = @Total , @ReadOnly = 1, @BranchID=null,@IsTaxable = 0

	 update data_SalePosReturnInfo set AccountVoucherID = @vID where SalePOsReturnID = @SalePOSReturnID



















GO

/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Update]    Script Date: 6/13/2022 12:37:35 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_SalePosInfo_Update] AS' 
END
GO



ALTER procedure [dbo].[data_SalePosInfo_Update] 
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
@SaleInvoiceNo int=0,
@ExchangeAmount numeric(18, 3) =NULL,
@MenuId int =NULL,
@InvoiceType int= NULL,
@CardNumber nvarchar(MAX)=NULL,
@CardName nvarchar(1000)=NULL,
@CashPayment numeric(18, 3)=NULL,
@CardPayment numeric(18, 3)=NULL,
@SaleManId int=null,
@CustomerID int=null,
@RiderAmount numeric(18,3)=0,
@LinckedBill int =NULL,
@CounterID int=null,
@SalePosReturnID int=0 output


as
declare @returnSale bit=0
declare @IsTaxable bit =0
--set @SalePosDate=GETDATE()

declare @MaxTable as MaxTable 
declare @MaxTable2 as MaxTable
if	 @SalePosID > 0
BEGIN
	
	Update  data_SalePosInfo set 
		ModifyUserID=@UserID,
		ModifyUserDateTime=GETDATE(),
		CompanyID=@CompanyID,
		FiscalID=@FiscalID,
		SalePosDate=@SalePosDate,
		WHID=@WHID,
		TaxAmount=@TaxAmount,
		GrossAmount=@GrossAmount,
		DiscountPercentage=@DiscountPercentage,
		DiscountAmount=@DiscountAmount,
		DiscountTotal=@DiscountTotal,
		OtherCharges=@OtherCharges,
		NetAmount=@NetAmount,
		AmountReceive=@AmountReceive,
		AmountReturn=@AmountReturn,
		AmountInAccount=@AmountInAccount,
		AmountReceivable=@AmountReceivable,
		AmountPayable=@AmountPayable,
		CustomerPhone=@CustomerPhone,
		CustomerName=@CustomerName,
		
		ExchangeAmount=@ExchangeAmount,
		MenuId=@MenuId,
		InvoiceType=@InvoiceType,
		CardNumber=@CardNumber,
		CardName=@CardName,
		CashPayment=@CashPayment,
		CardPayment=@CardPayment,
		SaleManId=@SaleManId,
		RiderAmount=@RiderAmount,
		LinckedBill=@LinckedBill,
		CounterID=@CounterID
	where SalePosID=@SalePosID
	delete from data_CashOut where SourceName='POS' and SourceID=@SalePosID
delete from data_CashIn where SourceName='POS' and SourceID=@SalePosID
Delete from data_ProductInflow where SourceName='POSEXCHANGE' and SourceID in (Select SalePosDetailID from data_SalePosDetail where SalePosID=@SalePosID)
Delete from data_ProductOutflowBatch where SourceName='POS' and SourceID in (Select SalePosDetailID from data_SalePosDetail where SalePosID=@SalePosID)
Delete from data_ProductOutflow where SourceName='POS' and SourceID in (Select SalePosDetailID from data_SalePosDetail where SalePosID=@SalePosID)
Delete from data_SalePosDetail where SalePosID=@SalePosID
	if @InvoiceType is null or @InvoiceType=1
	begin
	EXEC [dbo].[data_Cash_Insert]
		@SourceID = @SalePosID,
		@SourceName = N'POS',
		@Amount = @AmountReceivable,
		@CashType = 1,
		@SalePosDate=@SalePosDate,
		@CounterID=@CounterID
		end
		if @RiderAmount>0
	begin
	declare @RemarkDetail nvarchar(Max)=''
	set @RemarkDetail='Amount Given to Rider against Bill No '+ Cast(@SaleInvoiceNo as nvarchar(100))+' Dated on '+Format(@SalePosDate,'dd-MMM-yyyy') 
	EXEC [dbo].[data_Cash_Insert]
		@SourceID = @SalePosID,
		@SourceName = N'POS',
		@Amount = @RiderAmount,
		@CashType = 0,
		@Remarks=@RemarkDetail,
		@SalePosDate=@SalePosDate,
		@CounterID=@CounterID
		end
		

---========== Sale End Here ================
---========================== Sale Stock In Working Start Here =============================
		
end

declare @RowID int,@SaleDetailID int ,@StockRate numeric(14,5) , @Quantity numeric(10,2),@ItemId int,@stockQty numeric(14,2),@ItemName varchar(200),@ERRORMSG varchar(200),  @IMEINumber nvarchar(1000), @IMEINumber1 nvarchar(1000), @IMEINumber2 nvarchar(1000) , @AllowNegativeStock bit = 0, @IsBatchItem bit=0,
		@MainTainInventory bit = 1,@DealCateGoryID int=0,@ItemCategoryID int=0,@BomId int,@ProductIntflowID int=0,
        @data_ManufacturingDetail  data_ManufacturingDetail  ,
        @data_ItemBatchDetail  data_ItemBatchDetail  ,
        @data_ItemBatchDetailFinish  data_ItemBatchDetail ,@ManufacturingID int=0,@isExchange bit=0

		Select @DealCateGoryID=POSDealsCategory , @AllowNegativeStock = AllowNegativeStock from gen_SystemConfiguration where CompanyID=@CompanyID
		
declare Salecursor cursor for
select RowID from @data_SalePosDetail
open Salecursor
fetch next from Salecursor into @RowID
while @@FETCH_STATUS = 0
	begin

	select @ItemId = ItemId,@Quantity=Quantity,@StockRate=ItemRate ,@isExchange=isExchange, @IMEINumber=IMEINumber
	From @data_SalePosDetail		 
	where RowID = @RowID
		
	Select @ItemCategoryID=CategoryID,@MainTainInventory = MaintainInventory , @IsBatchItem=IsBatchItem  from InventItems where ItemId=@ItemId

	SET @IMEINumber1 = NULL; SET @IMEINumber2 = NULL;

	IF @IMEINumber IS NOT NULL AND @IMEINumber <> ''
	BEGIN
		IF CHARINDEX(',', @IMEINumber) > 0
		BEGIN
			SET @IMEINumber1 = Substring(
								@IMEINumber, 
								1, 
								Charindex(',', @IMEINumber)-1
								);
			SET @IMEINumber2 = Substring(
								@IMEINumber, 
								Charindex(',', @IMEINumber)+1, 
								LEN(@IMEINumber)-Charindex(',', @IMEINumber)
								);
		END
		ELSE
		BEGIN
			SET @IMEINumber1 = @IMEINumber;
		END
		
	END
	
	IF @IsBatchItem = 1 AND @IMEINumber1 IS NOT NULL
	BEGIN
		INSERT INTO @data_ItemBatchDetail (RowID, Quantity, Param1, Param2, Param3)
		SELECT @RowID , @Quantity, @IMEINumber1, @IMEINumber2, NULL
	END


Select @BomId=BOMID from gen_BOMInfo where ItemId=@ItemId
if(@BomId>0)
begin
		insert into @data_ManufacturingDetail (RowID,ItemId,BOMQuantity,ActualQuantity,WHID,StockRate,BOMFormulaQuantity) 
Select ROW_NUMBER() Over(  order by ItemID)-1 as ROwId,ItemId,Quantity,Quantity*@Quantity,@WHID,0 ,1 from gen_BOMDetail where BOMID=@BomId
exec data_ManufacturingInfo_Insert @ManufacturingID=@ManufacturingID output,@UserID=@UserID,@CompanyID=@CompanyID,@FiscalID=@FiscalID,@BomId=@BomId,@ItemId=@ItemId,@ManufacturingDate=@SalePosDate,@Quantity=@Quantity,@WHID=@WHID,@ManufacturingStyle='STYLE 1',@IsTaxable=@IsTaxable,@data_ManufacturingDetail=@data_ManufacturingDetail,@data_ItemBatchDetail=@data_ItemBatchDetail,@data_ItemBatchDetailFinish=@data_ItemBatchDetailFinish,@LooseQuantity=@Quantity		
end

		--if	 @returnSale = 0
		--BEGIN
		declare @checkRate bit = 1
		IF @MainTainInventory = 1
		BEGIN
			
			IF @IsBatchItem = 1 
			BEGIN
				exec CheckStock @ItemID = @ItemId ,
				@WHID = @WHID , 
				@StockDate = @SalePosDate , 
				@CompanyID = @CompanyID,		
				@RowID = @RowID ,
				@AllowNegativeStock = @AllowNegativeStock,
				@Quantity = @Quantity,
				@ERRORMSG = @ERRORMSG out,
				@checkRate = @checkRate out,
				@data_ItemBatchDetail =  @data_ItemBatchDetail ,
				@IsTaxable =  @IsTaxable

				if @ERRORMSG != ''
				BEGIN
					RAISERROR (@ERRORMSG , 16, 1 ) ;
					return
				END
			END
			ELSE
			BEGIN
				exec GetStockQuantity @ItemId ,@WHID , @SalePosDate , @stockQty output , @ItemName out , @CompanyID , '' , '' , 
				null , null , null , @IsBatchItem , @IsTaxable
				if ( @stockQty < @Quantity )
				BEGIN
						set @ERRORMSG = 'Stock is not enough of Item ' + @ItemName + ' Avaliable Stock '+  convert(varchar, @stockQty)	 + ' Required Quantity is ' + convert(varchar, @Quantity)	
						RAISERROR (@ERRORMSG , 16, 1 ) ;
						return
				END
			END
			
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
		isExchange,
		IMEINumber
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
		isExchange,
		IMEINumber

		From @data_SalePosDetail where RowID = @RowID
		
		set @SaleDetailID = @@IDENTITY		

		declare @ProductOutflowID int
			if @MainTainInventory = 1 
			BEGIN		
				BEGIN
					exec GetWeightedRateForItem @ItemId, @WHID ,@SalePosDate ,@SalePosDate ,@StockRate output , @CompanyID , @IsTaxable
				END
				update data_SalePosDetail set StockRate = @StockRate where SalePosDetailID = @SaleDetailID
				if @isExchange=1
				begin
				set @Quantity=-1* @Quantity
				exec data_ProductInflow_Insert @ProductIntflowID output,@ItemId,@SaleDetailID,'POSEXCHANGE',@WHID, @SalePosDate ,@StockRate,@Quantity, 
				@Quantity,@FiscalID , @CompanyID , @IsTaxable
				exec tempInflowDataTable_Insert @ProductIntflowID ,'POSEXCHANGE'
				end
				else
				begin
				exec data_ProductOutflow_Insert @ProductOutflowID output,null,@ItemId,@SaleDetailID,'POS',@WHID, @SalePosDate ,@StockRate,@Quantity, 
				@FiscalID , @CompanyID , @IsTaxable , NULL, NULL, NULL, NULL, NULL, NULL, NULL
				, @RowID , @data_ItemBatchDetail
				exec tempOutflowDataTable_Insert @ProductOutflowID ,'POS'
				Update data_salePosDetail set StockRate=@StockRate where SalePOSDetailID=@SaleDetailID
				end
				
			END
	
	FETCH NEXT FROM Salecursor INTO @RowID
	END

close Salecursor
deallocate Salecursor


---========================== Sale Stock In Working End Here ======================

------------------------------Account Entry

declare @ISOfflineServer bit=0,@StylePOS nvarchar(50)=''

Select @StylePOS=POSStyle from gen_posConfiguration where CounterID=@CounterID

IF @StylePOS='POSPcWorldStyle'
BEGIN
Select  @ISOfflineServer=ISNULL(IsofflineServer,0) from gen_posConfiguration  where CounterID=@CounterID
END
ELSE 
BEGIN
Select  @ISOfflineServer=ISNULL(IsofflineServer,0) from gen_posConfiguration where WHID=@WHID
END


if @ISOfflineServer=1
begin

exec  data_SalePOSInfo_InsertAccountOffline @CounterID=@CounterID,@SalePosID = @SalePosID, @CompanyID = @CompanyID, @SalePosDate = @SalePosDate , @WHID = @WHID , 
@NetAmount = @NetAmount , @SaleInvoiceNo = @SaleInvoiceNo , @UserID = @UserID , @FiscalID = @FiscalID ,@EditMode = 1,
@AmountReceivable = @AmountReceivable,@data_SalePosDetail=@data_SalePosDetail

end
-----------------------------------





GO

/****** Object:  StoredProcedure [dbo].[data_SalePosReturnInfo_Insert]    Script Date: 6/13/2022 12:37:35 PM ******/
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
@SaleInvoiceNo int=0,
@MenuId int=0,
@InvoiceType int=0,
@CustomerID int=null,
@RiderAmount numeric(18,3)=0,
@LinckedBill int =NULL,
@SaleManId int =NULL,
@CounterID int=NULL,
@SalePosReturnID int=0 output
as
declare @returnSale bit=0
declare @IsTaxable bit =0
--declare @SalePosReturnID bigint=0
declare @SalePosReturnDetailID bigint=0
declare @SalePosDetailID bigint=0
declare @ISOfflineServer bit=0,@StylePOS nvarchar(50)

Select @StylePOS=POSStyle from gen_posConfiguration where CounterID=@CounterID

IF @StylePOS='POSPcWorldStyle'
BEGIN
Select  @ISOfflineServer=ISNULL(IsofflineServer,0) from gen_posConfiguration where CounterID=@CounterID
END
ELSE 
BEGIN
Select  @ISOfflineServer=ISNULL(IsofflineServer,0) from gen_posConfiguration where WHID=@WHID
END
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
	insert into @MaxTable
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
		MinQuantity , 
		IMEINumber
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
		MinQuantity, 
		IMEINumber

		From @data_SalePosDetail 
		
end





		 declare @productInflowID int
DECLARE @PractitionerId int,@StockRate numeric(18,3)=0
declare @PosSaleReturnDetailID int ,@PosStockRate numeric(14,5) , @PosQuantity numeric(10,2),@PosItemId int,@PosstockQty numeric(14,2),@ManufacturingID int=0, @RIMEINumber nvarchar(1000), @RIMEINumber1 nvarchar(1000), @RIMEINumber2 nvarchar(1000), @RIsBatchItem bit=0 , @Rdata_ItemBatchDetail  data_ItemBatchDetail
	
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
	@SalePosDetailID=SalePosDetailID , @RIMEINumber=IMEINumber
from data_SalePosReturnInfo inner join data_SalePosReturnDetail 
on data_SalePosReturnInfo.SalePosReturnID=data_SalePosReturnDetail.SalePosReturnID 
where data_SalePosReturnDetail.IsLog=0 and SalePosReturnDetailID=@PractitionerId

Select @RIsBatchItem=IsBatchItem from InventItems where ItemId=@PosItemId

Select @ManufacturingID=ManaufacturingID from data_SalePosDetail where SalePosDetailID=@SalePosDetailID

SET @RIMEINumber1 = NULL; SET @RIMEINumber2 = NULL;

IF @RIMEINumber IS NOT NULL AND @RIMEINumber <> ''
BEGIN
	IF CHARINDEX(',', @RIMEINumber) > 0
	BEGIN
		SET @RIMEINumber1 = Substring(
							@RIMEINumber, 
							1, 
							Charindex(',', @RIMEINumber)-1
							);
		SET @RIMEINumber2 = Substring(
							@RIMEINumber, 
							Charindex(',', @RIMEINumber)+1, 
							LEN(@RIMEINumber)-Charindex(',', @RIMEINumber)
							);
	END
	ELSE
	BEGIN
		SET @RIMEINumber1 = @RIMEINumber;
	END
		
END
	
IF @RIsBatchItem = 1 AND @RIMEINumber1 IS NOT NULL
BEGIN
	INSERT INTO @Rdata_ItemBatchDetail (RowID, Quantity, Param1, Param2, Param3)
	SELECT @PractitionerId , @PosQuantity, @RIMEINumber1, @RIMEINumber2, NULL
END

	--watch this
	exec data_ProductInflow_Insert @productInflowID out,@PosItemId,@PosSaleReturnDetailID,'POS RETURN',@WHID, @SalePosDate , 
				@PosStockRate,@PosQuantity,@PosQuantity,@FiscalID , @CompanyID ,@IsTaxable, NULL, NULL, NULL, NULL, NULL, NULL, NULL
				, @PractitionerId , @Rdata_ItemBatchDetail
				exec tempInflowDataTable_Insert @productInflowID , 'POS RETURN'
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



if @ISOfflineServer=1
begin

exec  data_SalePOSReturnInfo_InsertAccountOffline @CounterID=@CounterID,@SalePosReturnID=@SalePosReturnID, @SalePosID = @SalePosID, @CompanyID = @CompanyID, @SalePosDate = @SalePosDate , @WHID = @WHID , 
@NetAmount = @NetAmount , @SaleInvoiceNo = @SaleInvoiceNo , @UserID = @UserID , @FiscalID = @FiscalID ,@EditMode = 0,
 @AmountReceivable = @NetAmount,@data_SalePosDetail=@data_SalePosDetail

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



GO

/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_SelectAll]    Script Date: 6/13/2022 12:37:35 PM ******/
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
@SaleDate date=null,
@MenuId int=0,
@CounterID int=0

as

declare @ReturnSaleID bigint
if @MenuId>0
begin
select @ReturnSaleID=SalePosID from data_SalePosInfo where SalePosNo=@InvoiceNo and SalePosDate=@SaleDate and MenuId=@MenuId
end
else if @CounterID>0
begin
select @ReturnSaleID=SalePosID from data_SalePosInfo where SalePosNo=@InvoiceNo and SalePosDate=@SaleDate and CounterID=@CounterID
end
else
begin

select @ReturnSaleID=SalePosID from data_SalePosInfo where SalePosNo=@InvoiceNo and SalePosDate=@SaleDate 



end
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
		set @WhereClause=' where data_SalePosInfo.SalePOSNo='+cast(@InvoiceNo as nvarchar(10))
		set @WhereClause=Cast(@WhereClause as nvarchar(4000)) +' and data_SalePosInfo.SalePOSDate='''+cast(@SaleDate as nvarchar(50))+''''
		if @MenuId>0
		begin
		set @WhereClause=Cast(@WhereClause as nvarchar(4000)) +' and data_SalePosInfo.MenuID='''+cast(@MenuId as nvarchar(50))+''''
		end
		if @CounterID>0
		begin
		set @WhereClause=Cast(@WhereClause as nvarchar(4000)) +' and data_SalePosInfo.CounterID='''+cast(@CounterID as nvarchar(50))+''''
		end
		print @whereClause
		exec('select data_SalePosInfo.*,b.SalePOSNo as LinkedBillNo from data_SalePosInfo left join data_SalePosInfo b on b.SalePosID=data_SalePosInfo.LinckedBill '+ @WhereClause)
		exec('select InventItems.ItemNumber,InventItems.ItenName, InventItems.IsBatchItem , data_SalePosDetail.* from data_SalePosDetail inner join InventItems on data_SalePosDetail.ItemId=InventItems.ItemId inner join data_SalePosInfo on data_salePosInfo.SalePosID=data_salePosDetail.SalePosID '+ @WhereClause)
	end
	else
	begin
		set @WhereClause=' where LogSourceID=0 and SalePosReturnID='+cast(@ReturnSaleID as nvarchar(10))
		set @WhereClauseDetail=' where IsLog=0 and SalePosReturnID='+cast(@ReturnSaleID as nvarchar(10))
		if @MenuId>0
		begin
		set @WhereClause=Cast(@WhereClause as nvarchar(4000)) +' and MenuID='''+cast(@MenuId as nvarchar(50))+''''
		end
		if @CounterID>0
		begin
		set @WhereClause=Cast(@WhereClause as nvarchar(4000)) +' and data_SalePosReturnInfo.CounterID='''+cast(@CounterID as nvarchar(50))+''''
		end
		exec('select * from data_SalePosReturnInfo '+ @WhereClause)
		exec('select InventItems.ItemNumber, InventItems.ItenName, InventItems.IsBatchItem , data_SalePosReturnDetail.* from data_SalePosReturnDetail inner join InventItems on data_SalePosReturnDetail.ItemId=InventItems.ItemId '+ @WhereClauseDetail)
	end
	








GO


