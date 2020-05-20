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
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            SqlTransaction tran;
            con.Open();
            tran = con.BeginTransaction();
            SqlCommand cmd;
            cmd = new SqlCommand(@"select GLUser.Userid,GLUser.UserPassword,GLUser.UserName,GLCompany.*,gen_PosConfiguration.WHID,FiscalID from GLUser inner join GLCompany on GLUser.CompanyID=GLCompany.Companyid inner join gen_PosConfiguration on gen_PosConfiguration.CompanyID=GLCompany.Companyid
            where UserPassword = '" + obj.Password + "' and UserName = '"+ obj.UserName + "'", con);
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
