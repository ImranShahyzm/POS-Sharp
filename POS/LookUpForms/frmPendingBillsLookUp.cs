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
    public partial class frmPendingBillsLookUp :MetroForm
    {
        public string SaleInvoiceNo { get; set; }
        public int SalePosID { get; set; }
        public decimal BillAmount { get; set; }
        public decimal RiderAmount { get; set; }
        public decimal ActualRiderAmt { get; set; }

        public DateTime SaleInvoiceDate { get; set; }
        public frmPendingBillsLookUp()
        {
            InitializeComponent();
        }

        private void frmPendingBillsLookUp_Load(object sender, EventArgs e)
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

            
            var GrossAmount = new DataGridViewTextBoxColumn();
            GrossAmount.Name = "Customer Name";
            GrossAmount.HeaderText = "CustomerName";
            GrossAmount.Width = 100;

            var OtherCharges = new DataGridViewTextBoxColumn();
            OtherCharges.Name = "Customer Phone";
            OtherCharges.HeaderText = "CustomerPhone";
            OtherCharges.Width = 100;

            var NetAmount = new DataGridViewTextBoxColumn();
            NetAmount.Name = "Bill Amount";
            NetAmount.HeaderText = "TotalBillAmount";
            NetAmount.Width = 100;
            

            dgvSaleInvoices.Columns.Add(ID);
           
            dgvSaleInvoices.Columns.Add(GrossAmount);
            dgvSaleInvoices.Columns.Add(OtherCharges);
            dgvSaleInvoices.Columns.Add(NetAmount);
          
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
            var connectionString = STATICClass.Connection();
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);

            cnn.Open();
            string SqlString = " ";
            if (txtInvoiceSearch.Text=="")
            {
                SqlString = @" select  * from (select Case when data_SalePosInfo.InvoiceType=2 then 'Dining Sale' else 'Credit Sale' end InvoiceSource,data_salePosInfo.SalePOSNo,data_salePosInfo.SalePosDate,data_salePosInfo.CustomerName,data_salePosInfo.CustomerPhone,  (data_salePosInfo.GrossAmount-data_salePosInfo.DiscountTotal+OtherCharges) as TotalBillAmount,
isnull((select sum(b.ReceoverdAmount)  from data_posBillRecoviers b where b.SalePosID =
 data_salePosInfo.SalePosID
),0) as RecoveryAmount,data_salePosInfo.WHID,data_salePosInfo.SalePosID,ISNULL(data_SalePosInfo.RiderAmount,0) as RiderAmount,isnull((select sum(b.RiderAmountRecovery)  from data_posBillRecoviers b where b.SalePosID =
 data_salePosInfo.SalePosID
),0) as RiderAmountRecovery
from data_salePosInfo where data_SalePosInfo.InvoiceType in ( 3,2) and SalePosDate <= '" + dtpSaleFromDate.Text + "') a where (TotalBillAmount+RiderAmount) - (RecoveryAmount+RiderAmountRecovery) > 0 ";
            }
            else
            {
                SqlString = @" select  * from (select Case when data_SalePosInfo.InvoiceType=2 then 'Dining Sale' else 'Credit Sale' end InvoiceSource,data_salePosInfo.SalePOSNo,data_salePosInfo.SalePosDate,data_salePosInfo.CustomerName,data_salePosInfo.CustomerPhone,  (data_salePosInfo.GrossAmount-data_salePosInfo.DiscountTotal+OtherCharges) as TotalBillAmount,
isnull((select sum(b.ReceoverdAmount)  from data_posBillRecoviers b where b.SalePosID =
 data_salePosInfo.SalePosID
),0) as RecoveryAmount,data_salePosInfo.WHID,data_salePosInfo.SalePosID,ISNULL(data_SalePosInfo.RiderAmount,0) as RiderAmount,isnull((select sum(b.RiderAmountRecovery)  from data_posBillRecoviers b where b.SalePosID =
 data_salePosInfo.SalePosID
),0) as RiderAmountRecovery
from data_salePosInfo where data_SalePosInfo.InvoiceType in( 3,2) and SalePosDate <= '" + dtpSaleFromDate.Text + "' and SalePosNO like '" + txtInvoiceSearch.Text + "%') a where (TotalBillAmount+RiderAmount) - (RecoveryAmount+RiderAmountRecovery) > 0 ";
                
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
            int index = dgvSaleInvoices.SelectedRows[0].Index;
            ResultReturn(index);
        }
        private void ResultReturn(int Index)
        {

            if (Index > 0)
            {
                DataGridViewRow dgr = dgvSaleInvoices.Rows[Index];
                SaleInvoiceNo = dgr.Cells["SalePOSNO"].Value.ToString();
                SaleInvoiceDate = dtpSaleFromDate.Value;
                SalePosID = Convert.ToInt32(dgr.Cells["SalePosID"].Value);
                BillAmount = Convert.ToDecimal(dgr.Cells["TotalBillAmount"].Value) - Convert.ToDecimal(dgr.Cells["RecoveryAmount"].Value);
                RiderAmount = Convert.ToDecimal(dgr.Cells["RiderAmount"].Value) - Convert.ToDecimal(dgr.Cells["RiderAmountRecovery"].Value);
                ActualRiderAmt = Convert.ToDecimal(dgr.Cells["RiderAmount"].Value);
                this.DialogResult = DialogResult.OK;
                this.Close();
            }
            else if (Index == 0)
            {
                DataGridViewRow dgr = dgvSaleInvoices.Rows[0];
                SaleInvoiceNo = dgr.Cells["SalePOSNO"].Value.ToString();
                SaleInvoiceDate = dtpSaleFromDate.Value;
                SalePosID = Convert.ToInt32(dgr.Cells["SalePosID"].Value);
                BillAmount = Convert.ToDecimal(dgr.Cells["TotalBillAmount"].Value) - Convert.ToDecimal(dgr.Cells["RecoveryAmount"].Value);
                RiderAmount = Convert.ToDecimal(dgr.Cells["RiderAmount"].Value) - Convert.ToDecimal(dgr.Cells["RiderAmountRecovery"].Value);
                ActualRiderAmt = Convert.ToDecimal(dgr.Cells["RiderAmount"].Value);
                
                this.DialogResult = DialogResult.OK;
                this.Close();
            }
        }


        private void dgvSaleInvoices_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)13)
            {
                

                int index = dgvSaleInvoices.SelectedRows[0].Index;
                ResultReturn(index);

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

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

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
