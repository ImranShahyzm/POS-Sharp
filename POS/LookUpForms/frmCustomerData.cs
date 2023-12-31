﻿using MetroFramework.Forms;
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
    public partial class frmCustomerData : MetroForm
    {
        public string CustomerName { get; set; }
        public string PhoneNumber { get; set; }
        public PosKhaakiStyle KhaakiObjet;
        public frmCustomerData(PosKhaakiStyle obj)
        {
            InitializeComponent();
            //loadCashSource();
            KhaakiObjet = obj;
            txtPhoneNo.Text = obj.CustomerPhone;
            txtCustomerName.Text = obj.CustomerName;
            lblTotalBill.Text = obj.totalBill;
            lblReturn.Text = obj.ReturnAmount;
            lblTotalReceived.Text = obj.ReceivedAmount;
            loadSaleMansMenuGroup();
            cmbSalesMan.Select();
            if(!String.IsNullOrEmpty(KhaakiObjet.SaleManId))
            {
                cmbSalesMan.SelectedValue = Convert.ToInt32(KhaakiObjet.SaleManId);
            }
            cmbSalesMan.Focus();
          
        }
        private void loadSaleMansMenuGroup()
        {



            var connectionString = STATICClass.Connection();
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " SELECT SaleManInfoID,SaleManName FROM Gen_saleManInfo where WHID=" + CompanyInfo.WareHouseID+"";
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            DataRow dr = dt.NewRow();
            dr[0] = "0";
            dr[1] = "--Select Sales Person--";
            dt.Rows.InsertAt(dr, 0);

            cmbSalesMan.ValueMember = "SaleManInfoID";
            cmbSalesMan.DisplayMember = "SaleManName";
            cmbSalesMan.DataSource = dt;

        }
        private void GetCustomerName(string PhoneNo)
        {
            if (!string.IsNullOrEmpty(PhoneNo))
            {
                var connectionString = STATICClass.Connection();
                SqlConnection cnn;
                cnn = new SqlConnection(connectionString);
                cnn.Open();
                string SqlString = " Select Top 1 CustomerName , CustomerPhone from data_SalePosInfo Where WHID=" + CompanyInfo.WareHouseID + " and CustomerPhone like '%" + PhoneNo + "%'";

                SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                cnn.Close();
                if (dt.Rows.Count > 0)
                {
                    txtCustomerName.Text = Convert.ToString(dt.Rows[0]["CustomerName"].ToString());
                    txtPhoneNo.Text = Convert.ToString(dt.Rows[0]["CustomerPhone"].ToString());
                }
            }
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
            //decimal cashInAmount = txtCashInAmount.Text == "" ? 0 : Convert.ToDecimal(txtCashInAmount.Text);
            //bool validateReturnOK = true;
           

                return true;
            
        }

        private void SaveForm()
        {
            //var connectionString = STATICClass.Connection();
            //SqlConnection con = new SqlConnection(connectionString);
            //SqlTransaction tran;
            //con.Open();
            //tran = con.BeginTransaction();
            //SqlCommand cmd;
            //cmd = new SqlCommand("data_Cash_Insert", con);
            //cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.AddWithValue("@SourceID", cmbCashType.SelectedValue.ToString());
            //cmd.Parameters.AddWithValue("@SourceName", cmbCashType.Text);
            //cmd.Parameters.AddWithValue("@Amount", txtCashInAmount.Text == "" ? 0 : Convert.ToDecimal(txtCashInAmount.Text));
            //cmd.Parameters.AddWithValue("@CashType", true);
            //cmd.Parameters.AddWithValue("@SalePosDate", dtCashDate.Value);
            
            //SqlDataAdapter da = new SqlDataAdapter();
            //DataTable dt1 = new DataTable();
            //da.SelectCommand = cmd;
            //try
            //{
            //    cmd.Transaction = tran; da.Fill(dt1);
            //    tran.Commit();
            //    MessageBox.Show("Cash In Successfully Done.");
            //    this.Close();
            //}
            //catch (Exception ex)
            //{
            //    tran.Rollback();
            //    MessageBox.Show("Error is" + ex.Message);
            //}
            //finally
            //{
            //    con.Close();
            //}
            //if(txtCustomerName.Text!="")
            //{
                KhaakiObjet.CustomerName = txtCustomerName.Text;
                KhaakiObjet.CustomerPhone = txtPhoneNo.Text;
                KhaakiObjet.SaleManId = Convert.ToString(cmbSalesMan.SelectedValue);

            KhaakiObjet.AllowSave = true;
                this.Close();
            //}
            //else
            //{
            //    MessageBox.Show("Please Enter Customer Number for further Processing...");
            //    txtPhoneNo.Focus();

            //}
        }

        private void clearAll()
        {
            txtCustomerName.Clear();
            txtPhoneNo.Clear();
            txtCustomerName.Select();
            txtCustomerName.Focus();
        }

        private void frmCustomerData_Load(object sender, EventArgs e)
        {
            txtCustomerName.Focus();
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

        private void txtCardNumber_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                btnSave.Focus();
            }
            if (e.KeyCode == Keys.Escape)
            {
                KhaakiObjet.AllowSave = false;
                this.Close();
            }
        }

        private void txtCardName_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                GetCustomerName(txtPhoneNo.Text);
                txtCustomerName.Focus();
            }
            if (e.KeyCode == Keys.Escape)
            {
                KhaakiObjet.AllowSave = false;
                this.Close();
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            KhaakiObjet.AllowSave = false;
            this.Close();

        }

        private void frmCustomerData_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Escape)
            {
                KhaakiObjet.AllowSave = false;
                this.Close();
            }
        }

        private void cmbSalesMan_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                txtPhoneNo.Select();
                txtPhoneNo.Focus();
            }
        }
    }
}
