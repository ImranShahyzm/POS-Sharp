using BLL;
using POS.Helper;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace POS.LookUpForms
{
    public partial class frmStockArrival : Form
    {
        public frmStockArrival()
        {
            InitializeComponent();
        }

        private void refreshdata()
        {

            StockArrivalBLL ab = new StockArrivalBLL();

            data_StockTransferInfoModel obj = new data_StockTransferInfoModel();

            DataTable dt = obj.SelectAllRemainingMaster(" Where data_RawStockTransfer.TransferToWHID=" + CompanyInfo.WareHouseID + "", "").Tables[0]; 
               
            dgvStockArrival.DataSource = dt;
        }

        private void frmStockArrival_Load(object sender, EventArgs e)
        {
            refreshdata();
        }

        private void dgvStockArrival_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int id = Convert.ToInt32(dgvStockArrival.Rows[dgvStockArrival.CurrentRow.Index].Cells[0].Value);
            using (StockInForm obj = new StockInForm(id))
            {
                
                obj.ShowDialog();
            };
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
