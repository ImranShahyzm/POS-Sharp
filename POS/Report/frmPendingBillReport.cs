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
    public partial class frmPendingBillReport : MetroForm
    {
        public frmPendingBillReport()
        {
            InitializeComponent();
            //laodCategories();
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
                    obj.PendingBillsReport(reportName, dtpSaleFromDate.Value, dtpSaleToDate.Value, Convert.ToInt32(cmbSaleStyle.SelectedValue));

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

            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
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
                btnPreview.Select();
                btnPreview.Focus();
                btnPreview_Click(sender, e);
            }
        }
    }
}
