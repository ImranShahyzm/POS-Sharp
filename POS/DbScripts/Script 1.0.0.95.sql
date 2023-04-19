IF NOT EXISTS (SELECT 1 FROM sys.columns 
				WHERE name = N'MaxDiscountPercentage' 
				and object_id = object_id(N'dbo.data_SalePosReturnDetail'))
BEGIN
BEGIN TRANSACTION
	ALTER TABLE dbo.data_SalePosReturnDetail ADD
	MaxDiscountPercentage numeric(18, 3) NULL
COMMIT
END
GO



IF NOT EXISTS (SELECT 1 FROM sys.columns 
				WHERE name = N'MaxDiscountPercentage' 
				and object_id = object_id(N'dbo.data_SalePosDetail'))
BEGIN
BEGIN TRANSACTION
	ALTER TABLE dbo.data_SalePosDetail ADD
	MaxDiscountPercentage numeric(18, 3) NULL
COMMIT
END
GO
/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Update]    Script Date: 04/19/2023 11:32:16 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePosInfo_Update]
GO
/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Cancel]    Script Date: 04/19/2023 11:29:42 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_Cancel]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePosInfo_Cancel]
GO

/****** Object:  StoredProcedure [dbo].[data_SalePOSReturnInfo_InsertAccountOffline]    Script Date: 04/19/2023 11:27:59 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePOSReturnInfo_InsertAccountOffline]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePOSReturnInfo_InsertAccountOffline]
GO
/****** Object:  StoredProcedure [dbo].[data_SalePOSInfo_InsertAccountOffline]    Script Date: 04/19/2023 11:27:59 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePOSInfo_InsertAccountOffline]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePOSInfo_InsertAccountOffline]
GO
/****** Object:  StoredProcedure [dbo].[data_SalePosReturnInfo_Insert]    Script Date: 04/19/2023 11:23:32 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosReturnInfo_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePosReturnInfo_Insert]
GO
/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Insert]    Script Date: 04/19/2023 11:23:32 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePosInfo_Insert]
GO
/****** Object:  View [dbo].[vw_KhaakiPromoonAll]    Script Date: 04/19/2023 11:23:32 AM ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_KhaakiPromoonAll]'))
DROP VIEW [dbo].[vw_KhaakiPromoonAll]
GO
/****** Object:  View [dbo].[vw_KhaakiPromo]    Script Date: 04/19/2023 11:23:32 AM ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_KhaakiPromo]'))
DROP VIEW [dbo].[vw_KhaakiPromo]
GO
/****** Object:  UserDefinedTableType [dbo].[data_SalePosDetail]    Script Date: 04/19/2023 11:23:32 AM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_SalePosDetail' AND ss.name = N'dbo')
DROP TYPE [dbo].[data_SalePosDetail]
GO
/****** Object:  UserDefinedTableType [dbo].[data_SalePosDetail]    Script Date: 04/19/2023 11:23:32 AM ******/
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
	[IMEINumber] [nvarchar](1000) NULL,
	[Remarks] [nvarchar](1000) NULL,
	[MaxDiscountPercentage] [numeric](18, 3) NULL
)
GO
/****** Object:  View [dbo].[vw_KhaakiPromo]    Script Date: 04/19/2023 11:23:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_KhaakiPromo]'))
EXEC dbo.sp_executesql @statement = N'

CREATE VIEW [dbo].[vw_KhaakiPromo]
AS
SELECT        SchemeID, PromoName, PromoPercentage, BookingStartDate, BookingEndDate, StartTime, EndTime, ItemId, Qauntity, WHID, AdditionPercentage
FROM            (SELECT        dbo.gen_Pes_SchemeInfo.PromoPercentage, dbo.gen_Pes_SchemeInfo.SchemeID, dbo.gen_Pes_SchemeInfo.Title AS PromoName, dbo.gen_Pes_SchemeInfo.BookingStartDate, 
                                                    dbo.gen_Pes_SchemeInfo.BookingEndDate, dbo.gen_Pes_SchemeInfo.StartTime, dbo.gen_Pes_SchemeInfo.EndTime, PromoDetail.ItemId, dbo.gen_Pes_SchemeInfo.BaseQuantity AS Qauntity, 
                                                    dbo.gen_Pes_SchemeInfo.WHID, PromoDetail.DiscountPercentage AS AdditionPercentage
                          FROM            dbo.gen_Pes_SchemeInfo LEFT OUTER JOIN
                                                    dbo.gen_Pes_SchemeDetail AS PromoDetail ON PromoDetail.SchemeID = dbo.gen_Pes_SchemeInfo.SchemeID
                          WHERE        (dbo.gen_Pes_SchemeInfo.ApplicableOnAll = 1)) AS temp
' 
GO
/****** Object:  View [dbo].[vw_KhaakiPromoonAll]    Script Date: 04/19/2023 11:23:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_KhaakiPromoonAll]'))
EXEC dbo.sp_executesql @statement = N'

CREATE VIEW [dbo].[vw_KhaakiPromoonAll]
AS
SELECT        SchemeID, PromoName, PromoPercentage, BookingStartDate, BookingEndDate, StartTime, EndTime,  Qauntity, WHID, AdditionPercentage
FROM            (SELECT        dbo.gen_Pes_SchemeInfo.PromoPercentage, dbo.gen_Pes_SchemeInfo.SchemeID, dbo.gen_Pes_SchemeInfo.Title AS PromoName, dbo.gen_Pes_SchemeInfo.BookingStartDate, 
                                                    dbo.gen_Pes_SchemeInfo.BookingEndDate, dbo.gen_Pes_SchemeInfo.StartTime, dbo.gen_Pes_SchemeInfo.EndTime, dbo.gen_Pes_SchemeInfo.BaseQuantity AS Qauntity, 
                                                    dbo.gen_Pes_SchemeInfo.WHID, PromoPercentage AS AdditionPercentage
                          FROM            dbo.gen_Pes_SchemeInfo 
                                                   
                          WHERE        (dbo.gen_Pes_SchemeInfo.ApplicableOnAll = 1)) AS temp

' 
GO
/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Insert]    Script Date: 04/19/2023 11:23:32 AM ******/
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
		IMEINumber,
		MaxDiscountPercentage
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
		IMEINumber,
		MaxDiscountPercentage

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
		InvoiceType,
		CounterID
		
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
		@InvoiceType,
		@CounterID
		
		)
	set @SalePosReturnID = SCOPE_IDENTITY()

	--Checking Total Cash Remaining 
DECLARE @Amount decimal(18,2)=0 
select @Amount=(select isnull(sum(Amount),0) as Amount from data_CashIn where Date=cast(GETDATE() as date))
-
(select isnull(sum(Amount),0) as Amount from data_CashOut where Date=cast(GETDATE() as date)) 
--select  @Amount
declare @ErrorMessage nvarchar(1000),@RemarksonDirectReturn nvarchar(Max)='Direct Sale Return'
if	@Amount>=@AmountPayable
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
/****** Object:  StoredProcedure [dbo].[data_SalePosReturnInfo_Insert]    Script Date: 04/19/2023 11:23:32 AM ******/
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
			if	@Amount>=@AmountPayable
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


/****** Object:  StoredProcedure [dbo].[data_SalePOSInfo_InsertAccountOffline]    Script Date: 04/19/2023 11:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePOSInfo_InsertAccountOffline]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_SalePOSInfo_InsertAccountOffline] AS' 
END
GO










ALTER PROCEDURE [dbo].[data_SalePOSInfo_InsertAccountOffline] 
@UserID INT = NULL , 
@CompanyID INT = NULL , 
@FiscalID INT = NULL ,
@SalePosDate	DATE	=NULL,
@WHID	INT	=NULL,
@TaxAmount			DECIMAL(18, 2)	=NULL,
@GrossAmount		DECIMAL(18, 2)	=NULL,
@DiscountPercentage	DECIMAL(18, 2)	=NULL,
@DiscountAmount		DECIMAL(18, 2)	=NULL,
@DiscountTotal		DECIMAL(18, 2)	=NULL,
@OtherCharges		DECIMAL(18, 2)	=NULL,
@NetAmount			DECIMAL(18, 2)	=NULL,
@AmountReceive		DECIMAL(18, 2)	=NULL,
@AmountReturn		DECIMAL(18, 2)	=NULL,
@AmountInAccount	DECIMAL(18, 2)	=NULL,
@AmountReceivable	DECIMAL(18, 2)	=NULL,
@AmountPayable		DECIMAL(18, 2)	=NULL,
@DirectReturn	BIT=0,
@data_SalePosDetail  data_SalePosDetail   READONLY,
@SalePosID BIGINT OUTPUT,
@CustomerPhone NVARCHAR(50)=NULL,
@CustomerName  NVARCHAR(50)=NULL,
@SaleInvoiceNo INT=0,
@ExchangeAmount NUMERIC(18, 3) =NULL,
@MenuId INT =NULL,
@InvoiceType INT= NULL,
@CardNumber NVARCHAR(MAX)=NULL,
@CardName NVARCHAR(1000)=NULL,
@CashPayment NUMERIC(18, 3)=NULL,
@CardPayment NUMERIC(18, 3)=NULL,
@SaleManId INT=NULL,
@CustomerID INT=NULL,
@RiderAmount NUMERIC(18,3)=0,
@LinckedBill INT =NULL,
@CounterID INT=NULL,
@EditMode BIT=0


AS 

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
SELECT @CashAccount=CashAccountPOS FROM gen_posConfiguration WHERE WHID=@WHID

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
ELSE
BEGIN
	SET @vID = 0	
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
	INSERT INTO @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,cr)
	SELECT StockAccount , DTypeID,DvaluesID,@MasterDescription ,StockAmount FROM #temp
	END

if @SaleAmount>0
	begin
	insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,cr)
	select SaleAccount , DTypeID,DvaluesID,@MasterDescription ,DtSoldAmount from #temp
	end
INSERT INTO @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
VALUES(@CashAccount,0,0,@MasterDescription, @AmountReceivable)





SELECT @DrTotal=SUM(dr),@CrTotal=SUM(cr) FROM @GLvDetail
	IF @DrTotal - @CrTotal > 0
	BEGIN
		INSERT INTO @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,cr)
		VALUES(@RoundingAccount,0,0,@MasterDescription,@DrTotal - @CrTotal)

	END
	ELSE IF  @DrTotal - @CrTotal < 0
	BEGIN
		INSERT INTO @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
		VALUES(@RoundingAccount,0,0,@MasterDescription, @CrTotal - @DrTotal)

	END

SET @Total = @NetAmount + @StockAmount




EXEC GLvMAIN_Insert  @GLvDetail=@GLvDetail , @vID = @vID OUTPUT ,@vType =@vType ,@vNO = @VoucherNo , @vDate = @SalePosDate ,@vremarks =@MasterDescription ,@FiscalID = @FiscalID , @Comp_Id =@CompanyID,
	 @vUserID=@UserID,@TotalDr = @Total , @TotalCr = @Total , @ReadOnly = 1, @BranchID=NULL,@IsTaxable = 0

	 UPDATE data_SalePosInfo SET AccountVoucherID = @vID WHERE SALEPOSID = @SALEPOSID




















GO
/****** Object:  StoredProcedure [dbo].[data_SalePOSReturnInfo_InsertAccountOffline]    Script Date: 04/19/2023 11:27:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePOSReturnInfo_InsertAccountOffline]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_SalePOSReturnInfo_InsertAccountOffline] AS' 
END
GO



ALTER PROCEDURE [dbo].[data_SalePOSReturnInfo_InsertAccountOffline] 
@UserID INT = NULL , 
@CompanyID INT = NULL , 
@FiscalID INT = NULL ,
@SalePosDate	DATE	=NULL,
@WHID	INT	=NULL,
@TaxAmount			DECIMAL(18, 2)	=NULL,
@GrossAmount		DECIMAL(18, 2)	=NULL,
@DiscountPercentage	DECIMAL(18, 2)	=NULL,
@DiscountAmount		DECIMAL(18, 2)	=NULL,
@DiscountTotal		DECIMAL(18, 2)	=NULL,
@OtherCharges		DECIMAL(18, 2)	=NULL,
@NetAmount			DECIMAL(18, 2)	=NULL,
@AmountReceive		DECIMAL(18, 2)	=NULL,
@AmountReturn		DECIMAL(18, 2)	=NULL,
@AmountInAccount	DECIMAL(18, 2)	=NULL,
@AmountReceivable	DECIMAL(18, 2)	=NULL,
@AmountPayable		DECIMAL(18, 2)	=NULL,
@DirectReturn	BIT=0,
@data_SalePosDetail  data_SalePosDetail   READONLY,
@SalePosID BIGINT =0,
@SalePosReturnID INT=0,
@CustomerPhone NVARCHAR(50)=NULL,
@CustomerName  NVARCHAR(50)=NULL,
@SaleInvoiceNo INT=0,
@ExchangeAmount NUMERIC(18, 3) =NULL,
@MenuId INT =NULL,
@InvoiceType INT= NULL,
@CardNumber NVARCHAR(MAX)=NULL,
@CardName NVARCHAR(1000)=NULL,
@CashPayment NUMERIC(18, 3)=NULL,
@CardPayment NUMERIC(18, 3)=NULL,
@SaleManId INT=NULL,
@CustomerID INT=NULL,
@RiderAmount NUMERIC(18,3)=0,
@LinckedBill INT =NULL,
@CounterID INT=NULL,
@EditMode BIT=0


AS 

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
SELECT @CashAccount=CashAccountPOS FROM gen_posConfiguration WHERE WHID=@WHID

END
if @SaleInvoiceNo>0
begin
set @MasterDescription = 'POS Sale Voucher No ' + CONVERT(varchar, @SaleInvoiceNo)
end
ELSE 
BEGIN
SET @MasterDescription = 'Direct Sale Return ' 
END
select
		 @MasterDescription += ' and Return of ' + STUFF((select ',' 		  
		+ CONVERT(varchar(10),CONVERT(numeric(18,0),Quantity))+' '  + ItenName +'@'+CONVERT(varchar(10),CONVERT(numeric(18,0), ItemRate)) --+ ','
		From @data_SalePosDetail as D join InventItems on InventItems.ItemId=D.ItemId  FOR XML PATH('')),1,1,'')
declare @SaleAmount numeric(18, 3) ,@StockAmount numeric(18,3)

if @EditMode = 1
BEGIN
	select @vID = AccountVoucherID from data_SalePosReturnInfo where SalePosReturnID = @SalePosReturnID 	
END
ELSE
BEGIN
	SET @vID = 0	
	--exec GLvMAIN_MaxVoucherNo @CompanyID,@vType, @VoucherNo output , @FiscalID,@IsTaxable,@vDate
END





	select sum(p.TotalAmount) as DtSoldAmount,InventCategory.StockAccount,InventCategory.CGSAccount,InventCategory.SaleAccount , 0 as DTypeID,0 as DvaluesID,sum(p.Quantity * isnull(p.StockRate,0)) AS StockAmount into #temp
	from data_SalePosReturnDetail p join InventItems on p.ItemId = InventItems.ItemId join InventCategory on InventItems.CategoryID = InventCategory.CategoryID
	
	 where SalePosReturnID=@SalePosReturnID
	group by InventCategory.CategoryID,InventCategory.StockAccount,InventCategory.CGSAccount,InventCategory.SaleAccount

	select @StockAmount = sum(StockAmount) from #temp
	SELECT @SaleAmount = SUM(DtSoldAmount) FROM #temp
	IF @StockAmount>0
	BEGIN
	INSERT INTO @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
	SELECT StockAccount , DTypeID,DvaluesID,@MasterDescription ,StockAmount FROM #temp

	INSERT INTO @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,cr)
	SELECT CGSAccount , DTypeID,DvaluesID,@MasterDescription ,StockAmount FROM #temp
	END
	IF @SaleAmount>0
	BEGIN
	INSERT INTO @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
	SELECT SaleAccount , DTypeID,DvaluesID,@MasterDescription ,DtSoldAmount FROM #temp
	END
INSERT INTO @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,cr)
VALUES(@CashAccount,0,0,@MasterDescription, @AmountReceivable)





SELECT @DrTotal=SUM(dr),@CrTotal=SUM(cr) FROM @GLvDetail
	IF @DrTotal - @CrTotal > 0
	BEGIN
		INSERT INTO @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,cr)
		VALUES(@RoundingAccount,0,0,@MasterDescription,@DrTotal - @CrTotal)

	END
	ELSE IF  @DrTotal - @CrTotal < 0
	BEGIN
		INSERT INTO @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
		VALUES(@RoundingAccount,0,0,@MasterDescription, @CrTotal - @DrTotal)

	END

SET @Total = @NetAmount + @StockAmount




EXEC GLvMAIN_Insert  @GLvDetail=@GLvDetail , @vID = @vID OUTPUT ,@vType =@vType ,@vNO = @VoucherNo , @vDate = @SalePosDate ,@vremarks =@MasterDescription ,@FiscalID = @FiscalID , @Comp_Id =@CompanyID,
	 @vUserID=@UserID,@TotalDr = @Total , @TotalCr = @Total , @ReadOnly = 1, @BranchID=NULL,@IsTaxable = 0

	 UPDATE data_SalePosReturnInfo SET AccountVoucherID = @vID WHERE SalePOsReturnID = @SalePOSReturnID





GO

/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Cancel]    Script Date: 04/19/2023 11:29:42 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_Cancel]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_SalePosInfo_Cancel] AS' 
END
GO




ALTER PROCEDURE[dbo].[data_SalePosInfo_Cancel]
@UserID INT = NULL , 
@CompanyID INT = NULL , 
@FiscalID INT = NULL ,
@SalePosDate DATE = NULL,
@WHID   INT	=NULL,
@TaxAmount DECIMAL (18, 2)	=NULL,
@GrossAmount DECIMAL (18, 2)	=NULL,
@DiscountPercentage DECIMAL (18, 2)	=NULL,
@DiscountAmount DECIMAL (18, 2)	=NULL,
@DiscountTotal DECIMAL (18, 2)	=NULL,
@OtherCharges DECIMAL (18, 2)	=NULL,
@NetAmount DECIMAL (18, 2)	=NULL,
@AmountReceive DECIMAL (18, 2)	=NULL,
@AmountReturn DECIMAL (18, 2)	=NULL,
@AmountInAccount DECIMAL (18, 2)	=NULL,
@AmountReceivable DECIMAL (18, 2)	=NULL,
@AmountPayable DECIMAL (18, 2)	=NULL,
@DirectReturn BIT = 0,
@data_SalePosDetail  data_SalePosDetail READONLY,
@SalePosID BIGINT OUTPUT,
@CustomerPhone NVARCHAR(50)=NULL,
@CustomerName NVARCHAR(50)=NULL,
@SaleInvoiceNo INT=0,
@ExchangeAmount NUMERIC(18, 3) =NULL,
@MenuId INT =NULL,
@InvoiceType INT= NULL,
@CardNumber NVARCHAR(MAX)=NULL,
@CardName NVARCHAR(1000)=NULL,
@CashPayment NUMERIC(18, 3)=NULL,
@CardPayment NUMERIC(18, 3)=NULL,
@SaleManId INT=NULL

AS
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
		
END

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
WHILE @@FETCH_STATUS = 0
	BEGIN

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

        INSERT INTO data_SalePosDetail(
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

        ) SELECT
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


        FROM @data_SalePosDetail WHERE RowID = @RowID


        SET @SaleDetailID = @@IDENTITY		

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

CLOSE Salecursor
DEALLOCATE Salecursor

---========================== Sale Stock In Working End Here =============================







GO



/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Update]    Script Date: 04/19/2023 11:32:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_SalePosInfo_Update] AS' 
END
GO




ALTER PROCEDURE [dbo].[data_SalePosInfo_Update] 
@UserID INT = NULL , 
@CompanyID INT = NULL , 
@FiscalID INT = NULL ,
@SalePosDate	DATE	=NULL,
@WHID	INT	=NULL,
@TaxAmount			DECIMAL(18, 2)	=NULL,
@GrossAmount		DECIMAL(18, 2)	=NULL,
@DiscountPercentage	DECIMAL(18, 2)	=NULL,
@DiscountAmount		DECIMAL(18, 2)	=NULL,
@DiscountTotal		DECIMAL(18, 2)	=NULL,
@OtherCharges		DECIMAL(18, 2)	=NULL,
@NetAmount			DECIMAL(18, 2)	=NULL,
@AmountReceive		DECIMAL(18, 2)	=NULL,
@AmountReturn		DECIMAL(18, 2)	=NULL,
@AmountInAccount	DECIMAL(18, 2)	=NULL,
@AmountReceivable	DECIMAL(18, 2)	=NULL,
@AmountPayable		DECIMAL(18, 2)	=NULL,
@DirectReturn	BIT=0,
@data_SalePosDetail  data_SalePosDetail   READONLY,
@SalePosID BIGINT OUTPUT,
@CustomerPhone NVARCHAR(50)=NULL,
@CustomerName  NVARCHAR(50)=NULL,
@SaleInvoiceNo INT=0,
@ExchangeAmount NUMERIC(18, 3) =NULL,
@MenuId INT =NULL,
@InvoiceType INT= NULL,
@CardNumber NVARCHAR(MAX)=NULL,
@CardName NVARCHAR(1000)=NULL,
@CashPayment NUMERIC(18, 3)=NULL,
@CardPayment NUMERIC(18, 3)=NULL,
@SaleManId INT=NULL,
@CustomerID INT=NULL,
@RiderAmount NUMERIC(18,3)=0,
@LinckedBill INT =NULL,
@CounterID INT=NULL,
@SalePosReturnID INT=0 OUTPUT


AS
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
		IF @RiderAmount>0
	BEGIN
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
		END
		

---========== Sale End Here ================
---========================== Sale Stock In Working Start Here =============================
		
END

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
WHILE @@FETCH_STATUS = 0
	BEGIN

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
			SET @IMEINumber2 = SUBSTRING(
								@IMEINumber, 
								CHARINDEX(',', @IMEINumber)+1, 
								LEN(@IMEINumber)-CHARINDEX(',', @IMEINumber)
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
EXEC data_ManufacturingInfo_Insert @ManufacturingID=@ManufacturingID OUTPUT,@UserID=@UserID,@CompanyID=@CompanyID,@FiscalID=@FiscalID,@BomId=@BomId,@ItemId=@ItemId,@ManufacturingDate=@SalePosDate,@Quantity=@Quantity,@WHID=@WHID,@ManufacturingStyle='STYLE 1',@IsTaxable=@IsTaxable,@data_ManufacturingDetail=@data_ManufacturingDetail,@data_ItemBatchDetail=@data_ItemBatchDetail,@data_ItemBatchDetailFinish=@data_ItemBatchDetailFinish,@LooseQuantity=@Quantity		
END

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

				IF @ERRORMSG != ''
				BEGIN
					RAISERROR (@ERRORMSG , 16, 1 ) ;
					RETURN
				END
			END
			ELSE
			BEGIN
				exec GetStockQuantity @ItemId ,@WHID , @SalePosDate , @stockQty output , @ItemName out , @CompanyID , '' , '' , 
				null , null , null , @IsBatchItem , @IsTaxable
				IF ( @stockQty < @Quantity )
				BEGIN
						set @ERRORMSG = 'Stock is not enough of Item ' + @ItemName + ' Avaliable Stock '+  convert(varchar, @stockQty)	 + ' Required Quantity is ' + convert(varchar, @Quantity)	
						RAISERROR (@ERRORMSG , 16, 1 ) ;
						RETURN
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
		IMEINumber,
		Remarks
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
		IMEINumber,
		Remarks

		From @data_SalePosDetail where RowID = @RowID
		
		set @SaleDetailID = @@IDENTITY		

		declare @ProductOutflowID int
			IF @MainTainInventory = 1 
			BEGIN		
				BEGIN
					exec GetWeightedRateForItem @ItemId, @WHID ,@SalePosDate ,@SalePosDate ,@StockRate output , @CompanyID , @IsTaxable
				END
				update data_SalePosDetail set StockRate = @StockRate where SalePosDetailID = @SaleDetailID
				IF @isExchange=1
				begin
				set @Quantity=-1* @Quantity
				exec data_ProductInflow_Insert @ProductIntflowID output,@ItemId,@SaleDetailID,'POSEXCHANGE',@WHID, @SalePosDate ,@StockRate,@Quantity, 
				@Quantity,@FiscalID , @CompanyID , @IsTaxable
				EXEC tempInflowDataTable_Insert @ProductIntflowID ,'POSEXCHANGE'
				END
				ELSE
				BEGIN
				EXEC data_ProductOutflow_Insert @ProductOutflowID OUTPUT,NULL,@ItemId,@SaleDetailID,'POS',@WHID, @SalePosDate ,@StockRate,@Quantity, 
				@FiscalID , @CompanyID , @IsTaxable , NULL, NULL, NULL, NULL, NULL, NULL, NULL
				, @RowID , @data_ItemBatchDetail
				EXEC tempOutflowDataTable_Insert @ProductOutflowID ,'POS'
				UPDATE data_salePosDetail SET StockRate=@StockRate WHERE SalePOSDetailID=@SaleDetailID
				END
				
			END
	
	FETCH NEXT FROM Salecursor INTO @RowID
	END

CLOSE Salecursor
DEALLOCATE Salecursor


---========================== Sale Stock In Working End Here ======================

------------------------------Account Entry

DECLARE @ISOfflineServer BIT=0,@StylePOS NVARCHAR(50)=''

SELECT @StylePOS=POSStyle FROM gen_posConfiguration WHERE CounterID=@CounterID

IF @StylePOS='POSPcWorldStyle'
BEGIN
SELECT  @ISOfflineServer=ISNULL(IsofflineServer,0) FROM gen_posConfiguration  WHERE CounterID=@CounterID
END
ELSE 
BEGIN
SELECT  @ISOfflineServer=ISNULL(IsofflineServer,0) FROM gen_posConfiguration WHERE WHID=@WHID
END


IF @ISOfflineServer=1
BEGIN

EXEC  data_SalePOSInfo_InsertAccountOffline @CounterID=@CounterID,@SalePosID = @SalePosID, @CompanyID = @CompanyID, @SalePosDate = @SalePosDate , @WHID = @WHID , 
@NetAmount = @NetAmount , @SaleInvoiceNo = @SaleInvoiceNo , @UserID = @UserID , @FiscalID = @FiscalID ,@EditMode = 1,
@AmountReceivable = @AmountReceivable,@data_SalePosDetail=@data_SalePosDetail

END
-----------------------------------







GO















Alter procedure [dbo].[data_SalePosReturnInfo_Insert] 
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
		IMEINumber,
		MaxDiscountPercentage
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
		IMEINumber,
		MaxDiscountPercentage
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
			if	@Amount>=@AmountPayable
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




Alter PROCEDURE [dbo].[data_SalePosInfo_Update] 
@UserID INT = NULL , 
@CompanyID INT = NULL , 
@FiscalID INT = NULL ,
@SalePosDate	DATE	=NULL,
@WHID	INT	=NULL,
@TaxAmount			DECIMAL(18, 2)	=NULL,
@GrossAmount		DECIMAL(18, 2)	=NULL,
@DiscountPercentage	DECIMAL(18, 2)	=NULL,
@DiscountAmount		DECIMAL(18, 2)	=NULL,
@DiscountTotal		DECIMAL(18, 2)	=NULL,
@OtherCharges		DECIMAL(18, 2)	=NULL,
@NetAmount			DECIMAL(18, 2)	=NULL,
@AmountReceive		DECIMAL(18, 2)	=NULL,
@AmountReturn		DECIMAL(18, 2)	=NULL,
@AmountInAccount	DECIMAL(18, 2)	=NULL,
@AmountReceivable	DECIMAL(18, 2)	=NULL,
@AmountPayable		DECIMAL(18, 2)	=NULL,
@DirectReturn	BIT=0,
@data_SalePosDetail  data_SalePosDetail   READONLY,
@SalePosID BIGINT OUTPUT,
@CustomerPhone NVARCHAR(50)=NULL,
@CustomerName  NVARCHAR(50)=NULL,
@SaleInvoiceNo INT=0,
@ExchangeAmount NUMERIC(18, 3) =NULL,
@MenuId INT =NULL,
@InvoiceType INT= NULL,
@CardNumber NVARCHAR(MAX)=NULL,
@CardName NVARCHAR(1000)=NULL,
@CashPayment NUMERIC(18, 3)=NULL,
@CardPayment NUMERIC(18, 3)=NULL,
@SaleManId INT=NULL,
@CustomerID INT=NULL,
@RiderAmount NUMERIC(18,3)=0,
@LinckedBill INT =NULL,
@CounterID INT=NULL,
@SalePosReturnID INT=0 OUTPUT


AS
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
		IF @RiderAmount>0
	BEGIN
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
		END
		

---========== Sale End Here ================
---========================== Sale Stock In Working Start Here =============================
		
END

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
WHILE @@FETCH_STATUS = 0
	BEGIN

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
			SET @IMEINumber2 = SUBSTRING(
								@IMEINumber, 
								CHARINDEX(',', @IMEINumber)+1, 
								LEN(@IMEINumber)-CHARINDEX(',', @IMEINumber)
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
EXEC data_ManufacturingInfo_Insert @ManufacturingID=@ManufacturingID OUTPUT,@UserID=@UserID,@CompanyID=@CompanyID,@FiscalID=@FiscalID,@BomId=@BomId,@ItemId=@ItemId,@ManufacturingDate=@SalePosDate,@Quantity=@Quantity,@WHID=@WHID,@ManufacturingStyle='STYLE 1',@IsTaxable=@IsTaxable,@data_ManufacturingDetail=@data_ManufacturingDetail,@data_ItemBatchDetail=@data_ItemBatchDetail,@data_ItemBatchDetailFinish=@data_ItemBatchDetailFinish,@LooseQuantity=@Quantity		
END

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

				IF @ERRORMSG != ''
				BEGIN
					RAISERROR (@ERRORMSG , 16, 1 ) ;
					RETURN
				END
			END
			ELSE
			BEGIN
				exec GetStockQuantity @ItemId ,@WHID , @SalePosDate , @stockQty output , @ItemName out , @CompanyID , '' , '' , 
				null , null , null , @IsBatchItem , @IsTaxable
				IF ( @stockQty < @Quantity )
				BEGIN
						set @ERRORMSG = 'Stock is not enough of Item ' + @ItemName + ' Avaliable Stock '+  convert(varchar, @stockQty)	 + ' Required Quantity is ' + convert(varchar, @Quantity)	
						RAISERROR (@ERRORMSG , 16, 1 ) ;
						RETURN
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
		IMEINumber,
		Remarks,
		MaxDiscountPercentage
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
		IMEINumber,
		Remarks,
		MaxDiscountPercentage

		From @data_SalePosDetail where RowID = @RowID
		
		set @SaleDetailID = @@IDENTITY		

		declare @ProductOutflowID int
			IF @MainTainInventory = 1 
			BEGIN		
				BEGIN
					exec GetWeightedRateForItem @ItemId, @WHID ,@SalePosDate ,@SalePosDate ,@StockRate output , @CompanyID , @IsTaxable
				END
				update data_SalePosDetail set StockRate = @StockRate where SalePosDetailID = @SaleDetailID
				IF @isExchange=1
				begin
				set @Quantity=-1* @Quantity
				exec data_ProductInflow_Insert @ProductIntflowID output,@ItemId,@SaleDetailID,'POSEXCHANGE',@WHID, @SalePosDate ,@StockRate,@Quantity, 
				@Quantity,@FiscalID , @CompanyID , @IsTaxable
				EXEC tempInflowDataTable_Insert @ProductIntflowID ,'POSEXCHANGE'
				END
				ELSE
				BEGIN
				EXEC data_ProductOutflow_Insert @ProductOutflowID OUTPUT,NULL,@ItemId,@SaleDetailID,'POS',@WHID, @SalePosDate ,@StockRate,@Quantity, 
				@FiscalID , @CompanyID , @IsTaxable , NULL, NULL, NULL, NULL, NULL, NULL, NULL
				, @RowID , @data_ItemBatchDetail
				EXEC tempOutflowDataTable_Insert @ProductOutflowID ,'POS'
				UPDATE data_salePosDetail SET StockRate=@StockRate WHERE SalePOSDetailID=@SaleDetailID
				END
				
			END
	
	FETCH NEXT FROM Salecursor INTO @RowID
	END

CLOSE Salecursor
DEALLOCATE Salecursor


---========================== Sale Stock In Working End Here ======================

------------------------------Account Entry

DECLARE @ISOfflineServer BIT=0,@StylePOS NVARCHAR(50)=''

SELECT @StylePOS=POSStyle FROM gen_posConfiguration WHERE CounterID=@CounterID

IF @StylePOS='POSPcWorldStyle'
BEGIN
SELECT  @ISOfflineServer=ISNULL(IsofflineServer,0) FROM gen_posConfiguration  WHERE CounterID=@CounterID
END
ELSE 
BEGIN
SELECT  @ISOfflineServer=ISNULL(IsofflineServer,0) FROM gen_posConfiguration WHERE WHID=@WHID
END


IF @ISOfflineServer=1
BEGIN

EXEC  data_SalePOSInfo_InsertAccountOffline @CounterID=@CounterID,@SalePosID = @SalePosID, @CompanyID = @CompanyID, @SalePosDate = @SalePosDate , @WHID = @WHID , 
@NetAmount = @NetAmount , @SaleInvoiceNo = @SaleInvoiceNo , @UserID = @UserID , @FiscalID = @FiscalID ,@EditMode = 1,
@AmountReceivable = @AmountReceivable,@data_SalePosDetail=@data_SalePosDetail

END
-----------------------------------




Go


