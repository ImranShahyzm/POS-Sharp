using MetroFramework.Forms;
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
    public partial class frmCashIn : MetroForm
    {
        public frmCashIn()
        {
            InitializeComponent();
            loadCashSource();
            txtCashInAmount.Focus();
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
            cmbCashType.ValueMember = "CashTypeSourceID";
            cmbCashType.DisplayMember = "SourceName";
            cmbCashType.DataSource = dt;
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
            decimal cashInAmount = txtCashInAmount.Text == "" ? 0 : Convert.ToDecimal(txtCashInAmount.Text);
            bool validateReturnOK = true;
            if (cashInAmount == 0)
            {
                txtCashInAmount.Focus();
                MessageBox.Show("Please Enter Cash In Amount!");
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
            cmd.Parameters.AddWithValue("@Amount", txtCashInAmount.Text == "" ? 0 : Convert.ToDecimal(txtCashInAmount.Text));
            cmd.Parameters.AddWithValue("@CashType", true);
            cmd.Parameters.AddWithValue("@SalePosDate", dtCashDate.Value);
            cmd.Parameters.AddWithValue("@Remarks", txtRemarks.Text);
            SqlDataAdapter da = new SqlDataAdapter();
            DataTable dt1 = new DataTable();
            da.SelectCommand = cmd;
            try
            {
                cmd.Transaction = tran; da.Fill(dt1);
                tran.Commit();
                MessageBox.Show("Cash In Successfully Done.");
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
            txtCashInAmount.Text = "";
            txtCashInAmount.Focus();
            cmbCashType.SelectedIndex = 0;
        }

        private void frmCashIn_Load(object sender, EventArgs e)
        {
            txtCashInAmount.Focus();
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

        private void dtCashDate_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                cmbCashType.Select();
                cmbCashType.Focus();
            }
        }

        private void cmbCashType_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                txtCashInAmount.Select();
                txtCashInAmount.Focus();
            }
        }

        private void txtCashInAmount_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                txtRemarks.Select();
                txtRemarks.Focus();
            }
        }

        private void txtRemarks_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                btnSave.Select();
                btnSave.Focus();
            }
        }
    }
}
