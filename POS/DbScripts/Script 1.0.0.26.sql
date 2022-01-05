
/****** Object:  StoredProcedure [dbo].[POSdata_SaleandReturnInfoServer_SelectAll]    Script Date: 5/21/2021 11:47:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
exec('select * from data_SalePosInfo '+ @WhereClause)
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





Go



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
	DiscountGL int NULL,
	CostAcccount int NULL
GO
ALTER TABLE dbo.gen_PosConfiguration SET (LOCK_ESCALATION = TABLE)
GO
COMMIT


/****** Object:  StoredProcedure [dbo].[POSdata_SaleandReturnInfoServer_InsertAccount]    Script Date: 5/21/2021 11:50:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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


Go








/****** Object:  StoredProcedure [dbo].[POSdata_SaleandReturnInfoServer_InsertAccount]    Script Date: 5/21/2021 11:50:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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


Go










