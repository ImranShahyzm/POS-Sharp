using Common;
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
            if (CompanyInfo.isPrinter)
            {
                rpt.PrintToPrinter(1, false, 0, 0);
            }
            else
            {
             
                this.ShowDialog();
                rpt.Dispose();
            }

        }
        public void loadSaleFoodMamaReport(string StoreProcedure, string ReportName, List<string[]> parameters)
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
            rpt.Load(Path.Combine(Application.StartupPath, "Report", "SaleThermalPrintFoodMama.rpt"));
            rpt.Database.Tables[0].SetDataSource(dt);
            rpt.Database.Tables[1].SetDataSource(dt2);
            rpt.SummaryInfo.ReportTitle = "Sales Invoice";
            rpt.SummaryInfo.ReportAuthor = "Admin";
            int? LanguageSelection = 1;
            rpt.SetParameterValue("LanguageSelection", Convert.ToInt32(LanguageSelection));
            rpt.SetParameterValue("TagName", "");
            var ImageValue = (dt2.Rows[0]["CompanyImage"]).ToString();
            String Serverpath = Convert.ToString(Path.Combine(Application.StartupPath, "Resources", "logo.jpeg"));
            rpt.SetParameterValue("ServerName", Serverpath);
            rpt.SetParameterValue("Username", CompanyInfo.username);
            crystalReportViewer1.ReportSource = rpt;
            crystalReportViewer1.Refresh();
            if (CompanyInfo.isPrinter)
            {
                rpt.PrintToPrinter(1, false, 0, 0);
            }
            else
            {

                this.ShowDialog();
                rpt.Dispose();
            }

        }

        public void loadKhaakiInvoice(string StoreProcedure, string ReportName, List<string[]> parameters)
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
            rpt.Load(Path.Combine(Application.StartupPath, "Report", "SaleThermalKhaakiPos.rpt"));
            rpt.Database.Tables[0].SetDataSource(dt);
            rpt.Database.Tables[1].SetDataSource(dt2);
            rpt.SummaryInfo.ReportTitle = "Sales Invoice";
            rpt.SummaryInfo.ReportAuthor = "Admin";
            int? LanguageSelection = 1;
            rpt.SetParameterValue("LanguageSelection", Convert.ToInt32(LanguageSelection));
            rpt.SetParameterValue("TagName", "");
            var ImageValue = (dt2.Rows[0]["CompanyImage"]).ToString();
            String Serverpath = Convert.ToString(Path.Combine(Application.StartupPath, "Resources", "logo.jpeg"));
            rpt.SetParameterValue("ServerName", Serverpath);
            rpt.SetParameterValue("Username", CompanyInfo.username);
            crystalReportViewer1.ReportSource = rpt;
            crystalReportViewer1.Refresh();
            if (CompanyInfo.isPrinter)
            {
                rpt.PrintToPrinter(1, false, 0, 0);
            }
            else
            {

                this.ShowDialog();
                rpt.Dispose();
            }

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
            if (CompanyInfo.isPrinter)
            {
                rpt.PrintToPrinter(1, false, 0, 0);
            }
            else
            {

                this.ShowDialog();
                rpt.Dispose();
            }

        }
        public DataTable ItemStockReport(int CompanyID ,string ReportName,DateTime dateTo)
        {
            DataTable dt;

            string Sql = @"
           select  case when isnull(sum(Quantity) ,0) = 0 then 0 else isnull(Sum(Amount),0)/isnull(sum(Quantity) ,0) end ";
            
            Sql += @"as WeightedRate,  isnull(sum(Quantity) ,0) ";
            
            Sql += @"as Quantity , isnull(Sum(Amount),0)  as StockAmount , s.ItemId , InventItems.ItenName, InventItems.ReOrderLevel , InventUOM.UOMName , InventItems.CategoryID,InventCategory.CategoryName ,InventCategory.ItemGroupID,InventItemGroup.ItemGroupName  
             from (
            select a.StockRate * a.Quantity as Amount,a.Quantity ,a.ItemId   from data_ProductInflow a inner join  InventItems b on a.ItemId =b.ItemId
            left join InventCategory c on b.CategoryID = c.CategoryID where 0 = 0 ";

            //if (this.ItemID > 0)
            //{
            //    Sql += " and a.ItemId = " + this.ItemID;
            //}

            //if (this.CategoryID > 0)
            //{
            //    Sql += " and b.CategoryID = " + this.CategoryID;
            //}
            //if (this.ItemGroupID > 0)
            //{
            //    Sql += " and c.ItemGroupID  = " + this.ItemGroupID;
            //}
            //if (this.WHID > 0)
            //{
            //    Sql += " and  a.WHID=" + this.WHID;
            //}
            
            
            //if (this.ItemBrandId > 0)
            //{
            //    Sql += " and  b.ItemBrandId=" + this.ItemBrandId;
            //}
            Sql += " and a.StockDate <= '" + dateTo + "' ";
            Sql += " and a.CompanyID = " + CompanyID;
            Sql += @" union all 
select - a.StockRate * a.Quantity as Amount,-a.Quantity as Quantity ,a.ItemId from data_ProductOutflow a inner join  InventItems b on a.ItemId =
b.ItemId left join InventCategory c on b.CategoryID = c.CategoryID where 0 = 0 ";
            //if (this.ItemID > 0)
            //{
            //    Sql += " and a.ItemId = " + this.ItemID;
            //}
            //if (this.CategoryID > 0)
            //{
            //    Sql += " and b.CategoryID = " + this.CategoryID;
            //}
            //if (this.ItemGroupID > 0)
            //{
            //    Sql += " and c.ItemGroupID  = " + this.ItemGroupID;
            //}
            //if (this.WHID > 0)
            //{
            //    Sql += " and  a.WHID=" + this.WHID;
            //}
            //if (this.TransferToShedId > 0)
            //{
            //    Sql += " and  a.ShedId=" + this.TransferToShedId;
            //}
            //if (this.TaxMode != "OVERALL")
            //{
            //    Sql += " and  a.IsTaxable = " + (this.TaxMode == "TAXABLE" ? 1 : 0);
            //}
            //if (this.ItemBrandId > 0)
            //{
            //    Sql += " and  b.ItemBrandId=" + this.ItemBrandId;
            //}
            Sql += " and a.StockDate <= '" + dateTo + "' ";
            Sql += " and a.CompanyID = " + CompanyID;
            Sql += @" )s   inner join  InventItems  on s.ItemId = InventItems.ItemId
 inner join InventUOM on InventItems.UOMId = InventUOM.UOMId
left join InventCategory on InventCategory.CategoryID=InventItems.CategoryID
 left join InventItemGroup on InventItemGroup.ItemGroupID=InventCategory.CategoryID
group by s.ItemId , InventItems.ItenName ,InventItems.ReOrderLevel, InventUOM.UOMName ,InventItems.CategoryID,InventCategory.ItemGroupID, 
InventCategory.CategoryName, InventItemGroup.ItemGroupName,CartonSize";
            
            dt = new DataTable();
            dt = STATICClass.SelectAllFromQuery(Sql).Tables[0];
            return dt;
        }
        public void StockReport(string reportName,DateTime dateTo)
        {
            ReportDocument rpt = new ReportDocument();
            DataTable dt = ItemStockReport(CompanyInfo.CompanyID,reportName,dateTo);
            rpt.Load(Path.Combine(Application.StartupPath, "Report", "ItemStockReport.rpt"));
            rpt.Database.Tables[0].SetDataSource(dt);
            
            rpt.SummaryInfo.ReportTitle = "Item Stock Report";
            
            rpt.SetParameterValue("CompanyName",CompanyInfo.WareHouseName);
            rpt.SetParameterValue("UserName", CompanyInfo.username);


            String Serverpath = Convert.ToString(Path.Combine(Application.StartupPath, "Resources", "logo.jpeg"));
            //rpt.SetParameterValue("ServerName", Serverpath);
            //rpt.SetParameterValue("Username", CompanyInfo.username);
            crystalReportViewer1.ReportSource = rpt;
            crystalReportViewer1.Refresh();
            this.ShowDialog();
            rpt.Dispose();
        }
        public void CashBook(string StoreProcedure, string ReportName, List<string[]> parameters)
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

            rpt.Load(Path.Combine(Application.StartupPath, "Report", "DayBook.rpt"));
            rpt.Database.Tables[0].SetDataSource(dt);

            rpt.SetParameterValue("CompanyName", dt2.Rows[0]["Title"]);
            rpt.SummaryInfo.ReportTitle = "Cash Book";
            rpt.SummaryInfo.ReportAuthor = "Admin";
           
            
         
            String Serverpath = Convert.ToString(Path.Combine(Application.StartupPath, "Resources", "logo.jpeg"));
            //rpt.SetParameterValue("ServerName", Serverpath);
            //rpt.SetParameterValue("Username", CompanyInfo.username);
            crystalReportViewer1.ReportSource = rpt;
            crystalReportViewer1.Refresh();
            this.ShowDialog();
            rpt.Dispose();


        }
    }
}
