using BLL;
using Common;
using POS.Helper;
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
    public partial class frmLogIn : Form
    {
        public frmLogIn()
        {
            InitializeComponent();
            txtUserName.Focus();
            clearAll();
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
            if (string.IsNullOrEmpty(txtPassword.Text) == true)
            {
                txtPassword.Focus();
                MessageBox.Show("Please Enter Password!");
                validateReturnOK = false;
            }
            if (string.IsNullOrEmpty(txtUserName.Text) == true)
            {
                txtUserName.Focus();
                MessageBox.Show("Please Enter UserName!");
                validateReturnOK = false;
            }
            return validateReturnOK;
        }

        private void SaveForm()
        {
            try
            {
                LogInBLL objbll = new LogInBLL();
                LogInCommon objcom = new LogInCommon();
                objcom.UserName = txtUserName.Text;
                objcom.Password = txtPassword.Text;
                DataTable dt = objbll.checkLoginBLL(objcom);
                if (dt.Rows.Count > 0)
                {
                    frmPOSSale objFrm = new frmPOSSale();
                    objFrm.Show();
                    objcom.Userid = Convert.ToInt32(dt.Rows[0]["Userid"]);
                    CommonClass.CompanyName = dt.Rows[0]["Title"].ToString();
                    CompanyInfo.CompanyID = Convert.ToInt32(dt.Rows[0]["CompanyID"]);
                    CompanyInfo.FiscalID = Convert.ToInt32(dt.Rows[0]["FiscalID"]);
                    CompanyInfo.WareHouseID = Convert.ToInt32(dt.Rows[0]["WHID"]);
                    CompanyInfo.UserID = Convert.ToInt32(dt.Rows[0]["Userid"]);
                    this.Hide();
                }
                else
                {
                    MessageBox.Show("Invalid UserName and Password. Please Enter Correct Credientials!");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
           
        }

        private void clearAll()
        {
            txtUserName.Text = "";
            txtPassword.Text = "";
            txtUserName.Select();
            txtUserName.Focus();
        }

        private void frmLogIn_Load(object sender, EventArgs e)
        {
         

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
            else if (keyData == (Keys.Alt | Keys.C))
            {
                clearAll();
                return true;
            }
            return base.ProcessCmdKey(ref msg, keyData);
        }

        private void txtLogInAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!(Char.IsDigit(e.KeyChar) || (e.KeyChar == (char)Keys.Back)))
                e.Handled = true;
        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            frmReport obj = new frmReport();
            obj.Show();
        }
    }
}
