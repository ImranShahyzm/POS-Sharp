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

namespace POS.LookUpForms
{
    public partial class frmClosingLookUp : Form
    {
        public frmClosingLookUp()
        {

            InitializeComponent();
        }
        private void loadCashClosings()
        {
            var connectionString = STATICClass.Connection();
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " ";
           
           
                SqlString = " select CashOut,sourceID,SourceName,Amount,[Date] from data_CashOut where [Date] between '"+dtpSaleFromDate.Value+ "' and '" + dptSaleToDate.Value + "' and SourceName in (Select SourceName from gen_CashTypeSource)";
           
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            if (dt.Rows.Count > 0)
            {
                dgvSaleInvoices.DataSource = dt;
            }
            else
            {
                this.dgvSaleInvoices.DataSource = null;
                dgvSaleInvoices.Rows.Clear();
                dgvSaleInvoices.Refresh();
            }
        }

        private void frmClosingLookUp_Load(object sender, EventArgs e)
        {
            loadCashClosings();
        }

        private void dtpSaleFromDate_ValueChanged(object sender, EventArgs e)
        {
            loadCashClosings();
        }

        private void dgvSaleInvoices_CellContentDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (CompanyInfo.ShopUserType==2)
                {
                    DataGridViewRow row = this.dgvSaleInvoices.Rows[e.RowIndex];
                    var value = Convert.ToInt32(row.Cells[0].Value);
                    var Responce = MessageBox.Show("Are You Sure you Want to Delete this Record...??", "Confirmation",
                    MessageBoxButtons.OKCancel);
                    if (Responce == DialogResult.OK)
                    {
                        DeleteRecord(value);
                    }
                    else
                    {

                    }
                }

            }
        }
        private void DeleteRecord(int CashOutID)
        {
            var connectionString = STATICClass.Connection();
            SqlConnection con = new SqlConnection(connectionString);
            SqlTransaction tran;
            con.Open();
            tran = con.BeginTransaction();
            SqlCommand cmd;
            cmd = new SqlCommand("gen_POSCashTranscation_Delete", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@CashInOut", CashOutID);
          
            SqlDataAdapter da = new SqlDataAdapter();
            DataTable dt1 = new DataTable();
            da.SelectCommand = cmd;
            try
            {
                cmd.Transaction = tran;
                da.Fill(dt1);
                tran.Commit();
                MessageBox.Show("Cash Out Successfully Deleted.");
                
            }
            catch (Exception ex)
            {
                tran.Rollback();
                MessageBox.Show("Error is" + ex.Message);
            }
            finally
            {
                con.Close();
            }
        }
    }
}
