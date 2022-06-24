using Common;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
   public class StockArrivalDAL
    {
        public DataTable GetAllPendingArrival(int BranchID ,int WHID)
        {
            var connectionString =CommonClass.ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            SqlTransaction tran;
            con.Open();
            tran = con.BeginTransaction();
            SqlCommand cmd;
            cmd = new SqlCommand(@"SELECT       TransferIDref as StockTransferID,  Format(TransferDate,'dd-MMM-yyyy') as FormatTransferDate , TransferNo, InventWareHouse.WHDesc,  Remarks
FROM            data_RawStockTransfer inner join InventWareHouse on InventWareHouse.WHID=data_RawStockTransfer.TransferFromWHID 
            where  TransferToWHID = " + WHID+"", con);
            SqlDataAdapter da = new SqlDataAdapter();
            DataTable dt = new DataTable();
            da.SelectCommand = cmd;
            try
            {
                cmd.Transaction = tran; da.Fill(dt);
                tran.Commit();
            }
            catch (Exception ex)
            {
                tran.Rollback();
                throw ex;
            }

            return dt;
        }


    }
}
