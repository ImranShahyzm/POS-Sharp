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

namespace POS
{
    public partial class frmCashIn : MetroForm
    {
        public frmCashIn()
        {
            InitializeComponent();
            loadCashSource();
            txtCashInAmount.Focus();
            ChechActiveShift();
        }

        private void loadCashSource()
        {
            var connectionString = STATICClass.Connection();
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
        private void GetShiftList()
        {
            var connectionString = STATICClass.Connection();
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " Select ShiftID,ShiftName from PosData_ShiftRecords where ISNULL(LastExecuted,getDate())!='"+System.DateTime.Now.Date+ "' and ISNULL(ISCuurentlyRunning,0)=0";
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            //cnn.Close();
            cmbShiftName.ValueMember = "ShiftID";
            cmbShiftName.DisplayMember = "ShiftName";
            cmbShiftName.DataSource = dt;
        }
        private void ActivateShift(int ShiftID)
        {
            var connectionString = STATICClass.Connection();
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            try
            {
                string SqlString = " Update PosData_ShiftRecords Set ISCuurentlyRunning=1  where  ShiftID=" + ShiftID + "";
                SqlCommand sda = new SqlCommand(SqlString, cnn);
                sda.CommandType = CommandType.Text;
                sda.ExecuteNonQuery();
                ChechActiveShift();
            }
            catch(Exception e)
            {
                MessageBox.Show(e.Message);
            }finally
            {

                cnn.Close();

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
         if(dt.Rows.Count>0)
            {
                lblShift.Text="Shift "+ dt.Rows[0]["ShiftName"].ToString()+" is Currently Running " ;
                lblShift.Visible = true;
                CompanyInfo.ShiftID = Convert.ToInt32(dt.Rows[0]["ShiftID"].ToString());
                cmbShiftName.Visible = false;
                lblStartShift.Visible = false;
                btnShiftStart.Visible = false;
            }
         else
            {
                GetShiftList();
                cmbShiftName.Visible = true;
                lblStartShift.Visible = true;
                btnShiftStart.Visible = true;
                lblShift.Visible = false;
            }

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
            cmd.Parameters.AddWithValue("@Amount", txtCashInAmount.Text == "" ? 0 : Convert.ToDecimal(txtCashInAmount.Text));
            cmd.Parameters.AddWithValue("@CashType", true);
            cmd.Parameters.AddWithValue("@SalePosDate", dtCashDate.Value);
            cmd.Parameters.AddWithValue("@Remarks", txtRemarks.Text);
            cmd.Parameters.AddWithValue("@CounterID", CompanyInfo.CounterID);
            cmd.Parameters.AddWithValue("@ShiftID", CompanyInfo.ShiftID );
            

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
                MessageBox.Show(ex.Message);
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
            ChechActiveShift();
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

        private void btnShiftStart_Click(object sender, EventArgs e)
        {
            if(Convert.ToInt32(cmbShiftName.SelectedValue)>0)
            {
                ActivateShift(Convert.ToInt32(cmbShiftName.SelectedValue));
            }
        }
    }
}
