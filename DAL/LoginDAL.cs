using Common;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.NetworkInformation;
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
                //where += " and   Replace(CounterPCName,',','') like '%" + obj.NICID+"%'";
                where += GetWhereCondition(obj.NICID);
            }
           
                var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
                SqlConnection con = new SqlConnection(connectionString);
                SqlTransaction tran;
                con.Open();



                tran = con.BeginTransaction();
                SqlCommand cmd;
                cmd = new SqlCommand(@"select CounterPCName,CounterTitle, ISNULL(ShopUserType,0) as ShopUserType,InventWareHouse.BranchID,GLUser.Userid,GLUser.UserPassword,GLUser.UserName,GLCompany.*,gen_PosConfiguration.WHID,FiscalID,InventWareHouse.WHDesc as WareHouseName,gen_PosConfiguration.LocationID,gen_PosConfiguration.IsKhaakiSoft,gen_PosConfiguration.PosStyle,CounterID,
gen_PosConfiguration.ISFbrConnectivity , gen_PosConfiguration.POSID,gen_PosConfiguration.USIN , gen_PosConfiguration.NoOfInvoicePrint,gen_PosConfiguration.ApiIpAddress
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
                cmd.Transaction = tran;
                da.Fill(dt);
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

        public DataTable GetActiveCountersList()
        {
          
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            SqlDataAdapter adp = new SqlDataAdapter();
            DataTable dt = new DataTable();
            SqlTransaction tran;
            con.Open();



            tran = con.BeginTransaction();
            SqlCommand cmd;
            cmd = new SqlCommand(@"Select * from gen_PosConfiguration", con);
            cmd.CommandType = CommandType.Text;

            try
            {
                adp.SelectCommand = cmd;
                cmd.Transaction = tran;
                adp.Fill(dt);
                tran.Commit();
            }
            catch (Exception ex)
            {
                tran.Rollback();
                throw ex;
            }

            return dt;
        }

        private string GetNICIDs()
        {

            NetworkInterface[] nics = NetworkInterface.GetAllNetworkInterfaces();
            String sMacAddress = string.Empty;
            foreach (NetworkInterface adapter in nics)
            {
                if (adapter.GetPhysicalAddress().ToString() != String.Empty)// only return MAC Address from first card  
                {
                    IPInterfaceProperties properties = adapter.GetIPProperties();
                    sMacAddress = sMacAddress + adapter.GetPhysicalAddress().ToString() + ",";
                }

            }
            var MacAddressArray = sMacAddress.Split(',');
            return sMacAddress;


        }
        private string GetWhereCondition(string sMacAddress)
        {
            string WhereClause = " and (";
           
            var MacAddressArray = sMacAddress.Split(',');
            int Count = 0;

            foreach (var macAddress in MacAddressArray)
            {
                if (!string.IsNullOrEmpty(macAddress))
                {
                    if(Count>0)
                    {
                        WhereClause = WhereClause + " OR ";
                    }

                    WhereClause = WhereClause + "   '"+macAddress+"' in (Select * from dbo.fnSplitString1(CounterPCName,','))";
                    Count++;
                }
                
            }
            WhereClause += " )";
            return WhereClause;


        }

        public string SaveConfiguration(int ConfigID,string MacCounterPCName)
        {
            string ReturnMessage = "Done";
            DataTable dt = new DataTable();
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            SqlTransaction tran;
            con.Open();
            tran = con.BeginTransaction();
            SqlCommand cmd;
            cmd = new SqlCommand("gen_PosConfiguration_Insert", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter();
            SqlParameter p = new SqlParameter("ConfigID", ConfigID);
            p.Direction = ParameterDirection.InputOutput;
            cmd.Parameters.Add(p);
            cmd.Parameters.AddWithValue("@CounterPCName", MacCounterPCName);
            da.SelectCommand = cmd;
            try
            {
                cmd.Transaction = tran;
                da.Fill(dt);
                tran.Commit();

            }catch(Exception e)
            {
                ReturnMessage = e.Message.ToString();
                tran.Rollback();
            }
            finally
                {
                con.Close();
            }
            return ReturnMessage;
            }

        public string SetMAcAddressIfFirstRun()
        {
            string isSaved = "Done";
            bool isStoreWiseRights = false;
            int NoOfCountersAllowed = 0;
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            SqlTransaction tran;
            SqlDataAdapter adp = new SqlDataAdapter();
            con.Open();
            tran = con.BeginTransaction();
            SqlCommand cmd;
            cmd = new SqlCommand(@"Select isStoreWiseRights,NoOfCountersAllowed from gen_SystemConfiguration", con);
            cmd.CommandType = CommandType.Text;
            adp.SelectCommand = cmd;
            DataTable dt = new DataTable();
            try
            {
                cmd.Transaction = tran;
                adp.Fill(dt);
                tran.Commit();
                
            }
            catch (Exception ex)
            {
                tran.Rollback();
                throw ex;
            }

            if(dt.Rows.Count>0)
            {
                isStoreWiseRights= dt.Rows[0][0] is DBNull ? false : Convert.ToBoolean(dt.Rows[0][0].ToString());
                NoOfCountersAllowed= dt.Rows[0][1] is DBNull ? 0 : Convert.ToInt32(dt.Rows[0][1].ToString());
            }
            if(isStoreWiseRights==true && NoOfCountersAllowed>0)
            {
                var CountsList = GetActiveCountersList();
                if(CountsList.Rows.Count< NoOfCountersAllowed)
                {
                    string GetNetworkIDs = GetNICIDs();
                    bool CheckIfAlreadyAdded = false;
                    foreach(DataRow Row in CountsList.Rows)
                    {
                        var AlreadyActiveMacs = Row["CounterPCName"].ToString().Split(',');
                        foreach (var newMacAddress in GetNetworkIDs.Split(','))
                        {
                            foreach (var macAddress in AlreadyActiveMacs)
                            {
                                if (!string.IsNullOrEmpty(newMacAddress) && !string.IsNullOrEmpty(macAddress))
                                {
                                    if (newMacAddress == macAddress)
                                    {
                                        CheckIfAlreadyAdded = true;
                                    }
                                }
                                if(CheckIfAlreadyAdded)
                                {
                                    break;
                                }
                            }
                            if (CheckIfAlreadyAdded)
                            {
                                break;
                            }
                        }
                        if (CheckIfAlreadyAdded)
                        {
                            break;
                        }
                    }
                    if (!CheckIfAlreadyAdded)
                    {

                        isSaved = SaveConfiguration(0, GetNetworkIDs);
                        

                    }

                }
                else
                {
                    //isSaved = "Can't Create New Counter as Maximum Counters Limit is Reached...";
                    isSaved = "Done";
                }


            }
            return isSaved;

        }


        public int CheckIfBarcodePrinterExe()
        {
            int IsBarcodePrinter = 0;
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            SqlTransaction tran;
            con.Open();



            tran = con.BeginTransaction();
            SqlCommand cmd;
            cmd = new SqlCommand(@"Select top 1 IsBarcodePrinter from gen_PosConfiguration", con);
            cmd.CommandType = CommandType.Text;

            try
            {
                cmd.Transaction = tran;
                IsBarcodePrinter = cmd.ExecuteScalar() is DBNull ? 0 : Convert.ToInt32(cmd.ExecuteScalar());
                tran.Commit();
            }
            catch (Exception ex)
            {
                tran.Rollback();
                throw ex;
            }

            return IsBarcodePrinter;
        }
    }
}
