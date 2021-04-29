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
    public partial class frmProductLookUp : Form
    {
        public int ProductID { get; set; }
        public string ManualNumber { get; set; }
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
            string SqlString = " select ItemId,ItenName as Product,ManualNumber from InventItems left join InventCategory on InventCategory.CategoryID=InventItems.CategoryID left join InventItemGroup on InventItemGroup.ItemGroupID=InventCategory.ItemGroupID ";
            if(MainGroupId>0)
            {
                SqlString=SqlString+ " where InventCategory.ItemGroupID=" + MainGroupId+"";
            }
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            dgvProducts.DataSource = dt;
            this.dgvProducts.Columns["ItemId"].Visible = false;
            this.dgvProducts.Columns["Product"].Width = 250;
        }

        private void txtProductSearch_TextChanged(object sender, EventArgs e)
        {
            string searchValue = txtProductSearch.Text;
            string SqlString = " select ItemId,ItenName as Product,ManualNumber from InventItems left join InventCategory on InventCategory.CategoryID=InventItems.CategoryID left join InventItemGroup on InventItemGroup.ItemGroupID=InventCategory.ItemGroupID  where ManualNumber= '" + searchValue + "'";
            if (searchValue=="")
            {
                
                SqlString = " select ItemId,ItenName as Product,ManualNumber from InventItems left join InventCategory on InventCategory.CategoryID=InventItems.CategoryID left join InventItemGroup on InventItemGroup.ItemGroupID=InventCategory.ItemGroupID  where 0=0";
            }
            else
            {
                SqlString = " select ItemId,ItenName as Product,ManualNumber from InventItems left join InventCategory on InventCategory.CategoryID=InventItems.CategoryID left join InventItemGroup on InventItemGroup.ItemGroupID=InventCategory.ItemGroupID  where ManualNumber= '" + searchValue + "'";
            }
            if (Convert.ToDecimal(txtMainGroupID.Text)>0)
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
            if(dt.Rows.Count<=0)
            {
                SearchByName();
            }
            
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
            string manualNumber = dgvProducts.Rows[e.RowIndex].Cells["ManualNumber"].Value.ToString();
            ManualNumber = manualNumber;
            ProductID = Convert.ToInt32(value);
            this.DialogResult = DialogResult.OK;
            this.Close();
        }

     
        private void dgvProducts_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)13)
            {
                DataGridViewRow dgr = dgvProducts.Rows[dgvProducts.CurrentRow.Index-1];
                string value = dgr.Cells["ItemId"].Value.ToString();
                string manualNumber = dgr.Cells["ManualNumber"].Value.ToString();
                ManualNumber = manualNumber;
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
        }
    }
}
