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
        public DataTable ItemStockReport(int CompanyID ,string ReportName,DateTime dateTo,int CategoryID=0, DateTime? RegisterFrom = null, DateTime? RegitserTo = null)
        {
            DataTable dt;

            string Sql = @"
           select Format(isnull(InventItems.RegisterInevntoryDate,'01-01-2017') , 'dd-MMM-yyyy') as Age, varnt.VariantDescription,ab.ColorTitle,InventItems.ItemNumber, case when isnull(sum(Quantity) ,0) = 0 then 0 else isnull(Sum(Amount),0)/isnull(sum(Quantity) ,0) end ";
            
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
            if(RegisterFrom!=null && RegitserTo !=null)
            {
                Sql += " and Isnull(RegisterInevntoryDate,'01-01-2017') between '"+RegisterFrom+"' and '"+RegitserTo+"'";
            }
Sql += @" group by s.ItemId , InventItems.ItenName ,InventItems.ReOrderLevel, InventUOM.UOMName ,InventItems.CategoryID,InventCategory.ItemGroupID, 
InventCategory.CategoryName, InventItemGroup.ItemGroupName,RegisterInevntoryDate,CartonSize,Itemnumber,VariantDescription,ColorTitle";
            
            dt = new DataTable();
            dt = STATICClass.SelectAllFromQuery(Sql).Tables[0];
            return dt;
        }

        public DataTable DailySale(int CompanyID, string ReportName, DateTime DateFrom, DateTime dateTo,int CategoryID=0)
        {
            DataTable dt;

            string Sql = @"
		    select VariantDescription, InventCategory.CategoryID,CategoryName,InventItems.ItemNumber,adgen_ColorInfo.ColorTitle,data_SalePosInfo.SalePosID,data_SalePosInfo.SalePosNo ,format(data_SalePosInfo.SalePosDate,'dd-MMM-yyyy') as SalePosDate,data_SalePosInfo.NetAmount as SaleInfo_NetAmount,
            data_SalePosInfo.DiscountPercentage as SaleInfo_DPer,data_SalePosInfo.DiscountAmount as SaleInfo_DAmount,data_SalePosDetail.ItemId,
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
            if(CategoryID>0)
            {
                Sql = Sql + " and InventItems.CateGoryID=" + CategoryID + "";
            }
            Sql=Sql+ " order by data_SalePosInfo.SalePosDate,SalePosNo";
            dt = new DataTable();
            dt = STATICClass.SelectAllFromQuery(Sql).Tables[0];
            return dt;
        }

        public DataTable DailySaleManWise(int CompanyID, string ReportName, DateTime DateFrom, DateTime dateTo, int CategoryID = 0, int SaleManID = 0)
        {
            DataTable dt;

            string Sql = @"
		    
		    select SalesMan.SaleManInfoID,SalesMan.SaleManName,VariantDescription, InventCategory.CategoryID,CategoryName,InventItems.ItemNumber,adgen_ColorInfo.ColorTitle,data_SalePosInfo.SalePosID,data_SalePosInfo.SalePosNo ,format(data_SalePosInfo.SalePosDate,'dd-MMM-yyyy') as SalePosDate,data_SalePosInfo.NetAmount as SaleInfo_NetAmount,
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
			left join gen_SaleManInfo SalesMan on SalesMan.SaleManInfoID=data_SalePosInfo.SaleManId where 0=0 ";
            Sql = Sql + " and data_SalePosInfo.SalePosDate between '" + DateFrom + "' and '" + dateTo + "'  and data_SalePosInfo.Companyid=" + CompanyInfo.CompanyID + " and data_SalePosInfo.WHID=" + CompanyInfo.WareHouseID;
            if (CategoryID > 0)
            {
                Sql = Sql + " and InventItems.CateGoryID=" + CategoryID + "";
            }
            if (SaleManID > 0)
            {
                Sql = Sql + " and data_SalePosInfo.SaleManId=" + SaleManID + "";
            }
            Sql = Sql + " order by data_SalePosInfo.SalePosDate,SalePosNo";
            dt = new DataTable();
            dt = STATICClass.SelectAllFromQuery(Sql).Tables[0];
            return dt;
        }

        public DataTable DailySaleSummary(int CompanyID, string ReportName, DateTime DateFrom, DateTime dateTo, int CategoryID = 0, int SaleManID = 0)
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
			left join gen_SaleManInfo SalesMan on SalesMan.SaleManInfoID=data_SalePosInfo.SaleManId where 0=0 
";
            Sql = Sql + " and data_SalePosInfo.SalePosDate between '" + DateFrom + "' and '" + dateTo + "'  and data_SalePosInfo.Companyid=" + CompanyInfo.CompanyID + " and data_SalePosInfo.WHID=" + CompanyInfo.WareHouseID+ " )temp where 0=0";
            //if (CategoryID > 0)
            //{
            //    Sql = Sql + " and InventItems.CateGoryID=" + CategoryID + "";
            //}
            if (SaleManID > 0)
            {
                Sql = Sql + " and temp.SaleManInfoID=" + SaleManID + "";
            }
            Sql = Sql + " group by SalePOSNo,SalePosDate,CardPayment,CashPayment,SaleInfo_DAmount,SaleManInfoID,SaleManName,AmountReturn,CompanyID,WHID";
            dt = new DataTable();
            dt = STATICClass.SelectAllFromQuery(Sql).Tables[0];
            return dt;
        }
        public DataSet get_StockMovement(DateTime DateFrom,DateTime DateTo, int ItemID = 0,int CategoryID=0)
        {
            string DateFromstr = "'" + DateFrom.ToString("yyyy-MM-dd") + "'";
            string DateTostr = "'" + DateTo.ToString("yyyy-MM-dd") + "'";
            DataSet ds = new DataSet();
            string PURCHASE = "", PURCHASERETURN = "", SALE = "", SALERETURN = "", STOCKINOUT = "", MFGOUT = "", MFGIN = "";
            

            if (ItemID > 0)
            {
                PURCHASERETURN += " and data_StockIssuancetoPosKitchenDetail.ItemId = " + ItemID;

            }
            PURCHASERETURN += " and data_StockIssuancetoPosKitchen.CompanyID=" + CompanyInfo.CompanyID + "   and data_StockIssuancetoPosKitchen.IssuanceDate between '" + DateFrom.ToString("yyyy-MM-dd") + "' and '" + DateTo.ToString("yyyy-MM-dd") + "' ";
            if (ItemID > 0)
            {
                SALE += " and data_SalePosDetail.ItemId = " +ItemID;
            }
            SALE += " and data_SalePosInfo.CompanyID=" + CompanyInfo.CompanyID + "  and data_SalePosInfo.SalePosDate between '" + DateFrom.ToString("yyyy-MM-dd") + "' and '" + DateTo.ToString("yyyy-MM-dd") + "' ";
            if (ItemID > 0)
            {
                SALERETURN += " and data_StockArrivalDetail.ItemId = " + ItemID;
            }
            SALERETURN += " and data_StockArrivalInfo.CompanyID=" + CompanyInfo.CompanyID + " and data_StockArrivalInfo.ArrivalDate between '" + DateFrom.ToString("yyyy-MM-dd") + "' and '" + DateTo.ToString("yyyy-MM-dd") + "' ";
            string WC = " where InventItems.CompanyID=" + CompanyInfo.CompanyID + " ";
            if (ItemID > 0)
            {
                WC += " and InventItems.ItemId = " + ItemID;
            }
            if (CategoryID > 0)
            {
                WC += " and InventItems.CategoryID = " + CategoryID;
            }
            List<SqlParameter> ParamList = new List<SqlParameter>();
           
            ParamList.Add(new SqlParameter("@PURCHASERETURN", PURCHASERETURN));
            ParamList.Add(new SqlParameter("@SALE", SALE));
            ParamList.Add(new SqlParameter("@SALERETURN", SALERETURN));
           
            ParamList.Add(new SqlParameter("@FromDate", DateFromstr));
            ParamList.Add(new SqlParameter("@ToDate", DateTostr));
            ParamList.Add(new SqlParameter("@WC", WC));
            ParamList.Add(new SqlParameter("@CompanyID", CompanyInfo.CompanyID));
            ds = STATICClass.SelectAll("get_POSStockMovement", ParamList);
            return ds;

        }


        public void StockReport(string reportName,DateTime dateTo,int CategoryID =0,DateTime ?RegisterFrom=null,DateTime ?RegitserTo=null)
        {
            ReportDocument rpt = new ReportDocument();
            DataTable dt = ItemStockReport(CompanyInfo.CompanyID,reportName,dateTo,CategoryID,RegisterFrom,RegitserTo);
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
        public void DailyStockMovement(string reportName, DateTime DateFrom, DateTime dateTo,int ItemID=0, int CategoryID = 0)
        {
            ReportDocument rpt = new ReportDocument();
            DataTable dt = get_StockMovement( DateFrom, dateTo,ItemID ,CategoryID).Tables[0];
            rpt.Load(Path.Combine(Application.StartupPath, "Report", "StockMovementReportWithouValue.rpt"));
            rpt.Database.Tables[0].SetDataSource(dt);

            rpt.SummaryInfo.ReportTitle = "Stock Movement Report";

            rpt.SetParameterValue("CompanyName", CompanyInfo.WareHouseName);
            rpt.SetParameterValue("UserName", CompanyInfo.username);


            rpt.SetParameterValue("ReportFiltration", "From " + DateFrom.ToString("dd-MM-yyyy") + " To " + dateTo.ToString("dd-MM-yyyy"));
            
            rpt.SetParameterValue("WithouClosing",false);
            String Serverpath = Convert.ToString(Path.Combine(Application.StartupPath, "Resources", "logo.jpeg"));
            //rpt.SetParameterValue("ServerName", Serverpath);
            //rpt.SetParameterValue("Username", CompanyInfo.username);
            crystalReportViewer1.ReportSource = rpt;
            crystalReportViewer1.Refresh();
            this.ShowDialog();
            rpt.Dispose();
        }
        public void DailySale(string reportName, DateTime DateFrom,DateTime dateTo,int CategoryID=0)
        {
            ReportDocument rpt = new ReportDocument();
            DataTable dt = DailySale(CompanyInfo.CompanyID, reportName,DateFrom, dateTo,CategoryID);
            rpt.Load(Path.Combine(Application.StartupPath, "Report", "SaleRegister.rpt"));
            rpt.Database.Tables[0].SetDataSource(dt);

            rpt.SummaryInfo.ReportTitle = "Daily Sale Report";

            rpt.SetParameterValue("CompanyName", CompanyInfo.WareHouseName);
            rpt.SetParameterValue("UserName", CompanyInfo.username);

           
            rpt.SetParameterValue("ReportFiltration","From "+DateFrom.ToString("dd-MM-yyyy") +" To "+dateTo.ToString("dd-MM-yyyy"));
            rpt.SetParameterValue("SuppressTag", false);

            String Serverpath = Convert.ToString(Path.Combine(Application.StartupPath, "Resources", "logo.jpeg"));
            //rpt.SetParameterValue("ServerName", Serverpath);
            //rpt.SetParameterValue("Username", CompanyInfo.username);
            crystalReportViewer1.ReportSource = rpt;
            crystalReportViewer1.Refresh();
            this.ShowDialog();
            rpt.Dispose();
        }
        public void rptSalesManWise(string reportName, DateTime DateFrom, DateTime dateTo, int CategoryID = 0,int SaleManID=0, int SaleStyle = 0)
        {
            ReportDocument rpt = new ReportDocument();
            DataTable dt;
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
                rpt.Database.Tables[0].SetDataSource(dt);

            rpt.SummaryInfo.ReportTitle = "Daily Sale Report";

            rpt.SetParameterValue("CompanyName", CompanyInfo.WareHouseName);
            rpt.SetParameterValue("UserName", CompanyInfo.username);


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
