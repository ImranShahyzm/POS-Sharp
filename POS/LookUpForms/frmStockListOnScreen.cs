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
    public partial class frmStockListOnScreen :MetroForm
    {
        public string SaleInvoiceNo { get; set; }

        public DateTime SaleInvoiceDate { get; set; }
        public frmStockListOnScreen()
        {
            InitializeComponent();
        }

        private void frmStockListOnScreen_Load(object sender, EventArgs e)
        {
            loadSaleInvoices();
            CalculateDetail();
            txtDescription.Select();
            txtDescription.Focus();

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
        public DataTable ItemStockReport(int CompanyID, string ReportName, DateTime dateTo, int CategoryID = 0, DateTime? RegisterFrom = null, DateTime? RegitserTo = null, int MenuID = 0)
        {
            DataTable dt;

            string Sql = @"
           select InventItems.ItemNumber as ProductCode,InventItems.ItenName as Description,varnt.VariantDescription as Size,ab.ColorTitle, InventItems.ItemSalesPrice as RetailPrice,";

            Sql += @"  isnull(sum(Quantity) ,0) ";

            Sql += @"as Quantity ,  InventCategory.CategoryName,isnull(sum(Quantity) ,0)*InventItems.ItemSalesPrice as NetAmount 
             from (
            select a.StockRate * a.Quantity as Amount,a.Quantity ,a.ItemId   from data_ProductInflow a inner join  InventItems b on a.ItemId =b.ItemId
            left join InventCategory c on b.CategoryID = c.CategoryID where 0 = 0 ";


            if (CategoryID > 0)
            {
                Sql += " and b.CategoryID = " + CategoryID;
            }
            
            Sql += " and a.StockDate <= '" + dateTo + "' ";
            Sql += " and a.CompanyID = " + CompanyID;
            Sql += @" union all 
select - a.StockRate * a.Quantity as Amount,-a.Quantity as Quantity ,a.ItemId from data_ProductOutflow a inner join  InventItems b on a.ItemId =
b.ItemId left join InventCategory c on b.CategoryID = c.CategoryID where 0 = 0 ";
            
            if (CategoryID > 0)
            {
                Sql += " and b.CategoryID = " + CategoryID;
            }
          
            Sql += " and a.StockDate <= '" + dateTo + "' ";
            Sql += " and a.CompanyID = " + CompanyID;
            Sql += @" )s   inner join  InventItems  on s.ItemId = InventItems.ItemId
 inner join InventUOM on InventItems.UOMId = InventUOM.UOMId
left join InventCategory on InventCategory.CategoryID=InventItems.CategoryID
 left join InventItemGroup on InventItemGroup.ItemGroupID=InventCategory.CategoryID
left join adgen_ColorInfo ab on ab.ColorID=InventItems.ColorID
 left join gen_ItemVariantInfo varnt on varnt.ItemVariantInfoId=InventItems.ItemVarientId where 0=0";
            if (RegisterFrom != null && RegitserTo != null)
            {
                Sql += " and Isnull(RegisterInevntoryDate,'01-01-2017') between '" + RegisterFrom + "' and '" + RegitserTo + "'";
            }
            if (!CompanyInfo.isKhaakiSoft && MenuID > 0)
            {
                Sql += " and  InventCategory.ItemGroupID=" + MenuID + " ";
            }
            if(!string.IsNullOrEmpty(txtItemCode.Text))
            {
                Sql += " and InventItems.ItemNumber like '%" + txtItemCode.Text + "'";
            }
            if (!string.IsNullOrEmpty(txtDescription.Text))
            {
                Sql += " and REPLACE (InventItems.ItenName,'-','')  like '%" + txtDescription.Text + "%'";
            }
            Sql += @" group by s.ItemId , InventItems.ItenName ,InventItems.ReOrderLevel, InventUOM.UOMName ,InventItems.CategoryID,InventCategory.ItemGroupID, 
InventCategory.CategoryName, InventItemGroup.ItemGroupName,RegisterInevntoryDate,CartonSize,Itemnumber,VariantDescription,ColorTitle,ItemSalesPrice";

            dt = new DataTable();
            dt = STATICClass.SelectAllFromQuery(Sql).Tables[0];
            return dt;
        }

        private void loadSaleInvoices()
        {

            DataTable dt = new DataTable();
            dt = ItemStockReport(CompanyInfo.CompanyID, "", System.DateTime.Now.Date);
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
        private void CalculateDetail()
        {
            int IssuedQty = 0;
            int Received = 0;
            for (int i = 0; i < dgvSaleInvoices.Rows.Count; i++)
            {
                IssuedQty = IssuedQty + (Convert.ToInt32(dgvSaleInvoices.Rows[i].Cells[5].Value));

                Received = Received + (Convert.ToInt32(dgvSaleInvoices.Rows[i].Cells[7].Value));


            }
            txtTotal.Text = IssuedQty.ToString();
            txtReceived.Text = Received.ToString();
        }
        private void txtInvoiceSearch_KeyPress(object sender, KeyPressEventArgs e)
        {
        
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
          
            //if (Index > 0)
            //{
            //    DataGridViewRow dgr = dgvSaleInvoices.Rows[Index];
            //    SaleInvoiceNo = dgr.Cells["SalePOSNO"].Value.ToString();
            //    SaleInvoiceDate = dtpSaleFromDate.Value;
            //    this.DialogResult = DialogResult.OK;
            //    this.Close();
            //}
            //else if (Index == 0)
            //{
            //    DataGridViewRow dgr = dgvSaleInvoices.Rows[0];
            //    SaleInvoiceNo = dgr.Cells["SalePOSNO"].Value.ToString();
            //    SaleInvoiceDate = dtpSaleFromDate.Value;
            //    this.DialogResult = DialogResult.OK;
            //    this.Close();
            //}
        }

        private void txtInvoiceSearch_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                //dtpSaleFromDate.Select();
                //dtpSaleFromDate.Focus();
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

        private void txtItemCode_KeyPress(object sender, KeyPressEventArgs e)
        {
            loadSaleInvoices();
        }

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void txtItemCode_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {

                txtDescription.Select();
                txtDescription.Focus();

            }
        }
    }
}
