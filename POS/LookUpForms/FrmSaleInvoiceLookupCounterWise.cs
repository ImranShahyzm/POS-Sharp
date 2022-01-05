using MetroFramework.Forms;
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
    public partial class FrmSaleInvoiceLookupCounterWise :MetroForm
    {
        public string SaleInvoiceNo { get; set; }

        public DateTime SaleInvoiceDate { get; set; }
        public FrmSaleInvoiceLookupCounterWise()
        {
            InitializeComponent();
        }

        private void FrmSaleInvoiceLookupCounterWise_Load(object sender, EventArgs e)
        {
            loadSaleInvoices();
            txtProductCode.Select();
            txtProductCode.Focus();

        }

        

       

        private void SetupDataGridView()
        {

            var ID = new DataGridViewTextBoxColumn();
            ID.Name = "SalePOSNO";
            ID.HeaderText = "Sale No";
            ID.Visible = false;

            var TaxAmount = new DataGridViewTextBoxColumn();
            TaxAmount.Name = "TaxAmount";
            TaxAmount.HeaderText = "TaxAmount";
            TaxAmount.Width = 100;

            var GrossAmount = new DataGridViewTextBoxColumn();
            GrossAmount.Name = "GrossAmount";
            GrossAmount.HeaderText = "GrossAmount";
            GrossAmount.Width = 100;

            var OtherCharges = new DataGridViewTextBoxColumn();
            OtherCharges.Name = "OtherCharges";
            OtherCharges.HeaderText = "OtherCharges";
            OtherCharges.Width = 100;

            var NetAmount = new DataGridViewTextBoxColumn();
            NetAmount.Name = "NetAmount";
            NetAmount.HeaderText = "NetAmount";
            NetAmount.Width = 100;

            var AmountReceive = new DataGridViewTextBoxColumn();
            AmountReceive.Name = "AmountReceive";
            AmountReceive.HeaderText = "AmountReceive";
            AmountReceive.Width = 100;

            var AmountReturn = new DataGridViewTextBoxColumn();
            AmountReturn.Name = "AmountReturn";
            AmountReturn.HeaderText = "AmountReturn";
            AmountReturn.Width = 100;


            dgvSaleInvoices.Columns.Add(ID);
            dgvSaleInvoices.Columns.Add(TaxAmount);
            dgvSaleInvoices.Columns.Add(GrossAmount);
            dgvSaleInvoices.Columns.Add(OtherCharges);
            dgvSaleInvoices.Columns.Add(NetAmount);
            dgvSaleInvoices.Columns.Add(AmountReceive);
            dgvSaleInvoices.Columns.Add(AmountReturn);
        }

        private void txtProductSearch_TextChanged(object sender, EventArgs e)
        {
            loadSaleInvoices();
        }

        private void dtpSaleFromDate_ValueChanged(object sender, EventArgs e)
        {
            loadSaleInvoices();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        private void loadSaleInvoices( string ITEMID="")
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " ";
            if (txtInvoiceSearch.Text=="")
            {
                SqlString = @" select Distinct data_salePosInfo.SalePosID,SALEPOSNO,data_salePosInfo.TaxAmount,GrossAmount,OtherCharges,NetAmount,AmountReceive,AmountReturn
  from data_salePosInfo
   inner join data_SalePosDetail
 on data_SalePosDetail.SalePosID = data_SalePosInfo.SalePosID
 where SalePosDate ='" + dtpSaleFromDate.Text + "' and CounterID="+CompanyInfo.CounterID+" ";
            }
            else
            {
                SqlString = @" select Distinct data_salePosInfo.SalePosID,SALEPOSNO,data_salePosInfo.TaxAmount,GrossAmount,OtherCharges,NetAmount,AmountReceive,AmountReturn
  from data_salePosInfo
   inner join data_SalePosDetail
 on data_SalePosDetail.SalePosID = data_SalePosInfo.SalePosID where SalePosDate='" + dtpSaleFromDate.Text + "' and  CounterID=" + CompanyInfo.CounterID + " and SalePosNO like '" + txtInvoiceSearch.Text+"%'";
            }
            if(!string.IsNullOrEmpty(ITEMID))
            {
                SqlString += " and data_SalePosDetail.ItemID=" + ITEMID + "";
            }
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            if (dt.Rows.Count > 0)
            {
                dgvSaleInvoices.DataSource = dt;
                txtItemID.Clear();
            }
            else
            {
                this.dgvSaleInvoices.DataSource = null;
                dgvSaleInvoices.Rows.Clear();
                dgvSaleInvoices.Refresh();
                txtItemID.Clear();
            }
        }

        private void txtInvoiceSearch_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!(Char.IsDigit(e.KeyChar) || (e.KeyChar == (char)Keys.Back)))
                e.Handled = true;
        }

        private void dgvSaleInvoices_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
          
        }

        private void dgvSaleInvoices_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)13)
            {
                
              
            }
        }
        private void ResultReturn(int Index)
        {
          
            if (Index > 0)
            {
                DataGridViewRow dgr = dgvSaleInvoices.Rows[Index];
                SaleInvoiceNo = dgr.Cells["SalePOSNO"].Value.ToString();
                SaleInvoiceDate = dtpSaleFromDate.Value;
                this.DialogResult = DialogResult.OK;
                this.Close();
            }
            else if (Index == 0)
            {
                DataGridViewRow dgr = dgvSaleInvoices.Rows[0];
                SaleInvoiceNo = dgr.Cells["SalePOSNO"].Value.ToString();
                SaleInvoiceDate = dtpSaleFromDate.Value;
                this.DialogResult = DialogResult.OK;
                this.Close();
            }
        }

        private void txtInvoiceSearch_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                dtpSaleFromDate.Select();
                dtpSaleFromDate.Focus();
            }
        }

        private void dtpSaleFromDate_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                dgvSaleInvoices.Select();
                dgvSaleInvoices.Focus();
            }
        }

        private void panel2_Paint(object sender, PaintEventArgs e)
        {

        }

        private void dgvSaleInvoices_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            int index = dgvSaleInvoices.SelectedRows[0].Index;
            ResultReturn(index);
        }

        private void dgvSaleInvoices_KeyDown(object sender, KeyEventArgs e)
        {

            if (e.KeyCode == Keys.Enter)
            {
                int rowIndex = dgvSaleInvoices.CurrentCell.OwningRow.Index;
                ResultReturn(rowIndex);
            }
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
                                inner join InventCategory on InventItems.CategoryID=InventCategory.CategoryID 
                                ";

            if (productID != 0)
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
            if (!string.IsNullOrEmpty(txtProductCode.Text))
            {
                if (e.KeyCode == Keys.Enter)
                {
                    var ItemID = Convert.ToInt32(string.IsNullOrEmpty(txtItemID.Text) ? "0" : txtItemID.Text);
                    if (ItemID == 0)
                    {
                        string BarcodeNumber = Convert.ToString(txtProductCode.Text).Trim();
                        var Length = BarcodeNumber.Length;
                        if (Length >= 13)
                        {

                            if (!string.IsNullOrEmpty(BarcodeNumber))
                            {

                                var BarcodeStd = Convert.ToInt32(BarcodeNumber.Substring(0, 2));
                                var ItemCode = Convert.ToInt32(BarcodeNumber.Substring(2, 5));
                                var BarQuantity = Convert.ToDecimal(BarcodeNumber.Substring(6 + 1));
                                var test = BarcodeNumber.Substring(2, 5);
                                DataTable dt = getProduct(0, ItemID, Convert.ToString(ItemCode).Trim());
                                var text = BarcodeNumber.Substring(6 + 1);
                                if (dt.Rows.Count > 0)
                                {


                                    loadSaleInvoices(Convert.ToString(dt.Rows[0]["ItemId"]));


                                }
                                return;

                            }
                        }
                        else
                        {
                            DataTable dt = getProduct(0, ItemID, Convert.ToString(BarcodeNumber).Trim());
                            //var text = BarcodeNumber.Substring(6 + 1);
                            if (dt.Rows.Count > 0)
                            {


                                loadSaleInvoices(Convert.ToString(dt.Rows[0]["ItemId"]));
                                return;

                            }
                        }

                    }




                    using (frmProductLookUp obj = new frmProductLookUp(0))
                    {
                        if (obj.ShowDialog() == DialogResult.OK)
                        {
                            int id = obj.ProductID;
                            txtItemID.Text = id.ToString();
                            txtProductCode.Text = obj.ManualNumber;
                            loadSaleInvoices(Convert.ToString(txtItemID.Text));



                        }
                    }
                }

            }
            else
            {
                if(e.KeyCode==Keys.Enter)
                {
                    txtInvoiceSearch.Select();
                    txtInvoiceSearch.Focus();
                }
            }
        }
                
            
    }
}
