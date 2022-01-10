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
    public class LoginDAL
    {
        public DataTable SaveForm(LogInCommon obj )
        {
            string where = "";
                if(CheckIFStoreWiseRights())
            {
                where += " and CounterPCName='" + obj.NICID+"'";
            }
           
                var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
                SqlConnection con = new SqlConnection(connectionString);
                SqlTransaction tran;
                con.Open();



                tran = con.BeginTransaction();
                SqlCommand cmd;
                cmd = new SqlCommand(@"select CounterPCName,CounterTitle, ISNULL(ShopUserType,0) as ShopUserType,InventWareHouse.BranchID,GLUser.Userid,GLUser.UserPassword,GLUser.UserName,GLCompany.*,gen_PosConfiguration.WHID,FiscalID,InventWareHouse.WHDesc as WareHouseName,gen_PosConfiguration.LocationID,gen_PosConfiguration.IsKhaakiSoft,gen_PosConfiguration.PosStyle,CounterID,
gen_PosConfiguration.ISFbrConnectivity , gen_PosConfiguration.POSID,gen_PosConfiguration.USIN , gen_PosConfiguration.NoOfInvoicePrint
from GLUser inner join GLCompany on GLUser.CompanyID=GLCompany.Companyid inner join gen_PosConfiguration on gen_PosConfiguration.CompanyID=GLCompany.Companyid
           inner join InventWareHouse on InventWareHouse.WHID=gen_PosConfiguration.WHID
            where UserPassword = '" + obj.Password + "' and UserName = '" + obj.UserName + "' "+where+" ", con);
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
        public DataTable StoreWiseLogin(LogInCommon obj)
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            SqlTransaction tran;
            con.Open();



            tran = con.BeginTransaction();
            SqlCommand cmd;
            cmd = new SqlCommand(@"Select ISNULL(ShopUserType,0) as ShopUserType,InventWareHouse.BranchID,GLUser.Userid,GLUser.UserPassword,GLUser.UserName,GLCompany.*,gen_PosConfiguration.WHID,FiscalID,InventWareHouse.WHDesc as WareHouseName,gen_PosConfiguration.LocationID,gen_PosConfiguration.IsKhaakiSoft,gen_PosConfiguration.PosStyle,CounterID from GLUser inner join GLCompany on GLUser.CompanyID=GLCompany.Companyid inner join gen_PosConfiguration on gen_PosConfiguration.CompanyID=GLCompany.Companyid
           inner join InventWareHouse on InventWareHouse.WHID=gen_PosConfiguration.CounterID
		   inner join GluserDetailWhid on GluserDetailWhid.Userid=GLUser.Userid
            where UserPassword = '" + obj.Password + "' and UserName = '" + obj.UserName + "'", con);
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
        public bool CheckIFStoreWiseRights()
        {
            bool isStoreWiseRights = false;
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            SqlTransaction tran;
            con.Open();



            tran = con.BeginTransaction();
            SqlCommand cmd;
            cmd = new SqlCommand(@"Select top 1 isStoreWiseRights from gen_SystemConfiguration", con);
            cmd.CommandType = CommandType.Text;
          
            try
            {
                cmd.Transaction = tran;
                 isStoreWiseRights =cmd.ExecuteScalar() is DBNull ?false:Convert.ToBoolean(cmd.ExecuteScalar());
                tran.Commit();
            }
            catch (Exception ex)
            {
                tran.Rollback();
                throw ex;
            }

            return isStoreWiseRights;
        }
    }
}
