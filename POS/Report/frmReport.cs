using CrystalDecisions.CrystalReports.Engine;
using Microsoft.Reporting.WinForms;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
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
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
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

        public void PreviewReport(string StoreProcedure, string ReportName, List<string[]> parameters)
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
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
    }
}
