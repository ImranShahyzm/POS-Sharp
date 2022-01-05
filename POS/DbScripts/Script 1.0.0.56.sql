
/****** Object:  StoredProcedure [dbo].[POSdata_StockDispatchTrasnferFetch_SelectAll]    Script Date: 9/14/2021 1:14:03 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockDispatchTrasnferFetch_SelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSdata_StockDispatchTrasnferFetch_SelectAll]
GO
/****** Object:  StoredProcedure [dbo].[POSData_StockDispatchTransfer_load]    Script Date: 9/14/2021 1:14:03 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSData_StockDispatchTransfer_load]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSData_StockDispatchTransfer_load]
GO
/****** Object:  StoredProcedure [dbo].[POSData_DispatchTransferRemainig_loadKhaaki]    Script Date: 9/14/2021 1:14:03 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSData_DispatchTransferRemainig_loadKhaaki]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[POSData_DispatchTransferRemainig_loadKhaaki]
GO
/****** Object:  StoredProcedure [dbo].[PosApi_AllStockDisaptchesTransfer_Insert]    Script Date: 9/14/2021 1:14:03 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PosApi_AllStockDisaptchesTransfer_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PosApi_AllStockDisaptchesTransfer_Insert]
GO
/****** Object:  StoredProcedure [dbo].[PosApi_AllStockDisaptchesTransfer_Insert]    Script Date: 9/14/2021 1:14:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PosApi_AllStockDisaptchesTransfer_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[PosApi_AllStockDisaptchesTransfer_Insert] AS' 
END
GO




ALTER procedure [dbo].[PosApi_AllStockDisaptchesTransfer_Insert]
@StockTransferID int output,
@data_StockDispatchAgainstTransferPOS data_StockDispatchAgainstTransferPOS  readonly,
@data_StockDispatchAgainstTransferDetailPOS data_StockDispatchAgainstTransferDetailPOS readonly,
@WHID int=0,
@DateFrom date,
@DateTo date
as
begin
Delete a from data_StockDispatchAgainstTransferDetailPOS a inner join data_StockDispatchAgainstTransferPOS on a.StockDispatchID=data_StockDispatchAgainstTransferPOS.StockDispatchID
where  DispatchToWHID=@WHID and DispatchDate between @DateFrom and @Dateto 
Delete from data_StockDispatchAgainstTransferPOS where DispatchToWHID=@WHID and DispatchDate between @DateFrom and @Dateto 


insert into data_StockDispatchAgainstTransferPOS(   StockDispatchID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, DispatchDate, DispatchNo, DispatchFromWHID, DispatchToWHID, FromBranchID, ToBranchID, 
                         IsTaxable, AccountVoucherID, Remarks, TruckNumber, DriverName, DriverPhone, StockTransferID, TransferType, MakeOrderID, FromLocation, ToLocation, TotalQuantity, TotalAmount
)Select  StockDispatchID, EntryUserID, EntryUserDateTime, ModifyUserID, ModifyUserDateTime, CompanyID, FiscalID, DispatchDate, DispatchNo, DispatchFromWHID, DispatchToWHID, FromBranchID, ToBranchID, 
							 IsTaxable, AccountVoucherID, Remarks, TruckNumber, DriverName, DriverPhone, StockTransferID, TransferType, MakeOrderID, FromLocation, ToLocation, TotalQuantity, TotalAmount from            @data_StockDispatchAgainstTransferPOS


insert into data_StockDispatchAgainstTransferDetailPOS (
StockDispatchDetailID, StockDispatchID, ItemId, Quantity, StockRate, CartonQuantity, LooseQuantity, ItemCode, ItemName, Remarks, TransferDetailID, TrackBranchID, OrderDetailID, OrderID, DeliveryDate, 
                         Rno
)

SELECT         StockDispatchDetailID, StockDispatchID, ItemId, Quantity, StockRate, CartonQuantity, LooseQuantity, ItemCode, ItemName, Remarks, TransferDetailID, TrackBranchID, OrderDetailID, OrderID, DeliveryDate, 
                         Rno
FROM            @data_StockDispatchAgainstTransferDetailPOS




SET @StockTransferID=1


End






GO
/****** Object:  StoredProcedure [dbo].[POSData_DispatchTransferRemainig_loadKhaaki]    Script Date: 9/14/2021 1:14:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSData_DispatchTransferRemainig_loadKhaaki]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSData_DispatchTransferRemainig_loadKhaaki] AS' 
END
GO
ALTER procedure [dbo].[POSData_DispatchTransferRemainig_loadKhaaki] 
@WhereClause varchar(4000),
@EditClause varchar(2000)

as


exec('select  *,(IssuedQuantity-UsedQuantity) as Remaining,0 as Received from (select 
data_StockDispatchAgainstTransferDetailPOS.ItemCode,
data_StockDispatchAgainstTransferPOS.DispatchDate,data_StockDispatchAgainstTransferPOS.Remarks, data_StockDispatchAgainstTransferDetailPOS.ItemId,InventItems.ItenName,InventUOM.UOMName, data_StockDispatchAgainstTransferDetailPOS.Quantity  as IssuedQuantity,
isnull((select sum(b.Quantity)  from data_StockArrivalDetail b where b.TransferDetailID  =
 data_StockDispatchAgainstTransferDetailPOS.TransferDetailID   '+ @EditClause +'
),0) as UsedQuantity,
data_StockDispatchAgainstTransferPOS.DispatchToWhid,data_StockDispatchAgainstTransferDetailPOS.TransferDetailID
from data_StockDispatchAgainstTransferPOS 
inner join data_StockDispatchAgainstTransferDetailPOS on data_StockDispatchAgainstTransferPOS.StockTransferID=data_StockDispatchAgainstTransferDetailPOS.OrderID 
left join InventItems on InventItems.ItemId=data_StockDispatchAgainstTransferDetailPOS.ItemId 
 left join InventUOM on InventUOM.UOMId=InventItems.UOMId
' + @WhereClause + ') a where IssuedQuantity-UsedQuantity > 0')

 



 





GO
/****** Object:  StoredProcedure [dbo].[POSData_StockDispatchTransfer_load]    Script Date: 9/14/2021 1:14:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSData_StockDispatchTransfer_load]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSData_StockDispatchTransfer_load] AS' 
END
GO

ALTER procedure [dbo].[POSData_StockDispatchTransfer_load] 
@WhereClause varchar(4000),
@EditClause varchar(2000)

as


exec('select Distinct  StockTransferID,Format(DispatchDate,''dd-MMM-yyyy'') as DispatchDate,DispatchNo,WHDesc,sum(TotalPOQuantity) as TotalQuantity from (select WHDesc,
data_StockDispatchAgainstTransferPOS.DispatchNo,
data_StockDispatchAgainstTransferPOS.StockTransferID ,
data_StockDispatchAgainstTransferPOS.DispatchDate,
data_StockDispatchAgainstTransferPOS.Remarks,
 data_StockDispatchAgainstTransferDetailPOS.ItemId,
 InventItems.ItenName,InventUOM.UOMName, isnull(data_StockDispatchAgainstTransferDetailPOS.Quantity,1000) as TotalPOQuantity,
isnull((select sum(b.Quantity)  from data_StockArrivalDetail b where b.TransferDetailID  =
 data_StockDispatchAgainstTransferDetailPOS.TransferDetailID    '+ @EditClause +'

),0) as UsedQuantity,
data_StockDispatchAgainstTransferPOS.DispatchToWHID,data_StockDispatchAgainstTransferDetailPOS.TransferDetailID
from data_StockDispatchAgainstTransferPOS left join data_StockDispatchAgainstTransferDetailPOS on data_StockDispatchAgainstTransferPOS.StockTransferID = data_StockDispatchAgainstTransferDetailPOS.OrderID 
left join InventItems on InventItems.ItemId=data_StockDispatchAgainstTransferDetailPOS.ItemId 
left join InventWareHouse on InventWareHouse.WHID=data_StockDispatchAgainstTransferPOS.DispatchToWHID
 left join InventUOM on InventUOM.UOMId=InventItems.UOMId 
' + @WhereClause + ') a where TotalPOQuantity-UsedQuantity > 0
Group by StockTransferID,DispatchDate,DispatchNo,WHDesc
')

 



 







GO
/****** Object:  StoredProcedure [dbo].[POSdata_StockDispatchTrasnferFetch_SelectAll]    Script Date: 9/14/2021 1:14:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POSdata_StockDispatchTrasnferFetch_SelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[POSdata_StockDispatchTrasnferFetch_SelectAll] AS' 
END
GO



ALTER procedure [dbo].[POSdata_StockDispatchTrasnferFetch_SelectAll] 
@SelectMaster bit,
@SelectDetail bit,
@WhereClause varchar(4000),
@WhereClauseDetail varchar(4000)
as



if @SelectMaster = 1 
BEGIN
	exec('
	select data_StockDispatchAgainstTransfer.*,InventWareHouse.WHDesc as FromLocation,ab.WHDesc as TOLocation,
Cast((Select sum(Quantity) from data_StockDispatchAgainstTransferDetail where data_StockDispatchAgainstTransferDetail.StockDispatchID=data_StockDispatchAgainstTransfer.StockDispatchID)as Int) as TotalQuantity,
Cast((Select sum(Quantity*inv.ItemSalesPrice) from data_StockDispatchAgainstTransferDetail inner join InventItems inv on inv.ItemId=data_StockDispatchAgainstTransferDetail.ItemId where data_StockDispatchAgainstTransferDetail.StockDispatchID=data_StockDispatchAgainstTransfer.StockDispatchID)as Int) as TotalAmount
from data_StockDispatchAgainstTransfer
left join InventWareHouse on InventWareHouse.WHID=data_StockDispatchAgainstTransfer.DispatchFromWHID
left join InventWareHouse ab on ab.WHID=data_StockDispatchAgainstTransfer.DispatchToWHID

	 '+ @WhereClause)
END


if @SelectDetail = 1 
BEGIN

	exec('
select data_StockDispatchAgainstTransferDetail.*,fORMAT(TransferDate,''dd-MMM-yyyy'') as DeliveryDate,TransferNo as RNo  from data_StockDispatchAgainstTransferDetail  inner join data_StockTransferDetail on data_StockTransferDetail.StockTransferDetailID=data_StockDispatchAgainstTransferDetail.TransferDetailID inner join data_StockTransferInfo on data_StockTransferInfo.StockTransferID=data_StockTransferDetail.StockTransferID

inner join data_StockDispatchAgainstTransfer on data_StockDispatchAgainstTransfer.StockDispatchID=data_StockDispatchAgainstTransferDetail.StockDispatchID'+ @WhereClauseDetail)

END



GO
