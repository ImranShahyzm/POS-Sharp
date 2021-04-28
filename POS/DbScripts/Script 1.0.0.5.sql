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
	LocationID int NULL
GO
ALTER TABLE dbo.gen_PosConfiguration SET (LOCK_ESCALATION = TABLE)
GO
COMMIT



/****** Object:  StoredProcedure [dbo].[POSdata_StockIssuancetoPosKitchenDetailInfo_Insert]    Script Date: 4/16/2021 12:36:35 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockIssuancetoPosKitchenDetailInfo_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_StockIssuancetoPosKitchenDetailInfo_Insert]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_StockIssuance_delete]    Script Date: 4/16/2021 12:36:35 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockIssuance_delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_StockIssuance_delete]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_data_StockIssuancetoPosKitchen_data_StockIssuancetoPosKitchen]') AND parent_object_id = OBJECT_ID(N'[dbo].[data_StockIssuancetoPosKitchen]'))
ALTER TABLE [dbo].[data_StockIssuancetoPosKitchen] DROP CONSTRAINT [FK_data_StockIssuancetoPosKitchen_data_StockIssuancetoPosKitchen]
GO
/****** Object:  Table [dbo].[data_StockIssuancetoPosKitchenDetail]    Script Date: 4/16/2021 12:36:35 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockIssuancetoPosKitchenDetail]') AND type in (N'U'))
DROP TABLE [dbo].[data_StockIssuancetoPosKitchenDetail]
GO
/****** Object:  Table [dbo].[data_StockIssuancetoPosKitchen]    Script Date: 4/16/2021 12:36:35 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockIssuancetoPosKitchen]') AND type in (N'U'))
DROP TABLE [dbo].[data_StockIssuancetoPosKitchen]
GO
/****** Object:  UserDefinedTableType [dbo].[data_StockIssuancetoPosKitchenDetail]    Script Date: 4/16/2021 12:36:35 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_StockIssuancetoPosKitchenDetail' AND ss.name = N'dbo')
DROP TYPE [dbo].[data_StockIssuancetoPosKitchenDetail]
GO
/****** Object:  UserDefinedTableType [dbo].[data_StockIssuancetoPosKitchenDetail]    Script Date: 4/16/2021 12:36:35 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_StockIssuancetoPosKitchenDetail' AND ss.name = N'dbo')
CREATE TYPE [dbo].[data_StockIssuancetoPosKitchenDetail] AS TABLE(
	[RowID] [int] NULL,
	[Issuance] [int] NULL,
	[ItemId] [int] NULL,
	[Quantity] [numeric](18, 3) NULL,
	[StockRate] [numeric](14, 5) NOT NULL,
	[CartonQuantity] [numeric](18, 3) NULL,
	[LooseQuantity] [numeric](18, 3) NULL,
	[TransferDetailID] [int] NULL
)
GO
/****** Object:  Table [dbo].[data_StockIssuancetoPosKitchen]    Script Date: 4/16/2021 12:36:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockIssuancetoPosKitchen]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[data_StockIssuancetoPosKitchen](
	[IssuanceID] [int] IDENTITY(1,1) NOT NULL,
	[EntryUserID] [int] NULL,
	[EntryUserDateTime] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyUserDateTime] [datetime] NULL,
	[CompanyID] [int] NULL,
	[FiscalID] [int] NULL,
	[IssuanceDate] [date] NULL,
	[IssuanceNo] [int] NULL,
	[FromWHID] [int] NULL,
	[LocationID] [int] NULL,
	[IsTaxable] [bit] NULL,
	[Remarks] [nvarchar](max) NULL,
	[RefID] [int] NULL,
	[isManual] [bit] NULL,
	[IssuanceType] [int] NULL,
 CONSTRAINT [PK_data_StockIssuancetoPosKitchen_1] PRIMARY KEY CLUSTERED 
(
	[IssuanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[data_StockIssuancetoPosKitchenDetail]    Script Date: 4/16/2021 12:36:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockIssuancetoPosKitchenDetail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[data_StockIssuancetoPosKitchenDetail](
	[IssuanceDetailID] [int] IDENTITY(1,1) NOT NULL,
	[IssuanceID] [int] NULL,
	[ItemId] [int] NULL,
	[Quantity] [numeric](18, 3) NULL,
	[StockRate] [numeric](14, 5) NOT NULL,
	[CartonQuantity] [numeric](18, 3) NULL,
	[LooseQuantity] [numeric](18, 3) NULL,
	[TransferDetailID] [int] NULL,
 CONSTRAINT [PK_data_StockIssuancetoPosKitchenDetail] PRIMARY KEY CLUSTERED 
(
	[IssuanceDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_data_StockIssuancetoPosKitchen_data_StockIssuancetoPosKitchen]') AND parent_object_id = OBJECT_ID(N'[dbo].[data_StockIssuancetoPosKitchen]'))
ALTER TABLE [dbo].[data_StockIssuancetoPosKitchen]  WITH CHECK ADD  CONSTRAINT [FK_data_StockIssuancetoPosKitchen_data_StockIssuancetoPosKitchen] FOREIGN KEY([IssuanceID])
REFERENCES [dbo].[data_StockIssuancetoPosKitchen] ([IssuanceID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_data_StockIssuancetoPosKitchen_data_StockIssuancetoPosKitchen]') AND parent_object_id = OBJECT_ID(N'[dbo].[data_StockIssuancetoPosKitchen]'))
ALTER TABLE [dbo].[data_StockIssuancetoPosKitchen] CHECK CONSTRAINT [FK_data_StockIssuancetoPosKitchen_data_StockIssuancetoPosKitchen]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_StockIssuance_delete]    Script Date: 4/16/2021 12:36:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockIssuance_delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_StockIssuance_delete] AS' 
END
GO


ALTER procedure [dbo].[POSdata_StockIssuance_delete] @IssuanceID int  as

	declare @AccountVoucherID int
	

	declare @ProductInflowSourceIDTable as data_ProductInflow, @ItemsWarehouseBatchWise as ItemsWarehouseBatchWise,@PurchaseDate date , 
	@CompanyID int , @IsTaxable bit = 0
	
	select @PurchaseDate=IssuanceDate , @CompanyID = CompanyID ,
	 @IsTaxable = IsTaxable from  data_stockissuancetoPosKitchen where IssuanceID = @IssuanceID

	insert into @ProductInflowSourceIDTable (SourceID)
	select IssuanceDetailID from data_StockIssuancetoPosKitchenDetail where IssuanceID = @IssuanceID

	
	update data_ProductInflow set IsDeleted = 1 where SourceName = 'KITCHENSTOCK IN' and SourceID in (select SourceID from @ProductInflowSourceIDTable )

	declare @ErrorMsg varchar(200) 
	set @ErrorMsg = ''
	exec CheckDeletedStock 'KITCHENSTOCK IN', @ItemsWarehouseBatchWise , @ProductInflowSourceIDTable , @PurchaseDate , @ErrorMsg output , @CompanyID , @IsTaxable
	if @ErrorMsg <> ''
	BEGIN
		RAISERROR (@ErrorMsg ,16 , 1);
		return
	END
	Delete from data_ProductOutflow where SourceName='POSSTOCKOUT' and SourceID in (select IssuanceDetailID from data_StockIssuancetoPosKitchenDetail where IssuanceID = @IssuanceID) 
	delete from data_ProductInflow where SourceName =  'KITCHENSTOCK IN'  AND SourceID in (select SourceID from  @ProductInflowSourceIDTable )	
	
	
	delete from data_StockIssuancetoPosKitchenDetail where IssuanceID =  @IssuanceID
	delete from data_StockIssuancetoPosKitchen where IssuanceID =  @IssuanceID
	

	
	








GO
/****** Object:  StoredProcedure [dbo].[POSdata_StockIssuancetoPosKitchenDetailInfo_Insert]    Script Date: 4/16/2021 12:36:35 PM ******/
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
@ItemName varchar(200),@ERRORMSG varchar(200)

 
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
