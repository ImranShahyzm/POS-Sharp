using BarcodeLib;
using MetroFramework.Forms;
using POS.Helper;
using POS.Report;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace POS.LookUpForms
{
    public partial class frmOnScreenBarcodePrint :MetroForm
    {
        public string SaleInvoiceNo { get; set; }

        public DateTime SaleInvoiceDate { get; set; }
        public DataTable InventoryTable = new DataTable();
        public frmOnScreenBarcodePrint()
        {
            InitializeComponent();
        }

        private void frmOnScreenBarcodePrint_Load(object sender, EventArgs e)
        {
            loadSaleInvoices();
          
            txtItemCode.Select();
            txtItemCode.Focus();

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
        public DataTable LoadInventoryTable()
        {
            DataTable dt;

            string Sql = @"SELECT   InventItems.ItemId,InventItems.ItemNumber, InventItems.ItenName, ItemModel,
                    adgen_ColorInfo.ColorTitle,
					  variantInfo.VariantDescription,
						 format(InventItems.ItemSalesPrice, '#,##0.00') as FormatSalePrice,
						 '' as Quantity
                         FROM InventItems left JOIN
                         InventUOM ON InventItems.UOMId = InventUOM.UOMId left outer JOIN
                         InventItemBrands ON InventItems.ItemBrandId = InventItemBrands.ItemBrandId  
                        LEFT JOIN InventCategory ON InventItems.CategoryID = InventCategory.CategoryID                        
                        LEFT JOIN InventItemGroup ON InventItemGroup.ItemGroupID = InventItems.ItemGroupID
						left join gen_ItemMainGroupInfo mainGroup on mainGroup.ItemMainGroupID=InventItems.ItemMainGroupID
						left join gen_ItemVariantInfo variantInfo on variantInfo.ItemVariantInfoId=InventItems.ItemVarientId
						left join  adgen_ColorInfo on adgen_ColorInfo.ColorID=InventItems.ColorID
						left join gen_ItemSubCategoryInfo on gen_ItemSubCategoryInfo.SubCategoryId=InventItems.SubCategoryID where 0=0";

           

            dt = new DataTable();
            dt = STATICClass.SelectAllFromQuery(Sql).Tables[0];
            return dt;
        }

        private void loadSaleInvoices()
        {

            if (InventoryTable.Rows.Count <= 0)
            {
                InventoryTable = LoadInventoryTable();
            }

                if (InventoryTable.Rows.Count > 0)
            {
                //dgvSaleInvoices.AutoGenerateColumns = false;
                dgvSaleInvoices.DataSource = InventoryTable;
                dgvSaleInvoices.Columns[0].ReadOnly = true;
                dgvSaleInvoices.Columns[1].ReadOnly = true;
                dgvSaleInvoices.Columns[2].ReadOnly = true;
                dgvSaleInvoices.Columns[3].ReadOnly = true;
                dgvSaleInvoices.Columns[4].ReadOnly = true;
                dgvSaleInvoices.Columns[5].ReadOnly = true;
                dgvSaleInvoices.Columns[6].ReadOnly = true;
                dgvSaleInvoices.Columns[7].ReadOnly = false;

                dgvSaleInvoices.Columns[1].HeaderText ="Item Code";
                dgvSaleInvoices.Columns[2].HeaderText = "Article Name";
                dgvSaleInvoices.Columns[2].Width = 183;
                dgvSaleInvoices.Columns[3].HeaderText = "Model";
                dgvSaleInvoices.Columns[4].HeaderText = "Color Title";
                dgvSaleInvoices.Columns[5].HeaderText = "Size";
                dgvSaleInvoices.Columns[6].HeaderText = "Sale Price";
                dgvSaleInvoices.Columns[0].Visible = false;

              
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
            //for (int i = 0; i < dgvSaleInvoices.Rows.Count; i++)
            //{
            //    IssuedQty = IssuedQty + (Convert.ToInt32(dgvSaleInvoices.Rows[i].Cells[5].Value));

            //    Received = Received + (Convert.ToInt32(dgvSaleInvoices.Rows[i].Cells[7].Value));


            //}
          
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
            string searchValue = txtItemCode.Text;
            try
            {
                //BindingSource bs = new BindingSource();
                //bs.DataSource = dgvSaleInvoices.DataSource;
                //bs.Filter = dgvSaleInvoices.Columns["ItemNumber"].ToString() + " LIKE '%" + searchValue + "%'";
                //bs.Filter = "Age < 21";

                //dgvSaleInvoices.DataSource = bs;
                //(dgvSaleInvoices.DataSource as DataTable).DefaultView.RowFilter = String.IsNullOrEmpty(searchValue) ?
                //    "lename IS NOT NULL" :
                //    String.Format("ItemNumber LIKE '{0}' OR ItenName LIKE '{1}' OR ItemModel LIKE '{2}' OR ColorTitle LIKE '{3}'", searchValue, searchValue, searchValue, searchValue);
                DataRow[] dr = (InventoryTable).Select("ItemNumber LIKE '%"+ searchValue + "%' OR ItenName LIKE '%" + searchValue + "%' OR ItemModel LIKE '%" + searchValue + "%' OR ColorTitle LIKE '%" + searchValue + "%'");
                var re = from row in InventoryTable.AsEnumerable()
                         where row[1].ToString().Contains(searchValue) || row[2].ToString().Contains(searchValue) || row[3].ToString().Contains(searchValue)
                         || row[4].ToString().Contains(searchValue)
                         select row;
                if (re.Count() == 0)
                {

                }
                else
                {
                    dgvSaleInvoices.DataSource = re.CopyToDataTable();
                }
            }
            catch (Exception ex)
            {

            }
        }
            



            

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void txtItemCode_KeyDown(object sender, KeyEventArgs e)
        {
          
        }
        public bool InsertKhaaki(DataTable detailDt,ref Int32 PrintId)
        {
             
            DataTable dt = new DataTable();
            SqlConnection con = new SqlConnection(STATICClass.Connection());
            SqlTransaction tran; con.Open(); tran = con.BeginTransaction();
            SqlCommand cmd = new SqlCommand("data_BarcodeKhaaki_Insert_Desktop", con);
            cmd.CommandType = CommandType.StoredProcedure; SqlDataAdapter da = new SqlDataAdapter();
            SqlParameter p = new SqlParameter("@PrintId",PrintId);
            p.Direction = ParameterDirection.InputOutput; cmd.Parameters.Add(p);
            cmd.Parameters.Add(new SqlParameter("@CompanyID", CompanyInfo.CompanyID));
            cmd.Parameters.Add(new SqlParameter("@UserID", CompanyInfo.UserID));
            cmd.Parameters.Add(new SqlParameter("@PrintDate",System.DateTime.Now));
            cmd.Parameters.Add(new SqlParameter("@data_barcodePrintDesktopDetail", detailDt));
            da.SelectCommand = cmd;
            try
            {
                cmd.Transaction = tran;
                da.Fill(dt);
                tran.Commit();
                PrintId = Convert.ToInt32(p.Value.ToString());
            }
            catch (Exception ex)
            {
                tran.Rollback();
                return false;
            }
            finally
            {
                con.Close();
            }
            return true;

        }

        public DataTable khaakiBarcodeImagesCreate(ref DataTable dt, string Path)
        {
            foreach (DataRow row in dt.Rows)
            {
                if (!string.IsNullOrEmpty(Convert.ToString(row["ItemNumber"])))
                {
                    row["ImagePath"] = SetBarcodeUsingBarcodeLib(row["ItemNumber"].ToString(), Path);
                }
            }
            return dt;
        }
        public string SetBarcodeUsingBarcodeLib(string id, string Path)
        {
            Barcode barcodLib = new Barcode();
            int imageWidth = 200;  // barcode image width
            int imageHeight = 50; //barcode image height
            Color foreColor = Color.Black; // Color to print barcode
            Color backColor = Color.White; //background color
            //numeric string to generate barcode
            string NumericString = id.Trim();
            // Generate the barcode with your settings
            Image myimg = barcodLib.Encode(TYPE.CODE11, NumericString, foreColor, backColor, imageWidth, imageHeight);

            
            
            string path = Path;
            myimg.Save(path + "\\" + id + ".png", ImageFormat.Png);
            return path + "\\" + id + ".png";

        }

        private void btnPrint_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dt = new DataTable();
                dt = (DataTable)dgvSaleInvoices.DataSource;
                var Result = dt.AsEnumerable().Where(x => Convert.ToString(x["Quantity"]) != "").ToList();
                DataTable dEtailt = new DataTable();
                dEtailt = Result.CopyToDataTable();
                dEtailt.Columns.Add("ImagePath");
                string BarcodeImage = Path.Combine(Application.StartupPath, "Images", "");
                khaakiBarcodeImagesCreate(ref dEtailt, BarcodeImage);
                // dEtailt.Columns[]
                int PrintId = 0;
                var CheckIfInserted = InsertKhaaki(dEtailt, ref PrintId);
                if (PrintId > 0)
                {
                    using (frmCrystal obj = new frmCrystal())
                    {
                        string reportName = "";
                        string WhereClause = "";
                        //reportName = "STOCKREPORT";

                        obj.KhaakiBarcodePrints(PrintId);

                    };
                    loadSaleInvoices();
                }
            }catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
          
            }

        }

    }
}
