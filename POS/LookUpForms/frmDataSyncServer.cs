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
        private void UpdateSyncedOrder(string OrderID)
        {


            SqlConnection db = new SqlConnection(STATICClass.Connection());
            SqlCommand com = new SqlCommand();
            com.Connection = db;
            db.Open();

            com.CommandText = @"update Posdata_MaketoOrderInfo set 
                           IsOrderSynced=1 where Neck is not null and FFrontNeck is not null and FBackNeck is not null and Hip is not null and Muscle is not null and OrderId=" + OrderID+"";
            com.ExecuteNonQuery();

            db.Close();

        }


        private async void  btnPreview_Click(object sender, EventArgs e)
        {
            btnProgressBar.Value = 9;
            lblStatus.Text = "Syncing Locations With Server...";
            btnSync.Enabled = false;
            try
            {
                await STATICClass.GetAllInventory();
                await STATICClass.GetAllWareHouseGluserPromo();
                await STATICClass.GetAllSalesMan();

                var obj = new data_StockTransferInfoModel().SelectAllArrivalStock("where ArrivalDate between '" + dtpSaleFromDate.Value + "' and '" + dtpSaleToDate.Value + "' and  ArrivalToWHID=" + CompanyInfo.WareHouseID + " and CompanyID=" + CompanyInfo.CompanyID + "", true, true, "where ArrivalDate between '" + dtpSaleFromDate.Value + "' and '" + dtpSaleToDate.Value + "' and  ArrivalToWHID=" + CompanyInfo.WareHouseID + " and CompanyID=" + CompanyInfo.CompanyID + "");

                bool StartInvoices = false;
                bool StartReturnInvoices = false;
                string Responce = "";
                if (obj.Tables[0].Rows.Count > 0)
                {
                    btnProgressBar.Value = 10;

                    foreach (DataRow row in obj.Tables[0].Rows)
                    {
                        string ArrivalID = row["ArrivalID"].ToString();
                        string WhereArrivalClause = "where ArrivalDate between '" + dtpSaleFromDate.Value + "' and '" + dtpSaleToDate.Value + "' and ArrivalToWHID = " + CompanyInfo.WareHouseID + " and CompanyID = " + CompanyInfo.CompanyID + " and data_StockArrivalInfo.ArrivalID=" + ArrivalID + "";
                        var ArrivalObj = new data_StockTransferInfoModel().SelectAllArrivalStock(WhereArrivalClause, true, true, WhereArrivalClause);

                        string result = JsonConvert.SerializeObject(ArrivalObj);
                        lblStatus.Visible = true;

                        Responce = await STATICClass.CheckNewWayofStockArrivalInsert(result, ArrivalID);
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
                if (StartInvoices == true)
                {
                    var Invoices = new data_StockTransferInfoModel().SelectAllInvoicesForUploading("where SalePosDate between '" + dtpSaleFromDate.Value.ToString("dd-MMM-yyyy") + "' and '" + dtpSaleToDate.Value.ToString("dd-MMM-yyyy") + "' and  WHID=" + CompanyInfo.WareHouseID + " and CompanyID=" + CompanyInfo.CompanyID + "", true, true, "where SalePosDate between '" + dtpSaleFromDate.Value.ToString("dd-MMM-yyyy") + "' and '" + dtpSaleToDate.Value.ToString("dd-MMM-yyyy") + "' and  WHID=" + CompanyInfo.WareHouseID + " and CompanyID=" + CompanyInfo.CompanyID + "", "where SalePosReturnDate between '" + dtpSaleFromDate.Value.ToString("dd-MMM-yyyy") + "' and '" + dtpSaleToDate.Value.ToString("dd-MMM-yyyy") + "' and  WHID=" + CompanyInfo.WareHouseID + " and CompanyID=" + CompanyInfo.CompanyID + "");


                    if (Invoices.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow row in Invoices.Tables[0].Rows)
                        {
                            string WhereSaleCluse = "where SalePosDate between '" + dtpSaleFromDate.Value.ToString("dd-MMM-yyyy") + "' and '" + dtpSaleToDate.Value.ToString("dd-MMM-yyyy") + "' and WHID = " + CompanyInfo.WareHouseID + " and CompanyID = " + CompanyInfo.CompanyID + " and data_salePosInfo.SalePosID=" + Convert.ToInt32(row["SalePosID"]) + "";
                            string whereReturnClause = "where SalePosReturnDate between '" + dtpSaleFromDate.Value.ToString("dd-MMM-yyyy") + "' and '" + dtpSaleToDate.Value.ToString("dd-MMM-yyyy") + "' and WHID = " + CompanyInfo.WareHouseID + " and CompanyID = " + CompanyInfo.CompanyID + "";
                            var InvoiceWiseRecords = new data_StockTransferInfoModel().SelectAllInvoicesForUploading(WhereSaleCluse, true, true, WhereSaleCluse, "");


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

                        btnProgressBar.Value = 60;
                        lblStatus.Text = "Uploading Return Invoices to Server...";
                        StartReturnInvoices = true;
                    }
                    else
                    {

                        btnProgressBar.Value = 60;
                        lblStatus.Text = "Uploading Return Invoices to Server...";
                        StartReturnInvoices = true;
                    }
                }
                if (StartReturnInvoices == true)
                {

                    var RInvoices = new data_StockTransferInfoModel().SelectAllInvoicesForUploading("where SalePosDate between '" + dtpSaleFromDate.Value.ToString("dd-MMM-yyyy") + "' and '" + dtpSaleToDate.Value.ToString("dd-MMM-yyyy") + "' and  WHID=" + CompanyInfo.WareHouseID + " and CompanyID=" + CompanyInfo.CompanyID + "", true, true, "where SalePosDate between '" + dtpSaleFromDate.Value.ToString("dd-MMM-yyyy") + "' and '" + dtpSaleToDate.Value.ToString("dd-MMM-yyyy") + "' and  WHID=" + CompanyInfo.WareHouseID + " and CompanyID=" + CompanyInfo.CompanyID + "", "where SalePosReturnDate between '" + dtpSaleFromDate.Value.ToString("dd-MMM-yyyy") + "' and '" + dtpSaleToDate.Value.ToString("dd-MMM-yyyy") + "' and  WHID=" + CompanyInfo.WareHouseID + " and CompanyID=" + CompanyInfo.CompanyID + "", false);

                    var RInvoiceRespomnce = "";
                    if (RInvoices.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow row in RInvoices.Tables[0].Rows)
                        {
                            string SaleReturnClause = "where SalePosReturnDate between '" + dtpSaleFromDate.Value.ToString("dd-MMM-yyyy") + "' and '" + dtpSaleToDate.Value.ToString("dd-MMM-yyyy") + "' and WHID = " + CompanyInfo.WareHouseID + " and CompanyID = " + CompanyInfo.CompanyID + " and data_SalePosReturnInfo.SalePOSReturnID=" + Convert.ToInt32(row["SalePOSReturnID"]) + "";
                            var ReturnInvoice = new data_StockTransferInfoModel().SelectAllInvoicesForUploading("", true, true, "", SaleReturnClause, false);

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
                        btnProgressBar.Value = 70;


                    }
                    else
                    {
                        MessageBox.Show(RInvoiceRespomnce);
                        lblStatus.Text = "Error Occured During Uploading...";
                        btnProgressBar.Value = 0;
                        btnSync.Enabled = true;
                        return;
                    }

                }
                bool StartSyncingMakeOrder = true;
                if (StartSyncingMakeOrder == true)
                {

                    string WhereClause = " where RegisterDate between '" + dtpSaleFromDate.Value.ToString("dd-MMM-yyyy") + "' and '" + dtpSaleToDate.Value.ToString("dd-MMM-yyyy") + "' and WHID = " + CompanyInfo.WareHouseID + " and CompanyID = " + CompanyInfo.CompanyID;
                    var MakeOrders = new data_StockTransferInfoModel().SelectAllMaketoOrder(WhereClause, true, false, "");

                    var RInvoiceRespomnce = "";
                    if (MakeOrders.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow row in MakeOrders.Tables[0].Rows)
                        {
                            WhereClause = " where RegisterDate between '" + dtpSaleFromDate.Value.ToString("dd-MMM-yyyy") + "' and '" + dtpSaleToDate.Value.ToString("dd-MMM-yyyy") + "' and WHID = " + CompanyInfo.WareHouseID + " and CompanyID = " + CompanyInfo.CompanyID + " and Posdata_MaketoOrderInfo.OrderID=" + Convert.ToInt32(row["OrderID"]) + "";
                            var OrdersData = new data_StockTransferInfoModel().SelectAllMaketoOrder(WhereClause, true, true, WhereClause);
                            //var abc =(byte[])OrdersData.Tables[0].Rows[0]["ImagePath"];
                            //string base64String = Convert.ToBase64String(abc, 0, abc.Length);
                            //OrdersData.Tables[0].Rows[0]["ImageActualPath"] =base64String;
                            string JsonOrdersData = JsonConvert.SerializeObject(OrdersData);
                            RInvoiceRespomnce = await STATICClass.InsertAllMakeOrderData(JsonOrdersData, Convert.ToString(row["OrderID"]));
                            if (Convert.ToString(RInvoiceRespomnce).Contains("Done"))
                            {
                                UpdateSyncedOrder(Convert.ToString(row["OrderID"]));
                            }


                        }
                    }
                    else
                    {
                        RInvoiceRespomnce = "Done";
                    }


                    if (Convert.ToString(RInvoiceRespomnce).Contains("Done"))
                    {
                        btnProgressBar.Value = 80;
                        await STATICClass.GetAllDispatchedOrdersFromServer(dtpSaleFromDate.Value.Date.ToString("dd-MMM-yyyy"), dtpSaleToDate.Value.Date.ToString("dd-MMM-yyyy"));

                    }
                    else
                    {
                        MessageBox.Show(RInvoiceRespomnce);
                        lblStatus.Text = "Error Occured During Uploading...";
                        btnProgressBar.Value = 0;
                        btnSync.Enabled = true;
                        return;
                    }

                }


                bool StartSyncingCashInOut = true;
                if (StartSyncingCashInOut == true)
                {

                    string WhereClause = " where [Date] between '" + dtpSaleFromDate.Value.ToString("dd-MMM-yyyy") + "' and '" + dtpSaleToDate.Value.ToString("dd-MMM-yyyy") + "'";
                    var CashInOutTrans = new data_StockTransferInfoModel().SelectAllCashInOut(WhereClause, true, true, WhereClause);

                    var RInvoiceRespomnce = "";
                    if (CashInOutTrans.Tables[0].Rows.Count > 0)
                    {
                        string CashInOutTransDate = JsonConvert.SerializeObject(CashInOutTrans);
                        RInvoiceRespomnce = await STATICClass.InsertAllCashInOut(CashInOutTransDate, dtpSaleFromDate.Value.ToString("dd-MMM-yyyy"), dtpSaleToDate.Value.ToString("dd-MMM-yyyy"));

                    }
                    else
                    {
                        RInvoiceRespomnce = "Done";
                    }


                    if (Convert.ToString(RInvoiceRespomnce).Contains("Done"))
                    {
                        btnProgressBar.Value = 90;
                        lblStatus.Text = "Data Uploaded Successfully...";

                    }
                    else
                    {
                        MessageBox.Show(RInvoiceRespomnce);
                        lblStatus.Text = "Error Occured During Uploading...";
                        btnProgressBar.Value = 0;
                        btnSync.Enabled = true;
                        return;
                    }

                }


                string postingSaleVouchers = await STATICClass.PosAllSaleVouchers(dtpSaleFromDate.Value.ToString("dd-MMM-yyyy"), dtpSaleToDate.Value.ToString("dd-MMM-yyyy"), CompanyInfo.WareHouseID.ToString(), CompanyInfo.CompanyID.ToString());
                btnProgressBar.Value = 95;


                await STATICClass.GetAllStockDispatcherFromServer(dtpSaleFromDate.Value.Date.ToString("dd-MMM-yyyy"), dtpSaleToDate.Value.Date.ToString("dd-MMM-yyyy"));
                btnProgressBar.Value = 100;

               await SyncLiveDataAsync();

            }
            catch (Exception ex)
            {
                btnProgressBar.ForeColor = Color.Red;
                lblStatus.Text = "Error Occurred During Uploading...";
                btnProgressBar.Value = 0;
                btnSync.Enabled = true;
                if (ex.HResult == -2146233088)
                {
                    MessageBox.Show("Oops! Looks like your server is down. Please check server availability to proceed further", "Server Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                else
                {
                    MessageBox.Show(ex.ExceptionMessage());
                }
                
            }

        }
        public async Task SyncLiveDataAsync()
        {
            var RInvoices = new data_StockTransferInfoModel().StockReturnedToServer("where IssuanceDate between '" + dtpSaleFromDate.Value.ToString("dd-MMM-yyyy") + "' and '" + dtpSaleToDate.Value.ToString("dd-MMM-yyyy") + "' and  FromWHID=" + CompanyInfo.WareHouseID + " and CompanyID=" + CompanyInfo.CompanyID + "", true, true, "where IssuanceDate between '" + dtpSaleFromDate.Value.ToString("dd-MMM-yyyy") + "' and '" + dtpSaleToDate.Value.ToString("dd-MMM-yyyy") + "' and  FromWHID=" + CompanyInfo.WareHouseID + " and CompanyID=" + CompanyInfo.CompanyID + "", "", false);

            string RJsonInvoices = JsonConvert.SerializeObject(RInvoices);
            var RInvoiceRespomnce = "";
            if (RInvoices.Tables[0].Rows.Count > 0)
            {
                RInvoiceRespomnce = await STATICClass.InsertAllStockReturntoServer(RJsonInvoices, dtpSaleFromDate.Value.ToString("dd-MMM-yyyy"), dtpSaleToDate.Value.ToString("dd-MMM-yyyy"), CompanyInfo.WareHouseID.ToString(), CompanyInfo.CompanyID.ToString());
            }
            else
            {
                RInvoiceRespomnce = "Done";
            }

        }
        private void dtpSaleFromDate_ValueChanged(object sender, EventArgs e)
        {

           // dtpSaleToDate.Value = dtpSaleFromDate.Value;

        }

        private void frmDataSyncServer_Load(object sender, EventArgs e)
        {
            dtpSaleFromDate.Value = System.DateTime.Now.AddDays(-15);
        }
        
    }
}
