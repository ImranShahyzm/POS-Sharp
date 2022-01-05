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
ALTER TABLE dbo.data_SalePosInfoServer ADD
	CounterID int NULL
GO
ALTER TABLE dbo.data_SalePosInfoServer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

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
ALTER TABLE dbo.data_SalePosReturnInfoServer ADD
	CounterID int NULL
GO
ALTER TABLE dbo.data_SalePosReturnInfoServer SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


/****** Object:  StoredProcedure [dbo].[POSdata_SaleandReturnInfoServer_Insert]    Script Date: 10/8/2021 9:54:31 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleandReturnInfoServer_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_SaleandReturnInfoServer_Insert]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleReturnInfoServer_InsertAccount]    Script Date: 10/8/2021 9:52:35 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleReturnInfoServer_InsertAccount]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_SaleReturnInfoServer_InsertAccount]
GO

/****** Object:  StoredProcedure [dbo].[POSdata_SaleandReturnInfoServer_InsertAccount]    Script Date: 10/8/2021 9:50:56 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleandReturnInfoServer_InsertAccount]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_SaleandReturnInfoServer_InsertAccount]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleWisePosInfoServer_Insert]    Script Date: 10/8/2021 9:47:49 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleWisePosInfoServer_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_SaleWisePosInfoServer_Insert]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleReturnWiseInfoServer_Insert]    Script Date: 10/8/2021 9:47:49 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleReturnWiseInfoServer_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_SaleReturnWiseInfoServer_Insert]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleandReturnInfoServer_SelectAll]    Script Date: 10/8/2021 9:47:49 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleandReturnInfoServer_SelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_SaleandReturnInfoServer_SelectAll]
GO
/****** Object:  UserDefinedTableType [dbo].[data_SalePosReturnInfoServer]    Script Date: 10/8/2021 9:47:49 AM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_SalePosReturnInfoServer' AND ss.name = N'dbo')
DROP TYPE [dbo].[data_SalePosReturnInfoServer]
GO
/****** Object:  UserDefinedTableType [dbo].[data_SalePosInfoServer]    Script Date: 10/8/2021 9:47:49 AM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_SalePosInfoServer' AND ss.name = N'dbo')
DROP TYPE [dbo].[data_SalePosInfoServer]
GO
/****** Object:  UserDefinedTableType [dbo].[data_SalePosInfoServer]    Script Date: 10/8/2021 9:47:49 AM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_SalePosInfoServer' AND ss.name = N'dbo')
CREATE TYPE [dbo].[data_SalePosInfoServer] AS TABLE(
	[SalePosID] [bigint] NOT NULL,
	[EntryUserID] [int] NULL,
	[EntryUserDateTime] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyUserDateTime] [datetime] NULL,
	[CompanyID] [int] NULL,
	[FiscalID] [int] NULL,
	[SalePosDate] [date] NULL,
	[WHID] [int] NULL,
	[TaxAmount] [decimal](18, 2) NULL,
	[GrossAmount] [decimal](18, 2) NULL,
	[DiscountPercentage] [decimal](18, 2) NULL,
	[DiscountAmount] [decimal](18, 2) NULL,
	[DiscountTotal] [decimal](18, 2) NULL,
	[OtherCharges] [decimal](18, 2) NULL,
	[NetAmount] [decimal](18, 2) NULL,
	[AmountReceive] [decimal](18, 2) NULL,
	[AmountReturn] [float] NULL,
	[SalePosReturnID] [bigint] NULL,
	[AmountInAccount] [decimal](18, 2) NULL,
	[AmountReceivable] [decimal](18, 2) NULL,
	[AmountPayable] [decimal](18, 2) NULL,
	[DirectReturn] [bit] NULL,
	[MfgID] [int] NULL,
	[CustomerPhone] [nvarchar](50) NULL,
	[CustomerName] [nvarchar](50) NULL,
	[SalePOSNo] [int] NULL,
	[isTaxable] [bit] NULL,
	[ExchangeAmount] [numeric](18, 3) NULL,
	[MenuId] [int] NULL,
	[InvoiceType] [int] NULL,
	[CardNumber] [nvarchar](max) NULL,
	[CardName] [nvarchar](1000) NULL,
	[CashPayment] [numeric](18, 3) NULL,
	[CardPayment] [numeric](18, 3) NULL,
	[SaleManId] [int] NULL,
	[RiderAmount] [numeric](18, 3) NULL,
	[LinckedBill] [int] NULL,
	CounterID int NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[data_SalePosReturnInfoServer]    Script Date: 10/8/2021 9:47:49 AM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_SalePosReturnInfoServer' AND ss.name = N'dbo')
CREATE TYPE [dbo].[data_SalePosReturnInfoServer] AS TABLE(
	[SalePosReturnID] [bigint] NULL,
	[SalePosID] [bigint] NULL,
	[EntryUserID] [int] NULL,
	[EntryUserDateTime] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyUserDateTime] [datetime] NULL,
	[CompanyID] [int] NULL,
	[FiscalID] [int] NULL,
	[SalePosReturnDate] [date] NULL,
	[WHID] [int] NULL,
	[TaxAmount] [decimal](18, 2) NULL,
	[GrossAmount] [decimal](18, 2) NULL,
	[DiscountPercentage] [decimal](18, 2) NULL,
	[DiscountAmount] [decimal](18, 2) NULL,
	[DiscountTotal] [decimal](18, 2) NULL,
	[OtherCharges] [decimal](18, 2) NULL,
	[NetAmount] [decimal](18, 2) NULL,
	[AmountReceive] [decimal](18, 2) NULL,
	[AmountReturn] [decimal](18, 2) NULL,
	[LogSourceID] [bigint] NULL,
	[AmountInAccount] [decimal](18, 2) NULL,
	[AmountReceivable] [decimal](18, 2) NULL,
	[AmountPayable] [decimal](18, 2) NULL,
	[CustomerPhone] [nvarchar](50) NULL,
	[CustomerName] [nvarchar](50) NULL,
	[SalePOSNo] [int] NULL,
	[MenuId] [int] NULL,
	[InvoiceType] [int] NULL,
	[SaleManId] [int] NULL,
	CounterID int NULL
)
GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleandReturnInfoServer_SelectAll]    Script Date: 10/8/2021 9:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleandReturnInfoServer_SelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_SaleandReturnInfoServer_SelectAll] AS' 
END
GO







ALTER procedure [dbo].[POSdata_SaleandReturnInfoServer_SelectAll] 
@WhereClause nvarchar(Max),
@BoolMaster bit=0,
@DetailMaster bit=0,
@WhereClauseDetail nvarchar(Max),
@WhereClauseReturn nvarchar(Max),
@WhereClauseReturnDetail nvarchar(Max)='',
@isSales bit=1
as

if @isSales =1
begin

if(@BoolMaster=1)
begin
exec('SELECT        SalePosID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, SalePosDate, WHID, TaxAmount, GrossAmount, DiscountPercentage, DiscountAmount, DiscountTotal, OtherCharges, 
                         NetAmount, AmountReceive, AmountReturn, SalePosReturnID, AmountInAccount, AmountReceivable, AmountPayable, DirectReturn, MfgID, CustomerPhone, CustomerName, SalePOSNo, isTaxable, ExchangeAmount, MenuId, 
                         InvoiceType, CardNumber, CardName, CashPayment, CardPayment, SaleManId,CounterID
FROM            data_SalePosInfo '+ @WhereClause)
end
if (@DetailMaster=1)
begin
exec('SELECT        data_SalePosDetail.* FROM            data_SalePosDetail inner join data_SalePosInfo on data_SalePosInfo.SalePosID=data_SalePosDetail.SalePosID '+ @WhereClauseDetail)
end
end
else
begin
if(@BoolMaster=1)
begin
exec('select * from data_SalePosReturnInfo '+ @WhereClauseReturn)
end
if (@DetailMaster=1)
begin
exec('SELECT        SalePosReturnDetailID, SalePosDetailID, data_SalePosReturnDetail.SalePosReturnID, ItemId, Quantity, ItemRate, TaxPercentage, data_SalePosReturnDetail.TaxAmount, data_SalePosReturnDetail.DiscountPercentage, data_SalePosReturnDetail.DiscountAmount, TotalAmount, IsLog, CartonSize, Carton, TotalQuantity, SchemeID, 
                         MinQuantity,StockRate,0 as isExchange

FROM            data_SalePosReturnDetail inner join data_SalePosReturnInfo on data_SalePosReturnInfo.SalePosReturnID=data_SalePosReturnDetail.SalePosReturnID '+ @WhereClauseReturn)
end

end







GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleReturnWiseInfoServer_Insert]    Script Date: 10/8/2021 9:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleReturnWiseInfoServer_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_SaleReturnWiseInfoServer_Insert] AS' 
END
GO







ALTER procedure [dbo].[POSdata_SaleReturnWiseInfoServer_Insert] 
@IsInserted int output ,
@data_SalePosReturnInfoServer data_SalePosReturnInfoServer readonly,
@data_SalePosReturnDetailServer  data_SalePosReturnDetailServer readonly,
@DateFrom Date=null,
@DateTo Date=null,
@CompanyID int=null,
@WHID int=null,
@SaleReturnPOSID int=0 
as


Delete from data_SalePosReturnDetailServer where SalePosReturnID =@SaleReturnPOSID and TrackBranchID=@WHID
Delete from data_SalePosReturnInfoServer  where WHID=@WHID and SalePosReturnID=@SaleReturnPOSID

insert into    data_SalePosReturnInfoServer(   SalePosReturnID, SalePosID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, SalePosReturnDate, WHID, TaxAmount, GrossAmount, DiscountPercentage, DiscountAmount, 
                         DiscountTotal, OtherCharges, NetAmount, AmountReceive, AmountReturn, LogSourceID, AmountInAccount, AmountReceivable, AmountPayable, CustomerPhone, CustomerName, SalePOSNo,SaleManId,CounterID)
						 Select 
						  SalePosReturnID, SalePosID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, SalePosReturnDate, WHID, TaxAmount, GrossAmount, DiscountPercentage, DiscountAmount, 
                         DiscountTotal, OtherCharges, NetAmount, AmountReceive, AmountReturn, LogSourceID, AmountInAccount, AmountReceivable, AmountPayable, CustomerPhone, CustomerName, SalePOSNo,SaleManId,CounterID
						 from @data_SalePosReturnInfoServer
insert into data_SalePosReturnDetailServer        (SalePosReturnDetailID, SalePosDetailID, SalePosReturnID, ItemId, Quantity, ItemRate, TaxPercentage, TaxAmount, DiscountPercentage, DiscountAmount, TotalAmount, IsLog, CartonSize, Carton, TotalQuantity,StockRate,TrackBranchID
)

SELECT      SalePosReturnDetailID, SalePosDetailID, SalePosReturnID, ItemId, Quantity, ItemRate, TaxPercentage, TaxAmount, DiscountPercentage, DiscountAmount, TotalAmount, IsLog, CartonSize, Carton, TotalQuantity,StockRate,@WHID
FROM            @data_SalePosReturnDetailServer


set @IsInserted=1

--exec POSdata_SaleReturnInfoServer_InsertAccount @IsInserted=@IsInserted,@data_SalePosReturnInfoServer=@data_SalePosReturnInfoServer,@data_SalePosReturnDetailServer=@data_SalePosReturnDetailServer,@DateFrom=@DateFrom,@DateTo=@DateTo,@CompanyID=@CompanyID,@WHID=@WHID






GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleWisePosInfoServer_Insert]    Script Date: 10/8/2021 9:47:49 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleWisePosInfoServer_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_SaleWisePosInfoServer_Insert] AS' 
END
GO







ALTER procedure [dbo].[POSdata_SaleWisePosInfoServer_Insert] 
@IsInserted int output ,
@data_SalePosInfoServer data_SalePosInfoServer readonly,
@data_SalePosDetailServer  data_SalePosDetailServer readonly,
@DateFrom Date=null,
@DateTo Date=null,
@CompanyID int=null,
@WHID int=null,
@SalePosID int=0 
as

delete from data_ProductOutflow where SourceName='POSSOLD' and SourceID in (select SalePosDetailID from @data_SalePosDetailServer) and WHID=@WHID
Delete from data_SalePosDetailServer where SalePosID =@SalePosID and TrackBranchID=@WHID
Delete from data_SalePosInfoServer  where WHID=@WHID and SalePosID =@SalePosID

insert into    data_SalePosInfoServer( SalePosID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, SalePosDate, WHID, TaxAmount, GrossAmount, DiscountPercentage, DiscountAmount, DiscountTotal, OtherCharges, 
                         NetAmount, AmountReceive, AmountReturn, SalePosReturnID, AmountInAccount, AmountReceivable, AmountPayable, DirectReturn, MfgID, CustomerPhone, CustomerName, SalePOSNo, isTaxable,ExchangeAmount,MenuId,InvoiceType,CardNumber,CardName,CashPayment,CardPayment,SaleManID,RiderAmount,LinckedBill,CounterID)
						 Select 
						 SalePosID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, SalePosDate, WHID, TaxAmount, GrossAmount, DiscountPercentage, DiscountAmount, DiscountTotal, OtherCharges, 
                         NetAmount, AmountReceive, AmountReturn, SalePosReturnID, AmountInAccount, AmountReceivable, AmountPayable, DirectReturn, MfgID, CustomerPhone, CustomerName, SalePOSNo, isTaxable,
						 ExchangeAmount,MenuId,InvoiceType,CardNumber,CardName,CashPayment,CardPayment,SaleManID,RiderAmount,LinckedBill,CounterID
						 from @data_SalePosInfoServer
insert into data_SalePosDetailServer        (SalePosDetailID, SalePosID, ItemId, Quantity, ItemRate, TaxPercentage, TaxAmount, DiscountPercentage, DiscountAmount, TotalAmount, ManaufacturingID, CartonSize, Carton, TotalQuantity
,SchemeID,MinQuantity,isExchange,StockRate,TrackBranchID)

SELECT        SalePosDetailID, SalePosID, ItemId, Quantity, ItemRate, TaxPercentage, TaxAmount, DiscountPercentage, DiscountAmount, TotalAmount, ManaufacturingID, CartonSize, Carton, TotalQuantity,SchemeID,MinQuantity,isExchange,StockRate,@WHID
FROM            @data_SalePosDetailServer


set @IsInserted=1

declare @RowID int,@IssuanceIDDetailID int ,@StockRate numeric(14,5) , @Quantity numeric(10,2),@ItemId int,@stockQty numeric(14,2),
@ItemName varchar(200),@ERRORMSG varchar(200),@productOutflowID int,@StockDate datetime,@FiscalID int=0,@BranchID int=null,@DirectReturn bit=0


--declare @jj as xml = (select * from @data_StockTransferDetail for xml auto)

declare firstcursor cursor for
select SalePosDetailID from @data_SalePosDetailServer
open firstcursor
fetch next from firstcursor into @RowID
while @@FETCH_STATUS = 0
	begin
		declare @checkRate bit = 1
	

	select @ItemId=itemid,@StockRate=StockRate,@Quantity=Quantity from @data_SalePosDetailServer where SalePosDetailID=@RowID
		Select @DirectReturn=DirectReturn,@StockDate=SalePosDate,@FiscalID=FiscalID,@CompanyID=CompanyID from @data_SalePosInfoServer where WHID=@WHID and SalePosID=@SalePosID
	exec GetWeightedRateForItem @ItemId, 0 ,@StockDate ,@StockDate ,@StockRate output , @CompanyID , 0
	if(@DirectReturn !=1)
	begin
		exec data_Productoutflow_Insert @productOutflowID output,null,@ItemId,@RowID,'POSSOLD',@WHID, 
		@StockDate ,@StockRate,@Quantity ,@FiscalID , @CompanyID , 0,null,null,null,null,null,null,null
		end
	FETCH NEXT FROM firstcursor INTO @RowID
	END

close firstcursor
deallocate firstcursor




--while @DateFrom<=@DateTo
--begin

--exec POSdata_SaleandReturnInfoServer_InsertAccount @IsInserted=@IsInserted,@data_SalePosInfoServer=@data_SalePosInfoServer,@data_SalePosDetailServer=@data_SalePosDetailServer,@DateFrom=@DateFrom,@DateTo=@DateFrom,@CompanyID=@CompanyID,@WHID=@WHID

--set @DateFrom =  DATEADD(d,1, @DateFrom)

--end







GO


/****** Object:  StoredProcedure [dbo].[POSdata_SaleandReturnInfoServer_InsertAccount]    Script Date: 10/8/2021 9:50:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleandReturnInfoServer_InsertAccount]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_SaleandReturnInfoServer_InsertAccount] AS' 
END
GO







ALTER procedure [dbo].[POSdata_SaleandReturnInfoServer_InsertAccount] 
@IsInserted int output ,
@data_SalePosInfoServer data_SalePosInfoServer readonly,
@data_SalePosDetailServer  data_SalePosDetailServer readonly,
@DateFrom Date=null,
@DateTo Date=null,
@CompanyID int=null,
@WHID int=null 
as

declare @TotalCashAmount numeric(18,3),@TotalSaleAmount numeric(18,3), @GLvDetail as GLvDetail ,@vID int = 0 ,@FiscalID int,@DiscountGL int,@RevenuePOS int,@CashPos int,@vType int=null
declare @TotalDiscount numeric(18,3)=0
select @TotalSaleAmount=sum(ItemRate*Quantity),@TotalCashAmount=sum(ItemRate*Quantity) from @data_SalePosDetailServer
Select @TotalDiscount=sum(DiscountTotal) from @data_SalePosInfoServer
Select @RevenuePOS=RevenueAccountPOS,@CashPos=CashAccountPos,@FiscalID=FiscalID,@DiscountGL=DiscountGL from gen_PosConfiguration where WHID=@WHID and CompanyID=@CompanyID

if @TotalDiscount>0 and @DiscountGL is not null
begin

set @TotalCashAmount=@TotalCashAmount-@TotalDiscount

end

if((Select Count(*) from GLVoucherType where Title='POSCRV' and Companyid=@CompanyID)>0)
begin
	Select @vType=Voucherid from GLVoucherType  where Title='POSCRV' and Companyid=@CompanyID
end
else
begin
insert into GLVoucherType (Title,Description,SystemType,Companyid)
values('POSCRV','System Generated POS Voucher please Do not Change its title',1,@CompanyID)

Select @vType=Voucherid from GLVoucherType  where Title='POSCRV' and Companyid=@CompanyID
update gen_SystemConfiguration set POSCashVoucher=@vType
end

declare @AccountVoucherID int
Select @AccountVoucherID =AccountVoucherID from  pos_ServerVouchers where WHID=@WHID and VoucherDate=@DateFrom and VoucherSource='POSSALE'
exec GLvMAIN_delete @vId=@AccountVoucherID
insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
values(@CashPos,0,0,'Total Sale From '+Cast(@DateFrom as nvarchar(50))+' To '+ cast(@DateTo as nvarchar(50))+' ',@TotalCashAmount)


insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,cr)
values(@RevenuePOS,0,0,'Total Sale From '+Cast(@DateFrom as nvarchar(50))+' To '+ cast(@DateTo as nvarchar(50))+' ',@TotalSaleAmount)
if @TotalDiscount>0 and @DiscountGL is not null
begin

insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
values(@DiscountGL,0,0,'Total Discount on Sales From '+Cast(@DateFrom as nvarchar(50))+' To '+ cast(@DateTo as nvarchar(50))+' ',@TotalDiscount)

end


declare @UserId int=null,@BranchID int 
select @BranchID=BranchID from InventWareHouse where WHID=@WHID

exec GLvMAIN_Insert  @GLvDetail=@GLvDetail , @vID = @vID output ,@vType =@vType , @vDate = @DateFrom ,@vremarks ='Syncing Data Voucher ' ,@FiscalID = @FiscalID , @Comp_Id =@CompanyID,
	 @vUserID=@UserID,@TotalDr = @TotalSaleAmount , @TotalCr = @TotalSaleAmount , @ReadOnly = 1, @BranchID=@BranchID

	insert into pos_ServerVouchers(WHID, AccountVoucherID, VoucherDate, VoucherSource
) values(@WHID,@vID,@DateFrom,'POSSALE')





GO



/****** Object:  StoredProcedure [dbo].[POSdata_SaleReturnInfoServer_InsertAccount]    Script Date: 10/8/2021 9:52:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleReturnInfoServer_InsertAccount]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_SaleReturnInfoServer_InsertAccount] AS' 
END
GO







ALTER procedure [dbo].[POSdata_SaleReturnInfoServer_InsertAccount] 
@IsInserted int output ,
@data_SalePosReturnInfoServer data_SalePosReturnInfoServer readonly,
@data_SalePosReturnDetailServer  data_SalePosReturnDetailServer readonly,
@DateFrom Date=null,
@DateTo Date=null,
@CompanyID int=null,
@WHID int=null 
as

declare @TotalSaleAmount numeric(18,3), @GLvDetail as GLvDetail ,@vID int = 0 ,@FiscalID int,@RevenuePOS int,@CashPos int,@vType int=null
select @TotalSaleAmount=sum(ItemRate*Quantity) from @data_SalePosReturnDetailServer
Select @RevenuePOS=RevenueAccountPOS,@CashPos=CashAccountPos,@FiscalID=FiscalID from gen_PosConfiguration where WHID=@WHID and CompanyID=@CompanyID


if((Select Count(*) from GLVoucherType where Title='POSCPV' and Companyid=@CompanyID)>0)
begin
	Select @vType=Voucherid from GLVoucherType  where Title='POSCPV' and Companyid=@CompanyID
end
else
begin
insert into GLVoucherType (Title,Description,SystemType,Companyid)
values('POSCPV','System Generated POS Return Voucher please Do not Change its title',1,@CompanyID)

Select @vType=Voucherid from GLVoucherType  where Title='POSCPV' and Companyid=@CompanyID

end

declare @AccountVoucherID int
Select @AccountVoucherID =AccountVoucherID from  pos_ServerVouchers where WHID=@WHID and VoucherDate=@DateFrom and VoucherSource='POSSALERETURN'
exec GLvMAIN_delete @vId=@AccountVoucherID
insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,cr)
values(@CashPos,0,0,'Total Sale Return From '+Cast(@DateFrom as nvarchar(50))+' To '+ cast(@DateTo as nvarchar(50))+' ',@TotalSaleAmount)
insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
values(@RevenuePOS,0,0,'Total Sale Return From '+Cast(@DateFrom as nvarchar(50))+' To '+ cast(@DateTo as nvarchar(50))+' ',@TotalSaleAmount)
declare @UserId int=null,@BranchID int 
select @BranchID=BranchID from InventWareHouse where WHID=@WHID

exec GLvMAIN_Insert  @GLvDetail=@GLvDetail , @vID = @vID output ,@vType =@vType , @vDate = @DateFrom ,@vremarks ='Syncing Data Voucher ' ,@FiscalID = @FiscalID , @Comp_Id =@CompanyID,
	 @vUserID=@UserID,@TotalDr = @TotalSaleAmount , @TotalCr = @TotalSaleAmount , @ReadOnly = 1, @BranchID=@BranchID

	insert into pos_ServerVouchers(WHID, AccountVoucherID, VoucherDate, VoucherSource
) values(@WHID,@vID,@DateFrom,'POSSALERETURN')







GO


/****** Object:  StoredProcedure [dbo].[POSdata_SaleandReturnInfoServer_Insert]    Script Date: 10/8/2021 9:54:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleandReturnInfoServer_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_SaleandReturnInfoServer_Insert] AS' 
END
GO






ALTER procedure [dbo].[POSdata_SaleandReturnInfoServer_Insert] 
@IsInserted int output ,
@data_SalePosInfoServer data_SalePosInfoServer readonly,
@data_SalePosDetailServer  data_SalePosDetailServer readonly,
@DateFrom Date=null,
@DateTo Date=null,
@CompanyID int=null,
@WHID int=null 
as


Delete from data_SalePosDetailServer where SalePosID in (Select SalePosID from data_SalePosInfoServer where WHID=@WHID and (SalePosDate between @DateFrom and @DateTo) and CompanyID=@CompanyID)
Delete from data_SalePosInfoServer  where WHID=@WHID and (SalePosDate between @DateFrom and @DateTo) and CompanyID=@CompanyID

insert into    data_SalePosInfoServer( SalePosID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, SalePosDate, WHID, TaxAmount, GrossAmount, DiscountPercentage, DiscountAmount, DiscountTotal, OtherCharges, 
                         NetAmount, AmountReceive, AmountReturn, SalePosReturnID, AmountInAccount, AmountReceivable, AmountPayable, DirectReturn, MfgID, CustomerPhone, CustomerName, SalePOSNo, isTaxable,ExchangeAmount,MenuId,InvoiceType,CardNumber,CardName,CashPayment,CardPayment,SaleManID,RiderAmount,LinckedBill,CounterID)
						 Select 
						 SalePosID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, SalePosDate, WHID, TaxAmount, GrossAmount, DiscountPercentage, DiscountAmount, DiscountTotal, OtherCharges, 
                         NetAmount, AmountReceive, AmountReturn, SalePosReturnID, AmountInAccount, AmountReceivable, AmountPayable, DirectReturn, MfgID, CustomerPhone, CustomerName, SalePOSNo, isTaxable,
						 ExchangeAmount,MenuId,InvoiceType,CardNumber,CardName,CashPayment,CardPayment,SaleManID,RiderAmount,LinckedBill,CounterID
						 from @data_SalePosInfoServer
insert into data_SalePosDetailServer        (SalePosDetailID, SalePosID, ItemId, Quantity, ItemRate, TaxPercentage, TaxAmount, DiscountPercentage, DiscountAmount, TotalAmount, ManaufacturingID, CartonSize, Carton, TotalQuantity
,SchemeID,MinQuantity,isExchange,StockRate)

SELECT        SalePosDetailID, SalePosID, ItemId, Quantity, ItemRate, TaxPercentage, TaxAmount, DiscountPercentage, DiscountAmount, TotalAmount, ManaufacturingID, CartonSize, Carton, TotalQuantity,SchemeID,MinQuantity,isExchange,StockRate
FROM            @data_SalePosDetailServer


set @IsInserted=1

exec POSdata_SaleandReturnInfoServer_InsertAccount @IsInserted=@IsInserted,@data_SalePosInfoServer=@data_SalePosInfoServer,@data_SalePosDetailServer=@data_SalePosDetailServer,@DateFrom=@DateFrom,@DateTo=@DateTo,@CompanyID=@CompanyID,@WHID=@WHID






GO


/****** Object:  StoredProcedure [dbo].[POSdata_SaleWisePosInfoServer_Insert]    Script Date: 10/8/2021 10:10:49 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleWisePosInfoServer_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_SaleWisePosInfoServer_Insert]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleVouchersInfoServer_InsertAccount]    Script Date: 10/8/2021 10:10:49 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleVouchersInfoServer_InsertAccount]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_SaleVouchersInfoServer_InsertAccount]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleReturnWiseInfoServer_Insert]    Script Date: 10/8/2021 10:10:49 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleReturnWiseInfoServer_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_SaleReturnWiseInfoServer_Insert]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleReturnInfoServer_InsertAccount]    Script Date: 10/8/2021 10:10:49 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleReturnInfoServer_InsertAccount]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_SaleReturnInfoServer_InsertAccount]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleReturnInfoServer_Insert]    Script Date: 10/8/2021 10:10:49 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleReturnInfoServer_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_SaleReturnInfoServer_Insert]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleReturnDateWiseServer_InsertAccount]    Script Date: 10/8/2021 10:10:49 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleReturnDateWiseServer_InsertAccount]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_SaleReturnDateWiseServer_InsertAccount]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleandReturnInfoServer_SelectAll]    Script Date: 10/8/2021 10:10:49 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleandReturnInfoServer_SelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_SaleandReturnInfoServer_SelectAll]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleandReturnInfoServer_InsertAccount]    Script Date: 10/8/2021 10:10:49 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleandReturnInfoServer_InsertAccount]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_SaleandReturnInfoServer_InsertAccount]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleandReturnInfoServer_Insert]    Script Date: 10/8/2021 10:10:49 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleandReturnInfoServer_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_SaleandReturnInfoServer_Insert]
GO
/****** Object:  UserDefinedTableType [dbo].[data_SalePosReturnInfoServer]    Script Date: 10/8/2021 10:10:49 AM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_SalePosReturnInfoServer' AND ss.name = N'dbo')
DROP TYPE [dbo].[data_SalePosReturnInfoServer]
GO
/****** Object:  UserDefinedTableType [dbo].[data_SalePosInfoServer]    Script Date: 10/8/2021 10:10:49 AM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_SalePosInfoServer' AND ss.name = N'dbo')
DROP TYPE [dbo].[data_SalePosInfoServer]
GO
/****** Object:  UserDefinedTableType [dbo].[data_SalePosInfoServer]    Script Date: 10/8/2021 10:10:49 AM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_SalePosInfoServer' AND ss.name = N'dbo')
CREATE TYPE [dbo].[data_SalePosInfoServer] AS TABLE(
	[SalePosID] [bigint] NOT NULL,
	[EntryUserID] [int] NULL,
	[EntryUserDateTime] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyUserDateTime] [datetime] NULL,
	[CompanyID] [int] NULL,
	[FiscalID] [int] NULL,
	[SalePosDate] [date] NULL,
	[WHID] [int] NULL,
	[TaxAmount] [decimal](18, 2) NULL,
	[GrossAmount] [decimal](18, 2) NULL,
	[DiscountPercentage] [decimal](18, 2) NULL,
	[DiscountAmount] [decimal](18, 2) NULL,
	[DiscountTotal] [decimal](18, 2) NULL,
	[OtherCharges] [decimal](18, 2) NULL,
	[NetAmount] [decimal](18, 2) NULL,
	[AmountReceive] [decimal](18, 2) NULL,
	[AmountReturn] [float] NULL,
	[SalePosReturnID] [bigint] NULL,
	[AmountInAccount] [decimal](18, 2) NULL,
	[AmountReceivable] [decimal](18, 2) NULL,
	[AmountPayable] [decimal](18, 2) NULL,
	[DirectReturn] [bit] NULL,
	[MfgID] [int] NULL,
	[CustomerPhone] [nvarchar](50) NULL,
	[CustomerName] [nvarchar](50) NULL,
	[SalePOSNo] [int] NULL,
	[isTaxable] [bit] NULL,
	[ExchangeAmount] [numeric](18, 3) NULL,
	[MenuId] [int] NULL,
	[InvoiceType] [int] NULL,
	[CardNumber] [nvarchar](max) NULL,
	[CardName] [nvarchar](1000) NULL,
	[CashPayment] [numeric](18, 3) NULL,
	[CardPayment] [numeric](18, 3) NULL,
	[SaleManId] [int] NULL,
	[RiderAmount] [numeric](18, 3) NULL,
	[LinckedBill] [int] NULL,
	[CounterID] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[data_SalePosReturnInfoServer]    Script Date: 10/8/2021 10:10:50 AM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'data_SalePosReturnInfoServer' AND ss.name = N'dbo')
CREATE TYPE [dbo].[data_SalePosReturnInfoServer] AS TABLE(
	[SalePosReturnID] [bigint] NULL,
	[SalePosID] [bigint] NULL,
	[EntryUserID] [int] NULL,
	[EntryUserDateTime] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyUserDateTime] [datetime] NULL,
	[CompanyID] [int] NULL,
	[FiscalID] [int] NULL,
	[SalePosReturnDate] [date] NULL,
	[WHID] [int] NULL,
	[TaxAmount] [decimal](18, 2) NULL,
	[GrossAmount] [decimal](18, 2) NULL,
	[DiscountPercentage] [decimal](18, 2) NULL,
	[DiscountAmount] [decimal](18, 2) NULL,
	[DiscountTotal] [decimal](18, 2) NULL,
	[OtherCharges] [decimal](18, 2) NULL,
	[NetAmount] [decimal](18, 2) NULL,
	[AmountReceive] [decimal](18, 2) NULL,
	[AmountReturn] [decimal](18, 2) NULL,
	[LogSourceID] [bigint] NULL,
	[AmountInAccount] [decimal](18, 2) NULL,
	[AmountReceivable] [decimal](18, 2) NULL,
	[AmountPayable] [decimal](18, 2) NULL,
	[CustomerPhone] [nvarchar](50) NULL,
	[CustomerName] [nvarchar](50) NULL,
	[SalePOSNo] [int] NULL,
	[MenuId] [int] NULL,
	[InvoiceType] [int] NULL,
	[SaleManId] [int] NULL,
	[CounterID] [int] NULL
)
GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleandReturnInfoServer_Insert]    Script Date: 10/8/2021 10:10:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleandReturnInfoServer_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_SaleandReturnInfoServer_Insert] AS' 
END
GO






ALTER procedure [dbo].[POSdata_SaleandReturnInfoServer_Insert] 
@IsInserted int output ,
@data_SalePosInfoServer data_SalePosInfoServer readonly,
@data_SalePosDetailServer  data_SalePosDetailServer readonly,
@DateFrom Date=null,
@DateTo Date=null,
@CompanyID int=null,
@WHID int=null 
as


Delete from data_SalePosDetailServer where SalePosID in (Select SalePosID from data_SalePosInfoServer where WHID=@WHID and (SalePosDate between @DateFrom and @DateTo) and CompanyID=@CompanyID)
Delete from data_SalePosInfoServer  where WHID=@WHID and (SalePosDate between @DateFrom and @DateTo) and CompanyID=@CompanyID

insert into    data_SalePosInfoServer( SalePosID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, SalePosDate, WHID, TaxAmount, GrossAmount, DiscountPercentage, DiscountAmount, DiscountTotal, OtherCharges, 
                         NetAmount, AmountReceive, AmountReturn, SalePosReturnID, AmountInAccount, AmountReceivable, AmountPayable, DirectReturn, MfgID, CustomerPhone, CustomerName, SalePOSNo, isTaxable,ExchangeAmount,MenuId,InvoiceType,CardNumber,CardName,CashPayment,CardPayment,SaleManID,RiderAmount,LinckedBill,CounterID)
						 Select 
						 SalePosID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, SalePosDate, WHID, TaxAmount, GrossAmount, DiscountPercentage, DiscountAmount, DiscountTotal, OtherCharges, 
                         NetAmount, AmountReceive, AmountReturn, SalePosReturnID, AmountInAccount, AmountReceivable, AmountPayable, DirectReturn, MfgID, CustomerPhone, CustomerName, SalePOSNo, isTaxable,
						 ExchangeAmount,MenuId,InvoiceType,CardNumber,CardName,CashPayment,CardPayment,SaleManID,RiderAmount,LinckedBill,CounterID
						 from @data_SalePosInfoServer
insert into data_SalePosDetailServer        (SalePosDetailID, SalePosID, ItemId, Quantity, ItemRate, TaxPercentage, TaxAmount, DiscountPercentage, DiscountAmount, TotalAmount, ManaufacturingID, CartonSize, Carton, TotalQuantity
,SchemeID,MinQuantity,isExchange,StockRate)

SELECT        SalePosDetailID, SalePosID, ItemId, Quantity, ItemRate, TaxPercentage, TaxAmount, DiscountPercentage, DiscountAmount, TotalAmount, ManaufacturingID, CartonSize, Carton, TotalQuantity,SchemeID,MinQuantity,isExchange,StockRate
FROM            @data_SalePosDetailServer


set @IsInserted=1

exec POSdata_SaleandReturnInfoServer_InsertAccount @IsInserted=@IsInserted,@data_SalePosInfoServer=@data_SalePosInfoServer,@data_SalePosDetailServer=@data_SalePosDetailServer,@DateFrom=@DateFrom,@DateTo=@DateTo,@CompanyID=@CompanyID,@WHID=@WHID







GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleandReturnInfoServer_InsertAccount]    Script Date: 10/8/2021 10:10:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleandReturnInfoServer_InsertAccount]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_SaleandReturnInfoServer_InsertAccount] AS' 
END
GO







ALTER procedure [dbo].[POSdata_SaleandReturnInfoServer_InsertAccount] 
@IsInserted int output ,
@data_SalePosInfoServer data_SalePosInfoServer readonly,
@data_SalePosDetailServer  data_SalePosDetailServer readonly,
@DateFrom Date=null,
@DateTo Date=null,
@CompanyID int=null,
@WHID int=null 
as

declare @TotalCashAmount numeric(18,3),@TotalSaleAmount numeric(18,3), @GLvDetail as GLvDetail ,@vID int = 0 ,@FiscalID int,@DiscountGL int,@RevenuePOS int,@CashPos int,@vType int=null
declare @TotalDiscount numeric(18,3)=0
select @TotalSaleAmount=sum(ItemRate*Quantity),@TotalCashAmount=sum(ItemRate*Quantity) from @data_SalePosDetailServer
Select @TotalDiscount=sum(DiscountTotal) from @data_SalePosInfoServer
Select @RevenuePOS=RevenueAccountPOS,@CashPos=CashAccountPos,@FiscalID=FiscalID,@DiscountGL=DiscountGL from gen_PosConfiguration where WHID=@WHID and CompanyID=@CompanyID

if @TotalDiscount>0 and @DiscountGL is not null
begin

set @TotalCashAmount=@TotalCashAmount-@TotalDiscount

end

if((Select Count(*) from GLVoucherType where Title='POSCRV' and Companyid=@CompanyID)>0)
begin
	Select @vType=Voucherid from GLVoucherType  where Title='POSCRV' and Companyid=@CompanyID
end
else
begin
insert into GLVoucherType (Title,Description,SystemType,Companyid)
values('POSCRV','System Generated POS Voucher please Do not Change its title',1,@CompanyID)

Select @vType=Voucherid from GLVoucherType  where Title='POSCRV' and Companyid=@CompanyID
update gen_SystemConfiguration set POSCashVoucher=@vType
end

declare @AccountVoucherID int
Select @AccountVoucherID =AccountVoucherID from  pos_ServerVouchers where WHID=@WHID and VoucherDate=@DateFrom and VoucherSource='POSSALE'
exec GLvMAIN_delete @vId=@AccountVoucherID
insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
values(@CashPos,0,0,'Total Sale From '+Cast(@DateFrom as nvarchar(50))+' To '+ cast(@DateTo as nvarchar(50))+' ',@TotalCashAmount)


insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,cr)
values(@RevenuePOS,0,0,'Total Sale From '+Cast(@DateFrom as nvarchar(50))+' To '+ cast(@DateTo as nvarchar(50))+' ',@TotalSaleAmount)
if @TotalDiscount>0 and @DiscountGL is not null
begin

insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
values(@DiscountGL,0,0,'Total Discount on Sales From '+Cast(@DateFrom as nvarchar(50))+' To '+ cast(@DateTo as nvarchar(50))+' ',@TotalDiscount)

end


declare @UserId int=null,@BranchID int 
select @BranchID=BranchID from InventWareHouse where WHID=@WHID

exec GLvMAIN_Insert  @GLvDetail=@GLvDetail , @vID = @vID output ,@vType =@vType , @vDate = @DateFrom ,@vremarks ='Syncing Data Voucher ' ,@FiscalID = @FiscalID , @Comp_Id =@CompanyID,
	 @vUserID=@UserID,@TotalDr = @TotalSaleAmount , @TotalCr = @TotalSaleAmount , @ReadOnly = 1, @BranchID=@BranchID

	insert into pos_ServerVouchers(WHID, AccountVoucherID, VoucherDate, VoucherSource
) values(@WHID,@vID,@DateFrom,'POSSALE')






GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleandReturnInfoServer_SelectAll]    Script Date: 10/8/2021 10:10:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleandReturnInfoServer_SelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_SaleandReturnInfoServer_SelectAll] AS' 
END
GO







ALTER procedure [dbo].[POSdata_SaleandReturnInfoServer_SelectAll] 
@WhereClause nvarchar(Max),
@BoolMaster bit=0,
@DetailMaster bit=0,
@WhereClauseDetail nvarchar(Max),
@WhereClauseReturn nvarchar(Max),
@WhereClauseReturnDetail nvarchar(Max)='',
@isSales bit=1
as

if @isSales =1
begin

if(@BoolMaster=1)
begin
exec('SELECT        SalePosID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, SalePosDate, WHID, TaxAmount, GrossAmount, DiscountPercentage, DiscountAmount, DiscountTotal, OtherCharges, 
                         NetAmount, AmountReceive, AmountReturn, SalePosReturnID, AmountInAccount, AmountReceivable, AmountPayable, DirectReturn, MfgID, CustomerPhone, CustomerName, SalePOSNo, isTaxable, ExchangeAmount, MenuId, 
                         InvoiceType, CardNumber, CardName, CashPayment, CardPayment, SaleManId,CounterID
FROM            data_SalePosInfo '+ @WhereClause)
end
if (@DetailMaster=1)
begin
exec('SELECT        data_SalePosDetail.* FROM            data_SalePosDetail inner join data_SalePosInfo on data_SalePosInfo.SalePosID=data_SalePosDetail.SalePosID '+ @WhereClauseDetail)
end
end
else
begin
if(@BoolMaster=1)
begin
exec('select * from data_SalePosReturnInfo '+ @WhereClauseReturn)
end
if (@DetailMaster=1)
begin
exec('SELECT        SalePosReturnDetailID, SalePosDetailID, data_SalePosReturnDetail.SalePosReturnID, ItemId, Quantity, ItemRate, TaxPercentage, data_SalePosReturnDetail.TaxAmount, data_SalePosReturnDetail.DiscountPercentage, data_SalePosReturnDetail.DiscountAmount, TotalAmount, IsLog, CartonSize, Carton, TotalQuantity, SchemeID, 
                         MinQuantity,StockRate,0 as isExchange

FROM            data_SalePosReturnDetail inner join data_SalePosReturnInfo on data_SalePosReturnInfo.SalePosReturnID=data_SalePosReturnDetail.SalePosReturnID '+ @WhereClauseReturn)
end

end








GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleReturnDateWiseServer_InsertAccount]    Script Date: 10/8/2021 10:10:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleReturnDateWiseServer_InsertAccount]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_SaleReturnDateWiseServer_InsertAccount] AS' 
END
GO







ALTER procedure [dbo].[POSdata_SaleReturnDateWiseServer_InsertAccount] 
@IsInserted int output ,
@DateFrom Date=null,
@DateTo Date=null,
@CompanyID int=null,
@WHID int=null 
as

declare @TotalSaleAmount numeric(18,3), @GLvDetail as GLvDetail ,@vID int = 0 ,@FiscalID int,@RevenuePOS int,@CashPos int,@vType int=null
Select @RevenuePOS=RevenueAccountPOS,@CashPos=CashAccountPos,@FiscalID=FiscalID from gen_PosConfiguration where WHID=@WHID and CompanyID=@CompanyID


if((Select Count(*) from GLVoucherType where Title='POSCPV' and Companyid=@CompanyID)>0)
begin
	Select @vType=Voucherid from GLVoucherType  where Title='POSCPV' and Companyid=@CompanyID
end
else
begin
insert into GLVoucherType (Title,Description,SystemType,Companyid)
values('POSCPV','System Generated POS Return Voucher please Do not Change its title',1,@CompanyID)

Select @vType=Voucherid from GLVoucherType  where Title='POSCPV' and Companyid=@CompanyID

end

declare @AccountVoucherID int


declare @SalePosreturnDate Date=NULL

declare firstcursor cursor for
select SalePosreturnDate from vw_SalePosReturnVouchers where WHID=@WHID and SalePosreturnDate between @DateFrom and @DateTo
open firstcursor
fetch next from firstcursor into @SalePosreturnDate
while @@FETCH_STATUS = 0
	begin

Select @AccountVoucherID =AccountVoucherID from  pos_ServerVouchers where WHID=@WHID and VoucherDate=@SalePosreturnDate and VoucherSource='POSSALERETURN'
exec GLvMAIN_delete @vId=@AccountVoucherID

select @TotalSaleAmount=sum(GrossAmount) from vw_SalePosReturnVouchers where WHID=@WHID and SalePosreturnDate=@SalePosreturnDate




insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,cr)
values(@CashPos,0,0,'Total Sale Return From '+Cast(@SalePosreturnDate as nvarchar(50))+' To '+ cast(@SalePosreturnDate as nvarchar(50))+' ',@TotalSaleAmount)
insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
values(@RevenuePOS,0,0,'Total Sale Return From '+Cast(@SalePosreturnDate as nvarchar(50))+' To '+ cast(@SalePosreturnDate as nvarchar(50))+' ',@TotalSaleAmount)
declare @UserId int=null,@BranchID int 
select @BranchID=BranchID from InventWareHouse where WHID=@WHID

exec GLvMAIN_Insert  @GLvDetail=@GLvDetail , @vID = @vID output ,@vType =@vType , @vDate = @SalePosreturnDate ,@vremarks ='Syncing Data Voucher ' ,@FiscalID = @FiscalID , @Comp_Id =@CompanyID,
	 @vUserID=@UserID,@TotalDr = @TotalSaleAmount , @TotalCr = @TotalSaleAmount , @ReadOnly = 1, @BranchID=@BranchID

	insert into pos_ServerVouchers(WHID, AccountVoucherID, VoucherDate, VoucherSource
) values(@WHID,@vID,@SalePosreturnDate,'POSSALERETURN')


set @vID=0
delete from @GLvDetail
FETCH NEXT FROM firstcursor INTO @SalePosreturnDate
	END

close firstcursor
deallocate firstcursor





GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleReturnInfoServer_Insert]    Script Date: 10/8/2021 10:10:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleReturnInfoServer_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_SaleReturnInfoServer_Insert] AS' 
END
GO
ALTER PROCEDURE [dbo].[POSdata_SaleReturnInfoServer_Insert] AS


GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleReturnInfoServer_InsertAccount]    Script Date: 10/8/2021 10:10:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleReturnInfoServer_InsertAccount]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_SaleReturnInfoServer_InsertAccount] AS' 
END
GO







ALTER procedure [dbo].[POSdata_SaleReturnInfoServer_InsertAccount] 
@IsInserted int output ,
@data_SalePosReturnInfoServer data_SalePosReturnInfoServer readonly,
@data_SalePosReturnDetailServer  data_SalePosReturnDetailServer readonly,
@DateFrom Date=null,
@DateTo Date=null,
@CompanyID int=null,
@WHID int=null 
as

declare @TotalSaleAmount numeric(18,3), @GLvDetail as GLvDetail ,@vID int = 0 ,@FiscalID int,@RevenuePOS int,@CashPos int,@vType int=null
select @TotalSaleAmount=sum(ItemRate*Quantity) from @data_SalePosReturnDetailServer
Select @RevenuePOS=RevenueAccountPOS,@CashPos=CashAccountPos,@FiscalID=FiscalID from gen_PosConfiguration where WHID=@WHID and CompanyID=@CompanyID


if((Select Count(*) from GLVoucherType where Title='POSCPV' and Companyid=@CompanyID)>0)
begin
	Select @vType=Voucherid from GLVoucherType  where Title='POSCPV' and Companyid=@CompanyID
end
else
begin
insert into GLVoucherType (Title,Description,SystemType,Companyid)
values('POSCPV','System Generated POS Return Voucher please Do not Change its title',1,@CompanyID)

Select @vType=Voucherid from GLVoucherType  where Title='POSCPV' and Companyid=@CompanyID

end

declare @AccountVoucherID int
Select @AccountVoucherID =AccountVoucherID from  pos_ServerVouchers where WHID=@WHID and VoucherDate=@DateFrom and VoucherSource='POSSALERETURN'
exec GLvMAIN_delete @vId=@AccountVoucherID
insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,cr)
values(@CashPos,0,0,'Total Sale Return From '+Cast(@DateFrom as nvarchar(50))+' To '+ cast(@DateTo as nvarchar(50))+' ',@TotalSaleAmount)
insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
values(@RevenuePOS,0,0,'Total Sale Return From '+Cast(@DateFrom as nvarchar(50))+' To '+ cast(@DateTo as nvarchar(50))+' ',@TotalSaleAmount)
declare @UserId int=null,@BranchID int 
select @BranchID=BranchID from InventWareHouse where WHID=@WHID

exec GLvMAIN_Insert  @GLvDetail=@GLvDetail , @vID = @vID output ,@vType =@vType , @vDate = @DateFrom ,@vremarks ='Syncing Data Voucher ' ,@FiscalID = @FiscalID , @Comp_Id =@CompanyID,
	 @vUserID=@UserID,@TotalDr = @TotalSaleAmount , @TotalCr = @TotalSaleAmount , @ReadOnly = 1, @BranchID=@BranchID

	insert into pos_ServerVouchers(WHID, AccountVoucherID, VoucherDate, VoucherSource
) values(@WHID,@vID,@DateFrom,'POSSALERETURN')








GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleReturnWiseInfoServer_Insert]    Script Date: 10/8/2021 10:10:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleReturnWiseInfoServer_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_SaleReturnWiseInfoServer_Insert] AS' 
END
GO







ALTER procedure [dbo].[POSdata_SaleReturnWiseInfoServer_Insert] 
@IsInserted int output ,
@data_SalePosReturnInfoServer data_SalePosReturnInfoServer readonly,
@data_SalePosReturnDetailServer  data_SalePosReturnDetailServer readonly,
@DateFrom Date=null,
@DateTo Date=null,
@CompanyID int=null,
@WHID int=null,
@SaleReturnPOSID int=0 
as


Delete from data_SalePosReturnDetailServer where SalePosReturnID =@SaleReturnPOSID and TrackBranchID=@WHID
Delete from data_SalePosReturnInfoServer  where WHID=@WHID and SalePosReturnID=@SaleReturnPOSID

insert into    data_SalePosReturnInfoServer(   SalePosReturnID, SalePosID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, SalePosReturnDate, WHID, TaxAmount, GrossAmount, DiscountPercentage, DiscountAmount, 
                         DiscountTotal, OtherCharges, NetAmount, AmountReceive, AmountReturn, LogSourceID, AmountInAccount, AmountReceivable, AmountPayable, CustomerPhone, CustomerName, SalePOSNo,SaleManId,CounterID)
						 Select 
						  SalePosReturnID, SalePosID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, SalePosReturnDate, WHID, TaxAmount, GrossAmount, DiscountPercentage, DiscountAmount, 
                         DiscountTotal, OtherCharges, NetAmount, AmountReceive, AmountReturn, LogSourceID, AmountInAccount, AmountReceivable, AmountPayable, CustomerPhone, CustomerName, SalePOSNo,SaleManId,CounterID
						 from @data_SalePosReturnInfoServer
insert into data_SalePosReturnDetailServer        (SalePosReturnDetailID, SalePosDetailID, SalePosReturnID, ItemId, Quantity, ItemRate, TaxPercentage, TaxAmount, DiscountPercentage, DiscountAmount, TotalAmount, IsLog, CartonSize, Carton, TotalQuantity,StockRate,TrackBranchID
)

SELECT      SalePosReturnDetailID, SalePosDetailID, SalePosReturnID, ItemId, Quantity, ItemRate, TaxPercentage, TaxAmount, DiscountPercentage, DiscountAmount, TotalAmount, IsLog, CartonSize, Carton, TotalQuantity,StockRate,@WHID
FROM            @data_SalePosReturnDetailServer


set @IsInserted=1

--exec POSdata_SaleReturnInfoServer_InsertAccount @IsInserted=@IsInserted,@data_SalePosReturnInfoServer=@data_SalePosReturnInfoServer,@data_SalePosReturnDetailServer=@data_SalePosReturnDetailServer,@DateFrom=@DateFrom,@DateTo=@DateTo,@CompanyID=@CompanyID,@WHID=@WHID







GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleVouchersInfoServer_InsertAccount]    Script Date: 10/8/2021 10:10:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleVouchersInfoServer_InsertAccount]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_SaleVouchersInfoServer_InsertAccount] AS' 
END
GO








ALTER procedure [dbo].[POSdata_SaleVouchersInfoServer_InsertAccount] 
@IsInserted int output ,
@DateFrom Date=null,
@DateTo Date=null,
@CompanyID int=null,
@WHID int=null 
as

declare @TotalCashAmount numeric(18,3),@TotalSaleAmount numeric(18,3), @GLvDetail as GLvDetail ,@vID int = 0 ,@FiscalID int,@DiscountGL int,@RevenuePOS int,@CashPos int,@vType int=null
declare @TotalDiscount numeric(18,3)=0

if((Select Count(*) from GLVoucherType where Title='POSCRV' and Companyid=@CompanyID)>0)
begin
	Select @vType=Voucherid from GLVoucherType  where Title='POSCRV' and Companyid=@CompanyID
end
else
begin
insert into GLVoucherType (Title,Description,SystemType,Companyid)
values('POSCRV','System Generated POS Voucher please Do not Change its title',1,@CompanyID)

Select @vType=Voucherid from GLVoucherType  where Title='POSCRV' and Companyid=@CompanyID
update gen_SystemConfiguration set POSCashVoucher=@vType
end

declare @AccountVoucherID int

declare @SalePOSDate Date=NULL

declare firstcursor cursor for
select SalePosDate from vw_salePosVouchers where WHID=@WHID and SalePosDate between @DateFrom and @DateTo
open firstcursor
fetch next from firstcursor into @SalePOSDate
while @@FETCH_STATUS = 0
	begin

Select @AccountVoucherID =AccountVoucherID from  pos_ServerVouchers where WHID=@WHID and VoucherDate=@SalePOSDate and VoucherSource='POSSALE'
exec GLvMAIN_delete @vId=@AccountVoucherID


select @TotalSaleAmount=sum(GrossAmount),@TotalCashAmount=sum(GrossAmount),@TotalDiscount=sum(DiscountTotal) from vw_salePosVouchers where WHID=@WHID and SalePosDate=@SalePOSDate

Select @RevenuePOS=RevenueAccountPOS,@CashPos=CashAccountPos,@FiscalID=FiscalID,@DiscountGL=DiscountGL from gen_PosConfiguration where WHID=@WHID and CompanyID=@CompanyID

if @TotalDiscount>0 and @DiscountGL is not null
begin

set @TotalCashAmount=@TotalCashAmount-@TotalDiscount

end



insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
values(@CashPos,0,0,'Total Sale at '+Cast(@SalePOSDate as nvarchar(50))+' ',@TotalCashAmount)


insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,cr)
values(@RevenuePOS,0,0,'Total Sale at '+Cast(@SalePOSDate as nvarchar(50))+' ',@TotalSaleAmount)
if @TotalDiscount>0 and @DiscountGL is not null
begin

insert into @GLvDetail(GlAccountID,DTypeID,DvaluesID,Narration,dr)
values(@DiscountGL,0,0,'Total Discount on Sales at '+Cast(@SalePOSDate as nvarchar(50))+' ',@TotalDiscount)

end


declare @UserId int=null,@BranchID int 
select @BranchID=BranchID from InventWareHouse where WHID=@WHID

exec GLvMAIN_Insert  @GLvDetail=@GLvDetail , @vID = @vID output ,@vType =@vType , @vDate = @SalePOSDate ,@vremarks ='Syncing Data Voucher ' ,@FiscalID = @FiscalID , @Comp_Id =@CompanyID,
	 @vUserID=@UserID,@TotalDr = @TotalSaleAmount , @TotalCr = @TotalSaleAmount , @ReadOnly = 1, @BranchID=@BranchID

	insert into pos_ServerVouchers(WHID, AccountVoucherID, VoucherDate, VoucherSource
) values(@WHID,@vID,@SalePOSDate,'POSSALE')
set @vID=0
delete from @GLvDetail
FETCH NEXT FROM firstcursor INTO @SalePOSDate
	END

close firstcursor
deallocate firstcursor





GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleWisePosInfoServer_Insert]    Script Date: 10/8/2021 10:10:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleWisePosInfoServer_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_SaleWisePosInfoServer_Insert] AS' 
END
GO







ALTER procedure [dbo].[POSdata_SaleWisePosInfoServer_Insert] 
@IsInserted int output ,
@data_SalePosInfoServer data_SalePosInfoServer readonly,
@data_SalePosDetailServer  data_SalePosDetailServer readonly,
@DateFrom Date=null,
@DateTo Date=null,
@CompanyID int=null,
@WHID int=null,
@SalePosID int=0 
as

delete from data_ProductOutflow where SourceName='POSSOLD' and SourceID in (select SalePosDetailID from @data_SalePosDetailServer) and WHID=@WHID
Delete from data_SalePosDetailServer where SalePosID =@SalePosID and TrackBranchID=@WHID
Delete from data_SalePosInfoServer  where WHID=@WHID and SalePosID =@SalePosID

insert into    data_SalePosInfoServer( SalePosID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, SalePosDate, WHID, TaxAmount, GrossAmount, DiscountPercentage, DiscountAmount, DiscountTotal, OtherCharges, 
                         NetAmount, AmountReceive, AmountReturn, SalePosReturnID, AmountInAccount, AmountReceivable, AmountPayable, DirectReturn, MfgID, CustomerPhone, CustomerName, SalePOSNo, isTaxable,ExchangeAmount,MenuId,InvoiceType,CardNumber,CardName,CashPayment,CardPayment,SaleManID,RiderAmount,LinckedBill,CounterID)
						 Select 
						 SalePosID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, SalePosDate, WHID, TaxAmount, GrossAmount, DiscountPercentage, DiscountAmount, DiscountTotal, OtherCharges, 
                         NetAmount, AmountReceive, AmountReturn, SalePosReturnID, AmountInAccount, AmountReceivable, AmountPayable, DirectReturn, MfgID, CustomerPhone, CustomerName, SalePOSNo, isTaxable,
						 ExchangeAmount,MenuId,InvoiceType,CardNumber,CardName,CashPayment,CardPayment,SaleManID,RiderAmount,LinckedBill,CounterID
						 from @data_SalePosInfoServer
insert into data_SalePosDetailServer        (SalePosDetailID, SalePosID, ItemId, Quantity, ItemRate, TaxPercentage, TaxAmount, DiscountPercentage, DiscountAmount, TotalAmount, ManaufacturingID, CartonSize, Carton, TotalQuantity
,SchemeID,MinQuantity,isExchange,StockRate,TrackBranchID)

SELECT        SalePosDetailID, SalePosID, ItemId, Quantity, ItemRate, TaxPercentage, TaxAmount, DiscountPercentage, DiscountAmount, TotalAmount, ManaufacturingID, CartonSize, Carton, TotalQuantity,SchemeID,MinQuantity,isExchange,StockRate,@WHID
FROM            @data_SalePosDetailServer


set @IsInserted=1

declare @RowID int,@IssuanceIDDetailID int ,@StockRate numeric(14,5) , @Quantity numeric(10,2),@ItemId int,@stockQty numeric(14,2),
@ItemName varchar(200),@ERRORMSG varchar(200),@productOutflowID int,@StockDate datetime,@FiscalID int=0,@BranchID int=null,@DirectReturn bit=0


--declare @jj as xml = (select * from @data_StockTransferDetail for xml auto)

declare firstcursor cursor for
select SalePosDetailID from @data_SalePosDetailServer
open firstcursor
fetch next from firstcursor into @RowID
while @@FETCH_STATUS = 0
	begin
		declare @checkRate bit = 1
	

	select @ItemId=itemid,@StockRate=StockRate,@Quantity=Quantity from @data_SalePosDetailServer where SalePosDetailID=@RowID
		Select @DirectReturn=DirectReturn,@StockDate=SalePosDate,@FiscalID=FiscalID,@CompanyID=CompanyID from @data_SalePosInfoServer where WHID=@WHID and SalePosID=@SalePosID
	exec GetWeightedRateForItem @ItemId, 0 ,@StockDate ,@StockDate ,@StockRate output , @CompanyID , 0
	if(@DirectReturn !=1)
	begin
		exec data_Productoutflow_Insert @productOutflowID output,null,@ItemId,@RowID,'POSSOLD',@WHID, 
		@StockDate ,@StockRate,@Quantity ,@FiscalID , @CompanyID , 0,null,null,null,null,null,null,null
		end
	FETCH NEXT FROM firstcursor INTO @RowID
	END

close firstcursor
deallocate firstcursor




--while @DateFrom<=@DateTo
--begin

--exec POSdata_SaleandReturnInfoServer_InsertAccount @IsInserted=@IsInserted,@data_SalePosInfoServer=@data_SalePosInfoServer,@data_SalePosDetailServer=@data_SalePosDetailServer,@DateFrom=@DateFrom,@DateTo=@DateFrom,@CompanyID=@CompanyID,@WHID=@WHID

--set @DateFrom =  DATEADD(d,1, @DateFrom)

--end








GO
