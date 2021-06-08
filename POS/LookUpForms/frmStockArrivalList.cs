using MetroFramework.Forms;
using POS.Helper;
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
    public partial class frmStockArrivalList  :MetroForm
    {
        public frmStockArrivalList()
        {
            InitializeComponent();
            LoadStockDataMaster();
        }
        public void LoadStockDataMaster()
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " ";
            if (txtArrivalNo.Text == "")
            {
                SqlString = " SELECT        ArrivalID,TransferNo,  format(ArrivalDate,'dd-MMM-yyyy') as ArrivalDate, ArrivalNo,data_StockArrivalInfo.Remarks, RefID  from data_StockArrivalInfo left join data_RawStockTransfer on data_RawStockTransfer.TransferIDRef=refID where ArrivalToWHID=" + CompanyInfo.WareHouseID+"";
            }
            else
            {
                SqlString = " SELECT        ArrivalID, TransferNo, format(ArrivalDate,'dd-MMM-yyyy') as ArrivalDate, ArrivalNo,data_StockArrivalInfo.Remarks, RefID from data_StockArrivalInfo left join data_RawStockTransfer on data_RawStockTransfer.TransferIDRef=refID where ArrivalToWHID=" + CompanyInfo.WareHouseID + " and ArrivalNo like '" + txtArrivalNo.Text + "%'";
            }
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            if (dt.Rows.Count > 0)
            {
                dgvMaster.DataSource = dt;
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
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " ";
            if (txtArrivalNo.Text == "")
            {
                SqlString = "  SELECT        ArrivalID,TransferNo,  format(ArrivalDate,'dd-MMM-yyyy') as ArrivalDate, ArrivalNo,data_StockArrivalInfo.Remarks, RefID  from data_StockArrivalInfo left join data_RawStockTransfer on data_RawStockTransfer.TransferIDRef=refID where ArrivalToWHID=" + CompanyInfo.WareHouseID + " and ArrivalDate = '"+txtArrivalDate.Value+"'";
            }
            else
            {
                SqlString = "  SELECT        ArrivalID,TransferNo,  format(ArrivalDate,'dd-MMM-yyyy') as ArrivalDate, ArrivalNo,data_StockArrivalInfo.Remarks, RefID  from data_StockArrivalInfo left join data_RawStockTransfer on data_RawStockTransfer.TransferIDRef=refID where ArrivalToWHID=" + CompanyInfo.WareHouseID + " and ArrivalDate = '" + txtArrivalDate.Value + "' and ArrivalNo like '" + txtArrivalNo.Text + "%'";
            }
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            if (dt.Rows.Count > 0)
            {
                dgvMaster.DataSource = dt;
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
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " ";
            if (ArrivalID > 0)
            {
                SqlString = " Select ItemNumber,ItenName as ProductName,Quantity as Received from data_StockArrivalDetail inner join InventItems on InventItems.ItemId=data_StockArrivalDetail.ItemId where ArrivalID=" + ArrivalID + "";


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
                }
                else
                {
                    this.dgvDetail.DataSource = null;
                    dgvDetail.Rows.Clear();
                    dgvDetail.Refresh();
                    btnDelete.Visible = false;
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
    }
}
