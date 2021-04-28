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
    public partial class frmManualStockLookUp : MetroForm
    {
        public int ArrivalID { get; set; }
        public string ManualNumber { get; set; }

        public string ArrivalDate { get; set; }
        public frmManualStockLookUp()
        {
            InitializeComponent();
            loadProducts();
        }
        bool onload = false;
        public frmManualStockLookUp(string manualNumber)
        {
            InitializeComponent();
        }

        private void frmManualStockLookUp_Load(object sender, EventArgs e)
        {
            txtProductSearch.Select();
            txtProductSearch.Focus();
        }

        private void SetupDataGridView()
        {

            var ID = new DataGridViewTextBoxColumn();
            ID.Name = "ID";
            ID.HeaderText = "ID";
            ID.Visible = false;

            var Product = new DataGridViewTextBoxColumn();
            Product.Name = "ArrivalDate";
            Product.HeaderText = "Arrival Date";
            Product.Width = 180;

            var ManualNumber = new DataGridViewTextBoxColumn();
            ManualNumber.Name = "ManualNo";
            ManualNumber.HeaderText = "Manual No";
            ManualNumber.Width = 180;

            var VehicleNo = new DataGridViewTextBoxColumn();
            ManualNumber.Name = "VehicleNo";
            ManualNumber.HeaderText = "Vehicle No";
            ManualNumber.Width = 180;


            dgvProducts.Columns.Add(ID);
            dgvProducts.Columns.Add(Product);
            dgvProducts.Columns.Add(ManualNumber);
            dgvProducts.Columns.Add(VehicleNo);

        }
        private void loadProducts()
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " Select ArrivalID,Format(ArrivalDate , 'dd-MMM-yyyy') as ArrivalDate,ManualNo,VehicleNo from data_StockArrivalInfo Where ArrivalToWHID="+CompanyInfo.WareHouseID+"";
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            dgvProducts.DataSource = dt;
            this.dgvProducts.Columns["ArrivalID"].Visible = false;
            this.dgvProducts.Columns["ArrivalDate"].Width = 150;
        }

        private void txtProductSearch_TextChanged(object sender, EventArgs e)
        {
            string searchValue = txtProductSearch.Text;
            string SqlString = " Select ArrivalID,Format(ArrivalDate , 'dd-MMM-yyyy') as ArrivalDate,ManualNo,VehicleNo from data_StockArrivalInfo Where ArrivalToWHID=" + CompanyInfo.WareHouseID + " and  ManualNumber= '" + searchValue + "'";
            
            if (searchValue=="")
            {
                SqlString = " Select ArrivalID,Format(ArrivalDate , 'dd-MMM-yyyy') as ArrivalDate,ManualNo,VehicleNo from data_StockArrivalInfo Where ArrivalToWHID=" + CompanyInfo.WareHouseID + "";
            }
            else
            {
                SqlString = " Select ArrivalID,Format(ArrivalDate , 'dd-MMM-yyyy') as ArrivalDate,ManualNo,VehicleNo from data_StockArrivalInfo Where ArrivalToWHID=" + CompanyInfo.WareHouseID + " and  ManualNumber= '" + searchValue + "'";
            }
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            dgvProducts.DataSource = dt;
            this.dgvProducts.Columns["ArrivalID"].Visible = false;
            this.dgvProducts.Columns["ArrivalDate"].Width = 150;
        }

        private void dgvProducts_DoubleClick(object sender, EventArgs e)
        {

        }

        private void dgvProducts_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            string value = dgvProducts.Rows[e.RowIndex].Cells["ArrivalID"].Value.ToString();
            string manualNumber = dgvProducts.Rows[e.RowIndex].Cells["ManualNo"].Value.ToString();
            ManualNumber = manualNumber;
            ArrivalID = Convert.ToInt32(value);
            this.DialogResult = DialogResult.OK;
            this.Close();
        }

     
        private void dgvProducts_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)13)
            {
                DataGridViewRow dgr = dgvProducts.Rows[dgvProducts.CurrentRow.Index-1];
                string value = dgr.Cells["ArrivalID"].Value.ToString();
                string manualNumber = dgr.Cells["ManualNo"].Value.ToString();
                ManualNumber = manualNumber;
                ArrivalID = Convert.ToInt32(value);
                this.DialogResult = DialogResult.OK;
                this.Close();
            }
        }

        private void txtProductSearch_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                dgvProducts.Focus();
            }
        }

      
    }
}
