﻿using MetroFramework.Forms;
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
    public partial class frmStockKhaaki : MetroForm
    {
        public frmStockKhaaki()
        {
            InitializeComponent();

            loadSaleMenuGroup();

        }
        private void loadSaleMenuGroup()
        {



            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " SELECT * FROM InventItemGroup";
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            DataRow dr = dt.NewRow();
            dr[0] = "0";
            dr[1] = "--Select Menu--";
            dt.Rows.InsertAt(dr, 0);

            cmbSalemenu.ValueMember = "ItemGroupID";
            cmbSalemenu.DisplayMember = "ItemGroupName";
            cmbSalemenu.DataSource = dt;

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
                obj.StockReport(reportName, dtpSaleToDate.Value,0,null,null,Convert.ToInt32(cmbSalemenu.SelectedValue));
              
            };        }

        private void label1_Click(object sender, EventArgs e)
        {

        }
    }
}