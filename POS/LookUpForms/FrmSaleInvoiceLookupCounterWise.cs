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
    public partial class FrmSaleInvoiceLookupCounterWise :MetroForm
    {
        public string SaleInvoiceNo { get; set; }

        public DateTime SaleInvoiceDate { get; set; }
        public FrmSaleInvoiceLookupCounterWise()
        {
            InitializeComponent();
        }

        private void FrmSaleInvoiceLookupCounterWise_Load(object sender, EventArgs e)
        {
            loadSaleInvoices();
            txtInvoiceSearch.Select();
            txtInvoiceSearch.Focus();

        }

        

       

        private void SetupDataGridView()
        {

            var ID = new DataGridViewTextBoxColumn();
            ID.Name = "SalePOSNO";
            ID.HeaderText = "Sale No";
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
                SqlString = " select SALEPOSNO,TaxAmount,GrossAmount,OtherCharges,NetAmount,AmountReceive,AmountReturn from data_salePosInfo where SalePosDate='" + dtpSaleFromDate.Text + "' and CounterID="+CompanyInfo.CounterID+" ";
            }
            else
            {
                SqlString = " select SalePOSNO,TaxAmount,GrossAmount,OtherCharges,NetAmount,AmountReceive,AmountReturn from data_salePosInfo where SalePosDate='" + dtpSaleFromDate.Text + "' and  CounterID=" + CompanyInfo.CounterID + " and SalePosNO like '" + txtInvoiceSearch.Text+"%'";
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
                
              
            }
        }
        private void ResultReturn(int Index)
        {
          
            if (Index > 0)
            {
                DataGridViewRow dgr = dgvSaleInvoices.Rows[Index];
                SaleInvoiceNo = dgr.Cells["SalePOSNO"].Value.ToString();
                SaleInvoiceDate = dtpSaleFromDate.Value;
                this.DialogResult = DialogResult.OK;
                this.Close();
            }
            else if (Index == 0)
            {
                DataGridViewRow dgr = dgvSaleInvoices.Rows[0];
                SaleInvoiceNo = dgr.Cells["SalePOSNO"].Value.ToString();
                SaleInvoiceDate = dtpSaleFromDate.Value;
                this.DialogResult = DialogResult.OK;
                this.Close();
            }
        }

        private void txtInvoiceSearch_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                dtpSaleFromDate.Select();
                dtpSaleFromDate.Focus();
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

        private void panel2_Paint(object sender, PaintEventArgs e)
        {

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
    }
}
