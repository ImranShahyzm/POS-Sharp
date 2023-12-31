﻿using MetroFramework.Forms;
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

namespace POS.LookUpForms
{
    public partial class FrmStockReturnList  :MetroForm
    {
        public FrmStockReturnList()
        {
            InitializeComponent();
            LoadStockDataMaster();
        }
        public void LoadStockDataMaster()
        {
            var connectionString = STATICClass.Connection();
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " ";
            if (txtArrivalNo.Text == "")
            {
                SqlString = " SELECT IssuanceID, format(IssuanceDate, 'dd-MMM-yyyy') as IssuanceDate, IssuanceNo,Cast((Select sum(quantity) from data_StockIssuancetoPosKitchenDetail where data_StockIssuancetoPosKitchenDetail.IssuanceID = data_StockIssuancetoPosKitchen.IssuanceID) as int) as Quantity,cast((Select sum(quantity * inv.ItemSalesPrice) from data_StockIssuancetoPosKitchenDetail inner join InventItems inv on inv.ItemId = data_StockIssuancetoPosKitchenDetail.ItemId where data_StockIssuancetoPosKitchenDetail.IssuanceID = data_StockIssuancetoPosKitchen.IssuanceID) as int) as TotalAmount  from data_StockIssuancetoPosKitchen  where FromWHID=" + CompanyInfo.WareHouseID+"";
            }
            else
            {
                SqlString = "  SELECT IssuanceID, format(IssuanceDate, 'dd-MMM-yyyy') as IssuanceDate, IssuanceNo,Cast((Select sum(quantity) from data_StockIssuancetoPosKitchenDetail where data_StockIssuancetoPosKitchenDetail.IssuanceID = data_StockIssuancetoPosKitchen.IssuanceID) as int) as Quantity,cast((Select sum(quantity * inv.ItemSalesPrice) from data_StockIssuancetoPosKitchenDetail inner join InventItems inv on inv.ItemId = data_StockIssuancetoPosKitchenDetail.ItemId where data_StockIssuancetoPosKitchenDetail.IssuanceID = data_StockIssuancetoPosKitchen.IssuanceID) as int) as TotalAmount  from data_StockIssuancetoPosKitchen  where FromWHID=" + CompanyInfo.WareHouseID + " and IssuanceNo like '" + txtArrivalNo.Text + "%'";
            }
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            if (dt.Rows.Count > 0)
            {
                dgvMaster.DataSource = dt;
                dgvMaster.Columns[0].Visible = false;
                //dgvMaster.Columns[5].Visible = false;
            }
            else
            {
                this.dgvMaster.DataSource = null;
                dgvMaster.Rows.Clear();
                dgvMaster.Refresh();
            }
        }
        public void LoadStockDataMasterDateSearch()
        {
            var connectionString = STATICClass.Connection();
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " ";
            if (txtArrivalNo.Text == "")
            {
                SqlString = " SELECT IssuanceID, format(IssuanceDate, 'dd-MMM-yyyy') as IssuanceDate, IssuanceNo,Cast((Select sum(quantity) from data_StockIssuancetoPosKitchenDetail where data_StockIssuancetoPosKitchenDetail.IssuanceID = data_StockIssuancetoPosKitchen.IssuanceID) as int) as Quantity,cast((Select sum(quantity * inv.ItemSalesPrice) from data_StockIssuancetoPosKitchenDetail inner join InventItems inv on inv.ItemId = data_StockIssuancetoPosKitchenDetail.ItemId where data_StockIssuancetoPosKitchenDetail.IssuanceID = data_StockIssuancetoPosKitchen.IssuanceID) as int) as TotalAmount  from data_StockIssuancetoPosKitchen  where FromWHID=" + CompanyInfo.WareHouseID + " and IssuanceDate = '"+txtArrivalDate.Value+"'";
            }
            else
            {
                SqlString = "  SELECT IssuanceID, format(IssuanceDate, 'dd-MMM-yyyy') as IssuanceDate, IssuanceNo,Cast((Select sum(quantity) from data_StockIssuancetoPosKitchenDetail where data_StockIssuancetoPosKitchenDetail.IssuanceID = data_StockIssuancetoPosKitchen.IssuanceID) as int) as Quantity,cast((Select sum(quantity * inv.ItemSalesPrice) from data_StockIssuancetoPosKitchenDetail inner join InventItems inv on inv.ItemId = data_StockIssuancetoPosKitchenDetail.ItemId where data_StockIssuancetoPosKitchenDetail.IssuanceID = data_StockIssuancetoPosKitchen.IssuanceID) as int) as TotalAmount  from data_StockIssuancetoPosKitchen  where FromWHID=" + CompanyInfo.WareHouseID + " and IssuanceDate = '" + txtArrivalDate.Value + "' and IssuanceNo like '" + txtArrivalNo.Text + "%'";
            }
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            if (dt.Rows.Count > 0)
            {
                dgvMaster.DataSource = dt;
                dgvMaster.Columns[0].Visible = false;
                //dgvMaster.Columns[5].Visible = false;


            }
            else
            {
                this.dgvMaster.DataSource = null;
                dgvMaster.Rows.Clear();
                dgvMaster.Refresh();
            }
        }


        public void LoadStockDetailDataMaster(int ArrivalID)
        {
            var connectionString = STATICClass.Connection();
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " ";
            if (ArrivalID > 0)
            {
                SqlString = " Select ItemNumber, ItenName as ProductName,cast(Quantity as Int) as Returned,cast((Quantity * InventItems.ItemSalesPrice)as int) as Amount from data_StockIssuancetoPosKitchenDetail inner join InventItems on InventItems.ItemId = data_StockIssuancetoPosKitchenDetail.ItemId where IssuanceID =" + ArrivalID + "";


                SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                cnn.Close();
                if (dt.Rows.Count > 0)
                {
                    txtArrivalID.Text = Convert.ToString(ArrivalID);
                    dgvDetail.DataSource = dt;
                    dgvDetail.Columns[0].Width = 100;
                    dgvDetail.Columns[1].Width = 200;
                   
                    if (!CompanyInfo.isKhaakiSoft)
                    {
                        btnDelete.Visible = true;
                    }
                    btnPrint.Visible = true;
                }
                else
                {
                    this.dgvDetail.DataSource = null;
                    dgvDetail.Rows.Clear();
                    dgvDetail.Refresh();
                    btnDelete.Visible = false;
                    btnPrint.Visible = false;
                }
            }
        }
    
       

        private void txtArrivalDate_ValueChanged(object sender, EventArgs e)
        {
            LoadStockDataMasterDateSearch();
        }

        

        

        private void dgvMaster_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (dgvMaster.CurrentRow.Index >= 0)
            {
                var id = Convert.ToInt32(dgvMaster.CurrentRow.Cells[0].Value);
                if (id > 0)
                {
                    LoadStockDetailDataMaster(id);
                }
            }

        }

        private void dgvMaster_KeyUp(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Up)
            {
                if (dgvMaster.CurrentRow.Index >= 0)
                {
                    var id = Convert.ToInt32(dgvMaster.CurrentRow.Cells[0].Value);
                    if (id > 0)
                    {
                        LoadStockDetailDataMaster(id);
                    }
                }

            }
            if (e.KeyCode == Keys.Down)
            {
                if (dgvMaster.CurrentRow.Index >= 0)
                {
                    var id = Convert.ToInt32(dgvMaster.CurrentRow.Cells[0].Value);
                    if (id > 0)
                    {
                        LoadStockDetailDataMaster(id);
                    }
                }

            }
        }
        private void clearBothGrids()
        {
            this.dgvMaster.DataSource = null;
            dgvMaster.Rows.Clear();
            dgvMaster.Refresh();
            this.dgvDetail.DataSource = null;
            dgvDetail.Rows.Clear();
            dgvDetail.Refresh();
            btnDelete.Visible = false;
        }
        private void btnDelete_Click(object sender, EventArgs e)
        {
            var ArrivalID = Convert.ToInt32(txtArrivalID.Text);
            if(ArrivalID>0)
            {
                if (MessageBox.Show( "Are You Sure You Want to Delete the Selected Record...?", "Confirmation...!!", MessageBoxButtons.YesNo) == DialogResult.Yes)
                {
                    data_StockTransferInfoModel obj = new data_StockTransferInfoModel();
                    var Responce = obj.ArrivalDelete(ArrivalID);
                    if (Responce == "Deleted")
                    {
                        clearBothGrids();
                        LoadStockDataMaster();

                    }
                    else
                    {
                        MessageBox.Show(Responce);
                    }
                    return;
              
                    
                }
                   
            }
        }

        private void btnPrint_Click(object sender, EventArgs e)
        {
            using (frmCrystal obj = new frmCrystal())
            {
                string reportName = "";
                string WhereClause = "";
                reportName = "Sale Report";
                //  WhereClause = " Cash Book Detail From " + dtpSaleFromDate.Text + " To " + dtpSaleToDate.Text + "";
                try
                {
                    if (Convert.ToInt32(txtArrivalID.Text) > 0)
                    {
                        obj.StockReturnList(reportName, Convert.ToInt32(txtArrivalID.Text));
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            };
        }
    }
}
