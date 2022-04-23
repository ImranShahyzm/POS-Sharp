using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using POS.Helper;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace POS.LookUpForms
{
    public partial class frmProductLookUp : Form
    {
        public int ProductID { get; set; }
        public string ManualNumber { get; set; }
        public string ItemNumber { get; set; }
        public frmProductLookUp(int GroupId=0)
        {
            InitializeComponent();
            loadProducts(GroupId);
            txtMainGroupID.Text = GroupId.ToString();
        }
        bool onload = false;
        //public frmProductLookUp(string manualNumber)
        //{
        //    InitializeComponent();
        //}

        private void frmProductLookUp_Load(object sender, EventArgs e)
        {
            txtProductSearch.Select();
            txtProductSearch.Focus();
        }

        private void SetupDataGridView()
        {

            var ID = new DataGridViewTextBoxColumn();
            ID.Name = "ID";
            ID.HeaderText = "ID";
            ID.Visible = false;

            var Product = new DataGridViewTextBoxColumn();
            Product.Name = "ItenName";
            Product.HeaderText = "ItenName";
            Product.Width = 180;

            var ManualNumber = new DataGridViewTextBoxColumn();
            ManualNumber.Name = "ManualNumber";
            ManualNumber.HeaderText = "ManualNumber";
            ManualNumber.Width = 180;


            dgvProducts.Columns.Add(ID);
            dgvProducts.Columns.Add(Product);
            dgvProducts.Columns.Add(ManualNumber);

        }
        private void loadProducts(int MainGroupId=0)
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();

            //string SqlString = " select ItemId,ItenName as Product,ManualNumber from InventItems left join InventCategory on InventCategory.CategoryID=InventItems.CategoryID left join InventItemGroup on InventItemGroup.ItemGroupID=InventCategory.ItemGroupID ";
            //if(MainGroupId>0)
            //{
            //    SqlString=SqlString+ " where InventCategory.ItemGroupID=" + MainGroupId+"";
            //}
            string SqlString = "";
            if (CompanyInfo.isKhaakiSoft == true)
            {
                SqlString = ItemSearchSQL("", MainGroupId);
            }
            else
            {
                SqlString = ItemSearchSQLWithItemNumber("", MainGroupId);
            }
            

            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            dgvProducts.DataSource = dt;
            this.dgvProducts.Columns["ItemId"].Visible = false;
            this.dgvProducts.Columns["Product"].Width = 250;
        }

        private string ItemSearchSQL(string SearchVal = "", int MainGroupId = 0)
        {
            string WHERE = " WHERE 0=0 ";
            
            if (MainGroupId > 0)
            {
                WHERE += " and ( InventCategory.ItemGroupID=" + MainGroupId + "";
                if (SearchVal != null && SearchVal != "")
                {
                    WHERE += " or InventItems.ManualNumber like '%" + SearchVal + "%' or InventItems.ItenName like '%" + SearchVal + "%'  ";
                }
                WHERE += " ) ";
            }
            else
            {
                if (SearchVal != null && SearchVal != "")
                {
                    WHERE += " and ( InventItems.ManualNumber like '%" + SearchVal + "%' or InventItems.ItenName like '%" + SearchVal + "%'  ) ";
                }
            }
            
            string SqlString = $@"  select InventItems.ItemId, ManualNumber , InventItems.ItenName as Product, ISNULL(SUM(s.Quantity) , 0) as StockQty from 
 InventItems
 left join InventCategory on InventCategory.CategoryID = InventItems.CategoryID
 left join InventItemGroup on InventItemGroup.ItemGroupID = InventCategory.ItemGroupID
 left join
 (

    select a.Quantity , a.ItemId
    from data_ProductInflow a

        inner join  InventItems b on a.ItemId = b.ItemId

        left join InventCategory c on b.CategoryID = c.CategoryID

    where 0 = 0   and a.CompanyID = {CompanyInfo.CompanyID}

union all


    select - a.Quantity as Quantity ,a.ItemId
     from data_ProductOutflow a

        inner join  InventItems b on a.ItemId = b.ItemId

        left join InventCategory c on b.CategoryID = c.CategoryID

    where 0 = 0   and a.CompanyID = {CompanyInfo.CompanyID}

)  s ON InventItems.ItemId = s.ItemId

{WHERE}

GROUP BY InventItems.ItemId, ItenName , ManualNumber ";

            return SqlString;
        }

        private string ItemSearchSQLWithItemNumber(string SearchVal = "", int MainGroupId = 0)
        {
            string WHERE = " WHERE 0=0 ";

            if (MainGroupId > 0)
            {
                WHERE += " and ( InventCategory.ItemGroupID=" + MainGroupId + "";
                if (SearchVal != null && SearchVal != "")
                {
                    WHERE += " or InventItems.ItemNumber like '%" + SearchVal + "%' or InventItems.ItenName like '%" + SearchVal + "%'  ";
                }
                WHERE += " ) ";
            }
            else
            {
                if (SearchVal != null && SearchVal != "")
                {
                    WHERE += " and ( InventItems.ItemNumber like '%" + SearchVal + "%' or InventItems.ItenName like '%" + SearchVal + "%'  ) ";
                }
            }

            string SqlString = $@"  select InventItems.ItemId, InventItems.ItemNumber, InventItems.ItenName as Product, ISNULL(SUM(s.Quantity) , 0) as [Stock Qty] from 
 InventItems
 left join InventCategory on InventCategory.CategoryID = InventItems.CategoryID
 left join InventItemGroup on InventItemGroup.ItemGroupID = InventCategory.ItemGroupID
 left join
 (

    select a.Quantity , a.ItemId
    from data_ProductInflow a

        inner join  InventItems b on a.ItemId = b.ItemId

        left join InventCategory c on b.CategoryID = c.CategoryID

    where 0 = 0   and a.CompanyID = {CompanyInfo.CompanyID}

union all


    select - a.Quantity as Quantity ,a.ItemId
     from data_ProductOutflow a

        inner join  InventItems b on a.ItemId = b.ItemId

        left join InventCategory c on b.CategoryID = c.CategoryID

    where 0 = 0   and a.CompanyID = {CompanyInfo.CompanyID}

)  s ON InventItems.ItemId = s.ItemId

{WHERE}

GROUP BY InventItems.ItemId, ItenName , InventItems.ItemNumber ";

            return SqlString;
        }

        private void txtProductSearch_TextChanged(object sender, EventArgs e)
        {
            string searchValue = txtProductSearch.Text;

            //string SqlString = " select ItemId,ItenName as Product,ManualNumber from InventItems left join InventCategory on InventCategory.CategoryID=InventItems.CategoryID left join InventItemGroup on InventItemGroup.ItemGroupID=InventCategory.ItemGroupID  where ManualNumber= '" + searchValue + "'";
            //if (searchValue=="")
            //{

            //    SqlString = " select ItemId,ItenName as Product,ManualNumber from InventItems left join InventCategory on InventCategory.CategoryID=InventItems.CategoryID left join InventItemGroup on InventItemGroup.ItemGroupID=InventCategory.ItemGroupID  where 0=0";
            //}
            //else
            //{
            //    SqlString = " select ItemId,ItenName as Product,ManualNumber from InventItems left join InventCategory on InventCategory.CategoryID=InventItems.CategoryID left join InventItemGroup on InventItemGroup.ItemGroupID=InventCategory.ItemGroupID  where ManualNumber= '" + searchValue + "'";
            //}
            //if (Convert.ToDecimal(txtMainGroupID.Text)>0)
            //{
            //    SqlString = SqlString + " and InventCategory.ItemGroupID=" + Convert.ToInt32(txtMainGroupID.Text) + "";
            //}

            string SqlString = "";
            if (CompanyInfo.isKhaakiSoft == true)
            {
                SqlString = ItemSearchSQL(searchValue, Convert.ToInt32("0" + txtMainGroupID.Text));
            }
            else
            {
                SqlString = ItemSearchSQLWithItemNumber(searchValue, Convert.ToInt32("0" + txtMainGroupID.Text));
            }
            
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            dgvProducts.DataSource = dt;
            this.dgvProducts.Columns["ItemId"].Visible = false;
            this.dgvProducts.Columns["Product"].Width = 250;
            //if(dt.Rows.Count<=0)
            //{
            //    SearchByName();
            //}
            
        }
        private void SearchByName()
        {
            string searchValue = txtProductSearch.Text;
            string SqlString = " select ItemId,ItenName as Product,ManualNumber from InventItems left join InventCategory on InventCategory.CategoryID=InventItems.CategoryID left join InventItemGroup on InventItemGroup.ItemGroupID=InventCategory.ItemGroupID where ItenName like '%" + searchValue + "%'";
            if (searchValue == "")
            {
                SqlString = " select ItemId,ItenName as Product,ManualNumber from InventItems left join InventCategory on InventCategory.CategoryID=InventItems.CategoryID left join InventItemGroup on InventItemGroup.ItemGroupID=InventCategory.ItemGroupID where 0=0";
            }
            else
            {
                SqlString = " select ItemId,ItenName as Product,ManualNumber from InventItems left join InventCategory on InventCategory.CategoryID=InventItems.CategoryID left join InventItemGroup on InventItemGroup.ItemGroupID=InventCategory.ItemGroupID where ItenName like '%" + searchValue + "%'";
            }
            if (Convert.ToDecimal(txtMainGroupID.Text) > 0)
            {
                SqlString = SqlString + " and InventCategory.ItemGroupID=" + Convert.ToInt32(txtMainGroupID.Text) + "";
            }
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            dgvProducts.DataSource = dt;
            this.dgvProducts.Columns["ItemId"].Visible = false;
            this.dgvProducts.Columns["Product"].Width = 250;
        }
        private void dgvProducts_DoubleClick(object sender, EventArgs e)
        {

        }

        private void dgvProducts_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            string value = dgvProducts.Rows[e.RowIndex].Cells["ItemId"].Value.ToString();
            string ManualNo = "", ItemNo = "";
            if (CompanyInfo.isKhaakiSoft == true)
            {
                ManualNo = dgvProducts.Rows[e.RowIndex].Cells["ManualNumber"].Value.ToString();
            }
            else
            {
                ItemNo = dgvProducts.Rows[e.RowIndex].Cells["ItemNumber"].Value.ToString();
            }
            ManualNumber = ManualNo;
            ItemNumber = ItemNo;

            ProductID = Convert.ToInt32(value);
            this.DialogResult = DialogResult.OK;
            this.Close();
        }

     
        private void dgvProducts_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)13)
            {
                //int rowIndex = dgvProducts.CurrentCell.OwningRow.Index;
                int rowIndex = dgvProducts.SelectedRows[0].Index-1;
                ResultReturn(rowIndex);
              
             
            }
        }
        private void ResultReturn(int Index)
        {

            if (Index > 0)
            {
                DataGridViewRow dgr = dgvProducts.Rows[Index];
                string value = dgr.Cells["ItemId"].Value.ToString();
                string ManualNo = "", ItemNo = "";
                if (CompanyInfo.isKhaakiSoft == true)
                {
                    ManualNo = dgr.Cells["ManualNumber"].Value.ToString();
                }
                else
                {
                    ItemNo = dgr.Cells["ItemNumber"].Value.ToString();
                }
                ManualNumber = ManualNo;
                ItemNumber = ItemNo;
                
                ProductID = Convert.ToInt32(value);
                this.DialogResult = DialogResult.OK;
                this.Close();
            }
            else if (Index == 0)
            {
                DataGridViewRow dgr = dgvProducts.Rows[0];
                string value = dgr.Cells["ItemId"].Value.ToString();
                string ManualNo = "", ItemNo = "";
                if (CompanyInfo.isKhaakiSoft == true)
                {
                    ManualNo = dgr.Cells["ManualNumber"].Value.ToString();
                }
                else
                {
                    ItemNo = dgr.Cells["ItemNumber"].Value.ToString();
                }
                ManualNumber = ManualNo;
                ItemNumber = ItemNo;
                
                ProductID = Convert.ToInt32(value);
                this.DialogResult = DialogResult.OK;
                this.Close();
            }
        }


        private void txtProductSearch_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                dgvProducts.Focus();
            }
            if (e.KeyCode == Keys.Escape)
            {
                this.DialogResult = DialogResult.Cancel;
                this.Close();
            }
        }

        
    }
}
