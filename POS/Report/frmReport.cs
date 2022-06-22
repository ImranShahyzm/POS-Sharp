using CrystalDecisions.CrystalReports.Engine;
using Microsoft.Reporting.WinForms;
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
    public partial class frmReport : Form
    {
        public frmReport()
        {
            InitializeComponent();
        }

        private void frmReport_Load(object sender, EventArgs e)
        {
            //var value = new List<string[]>();
            //string[] para1 = { "@FromDate", "2020-02-20" };
            //string[] para2 = { "@ToDate", "2020-02-26" };
            //value.Add(para1);
            //value.Add(para2);
            //    string reportName = "";
            //    reportName = "CashBook";
            //    PreviewReport("rpt_CashBook", reportName, value);
        }

        public void loadReport(string StoreProcedure, string ReportName, List<string[]> parameters)
        {
            var connectionString = STATICClass.Connection();
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

            //string ss = obj.Title;
            reportViewer1.ProcessingMode = ProcessingMode.Local;
            reportViewer1.LocalReport.ReportPath = Application.StartupPath + "\\Report\\" + ReportName + ".rdlc";
            ReportDataSource datasource = new ReportDataSource("DataSet1", dt);
            reportViewer1.LocalReport.DataSources.Clear();
            reportViewer1.LocalReport.DataSources.Add(datasource);
            this.reportViewer1.Clear();
            this.reportViewer1.RefreshReport();
            this.reportViewer1.RenderingComplete += new RenderingCompleteEventHandler(PrintSales);
        }
        public void loadSaleReport(string StoreProcedure, string ReportName, List<string[]> parameters)
        {
            var connectionString = STATICClass.Connection();
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
            reportViewer1.ProcessingMode = ProcessingMode.Local;
            rpt.Load(Path.Combine(Application.StartupPath, "Report", "SaleThermalPrint.rpt"));

            rpt.Database.Tables[0].SetDataSource(dt);
            rpt.Database.Tables[1].SetDataSource(dt2);
            rpt.SummaryInfo.ReportTitle = "Sales Invoice";
            rpt.SummaryInfo.ReportAuthor = "Admin";
            int? LanguageSelection = 1;
            rpt.SetParameterValue("LanguageSelection", Convert.ToInt32(LanguageSelection));
            var ImageValue = (dt2.Rows[0]["CompanyImage"]).ToString();
            String Serverpath = Convert.ToString(Path.Combine(Application.StartupPath, "Resources", "logo.png"));
            rpt.SetParameterValue("ServerName", Serverpath);

            rpt.PrintToPrinter(1, false, 0, 0);
            rpt.Dispose();


        }

        public void PreviewReport(string StoreProcedure, string ReportName, List<string[]> parameters)
        {
            var connectionString = STATICClass.Connection();
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
            Common.LogInCommon obj = new Common.LogInCommon();
            string ss = obj.Title;

            reportViewer1.ProcessingMode = ProcessingMode.Local;
            reportViewer1.LocalReport.ReportPath = Application.StartupPath + "\\Report\\" + ReportName + ".rdlc";
            ReportDataSource datasource = new ReportDataSource("DataSet1", dt);
            reportViewer1.LocalReport.DataSources.Clear();
            reportViewer1.LocalReport.DataSources.Add(datasource);
            this.reportViewer1.Clear();
            this.reportViewer1.RefreshReport();
            reportViewer1.SetDisplayMode(DisplayMode.PrintLayout);
            reportViewer1.ZoomMode = ZoomMode.Percent;
            reportViewer1.ZoomPercent = 100;
        }
      

        public void PrintSales(object sender, RenderingCompleteEventArgs e)
        {
            try
            {

                reportViewer1.PrintDialog();
                reportViewer1.Clear();
                reportViewer1.LocalReport.ReleaseSandboxAppDomain();
                reportViewer1.Dispose();
                this.Close();
            }
            catch (Exception ex)
            {
            }
        }
        public DataTable SelectCompanyDetail(string where = "")
        {
            var connectionString = STATICClass.Connection();
            SqlConnection con = new SqlConnection(connectionString);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter("select * from [dbo].[GLCompany] " + where, con);
            da.Fill(dt);
            return dt;
        }
    }
}
