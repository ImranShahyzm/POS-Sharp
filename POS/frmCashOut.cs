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
    public partial class frmCashOut : MetroForm
    {
        public frmCashOut()
        {
            InitializeComponent();
            loadAvaliableBalance();
            loadCashSource();
            txtCashOutAmount.Focus();
        }

        private void loadCashSource()
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " select CashTypeSourceID,SourceName from gen_CashTypeSource where IsForCashOut=1";
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            cmbCashType.ValueMember = "CashTypeSourceID";
            cmbCashType.DisplayMember = "SourceName";
            cmbCashType.DataSource = dt;
        }
        private void loadAvaliableBalance()
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = @" select (select isnull(sum(Amount),0) as Amount from data_CashIn where Date='" + dtCashDate.Value + @"')
                                  -
                                  (select isnull(sum(Amount),0) as Amount from data_CashOut where Date='" + dtCashDate.Value + @"') as Amount
                            ";
            if (CompanyInfo.isKhaakiSoft)
            {
                SqlString = @" select (select isnull(sum(Amount),0) as Amount from data_CashIn where Date<='" + dtCashDate.Value + @"')
                                  -
                                  (select isnull(sum(Amount),0) as Amount from data_CashOut where Date<='" + dtCashDate.Value + @"') as Amount
                            ";
            }
             
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            lblAvaliableBalance.Text = dt.Rows[0]["Amount"].ToString();
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
            decimal CashOutAmount = txtCashOutAmount.Text == "" ? 0 : Convert.ToDecimal(txtCashOutAmount.Text);
            decimal availableBalance = lblAvaliableBalance.Text == "" ? 0 : Convert.ToDecimal(lblAvaliableBalance.Text);
            bool validateReturnOK = true;
            if (CashOutAmount == 0)
            {
                txtCashOutAmount.Focus();
                MessageBox.Show("Please Enter Cash Out Amount!");
                validateReturnOK = false;
            }
            else if (availableBalance < CashOutAmount)
            {
                txtCashOutAmount.Focus();
                MessageBox.Show("Not have enough cash!");
                validateReturnOK = false;
            }
            return validateReturnOK;
        }

        private void SaveForm()
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            SqlTransaction tran;
            con.Open();
            tran = con.BeginTransaction();
            SqlCommand cmd;
            cmd = new SqlCommand("data_Cash_Insert", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@SourceID", cmbCashType.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@SourceName", cmbCashType.Text);
            cmd.Parameters.AddWithValue("@Amount", txtCashOutAmount.Text == "" ? 0 : Convert.ToDecimal(txtCashOutAmount.Text));
            cmd.Parameters.AddWithValue("@CashType", false);
            cmd.Parameters.AddWithValue("@SalePosDate", dtCashDate.Value);
            cmd.Parameters.AddWithValue("@CompanyID", CompanyInfo.CompanyID);
            cmd.Parameters.AddWithValue("@FiscalID", CompanyInfo.FiscalID);
            cmd.Parameters.AddWithValue("@UserID", CompanyInfo.UserID);
            cmd.Parameters.AddWithValue("@Remarks", txtRemarks.Text);
            
            SqlDataAdapter da = new SqlDataAdapter();
            DataTable dt1 = new DataTable();
            da.SelectCommand = cmd;
            try
            {
                cmd.Transaction = tran;
                da.Fill(dt1);
                tran.Commit();
                MessageBox.Show("Cash Out Successfully Done.");
                this.Close();
            }
            catch (Exception ex)
            {
                tran.Rollback();
                MessageBox.Show("Error is" + ex.Message);
            }
            finally
            {
                con.Close();
            }
        }

        private void clearAll()
        {
            txtCashOutAmount.Text = "";
            txtCashOutAmount.Focus();
            cmbCashType.SelectedIndex = 0;
        }

        private void frmCashOut_Load(object sender, EventArgs e)
        {
            txtCashOutAmount.Focus();
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

        private void txtCashOutAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!(Char.IsDigit(e.KeyChar) || (e.KeyChar == (char)Keys.Back)))
                e.Handled = true;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            frmClosingLookUp frm = new frmClosingLookUp();
            frm.Show();
        }

        private void dtCashDate_ValueChanged(object sender, EventArgs e)
        {
            if(CompanyInfo.isKhaakiSoft)
            {
                if(dtCashDate.Value.Date<System.DateTime.Now.Date)
                {
                    dtCashDate.Value = System.DateTime.Now;
                }

            }

                loadAvaliableBalance();
            
        }

        private void cmbCashType_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                txtCashOutAmount.Select();
                txtCashOutAmount.Focus();
            }
        }

        private void txtCashOutAmount_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                txtRemarks.Select();
                txtRemarks.Focus();
            }
        }

        private void txtRemarks_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                dtCashDate.Select();
                dtCashDate.Focus();
            }
        }

        private void dtCashDate_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                btnSave.Select();
                btnSave.Focus();
            }
        }
    }
}
