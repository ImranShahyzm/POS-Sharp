using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace POS.Helper
{
    public class data_StockTransferInfoModel : RightsClass
    {
      

        public string ItemSer = "[]";
        public string WHSer = "[]";
        public bool ActivateShedTransfer { get; set; }

        public string DetailDataTableSer = "[]";

        public string BatchDataTableSer = "[]";

        public string BatchStockDataTableSer = "[]";

        public Int32 StockTransferID { get; set; }
        public Int32 ArrivalID { get; set; }
        public DateTime TransferDate { get; set; }
        public Int32 TransferNo { get; set; }
        public Int32 TransferFromWHID { get; set; }
        public Int32? TransferToWHID { get; set; }
        public Int32? TransferToShedId { get; set; }
        public Int32? FromBranchID { get; set; }
        public Int32? ToBranchID { get; set; }
        public String Remarks { get; set; }
        public DataTable DetailDataTable { get; set; }
        public DataTable BatchDataTable { get; set; }
        public bool IsStockToShed { get; set; }
        public int RefID {get; set;}
        public string ManualNo { get; set; }
        public string VehicleNo { get; set; }

        public DateTime ArrivalDate { get; set; }

        public enum SP
        {
            data_StockTransferInfo_Insert,
            data_StockTransferInfo_SelectAll,
            data_StockTransferInfo_delete,
            PosApi_RawMaterialStock_Insert,
            POSdata_StockArrivalInfo_Insert,
            data_RawStockArrival_SelectAll,
            POSAPI_StockRaw_Insert,
            POSData_StockInwardRem_load,
            POSData_StockRawTrasnfer_load,
            POSdata_StockArrival_delete,
            POSdata_StockArrivalManualInfo_Insert,
            POSdata_StockArrivalInfo_SelectAll,
            POSdata_SaleandReturnInfoServer_SelectAll,
            PosApi_AllInevntory_Insert


        }
        public enum Fields
        {
            StockTransferID,
            TransferDate,
            TransferNo,
            TransferFromWHID,
            TransferToWHID,
            FromBranchID,
            ToBranchID,
            IsTaxable,
            Remarks,
            ArrivalID

        }

        public DataSet SelectAll(string WhereClause = "", string WhereClauseDetail = "", bool SelectMaster = true,
            bool SelectDetail = false, string WCparamDetail = "", bool SelectparamDetail = false)
        {
            DataSet ds = new DataSet(); List<SqlParameter> ParamList = new List<SqlParameter>();
            ParamList.Add(new SqlParameter("@SelectMaster", SelectMaster));
            ParamList.Add(new SqlParameter("@SelectDetail", SelectDetail));
            ParamList.Add(new SqlParameter("@WhereClause", WhereClause));
            ParamList.Add(new SqlParameter("@WhereClauseDetail", WhereClauseDetail));
            ParamList.Add(new SqlParameter("@WCparamDetail", WCparamDetail));
            ParamList.Add(new SqlParameter("@SelectparamDetail", SelectparamDetail));
            ds = STATICClass.SelectAll(SP.data_StockTransferInfo_SelectAll.ToString(), ParamList);
            return ds;
        }

        public DataSet SelectAllRemainingMaster(string WhereClause = "", string EditClauseDetail = "")
        {
            DataSet ds = new DataSet(); List<SqlParameter> ParamList = new List<SqlParameter>();
            ParamList.Add(new SqlParameter("@WhereClause", WhereClause));
            ParamList.Add(new SqlParameter("@EditClause", EditClauseDetail));
            ds = STATICClass.SelectAll(SP.POSData_StockRawTrasnfer_load.ToString(), ParamList);
            return ds;
        }
        public DataSet SelectAllRemaining(string WhereClause = "", string EditClauseDetail = "")
        {
            DataSet ds = new DataSet(); List<SqlParameter> ParamList = new List<SqlParameter>();
            ParamList.Add(new SqlParameter("@WhereClause", WhereClause));
            ParamList.Add(new SqlParameter("@EditClause", EditClauseDetail));
            ds = STATICClass.SelectAll(SP.POSData_StockInwardRem_load.ToString(), ParamList);
            return ds;
        }



        public bool Insert()
        {
            bool ReturnValue;
            SqlParameter p = new SqlParameter(Fields.StockTransferID.ToString(), this.StockTransferID);
            p.Direction = ParameterDirection.InputOutput;
            List<SqlParameter> ParamList = new List<SqlParameter>();
            ParamList.Add(p);
            ParamList.Add(new SqlParameter(MianFields.CompanyID.ToString(), this.CompanyID));
            ParamList.Add(new SqlParameter(MianFields.UserID.ToString(), this.UserID));
            ParamList.Add(new SqlParameter(MianFields.FiscalID.ToString(), this.FiscalID));
            ParamList.Add(new SqlParameter(Fields.TransferDate.ToString(), this.TransferDate));
            ParamList.Add(new SqlParameter(Fields.TransferNo.ToString(), this.TransferNo));
            ParamList.Add(new SqlParameter(Fields.TransferFromWHID.ToString(), this.TransferFromWHID));
            ParamList.Add(new SqlParameter(Fields.TransferToWHID.ToString(), this.TransferToWHID));
            ParamList.Add(new SqlParameter(Fields.FromBranchID.ToString(), this.FromBranchID));
            ParamList.Add(new SqlParameter(Fields.ToBranchID.ToString(), this.ToBranchID));
            ParamList.Add(new SqlParameter(Fields.IsTaxable.ToString(), this.IsTaxable));
            ParamList.Add(new SqlParameter(Fields.Remarks.ToString(), this.Remarks));
            ParamList.Add(new SqlParameter("@data_StockTransferDetail", this.DetailDataTable));
            ParamList.Add(new SqlParameter("@data_ItemBatchDetail", this.BatchDataTable));
            ParamList.Add(new SqlParameter("@TransferToShedId", this.TransferToShedId));
            ParamList.Add(new SqlParameter("@IsStockToShed", this.IsStockToShed));
            DataTable ret = STATICClass.ExecuteInsert(SP.data_StockTransferInfo_Insert.ToString()
                , ParamList);
            if (ret.Columns.Contains("StockTransferID"))
            {
                this.StockTransferID = Convert.ToInt32(ret.Rows[0]["StockTransferID"].ToString());
            }
            this.ErrorMsg = ret.Rows[0]["ErrorMsg"].ToString();
            ReturnValue = Convert.ToBoolean(ret.Rows[0]["NoError"].ToString());
            return ReturnValue;

        }


        public bool InsertRawFromAPI( DataTable dt)
        {
            bool ReturnValue;
            SqlParameter p = new SqlParameter(Fields.StockTransferID.ToString(), this.StockTransferID);
            p.Direction = ParameterDirection.InputOutput;
            List<SqlParameter> ParamList = new List<SqlParameter>();
            ParamList.Add(p);
           
            ParamList.Add(new SqlParameter("@data_RawStockTransfer", dt));
          
            DataTable ret = STATICClass.ExecuteInsert(SP.PosApi_RawMaterialStock_Insert.ToString()
                , ParamList);
            if (ret.Columns.Contains("StockTransferID"))
            {
                this.StockTransferID = Convert.ToInt32(ret.Rows[0]["StockTransferID"].ToString());
            }
            this.ErrorMsg = ret.Rows[0]["ErrorMsg"].ToString();
            ReturnValue = Convert.ToBoolean(ret.Rows[0]["NoError"].ToString());
            return ReturnValue;

        }
        public bool InsertRawDetailFromAPI(DataTable dt,int StockTransferID)
        {
            bool ReturnValue;
            SqlParameter p = new SqlParameter(Fields.StockTransferID.ToString(), StockTransferID);
            p.Direction = ParameterDirection.InputOutput;
            List<SqlParameter> ParamList = new List<SqlParameter>();
            ParamList.Add(p);

            ParamList.Add(new SqlParameter("@data_StockTransferRawDetail", dt));

            DataTable ret = STATICClass.ExecuteInsert(SP.POSAPI_StockRaw_Insert.ToString()
                , ParamList);
            if (ret.Columns.Contains("StockTransferID"))
            {
                this.StockTransferID = Convert.ToInt32(ret.Rows[0]["StockTransferID"].ToString());
            }
            this.ErrorMsg = ret.Rows[0]["ErrorMsg"].ToString();
            ReturnValue = Convert.ToBoolean(ret.Rows[0]["NoError"].ToString());
            return ReturnValue;

        }
        public DataTable AddGroupsTableColumns(DataTable dt)
        {

            dt.Columns.Add("ItemGroupID");

            dt.Columns.Add("ItemGroupName");
            dt.Columns.Add("CompanyID");
            dt.Columns.Add("ItemMainGroupID");
            return dt;
        }
        public DataTable AddMainGroupsTableColumns(DataTable dt)
        {

            dt.Columns.Add("ItemMainGroupID");

            dt.Columns.Add("EntryUserID");
            dt.Columns.Add("EntryUserDateTime");
            dt.Columns.Add("ModifyUserID");
            dt.Columns.Add("ModifyUserDateTime");
            dt.Columns.Add("CompanyID");
            dt.Columns.Add("ItemMainGroupName");

            return dt;
        }
        public bool insertAllInventory(DataSet dt, int StockTransferID)
        {
            bool ReturnValue;
            SqlParameter p = new SqlParameter(Fields.StockTransferID.ToString(), StockTransferID);
            p.Direction = ParameterDirection.InputOutput;
            List<SqlParameter> ParamList = new List<SqlParameter>();
            ParamList.Add(p);
            
            ParamList.Add(new SqlParameter("@POSAPI_InventItems", dt.Tables[0]));

            DataTable MainGrpudt = dt.Tables[2];
            if (dt.Tables[3].Rows.Count<=0)
            {
                 MainGrpudt = AddMainGroupsTableColumns(dt.Tables[2]);

                
            }
            ParamList.Add(new SqlParameter("@gen_ItemMainGroupInfo", MainGrpudt));
            DataTable GroupDt= dt.Tables[3];
            if (dt.Tables[3].Rows.Count<=0)
            {
                GroupDt = AddGroupsTableColumns(dt.Tables[3]);

                
            }
            ParamList.Add(new SqlParameter("@InventItemGroup", GroupDt));
            ParamList.Add(new SqlParameter("@inventCategory", dt.Tables[1]));
            
            ParamList.Add(new SqlParameter("@inventUOM", dt.Tables[4]));

            DataTable ret = STATICClass.ExecuteInsert(SP.PosApi_AllInevntory_Insert.ToString()
                , ParamList);
            if (ret.Columns.Contains("StockTransferID"))
            {
                this.StockTransferID = Convert.ToInt32(ret.Rows[0]["StockTransferID"].ToString());
            }
            this.ErrorMsg = ret.Rows[0]["ErrorMsg"].ToString();
            ReturnValue = Convert.ToBoolean(ret.Rows[0]["NoError"].ToString());
            return ReturnValue;

        }

        public bool insertDetaildata(DataTable dt,data_StockTransferInfoModel model)
        {
            bool ReturnValue;
            SqlParameter p = new SqlParameter(Fields.ArrivalID.ToString(), model.ArrivalID);
            p.Direction = ParameterDirection.InputOutput;
            List<SqlParameter> ParamList = new List<SqlParameter>();
            ParamList.Add(p);

            ParamList.Add(new SqlParameter("@RefID", model.RefID));
            ParamList.Add(new SqlParameter("@ArrivalDate", model.ArrivalDate));
            ParamList.Add(new SqlParameter("@UserID", CompanyInfo.UserID));
            ParamList.Add(new SqlParameter("@CompanyID", CompanyInfo.CompanyID));
            //ParamList.Add(new SqlParameter("@CompanyID", CompanyInfo.CompanyID));
            ParamList.Add(new SqlParameter("@FiscalID", CompanyInfo.FiscalID));
            ParamList.Add(new SqlParameter("@data_StockArrivalDetail", dt));

            DataTable ret = STATICClass.ExecuteInsert(SP.POSdata_StockArrivalInfo_Insert.ToString()
                , ParamList);
            if (ret.Columns.Contains("ArrivalID"))
            {
                model.ArrivalID = Convert.ToInt32(ret.Rows[0]["ArrivalID"].ToString());
            }
            this.ErrorMsg = ret.Rows[0]["ErrorMsg"].ToString();
            ReturnValue = Convert.ToBoolean(ret.Rows[0]["NoError"].ToString());
            return ReturnValue;

        }

        public bool InsertManualDetaildata(DataTable dt, data_StockTransferInfoModel model)
        {
            bool ReturnValue;
            SqlParameter p = new SqlParameter(Fields.ArrivalID.ToString(), model.ArrivalID);
            p.Direction = ParameterDirection.InputOutput;
            List<SqlParameter> ParamList = new List<SqlParameter>();
            ParamList.Add(p);

            ParamList.Add(new SqlParameter("@RefID", model.RefID));
            ParamList.Add(new SqlParameter("@ArrivalDate", model.ArrivalDate));
            ParamList.Add(new SqlParameter("@UserID", CompanyInfo.UserID));
            ParamList.Add(new SqlParameter("@CompanyID", CompanyInfo.CompanyID));
            //ParamList.Add(new SqlParameter("@CompanyID", CompanyInfo.CompanyID));
            ParamList.Add(new SqlParameter("@FiscalID", CompanyInfo.FiscalID));
            ParamList.Add(new SqlParameter("@TransferToWHID", CompanyInfo.WareHouseID));

            ParamList.Add(new SqlParameter("@ManualNo", model.ManualNo));
            ParamList.Add(new SqlParameter("@VehicleNo", model.VehicleNo));
            ParamList.Add(new SqlParameter("@Remarks", model.Remarks));


            ParamList.Add(new SqlParameter("@ToBranchID", CompanyInfo.BranchID));
            ParamList.Add(new SqlParameter("@data_StockArrivalManual", dt));

            DataTable ret = STATICClass.ExecuteInsert(SP.POSdata_StockArrivalManualInfo_Insert.ToString()
                , ParamList);
            if (ret.Columns.Contains("ArrivalID"))
            {
                model.ArrivalID = Convert.ToInt32(ret.Rows[0]["ArrivalID"].ToString());
            }
            this.ErrorMsg = ret.Rows[0]["ErrorMsg"].ToString();
            ReturnValue = Convert.ToBoolean(ret.Rows[0]["NoError"].ToString());
            return ReturnValue;

        }


        public string Delete(Int32 MasterID)
        {
            List<SqlParameter> ParamList = new List<SqlParameter>();
            ParamList.Add(new SqlParameter(Fields.StockTransferID.ToString(), MasterID));
            DataTable ret = STATICClass.ExecuteDelete(SP.data_StockTransferInfo_delete.ToString()
                , ParamList);
            return ret.Rows[0]["MESSAGE"].ToString();
        }
        public string ArrivalDelete(Int32 MasterID)
        {
            List<SqlParameter> ParamList = new List<SqlParameter>();
            ParamList.Add(new SqlParameter(Fields.ArrivalID.ToString(), MasterID));
            DataTable ret = STATICClass.ExecuteDelete(SP.POSdata_StockArrival_delete.ToString()
                , ParamList);
            return ret.Rows[0]["MESSAGE"].ToString();
        }
        
        public DataTable GetArrivedRawData(int RefId)
        {
            DataTable ds = new DataTable();
            List<SqlParameter> ParamList = new List<SqlParameter>();          
            ParamList.Add(new SqlParameter("@WhereClause ", "where TransferIDRef="+RefId+""));
            ds = STATICClass.SelectAll(SP.data_RawStockArrival_SelectAll.ToString(), ParamList).Tables[0];
            return ds;
        }
        public DataSet SelectAllArrivalStock(string WhereClause = "",bool BoolMaster = true,
            bool DetailMaster = false, string WhereClauseDetail = "")
        {
            DataSet ds = new DataSet(); List<SqlParameter> ParamList = new List<SqlParameter>();
            ParamList.Add(new SqlParameter("@WhereClause", WhereClause));
            ParamList.Add(new SqlParameter("@BoolMaster", BoolMaster));
            ParamList.Add(new SqlParameter("@DetailMaster", DetailMaster));
            ParamList.Add(new SqlParameter("@WhereClauseDetail", WhereClauseDetail));
            ds = STATICClass.SelectAll(SP.POSdata_StockArrivalInfo_SelectAll.ToString(), ParamList);
            return ds;
        }

        public DataSet SelectAllInvoicesForUploading(string WhereClause = "", bool BoolMaster = true,
            bool DetailMaster = false, string WhereClauseDetail = "",string WhereClauseReturn="",bool isSales=true)
        {
            DataSet ds = new DataSet(); List<SqlParameter> ParamList = new List<SqlParameter>();
            ParamList.Add(new SqlParameter("@WhereClause", WhereClause));
            ParamList.Add(new SqlParameter("@BoolMaster", BoolMaster));
            ParamList.Add(new SqlParameter("@DetailMaster", DetailMaster));
            ParamList.Add(new SqlParameter("@WhereClauseDetail", WhereClauseDetail));
            ParamList.Add(new SqlParameter("@isSales", isSales));
            ParamList.Add(new SqlParameter("@WhereClauseReturn", WhereClauseReturn));
            
            ds = STATICClass.SelectAll(SP.POSdata_SaleandReturnInfoServer_SelectAll.ToString(), ParamList);
            return ds;
        }

    }
}
