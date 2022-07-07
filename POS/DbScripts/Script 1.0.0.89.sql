





alter procedure [dbo].[data_ProductOutflow_Insert] 
@ProductOutflowID int  output , 
@ProductInflowID int = null , 
@ItemId int = null , 
@SourceID int = null , 
@SourceName varchar(50) = null , 
@WHID int = null , 
@StockDate date = null , 
@StockRate numeric(14, 5) = null , 
@Quantity numeric(10, 2) = null ,
@FiscalID int  = null ,
@CompanyID int  = null ,
@IsTaxable bit = 0,
@LocationId int=NULL,
@FlockId int=NULL,
@IssueWeight numeric(18, 3) = null,
@ExpiryDate	date =null,
@BatchNo	nvarchar(50) =null ,
@BranchID int=NULL,
@ShedId int=null,
@RowID int=null,
@data_ItemBatchDetail  data_ItemBatchDetail readonly
as


	Insert into data_ProductOutflow ( 
		ProductInflowID , 
		ItemId , 
		SourceID , 
		SourceName , 
		WHID , 
		StockDate , 
		StockRate , 
		Quantity ,
		FiscalID ,
		CompanyID ,
		IsTaxable,
		LocationId,
		FlockId,
		IssueWeight,
		ExpiryDate,
		BatchNo,
		BranchID,
		ShedId

	 ) Values (
		@ProductInflowID , 
		@ItemId , 
		@SourceID , 
		@SourceName , 
		@WHID , 
		@StockDate , 
		@StockRate , 
		@Quantity ,
		@FiscalID ,
		@CompanyID ,
		@IsTaxable,
		@LocationId,
		@FlockId ,
		@IssueWeight,
		@ExpiryDate,
		@BatchNo,
		@BranchID,
		@ShedId

	)	
	set @ProductOutflowID = @@IDENTITY

	INSERT INTO data_ProductOutflowBatch
	(
		ProductOutflowID ,
		SourceID ,
		SourceName ,
		ItemId ,
		Quantity ,
		Param1 ,
		Param2 ,
		Param3
	) 
	SELECT 
		@ProductOutflowID ,
		@SourceID , 
		@SourceName ,
		@ItemId , 
		Quantity ,
		Param1 ,
		Param2 ,
		Param3
	FROM @data_ItemBatchDetail
	Where RowID = @RowID



Go