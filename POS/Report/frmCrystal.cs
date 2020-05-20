using CrystalDecisions.CrystalReports.Engine;
using POS.Helper;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace POS.Report
{
    public partial class frmCrystal : Form
    {
        public frmCrystal()
        {
            InitializeComponent();
        }
        public DataTable SelectCompanyDetail(string where = "")
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter("select * from [dbo].[GLCompany] " + where, con);
            da.Fill(dt);
            return dt;
        }
        public void loadSaleReport(string StoreProcedure, string ReportName, List<string[]> parameters)
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            ReportDocument rpt = new ReportDocument();
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            SqlCommand cmd = new SqlCommand(StoreProcedure, cnn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter();

            for (int i = 0; i < parameters.Count; i++)
            {
                cmd.Parameters.AddWithValue(parameters[i][0], parameters[i][1]);
            }
            da.SelectCommand = cmd;
            DataTable dt = new DataTable();
            da.Fill(dt);
            cnn.Close();

            DataTable dt2 = SelectCompanyDetail(" where companyid = " + CompanyInfo.CompanyID);
            //string ss = obj.Title;
            //reportViewer1.ProcessingMode = ProcessingMode.Local;
            rpt.Load(Path.Combine(Application.StartupPath, "Report", "SaleThermalPrint.rpt"));
            rpt.Database.Tables[0].SetDataSource(dt);
            rpt.Database.Tables[1].SetDataSource(dt2);
            rpt.SummaryInfo.ReportTitle = "Sales Invoice";
            rpt.SummaryInfo.ReportAuthor = "Admin";
            int? LanguageSelection = 1;
            rpt.SetParameterValue("LanguageSelection", Convert.ToInt32(LanguageSelection));
            rpt.SetParameterValue("TagName","A Lip Licking Flavour");
            var ImageValue = (dt2.Rows[0]["CompanyImage"]).ToString();
            String Serverpath = Convert.ToString(Path.Combine(Application.StartupPath, "Resources", "logo.jpeg"));
            rpt.SetParameterValue("ServerName", Serverpath);
            rpt.SetParameterValue("Username", CompanyInfo.username);
            crystalReportViewer1.ReportSource = rpt;
            crystalReportViewer1.Refresh();
            //rpt.PrintToPrinter(1, false, 0, 0);
            //rpt.Dispose();
            this.ShowDialog();

        }
        public void loadSaleKitchenReport(string StoreProcedure, string ReportName, List<string[]> parameters)
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            ReportDocument rpt = new ReportDocument();
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            SqlCommand cmd = new SqlCommand(StoreProcedure, cnn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter();

            for (int i = 0; i < parameters.Count; i++)
            {
                cmd.Parameters.AddWithValue(parameters[i][0], parameters[i][1]);
            }
            da.SelectCommand = cmd;
            DataTable dt = new DataTable();
            da.Fill(dt);
            cnn.Close();

            DataTable dt2 = SelectCompanyDetail(" where companyid = " + CompanyInfo.CompanyID);
            //string ss = obj.Title;
            //reportViewer1.ProcessingMode = ProcessingMode.Local;
            rpt.Load(Path.Combine(Application.StartupPath, "Report", "SaleThermalPrintKitchen.rpt"));
            rpt.Database.Tables[0].SetDataSource(dt);
            rpt.Database.Tables[1].SetDataSource(dt2);
            rpt.SummaryInfo.ReportTitle = "Kitchen Print";
            rpt.SummaryInfo.ReportAuthor = "Admin";
            int? LanguageSelection = 1;
            rpt.SetParameterValue("LanguageSelection", Convert.ToInt32(LanguageSelection));
            rpt.SetParameterValue("TagName", "A Lip Licking Flavour");
            var ImageValue = (dt2.Rows[0]["CompanyImage"]).ToString();
            String Serverpath = Convert.ToString(Path.Combine(Application.StartupPath, "Resources", "logo.jpeg"));
            rpt.SetParameterValue("ServerName", Serverpath);
            rpt.SetParameterValue("Username", CompanyInfo.username);
            crystalReportViewer1.ReportSource = rpt;
            crystalReportViewer1.Refresh();
            //rpt.PrintToPrinter(1, false, 0, 0);
            //rpt.Dispose();
            this.ShowDialog();

        }

    }
}
