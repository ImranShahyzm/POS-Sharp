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
    public partial class frmSaleInvoiceLookUp : Form
    {
        public string SaleInvoiceNo { get; set; }
        public frmSaleInvoiceLookUp()
        {
            InitializeComponent();
        }

        private void frmSaleInvoiceLookUp_Load(object sender, EventArgs e)
        {
            loadSaleInvoices();
            txtInvoiceSearch.Select();
            txtInvoiceSearch.Focus();

        }

        

       

        private void SetupDataGridView()
        {

            var ID = new DataGridViewTextBoxColumn();
            ID.Name = "SalePosID";
            ID.HeaderText = "SalePosID";
            ID.Visible = false;

            var TaxAmount = new DataGridViewTextBoxColumn();
            TaxAmount.Name = "TaxAmount";
            TaxAmount.HeaderText = "TaxAmount";
            TaxAmount.Width = 100;

            var GrossAmount = new DataGridViewTextBoxColumn();
            GrossAmount.Name = "GrossAmount";
            GrossAmount.HeaderText = "GrossAmount";
            GrossAmount.Width = 100;

            var OtherCharges = new DataGridViewTextBoxColumn();
            OtherCharges.Name = "OtherCharges";
            OtherCharges.HeaderText = "OtherCharges";
            OtherCharges.Width = 100;

            var NetAmount = new DataGridViewTextBoxColumn();
            NetAmount.Name = "NetAmount";
            NetAmount.HeaderText = "NetAmount";
            NetAmount.Width = 100;

            var AmountReceive = new DataGridViewTextBoxColumn();
            AmountReceive.Name = "AmountReceive";
            AmountReceive.HeaderText = "AmountReceive";
            AmountReceive.Width = 100;

            var AmountReturn = new DataGridViewTextBoxColumn();
            AmountReturn.Name = "AmountReturn";
            AmountReturn.HeaderText = "AmountReturn";
            AmountReturn.Width = 100;


            dgvSaleInvoices.Columns.Add(ID);
            dgvSaleInvoices.Columns.Add(TaxAmount);
            dgvSaleInvoices.Columns.Add(GrossAmount);
            dgvSaleInvoices.Columns.Add(OtherCharges);
            dgvSaleInvoices.Columns.Add(NetAmount);
            dgvSaleInvoices.Columns.Add(AmountReceive);
            dgvSaleInvoices.Columns.Add(AmountReturn);
        }

        private void txtProductSearch_TextChanged(object sender, EventArgs e)
        {
            loadSaleInvoices();
        }

        private void dtpSaleFromDate_ValueChanged(object sender, EventArgs e)
        {
            loadSaleInvoices();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        private void loadSaleInvoices()
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " ";
            if (txtInvoiceSearch.Text=="")
            {
                SqlString = " select SalePosID,TaxAmount,GrossAmount,OtherCharges,NetAmount,AmountReceive,AmountReturn from data_salePosInfo where SalePosDate='" + dtpSaleFromDate.Text + "' ";
            }
            else
            {
                SqlString = " select SalePosID,TaxAmount,GrossAmount,OtherCharges,NetAmount,AmountReceive,AmountReturn from data_salePosInfo where SalePosDate='" + dtpSaleFromDate.Text + "' and SalePosID like '" + txtInvoiceSearch.Text+"%'";
            }
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            if (dt.Rows.Count > 0)
            {
                dgvSaleInvoices.DataSource = dt;
            }
            else
            {
                this.dgvSaleInvoices.DataSource = null;
                dgvSaleInvoices.Rows.Clear();
                dgvSaleInvoices.Refresh();
            }
        }

        private void txtInvoiceSearch_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!(Char.IsDigit(e.KeyChar) || (e.KeyChar == (char)Keys.Back)))
                e.Handled = true;
        }

        private void dgvSaleInvoices_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void dgvSaleInvoices_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)13)
            {
                DataGridViewRow dgr = dgvSaleInvoices.CurrentRow;
                SaleInvoiceNo = dgr.Cells["SalePosID"].Value.ToString();
                this.DialogResult = DialogResult.OK;
                this.Close();
            }
        }
    }
}
