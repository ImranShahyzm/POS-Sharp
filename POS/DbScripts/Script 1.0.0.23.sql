/****** Object:  StoredProcedure [dbo].[POSdata_StockReturntoServer_SelectAll]    Script Date: 5/7/2021 1:32:09 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockReturntoServer_SelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_StockReturntoServer_SelectAll]
GO
/****** Object:  StoredProcedure [dbo].[POSdata_StockIssuancetoPosKitchenServer_Insert]    Script Date: 5/7/2021 1:32:09 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockIssuancetoPosKitchenServer_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_StockIssuancetoPosKitchenServer_Insert]
GO
/****** Object:  StoredProcedure [dbo].[POSData_StockInwardRem_loadKhaaki]    Script Date: 5/7/2021 1:32:09 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSData_StockInwardRem_loadKhaaki]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSData_StockInwardRem_loadKhaaki]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_data_StockIssuancetoPosKitchenServer_data_StockIssuancetoPosKitchenServer]') AND parent_object_id = OBJECT_ID(N'[dbo].[data_StockIssuancetoPosKitchenServer]'))
ALTER TABLE [dbo].[data_StockIssuancetoPosKitchenServer] DROP CONSTRAINT [FK_data_StockIssuancetoPosKitchenServer_data_StockIssuancetoPosKitchenServer]
GO
/****** Object:  Table [dbo].[data_StockIssuancetoPosKitchenServer]    Script Date: 5/7/2021 1:32:09 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockIssuancetoPosKitchenServer]') AND type in (N'U'))
DROP TABLE [dbo].[data_StockIssuancetoPosKitchenServer]
GO
/****** Object:  Table [dbo].[data_StockIssuancetoPosKitchenDetailServer]    Script Date: 5/7/2021 1:32:09 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockIssuancetoPosKitchenDetailServer]') AND type in (N'U'))
DROP TABLE [dbo].[data_StockIssuancetoPosKitchenDetailServer]
GO
/****** Object:  UserDefinedTableType [dbo].[POSdata_StockIssuancetoPosKitchenServer]    Script Date: 5/7/2021 1:32:09 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'POSdata_StockIssuancetoPosKitchenServer' AND ss.name = N'dbo')
DROP TYPE [dbo].[POSdata_StockIssuancetoPosKitchenServer]
GO
/****** Object:  UserDefinedTableType [dbo].[POSdata_StockIssuancetoPosKitchenDetailServer]    Script Date: 5/7/2021 1:32:09 PM ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'POSdata_StockIssuancetoPosKitchenDetailServer' AND ss.name = N'dbo')
DROP TYPE [dbo].[POSdata_StockIssuancetoPosKitchenDetailServer]
GO
/****** Object:  UserDefinedTableType [dbo].[POSdata_StockIssuancetoPosKitchenDetailServer]    Script Date: 5/7/2021 1:32:09 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'POSdata_StockIssuancetoPosKitchenDetailServer' AND ss.name = N'dbo')
CREATE TYPE [dbo].[POSdata_StockIssuancetoPosKitchenDetailServer] AS TABLE(
	[IssuanceDetailID] [int] NULL,
	[IssuanceID] [int] NULL,
	[ItemId] [int] NULL,
	[Quantity] [numeric](18, 3) NULL,
	[StockRate] [numeric](14, 5) NOT NULL,
	[CartonQuantity] [numeric](18, 3) NULL,
	[LooseQuantity] [numeric](18, 3) NULL,
	[TransferDetailID] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[POSdata_StockIssuancetoPosKitchenServer]    Script Date: 5/7/2021 1:32:09 PM ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'POSdata_StockIssuancetoPosKitchenServer' AND ss.name = N'dbo')
CREATE TYPE [dbo].[POSdata_StockIssuancetoPosKitchenServer] AS TABLE(
	[IssuanceID] [int] NULL,
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
	[IssuanceType] [int] NULL
)
GO
/****** Object:  Table [dbo].[data_StockIssuancetoPosKitchenDetailServer]    Script Date: 5/7/2021 1:32:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockIssuancetoPosKitchenDetailServer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[data_StockIssuancetoPosKitchenDetailServer](
	[ServerDetailID] [int] IDENTITY(1,1) NOT NULL,
	[IssuanceDetailID] [int] NULL,
	[IssuanceID] [int] NULL,
	[ItemId] [int] NULL,
	[Quantity] [numeric](18, 3) NULL,
	[StockRate] [numeric](14, 5) NOT NULL,
	[CartonQuantity] [numeric](18, 3) NULL,
	[LooseQuantity] [numeric](18, 3) NULL,
	[TransferDetailID] [int] NULL,
	[ServerGenerateID] [int] NULL,
 CONSTRAINT [PK_data_StockIssuancetoPosKitchenDetailServer] PRIMARY KEY CLUSTERED
(
	[ServerDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[data_StockIssuancetoPosKitchenServer]    Script Date: 5/7/2021 1:32:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[data_StockIssuancetoPosKitchenServer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[data_StockIssuancetoPosKitchenServer](
	[ServerGenerateID] [int] IDENTITY(1,1) NOT NULL,
	[IssuanceID] [int] NULL,
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
 CONSTRAINT [PK_data_StockIssuancetoPosKitchenServer_1] PRIMARY KEY CLUSTERED
(
	[ServerGenerateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_data_StockIssuancetoPosKitchenServer_data_StockIssuancetoPosKitchenServer]') AND parent_object_id = OBJECT_ID(N'[dbo].[data_StockIssuancetoPosKitchenServer]'))
ALTER TABLE [dbo].[data_StockIssuancetoPosKitchenServer]  WITH CHECK ADD  CONSTRAINT [FK_data_StockIssuancetoPosKitchenServer_data_StockIssuancetoPosKitchenServer] FOREIGN KEY([ServerGenerateID])
REFERENCES [dbo].[data_StockIssuancetoPosKitchenServer] ([ServerGenerateID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_data_StockIssuancetoPosKitchenServer_data_StockIssuancetoPosKitchenServer]') AND parent_object_id = OBJECT_ID(N'[dbo].[data_StockIssuancetoPosKitchenServer]'))
ALTER TABLE [dbo].[data_StockIssuancetoPosKitchenServer] CHECK CONSTRAINT [FK_data_StockIssuancetoPosKitchenServer_data_StockIssuancetoPosKitchenServer]
GO
/****** Object:  StoredProcedure [dbo].[POSData_StockInwardRem_loadKhaaki]    Script Date: 5/7/2021 1:32:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSData_StockInwardRem_loadKhaaki]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSData_StockInwardRem_loadKhaaki] AS'
END
GO
ALTER procedure [dbo].[POSData_StockInwardRem_loadKhaaki]
@WhereClause varchar(4000),
@EditClause varchar(2000)

as


exec('select  *,(IssuedQuantity-UsedQuantity) as Remaining,0 as Received from (select
data_StockTransferRawDetail.ItemCode,
data_RawStockTransfer.TransferDate,data_RawStockTransfer.Remarks, data_StockTransferRawDetail.ItemId,InventItems.ItenName,InventUOM.UOMName, data_StockTransferRawDetail.Quantity  as IssuedQuantity,
isnull((select sum(b.Quantity)  from data_StockArrivalDetail b where b.TransferDetailID  =
 data_StockTransferRawDetail.StockTransferDetailID  '+ @EditClause +'
),0) as UsedQuantity,
data_RawStockTransfer.TransferToWHID,data_StockTransferRawDetail.StockTransferDetailID
from data_RawStockTransfer inner join data_StockTransferRawDetail on data_RawStockTransfer.TransferIDRef = data_StockTransferRawDetail.stockTransferID
left join InventItems on InventItems.ItemId=data_StockTransferRawDetail.ItemId
 left join InventUOM on InventUOM.UOMId=InventItems.UOMId
' + @WhereClause + ') a where IssuedQuantity-UsedQuantity > 0')











GO
/****** Object:  StoredProcedure [dbo].[POSdata_StockIssuancetoPosKitchenServer_Insert]    Script Date: 5/7/2021 1:32:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockIssuancetoPosKitchenServer_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_StockIssuancetoPosKitchenServer_Insert] AS'
END
GO







ALTER procedure [dbo].[POSdata_StockIssuancetoPosKitchenServer_Insert]
@IsInserted int output ,
@POSdata_StockIssuancetoPosKitchenDetailServer POSdata_StockIssuancetoPosKitchenDetailServer readonly,
@POSdata_StockIssuancetoPosKitchenServer  POSdata_StockIssuancetoPosKitchenServer readonly,
@DateFrom Date=null,
@DateTo Date=null,
@CompanyID int=null,
@WHID int=null
as


Delete from data_StockIssuancetoPosKitchenDetailServer where IssuanceID in (Select IssuanceID from data_StockIssuancetoPosKitchenServer where FromWHID=@WHID and (IssuanceDate between @DateFrom and @DateTo) and CompanyID=@CompanyID)
Delete from data_StockIssuancetoPosKitchenServer  where FromWHID=@WHID and (IssuanceDate between @DateFrom and @DateTo) and CompanyID=@CompanyID
declare @ServerGeneratedId int,@RowID int
declare firstcursor cursor for
select IssuanceID from @POSdata_StockIssuancetoPosKitchenServer
open firstcursor
fetch next from firstcursor into @RowID
while @@FETCH_STATUS = 0
	begin

	insert into data_StockIssuancetoPosKitchenServer( IssuanceID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, IssuanceDate, IssuanceNo, FromWHID, LocationID, IsTaxable, Remarks, RefID, isManual,
                         IssuanceType)
						 select
						 IssuanceID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, IssuanceDate, IssuanceNo, FromWHID, LocationID, IsTaxable, Remarks, RefID, isManual,
                         IssuanceType
FROM            @POSdata_StockIssuancetoPosKitchenServer where issuanceId=@RowID
set @ServerGeneratedId = @@IDENTITY

insert into data_StockIssuancetoPosKitchenDetailServer (IssuanceDetailID, IssuanceID, ItemId, Quantity, StockRate, CartonQuantity, LooseQuantity, TransferDetailID, ServerGenerateID)
Select IssuanceDetailID, IssuanceID, ItemId, Quantity, StockRate, CartonQuantity, LooseQuantity, TransferDetailID, @ServerGeneratedId from @POSdata_StockIssuancetoPosKitchenDetailServer where IssuanceID=@RowID

	DECLARE @Gid uniqueidentifier = CAST(CONTEXT_INFO() as uniqueidentifier);

	FETCH NEXT FROM firstcursor INTO @RowID
	END

close firstcursor
deallocate firstcursor

set @IsInserted=1




GO
/****** Object:  StoredProcedure [dbo].[POSdata_StockReturntoServer_SelectAll]    Script Date: 5/7/2021 1:32:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockReturntoServer_SelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_StockReturntoServer_SelectAll] AS'
END
GO







ALTER procedure [dbo].[POSdata_StockReturntoServer_SelectAll]
@WhereClause nvarchar(Max),
@BoolMaster bit=0,
@DetailMaster bit=0,
@WhereClauseDetail nvarchar(Max),
@WhereClauseReturn nvarchar(Max),
@WhereClauseReturnDetail nvarchar(Max)='',
@isSales bit=1
as
begin

if(@BoolMaster=1)
begin
exec('Select * from data_StockIssuancetoPosKitchen '+ @WhereClause)
end
if (@DetailMaster=1)
begin
exec('Select ddt.* from data_StockIssuancetoPosKitchenDetail ddt
inner join data_StockIssuancetoPosKitchen  on data_StockIssuancetoPosKitchen.IssuanceID=ddt.IssuanceID
 '+ @WhereClauseDetail)
end


end












GO
