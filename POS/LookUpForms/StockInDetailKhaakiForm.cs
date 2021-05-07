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
using MetroFramework.Forms;
using POS.Helper;

namespace POS.LookUpForms
{
    public partial class StockInDetailKhaakiForm :MetroForm
    {
        public StockInDetailKhaakiForm(int id,string ArrivalNo="")
        {
            InitializeComponent();
            txtArrivalNo.Text = ArrivalNo;
            loadProducts();
            setGriddataAsync(id);
        }
        public async Task setGriddataAsync(int id)
        {
            var dat = await STATICClass.GETStockDetail(id);
            txtRefID.Text = Convert.ToString(id);
            data_StockTransferInfoModel obj = new data_StockTransferInfoModel();
            var dt = obj.SelectAllRemainingKhaki(" where data_RawStockTransfer.transferIDRef="+id+" and data_RawStockTransfer.CompanyID=" + CompanyInfo.CompanyID+ " and TransferToWHID=" + CompanyInfo.WareHouseID, "").Tables[0];

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
                var Received = dgvStockDetailData.CurrentRow.Cells[11].Value;
                var Remaining = dgvStockDetailData.CurrentRow.Cells[10].Value;
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
                    dgvStockDetailData.CurrentRow.Cells[11].Value = dgvStockDetailData.CurrentRow.Cells[10].Value; 
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
        private void loadProducts()
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " select ItemId,ItenName from InventItems";
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            DataRow dr = dt.NewRow();
            dr[0] = "0";
            dr[1] = "Select Product";
            dt.Rows.InsertAt(dr, 0);

            cmbProducts.ValueMember = "ItemId";
            cmbProducts.DisplayMember = "ItenName";
            cmbProducts.DataSource = dt;
        }
        private DataTable getProduct(int categoryID, int productID = 0, string ManualNumber = "")
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = @" select InventItems.ItemId,InventItems.ItenName,InventItems.ItemSalesPrice,cast(isnull(t.TotalTax,0) as numeric(18,2)) as TotalTax,cast(isnull(((InventItems.ItemSalesPrice*t.TotalTax)/100),0) as numeric(18,2)) as TaxAmount,InventItems.cartonSize
                                from InventItems
                                left outer
                                join (select InventItems.ItemId,sum(gen_TaxDetailInfo.TaxPercentage) as TotalTax
                                from InventItems
                                inner join gen_TaxGroupInfo on InventItems.TaxGroupID = gen_TaxGroupInfo.TaxGroupID
                                inner
                                join gen_TaxGroupDetail on gen_TaxGroupInfo.TaxGroupID = gen_TaxGroupDetail.TaxGroupID
                                inner
                                join gen_TaxInfo on gen_TaxGroupDetail.TaxID = gen_TaxInfo.TaxID
                                inner
                                join gen_TaxDetailInfo on gen_TaxInfo.TaxID = gen_TaxDetailInfo.TaxID
                                where GETDATE() between FromDate and ToDate
                                group by InventItems.ItemId)t on InventItems.ItemId = t.ItemId
                                ";
            if (categoryID != 0)
            {
                SqlString += "where InventItems.MainItem = 1 and InventItems.CategoryID = " + categoryID;
            }
            else if (productID != 0)
            {
                SqlString += "where InventItems.ItemId = " + productID;
            }
            else if (ManualNumber != "")
            {
                SqlString += "where InventItems.ManualNumber= '" + ManualNumber + "'";
            }
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            return dt;
        }
        private void txtProductCode_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyData == Keys.Enter)
            {
                if (txtProductCode.Text != "")
                {
                    DataTable dt = getProduct(0, 0, txtProductCode.Text);
                    if (dt.Rows.Count == 0)
                    {
                        using (frmProductLookUp obj = new frmProductLookUp(0))
                        {
                            if (obj.ShowDialog() == DialogResult.OK)
                            {
                                int id = obj.ProductID;
                                txtProductID.Text = id.ToString();
                                txtProductCode.Text = obj.ManualNumber;
                                cmbProducts.SelectedValue = id.ToString();
                                var dtReturn = getProduct(0, Convert.ToInt32(id));
                                txtQuantity.Text = "1";
                                txtQuantity_KeyDown(sender, e);
                            }
                        };
                    }
                    else
                    {
                        cmbProducts.SelectedValue = dt.Rows[0]["ItemId"].ToString();

                       
                        txtProductID.Text = Convert.ToString(dt.Rows[0]["ItemId"]);
                       
                        txtQuantity.Text = "1";
                        txtQuantity_KeyDown(sender, e);
                    }
                    string ids = cmbProducts.SelectedValue.ToString();
                    {
                        if (ids != "0")
                        {
                            //DataTable dt1 = getProduct(0, Convert.ToInt32(ids));
                            //AddProducts(dt1.Rows[0]["itenName"].ToString(), Convert.ToInt32(ids), Convert.ToDecimal(dt1.Rows[0]["ItemSalesPrice"]), Convert.ToDecimal(dt1.Rows[0]["TotalTax"]));
                        }
                    }
                }
                else
                {
                    MessageBox.Show("Please Enter Product Code");
                }
            }
        }
        private void AddProducts(string productName, int id, decimal rates, decimal taxPercentage, decimal CartonSize = 0)
        {

           
            bool recordExist = false;
            
                for (int i = 0; i < dgvStockDetailData.Rows.Count; i++)
                {
                    if (id == Convert.ToInt32(dgvStockDetailData.Rows[i].Cells[3].Value.ToString()))
                    {

                        string value = dgvStockDetailData.Rows[i].Cells[11].Value.ToString();

                     
                        decimal qty = Convert.ToDecimal(value);
                     
                        qty = qty + Convert.ToDecimal(txtQuantity.Text);

                        dgvStockDetailData.Rows[i].Cells[11].Value = qty;
                    var Received = dgvStockDetailData.Rows[i].Cells[11].Value.ToString();
                    var Remaining = dgvStockDetailData.Rows[i].Cells[10].Value.ToString();
                    

                    if (Convert.ToDecimal(Received) > Convert.ToDecimal(Remaining))
                    {
                        dgvStockDetailData.Rows[i].Cells[11].Value = dgvStockDetailData.Rows[i].Cells[10].Value;
                        recordExist = true;
                        ClearFields();
                        txtProductCode.Focus();
                        MessageBox.Show("The Stock Arrival Quantity has been Completed.. For This Product...");
                        return;
                    }

                    recordExist = true;
                       
                        ClearFields();
                        txtProductCode.Focus();
                        return;
                    }
                }
            
            if (!recordExist)
            {

                MessageBox.Show("This Product is Not Enetered in Stock Issuance from Head Office...");
                decimal Value = Convert.ToDecimal(txtQuantity.Text);
                ClearFields();
                txtProductCode.Focus();
                //string[] row = { id.ToString(), Convert.ToString(txtProductCode.Text), cmbProducts.Text,"0", txtQuantity.Text.ToString(), "0",  "0", "0", "0", "0", "0", "0", "0", "0" };
                //dgvStockDetailData.Rows.Insert(0, row);
            }
          
            ClearFields();
            txtProductCode.Focus();
        }
        private void ClearFields()
        {
            txtProductID.Clear();

           
            txtQuantity.Clear();
          
            txtProductCode.Clear();
        
            cmbProducts.SelectedIndex = 0;
          
        }
        private void txtQuantity_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                if (txtQuantity.Text != "")
                {
                    if (Convert.ToDecimal(txtQuantity.Text) > 0)
                    {
                       
                            AddProducts(cmbProducts.SelectedText, Convert.ToInt32(txtProductID.Text), 0, 0);
                       
                    }
                }
            }
        }
    }
}
