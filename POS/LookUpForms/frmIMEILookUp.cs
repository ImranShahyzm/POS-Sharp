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
    public partial class frmIMEILookUp : Form
    {
        public int ItemID { get; set; }
        public int Searchable_ItemID { get; set; }
        public string Searchable_ItemName { get; set; }
        public string IMEINumber_forSelect { get; set; }
        public frmIMEILookUp(int ItemIDParam = 0, string ItemNameParam = "")
        {
            InitializeComponent();
            Searchable_ItemID = ItemIDParam;
            Searchable_ItemName = ItemNameParam;
            lblItemNameDisplay.Text = "Item : " + Searchable_ItemName;
            loadIMEIs();
        }
        
        private void frmIMEILookUp_Load(object sender, EventArgs e)
        {
            txtIMEISearch.Select();
            txtIMEISearch.Focus();
        }
        private DataTable IMEITable(string Where = "")
        {
            Where += " and b.ItemId=" + Searchable_ItemID + "  ";
            return STATICClass.IMEISearch_SelectAll(CompanyInfo.WareHouseID, CompanyInfo.CompanyID, Where);
        }
        private void loadIMEIs()
        {
            DataTable dt = new DataTable();
            dt = IMEITable();
            dgvIMEIs.DataSource = dt;
            this.dgvIMEIs.Columns["Param1"].Width = 160;
            this.dgvIMEIs.Columns["Param2"].Width = 160;
            this.dgvIMEIs.Columns["Param3"].Visible = false;
            this.dgvIMEIs.Columns["IMEINumber"].Visible = false;
            this.dgvIMEIs.Columns["ItemId"].Visible = false;
            this.dgvIMEIs.Columns["Quantity"].Width = 80;
        }
        
        private void txtIMEISearch_TextChanged(object sender, EventArgs e)
        {
            string searchValue = txtIMEISearch.Text;
            DataTable dt = new DataTable();
            string Where = "";
            if (searchValue != null && searchValue != "")
            {
                Where = $@"  and (b.Param1 LIKE '%{searchValue}%' OR b.Param2 LIKE '%{searchValue}%' ) ";
            }
            dt = IMEITable(Where);
            dgvIMEIs.DataSource = dt;
            this.dgvIMEIs.Columns["Param1"].Width = 160;
            this.dgvIMEIs.Columns["Param2"].Width = 160;
            this.dgvIMEIs.Columns["Param3"].Visible = false;
            this.dgvIMEIs.Columns["IMEINumber"].Visible = false;
            this.dgvIMEIs.Columns["ItemId"].Visible = false;
            this.dgvIMEIs.Columns["Quantity"].Width = 80;
        }
        
        private void dgvIMEIs_DoubleClick(object sender, EventArgs e)
        {

        }

        private void dgvIMEIs_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            string value = dgvIMEIs.Rows[e.RowIndex].Cells["ItemId"].Value.ToString();
            string IMEINo = dgvIMEIs.Rows[e.RowIndex].Cells["IMEINumber"].Value.ToString();

            ItemID = Convert.ToInt32(value);
            IMEINumber_forSelect = IMEINo;

            this.DialogResult = DialogResult.OK;
            this.Close();
        }

     
        private void dgvIMEIs_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)13)
            {
                //int rowIndex = dgvIMEIs.CurrentCell.OwningRow.Index;
                int rowIndex = -1;
                if (dgvIMEIs.Rows.Count > 0)
                {
                    rowIndex = dgvIMEIs.SelectedRows[0].Index - 1;
                }
                ResultReturn(rowIndex);

            }
        }
        private void ResultReturn(int Index)
        {
            if (Index >= 0)
            {
                DataGridViewRow row = dgvIMEIs.Rows[Index];
                string value = row.Cells["ItemId"].Value.ToString();
                string IMEINo = row.Cells["IMEINumber"].Value.ToString();

                ItemID = Convert.ToInt32(value);
                IMEINumber_forSelect = IMEINo;

                this.DialogResult = DialogResult.OK;
                this.Close();
            }
            
        }


        private void txtIMEISearch_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                dgvIMEIs.Focus();
            }
            if (e.KeyCode == Keys.Escape)
            {
                this.DialogResult = DialogResult.Cancel;
                this.Close();
            }
        }

        
    }
}
