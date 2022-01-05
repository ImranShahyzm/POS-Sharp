using MetroFramework.Forms;
using Newtonsoft.Json;
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
    public partial class frmRecipeSync : MetroForm
    {
        public frmRecipeSync()
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
        private void UpdateSyncedOrder(string OrderID)
        {


            SqlConnection db = new SqlConnection(STATICClass.Connection());
            SqlCommand com = new SqlCommand();
            com.Connection = db;
            db.Open();

            com.CommandText = @"update Posdata_MaketoOrderInfo set 
                           IsOrderSynced=1 where Neck is not null and FFrontNeck is not null and FBackNeck is not null and Hip is not null and Muscle is not null and OrderId=" + OrderID+"";
            com.ExecuteNonQuery();

            db.Close();

    }


        private async void  btnPreview_Click(object sender, EventArgs e)
        {

            

                btnProgressBar.Value = 9;
                lblStatus.Text = "Syncing Bill of materials With Server...";
            await STATICClass.GetALLBillOfMaterials();
                          
                        btnProgressBar.Value = 100;
                        lblStatus.Text = "Uploading Return Invoices to Server...";

        }

        private void dtpSaleFromDate_ValueChanged(object sender, EventArgs e)
        {

            dtpSaleToDate.Value = dtpSaleFromDate.Value;

        }
    }
}
