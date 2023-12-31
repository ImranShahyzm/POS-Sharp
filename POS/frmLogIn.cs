﻿using BLL;
using Common;
using DAL;
using MetroFramework.Forms;
using POS.Helper;
using POS.Report;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Net.NetworkInformation;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace POS
{
    public partial class frmLogIn : MetroForm
    {
        public frmLogIn()
        {

            InitializeComponent();
            
          
     
            
            System.Reflection.Assembly assembly = System.Reflection.Assembly.GetExecutingAssembly();
            FileVersionInfo fileVersion = FileVersionInfo.GetVersionInfo(assembly.Location);
            AppVersion.Text = String.Format(" Application Version {0}", fileVersion.FileVersion);
            //string version = System.Windows.Forms.Application.ProductVersion;
            //this.Text = String.Format("My Application Version {0}", version)
            //clearAll();
            try
            {
                CommonClass.ConnectionString = STATICClass.Connection();
                LoginDAL objDAL = new LoginDAL();
                string result = objDAL.SetMAcAddressIfFirstRun();
                if (result != "Done")
                {
                    if (MessageBox.Show(result, "Important Message...!!", MessageBoxButtons.OK, MessageBoxIcon.Stop) == DialogResult.OK)
                    {
                        System.Environment.Exit(1);
                    }
                }
                string EncryptedDate = objDAL.GetExpiryDate();
                string DecryptExpiryDate = STATICClass.Decrypt(EncryptedDate, STATICClass.ExpiryDateKey);
                if (DecryptExpiryDate != "No" && !string.IsNullOrEmpty(DecryptExpiryDate))
                {
                    STATICClass.IsDemo = true;
                    var CurrentDate = System.DateTime.Now;
                    var ExpiryDate = Convert.ToDateTime(DecryptExpiryDate);
                    var Days = (ExpiryDate.Date - CurrentDate.Date).TotalDays;
                    if (Days <= 0)
                    {
                        lblLicense.Text = "Software License has been Expired. Please Contact with Corbis Team.Thanks";
                    }
                    else
                    {
                        lblLicense.Text = "Software License will Expire in " + Convert.ToString(Days) + " Days. Please Contact with Corbis Team before that..Thanks";
                    }
                    STATICClass.DemoEndDate = ExpiryDate;
                    if (Days <= 7)
                    {
                        lblLicense.Visible = true;
                    }
                }
                else if (DecryptExpiryDate == "No")
                {
                    STATICClass.IsDemo = false;
                }
                else
                {
                    STATICClass.IsDemo = true;
                    STATICClass.DemoEndDate = System.DateTime.Now;
                }
            }catch(Exception e)
            {
                MessageBox.Show(e.Message);
            }

            txtUserName.Focus();
            txtUserName.Select();

        }
        private void btnSave_Click(object sender, EventArgs e)
        {
            if(STATICClass.IsDemo)
            {
                var CurrentDate = System.DateTime.Now.Date;

                if (CurrentDate.Date >= STATICClass.DemoEndDate.Date)
                {
                    MessageBox.Show("Your Software License has Been Expired Please Contact with Corbissoft Multan...0612080200");
                    return;
                }
            }
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
        private string GetNICID()
        {
       
            NetworkInterface[] nics = NetworkInterface.GetAllNetworkInterfaces();
            String sMacAddress = string.Empty;
            foreach (NetworkInterface adapter in nics)
            {
                if (sMacAddress == String.Empty)// only return MAC Address from first card  
                {
                    IPInterfaceProperties properties = adapter.GetIPProperties();
                    sMacAddress = adapter.GetPhysicalAddress().ToString();
                }
            }
            GetNICIDs();
            return sMacAddress;

          
        }

        private string GetNICIDs()
        {

            NetworkInterface[] nics = NetworkInterface.GetAllNetworkInterfaces();
            String sMacAddress = string.Empty;
            foreach (NetworkInterface adapter in nics)
            {
                if (adapter.GetPhysicalAddress().ToString() != String.Empty)// only return MAC Address from first card  
                {
                    IPInterfaceProperties properties = adapter.GetIPProperties();
                    sMacAddress = sMacAddress+adapter.GetPhysicalAddress().ToString()+",";
                }
                
            }
            var MacAddressArray = sMacAddress.Split(',');
            return sMacAddress;


        }

        private void SaveForm()
        {
            try
            {
                LogInBLL objbll = new LogInBLL();
                LogInCommon objcom = new LogInCommon();
                objcom.UserName = txtUserName.Text;
                objcom.Password = txtPassword.Text;

                var EncryptedPassword = STATICClass.Encrypt(txtPassword.Text.Trim(), STATICClass.ExpiryDateKey);
                objcom.Password = EncryptedPassword;

                objcom.NICID = GetNICIDs();
                DataTable dt = objbll.checkLoginBLL(objcom);
                if (dt.Rows.Count > 0)
                {
                    CompanyInfo.WareHouseName = dt.Rows[0]["CounterTitle"] is DBNull?Convert.ToString(dt.Rows[0]["WareHouseName"]): Convert.ToString(dt.Rows[0]["CounterTitle"]);
                   
                    CommonClass.CompanyName = dt.Rows[0]["Title"].ToString();
                    CompanyInfo.CompanyID = Convert.ToInt32(dt.Rows[0]["CompanyID"]);
                    CompanyInfo.FiscalID = Convert.ToInt32(dt.Rows[0]["FiscalID"]);
                    CompanyInfo.WareHouseID = Convert.ToInt32(dt.Rows[0]["WHID"]);
                    CompanyInfo.UserID = Convert.ToInt32(dt.Rows[0]["Userid"]);
                    CompanyInfo.username= Convert.ToString(dt.Rows[0]["UserName"]);
                    CompanyInfo.LocationID=Convert.ToString(dt.Rows[0]["LocationID"]);
                    CompanyInfo.isKhaakiSoft= Convert.ToBoolean(dt.Rows[0]["isKhaakiSoft"]);
                    CompanyInfo.ShopUserType = Convert.ToInt32(dt.Rows[0]["ShopUserType"]);
                    CompanyInfo.NoOfInvoicePrint = Convert.ToByte(dt.Rows[0]["NoOfInvoicePrint"]);

                    CompanyInfo.POSStyle=dt.Rows[0]["PosStyle"] is DBNull? "Default" : Convert.ToString(dt.Rows[0]["PosStyle"]);

                    CompanyInfo.CounterID = dt.Rows[0]["CounterID"] is DBNull ? 0 : Convert.ToInt32(dt.Rows[0]["CounterID"]);

                    CompanyInfo.ISFbrConnectivity = dt.Rows[0]["ISFbrConnectivity"] is DBNull ? 0 : Convert.ToInt32(dt.Rows[0]["ISFbrConnectivity"]);
                    CompanyInfo.POSID = dt.Rows[0]["POSID"] is DBNull ? 0 : Convert.ToInt32(dt.Rows[0]["POSID"]);
                    CompanyInfo.USIN = dt.Rows[0]["USIN"] is DBNull ? "0" : Convert.ToString(dt.Rows[0]["USIN"]);

                    CompanyInfo.ApiIpAddress = Convert.ToString(dt.Rows[0]["ApiIpAddress"]);
                    STATICClass.BaseURL = CompanyInfo.ApiIpAddress;


                    frmPOSSale objFrm = new frmPOSSale();

                    objcom.Userid = Convert.ToInt32(dt.Rows[0]["Userid"]);
                    objFrm.Show();
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

            this.Activate();

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

        private void txtPassword_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                btnSave.Focus();
            }
        }

        private void txtUserName_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                txtPassword.Focus();
            }
        }

        private void btnSettings_Click(object sender, EventArgs e)
        {
            frmConnection frm = new frmConnection();
            frm.ShowDialog();
        }
    }
}
