using MetroFramework.Forms;
using POS.Helper;
using POS.LookUpForms;
using POS.Report;
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
            if(CompanyInfo.CounterID>0)
            {
                ChechActiveShift();
                btnGenerateClosing.Visible = true;
            }
            if (CompanyInfo.CounterID > 0)
            {
                lblAvaliableBalance.Visible = false;
                label1.Visible = false;
            }

        }
        private void ChechActiveShift()
        {
            var connectionString = STATICClass.Connection();
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " Select ShiftID,ShiftName from PosData_ShiftRecords where  ISNULL(ISCuurentlyRunning,0)=1";
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            if (dt.Rows.Count > 0)
            {
                lblShift.Text = "Shift " + dt.Rows[0]["ShiftName"].ToString() + " is Currently Running ";
                lblShift.Visible = true;
                CompanyInfo.ShiftID = Convert.ToInt32(dt.Rows[0]["ShiftID"].ToString());
              
                btnShiftStart.Visible = true;
            }
            else
            {
                btnShiftStart.Visible = false;
               
                lblShift.Visible = false;
            }

        }
        private void loadCashSource()
        {
            var connectionString = STATICClass.Connection();
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
            var connectionString = STATICClass.Connection();
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string where = "where Date='" + dtCashDate.Value + @"'";
            try
            {
                if (CompanyInfo.CounterID > 0)
                {
                    where += "and CounterID=" + CompanyInfo.CounterID + @"";
                }
                string SqlString = @" select (select isnull(sum(Amount),0) as Amount from data_CashIn " + where + @")
                                  -
                                  (select isnull(sum(Amount),0) as Amount from data_CashOut " + where + @") as Amount
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
            catch (Exception e)
            {

            }
            finally
            {

            }
            cnn.Close();
           
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
            if (CompanyInfo.CounterID <= 0)
            { 
             if (availableBalance < CashOutAmount)
                {
                    txtCashOutAmount.Focus();
                    MessageBox.Show("Not have enough cash!");
                    validateReturnOK = false;
                }
            }
            return validateReturnOK;
        }

        private void SaveForm()
        {
            var connectionString = STATICClass.Connection();
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
            cmd.Parameters.AddWithValue("@CounterID", CompanyInfo.CounterID);
            cmd.Parameters.AddWithValue("@ShiftID", CompanyInfo.ShiftID);
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
        private void CloseShift(int ShiftID)
        {
            var connectionString = STATICClass.Connection();
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            try
            {
                string SqlString = " Update PosData_ShiftRecords Set ISCuurentlyRunning=0,LastExecuted='"+System.DateTime.Now.Date+"'  where  ShiftID=" + ShiftID + "";
                SqlCommand sda = new SqlCommand(SqlString, cnn);
                sda.CommandType = CommandType.Text;
                sda.ExecuteNonQuery();
                ChechActiveShift();
            }
            catch (Exception e)
            {
                MessageBox.Show(e.Message);
            }
            finally
            {

                cnn.Close();

            }
        }
        private void btnShiftStart_Click(object sender, EventArgs e)
        {
            
            DataTable dt = STATICClass.GetActiveShift();
            if (dt.Rows.Count > 0)
            {
                CloseShift(Convert.ToInt32(dt.Rows[0]["ShiftID"]));
            }
            
        }

        private void btnGenerateClosing_Click(object sender, EventArgs e)
        {
            if (CompanyInfo.CounterID > 0)
            {
                var DataTb = STATICClass.GetActiveSessionID();
                if (DataTb.Rows.Count >= 1)
                {
                    using (frmCrystal obj = new frmCrystal())
                    {
                        obj.GenerateClosing(DataTb);
                    }
                }
            }
        }
    }
}
