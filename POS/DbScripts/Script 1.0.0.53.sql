
/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Update]    Script Date: 9/8/2021 5:12:22 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePosInfo_Update]
GO
/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Insert]    Script Date: 9/8/2021 5:12:22 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_SalePosInfo_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_SalePosInfo_Insert]
GO
/****** Object:  StoredProcedure [dbo].[data_ManufacturingInfo_Insert]    Script Date: 9/8/2021 5:12:22 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_ManufacturingInfo_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[data_ManufacturingInfo_Insert]
GO
/****** Object:  StoredProcedure [dbo].[data_ManufacturingInfo_Insert]    Script Date: 9/8/2021 5:12:22 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_ManufacturingInfo_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[data_ManufacturingInfo_Insert] AS' 
END
GO




ALTER procedure [dbo].[data_ManufacturingInfo_Insert] 
@ManufacturingID int  output , 
@UserID int = null , 
@CompanyID int = null , 
@FiscalID int = null ,
@BOMID int = null , 
@ManufacturingNo int = null , 
@ItemId int = null , 
@ManufacturingDate date = null , 
@Quantity numeric(18, 3) = null , 
@WHID int = null , 
@BranchID int=null,
@Remarks varchar(300) = null ,
@ManufacturingStyle varchar(30) = null ,
@IsTaxable bit=0,
@data_ManufacturingDetail  data_ManufacturingDetail readonly ,
@data_ItemBatchDetail  data_ItemBatchDetail readonly ,
@data_ItemBatchDetailFinish  data_ItemBatchDetail readonly ,
@data_ManufacturingFormulaDetail data_ManufacturingFormulaDetail readonly ,
@ReformulationWorking bit=0 ,
@CartonQuantity numeric(18, 3) = 0,
@LooseQuantity numeric(18, 3) = 0,
@MfgOverHeadCost numeric(18, 3) = 0,
@MfgOverHeadRate numeric(18, 3) = 0,
--@AutoCode nvarchar(50)=null,
@ExpiryDate date = null,
@ManualCode nvarchar(50)=null,
@ReleaseNo int =null,
@ReleaseOrderID int=null,
@Minutes int =null,
@Hours int = null,
@MotorName		   nvarchar(50)=null,
@HP				   nvarchar(50)=null,
@Condition		   nvarchar(50)=null,
@Shape			   nvarchar(50)=null,
@Winding		   nvarchar(50)=null,
@WindingCondition  nvarchar(50)=null,
@RotorSize		  nvarchar(50)=null,
@Lead			  nvarchar(50)=null,
@Ampare			  nvarchar(50)=null,
@Bearing1		  nvarchar(50)=null,
@Bearing2		  nvarchar(50)=null,
@Impeller		  nvarchar(50)=null,
@Khradiya		  nvarchar(50)=null,
@InvoiceNo		  nvarchar(50)=null,
@MotorNumber	   nvarchar(50)=null,
@OldPic			  nvarchar(250)=null,
@AfterMPic		  nvarchar(250)=null,
@LabourContractor		int= NULL,
@PackingCharges numeric(18,3)= NULL,
@NetAmountformula numeric(18,3)= NULL,
@biltyno	  nvarchar(50)=null,
@PartyID		int= NULL,
@khradiaId int= NULL,
@KhradiaCost numeric(18, 3) =NULL,
@MfgTrimmingPercentage numeric(18, 3)=NULL,
@TrimmingQuantity numeric(18, 3)=NULL
as
declare @EditMode bit  = 0, @StockCheckDate date,@AutoCode nvarchar(50)=null

if	 @ManufacturingID = 0
BEGIN
	declare @MaxTable as MaxTable 
	insert into @MaxTable	
	exec GetVoucherNoI @Fieldname=N'ManufacturingNo',@TableName=N'data_ManufacturingInfo',@CheckTaxable= 1 ,@PrimaryKeyValue = @ManufacturingID,@PrimaryKeyFieldName = 'ManufacturingID' ,
	@voucherDate=@ManufacturingDate,@voucherDateFieldName=N'ManufacturingDate',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=@FiscalID, 
	@FiscalIDFieldName=N'FiscalID',@IsTaxable=@IsTaxable
	select @ManufacturingNo = VoucherNo from @MaxTable	
	set @StockCheckDate = @ManufacturingDate
	
	Select @AutoCode= 'Batch-'+cast(((select max(data_ManufacturingInfo.ManufacturingID)+1 from data_ManufacturingInfo where CompanyID=@CompanyID)) as nvarchar(50))
	
	Insert into data_ManufacturingInfo ( 
		EntryUserID , 
		EntryUserDateTime , 
		CompanyID , 
		FiscalID ,
		BOMID , 
		ManufacturingNo , 
		ItemId , 
		ManufacturingDate , 
		Quantity , 
		WHID , 
		Remarks ,
		ManufacturingStyle,
		BranchID,
		IsTaxable,
		ReformulationWorking,
		CartonQuantity,
		LooseQuantity,
		MfgOverHeadCost,
		MfgOverHeadRate,
		AutoCode,
		ManualCode,
		ExpiryDate,
		ReleaseNo,
		ReleaseOrderID,Minutes,Hours,
		MotorName		 
		,HP				 
		,Condition		 
		,Shape			 
		,Winding		 
		,WindingCondition
		,RotorSize		 
		,Lead			 
		,Ampare			 
		,Bearing1		 
		,Bearing2		 
		,Impeller		 
		,Khradiya		 
		,InvoiceNo		 
		,MotorNumber	 
		,OldPic			 
		,AfterMPic
		,LabourContractor
		,PackingCharges	
		
		
	 ) Values (
		@UserID , 
		GETDATE() ,
		@CompanyID , 
		@FiscalID ,
		@BOMID , 
		@ManufacturingNo , 
		@ItemId , 
		@ManufacturingDate , 
		@Quantity , 
		@WHID , 
		@Remarks ,
		@ManufacturingStyle,
		@BranchID,
		@IsTaxable,
		@ReformulationWorking ,
		@CartonQuantity,
		@LooseQuantity,
		@MfgOverHeadCost,
		@MfgOverHeadRate,
	    @AutoCode,
		@ManualCode,
		@ExpiryDate,
		@ReleaseNo,
		@ReleaseOrderID,@Minutes,@Hours
		,@MotorName		 
		,@HP				 
		,@Condition		 
		,@Shape			 
		,@Winding		 
		,@WindingCondition
		,@RotorSize		 
		,@Lead			 
		,@Ampare			 
		,@Bearing1		 
		,@Bearing2		 
		,@Impeller		 
		,@Khradiya		 
		,@InvoiceNo		 
		,@MotorNumber	 
		,@OldPic			 
		,@AfterMPic
		,@LabourContractor
		,@PackingCharges				 
		
		)
	set @ManufacturingID = @@IDENTITY
	
END

ELSE

BEGIN	
	
	select @StockCheckDate = ManufacturingDate from data_ManufacturingInfo where ManufacturingID = @ManufacturingID

	if @StockCheckDate > @ManufacturingDate
	BEGIN
		set @StockCheckDate = @ManufacturingDate
	END

	declare @SaveVoucherdate date , @IsVoucherNoMonthly bit
select @IsVoucherNoMonthly = IsVoucherNoMonthly from gen_SystemConfiguration where CompanyID =  @CompanyID

if @IsVoucherNoMonthly = 1
BEGIN
	select @SaveVoucherdate = ManufacturingDate from data_ManufacturingInfo where ManufacturingID = @ManufacturingID

	if MONTH(@ManufacturingDate) <> MONTH(@SaveVoucherdate) or  YEAR(@ManufacturingDate) <> YEAR(@SaveVoucherdate)
	BEGIN
		insert into @MaxTable
		exec GetVoucherNoI @Fieldname=N'ManufacturingNo',@TableName=N'data_ManufacturingInfo',@CheckTaxable= 1 ,@PrimaryKeyValue = @ManufacturingID,@PrimaryKeyFieldName = 'ManufacturingID' ,
		@voucherDate=@ManufacturingDate,@voucherDateFieldName=N'ManufacturingDate',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=@FiscalID, 
		@FiscalIDFieldName=N'FiscalID',@IsTaxable=@IsTaxable
		select @ManufacturingNo = VoucherNo from @MaxTable

	END
END
Select @AutoCode= 'Batch-'+cast(((select max(data_ManufacturingInfo.ManufacturingID) from data_ManufacturingInfo where CompanyID=@CompanyID and data_ManufacturingInfo.ManufacturingID=@ManufacturingID)) as nvarchar(50))
	update data_ManufacturingInfo set	
	ModifyUserID = @UserID , 
	ModifyUserDateTime = GETDATE() , 
	CompanyID = @CompanyID , 
	FiscalID = @FiscalID ,
	BOMID = @BOMID , 
	ManufacturingNo = @ManufacturingNo , 
	ItemId = @ItemId , 
	ManufacturingDate = @ManufacturingDate , 
	Quantity = @Quantity , 
	WHID = @WHID , 
	Remarks = @Remarks,
	BranchID=@BranchID,
	IsTaxable = @IsTaxable,
	ReformulationWorking = @ReformulationWorking ,
	CartonQuantity = @CartonQuantity ,
	LooseQuantity = @LooseQuantity,
	MfgOverHeadCost=@MfgOverHeadCost,
	MfgOverHeadRate=@MfgOverHeadRate,
	AutoCode=@AutoCode,
    ManualCode=@ManualCode,
	ExpiryDate=@ExpiryDate,
	ReleaseNo=@ReleaseNo,
	ReleaseOrderID=@ReleaseOrderID,
	Minutes=@Minutes,
	Hours=@Hours,
	MotorName		 =@MotorName		, 
	HP				 =@HP				, 
	Condition		 =@Condition		, 
	Shape			 =@Shape			, 
	Winding		 =@Winding		 	  ,
	WindingCondition=@WindingCondition,
	RotorSize		 =@RotorSize	,	 
	Lead			 =@Lead			, 
	Ampare			 =@Ampare		,	 
	Bearing1		 =@Bearing1		, 
	Bearing2		 =@Bearing2		, 
	Impeller		 =@Impeller		, 
	Khradiya		 =@Khradiya		, 
	InvoiceNo		 =@InvoiceNo	,	 
	MotorNumber	 =@MotorNumber	 	,
	OldPic			 =@OldPic		,	 
	AfterMPic		 =@AfterMPic	
	,LabourContractor=@LabourContractor
	,PackingCharges=@PackingCharges	
				 
	--,
	--ManufacturingStyle = @ManufacturingStyle
	where ManufacturingID = @ManufacturingID


	declare @ProductInflowSourceIDTable as data_ProductInflow , @ItemsWarehouseBatchWise as ItemsWarehouseBatchWise
	declare @ManufacturingdetailFGIDS as data_ProductInflow 
	insert into @ProductInflowSourceIDTable (SourceID) select ManufacturingID from data_ManufacturingInfo where ManufacturingID = @ManufacturingID
	insert into @ManufacturingdetailFGIDS (SourceID) select ManufacturingFGParamsID from data_ManufacturingDetailParamsFG where ManufacturingID = @ManufacturingID
	
	

	if (select count(*) from @data_ItemBatchDetailFinish) > 0
	BEGIN
		insert into @ItemsWarehouseBatchWise (ItemID,WHID,Param1,Param2,Param3)
		select @ItemId,@WHID ,Param1,Param2,Param3 from @data_ItemBatchDetailFinish
	END
	else 
	BEGIN
		insert into @ItemsWarehouseBatchWise (ItemID,WHID)
		select @ItemId,@WHID 
	END

	--declare @asss as xml = (select * from @ItemsWarehouseBatchWise for xml auto)
	--declare @assssss as xml = (select * from @ProductInflowSourceIDTable for xml auto)

	update data_ProductInflow set IsDeleted = 1 where SourceName = 'MFG IN' and SourceID in (select SourceID from @ProductInflowSourceIDTable )


	delete from data_ProductOutflowBatch where SourceName = 'MFG OUT' and SourceID in (select ManufacturingDetailID from data_ManufacturingDetail where ManufacturingID = @ManufacturingID) 	
	delete from data_ProductOutflow where SourceName = 'MFG OUT' and SourceID in (select ManufacturingDetailID from data_ManufacturingDetail where ManufacturingID = @ManufacturingID) 	
	delete from data_ManufacturingDetailParams where ManufacturingID = @ManufacturingID
	delete from data_ManufacturingDetailParamsFG where ManufacturingID = @ManufacturingID
	delete from data_ManufacturingDetail where ManufacturingID = @ManufacturingID
	delete from data_ProductInflow where SourceName = 'MFG IN' and SourceID in (select ManufacturingFormulaDID from data_ManufacturingFormulaDetail where ManufacturingID = @ManufacturingID) 
	delete from data_ManufacturingFormulaDetail where ManufacturingID = @ManufacturingID
	set	@EditMode = 1
END
	

declare @RowID int,@ManufacturingDetailID int ,@StockRate numeric(14,5) , @ActualQuantity numeric(10,2),@RawItemId int,@stockQty numeric(14,2),
@ItemName varchar(200),@ERRORMSG varchar(200),@WhIDDetail int,@MfgTrimmingPerDetail numeric(18,3)=0,@TrimDetail numeric(18,3)=0,@TotalUsedQuantity numeric(18,3)=0,
@WastageItemId int=0

Select @WastageItemId =RawItemID from gen_SystemConfiguration where CompanyID=@CompanyID
 
--declare @jj as xml = (select * from @data_ManufacturingDetail for xml auto)

declare firstcursor cursor for
select RowID from @data_ManufacturingDetail
open firstcursor
fetch next from firstcursor into @RowID
while @@FETCH_STATUS = 0
	begin
		declare @checkRate bit = 1
		
		set @TotalUsedQuantity=@ActualQuantity+@TrimDetail
		exec CheckStock @ItemID = @RawItemId ,
			@WHID = @WhIDDetail , 
			@StockDate = @ManufacturingDate , 
			@CompanyID = @CompanyID,			
			@RowID = @RowID ,
			@AllowNegativeStock = 0,
			@Quantity = @ActualQuantity,
			@ERRORMSG = @ERRORMSG out,
			@checkRate = @checkRate out,
			@data_ItemBatchDetail =  @data_ItemBatchDetail ,
			@IsTaxable = @IsTaxable


			if @ERRORMSG != ''
			BEGIN
				RAISERROR (@ERRORMSG , 16, 1 ) ;
				return
			END
			
		--exec GetStockQuantity @RawItemId ,@WhIDDetail , @ManufacturingDate , @stockQty output , @ItemName out , @CompanyID
		
		--if  @stockQty < @ActualQuantity 
		--BEGIN
		--	set @ERRORMSG = 'Stock is not enough of Item ' + @ItemName
		--	 RAISERROR (@ERRORMSG , 16, 1 ) ;
		--	 return
		--END


		Insert Into data_ManufacturingDetail (
		ManufacturingID ,
		ItemId ,
		BOMQuantity ,
		ActualQuantity ,
		WHID ,
		StockRate,
		BOMFormulaQuantity ,
		ReleaseOrderDetailID
		

		) Select
		@ManufacturingID ,
		ItemId ,
		BOMQuantity ,
		ActualQuantity ,
		WHID ,
		StockRate,
		BOMFormulaQuantity ,
		ReleaseOrderDetailID
		
		
		From @data_ManufacturingDetail where RowID = @RowID

		set @ManufacturingDetailID = @@IDENTITY		



		declare @productInflowID int,@ProductOutflowID int

		exec GetWeightedRateForItem @RawItemId, @WhIDDetail ,@ManufacturingDate ,@ManufacturingDate ,@StockRate output , @CompanyID , @IsTaxable

		update data_ManufacturingDetail set StockRate = @StockRate where ManufacturingDetailID = @ManufacturingDetailID
		exec data_ProductOutflow_Insert @ProductOutflowID out,null,@RawItemId,@ManufacturingDetailID,'MFG OUT',@WhIDDetail, @ManufacturingDate ,
		@StockRate , @ActualQuantity , @FiscalID , @CompanyID , @IsTaxable,null,null,null,null,null,@BranchID
		exec tempOutflowDataTable_Insert @ProductOutflowID ,'MFG OUT'

		if @TrimDetail>0
		begin
		
		exec data_ProductInflow_Insert @productInflowID out , @WastageItemId , @ManufacturingID , 'MFG IN' , @WHID , @ManufacturingDate , @StockRate , 
		@TrimDetail , @TrimDetail , @FiscalID , @CompanyID , @IsTaxable,null,null,null,null,null,@BranchID
		exec tempInflowDataTable_Insert @productInflowID ,'MFG IN'


		end
		

		

		Insert Into data_ManufacturingDetailParams(
		ManufacturingDetailID ,
		ManufacturingID ,
		ItemId ,
		Quantity ,
		Param1 ,
		Param2 ,
		Param3 
		) Select
		@ManufacturingDetailID ,
		@ManufacturingID ,
		@RawItemId ,
		Quantity ,
		Param1 ,
		Param2 ,
		Param3 
		From @data_ItemBatchDetail
		Where RowID = @RowID

		DECLARE @Gid uniqueidentifier = CAST(CONTEXT_INFO() as uniqueidentifier);
		DELETE FROM tempOutflowDataTable WHERE [GUID] = @Gid;		

	FETCH NEXT FROM firstcursor INTO @RowID
	END

close firstcursor
deallocate firstcursor



select @StockRate = sum( StockRate * ActualQuantity ) from data_ManufacturingDetail where ManufacturingID = @ManufacturingID

set @StockRate  =(@StockRate+(@MfgOverHeadRate*@Quantity)) /@Quantity

update data_ManufacturingInfo set StockRate = @StockRate where ManufacturingID = @ManufacturingID

exec data_ProductInflow_Insert @productInflowID out , @ItemId , @ManufacturingID , 'MFG IN' , @WHID , @ManufacturingDate , @StockRate , 
@Quantity , @Quantity , @FiscalID , @CompanyID , @IsTaxable,null,null,null,@ExpiryDate,@ManualCode,@BranchID
exec tempInflowDataTable_Insert @productInflowID ,'MFG IN'





		Insert Into data_ManufacturingDetailParamsFG(		
		ManufacturingID ,
		ItemId ,
		Quantity ,
		Param1 ,
		Param2 ,
		Param3 
		) Select		
		@ManufacturingID ,
		@ItemId ,
		Quantity ,
		Param1 ,
		Param2 ,
		Param3 
		From @data_ItemBatchDetailFinish

		declare @RawItemId1 int ,@QTY numeric(18, 3),@Rate numeric(18, 3),@netamo numeric(18, 3),@ManufacturingFormulaDID int

declare firstcursor1 cursor for
select RowID from @data_ManufacturingFormulaDetail
open firstcursor1
fetch next from firstcursor1 into @RowID
while @@FETCH_STATUS = 0
	begin
		
		select @RawItemId1 = ItemId ,@QTY = Quantity , @Rate = Rate,@netamo= NetAmount From @data_ManufacturingFormulaDetail where RowID = @RowID
		




		
Insert Into data_ManufacturingFormulaDetail(		
		ManufacturingID ,
		ItemId ,
		Quantity ,
		Rate ,
		NetAmount 
		) Select		
		@ManufacturingID ,
		ItemId ,
		Quantity ,
		Rate ,
		NetAmount 
		From @data_ManufacturingFormulaDetail where RowID = @RowID
			

		set @ManufacturingFormulaDID = @@IDENTITY		

exec data_ProductInflow_Insert @productInflowID out , @RawItemId1 , @ManufacturingFormulaDID , 'MFG IN' , @WHID , @ManufacturingDate , @Rate , 
@QTY , @QTY , @FiscalID , @CompanyID , @IsTaxable,null,null,null,@ExpiryDate,@ManualCode,@BranchID
exec tempInflowDataTable_Insert @productInflowID ,'MFG IN'
		FETCH NEXT FROM firstcursor1 INTO @RowID
	END



close firstcursor1
deallocate firstcursor1
set @Gid = CAST(CONTEXT_INFO() as uniqueidentifier);
DELETE FROM tempInflowDataTable WHERE [GUID] = @Gid;

--check Stock Available Or not of Inserted Item
if @EditMode = 1
BEGIN	
	set @ErrorMsg = ''
	exec CheckDeletedStock 'MFG IN', @ItemsWarehouseBatchWise , @ProductInflowSourceIDTable , @StockCheckDate , @ErrorMsg output, 
	@CompanyID , @IsTaxable
	if @ErrorMsg <> ''
	BEGIN
		RAISERROR (@ErrorMsg ,16 , 1);
		return
	END
	
	--delete from data_ProductInflowBatch where SourceName =  'MFG IN'  AND SourceID in (select SourceID from  @ProductInflowSourceIDTable ) 
	delete from data_ProductInflowBatch where SourceName =  'MFG IN'  AND SourceID in (select SourceID from  @ManufacturingdetailFGIDS ) 
	delete from data_ProductInflow where SourceName =  'MFG IN'  AND SourceID in (select SourceID from  @ProductInflowSourceIDTable ) and IsDeleted = 1
END


set @MfgOverHeadCost=@MfgOverHeadRate*@Quantity

----Start Account Voucher
--exec data_ManufacturingInfo_InsertAccount @ManufacturingID = @ManufacturingID, @CompanyID = @CompanyID, @ManufacturingDate = @ManufacturingDate , 
--@WHID = @WHID , @ManufacturingNo = @ManufacturingNo , @UserID = @UserID , @FiscalID = @FiscalID ,@EditMode = @EditMode, @BranchID = @BranchID, @IsTaxable = @IsTaxable
--, @Remarks = @Remarks ,@MfgOverHeadCost=@MfgOverHeadCost, @data_ManufacturingDetail = @data_ManufacturingDetail,@ManufacturingStyle=@ManufacturingStyle,@LabourContractor=@LabourContractor,@PackingCharges=@PackingCharges,@data_ManufacturingFormulaDetail=@data_ManufacturingFormulaDetail,@khradiaId=@khradiaId,@KhradiaCost=@KhradiaCost
----End Account Voucher																																																																		  







/****** Object:  StoredProcedure [dbo].[data_ManufacturingInfo_InsertAccount]    Script Date: 6/28/2021 5:26:25 PM ******/
SET ANSI_NULLS ON


GO
/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Insert]    Script Date: 9/8/2021 5:12:22 PM ******/
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
@LinckedBill int =NULL

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
	exec GetVoucherNoPosFoodMama @Fieldname=N'SalePOSNo',@TableName=N'data_SalePosInfo',@CheckTaxable= 0 ,@PrimaryKeyValue = @SalePosID,@PrimaryKeyFieldName = 'SalePosID' ,
	@voucherDate=@SalePOSDate,@voucherDateFieldName=N'SalePOSDate',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=@FiscalID, 
	@FiscalIDFieldName=N'FiscalID',@IsTaxable=@IsTaxable,@MenuId=@MenuId,@MenuFieldName=N'MenuId'
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
		LinckedBill
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
		@LinckedBill
		
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
		@SalePosDate=@SalePosDate
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
		@SalePosDate=@SalePosDate
		end
		

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
		if(@BomId>0)
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
				set @Quantity=-1* @Quantity
				exec data_ProductInflow_Insert @ProductIntflowID output,@ItemId,@SaleDetailID,'POSEXCHANGE',@WHID, @SalePosDate ,@StockRate,@Quantity, 
				@Quantity,@FiscalID , @CompanyID , @IsTaxable
				exec tempInflowDataTable_Insert @ProductIntflowID ,'POSEXCHANGE'
				end
				else
				begin
				exec data_ProductOutflow_Insert @ProductOutflowID output,null,@ItemId,@SaleDetailID,'POS',@WHID, @SalePosDate ,@StockRate,@Quantity, 
				@FiscalID , @CompanyID , @IsTaxable
				exec tempOutflowDataTable_Insert @ProductOutflowID ,'POS'
				end
				
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
/****** Object:  StoredProcedure [dbo].[data_SalePosInfo_Update]    Script Date: 9/8/2021 5:12:22 PM ******/
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
@LinckedBill int =NULL

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
		LinckedBill=@LinckedBill
	where SalePosID=@SalePosID
	delete from data_CashOut where SourceName='POS' and SourceID=@SalePosID
delete from data_CashIn where SourceName='POS' and SourceID=@SalePosID
Delete from data_ProductInflow where SourceName='POSEXCHANGE' and SourceID in (Select SalePosDetailID from data_SalePosDetail where SalePosID=@SalePosID)
Delete from data_ProductOutflow where SourceName='POS' and SourceID in (Select SalePosDetailID from data_SalePosDetail where SalePosID=@SalePosID)
Delete from data_SalePosDetail where SalePosID=@SalePosID
	if @InvoiceType is null or @InvoiceType=1
	begin
	EXEC [dbo].[data_Cash_Insert]
		@SourceID = @SalePosID,
		@SourceName = N'POS',
		@Amount = @AmountReceivable,
		@CashType = 1,
		@SalePosDate=@SalePosDate
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
		@SalePosDate=@SalePosDate
		end
		

---========== Sale End Here ================
---========================== Sale Stock In Working Start Here =============================
		
end

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
		if(@BomId>0)
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
				@FiscalID , @CompanyID , @IsTaxable
				exec tempOutflowDataTable_Insert @ProductOutflowID ,'POS'
				end
				
			END
	
	FETCH NEXT FROM Salecursor INTO @RowID
	END

close Salecursor
deallocate Salecursor


---========================== Sale Stock In Working End Here =============================







GO


/****** Object:  StoredProcedure [dbo].[data_ManufacturingInfo_Insert]    Script Date: 9/8/2021 5:18:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




ALTER procedure [dbo].[data_ManufacturingInfo_Insert] 
@ManufacturingID int  output , 
@UserID int = null , 
@CompanyID int = null , 
@FiscalID int = null ,
@BOMID int = null , 
@ManufacturingNo int = null , 
@ItemId int = null , 
@ManufacturingDate date = null , 
@Quantity numeric(18, 3) = null , 
@WHID int = null , 
@BranchID int=null,
@Remarks varchar(300) = null ,
@ManufacturingStyle varchar(30) = null ,
@IsTaxable bit=0,
@data_ManufacturingDetail  data_ManufacturingDetail readonly ,
@data_ItemBatchDetail  data_ItemBatchDetail readonly ,
@data_ItemBatchDetailFinish  data_ItemBatchDetail readonly ,
@data_ManufacturingFormulaDetail data_ManufacturingFormulaDetail readonly ,
@ReformulationWorking bit=0 ,
@CartonQuantity numeric(18, 3) = 0,
@LooseQuantity numeric(18, 3) = 0,
@MfgOverHeadCost numeric(18, 3) = 0,
@MfgOverHeadRate numeric(18, 3) = 0,
--@AutoCode nvarchar(50)=null,
@ExpiryDate date = null,
@ManualCode nvarchar(50)=null,
@ReleaseNo int =null,
@ReleaseOrderID int=null,
@Minutes int =null,
@Hours int = null,
@MotorName		   nvarchar(50)=null,
@HP				   nvarchar(50)=null,
@Condition		   nvarchar(50)=null,
@Shape			   nvarchar(50)=null,
@Winding		   nvarchar(50)=null,
@WindingCondition  nvarchar(50)=null,
@RotorSize		  nvarchar(50)=null,
@Lead			  nvarchar(50)=null,
@Ampare			  nvarchar(50)=null,
@Bearing1		  nvarchar(50)=null,
@Bearing2		  nvarchar(50)=null,
@Impeller		  nvarchar(50)=null,
@Khradiya		  nvarchar(50)=null,
@InvoiceNo		  nvarchar(50)=null,
@MotorNumber	   nvarchar(50)=null,
@OldPic			  nvarchar(250)=null,
@AfterMPic		  nvarchar(250)=null,
@LabourContractor		int= NULL,
@PackingCharges numeric(18,3)= NULL,
@NetAmountformula numeric(18,3)= NULL,
@biltyno	  nvarchar(50)=null,
@PartyID		int= NULL,
@khradiaId int= NULL,
@KhradiaCost numeric(18, 3) =NULL,
@MfgTrimmingPercentage numeric(18, 3)=NULL,
@TrimmingQuantity numeric(18, 3)=NULL
as
declare @EditMode bit  = 0, @StockCheckDate date,@AutoCode nvarchar(50)=null

if	 @ManufacturingID = 0
BEGIN
	declare @MaxTable as MaxTable 
	insert into @MaxTable	
	exec GetVoucherNoI @Fieldname=N'ManufacturingNo',@TableName=N'data_ManufacturingInfo',@CheckTaxable= 1 ,@PrimaryKeyValue = @ManufacturingID,@PrimaryKeyFieldName = 'ManufacturingID' ,
	@voucherDate=@ManufacturingDate,@voucherDateFieldName=N'ManufacturingDate',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=@FiscalID, 
	@FiscalIDFieldName=N'FiscalID',@IsTaxable=@IsTaxable
	select @ManufacturingNo = VoucherNo from @MaxTable	
	set @StockCheckDate = @ManufacturingDate
	
	Select @AutoCode= 'Batch-'+cast(((select max(data_ManufacturingInfo.ManufacturingID)+1 from data_ManufacturingInfo where CompanyID=@CompanyID)) as nvarchar(50))
	
	Insert into data_ManufacturingInfo ( 
		EntryUserID , 
		EntryUserDateTime , 
		CompanyID , 
		FiscalID ,
		BOMID , 
		ManufacturingNo , 
		ItemId , 
		ManufacturingDate , 
		Quantity , 
		WHID , 
		Remarks ,
		ManufacturingStyle,
		BranchID,
		IsTaxable,
		ReformulationWorking,
		CartonQuantity,
		LooseQuantity,
		MfgOverHeadCost,
		MfgOverHeadRate,
		AutoCode,
		ManualCode,
		ExpiryDate,
		ReleaseNo,
		ReleaseOrderID,Minutes,Hours,
		MotorName		 
		,HP				 
		,Condition		 
		,Shape			 
		,Winding		 
		,WindingCondition
		,RotorSize		 
		,Lead			 
		,Ampare			 
		,Bearing1		 
		,Bearing2		 
		,Impeller		 
		,Khradiya		 
		,InvoiceNo		 
		,MotorNumber	 
		,OldPic			 
		,AfterMPic
		,LabourContractor
		,PackingCharges	
		
		
	 ) Values (
		@UserID , 
		GETDATE() ,
		@CompanyID , 
		@FiscalID ,
		@BOMID , 
		@ManufacturingNo , 
		@ItemId , 
		@ManufacturingDate , 
		@Quantity , 
		@WHID , 
		@Remarks ,
		@ManufacturingStyle,
		@BranchID,
		@IsTaxable,
		@ReformulationWorking ,
		@CartonQuantity,
		@LooseQuantity,
		@MfgOverHeadCost,
		@MfgOverHeadRate,
	    @AutoCode,
		@ManualCode,
		@ExpiryDate,
		@ReleaseNo,
		@ReleaseOrderID,@Minutes,@Hours
		,@MotorName		 
		,@HP				 
		,@Condition		 
		,@Shape			 
		,@Winding		 
		,@WindingCondition
		,@RotorSize		 
		,@Lead			 
		,@Ampare			 
		,@Bearing1		 
		,@Bearing2		 
		,@Impeller		 
		,@Khradiya		 
		,@InvoiceNo		 
		,@MotorNumber	 
		,@OldPic			 
		,@AfterMPic
		,@LabourContractor
		,@PackingCharges				 
		
		)
	set @ManufacturingID = @@IDENTITY
	
END

ELSE

BEGIN	
	
	select @StockCheckDate = ManufacturingDate from data_ManufacturingInfo where ManufacturingID = @ManufacturingID

	if @StockCheckDate > @ManufacturingDate
	BEGIN
		set @StockCheckDate = @ManufacturingDate
	END

	declare @SaveVoucherdate date , @IsVoucherNoMonthly bit
select @IsVoucherNoMonthly = IsVoucherNoMonthly from gen_SystemConfiguration where CompanyID =  @CompanyID

if @IsVoucherNoMonthly = 1
BEGIN
	select @SaveVoucherdate = ManufacturingDate from data_ManufacturingInfo where ManufacturingID = @ManufacturingID

	if MONTH(@ManufacturingDate) <> MONTH(@SaveVoucherdate) or  YEAR(@ManufacturingDate) <> YEAR(@SaveVoucherdate)
	BEGIN
		insert into @MaxTable
		exec GetVoucherNoI @Fieldname=N'ManufacturingNo',@TableName=N'data_ManufacturingInfo',@CheckTaxable= 1 ,@PrimaryKeyValue = @ManufacturingID,@PrimaryKeyFieldName = 'ManufacturingID' ,
		@voucherDate=@ManufacturingDate,@voucherDateFieldName=N'ManufacturingDate',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=@FiscalID, 
		@FiscalIDFieldName=N'FiscalID',@IsTaxable=@IsTaxable
		select @ManufacturingNo = VoucherNo from @MaxTable

	END
END
Select @AutoCode= 'Batch-'+cast(((select max(data_ManufacturingInfo.ManufacturingID) from data_ManufacturingInfo where CompanyID=@CompanyID and data_ManufacturingInfo.ManufacturingID=@ManufacturingID)) as nvarchar(50))
	update data_ManufacturingInfo set	
	ModifyUserID = @UserID , 
	ModifyUserDateTime = GETDATE() , 
	CompanyID = @CompanyID , 
	FiscalID = @FiscalID ,
	BOMID = @BOMID , 
	ManufacturingNo = @ManufacturingNo , 
	ItemId = @ItemId , 
	ManufacturingDate = @ManufacturingDate , 
	Quantity = @Quantity , 
	WHID = @WHID , 
	Remarks = @Remarks,
	BranchID=@BranchID,
	IsTaxable = @IsTaxable,
	ReformulationWorking = @ReformulationWorking ,
	CartonQuantity = @CartonQuantity ,
	LooseQuantity = @LooseQuantity,
	MfgOverHeadCost=@MfgOverHeadCost,
	MfgOverHeadRate=@MfgOverHeadRate,
	AutoCode=@AutoCode,
    ManualCode=@ManualCode,
	ExpiryDate=@ExpiryDate,
	ReleaseNo=@ReleaseNo,
	ReleaseOrderID=@ReleaseOrderID,
	Minutes=@Minutes,
	Hours=@Hours,
	MotorName		 =@MotorName		, 
	HP				 =@HP				, 
	Condition		 =@Condition		, 
	Shape			 =@Shape			, 
	Winding		 =@Winding		 	  ,
	WindingCondition=@WindingCondition,
	RotorSize		 =@RotorSize	,	 
	Lead			 =@Lead			, 
	Ampare			 =@Ampare		,	 
	Bearing1		 =@Bearing1		, 
	Bearing2		 =@Bearing2		, 
	Impeller		 =@Impeller		, 
	Khradiya		 =@Khradiya		, 
	InvoiceNo		 =@InvoiceNo	,	 
	MotorNumber	 =@MotorNumber	 	,
	OldPic			 =@OldPic		,	 
	AfterMPic		 =@AfterMPic	
	,LabourContractor=@LabourContractor
	,PackingCharges=@PackingCharges	
				 
	--,
	--ManufacturingStyle = @ManufacturingStyle
	where ManufacturingID = @ManufacturingID


	declare @ProductInflowSourceIDTable as data_ProductInflow , @ItemsWarehouseBatchWise as ItemsWarehouseBatchWise
	declare @ManufacturingdetailFGIDS as data_ProductInflow 
	insert into @ProductInflowSourceIDTable (SourceID) select ManufacturingID from data_ManufacturingInfo where ManufacturingID = @ManufacturingID
	insert into @ManufacturingdetailFGIDS (SourceID) select ManufacturingFGParamsID from data_ManufacturingDetailParamsFG where ManufacturingID = @ManufacturingID
	
	

	if (select count(*) from @data_ItemBatchDetailFinish) > 0
	BEGIN
		insert into @ItemsWarehouseBatchWise (ItemID,WHID,Param1,Param2,Param3)
		select @ItemId,@WHID ,Param1,Param2,Param3 from @data_ItemBatchDetailFinish
	END
	else 
	BEGIN
		insert into @ItemsWarehouseBatchWise (ItemID,WHID)
		select @ItemId,@WHID 
	END

	--declare @asss as xml = (select * from @ItemsWarehouseBatchWise for xml auto)
	--declare @assssss as xml = (select * from @ProductInflowSourceIDTable for xml auto)

	update data_ProductInflow set IsDeleted = 1 where SourceName = 'MFG IN' and SourceID in (select SourceID from @ProductInflowSourceIDTable )


	delete from data_ProductOutflowBatch where SourceName = 'MFG OUT' and SourceID in (select ManufacturingDetailID from data_ManufacturingDetail where ManufacturingID = @ManufacturingID) 	
	delete from data_ProductOutflow where SourceName = 'MFG OUT' and SourceID in (select ManufacturingDetailID from data_ManufacturingDetail where ManufacturingID = @ManufacturingID) 	
	delete from data_ManufacturingDetailParams where ManufacturingID = @ManufacturingID
	delete from data_ManufacturingDetailParamsFG where ManufacturingID = @ManufacturingID
	delete from data_ManufacturingDetail where ManufacturingID = @ManufacturingID
	delete from data_ProductInflow where SourceName = 'MFG IN' and SourceID in (select ManufacturingFormulaDID from data_ManufacturingFormulaDetail where ManufacturingID = @ManufacturingID) 
	delete from data_ManufacturingFormulaDetail where ManufacturingID = @ManufacturingID
	set	@EditMode = 1
END
	

declare @RowID int,@ManufacturingDetailID int ,@StockRate numeric(14,5) , @ActualQuantity numeric(10,2),@RawItemId int,@stockQty numeric(14,2),
@ItemName varchar(200),@ERRORMSG varchar(200),@WhIDDetail int,@MfgTrimmingPerDetail numeric(18,3)=0,@TrimDetail numeric(18,3)=0,@TotalUsedQuantity numeric(18,3)=0,
@WastageItemId int=0

Select @WastageItemId =RawItemID from gen_SystemConfiguration where CompanyID=@CompanyID
 
--declare @jj as xml = (select * from @data_ManufacturingDetail for xml auto)

declare firstcursor cursor for
select RowID from @data_ManufacturingDetail
open firstcursor
fetch next from firstcursor into @RowID
while @@FETCH_STATUS = 0
	begin
		declare @checkRate bit = 1
		
		set @TotalUsedQuantity=@ActualQuantity+@TrimDetail
		exec CheckStock @ItemID = @RawItemId ,
			@WHID = @WhIDDetail , 
			@StockDate = @ManufacturingDate , 
			@CompanyID = @CompanyID,			
			@RowID = @RowID ,
			@AllowNegativeStock = 0,
			@Quantity = @ActualQuantity,
			@ERRORMSG = @ERRORMSG out,
			@checkRate = @checkRate out,
			@data_ItemBatchDetail =  @data_ItemBatchDetail ,
			@IsTaxable = @IsTaxable


			if @ERRORMSG != ''
			BEGIN
				RAISERROR (@ERRORMSG , 16, 1 ) ;
				return
			END
			
		--exec GetStockQuantity @RawItemId ,@WhIDDetail , @ManufacturingDate , @stockQty output , @ItemName out , @CompanyID
		
		--if  @stockQty < @ActualQuantity 
		--BEGIN
		--	set @ERRORMSG = 'Stock is not enough of Item ' + @ItemName
		--	 RAISERROR (@ERRORMSG , 16, 1 ) ;
		--	 return
		--END


		Insert Into data_ManufacturingDetail (
		ManufacturingID ,
		ItemId ,
		BOMQuantity ,
		ActualQuantity ,
		WHID ,
		StockRate,
		BOMFormulaQuantity ,
		ReleaseOrderDetailID
		

		) Select
		@ManufacturingID ,
		ItemId ,
		BOMQuantity ,
		ActualQuantity ,
		WHID ,
		0,
		BOMFormulaQuantity ,
		ReleaseOrderDetailID
		
		
		From @data_ManufacturingDetail where RowID = @RowID

		set @ManufacturingDetailID = @@IDENTITY		



		declare @productInflowID int,@ProductOutflowID int

		exec GetWeightedRateForItem @RawItemId, @WhIDDetail ,@ManufacturingDate ,@ManufacturingDate ,@StockRate output , @CompanyID , @IsTaxable

		update data_ManufacturingDetail set StockRate = @StockRate where ManufacturingDetailID = @ManufacturingDetailID
		exec data_ProductOutflow_Insert @ProductOutflowID out,null,@RawItemId,@ManufacturingDetailID,'MFG OUT',@WhIDDetail, @ManufacturingDate ,
		@StockRate , @ActualQuantity , @FiscalID , @CompanyID , @IsTaxable,null,null,null,null,null,@BranchID
		exec tempOutflowDataTable_Insert @ProductOutflowID ,'MFG OUT'

		if @TrimDetail>0
		begin
		
		exec data_ProductInflow_Insert @productInflowID out , @WastageItemId , @ManufacturingID , 'MFG IN' , @WHID , @ManufacturingDate , @StockRate , 
		@TrimDetail , @TrimDetail , @FiscalID , @CompanyID , @IsTaxable,null,null,null,null,null,@BranchID
		exec tempInflowDataTable_Insert @productInflowID ,'MFG IN'


		end
		

		

		Insert Into data_ManufacturingDetailParams(
		ManufacturingDetailID ,
		ManufacturingID ,
		ItemId ,
		Quantity ,
		Param1 ,
		Param2 ,
		Param3 
		) Select
		@ManufacturingDetailID ,
		@ManufacturingID ,
		@RawItemId ,
		Quantity ,
		Param1 ,
		Param2 ,
		Param3 
		From @data_ItemBatchDetail
		Where RowID = @RowID

		DECLARE @Gid uniqueidentifier = CAST(CONTEXT_INFO() as uniqueidentifier);
		DELETE FROM tempOutflowDataTable WHERE [GUID] = @Gid;		

	FETCH NEXT FROM firstcursor INTO @RowID
	END

close firstcursor
deallocate firstcursor



select @StockRate = sum( StockRate * ActualQuantity ) from data_ManufacturingDetail where ManufacturingID = @ManufacturingID

set @StockRate  =(@StockRate+(@MfgOverHeadRate*@Quantity)) /@Quantity

update data_ManufacturingInfo set StockRate = @StockRate where ManufacturingID = @ManufacturingID

exec data_ProductInflow_Insert @productInflowID out , @ItemId , @ManufacturingID , 'MFG IN' , @WHID , @ManufacturingDate , @StockRate , 
@Quantity , @Quantity , @FiscalID , @CompanyID , @IsTaxable,null,null,null,@ExpiryDate,@ManualCode,@BranchID
exec tempInflowDataTable_Insert @productInflowID ,'MFG IN'





		Insert Into data_ManufacturingDetailParamsFG(		
		ManufacturingID ,
		ItemId ,
		Quantity ,
		Param1 ,
		Param2 ,
		Param3 
		) Select		
		@ManufacturingID ,
		@ItemId ,
		Quantity ,
		Param1 ,
		Param2 ,
		Param3 
		From @data_ItemBatchDetailFinish

		declare @RawItemId1 int ,@QTY numeric(18, 3),@Rate numeric(18, 3),@netamo numeric(18, 3),@ManufacturingFormulaDID int

declare firstcursor1 cursor for
select RowID from @data_ManufacturingFormulaDetail
open firstcursor1
fetch next from firstcursor1 into @RowID
while @@FETCH_STATUS = 0
	begin
		
		select @RawItemId1 = ItemId ,@QTY = Quantity , @Rate = Rate,@netamo= NetAmount From @data_ManufacturingFormulaDetail where RowID = @RowID
		




		
Insert Into data_ManufacturingFormulaDetail(		
		ManufacturingID ,
		ItemId ,
		Quantity ,
		Rate ,
		NetAmount 
		) Select		
		@ManufacturingID ,
		ItemId ,
		Quantity ,
		Rate ,
		NetAmount 
		From @data_ManufacturingFormulaDetail where RowID = @RowID
			

		set @ManufacturingFormulaDID = @@IDENTITY		

exec data_ProductInflow_Insert @productInflowID out , @RawItemId1 , @ManufacturingFormulaDID , 'MFG IN' , @WHID , @ManufacturingDate , @Rate , 
@QTY , @QTY , @FiscalID , @CompanyID , @IsTaxable,null,null,null,@ExpiryDate,@ManualCode,@BranchID
exec tempInflowDataTable_Insert @productInflowID ,'MFG IN'
		FETCH NEXT FROM firstcursor1 INTO @RowID
	END



close firstcursor1
deallocate firstcursor1
set @Gid = CAST(CONTEXT_INFO() as uniqueidentifier);
DELETE FROM tempInflowDataTable WHERE [GUID] = @Gid;

--check Stock Available Or not of Inserted Item
if @EditMode = 1
BEGIN	
	set @ErrorMsg = ''
	exec CheckDeletedStock 'MFG IN', @ItemsWarehouseBatchWise , @ProductInflowSourceIDTable , @StockCheckDate , @ErrorMsg output, 
	@CompanyID , @IsTaxable
	if @ErrorMsg <> ''
	BEGIN
		RAISERROR (@ErrorMsg ,16 , 1);
		return
	END
	
	--delete from data_ProductInflowBatch where SourceName =  'MFG IN'  AND SourceID in (select SourceID from  @ProductInflowSourceIDTable ) 
	delete from data_ProductInflowBatch where SourceName =  'MFG IN'  AND SourceID in (select SourceID from  @ManufacturingdetailFGIDS ) 
	delete from data_ProductInflow where SourceName =  'MFG IN'  AND SourceID in (select SourceID from  @ProductInflowSourceIDTable ) and IsDeleted = 1
END


set @MfgOverHeadCost=@MfgOverHeadRate*@Quantity

----Start Account Voucher
--exec data_ManufacturingInfo_InsertAccount @ManufacturingID = @ManufacturingID, @CompanyID = @CompanyID, @ManufacturingDate = @ManufacturingDate , 
--@WHID = @WHID , @ManufacturingNo = @ManufacturingNo , @UserID = @UserID , @FiscalID = @FiscalID ,@EditMode = @EditMode, @BranchID = @BranchID, @IsTaxable = @IsTaxable
--, @Remarks = @Remarks ,@MfgOverHeadCost=@MfgOverHeadCost, @data_ManufacturingDetail = @data_ManufacturingDetail,@ManufacturingStyle=@ManufacturingStyle,@LabourContractor=@LabourContractor,@PackingCharges=@PackingCharges,@data_ManufacturingFormulaDetail=@data_ManufacturingFormulaDetail,@khradiaId=@khradiaId,@KhradiaCost=@KhradiaCost
----End Account Voucher																																																																		  





Go

/****** Object:  StoredProcedure [dbo].[data_ManufacturingInfo_Insert]    Script Date: 9/8/2021 5:18:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




ALTER procedure [dbo].[data_ManufacturingInfo_Insert] 
@ManufacturingID int  output , 
@UserID int = null , 
@CompanyID int = null , 
@FiscalID int = null ,
@BOMID int = null , 
@ManufacturingNo int = null , 
@ItemId int = null , 
@ManufacturingDate date = null , 
@Quantity numeric(18, 3) = null , 
@WHID int = null , 
@BranchID int=null,
@Remarks varchar(300) = null ,
@ManufacturingStyle varchar(30) = null ,
@IsTaxable bit=0,
@data_ManufacturingDetail  data_ManufacturingDetail readonly ,
@data_ItemBatchDetail  data_ItemBatchDetail readonly ,
@data_ItemBatchDetailFinish  data_ItemBatchDetail readonly ,
@data_ManufacturingFormulaDetail data_ManufacturingFormulaDetail readonly ,
@ReformulationWorking bit=0 ,
@CartonQuantity numeric(18, 3) = 0,
@LooseQuantity numeric(18, 3) = 0,
@MfgOverHeadCost numeric(18, 3) = 0,
@MfgOverHeadRate numeric(18, 3) = 0,
--@AutoCode nvarchar(50)=null,
@ExpiryDate date = null,
@ManualCode nvarchar(50)=null,
@ReleaseNo int =null,
@ReleaseOrderID int=null,
@Minutes int =null,
@Hours int = null,
@MotorName		   nvarchar(50)=null,
@HP				   nvarchar(50)=null,
@Condition		   nvarchar(50)=null,
@Shape			   nvarchar(50)=null,
@Winding		   nvarchar(50)=null,
@WindingCondition  nvarchar(50)=null,
@RotorSize		  nvarchar(50)=null,
@Lead			  nvarchar(50)=null,
@Ampare			  nvarchar(50)=null,
@Bearing1		  nvarchar(50)=null,
@Bearing2		  nvarchar(50)=null,
@Impeller		  nvarchar(50)=null,
@Khradiya		  nvarchar(50)=null,
@InvoiceNo		  nvarchar(50)=null,
@MotorNumber	   nvarchar(50)=null,
@OldPic			  nvarchar(250)=null,
@AfterMPic		  nvarchar(250)=null,
@LabourContractor		int= NULL,
@PackingCharges numeric(18,3)= NULL,
@NetAmountformula numeric(18,3)= NULL,
@biltyno	  nvarchar(50)=null,
@PartyID		int= NULL,
@khradiaId int= NULL,
@KhradiaCost numeric(18, 3) =NULL,
@MfgTrimmingPercentage numeric(18, 3)=NULL,
@TrimmingQuantity numeric(18, 3)=NULL
as
declare @EditMode bit  = 0, @StockCheckDate date,@AutoCode nvarchar(50)=null

if	 @ManufacturingID = 0
BEGIN
	declare @MaxTable as MaxTable 
	insert into @MaxTable	
	exec GetVoucherNoI @Fieldname=N'ManufacturingNo',@TableName=N'data_ManufacturingInfo',@CheckTaxable= 1 ,@PrimaryKeyValue = @ManufacturingID,@PrimaryKeyFieldName = 'ManufacturingID' ,
	@voucherDate=@ManufacturingDate,@voucherDateFieldName=N'ManufacturingDate',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=@FiscalID, 
	@FiscalIDFieldName=N'FiscalID',@IsTaxable=@IsTaxable
	select @ManufacturingNo = VoucherNo from @MaxTable	
	set @StockCheckDate = @ManufacturingDate
	
	Select @AutoCode= 'Batch-'+cast(((select max(data_ManufacturingInfo.ManufacturingID)+1 from data_ManufacturingInfo where CompanyID=@CompanyID)) as nvarchar(50))
	
	Insert into data_ManufacturingInfo ( 
		EntryUserID , 
		EntryUserDateTime , 
		CompanyID , 
		FiscalID ,
		BOMID , 
		ManufacturingNo , 
		ItemId , 
		ManufacturingDate , 
		Quantity , 
		WHID , 
		Remarks ,
		ManufacturingStyle,
		BranchID,
		IsTaxable,
		ReformulationWorking,
		CartonQuantity,
		LooseQuantity,
		MfgOverHeadCost,
		MfgOverHeadRate,
		AutoCode,
		ManualCode,
		ExpiryDate,
		ReleaseNo,
		ReleaseOrderID,Minutes,Hours,
		MotorName		 
		,HP				 
		,Condition		 
		,Shape			 
		,Winding		 
		,WindingCondition
		,RotorSize		 
		,Lead			 
		,Ampare			 
		,Bearing1		 
		,Bearing2		 
		,Impeller		 
		,Khradiya		 
		,InvoiceNo		 
		,MotorNumber	 
		,OldPic			 
		,AfterMPic
		,LabourContractor
		,PackingCharges	
		
		
	 ) Values (
		@UserID , 
		GETDATE() ,
		@CompanyID , 
		@FiscalID ,
		@BOMID , 
		@ManufacturingNo , 
		@ItemId , 
		@ManufacturingDate , 
		@Quantity , 
		@WHID , 
		@Remarks ,
		@ManufacturingStyle,
		@BranchID,
		@IsTaxable,
		@ReformulationWorking ,
		@CartonQuantity,
		@LooseQuantity,
		@MfgOverHeadCost,
		@MfgOverHeadRate,
	    @AutoCode,
		@ManualCode,
		@ExpiryDate,
		@ReleaseNo,
		@ReleaseOrderID,@Minutes,@Hours
		,@MotorName		 
		,@HP				 
		,@Condition		 
		,@Shape			 
		,@Winding		 
		,@WindingCondition
		,@RotorSize		 
		,@Lead			 
		,@Ampare			 
		,@Bearing1		 
		,@Bearing2		 
		,@Impeller		 
		,@Khradiya		 
		,@InvoiceNo		 
		,@MotorNumber	 
		,@OldPic			 
		,@AfterMPic
		,@LabourContractor
		,@PackingCharges				 
		
		)
	set @ManufacturingID = @@IDENTITY
	
END

ELSE

BEGIN	
	
	select @StockCheckDate = ManufacturingDate from data_ManufacturingInfo where ManufacturingID = @ManufacturingID

	if @StockCheckDate > @ManufacturingDate
	BEGIN
		set @StockCheckDate = @ManufacturingDate
	END

	declare @SaveVoucherdate date , @IsVoucherNoMonthly bit
select @IsVoucherNoMonthly = IsVoucherNoMonthly from gen_SystemConfiguration where CompanyID =  @CompanyID

if @IsVoucherNoMonthly = 1
BEGIN
	select @SaveVoucherdate = ManufacturingDate from data_ManufacturingInfo where ManufacturingID = @ManufacturingID

	if MONTH(@ManufacturingDate) <> MONTH(@SaveVoucherdate) or  YEAR(@ManufacturingDate) <> YEAR(@SaveVoucherdate)
	BEGIN
		insert into @MaxTable
		exec GetVoucherNoI @Fieldname=N'ManufacturingNo',@TableName=N'data_ManufacturingInfo',@CheckTaxable= 1 ,@PrimaryKeyValue = @ManufacturingID,@PrimaryKeyFieldName = 'ManufacturingID' ,
		@voucherDate=@ManufacturingDate,@voucherDateFieldName=N'ManufacturingDate',@companyID=@CompanyID,@companyFieldName=N'CompanyID',@FiscalID=@FiscalID, 
		@FiscalIDFieldName=N'FiscalID',@IsTaxable=@IsTaxable
		select @ManufacturingNo = VoucherNo from @MaxTable

	END
END
Select @AutoCode= 'Batch-'+cast(((select max(data_ManufacturingInfo.ManufacturingID) from data_ManufacturingInfo where CompanyID=@CompanyID and data_ManufacturingInfo.ManufacturingID=@ManufacturingID)) as nvarchar(50))
	update data_ManufacturingInfo set	
	ModifyUserID = @UserID , 
	ModifyUserDateTime = GETDATE() , 
	CompanyID = @CompanyID , 
	FiscalID = @FiscalID ,
	BOMID = @BOMID , 
	ManufacturingNo = @ManufacturingNo , 
	ItemId = @ItemId , 
	ManufacturingDate = @ManufacturingDate , 
	Quantity = @Quantity , 
	WHID = @WHID , 
	Remarks = @Remarks,
	BranchID=@BranchID,
	IsTaxable = @IsTaxable,
	ReformulationWorking = @ReformulationWorking ,
	CartonQuantity = @CartonQuantity ,
	LooseQuantity = @LooseQuantity,
	MfgOverHeadCost=@MfgOverHeadCost,
	MfgOverHeadRate=@MfgOverHeadRate,
	AutoCode=@AutoCode,
    ManualCode=@ManualCode,
	ExpiryDate=@ExpiryDate,
	ReleaseNo=@ReleaseNo,
	ReleaseOrderID=@ReleaseOrderID,
	Minutes=@Minutes,
	Hours=@Hours,
	MotorName		 =@MotorName		, 
	HP				 =@HP				, 
	Condition		 =@Condition		, 
	Shape			 =@Shape			, 
	Winding		 =@Winding		 	  ,
	WindingCondition=@WindingCondition,
	RotorSize		 =@RotorSize	,	 
	Lead			 =@Lead			, 
	Ampare			 =@Ampare		,	 
	Bearing1		 =@Bearing1		, 
	Bearing2		 =@Bearing2		, 
	Impeller		 =@Impeller		, 
	Khradiya		 =@Khradiya		, 
	InvoiceNo		 =@InvoiceNo	,	 
	MotorNumber	 =@MotorNumber	 	,
	OldPic			 =@OldPic		,	 
	AfterMPic		 =@AfterMPic	
	,LabourContractor=@LabourContractor
	,PackingCharges=@PackingCharges	
				 
	--,
	--ManufacturingStyle = @ManufacturingStyle
	where ManufacturingID = @ManufacturingID


	declare @ProductInflowSourceIDTable as data_ProductInflow , @ItemsWarehouseBatchWise as ItemsWarehouseBatchWise
	declare @ManufacturingdetailFGIDS as data_ProductInflow 
	insert into @ProductInflowSourceIDTable (SourceID) select ManufacturingID from data_ManufacturingInfo where ManufacturingID = @ManufacturingID
	insert into @ManufacturingdetailFGIDS (SourceID) select ManufacturingFGParamsID from data_ManufacturingDetailParamsFG where ManufacturingID = @ManufacturingID
	
	

	if (select count(*) from @data_ItemBatchDetailFinish) > 0
	BEGIN
		insert into @ItemsWarehouseBatchWise (ItemID,WHID,Param1,Param2,Param3)
		select @ItemId,@WHID ,Param1,Param2,Param3 from @data_ItemBatchDetailFinish
	END
	else 
	BEGIN
		insert into @ItemsWarehouseBatchWise (ItemID,WHID)
		select @ItemId,@WHID 
	END

	--declare @asss as xml = (select * from @ItemsWarehouseBatchWise for xml auto)
	--declare @assssss as xml = (select * from @ProductInflowSourceIDTable for xml auto)

	update data_ProductInflow set IsDeleted = 1 where SourceName = 'MFG IN' and SourceID in (select SourceID from @ProductInflowSourceIDTable )


	delete from data_ProductOutflowBatch where SourceName = 'MFG OUT' and SourceID in (select ManufacturingDetailID from data_ManufacturingDetail where ManufacturingID = @ManufacturingID) 	
	delete from data_ProductOutflow where SourceName = 'MFG OUT' and SourceID in (select ManufacturingDetailID from data_ManufacturingDetail where ManufacturingID = @ManufacturingID) 	
	delete from data_ManufacturingDetailParams where ManufacturingID = @ManufacturingID
	delete from data_ManufacturingDetailParamsFG where ManufacturingID = @ManufacturingID
	delete from data_ManufacturingDetail where ManufacturingID = @ManufacturingID
	delete from data_ProductInflow where SourceName = 'MFG IN' and SourceID in (select ManufacturingFormulaDID from data_ManufacturingFormulaDetail where ManufacturingID = @ManufacturingID) 
	delete from data_ManufacturingFormulaDetail where ManufacturingID = @ManufacturingID
	set	@EditMode = 1
END
	

declare @RowID int,@ManufacturingDetailID int ,@StockRate numeric(14,5) , @ActualQuantity numeric(10,2),@RawItemId int,@stockQty numeric(14,2),
@ItemName varchar(200),@ERRORMSG varchar(200),@WhIDDetail int,@MfgTrimmingPerDetail numeric(18,3)=0,@TrimDetail numeric(18,3)=0,@TotalUsedQuantity numeric(18,3)=0,
@WastageItemId int=0

Select @WastageItemId =RawItemID from gen_SystemConfiguration where CompanyID=@CompanyID
 
--declare @jj as xml = (select * from @data_ManufacturingDetail for xml auto)

declare firstcursor cursor for
select RowID from @data_ManufacturingDetail
open firstcursor
fetch next from firstcursor into @RowID
while @@FETCH_STATUS = 0
	begin
		declare @checkRate bit = 1
		
		set @TotalUsedQuantity=@ActualQuantity+@TrimDetail
		exec CheckStock @ItemID = @RawItemId ,
			@WHID = @WhIDDetail , 
			@StockDate = @ManufacturingDate , 
			@CompanyID = @CompanyID,			
			@RowID = @RowID ,
			@AllowNegativeStock = 0,
			@Quantity = @ActualQuantity,
			@ERRORMSG = @ERRORMSG out,
			@checkRate = @checkRate out,
			@data_ItemBatchDetail =  @data_ItemBatchDetail ,
			@IsTaxable = @IsTaxable


			if @ERRORMSG != ''
			BEGIN
				RAISERROR (@ERRORMSG , 16, 1 ) ;
				return
			END
			
		--exec GetStockQuantity @RawItemId ,@WhIDDetail , @ManufacturingDate , @stockQty output , @ItemName out , @CompanyID
		
		--if  @stockQty < @ActualQuantity 
		--BEGIN
		--	set @ERRORMSG = 'Stock is not enough of Item ' + @ItemName
		--	 RAISERROR (@ERRORMSG , 16, 1 ) ;
		--	 return
		--END


		Insert Into data_ManufacturingDetail (
		ManufacturingID ,
		ItemId ,
		BOMQuantity ,
		ActualQuantity ,
		WHID ,
		StockRate,
		BOMFormulaQuantity ,
		ReleaseOrderDetailID
		

		) Select
		@ManufacturingID ,
		ItemId ,
		BOMQuantity ,
		ActualQuantity ,
		WHID ,
		0,
		BOMFormulaQuantity ,
		ReleaseOrderDetailID
		
		
		From @data_ManufacturingDetail where RowID = @RowID

		set @ManufacturingDetailID = @@IDENTITY		



		declare @productInflowID int,@ProductOutflowID int

		exec GetWeightedRateForItem @RawItemId, @WhIDDetail ,@ManufacturingDate ,@ManufacturingDate ,@StockRate output , @CompanyID , @IsTaxable

		update data_ManufacturingDetail set StockRate = ISNULL(@StockRate,0) where ManufacturingDetailID = @ManufacturingDetailID
		Set @StockRate=ISNULl(@StockRate,1)
		exec data_ProductOutflow_Insert @ProductOutflowID out,null,@RawItemId,@ManufacturingDetailID,'MFG OUT',@WhIDDetail, @ManufacturingDate ,
		@StockRate , @ActualQuantity , @FiscalID , @CompanyID , @IsTaxable,null,null,null,null,null,@BranchID
		exec tempOutflowDataTable_Insert @ProductOutflowID ,'MFG OUT'

		if @TrimDetail>0
		begin
		
		exec data_ProductInflow_Insert @productInflowID out , @WastageItemId , @ManufacturingID , 'MFG IN' , @WHID , @ManufacturingDate , @StockRate , 
		@TrimDetail , @TrimDetail , @FiscalID , @CompanyID , @IsTaxable,null,null,null,null,null,@BranchID
		exec tempInflowDataTable_Insert @productInflowID ,'MFG IN'


		end
		

		

		Insert Into data_ManufacturingDetailParams(
		ManufacturingDetailID ,
		ManufacturingID ,
		ItemId ,
		Quantity ,
		Param1 ,
		Param2 ,
		Param3 
		) Select
		@ManufacturingDetailID ,
		@ManufacturingID ,
		@RawItemId ,
		Quantity ,
		Param1 ,
		Param2 ,
		Param3 
		From @data_ItemBatchDetail
		Where RowID = @RowID

		DECLARE @Gid uniqueidentifier = CAST(CONTEXT_INFO() as uniqueidentifier);
		DELETE FROM tempOutflowDataTable WHERE [GUID] = @Gid;		

	FETCH NEXT FROM firstcursor INTO @RowID
	END

close firstcursor
deallocate firstcursor



select @StockRate = sum( StockRate * ActualQuantity ) from data_ManufacturingDetail where ManufacturingID = @ManufacturingID

set @StockRate  =(@StockRate+(@MfgOverHeadRate*@Quantity)) /@Quantity

update data_ManufacturingInfo set StockRate = @StockRate where ManufacturingID = @ManufacturingID

exec data_ProductInflow_Insert @productInflowID out , @ItemId , @ManufacturingID , 'MFG IN' , @WHID , @ManufacturingDate , @StockRate , 
@Quantity , @Quantity , @FiscalID , @CompanyID , @IsTaxable,null,null,null,@ExpiryDate,@ManualCode,@BranchID
exec tempInflowDataTable_Insert @productInflowID ,'MFG IN'





		Insert Into data_ManufacturingDetailParamsFG(		
		ManufacturingID ,
		ItemId ,
		Quantity ,
		Param1 ,
		Param2 ,
		Param3 
		) Select		
		@ManufacturingID ,
		@ItemId ,
		Quantity ,
		Param1 ,
		Param2 ,
		Param3 
		From @data_ItemBatchDetailFinish

		declare @RawItemId1 int ,@QTY numeric(18, 3),@Rate numeric(18, 3),@netamo numeric(18, 3),@ManufacturingFormulaDID int

declare firstcursor1 cursor for
select RowID from @data_ManufacturingFormulaDetail
open firstcursor1
fetch next from firstcursor1 into @RowID
while @@FETCH_STATUS = 0
	begin
		
		select @RawItemId1 = ItemId ,@QTY = Quantity , @Rate = Rate,@netamo= NetAmount From @data_ManufacturingFormulaDetail where RowID = @RowID
		




		
Insert Into data_ManufacturingFormulaDetail(		
		ManufacturingID ,
		ItemId ,
		Quantity ,
		Rate ,
		NetAmount 
		) Select		
		@ManufacturingID ,
		ItemId ,
		Quantity ,
		Rate ,
		NetAmount 
		From @data_ManufacturingFormulaDetail where RowID = @RowID
			

		set @ManufacturingFormulaDID = @@IDENTITY		

exec data_ProductInflow_Insert @productInflowID out , @RawItemId1 , @ManufacturingFormulaDID , 'MFG IN' , @WHID , @ManufacturingDate , @Rate , 
@QTY , @QTY , @FiscalID , @CompanyID , @IsTaxable,null,null,null,@ExpiryDate,@ManualCode,@BranchID
exec tempInflowDataTable_Insert @productInflowID ,'MFG IN'
		FETCH NEXT FROM firstcursor1 INTO @RowID
	END



close firstcursor1
deallocate firstcursor1
set @Gid = CAST(CONTEXT_INFO() as uniqueidentifier);
DELETE FROM tempInflowDataTable WHERE [GUID] = @Gid;

--check Stock Available Or not of Inserted Item
if @EditMode = 1
BEGIN	
	set @ErrorMsg = ''
	exec CheckDeletedStock 'MFG IN', @ItemsWarehouseBatchWise , @ProductInflowSourceIDTable , @StockCheckDate , @ErrorMsg output, 
	@CompanyID , @IsTaxable
	if @ErrorMsg <> ''
	BEGIN
		RAISERROR (@ErrorMsg ,16 , 1);
		return
	END
	
	--delete from data_ProductInflowBatch where SourceName =  'MFG IN'  AND SourceID in (select SourceID from  @ProductInflowSourceIDTable ) 
	delete from data_ProductInflowBatch where SourceName =  'MFG IN'  AND SourceID in (select SourceID from  @ManufacturingdetailFGIDS ) 
	delete from data_ProductInflow where SourceName =  'MFG IN'  AND SourceID in (select SourceID from  @ProductInflowSourceIDTable ) and IsDeleted = 1
END


set @MfgOverHeadCost=@MfgOverHeadRate*@Quantity

----Start Account Voucher
--exec data_ManufacturingInfo_InsertAccount @ManufacturingID = @ManufacturingID, @CompanyID = @CompanyID, @ManufacturingDate = @ManufacturingDate , 
--@WHID = @WHID , @ManufacturingNo = @ManufacturingNo , @UserID = @UserID , @FiscalID = @FiscalID ,@EditMode = @EditMode, @BranchID = @BranchID, @IsTaxable = @IsTaxable
--, @Remarks = @Remarks ,@MfgOverHeadCost=@MfgOverHeadCost, @data_ManufacturingDetail = @data_ManufacturingDetail,@ManufacturingStyle=@ManufacturingStyle,@LabourContractor=@LabourContractor,@PackingCharges=@PackingCharges,@data_ManufacturingFormulaDetail=@data_ManufacturingFormulaDetail,@khradiaId=@khradiaId,@KhradiaCost=@KhradiaCost
----End Account Voucher																																																																		  




Go
