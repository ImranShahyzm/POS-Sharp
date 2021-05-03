using MetroFramework.Forms;
using POS.Helper;
using POS.LookUpForms;
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
    public partial class frmCashInAgainstBill : MetroForm
    {
        public frmCashInAgainstBill()
        {
            InitializeComponent();
            clearAll();
        }
        public enum SP
        {
            data_PosBillRecoveries_Insert



        }
        private void loadCashSource()
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " select CashTypeSourceID,SourceName from gen_CashTypeSource where IsForCashIn=1";
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            //cmbCashType.ValueMember = "CashTypeSourceID";
            //cmbCashType.DisplayMember = "SourceName";
            //cmbCashType.DataSource = dt;
        }
        
        private void btnSave_Click(object sender, EventArgs e)
        {
            if (validateSave())
            {
                SaveForm();
            }
        }
        private bool validateSave()
        {
            decimal cashInAmount = txtRecoverdAmount.Text == "" ? 0 : Convert.ToDecimal(txtRecoverdAmount.Text);
            bool validateReturnOK = true;
            if (cashInAmount == 0)
            {
                txtRecoverdAmount.Focus();
                MessageBox.Show("Please Enter Cash In Amount!");
                validateReturnOK = false;
            }
            return validateReturnOK;
        }

        private void SaveForm()
        {

            int recoveryID = 0;
            SqlParameter p = new SqlParameter("@RecoveryID", recoveryID);
            p.Direction = ParameterDirection.InputOutput;
            List<SqlParameter> ParamList = new List<SqlParameter>();
            ParamList.Add(p);

            ParamList.Add(new SqlParameter("@RecoverdBy", CompanyInfo.UserID));
            ParamList.Add(new SqlParameter("@RecoveryDate", Convert.ToDateTime(dtRecoveryDate.Value)));
            ParamList.Add(new SqlParameter("@ReceoverdAmount", Convert.ToDecimal(txtRecoverdAmount.Text)));
            ParamList.Add(new SqlParameter("@CompanyID", CompanyInfo.CompanyID));
            ParamList.Add(new SqlParameter("@BranchID", CompanyInfo.BranchID));
            ParamList.Add(new SqlParameter("@SalePosID", Convert.ToInt32(txtSaleID.Text)));
            ParamList.Add(new SqlParameter("@WHID", CompanyInfo.WareHouseID));
            try
            {
                DataTable ret = STATICClass.ExecuteInsert(SP.data_PosBillRecoveries_Insert.ToString()
                    , ParamList);
                if (ret.Columns.Contains("RecoveryID"))
                {
                    var RecoveryID = Convert.ToInt32(ret.Rows[0]["RecoveryID"].ToString());
                }
            }catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
                return;
            }
            clearAll();
        }

        private void clearAll()
        {
            txtCashInAmount.Text = "";
            
            txtBillNo.Clear();
            txtSaleID.Clear();
            txtRecoverdAmount.Clear();
            txtCashInAmount.Clear();
            txtBillNo.Select();
            txtBillNo.Focus();


        }

        private void frmCashInAgainstBill_Load(object sender, EventArgs e)
        {
            //txtBillNo.Focus();
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            clearAll();
        }
        protected override bool ProcessCmdKey(ref Message msg, Keys keyData)
        {
            if (keyData == (Keys.Alt | Keys.S))
            {
                if (validateSave())
                {
                    SaveForm();
                }
                return true;
            }
            else if (keyData == (Keys.Alt | Keys.N))
            {
                clearAll();
                return true;
            }
            return base.ProcessCmdKey(ref msg, keyData);
        }

        private void txtCashInAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!(Char.IsDigit(e.KeyChar) || (e.KeyChar == (char)Keys.Back)))
                e.Handled = true;
        }

        private void txtCashInAmount_TextChanged(object sender, EventArgs e)
        {

        }

        private void dtCashDate_ValueChanged(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void txtBillNo_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyData == Keys.Enter)
            {

                if (txtBillNo.Text != "" || (txtBillNo.Text == "" ? 0 : Convert.ToInt64(txtBillNo.Text)) != 0)
                {
                    clearAll();
                    string InvoiceNo = txtBillNo.Text;
                    //loadWholeInvoice(InvoiceNo);
                }
                else
                {
                    using (frmPendingBillsLookUp obj = new frmPendingBillsLookUp())
                    {
                        if (obj.ShowDialog() == DialogResult.OK)
                        {
                            string id = obj.SaleInvoiceNo;
                            if (id != "")
                            {
                                clearAll();
                                dtCashDate.Value = obj.SaleInvoiceDate;

                                //loadWholeInvoice(id);
                                txtSaleID.Text = obj.SalePosID.ToString();

                                txtBillNo.Text = obj.SaleInvoiceNo;
                                txtCashInAmount.Text = Convert.ToString(obj.BillAmount);
                                txtRecoverdAmount.Focus();
                                
                            }
                        }
                    };
                    //MessageBox.Show("Please Enter Invoice Number!");
                }
            }
        }

        private void txtRecoverdAmount_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                if (txtRecoverdAmount.Text != "")
                {
                    btnSave.Focus();
                }
            }
        }
    }
}
