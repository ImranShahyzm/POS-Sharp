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
    public partial class frmPendingBillReport : MetroForm
    {
        public frmPendingBillReport()
        {
            InitializeComponent();
            //laodCategories();
            LoadCustomers();
            dtpSaleFromDate.Select();
            dtpSaleFromDate.Focus();


        }



        protected override bool ProcessCmdKey(ref Message msg, Keys keyData)
        {
            if (keyData == (Keys.Alt | Keys.P))
            {
                return true;
            }
            else if (keyData == (Keys.Alt | Keys.N))
            {
                return true;
            }
            return base.ProcessCmdKey(ref msg, keyData);
        }


        private void btnPreview_Click(object sender, EventArgs e)
        {

            using (frmCrystal obj = new frmCrystal())
            {
                string reportName = "";
                string WhereClause = "";
                reportName = "Sale Report";
                //  WhereClause = " Cash Book Detail From " + dtpSaleFromDate.Text + " To " + dtpSaleToDate.Text + "";
                try
                {
                    obj.PendingBillsReport(reportName, dtpSaleFromDate.Value, dtpSaleToDate.Value, Convert.ToInt32(cmbSaleStyle.SelectedValue),txtCustPhone.Text);

                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            };
        }

        private void frmPendingBillReport_Load(object sender, EventArgs e)
        {
            cmbSaleStyle.DisplayMember = "Text";
            cmbSaleStyle.ValueMember = "Value";

            var items = new[]
                {
                    new { Text = "All Bills", Value = "1" },
                    new { Text = "Pending Bill", Value = "2" }
                     
                };

            cmbSaleStyle.DataSource = items;
            cmbSaleStyle.SelectedIndex = 0;

        }
        private void laodCategories()
        {

            var connectionString = STATICClass.Connection();
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " Select CategoryID,CategoryName from inventCategory where CompanyID=" + CompanyInfo.CompanyID + "";
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            DataRow dr = dt.NewRow();
            dr[0] = "0";
            dr[1] = "--Categories--";
            dt.Rows.InsertAt(dr, 0);

            cmbCategory.ValueMember = "CategoryID";
            cmbCategory.DisplayMember = "CategoryName";
            cmbCategory.DataSource = dt;



        }

        private void LoadCustomers()
        {

            var connectionString = STATICClass.Connection();
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " Select * from vw_customersList where WHID=" + CompanyInfo.WareHouseID + "and RegisterNo>0";
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            DataRow dr = dt.NewRow();
            dr[0] = "0";
            dr[2] = "--Registered Customers--";
            dt.Rows.InsertAt(dr, 0);

            //cmbCustomers.ValueMember = "CPhone";
            //cmbCustomers.DisplayMember = "Name";
            //cmbCustomers.DataSource = dt;



        }


        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void dtpSaleFromDate_ValueChanged(object sender, EventArgs e)
        {

        }

        private void cmbCategory_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void dtpSaleToDate_ValueChanged(object sender, EventArgs e)
        {

        }

        private void dtpSaleFromDate_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                dtpSaleToDate.Select();
                dtpSaleToDate.Focus();
            }
        }

        private void dtpSaleToDate_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                txtCustName.Select();
                txtCustName.Focus();
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



                txtCustName.Text = Convert.ToString(dt.Rows[0]["CName"]);
                txtCustPhone.Text = Convert.ToString(dt.Rows[0]["CPhone"]);
               





            }
            else
            {
                MessageBox.Show("We have no Customer  regarding this No!");
            }
        }

        private void txtCustName_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                if (string.IsNullOrEmpty(txtCustPhone.Text))
                {
                    using (frmSearchCustomerLookup obj = new frmSearchCustomerLookup(" and RegisterNo>0"))
                    {
                        if (obj.ShowDialog() == DialogResult.OK)
                        {
                            string Rno = obj.RegisterNo;

                            if (obj.CustomerID != "")
                            {
                                LoadCustomerData(obj.CustomerID);
                            }
                        }

                    };
                }
                else
                {
                    btnPreview.Select();
                    btnPreview.Focus();
                    btnPreview_Click(sender, e);
                }





            }
        }
    }
}
