using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MetroFramework.Forms;
using POS.Helper;

namespace POS.LookUpForms
{
    public partial class StockInDetailKhaakiForm :MetroForm
    {
        public StockInDetailKhaakiForm(int id)
        {
            InitializeComponent();
            setGriddataAsync(id);
        }
        public async Task setGriddataAsync(int id)
        {
            var dat = await STATICClass.GETStockDetail(id);
            txtRefID.Text = Convert.ToString(id);
            data_StockTransferInfoModel obj = new data_StockTransferInfoModel();
            var dt = obj.SelectAllRemaining(" where data_RawStockTransfer.transferIDRef="+id+" and data_RawStockTransfer.CompanyID=" + CompanyInfo.CompanyID+ " and TransferToWHID=" + CompanyInfo.WareHouseID, "").Tables[0];

            if (dt.Rows.Count > 0)
            {
                txtArrivalDate.Value = Convert.ToDateTime(dt.Rows[0]["TransferDate"]);
                    }
            dgvStockDetailData.DataSource = dt;
            dgvStockDetailData.Columns["TransferDate"].Visible = false;
            dgvStockDetailData.Columns["Remarks"].Visible = false;
            dgvStockDetailData.Columns["ItemId"].Visible = false;
            dgvStockDetailData.Columns["TransferToWHID"].Visible = false;
            dgvStockDetailData.Columns["StockTransferDetailID"].Visible = false;
            dgvStockDetailData.Columns[4].Width = 250;
            dgvStockDetailData.Columns[5].Visible = false;

            dgvStockDetailData.Columns[6].Visible = false;

            dgvStockDetailData.Columns[7].Visible = false;
            dgvStockDetailData.Columns[3].ReadOnly =true;
            dgvStockDetailData.Columns[4].ReadOnly = true;
            dgvStockDetailData.Columns[5].ReadOnly = true;
            dgvStockDetailData.Columns[6].ReadOnly = true;
            dgvStockDetailData.Columns[7].ReadOnly = true;
            dgvStockDetailData.Columns[8].ReadOnly = true;
            dgvStockDetailData.Columns[9].ReadOnly = true;

            dgvStockDetailData.Columns[10].ReadOnly = true;
            var deleteButton = new DataGridViewButtonColumn();
            deleteButton.Name = "dataGridViewDeleteButton";
            deleteButton.HeaderText = "Delete";
            deleteButton.Text = "Delete";
            deleteButton.UseColumnTextForButtonValue = true;
            this.dgvStockDetailData.Columns.Add(deleteButton);

        }
        
        private void btnSave_Click(object sender, EventArgs e)
        {
            //DataTable dt = new DataTable();

            //    dt.Columns.Add("ItemId");
            //    dt.Columns.Add("Quantity");
            //    dt.Columns.Add("StockRate");
            //    dt.Columns.Add("CartonQuantity");
            //    dt.Columns.Add("LooseQuantity");
            //    dt.Columns.Add("TransferDetailID");

            try
            {
                DataTable dtGrid = new DataTable();
                dtGrid = (DataTable)dgvStockDetailData.DataSource;
                data_StockTransferInfoModel model = new data_StockTransferInfoModel();
                if(String.IsNullOrEmpty(Convert.ToString(dtGrid.Rows[0]["TransferDate"])))
                {
                    MessageBox.Show("No Rows for Saving Record...");
                    return;
                }
                model.RefID = Convert.ToInt32(txtRefID.Text);
                model.ArrivalDate = txtArrivalDate.Value;
             var message= model.insertDetaildata(dtGrid, model);
                if(message==true)
                {
                    dgvStockDetailData.DataSource = null;
                    dgvStockDetailData.Rows.Clear();
                    dgvStockDetailData.Refresh();
                    this.Close();
                }
            }catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
                return;
            }

        }

        private void dgvStockDetailData_CellValidating(object sender, DataGridViewCellValidatingEventArgs e)
        {
            if (e.ColumnIndex == 11) // 1 should be your column index
            {
                int i;

                if (!int.TryParse(Convert.ToString(e.FormattedValue), out i))
                {
                    e.Cancel = true;
                    dgvStockDetailData.CurrentRow.Cells[11].Value = "0"; 


                }
                else
                {
                    // the input is numeric 
                }
            }
        }

        private void dgvStockDetailData_KeyPress(object sender, KeyPressEventArgs e)
        {
            //if (dgvStockDetailData.CurrentCell.ColumnIndex == 10)
            //{
            //    if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar)
            //   && e.KeyChar != '.')
            //    {
            //        e.Handled = true;
            //    }

            //    // only allow one decimal point
            //    if (e.KeyChar == '.'
            //        && (sender as TextBox).Text.IndexOf('.') > -1)
            //    {
            //        e.Handled = true;
            //    }
            //}

        }

        private void dgvStockDetailData_CellValidated(object sender, DataGridViewCellEventArgs e)
        {
            if(e.ColumnIndex==10)
            {
                var Received = dgvStockDetailData.CurrentRow.Cells[10].Value;
                var Remaining = dgvStockDetailData.CurrentRow.Cells[9].Value;
                if(Remaining is DBNull)
                {
                    return;
                }
                if (Received is DBNull)
                {
                    return;
                }

                if (Convert.ToDecimal(Received)> Convert.ToDecimal(Remaining))
                {
                    dgvStockDetailData.CurrentRow.Cells[10].Value = dgvStockDetailData.CurrentRow.Cells[9].Value; 
                }

            }

        }

        private void dgvStockDetailData_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            //if click is on new row or header row
            if (e.RowIndex == dgvStockDetailData.NewRowIndex || e.RowIndex < 0)
                return;

            //Check if click is on specific column 
            if (e.ColumnIndex == dgvStockDetailData.Columns["dataGridViewDeleteButton"].Index)
            {
                
                dgvStockDetailData.Rows.RemoveAt(e.RowIndex);

                
            }
        }

        private void dgvStockDetailData_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void dgvStockDetailData_EditingControlShowing(object sender, DataGridViewEditingControlShowingEventArgs e)
        {
            e.Control.KeyPress -= new KeyPressEventHandler(Column1_KeyPress);
            TextBox ttxb = e.Control as TextBox;

            if (dgvStockDetailData.CurrentCell.ColumnIndex == dgvStockDetailData.Columns["Received"].Index) //Desired Column
            {

                TextBox tb = e.Control as TextBox;
                if (tb != null)
                {
                    tb.KeyPress += new KeyPressEventHandler(Column1_KeyPress);
                }
                else
                {
                    tb.Text = (1).ToString();
                }
                if (tb.Text == "")
                {
                    tb.Text = (1).ToString();
                }

            }
        }
        
        private void Column1_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar))
            {
                e.Handled = true;
            }
            

        }
    }
}
