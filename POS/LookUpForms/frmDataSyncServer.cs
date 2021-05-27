using MetroFramework.Forms;
using Newtonsoft.Json;
using POS.Helper;
using POS.Report;
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

namespace POS
{
    public partial class frmDataSyncServer : MetroForm
    {
        public frmDataSyncServer()
        {
            InitializeComponent();
            
          
        }

        
      
        protected override bool ProcessCmdKey(ref Message msg, Keys keyData)
        {
            if (keyData == (Keys.Alt | Keys.P))
            {
                return true;
            }
            else if (keyData == (Keys.Alt | Keys.N))
            {
                return true;
            }
            return base.ProcessCmdKey(ref msg, keyData);
        }


        private async void  btnPreview_Click(object sender, EventArgs e)
        {

            

                btnProgressBar.Value = 9;
                lblStatus.Text = "Syncing Locations With Server...";
                await STATICClass.GetAllWareHouseGluserPromo();
                await STATICClass.GetAllSalesMan();

            

            var obj = new data_StockTransferInfoModel().SelectAllArrivalStock("where ArrivalDate between '"+dtpSaleFromDate.Value+ "' and '" + dtpSaleToDate.Value+ "' and  ArrivalToWHID=" + CompanyInfo.WareHouseID + " and CompanyID=" + CompanyInfo.CompanyID + "",true,true, "where ArrivalDate between '" + dtpSaleFromDate.Value + "' and '" + dtpSaleToDate.Value + "' and  ArrivalToWHID=" + CompanyInfo.WareHouseID + " and CompanyID=" + CompanyInfo.CompanyID + "");
           
            
            bool StartInvoices = false;
            bool StartReturnInvoices = false;
            string Responce = "";
            if (obj.Tables[0].Rows.Count > 0)
            {
                btnProgressBar.Value = 10;

                foreach (DataRow row in obj.Tables[0].Rows)
                {
                    string ArrivalID = row["ArrivalID"].ToString();
                    string WhereArrivalClause = "where ArrivalDate between '" + dtpSaleFromDate.Value + "' and '" + dtpSaleToDate.Value + "' and ArrivalToWHID = " + CompanyInfo.WareHouseID + " and CompanyID = " + CompanyInfo.CompanyID + " and data_StockArrivalInfo.ArrivalID="+ArrivalID+"";
                    var ArrivalObj = new data_StockTransferInfoModel().SelectAllArrivalStock(WhereArrivalClause,true,true,WhereArrivalClause);

                    string result = JsonConvert.SerializeObject(ArrivalObj);
                    lblStatus.Visible = true;
                    
                    Responce = await STATICClass.InsertAllStockArrivaltoServer(result, ArrivalID);
                    if (Convert.ToString(Responce).Contains("Done"))
                    {

                        if (btnProgressBar.Value <= 35)
                        {
                            btnProgressBar.Value = btnProgressBar.Value + 1;
                        }
                        StartInvoices = true;

                    }
                    else
                    {
                        lblStatus.Text = Responce;
                    }
                }
            }
            else

            {
                btnProgressBar.Value = 35;
                lblStatus.Text = "Uploading Invoices to Server...";
                StartInvoices = true;

            }
            if(StartInvoices==true)
            {
                var Invoices = new data_StockTransferInfoModel().SelectAllInvoicesForUploading("where SalePosDate between '" + dtpSaleFromDate.Value.ToString("dd-MMM-yyyy") + "' and '" + dtpSaleToDate.Value.ToString("dd-MMM-yyyy") + "' and  WHID=" + CompanyInfo.WareHouseID + " and CompanyID=" + CompanyInfo.CompanyID + "", true, true, "where SalePosDate between '" + dtpSaleFromDate.Value.ToString("dd-MMM-yyyy") + "' and '" + dtpSaleToDate.Value.ToString("dd-MMM-yyyy") + "' and  WHID=" + CompanyInfo.WareHouseID + " and CompanyID=" + CompanyInfo.CompanyID + "" , "where SalePosReturnDate between '" + dtpSaleFromDate.Value.ToString("dd-MMM-yyyy") + "' and '" + dtpSaleToDate.Value.ToString("dd-MMM-yyyy") + "' and  WHID=" + CompanyInfo.WareHouseID + " and CompanyID=" + CompanyInfo.CompanyID + "");


                if(Invoices.Tables[0].Rows.Count>0)
                {
                    foreach(DataRow row in Invoices.Tables[0].Rows)
                    {
                        string WhereSaleCluse = "where SalePosDate between '" + dtpSaleFromDate.Value.ToString("dd-MMM-yyyy") + "' and '" + dtpSaleToDate.Value.ToString("dd-MMM-yyyy") + "' and WHID = " + CompanyInfo.WareHouseID + " and CompanyID = " + CompanyInfo.CompanyID + " and data_salePosInfo.SalePosID="+Convert.ToInt32(row["SalePosID"])+"";
                        string whereReturnClause= "where SalePosReturnDate between '" + dtpSaleFromDate.Value.ToString("dd-MMM-yyyy") + "' and '" + dtpSaleToDate.Value.ToString("dd-MMM-yyyy") + "' and WHID = " + CompanyInfo.WareHouseID + " and CompanyID = " + CompanyInfo.CompanyID + "";
                        var InvoiceWiseRecords = new data_StockTransferInfoModel().SelectAllInvoicesForUploading(WhereSaleCluse,true,true, WhereSaleCluse, "");


                        string JsonInvoices = JsonConvert.SerializeObject(InvoiceWiseRecords);
                        if (InvoiceWiseRecords.Tables[0].Rows.Count > 0)
                        {
                            var InvoiceRespomnce = await STATICClass.InsertAllSalesAndReturntoServer(JsonInvoices, dtpSaleFromDate.Value.ToString("dd-MMM-yyyy"), dtpSaleToDate.Value.ToString("dd-MMM-yyyy"), CompanyInfo.WareHouseID.ToString(), CompanyInfo.CompanyID.ToString(), row["SalePosID"].ToString());
                            Responce = InvoiceRespomnce;
                            if (Convert.ToString(Responce).Contains("Done"))
                            {
                                if (btnProgressBar.Value <= 75)
                                {
                                    btnProgressBar.Value = btnProgressBar.Value + 1;
                                }
                            }
                        }
                        else
                        {
                            Responce = "Done";
                        }

                    }


                }


                
                    if (Convert.ToString(Responce).Contains("Done"))
                    {

                        btnProgressBar.Value = 75;
                        lblStatus.Text = "Uploading Return Invoices to Server...";
                        StartReturnInvoices = true;
                    }
                    else
                    {
                    
                        btnProgressBar.Value = 75;
                        lblStatus.Text = "Uploading Return Invoices to Server...";
                        StartReturnInvoices = true;
                    }
            }
            if (StartReturnInvoices==true)
            {

                var RInvoices = new data_StockTransferInfoModel().SelectAllInvoicesForUploading("where SalePosDate between '" + dtpSaleFromDate.Value.ToString("dd-MMM-yyyy") + "' and '" + dtpSaleToDate.Value.ToString("dd-MMM-yyyy") + "' and  WHID=" + CompanyInfo.WareHouseID + " and CompanyID=" + CompanyInfo.CompanyID + "", true, true, "where SalePosDate between '" + dtpSaleFromDate.Value.ToString("dd-MMM-yyyy") + "' and '" + dtpSaleToDate.Value.ToString("dd-MMM-yyyy") + "' and  WHID=" + CompanyInfo.WareHouseID + " and CompanyID=" + CompanyInfo.CompanyID + "", "where SalePosReturnDate between '" + dtpSaleFromDate.Value.ToString("dd-MMM-yyyy") + "' and '" + dtpSaleToDate.Value.ToString("dd-MMM-yyyy") + "' and  WHID=" + CompanyInfo.WareHouseID + " and CompanyID=" + CompanyInfo.CompanyID + "",false);

                var RInvoiceRespomnce="";
                if (RInvoices.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow row in RInvoices.Tables[0].Rows)
                    {
                        string SaleReturnClause = "where SalePosReturnDate between '" + dtpSaleFromDate.Value.ToString("dd-MMM-yyyy") + "' and '" + dtpSaleToDate.Value.ToString("dd-MMM-yyyy") + "' and WHID = " + CompanyInfo.WareHouseID + " and CompanyID = " + CompanyInfo.CompanyID + " and data_SalePosReturnInfo.SalePOSReturnID=" + Convert.ToInt32(row["SalePOSReturnID"]) +"";
                        var ReturnInvoice = new data_StockTransferInfoModel().SelectAllInvoicesForUploading("",true,true,"", SaleReturnClause, false);

                        string RJsonInvoices = JsonConvert.SerializeObject(ReturnInvoice);
                        RInvoiceRespomnce = await STATICClass.InsertAllSalesReturntoServer(RJsonInvoices, dtpSaleFromDate.Value.ToString("dd-MMM-yyyy"), dtpSaleToDate.Value.ToString("dd-MMM-yyyy"), CompanyInfo.WareHouseID.ToString(), CompanyInfo.CompanyID.ToString(), Convert.ToString(row["SalePOSReturnID"]));

                    }
                }
                else
                {
                    RInvoiceRespomnce = "Done";
                }

               
                if (Convert.ToString(RInvoiceRespomnce).Contains("Done"))
                {
                    btnProgressBar.Value = 100;
                    lblStatus.Text = "Data Uploaded Successfully...";
                  
                }
                else
                {
                    MessageBox.Show(RInvoiceRespomnce);
                    lblStatus.Text = "Error Occured During Uploading...";

                    btnProgressBar.Value = 0;
                    return;
                }

            }


            string postingSaleVouchers = await STATICClass.PosAllSaleVouchers( dtpSaleFromDate.Value.ToString("dd-MMM-yyyy"), dtpSaleToDate.Value.ToString("dd-MMM-yyyy"), CompanyInfo.WareHouseID.ToString(), CompanyInfo.CompanyID.ToString());

            


        }

        private void dtpSaleFromDate_ValueChanged(object sender, EventArgs e)
        {

            dtpSaleToDate.Value = dtpSaleFromDate.Value;

        }
    }
}
