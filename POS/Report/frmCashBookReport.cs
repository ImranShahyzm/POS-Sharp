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
    public partial class frmCashBookReport : Form
    {
        public frmCashBookReport()
        {
            InitializeComponent();
            
          
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
                reportName = "DailyCashBook";
                WhereClause = " Cash Book Detail From " + dtpSaleFromDate.Text + " To " + dtpSaleToDate.Text + "";
                if (!CompanyInfo.isKhaakiSoft)
                {
                    if(CompanyInfo.CounterID>0)
                    {
                        string[] Para3 = { "@CounterID",Convert.ToString(CompanyInfo.CounterID) };
                        value.Add(Para3);
                        obj.CashBook("rpt_CashBookCounterWise", reportName, value);
                    }
                    else
                    {
                        obj.CashBook("rpt_CashBookFoodMama", reportName, value);
                        
                    }
                  
                }
                else
                {
                    obj.CashBook("rpt_CashBook", reportName, value);
                }
                    //obj.ShowDialog();
            };        }

       


    }
}
