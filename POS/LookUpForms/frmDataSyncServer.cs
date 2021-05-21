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
           
            string result = JsonConvert.SerializeObject(obj);
            lblStatus.Visible = true;
            btnProgressBar.Value = 10;
            bool StartInvoices = false;
            bool StartReturnInvoices = false;
            string Responce = "";
            if (obj.Tables[0].Rows.Count > 0)
            {
                 Responce = await STATICClass.InsertAllStockArrivaltoServer(result);
                if (Convert.ToString(Responce).Contains("Done"))
                {
                    btnProgressBar.Value = 20;
                    lblStatus.Text = "Uploading Invoices to Server...";
                    StartInvoices = true;

                }
                else
                {
                    lblStatus.Text = Responce;
                }
            }
            else

            {
                btnProgressBar.Value = 20;
                lblStatus.Text = "Uploading Invoices to Server...";
                StartInvoices = true;

            }
            if(StartInvoices==true)
            {
                var Invoices = new data_StockTransferInfoModel().SelectAllInvoicesForUploading("where SalePosDate between '" + dtpSaleFromDate.Value.ToString("dd-MMM-yyyy") + "' and '" + dtpSaleToDate.Value.ToString("dd-MMM-yyyy") + "' and  WHID=" + CompanyInfo.WareHouseID + " and CompanyID=" + CompanyInfo.CompanyID + "", true, true, "where SalePosDate between '" + dtpSaleFromDate.Value.ToString("dd-MMM-yyyy") + "' and '" + dtpSaleToDate.Value.ToString("dd-MMM-yyyy") + "' and  WHID=" + CompanyInfo.WareHouseID + " and CompanyID=" + CompanyInfo.CompanyID + "" , "where SalePosReturnDate between '" + dtpSaleFromDate.Value.ToString("dd-MMM-yyyy") + "' and '" + dtpSaleToDate.Value.ToString("dd-MMM-yyyy") + "' and  WHID=" + CompanyInfo.WareHouseID + " and CompanyID=" + CompanyInfo.CompanyID + "");

                string JsonInvoices = JsonConvert.SerializeObject(Invoices);
                if (Invoices.Tables[0].Rows.Count > 0)
                {
                    var InvoiceRespomnce = await STATICClass.InsertAllSalesAndReturntoServer(JsonInvoices, dtpSaleFromDate.Value.ToString("dd-MMM-yyyy"), dtpSaleToDate.Value.ToString("dd-MMM-yyyy"), CompanyInfo.WareHouseID.ToString(), CompanyInfo.CompanyID.ToString());
                    Responce = InvoiceRespomnce;
                }
                else
                {
                    Responce = "Done";
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

                string RJsonInvoices = JsonConvert.SerializeObject(RInvoices);
                var RInvoiceRespomnce="";
                if (RInvoices.Tables[0].Rows.Count > 0)
                {
                     RInvoiceRespomnce = await STATICClass.InsertAllSalesReturntoServer(RJsonInvoices, dtpSaleFromDate.Value.ToString("dd-MMM-yyyy"), dtpSaleToDate.Value.ToString("dd-MMM-yyyy"), CompanyInfo.WareHouseID.ToString(), CompanyInfo.CompanyID.ToString());
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

        }

        private void dtpSaleFromDate_ValueChanged(object sender, EventArgs e)
        {

            dtpSaleToDate.Value = dtpSaleFromDate.Value;

        }
    }
}
