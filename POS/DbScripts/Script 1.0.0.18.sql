
/****** Object:  StoredProcedure [dbo].[POSdata_SaleandReturnInfoServer_SelectAll]    Script Date: 5/4/2021 2:08:51 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_SaleandReturnInfoServer_SelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_SaleandReturnInfoServer_SelectAll]
GO
/****** Object:  StoredProcedure [dbo].[PosApi_AllGlUserPromoLocations_Insert]    Script Date: 5/4/2021 2:08:51 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PosApi_AllGlUserPromoLocations_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PosApi_AllGlUserPromoLocations_Insert]
GO
/****** Object:  StoredProcedure [dbo].[pos_ApiSalesMan_SelectAll]    Script Date: 5/4/2021 2:08:51 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pos_ApiSalesMan_SelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pos_ApiSalesMan_SelectAll]
GO
/****** Object:  StoredProcedure [dbo].[pos_ApiGetPromosandWareHouseandGlUser_SelectAll]    Script Date: 5/4/2021 2:08:51 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pos_ApiGetPromosandWareHouseandGlUser_SelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pos_ApiGetPromosandWareHouseandGlUser_SelectAll]
GO
/****** Object:  UserDefinedTableType [dbo].[Pos_Pes_SchemeInfo]    Script Date: 5/4/2021 2:08:51 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'Pos_Pes_SchemeInfo' AND ss.name = N'dbo')
DROP TYPE [dbo].[Pos_Pes_SchemeInfo]
GO
/****** Object:  UserDefinedTableType [dbo].[Pos_Pes_SchemeDetail]    Script Date: 5/4/2021 2:08:51 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'Pos_Pes_SchemeDetail' AND ss.name = N'dbo')
DROP TYPE [dbo].[Pos_Pes_SchemeDetail]
GO
/****** Object:  UserDefinedTableType [dbo].[Pos_InventWareHouse]    Script Date: 5/4/2021 2:08:51 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'Pos_InventWareHouse' AND ss.name = N'dbo')
DROP TYPE [dbo].[Pos_InventWareHouse]
GO
/****** Object:  UserDefinedTableType [dbo].[Pos_GLUser]    Script Date: 5/4/2021 2:08:51 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'Pos_GLUser' AND ss.name = N'dbo')
DROP TYPE [dbo].[Pos_GLUser]
GO
/****** Object:  UserDefinedTableType [dbo].[Pos_GLUser]    Script Date: 5/4/2021 2:08:51 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'Pos_GLUser' AND ss.name = N'dbo')
CREATE TYPE [dbo].[Pos_GLUser] AS TABLE(
	[Userid] [int] NULL,
	[UserName] [varchar](100) NULL,
	[UserPassword] [nvarchar](50) NULL,
	[GroupID] [int] NULL,
	[Type] [bit] NULL,
	[Entryby] [nvarchar](50) NULL,
	[TimeStamp] [datetime] NULL,
	[Active] [bit] NULL,
	[CompanyID] [int] NULL,
	[AccountTitle] [nvarchar](50) NULL,
	[Taxmode] [nvarchar](50) NULL,
	[AllowDbBackup] [bit] NULL,
	[RequisitionApprove] [bit] NULL,
	[LeaveApprove] [bit] NULL,
	[VouchersRestriction] [nvarchar](250) NULL,
	[FirstName] [nvarchar](250) NULL,
	[LastName] [nvarchar](250) NULL,
	[RegisterDate] [datetime] NULL,
	[ModifyDate] [datetime] NULL,
	[PhoneNumber] [nvarchar](150) NULL,
	[EmailAddress] [nvarchar](250) NULL,
	[ProfileImage] [nvarchar](250) NULL,
	[ShowDashBoard] [bit] NULL,
	[CashAccount] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[Pos_InventWareHouse]    Script Date: 5/4/2021 2:08:51 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'Pos_InventWareHouse' AND ss.name = N'dbo')
CREATE TYPE [dbo].[Pos_InventWareHouse] AS TABLE(
	[WHID] [int] NULL,
	[WHDesc] [nvarchar](50) NULL,
	[GLCAID] [int] NULL,
	[CompanyID] [int] NULL,
	[BranchID] [int] NULL,
	[PhoneNo] [nvarchar](250) NULL,
	[LocationAddress] [nvarchar](250) NULL,
	[CityId] [int] NULL,
	[Email] [nvarchar](250) NULL,
	[AreaName] [nvarchar](250) NULL,
	[WhCode] [nvarchar](250) NULL,
	[SNo] [int] NULL,
	[CityNameManual] [nvarchar](1000) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[Pos_Pes_SchemeDetail]    Script Date: 5/4/2021 2:08:51 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'Pos_Pes_SchemeDetail' AND ss.name = N'dbo')
CREATE TYPE [dbo].[Pos_Pes_SchemeDetail] AS TABLE(
	[SchemeDetailID] [int] NULL,
	[SchemeID] [int] NOT NULL,
	[ItemId] [int] NULL,
	[Qauntity] [numeric](10, 3) NULL,
	[Rate] [numeric](10, 3) NULL,
	[Discount] [numeric](10, 3) NULL,
	[NetAmount] [numeric](10, 3) NULL,
	[Remarks] [varchar](300) NULL,
	[DiscountPercentage] [numeric](10, 3) NULL,
	[CartonForward] [numeric](18, 3) NULL,
	[CartonRate] [numeric](18, 3) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[Pos_Pes_SchemeInfo]    Script Date: 5/4/2021 2:08:51 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'Pos_Pes_SchemeInfo' AND ss.name = N'dbo')
CREATE TYPE [dbo].[Pos_Pes_SchemeInfo] AS TABLE(
	[SchemeID] [int] NULL,
	[EntryUserID] [int] NULL,
	[EntryUserDateTime] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyUserDateTime] [datetime] NULL,
	[CompanyID] [int] NULL,
	[Title] [nvarchar](500) NULL,
	[ShortCode] [nvarchar](50) NULL,
	[SchemeTypeID] [int] NULL,
	[BookingStartDate] [date] NULL,
	[BookingEndDate] [date] NULL,
	[DeliveryStartDate] [date] NULL,
	[DeliveryEndDate] [date] NULL,
	[RecoveryStartDate] [date] NULL,
	[RecoveryEndDate] [date] NULL,
	[NetAmount] [decimal](18, 3) NULL,
	[Remarks] [varchar](300) NULL,
	[BranchID] [int] NULL,
	[WithoutRate] [int] NULL,
	[StartTime] [datetime] NULL,
	[WHID] [int] NULL,
	[PromoPercentage] [numeric](18, 3) NULL,
	[ApplicableOnAll] [bit] NULL,
	[EndTime] [datetime] NULL,
	[BaseQuantity] [numeric](18, 3) NULL,
	[PGID] [int] NULL,
	[Sno] [int] NULL,
	[IsExpire] [bit] NULL
)
GO
/****** Object:  StoredProcedure [dbo].[pos_ApiGetPromosandWareHouseandGlUser_SelectAll]    Script Date: 5/4/2021 2:08:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pos_ApiGetPromosandWareHouseandGlUser_SelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[pos_ApiGetPromosandWareHouseandGlUser_SelectAll] AS' 
END
GO



ALTER procedure [dbo].[pos_ApiGetPromosandWareHouseandGlUser_SelectAll]
@SelectMaster bit,
@SelectDetail bit,
@WhereClause varchar(4000),
@WhereClauseDetail varchar(4000),
@WhereClauseWHID nvarchar(Max)
as

if @SelectMaster = 1
BEGIN
	exec('select * from InventwareHouse '+ @WhereClauseWHID)
END


if @SelectDetail = 1
BEGIN
	exec('Select * from GlUser '+ @WhereClauseDetail)
END

if @SelectDetail = 1
BEGIN
	exec('Select * from gen_pes_schemeinfo '+ @WhereClauseWHID)
END
if @SelectDetail = 1
BEGIN
	exec('Select gen_Pes_SchemeDetail.* from Gen_pes_schemeDetail left join gen_Pes_SchemeInfo on gen_Pes_SchemeInfo.SchemeID=gen_Pes_SchemeDetail.SchemeID '+ @WhereClauseWHID)
END


GO
/****** Object:  StoredProcedure [dbo].[pos_ApiSalesMan_SelectAll]    Script Date: 5/4/2021 2:08:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pos_ApiSalesMan_SelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[pos_ApiSalesMan_SelectAll] AS' 
END
GO



ALTER procedure [dbo].[pos_ApiSalesMan_SelectAll]
@SelectMaster bit,
@SelectDetail bit,
@WhereClause varchar(4000),
@WhereClauseDetail varchar(4000)
as

if @SelectMaster = 1
BEGIN
	exec('select * from gen_SaleManInfo '+ @WhereClause)
END



GO
/****** Object:  StoredProcedure [dbo].[PosApi_AllGlUserPromoLocations_Insert]    Script Date: 5/4/2021 2:08:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PosApi_AllGlUserPromoLocations_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[PosApi_AllGlUserPromoLocations_Insert] AS' 
END
GO



ALTER procedure [dbo].[PosApi_AllGlUserPromoLocations_Insert]
@StockTransferID int output,
@Pos_InventWareHouse Pos_InventWareHouse  readonly,
@Pos_Pes_SchemeInfo Pos_Pes_SchemeInfo readonly,
@Pos_Gluser Pos_Gluser readonly,
@Pos_Pes_SchemeDetail Pos_Pes_SchemeDetail readonly
as
begin

truncate table InventWareHouse
truncate table GlUser
truncate table gen_pes_schemeinfo
truncate table gen_Pes_SchemeDetail

SET IDENTITY_INSERT InventWareHouse ON
insert into        InventWareHouse(
WHID, WHDesc, GLCAID, CompanyID, BranchID, PhoneNo, LocationAddress, CityId, Email, AreaName, WhCode, SNo, CityNameManual
)

Select WHID, WHDesc, GLCAID, CompanyID, BranchID, PhoneNo, LocationAddress, CityId, Email, AreaName, WhCode, SNo, CityNameManual
 from @Pos_InventWareHouse


SET IDENTITY_INSERT InventWareHouse OFF


SET IDENTITY_INSERT GlUser ON

insert into     GlUser(

Userid, UserName, UserPassword, GroupID, Type, Entryby, TimeStamp, Active, CompanyID, AccountTitle, Taxmode, AllowDbBackup, RequisitionApprove, LeaveApprove, VouchersRestriction, FirstName, LastName, 
                         RegisterDate, ModifyDate, PhoneNumber, EmailAddress, ProfileImage, ShowDashBoard, CashAccount
)
Select 
Userid, UserName, UserPassword, GroupID, Type, Entryby, TimeStamp, Active, CompanyID, AccountTitle, Taxmode, AllowDbBackup, RequisitionApprove, LeaveApprove, VouchersRestriction, FirstName, LastName, 
                         RegisterDate, ModifyDate, PhoneNumber, EmailAddress, ProfileImage, ShowDashBoard, CashAccount

FROM            @Pos_GlUser
SET IDENTITY_INSERT GlUser OFF


SET IDENTITY_INSERT gen_pes_schemeinfo ON

insert into   gen_pes_schemeinfo(  SchemeID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, Title, ShortCode, SchemeTypeID, BookingStartDate, BookingEndDate, DeliveryStartDate, DeliveryEndDate, RecoveryStartDate, 
                         RecoveryEndDate, NetAmount, Remarks, BranchID, WithoutRate, StartTime, WHID, PromoPercentage, ApplicableOnAll, EndTime, BaseQuantity, PGID, Sno, IsExpire
)Select SchemeID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, Title, ShortCode, SchemeTypeID, BookingStartDate, BookingEndDate, DeliveryStartDate, DeliveryEndDate, RecoveryStartDate, 
                         RecoveryEndDate, NetAmount, Remarks, BranchID, WithoutRate, StartTime, WHID, PromoPercentage, ApplicableOnAll, EndTime, BaseQuantity, PGID, Sno, IsExpire FROM            @Pos_Pes_SchemeInfo


SET IDENTITY_INSERT gen_pes_schemeinfo OFF



SET IDENTITY_INSERT gen_Pes_SchemeDetail ON

insert into gen_Pes_SchemeDetail(SchemeDetailID, SchemeID, ItemId, Qauntity, Rate, Discount, NetAmount, Remarks, DiscountPercentage, CartonForward, CartonRate)
SELECT        SchemeDetailID, SchemeID, ItemId, Qauntity, Rate, Discount, NetAmount, Remarks, DiscountPercentage, CartonForward, CartonRate
FROM            @Pos_Pes_SchemeDetail

SET IDENTITY_INSERT gen_Pes_SchemeDetail OFF
SET @StockTransferID=1


End


GO
/****** Object:  StoredProcedure [dbo].[POSdata_SaleandReturnInfoServer_SelectAll]    Script Date: 5/4/2021 2:08:51 PM ******/
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
                         MinQuantity

FROM            data_SalePosReturnDetail inner join data_SalePosReturnInfo on data_SalePosReturnInfo.SalePosReturnID=data_SalePosReturnDetail.SalePosReturnID '+ @WhereClauseReturn)
end

end













GO
