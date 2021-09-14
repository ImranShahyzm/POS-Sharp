using BLL;
using MetroFramework.Forms;
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
    public partial class frmStockDispatchArrival : MetroForm
    {
        public frmStockDispatchArrival()
        {
            InitializeComponent();
        }

        private void refreshdata()
        {

            StockArrivalBLL ab = new StockArrivalBLL();

            data_StockTransferInfoModel obj = new data_StockTransferInfoModel();

            DataTable dt = obj.SelectAllRemainingDispatchesTransfer(" Where data_StockDispatchAgainstTransferPOS.DispatchToWHID=" + CompanyInfo.WareHouseID + "", "").Tables[0]; 
               
            dgvStockArrival.DataSource = dt;
        }

        private void frmStockDispatchArrival_Load(object sender, EventArgs e)
        {
            refreshdata();
        }

        private void dgvStockArrival_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int id = Convert.ToInt32(dgvStockArrival.Rows[dgvStockArrival.CurrentRow.Index].Cells[0].Value);
            string ArrivalNo= Convert.ToString(dgvStockArrival.Rows[dgvStockArrival.CurrentRow.Index].Cells[2].Value);
            if (CompanyInfo.isKhaakiSoft)
            {

                using (StockInDetailKhaakiForm obj = new StockInDetailKhaakiForm(id,ArrivalNo))
                {

                    obj.ShowDialog();
                };
            }
            else
            {
                using (StockInForm obj = new StockInForm(id))
                {

                    obj.ShowDialog();
                };
            }
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
