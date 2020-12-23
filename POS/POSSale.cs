using System;
using System.Configuration;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using POS.LookUpForms;
using CrystalDecisions.CrystalReports.Engine;
using POS.Report;
using POS.Helper;

namespace POS
{
    public partial class frmPOSSale : Form
    {
        public bool directReturn = false;
        public int SaleInvoiceNo = 0;
        public int SalePosMasterID = 0;
        public decimal netAmountForReturn = 0;

        public bool SaleReturn = false;
        public frmPOSSale()
        {
            InitializeComponent();
            //SetupDataGridView();
            timer1.Start();
            laodCategories();
            loadProducts();

            loadNewSale();

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
        private void laodCategories()
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " select top 6* from InventCategory where MainCategory=1 ";
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            int firstCategory = 0;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                Button b = new Button();
                b.BackColor = Color.LimeGreen;
                b.Dock = DockStyle.Fill;
                b.FlatStyle = FlatStyle.Flat;
                b.Font = new Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));

                if (firstCategory == 0)
                {
                    firstCategory = Convert.ToInt32(dt.Rows[i]["CategoryID"].ToString());

                    DataTable dt1 = getProduct(firstCategory);

                    for (int j = 0; j < dt1.Rows.Count; j++)
                    {
                        Button b1 = new Button();
                        b1.BackColor = Color.GreenYellow;
                        b1.Dock = DockStyle.Fill;
                        b1.FlatStyle = FlatStyle.Flat;

                        b1.Font = new Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));

                        b1.Name = dt1.Rows[j]["itemid"].ToString() + "-" + dt1.Rows[j]["ItemSalesPrice"].ToString() + "-" + dt1.Rows[j]["TotalTax"].ToString() + "-" + dt1.Rows[j]["cartonSize"].ToString();
                        b1.Text = dt1.Rows[j]["itenName"].ToString();
                        b1.Click += new EventHandler(load_Products_grid);
                        if (j > 18)
                        {
                            return;
                        }
                        tlpProducts.Controls.Add(b1);
                    }

                }
                b.Name = dt.Rows[i]["CategoryID"].ToString();
                b.Text = dt.Rows[i]["CategoryName"].ToString();
                b.Click += new EventHandler(generate_Products);
                if (i > 6)
                {
                    return;
                }
                tlpProductCategories.Controls.Add(b);

            }
        }

        private void generate_Products(object sender, EventArgs e)
        {
            tlpProducts.Controls.Clear();
            string id = (sender as Button).Name;
            DataTable dt = getProduct(Convert.ToInt32(id));
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                Button b = new Button();
                b.BackColor = Color.GreenYellow;
                b.Dock = DockStyle.Fill;
                b.FlatStyle = FlatStyle.Flat;

                b.Font = new Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));

                b.Name = dt.Rows[i]["itemid"].ToString() + "-" + dt.Rows[i]["ItemSalesPrice"].ToString() + "-" + dt.Rows[i]["TotalTax"].ToString() + "-" + dt.Rows[i]["cartonSize"].ToString(); 
                b.Text = dt.Rows[i]["itenName"].ToString();
                b.Click += new EventHandler(load_Products_grid);
                if (i > 18)
                {
                    return;
                }
                tlpProducts.Controls.Add(b);
            }
        }
        private void load_Products_grid(object sender, EventArgs e)
        {
            string productName = (sender as Button).Text;
            string text = (sender as Button).Name;
            string[] values = text.Split('-');
            int id = Convert.ToInt32(values[0]);
            decimal rates = Convert.ToDecimal(values[1]);
            decimal taxes = Convert.ToDecimal(values[2]);
            decimal CartonSize = Convert.ToDecimal(values[3]);
            AddProducts(productName, id, rates, taxes, CartonSize);

            //CheckLastAmountForOpening();
        }

        private void CheckLastAmountForOpening()
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = @" select (select isnull(sum(Amount),0) as Amount from data_CashIn where Date=cast(GETDATE() as date))
                                  -
                                  (select isnull(sum(Amount),0) as Amount from data_CashOut where Date=cast(GETDATE() as date)) as Amount
                            ";
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);

            if (Convert.ToDecimal(dt.Rows[0]["Amount"]) > 0)
            {
                SaveOpening(dt.Rows[0]["Amount"].ToString());
            }
        }

        private void SaveOpening(string amount)
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            SqlTransaction tran;
            con.Open();
            tran = con.BeginTransaction();
            try
            {
            SqlCommand cmd;
            cmd = new SqlCommand("data_Cash_Insert", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@SourceID", 1);
            cmd.Parameters.AddWithValue("@SourceName", "Opening Balance");
            cmd.Parameters.AddWithValue("@Amount", amount);
            cmd.Parameters.AddWithValue("@CashType", true);
            SqlDataAdapter da = new SqlDataAdapter();
            DataTable dt1 = new DataTable();
            da.SelectCommand = cmd;
            
                cmd.Transaction = tran; da.Fill(dt1);
                tran.Commit();
                MessageBox.Show("Opening Cash In Successfully Done.");
                this.Close();
            }
            catch (Exception ex)
            {
                tran.Rollback();
                MessageBox.Show("Error is" + ex.Message);
            }
            finally
            {
                con.Close();
            }
        }
        private void frmPOSSale_Load(object sender, EventArgs e)
        {
            SetupDataGridView();
        }

        private void SetupDataGridView()
        {

            var ID = new DataGridViewTextBoxColumn();
            ID.Name = "ID";
            ID.HeaderText = "ID";
            ID.Visible = false;



            var Product = new DataGridViewTextBoxColumn();
            Product.Name = "Product";
            Product.HeaderText = "Products";
            Product.Width = 180;
            Product.ReadOnly = true;

            var Rate = new DataGridViewTextBoxColumn();
            Rate.Name = "Rate";
            Rate.HeaderText = "Rate";
            Rate.Width = 60;
            Rate.ReadOnly = true;

            var buttonPlus = new DataGridViewButtonColumn();
            buttonPlus.Name = "";
            buttonPlus.HeaderText = " ";
            buttonPlus.Width = 20;
            var buttonPlus1 = new DataGridViewButtonColumn();
            buttonPlus1.Name = "";
            buttonPlus1.HeaderText = " ";
            buttonPlus1.Width = 20;

            var Quantity = new DataGridViewTextBoxColumn();
            Quantity.Name = "Quantity";
            Quantity.HeaderText = "Quantity";
            Quantity.Width = 40;
            
            Quantity.ReadOnly = false;

            var CartonQuantity = new DataGridViewTextBoxColumn();
            CartonQuantity.Name = "Bundle";
            CartonQuantity.HeaderText = "Bundle";
            CartonQuantity.Width = 40;
            CartonQuantity.ReadOnly = true;

            var buttonSubtract = new DataGridViewButtonColumn();
            buttonSubtract.Name = "";
            buttonSubtract.HeaderText = " ";
            //buttonSubtract.Text = "+";
            buttonSubtract.Width = 20;
            var buttonSubtract1 = new DataGridViewButtonColumn();
            buttonSubtract1.Name = "";
            buttonSubtract1.HeaderText = " ";
            //buttonSubtract.Text = "+";
            buttonSubtract1.Width = 20;

            var ItemTotal = new DataGridViewTextBoxColumn();
            ItemTotal.Name = "Total";
            ItemTotal.HeaderText = "Total";
            ItemTotal.Width = 80;
            ItemTotal.ReadOnly = true;

            var buttonCol = new DataGridViewButtonColumn();
            buttonCol.Name = "Delete";
            buttonCol.HeaderText = "Manage";
            buttonCol.Text = "Delete";
            buttonCol.Width = 50;

            var ItemTax = new DataGridViewTextBoxColumn();
            ItemTax.Name = "Tax";
            ItemTax.HeaderText = "Tax";
            ItemTax.Width = 80;
            ItemTax.ReadOnly = true;

            var ItemTaxAmount = new DataGridViewTextBoxColumn();
            ItemTaxAmount.Name = "TaxAmount";
            ItemTaxAmount.HeaderText = "TaxAmount";
            ItemTaxAmount.Width = 80;
            ItemTaxAmount.ReadOnly = true;

            var CartonSize = new DataGridViewTextBoxColumn();
            CartonSize.Name = "CartonSize";
            CartonSize.HeaderText = "CartonSize";
            CartonSize.Visible = false;

            var SaleDetailID = new DataGridViewTextBoxColumn();
            SaleDetailID.Name = "SaleDetailID";
            SaleDetailID.HeaderText = "SaleDetailID";
            SaleDetailID.Visible = false;
            ItemSaleGrid.Columns.Add(ID);
            ItemSaleGrid.Columns.Add(Product);
            ItemSaleGrid.Columns.Add(Rate);
            ItemSaleGrid.Columns.Add(buttonPlus1);
            ItemSaleGrid.Columns.Add(CartonQuantity);
            ItemSaleGrid.Columns.Add(buttonSubtract1);
            ItemSaleGrid.Columns.Add(buttonPlus);
            ItemSaleGrid.Columns.Add(Quantity);
            ItemSaleGrid.Columns.Add(buttonSubtract);
            ItemSaleGrid.Columns.Add(ItemTotal);
            ItemSaleGrid.Columns.Add(buttonCol);
            ItemSaleGrid.Columns.Add(ItemTax);
            ItemSaleGrid.Columns.Add(ItemTaxAmount);
            ItemSaleGrid.Columns.Add(CartonSize);
            ItemSaleGrid.Columns.Add(SaleDetailID);
            
            //Index last 14 
        }
        private void GrossAmount_Total()
        {
            decimal sum = 0;
            decimal taxAmountTotal = 0;
            for (int i = 0; i < ItemSaleGrid.Rows.Count; ++i)
            {
                sum += Convert.ToDecimal(ItemSaleGrid.Rows[i].Cells["Total"].Value.ToString());
                taxAmountTotal += Convert.ToDecimal(ItemSaleGrid.Rows[i].Cells["TaxAmount"].Value.ToString());
            }
            txtGrossAmount.Text = sum.ToString();
            txtTotalTax.Text = taxAmountTotal.ToString();
            CalculateNetTotal();

        }

        private void CalculateNetTotal()
        {
            decimal grossAmount = Convert.ToDecimal(txtGrossAmount.Text);
            decimal totalTaxAmount = Convert.ToDecimal(txtTotalTax.Text);
            decimal discAmount = txtDiscountAmount.Text == "" ? 0 : Convert.ToDecimal(txtDiscountAmount.Text);
            decimal discPercentage = txtDiscountPercentage.Text == "" ? 0 : Convert.ToDecimal(txtDiscountPercentage.Text);
            decimal otherCharges = txtOtherCharges.Text == "" ? 0 : Convert.ToDecimal(txtOtherCharges.Text);
            decimal totalDiscount = ((discPercentage * grossAmount) / 100) + discAmount;
            decimal netAmount = grossAmount - totalDiscount + totalTaxAmount + otherCharges;
            txtTotalDiscount.Text = totalDiscount.ToString();
            txtNetAmount.Text = netAmount.ToString();
            if (SaleInvoiceNo == 0)
            {
                if (directReturn==true)
                {
                    txtPayableAmount.Text = netAmount.ToString();
                }
                else
                {
                    txtReceivableAmount.Text = netAmount.ToString();
                }
                
            }
            else
            {
                decimal recAmount = txtAmountReceive.Text == "" ? 0 : Convert.ToDecimal(txtAmountReceive.Text);
                decimal accAmount = txtAccAmount.Text == "" ? 0 : Convert.ToDecimal(txtAccAmount.Text);
                //txtAmountReturn.Text = (recAmount - netAmount).ToString();
                if (accAmount >= netAmount)
                {
                    //txtAmountReturn.Text = (accAmount - netAmount).ToString();
                    txtPayableAmount.Text = (netAmount).ToString();
                    txtReceivableAmount.Text = "0.00";
                }
                else
                {
                    txtAmountReturn.Text = "0.00";
                    txtAmountReceive.Text = "0.00";
                    txtPayableAmount.Text = "0.00";
                    txtReceivableAmount.Text = (netAmount - accAmount).ToString();
                }
            }
            decimal payableAmount = txtReceivableAmount.Text == "" ? 0 : Convert.ToDecimal(txtReceivableAmount.Text);
            decimal returnAmount = txtAmountReturn.Text == "" ? 0 : Convert.ToDecimal(txtAmountReturn.Text);
            if (payableAmount == 0 && returnAmount > 0)
            {
                txtAmountReceive.Text = "0.00";
                txtAmountReceive.ReadOnly = true;
            }
            else if (payableAmount > 0)
            {
                txtAmountReceive.ReadOnly = false;
            }
        }

     
        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }
        private void CalculateDetail()
        {
            for (int i = 0; i < ItemSaleGrid.Rows.Count; i++)
            {

                int id = Convert.ToInt32( ItemSaleGrid.Rows[i].Cells[0].Value.ToString());
                DataTable dt = getProduct(0, Convert.ToInt32(id));
                var taxPercentage = Convert.ToDecimal(dt.Rows[0]["TotalTax"]);
                string rateValue = ItemSaleGrid.Rows[i].Cells[2].Value.ToString();
                string total = (Convert.ToDecimal(rateValue) * 1).ToString();
                string taxAmount = (((Convert.ToDecimal(taxPercentage) * Convert.ToDecimal(rateValue)) / 100) * 1).ToString();

                string value = ItemSaleGrid.Rows[i].Cells[7].Value.ToString();
                    decimal Bundle = Convert.ToDecimal(ItemSaleGrid.Rows[i].Cells[4].Value.ToString());
                    decimal BundleSize = Convert.ToDecimal(ItemSaleGrid.Rows[i].Cells[13].Value.ToString());
                   
                    decimal rate = Convert.ToDecimal(rateValue);
                    decimal qty = Convert.ToDecimal(value);
                   

                    
                    ItemSaleGrid.Rows[i].Cells["Total"].Value = Math.Round(((Bundle * BundleSize) + qty) * rate,2);
                    ItemSaleGrid.Rows[i].Cells["TaxAmount"].Value = ((Convert.ToDecimal(taxPercentage) * rate) / 100) * ((Bundle * BundleSize) + qty);

                    
                    GrossAmount_Total();
                   
                
            }
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            DateTime datetime = DateTime.Now;
            this.lblDateTime.Text = datetime.ToString("dddd , MMM dd yyyy,hh:mm:ss");
        }

        private void txtDiscountAmount_TextChanged(object sender, EventArgs e)
        {
            CalculateNetTotal();
        }

        private void txtDiscountPercentage_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar) &&
            (e.KeyChar != '.'))
            {
                e.Handled = true;
            }

            // only allow one decimal point
            if ((e.KeyChar == '.') && ((sender as TextBox).Text.IndexOf('.') > -1))
            {
                e.Handled = true;
            }
        }

        private void txtReceiveAmount_TextChanged(object sender, EventArgs e)
        {
            decimal payableAmount = txtReceivableAmount.Text == "" ? 0 : Convert.ToDecimal(txtReceivableAmount.Text);
            decimal returnAmount = txtAmountReturn.Text == "" ? 0 : Convert.ToDecimal(txtAmountReturn.Text);
            //if (payableAmount==0 && returnAmount>0)
            //{
            //    txtAmountReceive.ReadOnly = true;
            //}
            //else if (payableAmount>0)
            //{
            //txtAmountReceive.ReadOnly = false;
            decimal recAmount = txtAmountReceive.Text == "" ? 0 : Convert.ToDecimal(txtAmountReceive.Text);
            txtAmountReturn.Text = (recAmount - payableAmount).ToString();
            //}
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
        private DataTable getProductBarcode(int categoryID, int productID = 0, string ManualNumber = "")
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = @" select data_InventItemsBarcode.SystemBarcode,data_InventItemsBarcodeDetail.BarcodeNumber,InventItems.ItemId,InventItems.ItenName,InventItems.ItemSalesPrice,cast(isnull(t.TotalTax,0) as numeric(18,2)) as TotalTax,cast(isnull(((InventItems.ItemSalesPrice*t.TotalTax)/100),0) as numeric(18,2)) as TaxAmount,InventItems.cartonSize
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
                                group by InventItems.ItemId)t on InventItems.ItemId = t.ItemId left join data_InventItemsBarcode on data_InventItemsBarcode.ItemID=InventItems.ItemId left join data_InventItemsBarcodeDetail on data_InventItemsBarcodeDetail.RegisterID=data_InventItemsBarcode.RegisterID 
                                ";
            
             if (ManualNumber != "")
            {
                SqlString += " where data_InventItemsBarcodeDetail.BarcodeNumber='"+ManualNumber+ "' or data_InventItemsBarcode.SystemBarcode='" + ManualNumber + "'";
            }
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            return dt;
        }
        private void AddProducts(string productName, int id, decimal rates, decimal taxPercentage,decimal CartonSize=0)
        {

            string total = (Convert.ToDecimal(rates) * 1).ToString();
            string taxAmount = (((Convert.ToDecimal(taxPercentage) * Convert.ToDecimal(rates)) / 100) * 1).ToString();

            bool recordExist = false;
            for (int i = 0; i < ItemSaleGrid.Rows.Count; i++)
            {
                if (id == Convert.ToInt32(ItemSaleGrid.Rows[i].Cells[0].Value.ToString()))
                {

                    string value = ItemSaleGrid.Rows[i].Cells[7].Value.ToString();
                    decimal Bundle = Convert.ToDecimal(ItemSaleGrid.Rows[i].Cells[4].Value.ToString());
                    decimal BundleSize = Convert.ToDecimal(ItemSaleGrid.Rows[i].Cells[13].Value.ToString());
                    string rateValue = ItemSaleGrid.Rows[i].Cells[2].Value.ToString();
                    decimal rate = Convert.ToDecimal(rateValue);
                    decimal qty = Convert.ToDecimal(value);
                    qty++;
                    
                    ItemSaleGrid.Rows[i].Cells["Quantity"].Value = qty;
                    ItemSaleGrid.Rows[i].Cells["Total"].Value = ((Bundle*BundleSize)+qty) * rate;
                    ItemSaleGrid.Rows[i].Cells["TaxAmount"].Value = ((Convert.ToDecimal(taxPercentage) * rate) / 100) * qty;

                    recordExist = true;
                    GrossAmount_Total();
                    return;
                }
            }
            if (!recordExist)
            {
                string[] row = { id.ToString(), productName, rates.ToString(), "+", "0", "-", "+", "1", "-", total, "Delete", taxPercentage.ToString(), taxAmount,Convert.ToString(CartonSize) };
                ItemSaleGrid.Rows.Insert(0,row);
            }
            GrossAmount_Total();
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
                        using (frmProductLookUp obj = new frmProductLookUp())
                        {
                            if (obj.ShowDialog() == DialogResult.OK)
                            {
                                int id = obj.ProductID;
                                txtProductCode.Text = obj.ManualNumber;
                                cmbProducts.SelectedValue = id.ToString();
                            }
                        };
                    }
                    else
                    {
                        cmbProducts.SelectedValue = dt.Rows[0]["ItemId"].ToString();
                    }
                    string ids = cmbProducts.SelectedValue.ToString();
                    {
                        if (ids != "0")
                        {
                            DataTable dt1 = getProduct(0, Convert.ToInt32(ids));
                            AddProducts(dt1.Rows[0]["itenName"].ToString(), Convert.ToInt32(ids), Convert.ToDecimal(dt1.Rows[0]["ItemSalesPrice"]), Convert.ToDecimal(dt1.Rows[0]["TotalTax"]));
                        }
                    }
                }
                else
                {
                    MessageBox.Show("Please Enter Product Code");
                }
            }
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (validateSave())
            {
               
                SaveForm();
            }

        }

        private void SaveForm()
        {
            DataTable dt1 = new DataTable();
            dt1.Columns.Add("RowID");
            dt1.Columns.Add("ItemId");
            dt1.Columns.Add("Quantity");
            dt1.Columns.Add("ItemRate");
            dt1.Columns.Add("TaxPercentage");
            dt1.Columns.Add("TaxAmount");
            dt1.Columns.Add("DiscountPercentage");
            dt1.Columns.Add("DiscountAmount");
            dt1.Columns.Add("TotalAmount");
            dt1.Columns.Add("CartonSize");
            dt1.Columns.Add("Carton");
            dt1.Columns.Add("TotalQuantity");
            dt1.Columns.Add("SalePosDetailID");

            int i = 0;
            foreach (DataGridViewRow row in ItemSaleGrid.Rows)
            {
                DataRow dRow = dt1.NewRow();
                i = i + 1;
                var TQty = Convert.ToDecimal(row.Cells[7].Value.ToString())+(Convert.ToDecimal(row.Cells[4].Value.ToString()) * Convert.ToDecimal(row.Cells[13].Value.ToString()));
                dRow[0] = i;
                dRow[1] = row.Cells[0].Value.ToString();
                dRow[2] = TQty.ToString();
                dRow[3] = row.Cells[2].Value.ToString();
                dRow[4] = row.Cells[11].Value.ToString();
                dRow[5] = row.Cells[12].Value.ToString();
                dRow[6] = 0;
                dRow[7] = 0;
                dRow[8] = row.Cells[9].Value.ToString();
                dRow[9] = row.Cells[13].Value.ToString();
                dRow[10] = row.Cells[4].Value.ToString();
                dRow[11] = row.Cells[7].Value.ToString();
                dRow[12] = Convert.ToString(row.Cells[14].Value);

                dt1.Rows.Add(dRow);
            }
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            SqlTransaction tran;
            con.Open();
            tran = con.BeginTransaction();
            SqlCommand cmd;
            if (SaleReturn==false)
            {
                cmd = new SqlCommand("data_SalePosInfo_Insert", con);
            }
            else
            {
                cmd = new SqlCommand("data_SalePosReturnInfo_Insert", con);
            }
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter();
            DataTable dt = new DataTable();
            SqlParameter p = new SqlParameter("SalePosID", SalePosMasterID);
            p.Direction = ParameterDirection.InputOutput;
            cmd.Parameters.Add(p);
            cmd.Parameters.AddWithValue("@CompanyID", CompanyInfo.CompanyID);
            cmd.Parameters.AddWithValue("@SaleInvoiceNo", SaleInvoiceNo);
            cmd.Parameters.AddWithValue("@UserID", CompanyInfo.UserID);
            cmd.Parameters.AddWithValue("@FiscalID", CompanyInfo.FiscalID);
            cmd.Parameters.AddWithValue("@WHID", CompanyInfo.WareHouseID);
            cmd.Parameters.AddWithValue("@TaxAmount", txtTotalTax.Text == "" ? 0 : Convert.ToDecimal(txtTotalTax.Text));
            cmd.Parameters.AddWithValue("@GrossAmount", Convert.ToDecimal(txtGrossAmount.Text));
            cmd.Parameters.AddWithValue("@DiscountPercentage", txtDiscountPercentage.Text == "" ? 0 : Convert.ToDecimal(txtDiscountPercentage.Text));
            cmd.Parameters.AddWithValue("@DiscountAmount", txtDiscountAmount.Text == "" ? 0 : Convert.ToDecimal(txtDiscountAmount.Text));
            cmd.Parameters.AddWithValue("@DiscountTotal", Convert.ToDecimal(txtTotalDiscount.Text));
            cmd.Parameters.AddWithValue("@OtherCharges", txtOtherCharges.Text == "" ? 0 : Convert.ToDecimal(txtOtherCharges.Text));
            cmd.Parameters.AddWithValue("@NetAmount", Convert.ToDecimal(txtNetAmount.Text));
            cmd.Parameters.AddWithValue("@SalePosDate", Convert.ToDateTime(txtSaleDate.Value.Date));
            
            cmd.Parameters.AddWithValue("@AmountReceive", txtAmountReceive.Text == "" ? 0 : Convert.ToDecimal(txtAmountReceive.Text));
            cmd.Parameters.AddWithValue("@AmountReturn", txtAmountReturn.Text == "" ? 0 : Convert.ToDecimal(txtAmountReturn.Text));
            cmd.Parameters.AddWithValue("@AmountInAccount", txtAccAmount.Text == "" ? 0 : Convert.ToDecimal(txtAccAmount.Text));
            if (SaleInvoiceNo > 0)
            {
                cmd.Parameters.AddWithValue("@AmountPayable", txtPayableAmount.Text == "" ? Convert.ToDecimal(txtAccAmount.Text) : Convert.ToDecimal(txtPayableAmount.Text));
            }
            else
            {
                cmd.Parameters.AddWithValue("@AmountPayable", txtPayableAmount.Text == "" ? 0 : Convert.ToDecimal(txtPayableAmount.Text));
            }
                cmd.Parameters.AddWithValue("@AmountReceivable", txtReceivableAmount.Text == "" ? 0 : Convert.ToDecimal(txtReceivableAmount.Text));
            cmd.Parameters.AddWithValue("@CustomerPhone", txtCustPhone.Text == "" ? null : Convert.ToString(txtCustPhone.Text));
            cmd.Parameters.AddWithValue("@CustomerName", txtCustName.Text == "" ? null : Convert.ToString(txtCustName.Text));

            if (directReturn==true)
            {
                cmd.Parameters.AddWithValue("@DirectReturn", true);
            }
            cmd.Parameters.AddWithValue("@data_SalePosDetail", dt1);

            da.SelectCommand = cmd;
            try
            {
                cmd.Transaction = tran; da.Fill(dt1);
                tran.Commit();
                string SaleInvoiceNO = p.Value.ToString();
                var value = new List<string[]>();
                string[] ss = { "@SaleInvoice", SaleInvoiceNO };
                value.Add(ss);
                frmCrystal obj = new frmCrystal();
                string reportName = "";
                if (directReturn == false)
                {
                    reportName = "SaleInvoice";
                    //obj.loadReport("rpt_sale_invoice", reportName, value);
                    obj.loadSaleReport("rpt_sale_invoice", reportName, value);
                    obj.loadSaleKitchenReport("rpt_sale_invoiceKitchen", reportName, value);
                }
                //else
                //{
                //    reportName = "SaleInvoiceReturn";
                //    obj.loadReport("rpt_sale_invoice", reportName, value);
                //}
                clearAll();
                if (SaleInvoiceNo == 0)
                {
                    MessageBox.Show("Record has been Saved!");
                }
                else
                {
                    MessageBox.Show("Record has been Updated!");
                }
                loadNewSale();
                //if (SaleInvoiceNo == 0)
                //{
                //    MessageBox.Show("Record has been Saved!");
                //}
                //else
                //{
                //    MessageBox.Show("Record has been Updated!");
                //}
            }
            catch (Exception ex)
            {
                //if (tran != null)
                //{
                //    tran.Rollback();
                //}
                    MessageBox.Show(ex.Message, "Important Message", MessageBoxButtons.OK,MessageBoxIcon.Error);
            }
            finally
            {
                con.Close();
            }
        }

        private bool validateSave()
        {
            decimal amountReceived = txtAmountReceive.Text == "" ? 0 : Convert.ToDecimal(txtAmountReceive.Text);
            decimal amountReceivable = txtReceivableAmount.Text == "" ? 0 : Convert.ToDecimal(txtReceivableAmount.Text);
            decimal amountPayable = txtPayableAmount.Text == "" ? 0 : Convert.ToDecimal(txtPayableAmount.Text);
            decimal amountReturn = txtAmountReturn.Text == "" ? 0 : Convert.ToDecimal(txtAmountReturn.Text);
            decimal amountNet = txtNetAmount.Text == "" ? 0 : Convert.ToDecimal(txtNetAmount.Text);
            Int64 invoiceNO = txtInvoiceNo.Text == "" ? 0 : Convert.ToInt64(txtInvoiceNo.Text);
            bool validateReturnOK = true;
            if (ItemSaleGrid.Rows.Count > 0 || SaleInvoiceNo != 0)
            {

                //if (netAmountForReturn == amountNet)
                //{
                //    MessageBox.Show("There in no change in items!");
                //    validateReturnOK = false;
                //}
                //else if (amountReceivable > 0 && amountReceived == 0)
                //{
                //      txtAmountReceive.Focus();
                //        MessageBox.Show("Please Enter Received Amount!");
                //        validateReturnOK = false;
                //}
                //else
                if (amountReceivable > 0 && amountReceived < amountReceivable)
                {
                    txtAmountReceive.Focus();
                    MessageBox.Show("Amount Receive should be greater than Receivable Amount!");
                    validateReturnOK = false;
                }
                else if (amountReturn < 0)
                {
                    txtAmountReceive.Focus();
                    MessageBox.Show("Receiable Amount is not fully paid!");
                    validateReturnOK = false;
                }
                else if (lblSaleType.Text == "Sale Return" && SaleInvoiceNo == 0)
                {
                    MessageBox.Show("There is no Invoice No."+ Environment.NewLine +" For New Sale Please Click New Sale button OR Press ( ALT+N ) !");
                    validateReturnOK = false;
                }
            }
            else
            {
                validateReturnOK = false;
                MessageBox.Show("There is no item in cart!");
            }
            return validateReturnOK;
        }

        private void btnReturn_Click(object sender, EventArgs e)
        {
            loadReturnView();
        }

        

        private void txtInvoiceNo_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyData == Keys.Enter)
            {
              
                if (txtInvoiceNo.Text != "" || (txtInvoiceNo.Text == "" ? 0 : Convert.ToInt64(txtInvoiceNo.Text)) != 0)
                {
                    clearAll();
                    string InvoiceNo = txtInvoiceNo.Text;
                    loadWholeInvoice(InvoiceNo);
                }
                else
                {
                    MessageBox.Show("Please Enter Invoice Number!");
                }
            }
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            clearAll();
            loadNewSale();
        }

        private void clearAll()
        {
            ItemSaleGrid.Rows.Clear();
            ItemSaleGrid.Refresh();
            txtTotalTax.Text = "0";
            txtGrossAmount.Text = "0";
            txtDiscountPercentage.Text = "0";
            txtDiscountAmount.Text = "0";
            txtTotalDiscount.Text = "0";
            txtOtherCharges.Text = "0";
            txtNetAmount.Text = "0";
            txtAmountReceive.Text = "0";
            txtAmountReturn.Text = "0";
            txtAccAmount.Text = "0";
            txtPayableAmount.Text = "0";
            txtReceivableAmount.Text = "0";
            txtProductCode.Text = "";
            cmbProducts.SelectedValue = "0";
            txtCustName.Clear();
            txtCustPhone.Clear();
            directReturn = false;
        }

        private void loadNewSale()
        {
            lblSaleType.Text = "New Sale";
            txtInvoiceNo.ReadOnly = true;
            SaleInvoiceNo = 0;
            getInvoiceNumber();
            txtProductCode.Select();
            txtProductCode.Focus();
            SaleReturn = false;
            //txtAmountReceive.ReadOnly = false;
        }

        private void getInvoiceNumber()
        {



            int SaleVoucherNo = GetVoucherNoI(Fieldname: "SalePOSNo", TableName: "data_SalePosInfo", CheckTaxable: false,
                    PrimaryKeyValue: 0, PrimaryKeyFieldName: "SalePosID", voucherDate: Convert.ToDateTime(txtSaleDate.Value.Date), voucherDateFieldName: "SalePosDate",
                    companyID:CompanyInfo.CompanyID, FiscalID: CompanyInfo.FiscalID);
            txtInvoiceNo.Text = Convert.ToString(SaleVoucherNo);
        }
        public Int32 GetVoucherNoI(string Fieldname, string TableName, bool CheckTaxable, Int32 PrimaryKeyValue,
          string PrimaryKeyFieldName, DateTime? voucherDate, string voucherDateFieldName = "",
          Int32 companyID = 0, string companyFieldName = "CompanyID", Int32 FiscalID = 0,
          string FiscalIDFieldName = "FiscalID", bool IsTaxable = false)
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            try
            {
                DataTable dt = new DataTable();
                SqlConnection con = new SqlConnection(connectionString);
                SqlCommand cmd = new SqlCommand("GetVoucherNoPos", con);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter da = new SqlDataAdapter();
                cmd.Parameters.Add(new SqlParameter("@Fieldname", Fieldname));
                cmd.Parameters.Add(new SqlParameter("@TableName", TableName));
                cmd.Parameters.Add(new SqlParameter("@CheckTaxable", CheckTaxable));
                cmd.Parameters.Add(new SqlParameter("@PrimaryKeyValue", PrimaryKeyValue));
                cmd.Parameters.Add(new SqlParameter("@PrimaryKeyFieldName", PrimaryKeyFieldName));
                cmd.Parameters.Add(new SqlParameter("@voucherDate", voucherDate));
                cmd.Parameters.Add(new SqlParameter("@voucherDateFieldName", voucherDateFieldName));
                cmd.Parameters.Add(new SqlParameter("@companyID", companyID));
                cmd.Parameters.Add(new SqlParameter("@companyFieldName", companyFieldName));
                cmd.Parameters.Add(new SqlParameter("@FiscalID", FiscalID));
                cmd.Parameters.Add(new SqlParameter("@FiscalIDFieldName", FiscalIDFieldName));
                cmd.Parameters.Add(new SqlParameter("@IsTaxable", IsTaxable));
                da.SelectCommand = cmd;
                da.Fill(dt);
                return Convert.ToInt32(dt.Rows[0][0]);
            }
            catch (Exception ex)
            {

                throw;
            }

        }

        private void txtAmountReceive_Click(object sender, EventArgs e)
        {
            txtAmountReceive.SelectAll();
        }

        private void btnReturnWholeInvoice_Click(object sender, EventArgs e)
        {
            ItemSaleGrid.Rows.Clear();
            CalculateNetTotal();
        }

        private void txtInvoiceNo_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!(Char.IsDigit(e.KeyChar) || (e.KeyChar == (char)Keys.Back)))
                e.Handled = true;
        }
        protected override bool ProcessCmdKey(ref Message msg, Keys keyData)
        {
            if (keyData == (Keys.Alt | Keys.S))
            {
                if (validateSave())
                {
                    SaveForm();
                }
                return true;
            }
            else if (keyData == (Keys.Alt | Keys.R))
            {
                loadReturnView();
                return true;
            }
            else if (keyData == (Keys.Alt | Keys.N))
            {
                clearAll();
                loadNewSale();
                return true;
            }
            else if (keyData == (Keys.Alt | Keys.A))
            {
                txtAmountReceive.SelectAll();
                txtAmountReceive.Focus();
                return true;
            }
            return base.ProcessCmdKey(ref msg, keyData);
        }
        private void ItemSaleGrid_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.ColumnIndex == 6)
            {
                string value = ItemSaleGrid.Rows[e.RowIndex].Cells["Quantity"].Value.ToString();
                string rateValue = ItemSaleGrid.Rows[e.RowIndex].Cells["Rate"].Value.ToString();
                string taxValue = ItemSaleGrid.Rows[e.RowIndex].Cells["Tax"].Value.ToString();
                decimal Bundle = Convert.ToDecimal(ItemSaleGrid.Rows[e.RowIndex].Cells["Bundle"].Value.ToString());
                decimal BundleSize = Convert.ToDecimal(ItemSaleGrid.Rows[e.RowIndex].Cells["cartonSize"].Value.ToString());
                decimal rate = Convert.ToDecimal(rateValue);
                decimal qty = Convert.ToDecimal(value);
                qty++;
                ItemSaleGrid.Rows[e.RowIndex].Cells["Quantity"].Value = qty;
                ItemSaleGrid.Rows[e.RowIndex].Cells["Total"].Value = Math.Round(((Bundle * BundleSize) + qty) * rate, 2);
                ItemSaleGrid.Rows[e.RowIndex].Cells["TaxAmount"].Value = ((Convert.ToDecimal(taxValue) * rate) / 100) * qty;
            }

            if (e.ColumnIndex == 3)
            {
                string value = ItemSaleGrid.Rows[e.RowIndex].Cells["Bundle"].Value.ToString();
                string rateValue = ItemSaleGrid.Rows[e.RowIndex].Cells["Rate"].Value.ToString();
                string taxValue = ItemSaleGrid.Rows[e.RowIndex].Cells["Tax"].Value.ToString();
                decimal qty = Convert.ToDecimal(ItemSaleGrid.Rows[e.RowIndex].Cells["Quantity"].Value.ToString());
                decimal BundleSize = Convert.ToDecimal(ItemSaleGrid.Rows[e.RowIndex].Cells["cartonSize"].Value.ToString());
                decimal rate = Convert.ToDecimal(rateValue);
                decimal Bundle = Convert.ToDecimal(value);
                Bundle++;
                ItemSaleGrid.Rows[e.RowIndex].Cells["Bundle"].Value = Bundle;
                ItemSaleGrid.Rows[e.RowIndex].Cells["Total"].Value = Math.Round(((Bundle * BundleSize) + qty) * rate, 2);
                ItemSaleGrid.Rows[e.RowIndex].Cells["TaxAmount"].Value = ((Convert.ToDecimal(taxValue) * rate) / 100) * qty;
            }
            else if (e.ColumnIndex == 5)
            {
                string value = ItemSaleGrid.Rows[e.RowIndex].Cells["Bundle"].Value.ToString();
                string rateValue = ItemSaleGrid.Rows[e.RowIndex].Cells["Rate"].Value.ToString();
                string taxValue = ItemSaleGrid.Rows[e.RowIndex].Cells["Tax"].Value.ToString();
                decimal qty = Convert.ToDecimal(ItemSaleGrid.Rows[e.RowIndex].Cells["Quantity"].Value.ToString());
                decimal BundleSize = Convert.ToDecimal(ItemSaleGrid.Rows[e.RowIndex].Cells["cartonSize"].Value.ToString());
                decimal rate = Convert.ToDecimal(rateValue);
                decimal Bundle = Convert.ToDecimal(value);
                if (Bundle > 1)
                {
                    Bundle--;
                    ItemSaleGrid.Rows[e.RowIndex].Cells["Bundle"].Value = Bundle;
                    ItemSaleGrid.Rows[e.RowIndex].Cells["Total"].Value = Math.Round(((Bundle * BundleSize) + qty) * rate, 2);
                    ItemSaleGrid.Rows[e.RowIndex].Cells["TaxAmount"].Value = ((Convert.ToDecimal(taxValue) * rate) / 100) * qty;
                }
            }
            else if (e.ColumnIndex == 8)
            {
                string value = ItemSaleGrid.Rows[e.RowIndex].Cells["Quantity"].Value.ToString();
                string rateValue = ItemSaleGrid.Rows[e.RowIndex].Cells["Rate"].Value.ToString();
                string taxValue = ItemSaleGrid.Rows[e.RowIndex].Cells["Tax"].Value.ToString();
                decimal Bundle = Convert.ToDecimal(ItemSaleGrid.Rows[e.RowIndex].Cells["Bundle"].Value.ToString());
                decimal BundleSize = Convert.ToDecimal(ItemSaleGrid.Rows[e.RowIndex].Cells["cartonSize"].Value.ToString());
                decimal rate = Convert.ToDecimal(rateValue);
                decimal qty = Convert.ToDecimal(value);
                if (qty > 1)
                {
                    qty--;
                    ItemSaleGrid.Rows[e.RowIndex].Cells["Quantity"].Value = qty;
                    ItemSaleGrid.Rows[e.RowIndex].Cells["Total"].Value = Math.Round(((Bundle * BundleSize) + qty) * rate, 2);
                    ItemSaleGrid.Rows[e.RowIndex].Cells["TaxAmount"].Value = ((Convert.ToDecimal(taxValue) * rate) / 100) * qty;
                }
            }
            else if (e.ColumnIndex == 10)
            {
                int id = Convert.ToInt32(ItemSaleGrid.Rows[e.RowIndex].Index);
                ItemSaleGrid.Rows.RemoveAt(id);
                ItemSaleGrid.Refresh();
            }
            CalculateDetail();
            GrossAmount_Total();
        }

        private void ItemSaleGrid_EditingControlShowing(object sender, DataGridViewEditingControlShowingEventArgs e)
        {
            e.Control.KeyPress -= new KeyPressEventHandler(Column1_KeyPress);
            if (ItemSaleGrid.CurrentCell.ColumnIndex == ItemSaleGrid.Columns["Quantity"].Index) //Desired Column
            {
                TextBox tb = e.Control as TextBox;
                if (tb != null)
                {
                    tb.KeyPress += new KeyPressEventHandler(Column1_KeyPress);
                }
                else
                {
                    tb.Text= (1).ToString();
                }
                if (tb.Text == "")
                {
                    tb.Text = (1).ToString();
                }

            }
        }
        private void Column1_KeyPress(object sender, KeyPressEventArgs e)
        {
            // allowed only numeric value  ex.10
            //if (!char.IsControl(e.KeyChar)
            //    && !char.IsDigit(e.KeyChar))
            //{
            //    e.Handled = true;
            //}

            // allowed numeric and one dot  ex. 10.23
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar)
                 && e.KeyChar != '.')
            {
                e.Handled = true;
            }

            // only allow one decimal point
            if (e.KeyChar == '.'
                && (sender as TextBox).Text.IndexOf('.') > -1)
            {
                e.Handled = true;
            }
            CalculateDetail();

        }

        private void cmbProducts_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyData == Keys.Enter)
            {
                string id = cmbProducts.SelectedValue.ToString();
                {
                    if (id != "0")
                    {
                        DataTable dt = getProduct(0, Convert.ToInt32(id));
                        AddProducts(dt.Rows[0]["itenName"].ToString(), Convert.ToInt32(id), Convert.ToDecimal(dt.Rows[0]["ItemSalesPrice"]), Convert.ToDecimal(dt.Rows[0]["TotalTax"]));
                    }
                }
            }
        }

        private void btnCashIn_Click(object sender, EventArgs e)
        {
            frmCashIn obj = new frmCashIn();
            obj.Show();
        }

        private void btnCashOut_Click(object sender, EventArgs e)
        {
            frmCashOut obj = new frmCashOut();
            obj.Show();
        }

        private void btnUnCompleteSale_Click(object sender, EventArgs e)
        {
            loadDirectReturn();
        }
        private void loadReturnView()
        {
            clearAll();
            lblSaleType.Text = "Sale Return";
            txtInvoiceNo.ReadOnly = false;
            txtInvoiceNo.Text = "";
            txtInvoiceNo.Focus();
            SaleReturn = true;
        }
        private void loadDirectReturn()
        {
            clearAll();
            lblSaleType.Text = "Direct Return";
            directReturn = true;
        }

        private void btnNewSale_Click(object sender, EventArgs e)
        {
            using (frmSaleInvoiceLookUp obj = new frmSaleInvoiceLookUp())
            {
                if (obj.ShowDialog() == DialogResult.OK)
                {
                    string id = obj.SaleInvoiceNo;
                    if (id!="")
                    {
                        clearAll();
                        loadWholeInvoice(id);
                        txtInvoiceNo.Text = id;
                    }
                }
            };
        }
        private void loadWholeInvoice(string InvoiceNo)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataTable dtdetail = new DataTable();
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            SqlTransaction tran;
            con.Open();
            tran = con.BeginTransaction();
            SqlCommand cmd = new SqlCommand("data_SalePosInfo_SelectAll", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter();

            string whereclause = " where SaleposNo=" + InvoiceNo+" and SalePOsDate="+txtSaleDate.Value.Date+"";
            cmd.Parameters.AddWithValue("@SelectMaster", 1);
            cmd.Parameters.AddWithValue("@SelectDetail", 1);
            cmd.Parameters.AddWithValue("@InvoiceNo", InvoiceNo);
            
            cmd.Parameters.AddWithValue("@SaleDate", txtSaleDate.Value.Date);
            da.SelectCommand = cmd;
            try
            {
                cmd.Transaction = tran; da.Fill(ds);
                dt = ds.Tables[0];
                dtdetail = ds.Tables[1];
                tran.Commit();
            }
            catch (Exception ex)
            {
                tran.Rollback();
                MessageBox.Show(ex.Message);
            }
            finally
            {
                con.Close();
            }

            if (dt.Rows.Count > 0)
            {
                if (dtdetail.Rows.Count == 0)
                {
                    MessageBox.Show("This Invoice is all ready return!");
                    return;
                }
                SaleInvoiceNo = Convert.ToInt32(InvoiceNo);
                netAmountForReturn = Convert.ToDecimal(dt.Rows[0]["NetAmount"].ToString());
                txtTotalTax.Text = dt.Rows[0]["TaxAmount"].ToString();
                txtGrossAmount.Text = dt.Rows[0]["GrossAmount"].ToString();
                txtDiscountPercentage.Text = dt.Rows[0]["DiscountPercentage"].ToString();
                txtDiscountAmount.Text = dt.Rows[0]["DiscountAmount"].ToString();
                txtTotalDiscount.Text = dt.Rows[0]["DiscountTotal"].ToString();
                txtOtherCharges.Text = dt.Rows[0]["OtherCharges"].ToString();
                txtNetAmount.Text = dt.Rows[0]["NetAmount"].ToString();
                txtAmountReceive.Text = "0.00";
                txtAccAmount.Text = dt.Rows[0]["NetAmount"].ToString();
                //txtPayableAmount.Text = dt.Rows[0]["NetAmount"].ToString();
                txtPayableAmount.Text = "0.00";
                txtAmountReturn.Text = "0.00";
                txtReceivableAmount.Text = "0.00";
                txtCustName.Text= Convert.ToString(dt.Rows[0]["CustomerName"]);
                txtCustPhone.Text = Convert.ToString(dt.Rows[0]["CustomerPhone"]);
                SalePosID.Text= Convert.ToString(dt.Rows[0]["SalePosID"]);
                txtAmountReceive.ReadOnly = true;
                txtPrint.Visible = true;
                SaleReturn = true;
                for (int i = 0; i < dtdetail.Rows.Count; i++)
                {
                    string[] row = {
                            dtdetail.Rows[i]["ItemId"].ToString(),
                            dtdetail.Rows[i]["ItenName"].ToString(),
                            dtdetail.Rows[i]["ItemRate"].ToString(),
                            "+",
                            Convert.ToInt32(dtdetail.Rows[i]["Carton"]).ToString(),
                            "-",
                             "+",
                            Convert.ToInt32(dtdetail.Rows[i]["TotalQuantity"]).ToString(),
                            "-",
                            dtdetail.Rows[i]["TotalAmount"].ToString(),
                            "Delete",
                            dtdetail.Rows[i]["TaxPercentage"].ToString(),
                            dtdetail.Rows[i]["TaxAmount"].ToString(),
                    dtdetail.Rows[i]["CartonSize"].ToString(),
                    dtdetail.Rows[i]["SalePosDetailID"].ToString()};
                    ItemSaleGrid.Rows.Add(row);
                }

            }
            else
            {
                MessageBox.Show("We have no Sale Invoice regarding this No!");
            }
        }

        private void btnDashboard_Click(object sender, EventArgs e)
        {
            Dashboard obj = new Dashboard();
            obj.Show();
        }

        private void txtCustPhone_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                txtCustName.Focus();
                
            }
        }

      

        private void ItemSaleGrid_KeyDown(object sender, KeyEventArgs e)
        {
            
                CalculateDetail();
            
        }

        private void txtProductBarCode_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                string Barcode = txtProductBarCode.Text.ToString();
                {
                    if (!string.IsNullOrEmpty(Barcode))
                    {
                        DataTable dt = getProductBarcode(0,0, Barcode);
                        if (dt.Rows.Count > 0)
                        {
                            AddProducts(dt.Rows[0]["itenName"].ToString(), Convert.ToInt32(dt.Rows[0]["ItemId"].ToString()), Convert.ToDecimal(dt.Rows[0]["ItemSalesPrice"]), Convert.ToDecimal(dt.Rows[0]["TotalTax"]));
                            txtProductBarCode.Clear();
                        }
                        else
                        {
                            MessageBox.Show("Invalid Barcode Number...");
                            txtProductBarCode.Clear();
                            return;
                        }
                       }
                }
                
            }
        }

        private void txtSaleDate_ValueChanged(object sender, EventArgs e)
        {
            if (SaleReturn == false)
            {
                getInvoiceNumber();
            }
        }

        private void txtPrint_Click(object sender, EventArgs e)
        {
            string SaleInvoiceNO = SalePosID.Text.ToString();
            var value = new List<string[]>();
            string[] ss = { "@SaleInvoice", SaleInvoiceNO };
            value.Add(ss);
            frmCrystal obj = new frmCrystal();
            string reportName = "";
            if (directReturn == false)
            {
                reportName = "SaleInvoice";
                //obj.loadReport("rpt_sale_invoice", reportName, value);
                obj.loadSaleReport("rpt_sale_invoice", reportName, value);
                obj.loadSaleKitchenReport("rpt_sale_invoiceKitchen", reportName, value);
            }
           
        }

        private void btnSalesStatus_Click(object sender, EventArgs e)
        {
            using (frmReturnInvoices obj = new frmReturnInvoices())
            {
                if (obj.ShowDialog() == DialogResult.OK)
                {
                   
                }
            };
        }
    }
}
