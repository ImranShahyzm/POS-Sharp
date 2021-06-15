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
    public partial class frmSearchCustomerLookup :MetroForm
    {
        public string RegisterNo { get; set; }
        public string CustomerID { get; set; }
        public string PhoneNo { get; set; }

        public DateTime SaleInvoiceDate { get; set; }
        public frmSearchCustomerLookup()
        {
            InitializeComponent();
        }

        private void frmSearchCustomerLookup_Load(object sender, EventArgs e)
        {
            LoadAllRegisteredCustomer();
            txtPhoneSearch.Select();
            txtPhoneSearch.Focus();

        }

        

       

     

        private void txtProductSearch_TextChanged(object sender, EventArgs e)
        {
            LoadAllRegisteredCustomer();
        }

       

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        private void LoadAllRegisteredCustomer()
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " ";
            if (string.IsNullOrEmpty(txtPhoneSearch.Text))
            {
                SqlString = " Select CustomerID,Rno as RegisterNo,CName as Name,Cphone as Phone,CityName,Address from tblPos_CustomerData where WHID=" + CompanyInfo.WareHouseID + " ";
            }
            else
            {
               
                SqlString = " Select CustomerID,Rno as RegisterNo,CName as Name,Cphone as Phone,CityName,Address from tblPos_CustomerData where WHID=" + CompanyInfo.WareHouseID + " and Cphone like '" + txtPhoneSearch.Text + "%'";

            }
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            if (dt.Rows.Count > 0)
            {
                dgvSaleInvoices.DataSource = dt;
                dgvSaleInvoices.Columns[0].Visible = false;
                dgvSaleInvoices.Columns[1].Visible = false;
            }
            else
            {
                this.dgvSaleInvoices.DataSource = null;
                dgvSaleInvoices.Rows.Clear();
                dgvSaleInvoices.Refresh();
            }
        }

       


      
        private void ResultReturn(int Index)
        {
          
            if (Index > 0)
            {
                DataGridViewRow dgr = dgvSaleInvoices.Rows[Index];
                RegisterNo = dgr.Cells["RegisterNo"].Value.ToString();
                CustomerID = dgr.Cells["CustomerID"].Value.ToString();
                // SaleInvoiceDate = dtpSaleFromDate.Value;
                this.DialogResult = DialogResult.OK;
                this.Close();
            }
            else if (Index == 0)
            {
                DataGridViewRow dgr = dgvSaleInvoices.Rows[0];
                RegisterNo = dgr.Cells["RegisterNo"].Value.ToString();
                CustomerID = dgr.Cells["CustomerID"].Value.ToString();
                // SaleInvoiceDate = dtpSaleFromDate.Value;
                this.DialogResult = DialogResult.OK;
                this.Close();
            }
        }

      
        private void dtpSaleFromDate_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                dgvSaleInvoices.Select();
                dgvSaleInvoices.Focus();
            }
        }

      

        private void dgvSaleInvoices_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int index = dgvSaleInvoices.SelectedRows[0].Index;
            ResultReturn(index);
        }

        private void dgvSaleInvoices_KeyDown(object sender, KeyEventArgs e)
        {

            if (e.KeyCode == Keys.Enter)
            {
                int rowIndex = dgvSaleInvoices.CurrentCell.OwningRow.Index;
                ResultReturn(rowIndex);
            }
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void txtPhoneSearch_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                dgvSaleInvoices.Focus();
            }
        }
    }
}
