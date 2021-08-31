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
ALTER TABLE dbo.GLUser ADD
	ShopUserType int NULL
GO
ALTER TABLE dbo.GLUser SET (LOCK_ESCALATION = TABLE)
GO
COMMIT

/****** Object:  StoredProcedure [dbo].[PosApi_AllGlUserPromoLocations_Insert]    Script Date: 8/31/2021 2:17:19 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PosApi_AllGlUserPromoLocations_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PosApi_AllGlUserPromoLocations_Insert]
GO
/****** Object:  StoredProcedure [dbo].[pos_ApiGetPromosandWareHouseandGlUser_SelectAll]    Script Date: 8/31/2021 2:17:19 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pos_ApiGetPromosandWareHouseandGlUser_SelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pos_ApiGetPromosandWareHouseandGlUser_SelectAll]
GO
/****** Object:  UserDefinedTableType [dbo].[Pos_GLUser]    Script Date: 8/31/2021 2:17:19 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'Pos_GLUser' AND ss.name = N'dbo')
DROP TYPE [dbo].[Pos_GLUser]
GO
/****** Object:  UserDefinedTableType [dbo].[Pos_GLUser]    Script Date: 8/31/2021 2:17:19 PM ******/
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
	[CashAccount] [int] NULL,
	ShopUserType int NULL
)
GO
/****** Object:  StoredProcedure [dbo].[pos_ApiGetPromosandWareHouseandGlUser_SelectAll]    Script Date: 8/31/2021 2:17:19 PM ******/
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
	exec('SELECT        Userid, UserName, UserPassword, GroupID, Type, Entryby, TimeStamp, Active, CompanyID, AccountTitle, Taxmode, AllowDbBackup, RequisitionApprove, LeaveApprove, VouchersRestriction, FirstName, LastName, 
                         RegisterDate, ModifyDate, PhoneNumber, EmailAddress, ProfileImage, ShowDashBoard, CashAccount,ShopUserType
FROM            GLUser '+ @WhereClauseDetail)
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
/****** Object:  StoredProcedure [dbo].[PosApi_AllGlUserPromoLocations_Insert]    Script Date: 8/31/2021 2:17:19 PM ******/
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
                         RegisterDate, ModifyDate, PhoneNumber, EmailAddress, ProfileImage, ShowDashBoard, CashAccount,ShopUserType
)
Select 
Userid, UserName, UserPassword, GroupID, Type, Entryby, TimeStamp, Active, CompanyID, AccountTitle, Taxmode, AllowDbBackup, RequisitionApprove, LeaveApprove, VouchersRestriction, FirstName, LastName, 
                         RegisterDate, ModifyDate, PhoneNumber, EmailAddress, ProfileImage, ShowDashBoard, CashAccount,ShopUserType

FROM            @Pos_GlUser
SET IDENTITY_INSERT GlUser OFF


SET IDENTITY_INSERT gen_pes_schemeinfo ON

insert into   gen_pes_schemeinfo(  SchemeID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, Title, ShortCode, SchemeTypeID, BookingStartDate, BookingEndDate, DeliveryStartDate, DeliveryEndDate, RecoveryStartDate, 
                         RecoveryEndDate, NetAmount, Remarks, BranchID, WithoutRate, StartTime, WHID, PromoPercentage, EndTime, BaseQuantity, PGID, Sno, IsExpire,ApplicableOnAll
)Select SchemeID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, Title, ShortCode, SchemeTypeID, BookingStartDate, BookingEndDate, DeliveryStartDate, DeliveryEndDate, RecoveryStartDate, 
                         RecoveryEndDate, NetAmount, Remarks, BranchID, WithoutRate, StartTime, WHID, PromoPercentage, EndTime, BaseQuantity, PGID, Sno, IsExpire,ApplicableOnAll FROM            @Pos_Pes_SchemeInfo


SET IDENTITY_INSERT gen_pes_schemeinfo OFF



SET IDENTITY_INSERT gen_Pes_SchemeDetail ON

insert into gen_Pes_SchemeDetail(SchemeDetailID, SchemeID, ItemId, Qauntity, Rate, Discount, NetAmount, Remarks, DiscountPercentage, CartonForward, CartonRate)
SELECT        SchemeDetailID, SchemeID, ItemId, Qauntity, Rate, Discount, NetAmount, Remarks, DiscountPercentage, CartonForward, CartonRate
FROM            @Pos_Pes_SchemeDetail

SET IDENTITY_INSERT gen_Pes_SchemeDetail OFF
SET @StockTransferID=1


End



GO
