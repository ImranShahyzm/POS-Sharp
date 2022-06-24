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
    public partial class frmReturnInvoices : Form
    {
        public frmReturnInvoices()
        {
            InitializeComponent();
        }

        private void frmReturnInvoices_Load(object sender, EventArgs e)
        {
            loadSaleReturnInvoices();
            txtInvoiceSearch.Select();
            txtInvoiceSearch.Focus();
        }
        private void loadSaleReturnInvoices()
        {
            var connectionString = STATICClass.Connection();
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " ";
            if (txtInvoiceSearch.Text == "")
            {
                SqlString = " select SALEPOSNO,TaxAmount,GrossAmount,OtherCharges,NetAmount,AmountReceive,AmountReturn from data_salePosReturnInfo where SalePosReturnDate='" + dtpSaleFromDate.Text + "' ";
            }
            else
            {
                SqlString = " select SalePOSNO,TaxAmount,GrossAmount,OtherCharges,NetAmount,AmountReceive,AmountReturn from data_salePosReturnInfo where SalePosReturnDate='" + dtpSaleFromDate.Text + "' and SalePosNO like '" + txtInvoiceSearch.Text + "%'";
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

        private void dtpSaleFromDate_ValueChanged(object sender, EventArgs e)
        {
            loadSaleReturnInvoices();
        }
    }
}
