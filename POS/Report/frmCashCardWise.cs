using MetroFramework.Forms;
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
    public partial class frmCashCardWise : MetroForm
    {
        public frmCashCardWise()
        {
            InitializeComponent();
            laodCategories();
            loadSaleMansMenuGroup();


        }

        private void loadSaleMansMenuGroup()
        {

            var connectionString = STATICClass.Connection();
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " SELECT SaleManInfoID,SaleManName FROM Gen_saleManInfo where WHID=" + CompanyInfo.WareHouseID + "";
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
                    obj.rptCashCardWise(reportName, dtpSaleFromDate.Value, dtpSaleToDate.Value,Convert.ToInt32(cmbCategory.SelectedValue), Convert.ToInt32(cmbSalesMan.SelectedValue), Convert.ToInt32(cmbSaleStyle.SelectedValue));

                }
                catch(Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            };
        }

        private void frmCashCardWise_Load(object sender, EventArgs e)
        {

            cmbSaleStyle.DisplayMember = "Text";
            cmbSaleStyle.ValueMember = "Value";

            var items = new[] 
                {
                    new { Text = "Both Cash Card", Value = "1" },
                    new { Text = "Cash Sale", Value = "2" },
                     new { Text = "Card Sale", Value = "3" }
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
            string SqlString = " Select CategoryID,CategoryName from inventCategory where CompanyID="+CompanyInfo.CompanyID+"";
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


        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void cmbInvoicetype_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
