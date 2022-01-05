
/****** Object:  StoredProcedure [dbo].[PosData_tblCustomerData_SelectAll]    Script Date: 6/15/2021 4:19:02 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PosData_tblCustomerData_SelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PosData_tblCustomerData_SelectAll]
GO
/****** Object:  StoredProcedure [dbo].[PosData_tblCustomerData_Insert]    Script Date: 6/15/2021 4:19:02 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PosData_tblCustomerData_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PosData_tblCustomerData_Insert]
GO
/****** Object:  Table [dbo].[tblPos_CustomerData]    Script Date: 6/15/2021 4:19:02 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblPos_CustomerData]') AND type in (N'U'))
DROP TABLE [dbo].[tblPos_CustomerData]
GO
/****** Object:  Table [dbo].[tblPos_CustomerData]    Script Date: 6/15/2021 4:19:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblPos_CustomerData]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblPos_CustomerData](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[RegisterDate] [datetime] NULL,
	[CName] [nvarchar](1000) NULL,
	[CPhone] [nvarchar](1000) NULL,
	[Address] [nvarchar](max) NULL,
	[CityName] [nvarchar](500) NULL,
	[Gender] [nvarchar](100) NULL,
	[EntryUserID] [int] NULL,
	[EntryUserDateTime] [datetime] NULL,
	[ModifyUserID] [int] NULL,
	[ModifyUserDateTime] [datetime] NULL,
	[CompanyID] [int] NULL,
	[FiscalID] [int] NULL,
	[WHID] [int] NULL,
	[CNIC] [nvarchar](1000) NULL,
	[Neck] [nvarchar](50) NULL,
	[FFrontNeck] [nvarchar](50) NULL,
	[FBackNeck] [nvarchar](50) NULL,
	[Shoulder] [nvarchar](50) NULL,
	[FUpperBust] [nvarchar](50) NULL,
	[Bust] [nvarchar](50) NULL,
	[FUnderBust] [nvarchar](50) NULL,
	[ArmHole] [nvarchar](50) NULL,
	[SleeveLength] [nvarchar](50) NULL,
	[Muscle] [nvarchar](50) NULL,
	[Elbow] [nvarchar](50) NULL,
	[Cuff] [nvarchar](50) NULL,
	[Waist] [nvarchar](50) NULL,
	[Hip] [nvarchar](50) NULL,
	[BottomLength] [nvarchar](50) NULL,
	[Ankle] [nvarchar](50) NULL,
	[Remarks] [nvarchar](max) NULL,
	[IsTaxable] [bit] NULL,
	[Rno] [int] NULL,
 CONSTRAINT [PK_tblPos_CustomerData] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  StoredProcedure [dbo].[PosData_tblCustomerData_Insert]    Script Date: 6/15/2021 4:19:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PosData_tblCustomerData_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[PosData_tblCustomerData_Insert] AS' 
END
GO
ALTER procedure [dbo].[PosData_tblCustomerData_Insert] 

@CustomerID int  output ,
@RegisterDate datetime =NULL,
@CName nvarchar(1000) =NULL,
@CPhone nvarchar(1000) =NULL,
@Address nvarchar(max) =NULL,
@CityName nvarchar(500) =NULL,
@Gender nvarchar(100) =NULL,
@UserID int =NULL,
@CompanyID int =NULL,
@FiscalID int =NULL,
@WHID int =NULL,
@CNIC nvarchar(1000) =NULL,
@Neck nvarchar(50) =NULL,
@FFrontNeck nvarchar(50) =NULL,
@FBackNeck nvarchar(50) =NULL,
@Shoulder nvarchar(50) =NULL,
@FUpperBust nvarchar(50) =NULL,
@Bust nvarchar(50) =NULL,
@FUnderBust nvarchar(50) =NULL,
@ArmHole nvarchar(50) =NULL,
@SleeveLength nvarchar(50) =NULL,
@Muscle nvarchar(50) =NULL,
@Elbow nvarchar(50) =NULL,
@Cuff nvarchar(50) =NULL,
@Waist nvarchar(50) =NULL,
@Hip nvarchar(50) =NULL,
@BottomLength nvarchar(50) =NULL,
@Ankle nvarchar(50) =NULL,
@Remarks nvarchar(max) =NULL,
@RNo int =NULL,
@IsTaxable bit =0,
@BranchId int =0
as
declare @EditMode bit  = 0

if	 @CustomerID = 0
BEGIN
INSERT INTO tblPos_CustomerData
           (
	RegisterDate
   ,CName
   ,CPhone
   ,Address
   ,CityName
   ,Gender
   ,EntryUserID
   ,EntryUserDateTime
   ,CompanyID
   ,FiscalID
   ,WHID
   ,CNIC
   ,Neck
   ,FFrontNeck
   ,FBackNeck
   ,Shoulder
   ,FUpperBust
   ,Bust
   ,FUnderBust
   ,ArmHole
   ,SleeveLength
   ,Muscle
   ,Elbow
   ,Cuff
   ,Waist
   ,Hip
   ,BottomLength
   ,Ankle
   ,Remarks
   ,RNo
   ,IsTaxable
   )
   values(
   
   
	@RegisterDate
   ,N''+@CName
   ,@CPhone
   ,N''+@Address
   ,N''+@CityName
   ,@Gender
   ,@UserID
   ,GETDATE()
   ,@CompanyID
   ,@FiscalID
   ,@WHID
   ,@CNIC
   ,N''+@Neck
   ,N''+@FFrontNeck
   ,N''+@FBackNeck
   ,N''+@Shoulder
   ,N''+@FUpperBust
   ,N''+@Bust
   ,N''+@FUnderBust
   ,N''+@ArmHole
   ,N''+@SleeveLength
   ,N''+@Muscle
   ,N''+@Elbow
   ,N''+@Cuff
   ,N''+@Waist
   ,N''+@Hip
   ,N''+@BottomLength
   ,N''+@Ankle
   ,N''+@Remarks
   ,@RNo
   ,@IsTaxable
 
   )
	set @CustomerID = @@IDENTITY
	
END

ELSE

BEGIN	

	update tblPos_CustomerData set	
			RegisterDate		=@RegisterDate
		   ,CName				=N''+@CName
		   ,CPhone				=@CPhone
		   ,Address				=N''+@Address
		   ,CityName			=N''+@CityName
		   ,Gender				=@Gender
		   ,ModifyUserID			=@UserID
		   ,ModifyUserDateTime	=GETDATE()
		   ,CompanyID			=@CompanyID
		   ,FiscalID			=@FiscalID
		   ,WHID				=@WHID
		   ,CNIC				=@CNIC
		   ,Neck				=N''+@Neck
		   ,FFrontNeck			=N''+@FFrontNeck
		   ,FBackNeck			=N''+@FBackNeck
		   ,Shoulder			=N''+@Shoulder
		   ,FUpperBust			=N''+@FUpperBust
		   ,Bust				=N''+@Bust
		   ,FUnderBust			=N''+@FUnderBust
		   ,ArmHole				=N''+@ArmHole
		   ,SleeveLength		=N''+@SleeveLength
		   ,Muscle				=N''+@Muscle
		   ,Elbow				=N''+@Elbow
		   ,Cuff				=N''+@Cuff
		   ,Waist				=N''+@Waist
		   ,Hip					=N''+@Hip
		   ,BottomLength		=N''+@BottomLength
		   ,Ankle				=N''+@Ankle
		   ,Remarks				=N''+@Remarks
		   ,IsTaxable			=@IsTaxable
	where CustomerID=@CustomerID

	set	@EditMode = 1
END

	
GO
/****** Object:  StoredProcedure [dbo].[PosData_tblCustomerData_SelectAll]    Script Date: 6/15/2021 4:19:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PosData_tblCustomerData_SelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[PosData_tblCustomerData_SelectAll] AS' 
END
GO



ALTER procedure [dbo].[PosData_tblCustomerData_SelectAll]
@SelectMaster bit,
@WhereClause varchar(4000)
as

if @SelectMaster = 1
BEGIN
	exec('select * from tblPos_CustomerData '+ @WhereClause)
END



GO
