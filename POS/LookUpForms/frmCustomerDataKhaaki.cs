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
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace POS
{
    public partial class frmCustomerDataKhaaki : MetroForm
    {
        public frmCustomerDataKhaaki()
        {
            InitializeComponent();
            LoadCType();
            GetRegistraionNo();
            clearAll();
           
        }
        public enum SP
        {
            PosData_tblCustomerData_Insert



        }
        public void GetRegistraionNo()
        {
            int SaleVoucherNo = GetVoucherNoContinuos(Fieldname: "RNo", TableName: "tblPos_CustomerData", CheckTaxable: false,
                  PrimaryKeyValue: 0, PrimaryKeyFieldName: "CustomerID", voucherDate: Convert.ToDateTime(dtRegisterDate.Value.Date), voucherDateFieldName: "RegisterDate",
                  companyID: CompanyInfo.CompanyID, FiscalID: CompanyInfo.FiscalID);
            txtRno.Text = Convert.ToString(SaleVoucherNo);
            txtCustname.Select();
            txtCustname.Focus();
            txtRno.ReadOnly = true;
        }
        public Int32 GetVoucherNoContinuos(string Fieldname, string TableName, bool CheckTaxable, Int32 PrimaryKeyValue,
     string PrimaryKeyFieldName, DateTime? voucherDate, string voucherDateFieldName = "",
     Int32 companyID = 0, string companyFieldName = "CompanyID", Int32 FiscalID = 0,
     string FiscalIDFieldName = "FiscalID", bool IsTaxable = false)
        {
            var connectionString = STATICClass.Connection();
            try
            {
                DataTable dt = new DataTable();
                SqlConnection con = new SqlConnection(connectionString);
                SqlCommand cmd = new SqlCommand("GetVoucherNoS", con);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter da = new SqlDataAdapter();
                cmd.Parameters.Add(new SqlParameter("@Fieldname", Fieldname));
                cmd.Parameters.Add(new SqlParameter("@TableName", TableName));
                cmd.Parameters.Add(new SqlParameter("@CheckTaxable", CheckTaxable));
                cmd.Parameters.Add(new SqlParameter("@PrimaryKeyValue", PrimaryKeyValue));
                cmd.Parameters.Add(new SqlParameter("@PrimaryKeyFieldName", PrimaryKeyFieldName));
                cmd.Parameters.Add(new SqlParameter("@voucherDate", voucherDate));
                cmd.Parameters.Add(new SqlParameter("@voucherDateFieldName", voucherDateFieldName));
                cmd.Parameters.Add(new SqlParameter("@companyID", companyID));
                cmd.Parameters.Add(new SqlParameter("@companyFieldName", companyFieldName));
                cmd.Parameters.Add(new SqlParameter("@FiscalID", FiscalID));
                cmd.Parameters.Add(new SqlParameter("@FiscalIDFieldName", FiscalIDFieldName));
                cmd.Parameters.Add(new SqlParameter("@IsTaxable", IsTaxable));
                da.SelectCommand = cmd;
                da.Fill(dt);
                return Convert.ToInt32(dt.Rows[0][0]);
            }
            catch (Exception ex)
            {

                throw;
            }

        }

        public void LoadCType()
        {
            cmbGender.DisplayMember = "Text";
            cmbGender.ValueMember = "Value";

            var items = new[] {
    new { Text = "Male", Value = "1" },
    new { Text = "Female", Value = "2" }
    
};

            cmbGender.DataSource = items;

            hideFemaleOptions();
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
            //cmbCashType.ValueMember = "CashTypeSourceID";
            //cmbCashType.DisplayMember = "SourceName";
            //cmbCashType.DataSource = dt;
        }
        
        private void btnSave_Click(object sender, EventArgs e)
        {
            if (validateSave())
            {
                string message = "Do you want to Save the Data?";
                string title = "Close Window";
                MessageBoxButtons buttons = MessageBoxButtons.YesNo;
                DialogResult result = MessageBox.Show(message, title, buttons);
                if (result == DialogResult.Yes)
                {
                    SaveForm();
                }
                else
                {
                    btnSave.Enabled = false;
                }
            }
        }
        private void LoadCustomerData(string CustomerID)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataTable dtdetail = new DataTable();
            var connectionString = STATICClass.Connection();
            SqlConnection con = new SqlConnection(connectionString);
            SqlTransaction tran;
            con.Open();
            tran = con.BeginTransaction();
            SqlCommand cmd = new SqlCommand("PosData_tblCustomerData_SelectAll", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter();

            string whereclause = " where CustomerID=" + CustomerID + " and WHID=" + CompanyInfo.WareHouseID + "";
            cmd.Parameters.AddWithValue("@SelectMaster", 1);
            cmd.Parameters.AddWithValue("@WhereClause", whereclause);
            
            da.SelectCommand = cmd;
            try
            {
                cmd.Transaction = tran; da.Fill(ds);
                dt = ds.Tables[0];
               
                tran.Commit();
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

            if (dt.Rows.Count > 0)
            {
              
             
                txtRno.Text = Convert.ToString(dt.Rows[0]["Rno"]);
                txtCustname.Text = Convert.ToString(dt.Rows[0]["CName"]);  
                txtPhone.Text=Convert.ToString(dt.Rows[0]["CPhone"]);      
                txtAddress.Text=Convert.ToString(dt.Rows[0]["Address"]);
                txtCity.Text=Convert.ToString(dt.Rows[0]["CityName"]);
                cmbGender.SelectedValue=Convert.ToString(dt.Rows[0]["Gender"]);
                    
                txtCnic.Text=Convert.ToString(dt.Rows[0]["CNIC"]);        
                txtNeck.Text=Convert.ToString(dt.Rows[0]["Neck"]);
                txtFrontNeck.Text=Convert.ToString(dt.Rows[0]["FFrontNeck"]);
                txtBackNeck.Text=Convert.ToString(dt.Rows[0]["FBackNeck"]);
                txtShoulder.Text=Convert.ToString(dt.Rows[0]["Shoulder"]);
                txtUperBust.Text=Convert.ToString(dt.Rows[0]["FUpperBust"]);
                txtBust.Text=Convert.ToString(dt.Rows[0]["Bust"]);
                txtUnderBust.Text=Convert.ToString(dt.Rows[0]["FUnderBust"]);
                txtArmHole.Text=Convert.ToString(dt.Rows[0]["ArmHole"]);
                txtSleeve.Text=Convert.ToString(dt.Rows[0]["SleeveLength"]);
                txtMuscle.Text=Convert.ToString(dt.Rows[0]["Muscle"]);
                txtElbow.Text=Convert.ToString(dt.Rows[0]["Elbow"]);
                txtCuff.Text=Convert.ToString(dt.Rows[0]["Cuff"]);
                txtWaist.Text=Convert.ToString(dt.Rows[0]["Waist"]);
                txthip.Text=Convert.ToString(dt.Rows[0]["Hip"]);
                txtBottomLength.Text=Convert.ToString(dt.Rows[0]["BottomLength"]);
                txtAnkle.Text=Convert.ToString(dt.Rows[0]["Ankle"]);
                txtRemarks.Text=Convert.ToString(dt.Rows[0]["Remarks"]);
                txtProfession.Text = Convert.ToString(dt.Rows[0]["Profession"]);

                txtRno.ReadOnly = true;
                txtCustname.Select();
                txtCustname.Focus();






            }
            else
            {
                MessageBox.Show("We have no Customer  regarding this No!");
            }
        }
        private bool validateSave()
        {

            btnSave.Enabled = false;
            if (string.IsNullOrEmpty(txtCustname.Text) && string.IsNullOrEmpty(txtPhone.Text))
            {
                MessageBox.Show("Customer Name and Phone # are Required Please Add them...");

                btnSave.Enabled = true;
                return false;
            }
            else
            {
                if((txtPhone.Text.Length>11 || txtPhone.Text.Length < 11))
                {
                    MessageBox.Show("Please Enter Correct Phone No....");
                    txtPhone.Select();
                    txtPhone.Focus();
                    btnSave.Enabled = true;
                    return false;
                }
                else if(CheckPhoneNo(txtPhone.Text))
                {
                    MessageBox.Show("Another Customer with Same Phone Number is Already Registerd...!!!");
                    txtPhone.Select();
                    txtPhone.Focus();
                    btnSave.Enabled = true;
                    return false;
                }

                return true;
            }
            
            
        }

        public  bool IsPhoneNumber(string number)
        {
            var abc = Regex.Match(number, @"^(\+[0-9]{11})$");
            return Regex.Match(number, @"^(\+[0-9]{11})$").Success;
        }
        
        private bool CheckPhoneNo(string PhoneNo)
        {
            if (!string.IsNullOrEmpty(PhoneNo))
            {
                var connectionString = STATICClass.Connection();
                SqlConnection cnn;
                cnn = new SqlConnection(connectionString);
                cnn.Open();
                
               string SqlString = " Select Top 1 CPhone from tblPos_CustomerData Where WHID=" + CompanyInfo.WareHouseID + " and CPhone like '%" +  PhoneNo + "%'";
                if (!string.IsNullOrEmpty(txtRegisterID.Text))
                {
                    SqlString += " and CustomerID!=" + txtRegisterID.Text + "";
                }
                SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                //var Decrypt=StringCipher.Decrypt("CORBISNAME",dt.Rows[0])
                cnn.Close();
                if (dt.Rows.Count > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            return false;
        }


        private void SaveForm()
        {
            

            int RegisterID = 0;
            if(!string.IsNullOrEmpty(txtRegisterID.Text))
            {
                RegisterID = Convert.ToInt32(txtRegisterID.Text);
            }
            SqlParameter p = new SqlParameter("@CustomerID", RegisterID);
            p.Direction = ParameterDirection.InputOutput;
            List<SqlParameter> ParamList = new List<SqlParameter>();
            ParamList.Add(p);

            ParamList.Add(new SqlParameter("@UserID", CompanyInfo.UserID));
            ParamList.Add(new SqlParameter("@RegisterDate", Convert.ToDateTime(dtRegisterDate.Value)));
            ParamList.Add(new SqlParameter("@CName", txtCustname.Text));
            ParamList.Add(new SqlParameter("@CPhone", txtPhone.Text));
            ParamList.Add(new SqlParameter("@Address",txtAddress.Text));
            ParamList.Add(new SqlParameter("@CityName", txtCity.Text));
            ParamList.Add(new SqlParameter("@Gender", cmbGender.SelectedValue));
            ParamList.Add(new SqlParameter("@FiscalID", CompanyInfo.FiscalID));
            ParamList.Add(new SqlParameter("@CNIC",  txtCnic.Text));
            ParamList.Add(new SqlParameter("@Neck", txtNeck.Text));
            ParamList.Add(new SqlParameter("@FFrontNeck",txtFrontNeck.Text));
            ParamList.Add(new SqlParameter("@FBackNeck",txtBackNeck.Text));
            ParamList.Add(new SqlParameter("@Shoulder",txtShoulder.Text));
            ParamList.Add(new SqlParameter("@FUpperBust",txtUperBust.Text));
            ParamList.Add(new SqlParameter("@Bust",txtBust.Text));
            ParamList.Add(new SqlParameter("@FUnderBust",txtUnderBust.Text));
            ParamList.Add(new SqlParameter("@ArmHole",txtArmHole.Text));
            ParamList.Add(new SqlParameter("@SleeveLength",txtSleeve.Text));
            ParamList.Add(new SqlParameter("@Muscle",txtMuscle.Text));
            ParamList.Add(new SqlParameter("@Elbow",txtElbow.Text));
            ParamList.Add(new SqlParameter("@Cuff",txtCuff.Text));
            ParamList.Add(new SqlParameter("@Waist",txtWaist.Text));
            ParamList.Add(new SqlParameter("@Hip",txthip.Text));
            ParamList.Add(new SqlParameter("@BottomLength",txtBottomLength.Text));
            ParamList.Add(new SqlParameter("@Ankle",txtAnkle.Text));
            ParamList.Add(new SqlParameter("@Remarks",txtRemarks.Text));
            ParamList.Add(new SqlParameter("@RNo",txtRno.Text));
            ParamList.Add(new SqlParameter("@CompanyID", CompanyInfo.CompanyID));
            ParamList.Add(new SqlParameter("@BranchID", CompanyInfo.BranchID));
            ParamList.Add(new SqlParameter("@WHID", CompanyInfo.WareHouseID));
            ParamList.Add(new SqlParameter("@Profession", txtProfession.Text));
            try
            {
                DataTable ret = STATICClass.ExecuteInsert(SP.PosData_tblCustomerData_Insert.ToString()
                    , ParamList);
                if (ret.Columns.Contains("@CustomerID"))
                {
                     RegisterID = Convert.ToInt32(ret.Rows[0]["@CustomerID"].ToString());
                }
                else
                {
                    var msg= Convert.ToString(ret.Rows[0]["ErrorMsg"].ToString());
                    MessageBox.Show(msg);
                    btnSave.Enabled = false;
                    return;

                }
            }catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
                return;
            }
            ClearTextboxes(this.Controls);
        }

        private void clearAll()
        {
            txtCustname.Clear();
            txtPhone.Clear();
            txtAddress.Clear();
            txtCity.Clear();
            txtCnic.Clear();
            txtNeck.Clear();

            txtFrontNeck.Clear();

            txtBackNeck.Clear();
            txtShoulder.Clear();
            txtUperBust.Clear();
            txtBust.Clear();



            txtUnderBust.Clear();
            txtArmHole.Clear();
            txtSleeve.Clear();
            txtMuscle.Clear();

        }
        void ClearTextboxes(System.Windows.Forms.Control.ControlCollection ctrls)
        {
            foreach (Control ctrl in ctrls)
            {
                if (ctrl is TextBox)
                    ((TextBox)ctrl).Text = string.Empty;
                ClearTextboxes(ctrl.Controls);
            }
            btnSave.Enabled = true;
            txtRegisterID.Clear();

            GetRegistraionNo();
            txtCustname.Select();
            txtCustname.Focus();
        }

        private void frmCustomerDataKhaaki_Load(object sender, EventArgs e)
        {
            //txtBillNo.Focus();
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            ClearTextboxes(this.Controls);
        }
        protected override bool ProcessCmdKey(ref Message msg, Keys keyData)
        {
            if (keyData == (Keys.Alt | Keys.S))
            {
                if (validateSave())
                {
                    string message = "Do you want to Save the Data?";
                    string title = "Close Window";
                    MessageBoxButtons buttons = MessageBoxButtons.YesNo;
                    DialogResult result = MessageBox.Show(message, title, buttons);
                    if (result == DialogResult.Yes)
                    {
                        SaveForm();
                    }
                    else
                    {
                        return true;
                    }
                   
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

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void txtBust_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtShoulder_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtNeck_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtSleeve_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtUperBust_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtFrontNeck_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtBackNeck_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtUnderBust_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtMuscle_TextChanged(object sender, EventArgs e)
        {

        }

        private void label20_Click(object sender, EventArgs e)
        {

        }

        private void label17_Click(object sender, EventArgs e)
        {

        }

        private void label13_Click(object sender, EventArgs e)
        {

        }

        private void label23_Click(object sender, EventArgs e)
        {

        }

        
        public void hideFemaleOptions()
        {
            lblUpperBust.Visible = false;
            lblUnderBust.Visible = false;
            lblFrontNeck.Visible = false;
            lblBackNeck.Visible = false;
            txtFrontNeck.Visible = false;
            txtBackNeck.Visible = false;
            txtUperBust.Visible = false;
            txtUnderBust.Visible = false;
        }
        public void ShowFemaleOptions()
        {
            lblUpperBust.Visible = true;
            lblUnderBust.Visible = true;
            lblFrontNeck.Visible = true;
            lblBackNeck.Visible = true;
            txtFrontNeck.Visible = true;
            txtBackNeck.Visible = true;
            txtUperBust.Visible = true;
            txtUnderBust.Visible = true;
        }
        private void cmbGender_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(cmbGender.SelectedValue=="1")
            {
                hideFemaleOptions();
            }
            else
            {
                ShowFemaleOptions();
            }
        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void txtCustname_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                txtPhone.Select();
                txtPhone.Focus();
            }
        }

        private void txtPhone_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!(Char.IsDigit(e.KeyChar) || (e.KeyChar == (char)Keys.Back)))
                e.Handled = true;
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            txtRno.ReadOnly = false;
            txtRno.Clear();
            txtRno.Select();

            txtRno.Focus();
        }

        private void txtRno_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                using (frmSearchCustomerLookup obj = new frmSearchCustomerLookup())
                {
                    if (obj.ShowDialog() == DialogResult.OK)
                    {
                        string Rno = obj.RegisterNo;
                        txtRegisterID.Text = obj.CustomerID;
                        if (!string.IsNullOrEmpty(obj.CustomerID))
                        {
                            LoadCustomerData(obj.CustomerID);
                        }

                    }
                    else
                    {
                        ClearTextboxes(this.Controls);
                    }
                };
            }
        }

        private void txtPhone_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                txtProfession.Select();
                txtProfession.Focus();
            }
        }

        private void txtAddress_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                txtCity.Select();
                txtCity.Focus();
            }
        }

        private void txtCity_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                btnSave.Select();
                btnSave.Focus();
            }
        }

        private void cmbGender_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                txtAddress.Select();
                txtAddress.Focus();
            }
        }

        private void txtNeck_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                if(txtFrontNeck.Visible)
                {
                    txtFrontNeck.Select();
                    txtFrontNeck.Focus();
                }
                else
                {
                    txtShoulder.Select();
                    txtShoulder.Focus();
                }
            }
        }

        private void txtFrontNeck_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                if (txtBackNeck.Visible)
                {
                    txtBackNeck.Select();
                    txtBackNeck.Focus();
                }
                else
                {
                    txtShoulder.Select();
                    txtShoulder.Focus();
                }
            }
        }

        private void txtBackNeck_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
               
                    txtShoulder.Select();
                    txtShoulder.Focus();
                
            }
        }

        private void txtShoulder_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
              
                txtBust.Select();
                txtBust.Focus();
                
            }
        }

        private void txtBust_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                if (txtUperBust.Visible)
                {
                    txtUperBust.Select();
                    txtUperBust.Focus();
                }
                else
                {
                    txtArmHole.Select();
                    txtArmHole.Focus();
                }
            }
        }

        private void txtUperBust_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                if (txtUnderBust.Visible)
                {
                    txtUnderBust.Select();
                    txtUnderBust.Focus();
                }
                else
                {
                    txtArmHole.Select();
                    txtArmHole.Focus();
                }
            }
        }

        private void txtUnderBust_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
              
                    txtArmHole.Select();
                    txtArmHole.Focus();
                
            }
        }

        private void txtArmHole_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {

                txtSleeve.Select();
                txtSleeve.Focus();

            }
        }

        private void txtSleeve_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {

                txtMuscle.Select();
                txtMuscle.Focus();

            }
        }

        private void txtMuscle_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {

                txtElbow.Select();
                txtElbow.Focus();

            }
        }

        private void txtElbow_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {

                txtCuff.Select();
                txtCuff.Focus();

            }

        }

        private void txtCuff_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {

                txtWaist.Select();
                txtWaist.Focus();

            }
        }

        private void txtWaist_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {

                txthip.Select();
                txthip.Focus();

            }
        }

        private void txthip_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {

                txtBottomLength.Select();
                txtBottomLength.Focus();

            }
        }

        private void txtBottomLength_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {

                txtAnkle.Select();
                txtAnkle.Focus();

            }

        }

        private void txtAnkle_KeyDown(object sender, KeyEventArgs e)
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

                btnSave.Select();
                btnSave.Focus();

            }
        }

        private void txtProfession_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {

                cmbGender.Select();
                cmbGender.Focus();

            }
        }
    }
}
