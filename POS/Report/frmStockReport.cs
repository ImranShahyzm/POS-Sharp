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
    public partial class frmStockReport : MetroForm
    {
        public frmStockReport()
        {
            InitializeComponent();
            laodCategories();


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

        private void btnPreview_Click(object sender, EventArgs e)
        {
            var value = new List<string[]>();
            string[] para1 = { "@FromDate", dtpSaleFromDate.Text};
            string[] para2 = { "@ToDate", dtpSaleToDate.Text };
            value.Add(para1);
            value.Add(para2);
            //using (frmReport obj = new frmReport())
            //{
            //    string reportName = "";
            //    string WhereClause = "";
            //    reportName = "DailyCashBook";
            //    WhereClause = " Cash Book Detail From " + dtpSaleFromDate.Text + " To " + dtpSaleToDate.Text + "";
            //    obj.PreviewReport("rpt_CashBook", reportName, value);
            //    obj.ShowDialog();
            //};
            using (frmCrystal obj = new frmCrystal())
            {
                string reportName = "";
                string WhereClause = "";
                reportName = "STOCKREPORT";
                //  WhereClause = " Cash Book Detail From " + dtpSaleFromDate.Text + " To " + dtpSaleToDate.Text + "";
                if (!chkArticlesFilter.Checked)
                {
                    obj.StockReport(reportName, dtpSaleToDate.Value, Convert.ToInt32(cmbCategory.SelectedValue),null, null);
                }
                else
                {


                    obj.StockReport(reportName, dtpSaleToDate.Value, Convert.ToInt32(cmbCategory.SelectedValue), dtRegisterDate.Value, dtRegisterTo.Value);
                }
            };        }

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void dtpSaleToDate_ValueChanged(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void frmStockReport_Load(object sender, EventArgs e)
        {

        }

        private void chkArticlesFilter_CheckedChanged(object sender, EventArgs e)
        {

        }
    }
}
