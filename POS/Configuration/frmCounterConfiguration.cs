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
    public partial class frmCounterConfiguration : MetroForm
    {
        public frmCounterConfiguration()
        {
            InitializeComponent();
            clearAll();
            
            loadConfiguration();
            EnableFields();
        }
        public enum SP
        {
          
        }
        private void loadPosStyles()
        {
            cmbPosStyle.DisplayMember = "Text";
            cmbPosStyle.ValueMember = "Value";

            var PosStyleList = new[] {
                new { Text = "-- Please Select --", Value = "" },
                new { Text = "Ch Sweats Style", Value = "POSChSweets" },
    new { Text = "PC World Style", Value = "POSPcWorldStyle" },
    new { Text = "Cresent Style", Value = "CrescentStyle" },
    new { Text = "Oman Mobile Style", Value = "OmanMobileStyle" },
    new { Text = "Default Style", Value = "Default" }
};

            cmbPosStyle.DataSource = PosStyleList;

        }
        private void loadOpeningCashSource()
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
            cmbTranscation.ValueMember = "CashTypeSourceID";
            cmbTranscation.DisplayMember = "SourceName";
            cmbTranscation.DataSource = dt;
        }
        private void loadClosingCashSource()
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
            cmbClosingSource.ValueMember = "CashTypeSourceID";
            cmbClosingSource.DisplayMember = "SourceName";
            cmbClosingSource.DataSource = dt;
        }
        private void LoadRevenueCashCombo()
        {



            var connectionString = STATICClass.Connection();
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = "Select * from GLChartOFAccount where GLNature=0 and [ReadOnly]=0 and (GLCode Not like '50%') and CompanyID="+CompanyInfo.CompanyID+"";
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            DataRow dr = dt.NewRow();
            dr[0] = "0";
            dr[2] = "--Select Accounting Head--";
            dt.Rows.InsertAt(dr, 0);

            cmbRevenueAccount.ValueMember = "GLCAID";
            cmbRevenueAccount.DisplayMember = "GLTitle";
            cmbRevenueAccount.DataSource = dt;
            LoadCashCombo();
        }
        private void LoadCashCombo()
        {



            var connectionString = STATICClass.Connection();
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = "Select * from GLChartOFAccount where GLNature=0 and [ReadOnly]=0 and (GLCode Not like '50%') and CompanyID=" + CompanyInfo.CompanyID + "";
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            DataRow dr = dt.NewRow();
            dr[0] = "0";
            dr[2] = "--Select Accounting Head--";
            dt.Rows.InsertAt(dr, 0);

            cmbCashAccount.ValueMember = "GLCAID";
            cmbCashAccount.DisplayMember = "GLTitle";
            cmbCashAccount.DataSource = dt;

        }


        private void loadConfiguration()
        {
            try
            {
                loadClosingCashSource();
                loadOpeningCashSource();
                loadPosStyles();
                LoadRevenueCashCombo();

                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                DataTable dtdetail = new DataTable();
                var connectionString = STATICClass.Connection();
                SqlConnection con = new SqlConnection(connectionString);
                SqlTransaction tran;
                con.Open();
                tran = con.BeginTransaction();
                SqlCommand cmd = new SqlCommand("gen_posConfiguration_SelectAll", con);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter da = new SqlDataAdapter();

                string whereclause = "  and gen_PosConfiguration.CounterID=" + Convert.ToInt32(CompanyInfo.CounterID) + "";

                cmd.Parameters.AddWithValue("@CounterID", Convert.ToInt32(CompanyInfo.CounterID));
                cmd.Parameters.AddWithValue("@WhereClause", whereclause);
                da.SelectCommand = cmd;
                try
                {
                    cmd.Transaction = tran;
                    da.Fill(ds);
                    tran.Commit();
                    dt = ds.Tables[0];
                }
                catch (Exception ex)
                {
                    tran.Rollback();
                    MessageBox.Show(ex.Message);
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }

                if (dt.Rows.Count > 0)
                {

                    lblCompanyName.Text = Convert.ToString(dt.Rows[0]["Title"]);
                    txtConfigID.Text = Convert.ToString(dt.Rows[0]["ConfigID"]);
                    txtCounterID.Text = Convert.ToString(dt.Rows[0]["CounterID"]);
                    txtCounterTitle.Text = Convert.ToString(dt.Rows[0]["CounterTitle"]);
                    cmbRevenueAccount.SelectedValue = Convert.ToString(dt.Rows[0]["RevenueAccountPOS"])==""?"0": Convert.ToString(dt.Rows[0]["RevenueAccountPOS"]);
                    cmbCashAccount.SelectedValue = Convert.ToString(dt.Rows[0]["CashAccountPos"]) == "" ? "0" : Convert.ToString(dt.Rows[0]["CashAccountPos"]); 
                    cmbPosStyle.SelectedValue = Convert.ToString(dt.Rows[0]["POSStyle"]);
                    cmbTranscation.SelectedValue = Convert.ToString(dt.Rows[0]["OpeningSourceID"]);
                    cmbClosingSource.SelectedValue = Convert.ToString(dt.Rows[0]["ClosingSourceID"]);

                    txtNoOfInvoicePrint.Text = Convert.ToString(dt.Rows[0]["NoOfInvoicePrint"]);
                    txtBillPrefix.Text = Convert.ToString(dt.Rows[0]["BillPreFix"]);
                    txtFbrPOSID.Text = Convert.ToString(dt.Rows[0]["POSID"]);
                    txtApiAddress.Text = Convert.ToString(dt.Rows[0]["ApiIpAddress"]);
                    var isOfflineserver = dt.Rows[0]["IsofflineServer"];
                    if (isOfflineserver is DBNull)
                    {
                        cbxISServerOffline.Checked = false;
                    }
                    else
                    {
                        cbxISServerOffline.Checked = Convert.ToBoolean(isOfflineserver);
                    }
                    var isFbrConnectivty = dt.Rows[0]["ISFbrConnectivity"];
                    if (isFbrConnectivty is DBNull)
                    {
                        cbxIsFbrConnected.Checked = false;
                    }
                    else
                    {
                        cbxIsFbrConnected.Checked = Convert.ToBoolean(isFbrConnectivty);
                    }

                    var IsSessionHandling = dt.Rows[0]["IsSessionHandling"];
                    if (IsSessionHandling is DBNull)
                    {
                        chkIsSessionhandle.Checked = false;
                    }
                    else
                    {
                        chkIsSessionhandle.Checked = Convert.ToBoolean(IsSessionHandling);
                    }

                    var EncryptedDateExpiry= Convert.ToString(dt.Rows[0]["SystemColumnDt"]);
                    string DecryptExpiryDate = STATICClass.Decrypt(EncryptedDateExpiry, STATICClass.ExpiryDateKey);
                    if(DecryptExpiryDate!="No")
                    {
                        txtExpiryDate.Value = Convert.ToDateTime(DecryptExpiryDate);
                    }
                    else
                    {
                        txtExpiryDate.Value = txtExpiryDate.MinDate;
                    }

                }
                else
                {


                }
            }catch(Exception e)
            {
                MessageBox.Show(e.Message);
            }
        }

        private void EnableFields()
        {

            if(Convert.ToInt32(cmbRevenueAccount.SelectedValue)<=0)
            {
                cmbRevenueAccount.Enabled = true;
            }
            else
            {
                cmbRevenueAccount.Enabled = false;
            }
            if (Convert.ToInt32(cmbCashAccount.SelectedValue) <= 0)
            {
                cmbCashAccount.Enabled = true;
            }
            else
            {
                cmbCashAccount.Enabled = false;
            }
            if (Convert.ToString(cmbPosStyle.SelectedValue)=="-- Please Select --")
            {
                cmbPosStyle.Enabled = true;
            }
            else
            {
                cmbPosStyle.Enabled = false;
            }
            if (Convert.ToInt32(cmbTranscation.SelectedValue) <= 0)
            {
                cmbTranscation.Enabled = true;
            }
            else
            {
                cmbTranscation.Enabled = false;
            }
            if (Convert.ToInt32(cmbClosingSource.SelectedValue) <= 0)
            {
                cmbClosingSource.Enabled = true;
            }
            else
            {
                cmbClosingSource.Enabled = false;
            }

            txtFbrPOSID.Enabled = false;
            lblFbrPOSID.Visible = false;
            lblIpApi.Visible = false;
            lblServerOffline.Visible = false;
            lblFbrPOSID.Visible = false;
            lblFbrConnected.Visible = false;
            txtApiAddress.Enabled = false;

            lblSessionhandling.Visible = false;
            lblDateExpiry.Visible = false;
            chkIsSessionhandle.Visible = false;
            txtExpiryDate.Visible = false;

            txtFbrPOSID.Visible = false;
            txtApiAddress.Visible = false;

            cbxIsFbrConnected.Visible = false;
            cbxISServerOffline.Visible = false;

        }

        private void ValidatePassword()
        {
            if (Convert.ToString(txtManualPasswordField.Text) == STATICClass.ConfigurationPassword)
            {

                
                cmbRevenueAccount.Enabled = true;
                cmbCashAccount.Enabled = true;
                cmbPosStyle.Enabled = true;
                cmbTranscation.Enabled = true;
                cmbClosingSource.Enabled = true;

                txtFbrPOSID.Enabled = true;
                txtApiAddress.Enabled = true;
                txtFbrPOSID.Visible = true;
                txtApiAddress.Visible = true;
                cbxIsFbrConnected.Visible = true;
                cbxISServerOffline.Visible = true;


                lblFbrPOSID.Visible = true;
                lblIpApi.Visible = true;
                lblServerOffline.Visible = true;
                lblFbrPOSID.Visible = true;
                lblFbrConnected.Visible = true;

                lblSessionhandling.Visible = true;
                lblDateExpiry.Visible = true;
                chkIsSessionhandle.Visible = true;
                txtExpiryDate.Visible = true;

            }
            else
            {
                MessageBox.Show("Password is Not Correct...");
                return;
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

            bool validateReturnOK = true;
            if (string.IsNullOrEmpty(txtCounterTitle.Text))
            {
                txtCounterTitle.Select();
                txtCounterTitle.Focus();
                MessageBox.Show("Please Enter Counter Name....!");
                validateReturnOK = false;
            }
            if (Convert.ToString(cmbPosStyle.SelectedValue)== "-- Please Select --")
            {
                cmbPosStyle.Select();
                cmbPosStyle.Focus();
                MessageBox.Show("Please Select Point OF Sale Style....!");
                validateReturnOK = false;
            }
            if (Convert.ToInt32(cmbRevenueAccount.SelectedValue) == 0)
            {

                cmbRevenueAccount.Select();
                cmbRevenueAccount.Focus();
                MessageBox.Show("Revenue Account for Point of Sale is not Selected....!");
                validateReturnOK = false;
            }
            if (Convert.ToInt32(cmbTranscation.SelectedValue) == 0)
            {
                cmbTranscation.Select();
                cmbTranscation.Focus();
                MessageBox.Show("Opening Source Type is not Selected....!");
                validateReturnOK = false;
            }
            if (Convert.ToInt32(cmbClosingSource.SelectedValue) == 0)
            {
                cmbClosingSource.Select();
                cmbClosingSource.Focus();
                MessageBox.Show("Closing Source Type is not Selected....!");
                validateReturnOK = false;
            }
            if (Convert.ToInt32(cmbCashAccount.SelectedValue) == 0)
            {
                cmbCashAccount.Select();
                cmbCashAccount.Focus();
                MessageBox.Show("Cash Account for Point of Sale is not Selected....!");
                validateReturnOK = false;
            }

            if (Convert.ToBoolean(cbxISServerOffline.Checked) == true && string.IsNullOrEmpty(txtApiAddress.Text))
            {
                txtApiAddress.Select();
                txtApiAddress.Focus();
                MessageBox.Show("Ip Address Can't be Empty for Online Server....!");
                validateReturnOK = false;
            }
            if (Convert.ToBoolean(cbxIsFbrConnected.Checked) == true && string.IsNullOrEmpty(txtFbrPOSID.Text))
            {
                txtApiAddress.Select();
                txtApiAddress.Focus();
                MessageBox.Show("FBR POS ID  Can't be Empty for Fbr Connection....!");
                validateReturnOK = false;
            }


            return validateReturnOK;
        }

    
        private void SaveForm()
        {

            string EncryptDateExpiry = "";
            if(txtExpiryDate.Value!=txtExpiryDate.MinDate)
            {
                EncryptDateExpiry = STATICClass.Encrypt(Convert.ToString(txtExpiryDate.Value), STATICClass.ExpiryDateKey);
            }
            else
            {
                EncryptDateExpiry = STATICClass.Encrypt("No", STATICClass.ExpiryDateKey);
            }

            int ConfigID = Convert.ToInt32(txtConfigID.Text);
           
            DataTable dt = new DataTable();
            var connectionString = STATICClass.Connection();
            SqlConnection con = new SqlConnection(connectionString);
            SqlTransaction tran;
            con.Open();
            tran = con.BeginTransaction();
            SqlCommand cmd;
            cmd = new SqlCommand("gen_PosConfiguration_Insert", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter();
            SqlParameter p = new SqlParameter("ConfigID", ConfigID);
            p.Direction = ParameterDirection.InputOutput;
            cmd.Parameters.Add(p);
            cmd.Parameters.AddWithValue("@CounterTitle", Convert.ToString(txtCounterTitle.Text));
            cmd.Parameters.AddWithValue("@RevenueAccountPOS", Convert.ToInt32(cmbRevenueAccount.SelectedValue));
            cmd.Parameters.AddWithValue("@CashAccountPos", Convert.ToInt32(cmbCashAccount.SelectedValue));
            cmd.Parameters.AddWithValue("@POSStyle", Convert.ToString(cmbPosStyle.SelectedValue));
            if (cbxISServerOffline.Checked)
            {
                cmd.Parameters.AddWithValue("@IsofflineServer",1);
            }
            else
            {
                cmd.Parameters.AddWithValue("@IsofflineServer", 0);
            }
            if (cbxIsFbrConnected.Checked)
            {
                cmd.Parameters.AddWithValue("@ISFbrConnectivity", 1);
            }
            else
            {
                cmd.Parameters.AddWithValue("@ISFbrConnectivity", 0);
            }
            if (chkIsSessionhandle.Checked)
            {
                cmd.Parameters.AddWithValue("@IsSessionHandling", 1);
            }
            else
            {
                cmd.Parameters.AddWithValue("@IsSessionHandling", 0);
            }
            cmd.Parameters.AddWithValue("@ClosingSourceID", Convert.ToInt32(cmbClosingSource.SelectedValue));
            cmd.Parameters.AddWithValue("@OpeningSourceID", Convert.ToInt32(cmbTranscation.SelectedValue));
            cmd.Parameters.AddWithValue("@ApiIpAddress", Convert.ToString(txtApiAddress.Text));
            cmd.Parameters.AddWithValue("@POSID", Convert.ToString(txtFbrPOSID.Text));
            cmd.Parameters.AddWithValue("@NoOfInvoicePrint", Convert.ToString(txtNoOfInvoicePrint.Text));
            cmd.Parameters.AddWithValue("@BillPreFix", Convert.ToString(txtBillPrefix.Text));
            cmd.Parameters.AddWithValue("@SystemColumnDt", EncryptDateExpiry);

            da.SelectCommand = cmd;
            try
            {
                cmd.Transaction = tran;
                da.Fill(dt);
                tran.Commit();


            }
            catch (Exception e)
            {
                MessageBox.Show(e.Message.ToString());
                tran.Rollback();
            }
            finally
            {
                con.Close();
            }
           

          
              
          
            clearAll();
        }

        private void clearAll()
        {

            txtManualPasswordField.Clear();
            EnableFields();

        }

        private void frmCounterConfiguration_Load(object sender, EventArgs e)
        {
            //txtBillNo.Focus();
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            clearAll();
            this.Close();
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

     

      

        private void txtRiderRecovery_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
               
                    btnSave.Select();
                    btnSave.Focus();
                
            }
        }

        
        

        private void txtManualPasswordField_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                ValidatePassword();
                txtCounterTitle.Select();
                txtCounterTitle.Focus();
            }
        }

        private void txtNoOfInvoicePrint_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar) && e.KeyChar != '.')
            {

                e.Handled = true;

            }


            if (e.KeyChar == '.' && (sender as TextBox).Text.IndexOf('.') > -1)
            {


                e.Handled = true;
            }
        }

        private void txtCounterTitle_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                if(cmbRevenueAccount.Enabled)
                {
                    cmbRevenueAccount.Select();
                    cmbRevenueAccount.Focus();
                }
                else
                {
                    txtNoOfInvoicePrint.Select();
                    txtNoOfInvoicePrint.Focus();
                }
            }
        }

        private void cmbRevenueAccount_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                if (cmbCashAccount.Enabled)
                {
                    cmbCashAccount.Select();
                    cmbCashAccount.Focus();
                }
                else
                {
                    txtNoOfInvoicePrint.Select();
                    txtNoOfInvoicePrint.Focus();
                }
            }
        }

        private void cmbCashAccount_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                if (cmbCashAccount.Enabled)
                {
                    cmbPosStyle.Select();
                    cmbPosStyle.Focus();
                }
                else
                {
                    txtNoOfInvoicePrint.Select();
                    txtNoOfInvoicePrint.Focus();
                }
            }
        }

        private void cmbPosStyle_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                if (cmbTranscation.Enabled)
                {
                    cmbTranscation.Select();
                    cmbTranscation.Focus();
                }
                else
                {
                    txtNoOfInvoicePrint.Select();
                    txtNoOfInvoicePrint.Focus();
                }
            }
        }

        private void cmbTranscation_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                if (cmbClosingSource.Enabled)
                {
                    cmbClosingSource.Select();
                    cmbClosingSource.Focus();
                }
                else
                {
                    txtNoOfInvoicePrint.Select();
                    txtNoOfInvoicePrint.Focus();
                }
            }
        }

        private void cmbClosingSource_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
               
                    txtNoOfInvoicePrint.Select();
                    txtNoOfInvoicePrint.Focus();
                
            }
        }

        private void txtNoOfInvoicePrint_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {

                txtBillPrefix.Select();
                txtBillPrefix.Focus();

            }
        }

        private void txtBillPrefix_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                if (cbxISServerOffline.Visible)
                {
                    cbxISServerOffline.Select();
                    cbxISServerOffline.Focus();
                }
                else
                {
                    btnSave.Select();
                    btnSave.Focus();
                }
            }
        }

        private void cbxISServerOffline_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                if (cbxIsFbrConnected.Visible)
                {
                    cbxIsFbrConnected.Select();
                    cbxIsFbrConnected.Focus();
                }
                else
                {
                    btnSave.Select();
                    btnSave.Focus();
                }
            }
        }

        private void cbxIsFbrConnected_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                if (txtFbrPOSID.Visible)
                {
                    txtFbrPOSID.Select();
                    txtFbrPOSID.Focus();
                }
                else
                {
                    btnSave.Select();
                    btnSave.Focus();
                }
            }
        }

        private void txtFbrPOSID_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                if (txtApiAddress.Visible)
                {
                    txtApiAddress.Select();
                    txtApiAddress.Focus();
                }
                else
                {
                    btnSave.Select();
                    btnSave.Focus();
                }
            }
        }

        private void txtApiAddress_KeyDown(object sender, KeyEventArgs e)
        {

            if (e.KeyCode == Keys.Enter)
            {
              
                
                    btnSave.Select();
                    btnSave.Focus();
                
            }
        }
    }
}
