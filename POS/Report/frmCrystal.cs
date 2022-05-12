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
        public DataTable PendingBillsReprot(int CompanyID, string ReportName, DateTime DateFrom, DateTime dateTo, int CategoryID = 0, string CustomerPhone = "")
        {
            DataTable dt;
            string Sql = @"select  * from (select data_salePosInfo.SalePOSNo,Format(data_salePosInfo.SalePosDate,'dd-MMM-yyyy') as SalePosDate,data_salePosInfo.CustomerName,data_salePosInfo.CustomerPhone,  (data_salePosInfo.GrossAmount-data_salePosInfo.DiscountTotal+OtherCharges) as TotalBillAmount,
isnull((select sum(b.ReceoverdAmount)  from data_posBillRecoviers b where b.SalePosID =
 data_salePosInfo.SalePosID
),0) as RecoveryAmount,data_salePosInfo.WHID,data_salePosInfo.SalePosID,isnull((select sum(b.RiderAmountRecovery)  from data_posBillRecoviers b where b.SalePosID =
 data_salePosInfo.SalePosID
),0) as RiderAmountRecovery,RiderAmount
from data_salePosInfo where data_SalePosInfo.InvoiceType > 1 and 0=0";

            Sql = Sql + " and SalePosDate between '" + DateFrom.ToString("dd-MMM-yyyy") + "' and '" + dateTo.ToString("dd-MMM-yyyy") + "' ";
            Sql = Sql + "   and data_SalePosInfo.Companyid=" + CompanyInfo.CompanyID + " and data_SalePosInfo.WHID=" + CompanyInfo.WareHouseID;
            if (!string.IsNullOrEmpty(CustomerPhone))
            {
                Sql = Sql + "   and data_SalePosInfo.CustomerPhone='" + CustomerPhone + "'";
            }

            Sql = Sql + " ) a ";
            if (CategoryID == 2)
            {
                Sql = Sql + " where TotalBillAmount - RecoveryAmount > 0";
            }

            dt = new DataTable();
            dt = STATICClass.SelectAllFromQuery(Sql).Tables[0];
            return dt;
        }
        public void PendingBillsReport(string reportName, DateTime DateFrom, DateTime dateTo, int CategoryID = 0, string CustomerPhone = "")
        {
            ReportDocument rpt = new ReportDocument();
            DataTable dt = PendingBillsReprot(CompanyInfo.CompanyID, reportName, DateFrom, dateTo, CategoryID, CustomerPhone);
            rpt.Load(Path.Combine(Application.StartupPath, "Report", "PendingBillsAmount.rpt"));
            rpt.Database.Tables[0].SetDataSource(dt);
            if (DateFrom.Date == dateTo.Date)
            {

                rpt.SummaryInfo.ReportTitle = "Bills Activity Report";
            }
            else
            {
                rpt.SummaryInfo.ReportTitle = "Bills Activity Report";
            }
            rpt.SetParameterValue("CompanyName", CompanyInfo.WareHouseName);
            rpt.SetParameterValue("UserName", CompanyInfo.username);


            rpt.SetParameterValue("ReportFiltration", "From " + DateFrom.ToString("dd-MM-yyyy") + " To " + dateTo.ToString("dd-MM-yyyy"));
            rpt.SetParameterValue("SuppressTag", false);
            rpt.SetParameterValue("NetSale", TillNowSaleCalculation());
            rpt.SetParameterValue("MasterDiscount", SaleMasterDiscount(DateFrom, dateTo));

            String Serverpath = Convert.ToString(Path.Combine(Application.StartupPath, "Resources", "logo.jpeg"));
            //rpt.SetParameterValue("ServerName", Serverpath);
            //rpt.SetParameterValue("Username", CompanyInfo.username);
            crystalReportViewer1.ReportSource = rpt;
            crystalReportViewer1.Refresh();
            this.ShowDialog();
            rpt.Dispose();
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
        public void loadSaleFoodMamaReport(string StoreProcedure, string ReportName, List<string[]> parameters, bool isReturn = false, bool isReprint = false, bool isA4Style = false)
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
            if (CompanyInfo.POSStyle == "OmanMobileStyle")
            {
                if (isA4Style)
                {
                    rpt.Load(Path.Combine(Application.StartupPath, "Report", "SalePrintOMAN.rpt"));
                }
                else
                {
                    rpt.Load(Path.Combine(Application.StartupPath, "Report", "SaleThermalPrintOMAN.rpt"));
                }
            }
            else
                rpt.Load(Path.Combine(Application.StartupPath, "Report", "SaleThermalPrintFoodMama.rpt"));
            rpt.Database.Tables[0].SetDataSource(dt);
            rpt.Database.Tables[1].SetDataSource(dt2);
            if (isReturn)
            {
                rpt.SummaryInfo.ReportTitle = "Sales Return Invoice";
            }
            else if (isReprint)
            {
                rpt.SummaryInfo.ReportTitle = "Reprinted Bill Number";
            }
            else
            {
                rpt.SummaryInfo.ReportTitle = " Bill Number";
            }
            rpt.SummaryInfo.ReportAuthor = CompanyInfo.username;
            int? LanguageSelection = 1;
            rpt.SetParameterValue("LanguageSelection", Convert.ToInt32(LanguageSelection));
            rpt.SetParameterValue("TagName", "");
            var ImageValue = (dt2.Rows[0]["CompanyImage"]).ToString();
            String Serverpath = Convert.ToString(Path.Combine(Application.StartupPath, "Resources", "logo.jpeg"));
            rpt.SetParameterValue("ServerName", Serverpath);
            rpt.SetParameterValue("Username", CompanyInfo.username);
            crystalReportViewer1.ReportSource = rpt;
            crystalReportViewer1.Refresh();
            if (CompanyInfo.isPrinter && isA4Style==false)
            {
                rpt.PrintToPrinter(1, false, 0, 0);
                rpt.Dispose();
            }
            else
            {

                this.ShowDialog();
                rpt.Dispose();
            }
        }



        public void loadSaleFoodMamaReportLinked(string StoreProcedure, string ReportName, List<string[]> parameters)
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
            rpt.Load(Path.Combine(Application.StartupPath, "Report", "SaleThermalPrintFoodMamaClub.rpt"));
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

        public void PrintFbrInvoice(string StoreProcedure, string ReportName, List<string[]> parameters, bool isReturn = false, bool isReprint = false)
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
            rpt.Load(Path.Combine(Application.StartupPath, "Report", "SaleThermalFbrPrint.rpt"));
            rpt.Database.Tables[0].SetDataSource(dt);
            rpt.Database.Tables[1].SetDataSource(dt2);
            if (isReturn)
            {
                rpt.SummaryInfo.ReportTitle = "Sales Return Invoice";
            }
            else if (isReprint)
            {
                rpt.SummaryInfo.ReportTitle = "Reprinted Bill Number";
            }
            else
            {
                rpt.SummaryInfo.ReportTitle = " Bill Number";
            }
            rpt.SummaryInfo.ReportAuthor = CompanyInfo.username;
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
                rpt.Dispose();
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
                rpt.PrintToPrinter(CompanyInfo.NoOfInvoicePrint, false, 0, 0);
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
        public DataTable ItemStockReport(int CompanyID, string ReportName, DateTime dateTo, int CategoryID = 0, DateTime? RegisterFrom = null, DateTime? RegitserTo = null, int MenuID = 0)
        {
            DataTable dt;

            string Sql = @"
           select InventItems.ItemSalesPrice as RetailPrice,Format(isnull(InventItems.RegisterInevntoryDate,'01-01-2017') , 'dd-MMM-yyyy') as Age, varnt.VariantDescription,ab.ColorTitle,InventItems.ItemNumber, case when isnull(sum(Quantity) ,0) = 0 then 0 else isnull(Sum(Amount),0)/isnull(sum(Quantity) ,0) end ";

            Sql += @"as WeightedRate,  isnull(sum(Quantity) ,0) ";

            Sql += @"as Quantity , isnull(Sum(Amount),0)  as StockAmount , s.ItemId , InventItems.ItenName, InventItems.ReOrderLevel , InventUOM.UOMName , InventItems.CategoryID,InventCategory.CategoryName ,InventCategory.ItemGroupID,InventItemGroup.ItemGroupName  
             from (
            select a.StockRate * a.Quantity as Amount,a.Quantity ,a.ItemId   from data_ProductInflow a inner join  InventItems b on a.ItemId =b.ItemId
            left join InventCategory c on b.CategoryID = c.CategoryID where 0 = 0 ";

            //if (this.ItemID > 0)
            //{
            //    Sql += " and a.ItemId = " + this.ItemID;
            //}

            if (CategoryID > 0)
            {
                Sql += " and b.CategoryID = " + CategoryID;
            }
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
            if (CategoryID > 0)
            {
                Sql += " and b.CategoryID = " + CategoryID;
            }
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
left join adgen_ColorInfo ab on ab.ColorID=InventItems.ColorID
 left join gen_ItemVariantInfo varnt on varnt.ItemVariantInfoId=InventItems.ItemVarientId where 0=0";
            if (RegisterFrom != null && RegitserTo != null)
            {
                Sql += " and Isnull(RegisterInevntoryDate,'01-01-2017') between '" + RegisterFrom + "' and '" + RegitserTo + "'";
            }
            if (!CompanyInfo.isKhaakiSoft && MenuID > 0)
            {
                Sql += " and  InventCategory.ItemGroupID=" + MenuID + " ";
            }
            Sql += @" group by s.ItemId , InventItems.ItenName ,InventItems.ReOrderLevel, InventUOM.UOMName ,InventItems.CategoryID,InventCategory.ItemGroupID, 
InventCategory.CategoryName, InventItemGroup.ItemGroupName,RegisterInevntoryDate,CartonSize,Itemnumber,VariantDescription,ColorTitle,ItemSalesPrice";

            dt = new DataTable();
            dt = STATICClass.SelectAllFromQuery(Sql).Tables[0];
            return dt;
        }

        public DataTable DailySaleReturn(int CompanyID, string ReportName, DateTime DateFrom, DateTime dateTo, int CategoryID = 0, int MenuID = 0)
        {
            DataTable dt;

            string Sql = @"select data_SalePosReturnInfo.WHID, VariantDescription, InventCategory.CategoryID,CategoryName,InventItems.ManualNumber as ItemNumber,adgen_ColorInfo.ColorTitle,data_SalePosReturnInfo.SalePosID,data_SalePosReturnInfo.SalePosNo ,format(data_SalePosReturnInfo.SalePosReturnDate,'dd-MMM-yyyy') as SalePosReturnDate,data_SalePosReturnInfo.NetAmount as SaleInfo_NetAmount,
            data_SalePosReturnInfo.DiscountPercentage as SaleInfo_DPer,data_SalePosReturnInfo.DiscountAmount as SaleInfo_DAmount, data_SalePosReturnInfo.DiscountTotal as SaleInfo_DTotal,data_SalePosReturndetail.ItemId,
 data_SalePosReturndetail.Quantity,data_SalePosReturndetail.ItemRate,data_SalePosReturndetail.DiscountPercentage,data_SalePosReturndetail.DiscountAmount,
            data_SalePosReturndetail.TaxAmount,
            InventItems.ItenName
            from data_SalePosReturnInfo 
            inner join data_SalePosReturndetail on data_SalePosReturnInfo.SalePosReturnID=data_SalePosReturndetail.SalePosReturnID 
            left join InventItems on data_SalePosReturndetail.ItemId = InventItems.ItemId 
            left join InventCategory on InventCategory.CategoryID=InventItems.CategoryID
            left join InventItemGroup on InventCategory.ItemGroupID=InventItemGroup.ItemGroupID
            left join InventWareHouse on data_SalePosReturnInfo.WHID=InventWareHouse.WHID
            left join adgen_ColorInfo on adgen_ColorInfo.ColorID=InventItems.ColorID
			left join gen_ItemVariantInfo on InventItems.ItemVarientId=gen_ItemVariantInfo.ItemVariantInfoId
            where 0 = 0 ";
            Sql = Sql + " and data_SalePosReturnInfo.SalePosReturnDate  between '" + Convert.ToDateTime(DateFrom).ToString("yyyy-MM-dd") + "' and '" + dateTo.ToString("yyyy-MM-dd") + "'  and data_SalePosReturnInfo.Companyid=" + CompanyInfo.CompanyID + " and data_SalePosReturnInfo.WHID=" + CompanyInfo.WareHouseID;
            if (CategoryID > 0)
            {
                Sql = Sql + " and InventItems.CateGoryID=" + CategoryID + "";
            }
            if (MenuID > 0)
            {
                Sql = Sql + " and InventCategory.ItemGroupID=" + MenuID + "";
            }
            Sql = Sql + " order by data_SalePosReturnInfo.SalePosReturnDate,SalePosNo";
            dt = new DataTable();
            dt = STATICClass.SelectAllFromQuery(Sql).Tables[0];
            return dt;
        }

        public DataTable DailySale(int CompanyID, string ReportName, DateTime DateFrom, DateTime dateTo, int CategoryID = 0, int MenuID = 0)
        {
            DataTable dt;

            string Sql = @"
		    select data_SalePosInfo.WHID, VariantDescription, InventCategory.CategoryID,CategoryName,InventItems.ManualNumber as ItemNumber,adgen_ColorInfo.ColorTitle,data_SalePosInfo.SalePosID,data_SalePosInfo.SalePosNo ,format(data_SalePosInfo.SalePosDate,'dd-MMM-yyyy') as SalePosDate,data_SalePosInfo.NetAmount as SaleInfo_NetAmount,
            data_SalePosInfo.DiscountPercentage as SaleInfo_DPer,data_SalePosInfo.DiscountAmount as SaleInfo_DAmount, data_SalePosInfo.DiscountTotal as SaleInfo_DTotal,data_SalePosDetail.ItemId,
 data_SalePosDetail.Quantity,data_SalePosDetail.ItemRate,data_SalePosDetail.DiscountPercentage,data_SalePosDetail.DiscountAmount,
            data_SalePosDetail.TaxAmount,
            InventItems.ItenName
            from data_SalePosInfo 
            inner join data_SalePosDetail on data_SalePosInfo.SalePosID=data_SalePosDetail.SalePosID 
            left join InventItems on data_SalePosDetail.ItemId = InventItems.ItemId 
            left join InventCategory on InventCategory.CategoryID=InventItems.CategoryID
            left join InventItemGroup on InventCategory.ItemGroupID=InventItemGroup.ItemGroupID
            left join InventWareHouse on data_SalePosInfo.WHID=InventWareHouse.WHID
            left join adgen_ColorInfo on adgen_ColorInfo.ColorID=InventItems.ColorID
			left join gen_ItemVariantInfo on InventItems.ItemVarientId=gen_ItemVariantInfo.ItemVariantInfoId
            where 0 = 0";
            Sql = Sql + " and data_SalePosInfo.SalePosDate between '" + DateFrom + "' and '" + dateTo + "'  and data_SalePosInfo.Companyid=" + CompanyInfo.CompanyID + " and data_SalePosInfo.WHID=" + CompanyInfo.WareHouseID;
            if (CategoryID > 0)
            {
                Sql = Sql + " and InventItems.CateGoryID=" + CategoryID + "";
            }
            if (MenuID > 0)
            {
                Sql = Sql + " and InventCategory.ItemGroupID=" + MenuID + "";
            }
            Sql = Sql + " order by data_SalePosInfo.SalePosDate,SalePosNo";
            dt = new DataTable();
            dt = STATICClass.SelectAllFromQuery(Sql).Tables[0];
            return dt;
        }
        public DataTable DailySaleKhaaki(int CompanyID, string ReportName, DateTime DateFrom, DateTime dateTo, int CategoryID = 0)
        {
            DataTable dt;

            string Sql = @"
            select  data_SalePosInfo.CompanyID , Format(SalePosDate , 'dd-MMM-yyyy') as SalePosDateFormat,VariantDescription, InventCategory.CategoryID,CategoryName,InventItems.ItemNumber,adgen_ColorInfo.ColorTitle,Sum(data_SalePosInfo.NetAmount) as SaleInfo_NetAmount,
            0 as SaleInfo_DPer,Sum(data_SalePosInfo.DiscountAmount) as SaleInfo_DAmount,data_SalePosDetail.ItemId,
            sum(data_SalePosDetail.Quantity) as Quantity,sum(Quantity*data_SalePosDetail.ItemRate) as DetailNet,0 as DiscountPercentage,sum(data_SalePosDetail.DiscountAmount) as DiscountAmount,
            Sum(data_SalePosDetail.TaxAmount) as TaxAmount,
            InventItems.ItenName
            from data_SalePosInfo 
            inner join data_SalePosDetail on data_SalePosInfo.SalePosID=data_SalePosDetail.SalePosID 
            left join InventItems on data_SalePosDetail.ItemId = InventItems.ItemId 
            left join InventCategory on InventCategory.CategoryID=InventItems.CategoryID
            left join InventItemGroup on InventCategory.ItemGroupID=InventItemGroup.ItemGroupID
            left join InventWareHouse on data_SalePosInfo.WHID=InventWareHouse.WHID
            left join adgen_ColorInfo on adgen_ColorInfo.ColorID=InventItems.ColorID
			left join gen_ItemVariantInfo on InventItems.ItemVarientId=gen_ItemVariantInfo.ItemVariantInfoId
            where 0 = 0 and data_SalePosInfo.DirectReturn=0 ";
            Sql = Sql + " and data_SalePosInfo.SalePosDate between '" + DateFrom.ToString("dd-MMM-yyyy") + "' and '" + dateTo.ToString("dd-MMM-yyyy") + "'  and data_SalePosInfo.Companyid=" + CompanyInfo.CompanyID + " and data_SalePosInfo.WHID=" + CompanyInfo.WareHouseID;
            if (CategoryID > 0)
            {
                Sql = Sql + " and InventItems.CateGoryID=" + CategoryID + "";
            }
            Sql = Sql + " Group by data_SalePosInfo.CompanyID ,  VariantDescription, InventCategory.CategoryID,CategoryName,InventItems.ItemNumber,adgen_ColorInfo.ColorTitle,data_SalePosDetail.ItemId,  InventItems.ItenName,salePosdate";
            Sql = Sql + " order by data_SalePosInfo.SalePosDate";
            dt = new DataTable();
            dt = STATICClass.SelectAllFromQuery(Sql).Tables[0];
            return dt;
        }
        public DataTable DailySaleKhaakiPromo(int CompanyID, string ReportName, DateTime DateFrom, DateTime dateTo, int CategoryID = 0)
        {
            DataTable dt;

            string Sql = @"
SELECT
   data_SalePosInfo.CompanyID,
   data_SalePosDetail.DiscountPercentage,
   SUM(data_SalePosDetail.Quantity * data_SalePosDetail.ItemRate) AS GrossAmount,
   SUM(ISNULL(data_SalePosDetail.DiscountAmount, 0)) AS DiscountAmount,
   SUM(ISNULL(data_SalePosDetail.TotalAmount, 0)) AS TotalAmount
    
FROM
   data_SalePosInfo 
   INNER JOIN
      data_SalePosDetail 
      ON data_SalePosInfo.SalePosID = data_SalePosDetail.SalePosID 
   LEFT JOIN
      InventItems 
      ON data_SalePosDetail.ItemId = InventItems.ItemId 
   LEFT JOIN
      InventCategory 
      ON InventCategory.CategoryID = InventItems.CategoryID 
   LEFT JOIN
      InventItemGroup 
      ON InventCategory.ItemGroupID = InventItemGroup.ItemGroupID 
   LEFT JOIN
      InventWareHouse 
      ON data_SalePosInfo.WHID = InventWareHouse.WHID 
   LEFT JOIN
      adgen_ColorInfo 
      ON adgen_ColorInfo.ColorID = InventItems.ColorID 
   LEFT JOIN
      gen_ItemVariantInfo 
      ON InventItems.ItemVarientId = gen_ItemVariantInfo.ItemVariantInfoId 
WHERE
   0 = 0 
   AND data_SalePosInfo.DirectReturn = 0 
   AND data_SalePosDetail.DiscountPercentage > 0 ";
            Sql = Sql + " and data_SalePosInfo.SalePosDate between '" + DateFrom.ToString("dd-MMM-yyyy") + "' and '" + dateTo.ToString("dd-MMM-yyyy") + "'  and data_SalePosInfo.Companyid=" + CompanyInfo.CompanyID + " and data_SalePosInfo.WHID=" + CompanyInfo.WareHouseID;
            if (CategoryID > 0)
            {
                Sql = Sql + " and InventItems.CateGoryID=" + CategoryID + "";
            }
            Sql = Sql + @" GROUP BY
   data_SalePosInfo.CompanyID,
   data_SalePosDetail.DiscountPercentage ";

            dt = new DataTable();
            dt = STATICClass.SelectAllFromQuery(Sql).Tables[0];
            return dt;
        }
        public DataTable MakeOrdersList(int CompanyID, string ReportName, DateTime DateFrom, DateTime dateTo, int CategoryID = 0)
        {
            DataTable dt;

            string Sql = @"
            Select SalePOSNo as InvoiceNo,Posdata_MaketoOrderInfo.RNo as OrderNo,Format(RegisterDate , 'dd-MMM-yyyy') as OrderDate,CustomerPhone,CustomerName, Format(DeliveryDate,'dd-MMM-yyyy') as DeliveryDateFormat,Sum(Posdata_MaketoOrderInfo.GrossAmount) as SaleInfo_NetAmount,
            0 as SaleInfo_DPer,Sum(Posdata_MaketoOrderInfo.DiscountTotal) as SaleInfo_DAmount,
            sum(data_SalePosDetail.Quantity) as Quantity,sum(data_SalePosDetail.DiscountAmount) as DiscountAmount,
            Sum(data_SalePosDetail.TaxAmount) as TaxAmount
            from Posdata_MaketoOrderInfo 
            inner join data_SalePosDetail on Posdata_MaketoOrderInfo.SalePosID=data_SalePosDetail.SalePosID 
			inner join data_SalePosInfo on data_SalePosInfo.SalePosID=Posdata_MaketoOrderInfo.SalePosID
            left join InventItems on data_SalePosDetail.ItemId = InventItems.ItemId 
            left join InventCategory on InventCategory.CategoryID=InventItems.CategoryID
            left join InventItemGroup on InventCategory.ItemGroupID=InventItemGroup.ItemGroupID
            left join InventWareHouse on Posdata_MaketoOrderInfo.WHID=InventWareHouse.WHID
            left join adgen_ColorInfo on adgen_ColorInfo.ColorID=InventItems.ColorID
			left join gen_ItemVariantInfo on InventItems.ItemVarientId=gen_ItemVariantInfo.ItemVariantInfoId
            where 0 = 0 and data_SalePosInfo.DirectReturn=0 ";
            Sql = Sql + " and Posdata_MaketoOrderInfo.RegisterDate between '" + DateFrom.ToString("dd-MMM-yyyy") + "' and '" + dateTo.ToString("dd-MMM-yyyy") + "'  and Posdata_MaketoOrderInfo.Companyid=" + CompanyInfo.CompanyID + " and Posdata_MaketoOrderInfo.WHID=" + CompanyInfo.WareHouseID;
            if (CategoryID > 0)
            {
                Sql = Sql + " and InventItems.CateGoryID=" + CategoryID + "";
            }
            Sql = Sql + " Group by SalePOSNo,RNo,RegisterDate,DeliveryDate,CustomerPhone,CustomerName";
            Sql = Sql + " order by Posdata_MaketoOrderInfo.RegisterDate";
            dt = new DataTable();
            dt = STATICClass.SelectAllFromQuery(Sql).Tables[0];
            return dt;
        }
        public DataTable PrintReceiptList(int CompanyID, string ReportName, int CategoryID = 0)
        {
            DataTable dt;

            string Sql = @" SELECT        inv.ItemNumber,Inv.ItenName,Inv.ItemSalesPrice,data_StockArrivalDetail.Quantity,data_StockArrivalInfo.ArrivalID,TransferNo,  format(ArrivalDate,'dd-MMM-yyyy') as ArrivalDate, ArrivalNo,data_StockArrivalInfo.Remarks, RefID,cast((Select sum(quantity) from data_StockArrivalDetail where data_StockArrivalDetail.ArrivalID=data_StockArrivalInfo.ArrivalID) as int) as TotalQuantity,Cast((Select sum(quantity*StockRate) from data_StockArrivalDetail where data_StockArrivalDetail.ArrivalID=data_StockArrivalInfo.ArrivalID) as int) as TotalAmount  from data_StockArrivalInfo left join data_RawStockTransfer on data_RawStockTransfer.TransferIDRef=refID
 left join data_StockArrivalDetail on data_StockArrivalDetail.ArrivalID=data_StockArrivalInfo.ArrivalID
 left join InventItems inv on inv.ItemId=data_StockArrivalDetail.ItemId where 0=0 ";

            if (CategoryID > 0)
            {
                Sql = Sql + " and data_StockArrivalInfo.ArrivalID=" + CategoryID;
            }

            dt = new DataTable();
            dt = STATICClass.SelectAllFromQuery(Sql).Tables[0];
            return dt;
        }
        public DataTable PrintStockReturnList(int CompanyID, string ReportName, int CategoryID = 0)
        {
            DataTable dt;

            string Sql = @" SELECT        inv.ItemNumber,Inv.ItenName,Inv.ItemSalesPrice,data_StockIssuancetoPosKitchenDetail.Quantity,data_StockIssuancetoPosKitchen.IssuanceID,TransferNo,  format(IssuanceDate,'dd-MMM-yyyy') as Issuancedate, IssuanceNo,data_StockIssuancetoPosKitchen.Remarks, RefID,cast((Select sum(quantity) from data_StockIssuancetoPosKitchenDetail where data_StockIssuancetoPosKitchenDetail.IssuanceID=data_StockIssuancetoPosKitchen.IssuanceID) as int) as TotalQuantity,Cast((Select sum(quantity*StockRate) from data_StockIssuancetoPosKitchenDetail where data_StockIssuancetoPosKitchenDetail.IssuanceID=data_StockIssuancetoPosKitchen.IssuanceID) as int) as TotalAmount  from data_StockIssuancetoPosKitchen left join data_RawStockTransfer on data_RawStockTransfer.TransferIDRef=refID
 left join data_StockIssuancetoPosKitchenDetail on data_StockIssuancetoPosKitchenDetail.IssuanceID=data_StockIssuancetoPosKitchen.IssuanceID
 left join InventItems inv on inv.ItemId=data_StockIssuancetoPosKitchenDetail.ItemId where 0=0 ";

            if (CategoryID > 0)
            {
                Sql = Sql + " and data_StockIssuancetoPosKitchen.IssuanceID=" + CategoryID;
            }

            dt = new DataTable();
            dt = STATICClass.SelectAllFromQuery(Sql).Tables[0];
            return dt;
        }
        public DataTable SaleActivity(int CompanyID, string ReportName, DateTime DateFrom, DateTime dateTo, int CategoryID = 0)
        {
            DataTable dt;
            string Sql = @"
            select Format(SalePosDate , 'dd-MMM-yyyy') as SalePosDateFormat,data_SalePosInfo.SalePOSNo,(data_SalePosInfo.GrossAmount-isnull(data_SalePosInfo.ExchangeAmount,0)) as SaleInfo_NetAmount,
            0 as SaleInfo_DPer,(data_SalePosInfo.DiscountAmount) as SaleInfo_DAmount,ISNULL(data_SalePosInfo.CustomerName,'Walking Customer') as Clientname,ISNULL(data_SalePosInfo.CustomerPhone,'') as ClientPhone,
            sum(data_SalePosDetail.Quantity) as Quantity,0 as DiscountPercentage,(data_SalePosInfo.DiscountTotal) as TotalDiscount,
            Sum(data_SalePosDetail.TaxAmount) as TaxAmount 
            from data_SalePosInfo 
            inner join data_SalePosDetail on data_SalePosInfo.SalePosID=data_SalePosDetail.SalePosID 
            left join InventItems on data_SalePosDetail.ItemId = InventItems.ItemId 
            left join InventCategory on InventCategory.CategoryID=InventItems.CategoryID
            left join InventItemGroup on InventCategory.ItemGroupID=InventItemGroup.ItemGroupID
            left join InventWareHouse on data_SalePosInfo.WHID=InventWareHouse.WHID
            left join adgen_ColorInfo on adgen_ColorInfo.ColorID=InventItems.ColorID
			left join gen_ItemVariantInfo on InventItems.ItemVarientId=gen_ItemVariantInfo.ItemVariantInfoId
            where 0 = 0 and data_SalePosInfo.DirectReturn=0 ";
            Sql = Sql + " and data_SalePosInfo.SalePosDate between '" + DateFrom.ToString("dd-MMM-yyyy") + "' and '" + dateTo.ToString("dd-MMM-yyyy") + "'  and data_SalePosInfo.Companyid=" + CompanyInfo.CompanyID + " and data_SalePosInfo.WHID=" + CompanyInfo.WareHouseID;
            if (CategoryID > 0)
            {
                Sql = Sql + " and InventItems.CateGoryID=" + CategoryID + "";
            }
            Sql = Sql + " Group by  DiscountTotal,ExchangeAmount,data_SalePosInfo.DiscountAmount,GrossAmount,salePosdate,SalePOSNo,data_SalePosInfo.CustomerName,data_SalePosInfo.CustomerPhone ";
            Sql = Sql + " order by data_SalePosInfo.SalePosDate,SalePOSNo";
            dt = new DataTable();
            dt = STATICClass.SelectAllFromQuery(Sql).Tables[0];
            return dt;
        }
        public DataTable SaleActivityPromo(int CompanyID, string ReportName, DateTime DateFrom, DateTime dateTo, int CategoryID = 0)
        {
            DataTable dt = new DataTable();
            string SQL = $@"
SELECT * FROM 
(
SELECT
   data_SalePosDetail.DiscountPercentage,
   SUM(data_SalePosDetail.Quantity * data_SalePosDetail.ItemRate) as GrossAmount,
   SUM(ISNULL(data_SalePosDetail.DiscountAmount, 0)) AS DiscountAmount,
   SUM(ISNULL(data_SalePosDetail.TotalAmount, 0)) AS TotalAmount

FROM
   data_SalePosInfo 
   INNER JOIN
      data_SalePosDetail 
      ON data_SalePosInfo.SalePosID = data_SalePosDetail.SalePosID 
   LEFT JOIN
      InventItems 
      ON data_SalePosDetail.ItemId = InventItems.ItemId 
   LEFT JOIN
      InventCategory 
      ON InventCategory.CategoryID = InventItems.CategoryID 
   LEFT JOIN
      InventItemGroup 
      ON InventCategory.ItemGroupID = InventItemGroup.ItemGroupID 
   LEFT JOIN
      InventWareHouse 
      ON data_SalePosInfo.WHID = InventWareHouse.WHID 
   LEFT JOIN
      adgen_ColorInfo 
      ON adgen_ColorInfo.ColorID = InventItems.ColorID 
   LEFT JOIN
      gen_ItemVariantInfo 
      ON InventItems.ItemVarientId = gen_ItemVariantInfo.ItemVariantInfoId 
WHERE
   0 = 0 
   AND data_SalePosInfo.DirectReturn = 0
   AND data_SalePosDetail.DiscountPercentage > 0
   AND data_SalePosInfo.SalePosDate between '{DateFrom.ToString("dd-MMM-yyyy")}' and '{dateTo.ToString("dd-MMM-yyyy")}'  
   AND data_SalePosInfo.Companyid={CompanyInfo.CompanyID} 
   AND data_SalePosInfo.WHID={CompanyInfo.WareHouseID}
   ";
            if (CategoryID > 0)
            {
                SQL += " and InventItems.CateGoryID=" + CategoryID + "";
            }

            SQL += @" GROUP BY
    data_SalePosDetail.DiscountPercentage
) PromoDiscount
";
            dt = STATICClass.SelectAllFromQuery(SQL).Tables[0];
            return dt;
        }
        public decimal TillNowSaleCalculation()
        {
            string query = "Select Sum(NetAmount) as NetAmount from data_salePosinfo where data_SalePosInfo.DirectReturn=0 and WHID=" + CompanyInfo.WareHouseID + "";
            DataTable dt = new DataTable();
            dt = STATICClass.SelectAllFromQuery(query).Tables[0];
            if (dt.Rows.Count > 0)
            {
                return Convert.ToDecimal(dt.Rows[0]["NetAmount"]);
            }
            else
                return 0;

        }
        public decimal SaleMasterDiscount(DateTime DateFrom, DateTime dateTo)
        {
            string query = "Select ISNULL(Sum(DiscountAmount),0) as MasterDiscount from data_SalePosInfo where  data_SalePosInfo.DirectReturn=0 and SalePosDate between '" + DateFrom.ToString("dd-MMM-yyyy") + "' and '" + dateTo.ToString("dd-MMM-yyyy") + "' and WHID=" + CompanyInfo.WareHouseID + "";
            DataTable dt = new DataTable();
            dt = STATICClass.SelectAllFromQuery(query).Tables[0];

            return Convert.ToDecimal(dt.Rows[0]["MasterDiscount"]);

        }
        public DataTable GetCashCardPayments(DateTime DateFrom, DateTime dateTo)
        {
            string query = "Select WHID,Sum(ISNULL(CardPayment, 0)) as CardPayment,(SUm(ISNULL(CashPayment,0)+ISNULL(CardPayment,0)-NetAmount)) as ExchangeAmount,Sum(CashPayment) as CashPayment from data_SalePosInfo where data_SalePosInfo.DirectReturn=0 and SalePosDate between '" + DateFrom.ToString("dd-MMM-yyyy") + "' and '" + dateTo.ToString("dd-MMM-yyyy") + "' and WHID=" + CompanyInfo.WareHouseID + " group by WHID";
            DataTable dt = new DataTable();
            dt = STATICClass.SelectAllFromQuery(query).Tables[0];
            return dt;

        }
        public DataTable GetTotalSaleReturns(DateTime DateFrom, DateTime dateTo)
        {
            string query = @"Select WHID, sum(p.NetAmount) as GrossAmount, Sum(P.DtTaxAmount) as TaxAmount,sum(DiscountTotal) as DiscountTotal,sum(p.Quantity) as ReturnQuantity from data_SalePosReturnInfo 
inner join(
 Select SalePosReturnID, sum(Quantity* ItemRate) as NetAmount,sum(Quantity) as Quantity
,sum(data_SalePosReturnDetail.TaxAmount) as DtTaxAmount
from data_SalePosReturnDetail
   group by SalePosReturnID
) P on  p.SalePosReturnID = data_SalePosReturnInfo.SalePosReturnID where SalePosReturnDate between '" + DateFrom.ToString("dd-MMM-yyyy") + "' and '" + dateTo.ToString("dd-MMM-yyyy") + "' and WHID=" + CompanyInfo.WareHouseID + " group by WHID";
            DataTable dt = new DataTable();
            dt = STATICClass.SelectAllFromQuery(query).Tables[0];
            if (dt.Rows.Count <= 0)
            {
                DataRow dr = dt.NewRow();

                dr["WHID"] = CompanyInfo.WareHouseID;
                dr["GrossAmount"] = 0;
                dr["DiscountTotal"] = 0;

                dr["ReturnQuantity"] = 0;

                dt.Rows.Add(dr);

            }

            return dt;

        }


        public DataTable DailySaleManWise(int CompanyID, string ReportName, DateTime DateFrom, DateTime dateTo, int CategoryID = 0, int SaleManID = 0)
        {
            DataTable dt;

            string Sql = @"
		    select data_SalePosInfo.WHID,ISNULL(SalesMan.SaleManInfoID,0) as SaleManInfoID,ISNULL(SalesMan.SaleManName,'No Sales Person') as SaleManName,VariantDescription, InventCategory.CategoryID,CategoryName,InventItems.ItemNumber,adgen_ColorInfo.ColorTitle ,format(data_SalePosInfo.SalePosDate,'dd-MMM-yyyy') as SalePosDate,Sum(data_SalePosInfo.NetAmount) as SaleInfo_NetAmount,
            0 as SaleInfo_DPer,Sum(data_SalePosInfo.DiscountAmount) as SaleInfo_DAmount,data_SalePosDetail.ItemId,
 sum(data_SalePosDetail.Quantity) as Quantity,sum(data_SalePosDetail.Quantity*data_SalePosDetail.ItemRate) as DetailNet,0 as DiscountPercentage,sum(data_SalePosDetail.DiscountAmount) as DiscountAmount,
            sum(data_SalePosDetail.TaxAmount) as TaxAmount,
            InventItems.ItenName,Sum((ISNULL(data_SalePosInfo.CardPayment,0))) as CardPayment,sum((data_SalePosInfo.CashPayment)) as CashPayment,Sum(ISNULL(data_SalePosInfo.ExchangeAmount,0)) as Exchange
            from data_SalePosInfo 
            inner join data_SalePosDetail on data_SalePosInfo.SalePosID=data_SalePosDetail.SalePosID 
            left join InventItems on data_SalePosDetail.ItemId = InventItems.ItemId 
            left join InventCategory on InventCategory.CategoryID=InventItems.CategoryID
            left join InventItemGroup on InventCategory.ItemGroupID=InventItemGroup.ItemGroupID
            left join InventWareHouse on data_SalePosInfo.WHID=InventWareHouse.WHID
            left join adgen_ColorInfo on adgen_ColorInfo.ColorID=InventItems.ColorID
			left join gen_ItemVariantInfo on InventItems.ItemVarientId=gen_ItemVariantInfo.ItemVariantInfoId
			left join gen_SaleManInfo SalesMan on SalesMan.SaleManInfoID=data_SalePosInfo.SaleManId where 0=0  and data_SalePosInfo.DirectReturn=0 ";
            Sql = Sql + " and data_SalePosInfo.SalePosDate between '" + DateFrom + "' and '" + dateTo + "'  and data_SalePosInfo.Companyid=" + CompanyInfo.CompanyID + " and data_SalePosInfo.WHID=" + CompanyInfo.WareHouseID;
            if (CategoryID > 0)
            {
                Sql = Sql + " and InventItems.CateGoryID=" + CategoryID + "";
            }
            if (SaleManID > 0)
            {
                Sql = Sql + " and data_SalePosInfo.SaleManId=" + SaleManID + "";
            }
            Sql = Sql + @" group by SalesMan.SaleManInfoID,SalesMan.SaleManName,VariantDescription, InventCategory.CategoryID,CategoryName,InventItems.ItemNumber,adgen_ColorInfo.ColorTitle
			,data_SalePosDetail.ItemId,InventItems.ItenName,SalePosDate,data_SalePosInfo.WHID";
            Sql = Sql + " order by data_SalePosInfo.SalePosDate";
            dt = new DataTable();
            dt = STATICClass.SelectAllFromQuery(Sql).Tables[0];
            return dt;
        }

        public DataTable DailySaleSummary(int CompanyID, string ReportName, DateTime DateFrom, DateTime dateTo, int CategoryID = 0, int SaleManID = 0, int CashorCard = 0)
        {
            DataTable dt;
            string Sql = @"Select AmountReturn,isnull(SaleManInfoID,0) SaleManId,ISNULL(SaleManName,'No Sale Man') as SaleMane,SalePOSNo,SalePosDate,Sum(Quantity) as TSale,Sum(DiscountAmount) as DiscountAmount,sum(Quantity*ItemRate) as GrossAmount,CashPayment,CardPayment,SaleInfo_DAmount from(
		    select AmountReturn,data_SalePosInfo.CompanyID,data_SalePosInfo.WHID,SalesMan.SaleManInfoID,SalesMan.SaleManName,VariantDescription, InventCategory.CategoryID,CategoryName,InventItems.ItemNumber,adgen_ColorInfo.ColorTitle,data_SalePosInfo.SalePosID,data_SalePosInfo.SalePosNo ,format(data_SalePosInfo.SalePosDate,'dd-MMM-yyyy') as SalePosDate,data_SalePosInfo.NetAmount as SaleInfo_NetAmount,
            data_SalePosInfo.DiscountPercentage as SaleInfo_DPer,data_SalePosInfo.DiscountAmount as SaleInfo_DAmount,data_SalePosDetail.ItemId,
 data_SalePosDetail.Quantity,data_SalePosDetail.ItemRate,data_SalePosDetail.DiscountPercentage,data_SalePosDetail.DiscountAmount,
            data_SalePosDetail.TaxAmount,
            InventItems.ItenName,ISNULl(data_SalePosInfo.CardPayment,0) as CardPayment,isnull(data_SalePosInfo.CashPayment,0) as CashPayment
            from data_SalePosInfo 
            inner join data_SalePosDetail on data_SalePosInfo.SalePosID=data_SalePosDetail.SalePosID 
            left join InventItems on data_SalePosDetail.ItemId = InventItems.ItemId 
            left join InventCategory on InventCategory.CategoryID=InventItems.CategoryID
            left join InventItemGroup on InventCategory.ItemGroupID=InventItemGroup.ItemGroupID
            left join InventWareHouse on data_SalePosInfo.WHID=InventWareHouse.WHID
            left join adgen_ColorInfo on adgen_ColorInfo.ColorID=InventItems.ColorID
			left join gen_ItemVariantInfo on InventItems.ItemVarientId=gen_ItemVariantInfo.ItemVariantInfoId
			left join gen_SaleManInfo SalesMan on SalesMan.SaleManInfoID=data_SalePosInfo.SaleManId where 0=0 and data_SalePosInfo.DirectReturn=0
";
            Sql = Sql + " and data_SalePosInfo.SalePosDate between '" + DateFrom.ToString("dd-MMM-yyyy") + "' and '" + dateTo.ToString("dd-MMM-yyyy") + "'  and data_SalePosInfo.Companyid=" + CompanyInfo.CompanyID + " and data_SalePosInfo.WHID=" + CompanyInfo.WareHouseID + " )temp where 0=0";
            //if (CategoryID > 0)
            //{
            //    Sql = Sql + " and InventItems.CateGoryID=" + CategoryID + "";
            //}
            if (SaleManID > 0)
            {
                Sql = Sql + " and temp.SaleManInfoID=" + SaleManID + "";
            }
            if (CashorCard == 2)
            {
                Sql = Sql + " and temp.CashPayment>0";
            }
            if (CashorCard == 3)
            {
                Sql = Sql + " and temp.CardPayment>0";
            }
            Sql = Sql + " group by SalePOSNo,SalePosDate,CardPayment,CashPayment,SaleInfo_DAmount,SaleManInfoID,SaleManName,AmountReturn,CompanyID,WHID";
            dt = new DataTable();
            dt = STATICClass.SelectAllFromQuery(Sql).Tables[0];
            return dt;
        }
        public DataSet get_StockMovement(DateTime DateFrom, DateTime DateTo, int ItemID = 0, int CategoryID = 0, int MenuId = 0)
        {
            string DateFromstr = "'" + DateFrom.AddDays(-1).ToString("yyyy-MM-dd") + "'";
            string DateTostr = "'" + DateTo.ToString("yyyy-MM-dd") + "'";
            DataSet ds = new DataSet();
            string PURCHASE = "", PURCHASERETURN = "", SALE = "", SALERETURN = "", StockRETURN = "", MFGOUT = "", MFGIN = "";


            if (ItemID > 0)
            {
                PURCHASERETURN += " and data_StockIssuancetoPosKitchenDetail.ItemId = " + ItemID;

            }
            PURCHASERETURN += " and data_StockIssuancetoPosKitchen.FromWHID=" + CompanyInfo.WareHouseID + " and data_StockIssuancetoPosKitchen.CompanyID=" + CompanyInfo.CompanyID + "   and data_StockIssuancetoPosKitchen.IssuanceDate between '" + DateFrom.ToString("yyyy-MM-dd") + "' and '" + DateTo.ToString("yyyy-MM-dd") + "' ";
            if (ItemID > 0)
            {
                SALE += " and data_SalePosDetail.ItemId = " + ItemID;
            }
            SALE += " and data_SalePosInfo.WHID=" + CompanyInfo.WareHouseID + " and data_SalePosInfo.CompanyID=" + CompanyInfo.CompanyID + "  and data_SalePosInfo.SalePosDate between '" + DateFrom.ToString("yyyy-MM-dd") + "' and '" + DateTo.ToString("yyyy-MM-dd") + "' ";
            if (ItemID > 0)
            {
                StockRETURN += " and data_StockArrivalDetail.ItemId = " + ItemID;
            }
            StockRETURN += " and data_StockArrivalInfo.ArrivalToWHID=" + CompanyInfo.WareHouseID + " and data_StockArrivalInfo.CompanyID=" + CompanyInfo.CompanyID + " and data_StockArrivalInfo.ArrivalDate between '" + DateFrom.ToString("yyyy-MM-dd") + "' and '" + DateTo.ToString("yyyy-MM-dd") + "' ";
            if (ItemID > 0)
            {
                SALERETURN += " and data_SalePosReturnDetail.ItemId = " + ItemID;
            }
            SALERETURN += " and data_SalePosReturnInfo.WHID=" + CompanyInfo.WareHouseID + " and data_SalePosReturnInfo.CompanyID=" + CompanyInfo.CompanyID + " and data_SalePosReturnInfo.SalePosReturnDate between '" + DateFrom.ToString("yyyy-MM-dd") + "' and '" + DateTo.ToString("yyyy-MM-dd") + "' ";

            string WC = " where InventItems.CompanyID=" + CompanyInfo.CompanyID + " ";
            if (ItemID > 0)
            {
                WC += " and InventItems.ItemId = " + ItemID;
            }
            if (CategoryID > 0)
            {
                WC += " and InventItems.CategoryID = " + CategoryID;
            }
            if (MenuId > 0)
            {
                WC += " and cat.ItemGroupID = " + MenuId;
            }
            if (CompanyInfo.isKhaakiSoft)
            {
                WC += " and ISNULL(s.SaleQuantity,0)+ISNULL(sr.SaleReturnQuantity,0)+isnull(pr.PurchaseReturnQuantity,0)>0";
            }
            List<SqlParameter> ParamList = new List<SqlParameter>();

            ParamList.Add(new SqlParameter("@PURCHASERETURN", PURCHASERETURN));
            ParamList.Add(new SqlParameter("@SALE", SALE));
            ParamList.Add(new SqlParameter("@SALERETURN", SALERETURN));
            ParamList.Add(new SqlParameter("@StockRETURN", StockRETURN));

            ParamList.Add(new SqlParameter("@FromDate", DateFromstr));
            ParamList.Add(new SqlParameter("@ToDate", DateTostr));
            ParamList.Add(new SqlParameter("@WC", WC));
            ParamList.Add(new SqlParameter("@CompanyID", CompanyInfo.CompanyID));
            ds = STATICClass.SelectAll("get_POSStockMovement", ParamList);
            return ds;

        }


        public void StockReport(string reportName, DateTime dateTo, int CategoryID = 0, DateTime? RegisterFrom = null, DateTime? RegitserTo = null, int MenuID = 0)
        {
            ReportDocument rpt = new ReportDocument();
            DataTable dt = ItemStockReport(CompanyInfo.CompanyID, reportName, dateTo, CategoryID, RegisterFrom, RegitserTo, MenuID);
            if (CompanyInfo.isKhaakiSoft)
            {
                rpt.Load(Path.Combine(Application.StartupPath, "Report", "ItemStockKhaakiStyle.rpt"));
            }
            else
            {
                rpt.Load(Path.Combine(Application.StartupPath, "Report", "ItemStockReport.rpt"));
            }
            rpt.Database.Tables[0].SetDataSource(dt);

            rpt.SummaryInfo.ReportTitle = "Item Stock Report";

            rpt.SetParameterValue("CompanyName", CompanyInfo.WareHouseName);
            rpt.SetParameterValue("UserName", CompanyInfo.username);


            String Serverpath = Convert.ToString(Path.Combine(Application.StartupPath, "Resources", "logo.jpeg"));
            //rpt.SetParameterValue("ServerName", Serverpath);
            //rpt.SetParameterValue("Username", CompanyInfo.username);
            crystalReportViewer1.ReportSource = rpt;
            crystalReportViewer1.Refresh();
            this.ShowDialog();
            rpt.Dispose();
        }
        public void DailyStockMovement(string reportName, DateTime DateFrom, DateTime dateTo, int ItemID = 0, int CategoryID = 0, int MenuID = 0)
        {
            ReportDocument rpt = new ReportDocument();
            DataTable dt = get_StockMovement(DateFrom, dateTo, ItemID, CategoryID, MenuID).Tables[0];
            if (CompanyInfo.isKhaakiSoft)
            {
                rpt.Load(Path.Combine(Application.StartupPath, "Report", "StockMovementReportWithouValue.rpt"));
            }
            else
            {
                rpt.Load(Path.Combine(Application.StartupPath, "Report", "StockMovementReportFoodMama.rpt"));

            }
            rpt.Database.Tables[0].SetDataSource(dt);

            rpt.SummaryInfo.ReportTitle = "Stock Movement Report";

            rpt.SetParameterValue("CompanyName", CompanyInfo.WareHouseName);
            rpt.SetParameterValue("UserName", CompanyInfo.username);


            rpt.SetParameterValue("ReportFiltration", "From " + DateFrom.ToString("dd-MM-yyyy") + " To " + dateTo.ToString("dd-MM-yyyy"));

            rpt.SetParameterValue("WithouClosing", false);
            String Serverpath = Convert.ToString(Path.Combine(Application.StartupPath, "Resources", "logo.jpeg"));
            //rpt.SetParameterValue("ServerName", Serverpath);
            //rpt.SetParameterValue("Username", CompanyInfo.username);
            crystalReportViewer1.ReportSource = rpt;

            crystalReportViewer1.Refresh();
            this.ShowDialog();
            rpt.Dispose();
        }
        public void rptDailySale(string reportName, DateTime DateFrom, DateTime dateTo, int CategoryID = 0, int MenuID = 0)
        {
            ReportDocument rpt = new ReportDocument();
            DataTable dt = DailySale(CompanyInfo.CompanyID, reportName, DateFrom, dateTo, CategoryID, MenuID);
            DataTable CashCard = GetTotalSaleReturns(DateFrom, dateTo);
            rpt.Load(Path.Combine(Application.StartupPath, "Report", "SaleRegister.rpt"));
            rpt.Database.Tables[0].SetDataSource(dt);
            rpt.Database.Tables[1].SetDataSource(CashCard);

            rpt.SummaryInfo.ReportTitle = "Daily Sale Report";

            rpt.SetParameterValue("CompanyName", CompanyInfo.WareHouseName);
            rpt.SetParameterValue("UserName", CompanyInfo.username);
            rpt.SetParameterValue("MasterDiscount", SaleMasterDiscount(DateFrom, dateTo));


            rpt.SetParameterValue("ReportFiltration", "From " + DateFrom.ToString("dd-MM-yyyy") + " To " + dateTo.ToString("dd-MM-yyyy"));
            rpt.SetParameterValue("SuppressTag", false);

            String Serverpath = Convert.ToString(Path.Combine(Application.StartupPath, "Resources", "logo.jpeg"));
            //rpt.SetParameterValue("ServerName", Serverpath);
            //rpt.SetParameterValue("Username", CompanyInfo.username);
            crystalReportViewer1.ReportSource = rpt;
            crystalReportViewer1.Refresh();
            this.ShowDialog();
            rpt.Dispose();
        }



        public void rptDailySaleReturn(string reportName, DateTime DateFrom, DateTime dateTo, int CategoryID = 0, int MenuID = 0)
        {
            ReportDocument rpt = new ReportDocument();
            DataTable dt = DailySaleReturn(CompanyInfo.CompanyID, reportName, DateFrom, dateTo, CategoryID, MenuID);
            DataTable CashCard = GetTotalSaleReturns(DateFrom, dateTo);
            rpt.Load(Path.Combine(Application.StartupPath, "Report", "SaleReturnRegister.rpt"));
            rpt.Database.Tables[0].SetDataSource(dt);
            rpt.Database.Tables[1].SetDataSource(CashCard);

            rpt.SummaryInfo.ReportTitle = "Sale Return Report";

            rpt.SetParameterValue("CompanyName", CompanyInfo.WareHouseName);
            rpt.SetParameterValue("UserName", CompanyInfo.username);
            rpt.SetParameterValue("MasterDiscount", SaleMasterDiscount(DateFrom, dateTo));


            rpt.SetParameterValue("ReportFiltration", "From " + DateFrom.ToString("dd-MM-yyyy") + " To " + dateTo.ToString("dd-MM-yyyy"));
            rpt.SetParameterValue("SuppressTag", false);

            String Serverpath = Convert.ToString(Path.Combine(Application.StartupPath, "Resources", "logo.jpeg"));
            //rpt.SetParameterValue("ServerName", Serverpath);
            //rpt.SetParameterValue("Username", CompanyInfo.username);
            crystalReportViewer1.ReportSource = rpt;
            crystalReportViewer1.Refresh();
            this.ShowDialog();
            rpt.Dispose();
        }


        public void rptMakeOrderKhaaki(string reportName, DateTime DateFrom, DateTime dateTo, int CategoryID = 0)
        {
            ReportDocument rpt = new ReportDocument();
            DataTable dt = MakeOrdersList(CompanyInfo.CompanyID, reportName, DateFrom, dateTo, CategoryID);
            rpt.Load(Path.Combine(Application.StartupPath, "Report", "MakeOrdersList.rpt"));
            rpt.Database.Tables[0].SetDataSource(dt);
            if (DateFrom.Date == dateTo.Date)
            {

                rpt.SummaryInfo.ReportTitle = "Making Order's List";
            }
            else
            {
                rpt.SummaryInfo.ReportTitle = "Making Order's List";
            }
            rpt.SetParameterValue("CompanyName", CompanyInfo.WareHouseName);
            rpt.SetParameterValue("UserName", CompanyInfo.username);


            rpt.SetParameterValue("ReportFiltration", "From " + DateFrom.ToString("dd-MM-yyyy") + " To " + dateTo.ToString("dd-MM-yyyy"));
            rpt.SetParameterValue("SuppressTag", false);
            rpt.SetParameterValue("NetSale", TillNowSaleCalculation());
            rpt.SetParameterValue("MasterDiscount", SaleMasterDiscount(DateFrom, dateTo));

            String Serverpath = Convert.ToString(Path.Combine(Application.StartupPath, "Resources", "logo.jpeg"));
            //rpt.SetParameterValue("ServerName", Serverpath);
            //rpt.SetParameterValue("Username", CompanyInfo.username);
            crystalReportViewer1.ReportSource = rpt;
            crystalReportViewer1.Refresh();
            this.ShowDialog();
            rpt.Dispose();
        }


        public void StockReceiptList(string reportName, int CategoryID = 0)
        {
            ReportDocument rpt = new ReportDocument();
            DataTable dt = PrintReceiptList(CompanyInfo.CompanyID, reportName, CategoryID);
            rpt.Load(Path.Combine(Application.StartupPath, "Report", "StockReceiptPrint.rpt"));
            rpt.Database.Tables[0].SetDataSource(dt);


            rpt.SummaryInfo.ReportTitle = "Stock Receipt List";

            rpt.SetParameterValue("CompanyName", CompanyInfo.WareHouseName);
            rpt.SetParameterValue("UserName", CompanyInfo.username);


            rpt.SetParameterValue("ReportFiltration", "");
            rpt.SetParameterValue("SuppressTag", false);
            rpt.SetParameterValue("NetSale", TillNowSaleCalculation());
            rpt.SetParameterValue("MasterDiscount", "0");

            String Serverpath = Convert.ToString(Path.Combine(Application.StartupPath, "Resources", "logo.jpeg"));
            //rpt.SetParameterValue("ServerName", Serverpath);
            //rpt.SetParameterValue("Username", CompanyInfo.username);
            crystalReportViewer1.ReportSource = rpt;
            crystalReportViewer1.Refresh();
            this.ShowDialog();
            rpt.Dispose();
        }

        public void StockReturnList(string reportName, int CategoryID = 0)
        {
            ReportDocument rpt = new ReportDocument();
            DataTable dt = PrintStockReturnList(CompanyInfo.CompanyID, reportName, CategoryID);
            rpt.Load(Path.Combine(Application.StartupPath, "Report", "StockReturnedPrint.rpt"));
            rpt.Database.Tables[0].SetDataSource(dt);


            rpt.SummaryInfo.ReportTitle = "Stock Return List";

            rpt.SetParameterValue("CompanyName", CompanyInfo.WareHouseName);
            rpt.SetParameterValue("UserName", CompanyInfo.username);


            rpt.SetParameterValue("ReportFiltration", "");
            rpt.SetParameterValue("SuppressTag", false);
            rpt.SetParameterValue("NetSale", TillNowSaleCalculation());
            rpt.SetParameterValue("MasterDiscount", "0");

            String Serverpath = Convert.ToString(Path.Combine(Application.StartupPath, "Resources", "logo.jpeg"));
            //rpt.SetParameterValue("ServerName", Serverpath);
            //rpt.SetParameterValue("Username", CompanyInfo.username);
            crystalReportViewer1.ReportSource = rpt;
            crystalReportViewer1.Refresh();
            this.ShowDialog();
            rpt.Dispose();
        }


        public void DailySaleKhaaki(string reportName, DateTime DateFrom, DateTime dateTo, int CategoryID = 0)
        {
            ReportDocument rpt = new ReportDocument();
            DataTable dt = DailySaleKhaaki(CompanyInfo.CompanyID, reportName, DateFrom, dateTo, CategoryID);
            DataTable dtPromo = DailySaleKhaakiPromo(CompanyInfo.CompanyID, reportName, DateFrom, dateTo, CategoryID);
            rpt.Load(Path.Combine(Application.StartupPath, "Report", "SaleRegisterKhaaki.rpt"));
            rpt.Subreports["PromoDiscount.rpt"].SetDataSource(dtPromo);
            rpt.Database.Tables[0].SetDataSource(dt);
            if (DateFrom.Date == dateTo.Date)
            {
                rpt.SummaryInfo.ReportTitle = "Daily Sale Report";
            }
            else
            {
                rpt.SummaryInfo.ReportTitle = "Sale Report";
            }
            rpt.SetParameterValue("CompanyName", CompanyInfo.WareHouseName);
            rpt.SetParameterValue("UserName", CompanyInfo.username);


            rpt.SetParameterValue("ReportFiltration", "From " + DateFrom.ToString("dd-MM-yyyy") + " To " + dateTo.ToString("dd-MM-yyyy"));
            rpt.SetParameterValue("SuppressTag", false);
            rpt.SetParameterValue("NetSale", TillNowSaleCalculation());
            rpt.SetParameterValue("MasterDiscount", SaleMasterDiscount(DateFrom, dateTo));

            String Serverpath = Convert.ToString(Path.Combine(Application.StartupPath, "Resources", "logo.jpeg"));
            //rpt.SetParameterValue("ServerName", Serverpath);
            //rpt.SetParameterValue("Username", CompanyInfo.username);
            crystalReportViewer1.ReportSource = rpt;
            crystalReportViewer1.Refresh();
            this.ShowDialog();
            rpt.Dispose();
        }



        public void SaleActivityReport(string reportName, DateTime DateFrom, DateTime dateTo, int CategoryID = 0)
        {
            ReportDocument rpt = new ReportDocument();
            DataTable dt = SaleActivity(CompanyInfo.CompanyID, reportName, DateFrom, dateTo, CategoryID);
            DataTable dtPromo = SaleActivityPromo(CompanyInfo.CompanyID, reportName, DateFrom, dateTo, CategoryID);
            rpt.Load(Path.Combine(Application.StartupPath, "Report", "SaleActivityKhaaki.rpt"));
            rpt.Subreports["PromoDiscount.rpt"].SetDataSource(dtPromo);
            rpt.Database.Tables[0].SetDataSource(dt);
            if (DateFrom.Date == dateTo.Date)
            {

                rpt.SummaryInfo.ReportTitle = "Sale Activity Report";
            }
            else
            {
                rpt.SummaryInfo.ReportTitle = "Sale Activity Report";
            }
            rpt.SetParameterValue("CompanyName", CompanyInfo.WareHouseName);
            rpt.SetParameterValue("UserName", CompanyInfo.username);


            rpt.SetParameterValue("ReportFiltration", "From " + DateFrom.ToString("dd-MM-yyyy") + " To " + dateTo.ToString("dd-MM-yyyy"));
            rpt.SetParameterValue("SuppressTag", false);
            rpt.SetParameterValue("NetSale", TillNowSaleCalculation());
            rpt.SetParameterValue("MasterDiscount", SaleMasterDiscount(DateFrom, dateTo));

            String Serverpath = Convert.ToString(Path.Combine(Application.StartupPath, "Resources", "logo.jpeg"));
            //rpt.SetParameterValue("ServerName", Serverpath);
            //rpt.SetParameterValue("Username", CompanyInfo.username);
            crystalReportViewer1.ReportSource = rpt;
            crystalReportViewer1.Refresh();
            this.ShowDialog();
            rpt.Dispose();
        }

        public void rptCashCardWise(string reportName, DateTime DateFrom, DateTime dateTo, int CategoryID = 0, int SaleManID = 0, int SaleStyle = 0)
        {
            ReportDocument rpt = new ReportDocument();
            DataTable dt;
            DataTable CashCard;
            if (SaleStyle == 1)
            {
                rpt.Load(Path.Combine(Application.StartupPath, "Report", "CreditCardWise.rpt"));


            }
            else if (SaleStyle == 2)
            {
                rpt.Load(Path.Combine(Application.StartupPath, "Report", "CashSale.rpt"));

            }
            else
            {
                rpt.Load(Path.Combine(Application.StartupPath, "Report", "CardWise.rpt"));


            }
            dt = DailySaleSummary(CompanyInfo.CompanyID, reportName, DateFrom, dateTo, CategoryID, SaleManID, SaleStyle);
            CashCard = GetCashCardPayments(DateFrom, dateTo);
            rpt.Database.Tables[0].SetDataSource(dt);
            rpt.Database.Tables[1].SetDataSource(CashCard);

            if (SaleStyle == 1)
            {
                rpt.SummaryInfo.ReportTitle = "Both Cash and Card Sales";
            }
            else if (SaleStyle == 2)
            {
                rpt.SummaryInfo.ReportTitle = "Cash  Sales";
            }
            else
            {
                rpt.SummaryInfo.ReportTitle = "Card wise Sale Report";
            }
            rpt.SetParameterValue("CompanyName", CompanyInfo.WareHouseName);
            rpt.SetParameterValue("UserName", CompanyInfo.username);


            rpt.SetParameterValue("ReportFiltration", "From " + DateFrom.ToString("dd-MM-yyyy") + " To " + dateTo.ToString("dd-MM-yyyy"));
            rpt.SetParameterValue("SuppressTag", false);
            rpt.SetParameterValue("NetSale", TillNowSaleCalculation());
            rpt.SetParameterValue("MasterDiscount", SaleMasterDiscount(DateFrom, dateTo));

            String Serverpath = Convert.ToString(Path.Combine(Application.StartupPath, "Resources", "logo.jpeg"));
            //rpt.SetParameterValue("ServerName", Serverpath);
            //rpt.SetParameterValue("Username", CompanyInfo.username);
            crystalReportViewer1.ReportSource = rpt;
            crystalReportViewer1.Refresh();
            this.ShowDialog();
            rpt.Dispose();
        }
        public void rptSalesManWise(string reportName, DateTime DateFrom, DateTime dateTo, int CategoryID = 0, int SaleManID = 0, int SaleStyle = 0)
        {
            ReportDocument rpt = new ReportDocument();
            DataTable dt;
            DataTable CashCard;
            if (SaleStyle == 2)
            {
                rpt.Load(Path.Combine(Application.StartupPath, "Report", "CreditCardWise.rpt"));
                dt = DailySaleSummary(CompanyInfo.CompanyID, reportName, DateFrom, dateTo, CategoryID, SaleManID);

            }
            else
            {
                rpt.Load(Path.Combine(Application.StartupPath, "Report", "SaleRegisterWise.rpt"));
                dt = DailySaleManWise(CompanyInfo.CompanyID, reportName, DateFrom, dateTo, CategoryID, SaleManID);

            }
            CashCard = GetCashCardPayments(DateFrom, dateTo);
            rpt.Database.Tables[0].SetDataSource(dt);
            rpt.Database.Tables[1].SetDataSource(CashCard);

            if (DateFrom.Date == dateTo.Date)
            {
                rpt.SummaryInfo.ReportTitle = "SalesMan Wise Daily Sale Report";
            }
            else

            {
                rpt.SummaryInfo.ReportTitle = "SalesMan wise Sale Report";
            }
            rpt.SetParameterValue("CompanyName", CompanyInfo.WareHouseName);
            rpt.SetParameterValue("UserName", CompanyInfo.username);


            rpt.SetParameterValue("ReportFiltration", "From " + DateFrom.ToString("dd-MM-yyyy") + " To " + dateTo.ToString("dd-MM-yyyy"));
            rpt.SetParameterValue("SuppressTag", false);
            rpt.SetParameterValue("NetSale", TillNowSaleCalculation());
            rpt.SetParameterValue("MasterDiscount", SaleMasterDiscount(DateFrom, dateTo));

            String Serverpath = Convert.ToString(Path.Combine(Application.StartupPath, "Resources", "logo.jpeg"));
            //rpt.SetParameterValue("ServerName", Serverpath);
            //rpt.SetParameterValue("Username", CompanyInfo.username);
            crystalReportViewer1.ReportSource = rpt;
            crystalReportViewer1.Refresh();
            this.ShowDialog();
            rpt.Dispose();
        }
        public void CashBook(string StoreProcedure, string ReportName, List<string[]> parameters, int PrintStyle)
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
            if (CompanyInfo.CounterID > 0)
            {
                if (PrintStyle == 0)
                    rpt.Load(Path.Combine(Application.StartupPath, "Report", "CashBookThermalStyle.rpt"));
                else if (PrintStyle == 1)
                    rpt.Load(Path.Combine(Application.StartupPath, "Report", "CashBookA4.rpt"));
            }
            else

            {

                rpt.Load(Path.Combine(Application.StartupPath, "Report", "DayBook.rpt"));
            }
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

        private void crystalReportViewer1_Scroll(object sender, ScrollEventArgs e)
        {
            // the tabsheet that the report is shown on.
            Control control = this.crystalReportViewer1.Controls[0].Controls[0];
            // if a control on the tabsheet has the focus, then the scrollbar associated
            // with the tabsheet will actually work with the mouse wheel.
            if (!control.Controls[0].Focused)
                control.Controls[0].Focus();
        }
        public DataTable GetOpeningClosingSession(DataTable RecentSession)
        {
            DataTable dt;
            string Sql = @"
Select * from(select SessionStartTime, SessionClosingTime,CounterID,SourceName,(DebitAmount+CreditAmount) as NetAmount from vw_posSessionWiseOpClosing
where sessionID=" + Convert.ToInt32(RecentSession.Rows[0]["SessionID"]) + @")t
pivot (sum(NetAmount) for SourceName in ([Opening],[Closing],[Account Cash Out],[Manual],[Cash Difference])) as PivotResult
";


            dt = new DataTable();
            dt = STATICClass.SelectAllFromQuery(Sql).Tables[0];
            return dt;
        }
        public DataTable GetSaleSessionWise(DataTable RecentSession)
        {
            DataTable dt;
            string Sql = @"Select CounterID,Sum(GrossAmount) as GrossBill,sum(OtherCharges) as OtherCharges,sum(DiscountTotal) as DiscountTotal,sum(NetAmount) as NetAmount from data_SalePosInfo 
where CounterID=" + CompanyInfo.CounterID + @" and EntryUserDateTime between 
'" + Convert.ToDateTime(RecentSession.Rows[0]["SessionStartTime"]) + @"' and  '" + Convert.ToDateTime(RecentSession.Rows[0]["SessionClosingTime"]) + @"'
Group By CounterID
";


            dt = new DataTable();
            dt = STATICClass.SelectAllFromQuery(Sql).Tables[0];
            if (dt.Rows.Count <= 0)
            {
                DataRow row = dt.NewRow();
                row["CounterID"] = CompanyInfo.CounterID;
                row["GrossBill"] = "0";
                row["OtherCharges"] = "0";
                row["DiscountTotal"] = "0";
                row["NetAmount"] = "0";
                dt.Rows.Add(row);

            }
            return dt;
        }
        public DataTable GetSaleReturnSessionWise(DataTable RecentSession)
        {
            DataTable dt;
            string Sql = @"Select CounterID,Sum(GrossAmount) as GrossBill,sum(OtherCharges) as OtherCharges,sum(DiscountTotal) as DiscountTotal,sum(NetAmount) as NetAmount from data_SalePosReturnInfo  
where CounterID=" + CompanyInfo.CounterID + @" and EntryUserDateTime between 
'" + Convert.ToDateTime(RecentSession.Rows[0]["SessionStartTime"]) + @"' and  '" + Convert.ToDateTime(RecentSession.Rows[0]["SessionClosingTime"]) + @"'
Group By CounterID
";


            dt = new DataTable();
            dt = STATICClass.SelectAllFromQuery(Sql).Tables[0];
            if (dt.Rows.Count <= 0)
            {
                DataRow row = dt.NewRow();
                row["CounterID"] = CompanyInfo.CounterID;
                row["GrossBill"] = "0";
                row["OtherCharges"] = "0";
                row["DiscountTotal"] = "0";
                row["NetAmount"] = "0";
                dt.Rows.Add(row);
            }
            return dt;
        }
        public void GenerateClosing(DataTable SessionDt)
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            ReportDocument rpt = new ReportDocument();
            DataTable Transcations = GetOpeningClosingSession(SessionDt);

            DataTable Sales = GetSaleSessionWise(SessionDt);

            DataTable SalesReturn = GetSaleReturnSessionWise(SessionDt);
            DataTable dt2 = SelectCompanyDetail(" where companyid = " + CompanyInfo.CompanyID);


            rpt.Load(Path.Combine(Application.StartupPath, "Report", "ClosingReport.rpt"));

            rpt.Database.Tables[0].SetDataSource(Transcations);
            rpt.Database.Tables[1].SetDataSource(Sales);
            rpt.Database.Tables[2].SetDataSource(SalesReturn);

            rpt.SetParameterValue("CompanyName", dt2.Rows[0]["Title"]);
            rpt.SummaryInfo.ReportTitle = "Closing Report Till # " + Convert.ToString(CompanyInfo.CounterID);
            rpt.SummaryInfo.ReportAuthor = CompanyInfo.username;



            String Serverpath = Convert.ToString(Path.Combine(Application.StartupPath, "Resources", "logo.jpeg"));
            //rpt.SetParameterValue("ServerName", Serverpath);
            //rpt.SetParameterValue("Username", CompanyInfo.username);
            crystalReportViewer1.ReportSource = rpt;
            crystalReportViewer1.Refresh();
            this.ShowDialog();
            rpt.Dispose();


        }
        public DataTable KhaakiBarcodeSelectAll(string where = "", string id = "")

        {
            SqlConnection con = new SqlConnection(STATICClass.Connection());
            DataTable dt = new DataTable();

            SqlDataAdapter da = new SqlDataAdapter(@"
Select data_barcodePrintDetail.*,br.BrandName,data_barcodePrintMaster.CompanyID,gen_ItemMainGroupInfo.ItemMainGroupName,adgen_ColorInfo.ColorTitle,InventItems.ItemSalesPrice,catg.CategoryName from data_barcodePrintDetail inner join data_barcodePrintMaster on data_barcodePrintMaster.PrintID=data_barcodePrintDetail.PrintId
inner join InventItems on InventItems.ItemId=data_barcodePrintDetail.ItemID
left join gen_ItemMainGroupInfo on gen_ItemMainGroupInfo.ItemMainGroupID=InventItems.ItemMainGroupID
left join adgen_ColorInfo on adgen_ColorInfo.ColorID=InventItems.ColorID
left join InventItemBrands br on br.ItemBrandId=InventItems.ItemBrandId
left join InventCategory catg on catg.CategoryID=InventItems.CategoryID
JOIN generator_256 i 
ON i.n BETWEEN 1 AND data_barcodePrintDetail.PrintQty/2
                          " + where + " ORDER BY data_barcodePrintDetail.ItemID, i.n", con);

            da.Fill(dt);
            return dt;
        }

        public void KhaakiBarcodePrints(Int32 MasterID)
        {
            ReportDocument rpt = new ReportDocument();
            if (CompanyInfo.isKhaakiSoft)
            {
                rpt.Load(Path.Combine(Application.StartupPath, "Report", "ItemBarcodeKhaaki.rpt"));
            }

            DataTable dt = KhaakiBarcodeSelectAll(" where data_barcodePrintMaster.PrintId=" + MasterID + "");
            DataTable dt2 = SelectCompanyDetail(" where companyid = " + CompanyInfo.CompanyID);

            rpt.Database.Tables[0].SetDataSource(dt);
            rpt.Database.Tables[1].SetDataSource(dt2);

            rpt.SummaryInfo.ReportTitle = "Barcode";
            rpt.SummaryInfo.ReportAuthor = CompanyInfo.username;
            rpt.PrintToPrinter(1, false, 0, 0);
            //crystalReportViewer1.ReportSource = rpt;
            //crystalReportViewer1.Refresh();
            //this.ShowDialog();
            rpt.Dispose();
        }

    }
}
