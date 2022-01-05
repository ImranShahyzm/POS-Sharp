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
using System.Net.Http;
using MetroFramework.Forms;
using System.Globalization;
using System.Threading;
using POS.Model;
using Newtonsoft.Json;

namespace POS
{
    public partial class POSChSweets : MetroForm
    {
        public bool directReturn = false;
        public int SaleInvoiceNo = 0;
        public int SalePosMasterID = 0;
        public decimal netAmountForReturn = 0;

        public string totalBill { get; set; }
        public string ReceivedAmount { get; set; }
        public string ReturnAmount { get; set; }

        public string CustomerName { get; set; }
        public string CustomerPhone { get; set; }
        public string RiderAmount { get; set; }

        public string SaleManId { get; set; }

        public bool AllowSave { get; set; }
        public bool SaleReturn = false;
        public int LinkedBillID = 0;
        public bool InvoiceUpdate = false;

        public POSChSweets NextObj;
        public POSChSweets PreviousObj;
        public int BillNoCount = 0;
        public bool isBillSaved = false;
        public POSChSweets()
        {
            InitializeComponent();
            //SetupDataGridView();
            timer1.Start();
            //laodCategories();
            loadProducts();
            loadSaleMenuGroup();
            lblShopName.Text = "( " + CompanyInfo.WareHouseName + " )";
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
        private void setAvailableStock(int ItemId)
        {
            var Stock = STATICClass.GetStockQuantityItem(ItemId, CompanyInfo.WareHouseID, txtSaleDate.Value, CompanyInfo.CompanyID, "", "", false);
            if (Stock <= 50)
            {
                StockRunningOut.Text = "Stock Running Out For Item " + cmbProducts.Text;
                StockRunningOut.Visible = true;
            }
            else
            {
                StockRunningOut.Visible = false;
            }
            txtAvailableQty.Text = Convert.ToString(Stock);
        }
        private void laodCategories()
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " select  * from InventCategory where MainCategory=1 ";
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
                        //tlpProducts.Controls.Add(b1);
                    }

                }
                b.Name = dt.Rows[i]["CategoryID"].ToString();
                b.Text = dt.Rows[i]["CategoryName"].ToString();
                b.Click += new EventHandler(generate_Products);
                //if (i > 6)
                //{
                //    return;
                //}
                // tlpProductCategories.Controls.Add(b);

            }
        }

        private void loadSaleMenuGroup()
        {



            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " SELECT * FROM InventItemGroup";
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            DataRow dr = dt.NewRow();
            dr[0] = "0";
            dr[1] = "--Select Menu--";
            dt.Rows.InsertAt(dr, 0);

            cmbSalemenu.ValueMember = "ItemGroupID";
            cmbSalemenu.DisplayMember = "ItemGroupName";
            cmbSalemenu.DataSource = dt;

        }
        private void generate_Products(object sender, EventArgs e)
        {
            // tlpProducts.Controls.Clear();
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
                //tlpProducts.Controls.Add(b);
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
        private void POSChSweets_Load(object sender, EventArgs e)
        {


            cmbInvoicetype.DisplayMember = "Text";
            cmbInvoicetype.ValueMember = "Value";

            var items = new[] {
    new { Text = "Cash Invoice", Value = "1" },
    new { Text = "Dining Sale", Value = "2" },
    new { Text = "Home Delivery-Credit", Value = "3" }
};

            cmbInvoicetype.DataSource = items;


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

            //var CartonQuantity = new DataGridViewTextBoxColumn();
            //CartonQuantity.Name = "Bundle";
            //CartonQuantity.HeaderText = "Bundle";
            //CartonQuantity.Width = 40;
            //CartonQuantity.ReadOnly = true;

            //var buttonSubtract = new DataGridViewButtonColumn();
            //buttonSubtract.Name = "";
            //buttonSubtract.HeaderText = " ";

            //buttonSubtract.Width = 20;
            //var buttonSubtract1 = new DataGridViewButtonColumn();
            //buttonSubtract1.Name = "";
            //buttonSubtract1.HeaderText = " ";

            //buttonSubtract1.Width = 20;

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
            //ItemSaleGrid.Columns.Add(CartonQuantity);
            //ItemSaleGrid.Columns.Add(buttonSubtract1);
            ItemSaleGrid.Columns.Add(buttonPlus);
            ItemSaleGrid.Columns.Add(Quantity);

            //ItemSaleGrid.Columns.Add(buttonSubtract);
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



            decimal TotalDiscount = 0;
            decimal TotalExchanged = 0;
            for (int i = 0; i < ItemSaleGrid.Rows.Count; ++i)
            {

                var NetTotal = Convert.ToDecimal(Convert.ToString(ItemSaleGrid.Rows[i].Cells[3].Value)) * Convert.ToDecimal(Convert.ToString(ItemSaleGrid.Rows[i].Cells[2].Value));
                sum += NetTotal;
                taxAmountTotal += Convert.ToString(ItemSaleGrid.Rows[i].Cells[7].Value) == "" ? 0 : Convert.ToDecimal(ItemSaleGrid.Rows[i].Cells[7].Value);
                TotalDiscount += Convert.ToString(ItemSaleGrid.Rows[i].Cells[5].Value) == "" ? 0 : Convert.ToDecimal(ItemSaleGrid.Rows[i].Cells[5].Value);
            }

            txtGrossAmount.Text = Convert.ToString(Math.Ceiling(sum));
            txtTotalTax.Text = Convert.ToString(Math.Ceiling(taxAmountTotal));
            decimal discAmount = txtDiscountAmount.Text == "" ? 0 : Convert.ToDecimal(txtDiscountAmount.Text);
            txtTotalDiscount.Text = Convert.ToString(Math.Ceiling(discAmount));
            txtNetDtDiscount.Text = Convert.ToString(Math.Ceiling(TotalDiscount));

            CalculateNetTotal();





        }

        private void CalculateNetTotal()
        {
            try
            {
                decimal grossAmount = Convert.ToDecimal(txtGrossAmount.Text);
                decimal totalTaxAmount = Convert.ToDecimal(txtTotalTax.Text);
                decimal discAmount = txtDiscountAmount.Text == "" ? 0 : Convert.ToDecimal(txtDiscountAmount.Text);
                decimal discPercentage = txtDiscountPercentage.Text == "" ? 0 : Convert.ToDecimal(txtDiscountPercentage.Text);
                decimal otherCharges = txtOtherCharges.Text == "" ? 0 : Convert.ToDecimal(txtOtherCharges.Text);

                decimal DtNetDiscount = txtNetDtDiscount.Text == "" ? 0 : Convert.ToDecimal(txtNetDtDiscount.Text);
                decimal totalDiscount = ((discPercentage * grossAmount) / 100) + discAmount + DtNetDiscount;
                decimal netAmount = grossAmount - totalDiscount + totalTaxAmount + otherCharges;
                txtTotalDiscount.Text = totalDiscount.ToString();
                txtNetAmount.Text = Math.Round(netAmount, 2).ToString();
                if (SaleInvoiceNo == 0)
                {
                    if (directReturn == true)
                    {
                        txtPayableAmount.Text = netAmount.ToString();
                    }
                    else
                    {
                        txtReceivableAmount.Text = Math.Round(netAmount, 2).ToString();
                    }

                }
                else if (SaleInvoiceNo > 0 && InvoiceUpdate == true)
                {
                    if (directReturn == true)
                    {
                        txtPayableAmount.Text = netAmount.ToString();
                    }
                    else
                    {
                        txtReceivableAmount.Text = Math.Round(netAmount, 2).ToString();
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
                        //txtAmountReturn.Text = "0.00";
                        //txtAmountReceive.Text = "0.00";
                        //txtPayableAmount.Text = "0.00";
                        txtReceivableAmount.Text = Math.Round((netAmount - accAmount), 2).ToString();
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
            } catch (Exception e)
            {

            }
        }


        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }
        private void CalculateDetail()
        {
            try
            {
                for (int i = 0; i < ItemSaleGrid.Rows.Count; i++)
                {



                    int id = Convert.ToInt32(ItemSaleGrid.Rows[i].Cells[0].Value.ToString());
                    DataTable dt = getProduct(0, Convert.ToInt32(id));
                    var taxPercentage = Convert.ToDecimal(dt.Rows[0]["TotalTax"]);
                    var dtDiscpercentage = Convert.ToString(ItemSaleGrid.Rows[i].Cells[4].Value) == "" ? 0 : Convert.ToDecimal(ItemSaleGrid.Rows[i].Cells[4].Value);
                    string rateValue = ItemSaleGrid.Rows[i].Cells[2].Value.ToString();

                    string total = (Convert.ToDecimal(rateValue) * 1).ToString();

                    var DiscontAmountOnRate = (Convert.ToDecimal(rateValue) / 100) * dtDiscpercentage;
                    var DiscountedRate = Convert.ToDecimal(rateValue) - DiscontAmountOnRate;



                    string taxAmount = (((Convert.ToDecimal(taxPercentage) * Convert.ToDecimal(rateValue)) / 100) * 1).ToString();
                    string value = ItemSaleGrid.Rows[i].Cells[3].Value.ToString();
                    decimal rate = Convert.ToDecimal(rateValue);

                    decimal qty = Convert.ToDecimal(value);

                    ItemSaleGrid.Rows[i].Cells[3].Value = qty;
                    var discountAmt = ((qty) * rate) - ((Convert.ToDecimal(DiscountedRate)) * qty);
                    ItemSaleGrid.Rows[i].Cells[5].Value = discountAmt;

                    ItemSaleGrid.Rows[i].Cells[8].Value = ((qty) * rate) - discountAmt;
                    ItemSaleGrid.Rows[i].Cells[7].Value = ((Convert.ToDecimal(taxPercentage) * rate) / 100) * (qty);





                    GrossAmount_Total();



                }
            } catch (Exception e)
            {

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

        }
        private DataTable getCategories(int ItemGroupID, int CategoryID = 0, string ManualNumber = "")
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = @" Select * from inventcategory where ItemGroupID=" + ItemGroupID + " ";
            if (CategoryID != 0)
            {
                SqlString += "and CategoryID = " + CategoryID;
            }
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            return dt;
        }
        private int GetItemIDbyBuiltInBarcodes(string BarcodeNumber = "")
        {
            string SqlString = "Select Top 1 inv.ItemId,inv.ManualNumber,inv.ItemSalesPrice from data_InventItemsBarcodeDetail dt inner join InventItems inv on inv.ItemId=dt.ItemID";
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();

            if (!string.IsNullOrEmpty(BarcodeNumber))
            {
                SqlString += " where dt.BarcodeNumber = '" + BarcodeNumber.Trim() + "'";
            }
            try
            {
                SqlCommand cmd = new SqlCommand(SqlString, cnn);
                cmd.CommandType = CommandType.Text;
                var ItemID = cmd.ExecuteScalar();
                int ItemIDReturn = ItemID is DBNull ? 0 : Convert.ToInt32(ItemID);
                return ItemIDReturn;
            } catch (Exception e)
            {
                cnn.Close();
                return 0;
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
            if (Convert.ToInt32(cmbSalemenu.SelectedValue) != 0)
            {
                SqlString += "and InventCategory.ItemGroupID  = " + Convert.ToInt32(cmbSalemenu.SelectedValue);
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
                SqlString += " where data_InventItemsBarcodeDetail.BarcodeNumber='" + ManualNumber + "' or data_InventItemsBarcode.SystemBarcode='" + ManualNumber + "'";
            }
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            return dt;
        }
        private void AddProducts(string productName, int id, decimal rates, decimal taxPercentage, decimal CartonSize = 0)
        {

            string total = (Convert.ToDecimal(rates) * 1).ToString();
            string taxAmount = (((Convert.ToDecimal(taxPercentage) * Convert.ToDecimal(rates)) / 100) * 1).ToString();
            txtPromoDisc.Text = Convert.ToString(txtPromoDisc.Text) == "" ? "0" : Convert.ToString(txtPromoDisc.Text);
            txtPromoDiscAmt.Text = Convert.ToString(txtPromoDiscAmt.Text) == "" ? "0" : Convert.ToString(txtPromoDiscAmt.Text);


            bool recordExist = false;
            for (int i = 0; i < ItemSaleGrid.Rows.Count; i++)
            {
                if (id == Convert.ToInt32(ItemSaleGrid.Rows[i].Cells[0].Value.ToString()))
                {

                    string value = ItemSaleGrid.Rows[i].Cells[3].Value.ToString();

                    string rateValue = ItemSaleGrid.Rows[i].Cells[2].Value.ToString();
                    decimal rate = Convert.ToDecimal(rateValue);
                    decimal qty = Convert.ToDecimal(value);
                    decimal taxPerctge = Convert.ToDecimal(ItemSaleGrid.Rows[i].Cells[6].Value);
                    decimal DiscPromo = Convert.ToString(ItemSaleGrid.Rows[i].Cells[4].Value) == "" ? 0 : Convert.ToDecimal(ItemSaleGrid.Rows[i].Cells[4].Value);

                    qty = qty + Convert.ToDecimal(txtQuantity.Text);

                    ItemSaleGrid.Rows[i].Cells[3].Value = qty;
                    var discountAmt = ((Convert.ToDecimal(DiscPromo) * rate) / 100) * qty;
                    ItemSaleGrid.Rows[i].Cells[5].Value = discountAmt;

                    ItemSaleGrid.Rows[i].Cells[8].Value = ((qty) * rate) - discountAmt;
                    var TaxValue = ((Convert.ToDecimal(taxPerctge) * rate) / 100) * qty;
                    ItemSaleGrid.Rows[i].Cells[6].Value = TaxValue;











                    recordExist = true;
                    GrossAmount_Total();
                    ClearFields();
                    txtProductCode.Focus();
                    return;
                }
            }
            if (!recordExist)
            {

                if (txtQuantity.Text == "" || txtRate.Text == "" || txtProductID.Text == "")
                {
                    MessageBox.Show("Please Fill All the Fields...");
                    return;
                }
                var Value = txtQuantity.Text;
                var Rate = txtRate.Text;
                var NetAmount = Convert.ToDecimal(Value) * Convert.ToDecimal(Rate);

                //string[] row = { id.ToString(), cmbProducts.Text, txtQuantity.Text, txtStockRate.Text, NetAmount.ToString(), txtProductID.Text };
                //dgvStockInDetail.Rows.Insert(0, row);
                //ClearFields();
                txtProductID.Focus();

                string[] row = { id.ToString(), cmbProducts.Text, txtRate.Text.ToString(), txtQuantity.Text.ToString(), txtPromoDisc.Text.ToString(), txtPromoDiscAmt.Text.ToString(), txtTax.Text.ToString(), txtTaxAmount.Text.ToString(), txtdetailAmount.Text.ToString(), txtAvailableQty.Text.ToString() };
                ItemSaleGrid.Rows.Insert(0, row);
            }
            GrossAmount_Total();
            ClearFields();
            txtProductCode.Focus();
        }
        private void SetQuantitesBeforAdding(DataTable dt)
        {
            cmbProducts.SelectedValue = dt.Rows[0]["ItemId"].ToString();

            txtRate.Text = Convert.ToString(dt.Rows[0]["ItemSalesPrice"]);
            txtTax.Text = Convert.ToString(dt.Rows[0]["TotalTax"]);
            txtProductID.Text = Convert.ToString(dt.Rows[0]["ItemId"]);
            setAvailableStock(Convert.ToInt32(dt.Rows[0]["ItemId"]));
        }

        private void txtProductCode_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyData == Keys.Enter)
            {
                //if (Convert.ToInt32(cmbSalemenu.SelectedValue) <= 0)
                //{
                //    MessageBox.Show("Please Select Menu First .....");
                //    cmbSalemenu.Select();
                //    cmbSalemenu.Focus();
                //    return ;
                //}
                try
                {
                    if (txtProductCode.Text != "")
                    {
                        DataTable dt = new DataTable();
                        var ItemID = GetItemIDbyBuiltInBarcodes(txtProductCode.Text);
                        //******* Motext barcode ************//
                        bool isMOtextCode = false;

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
                                    dt = getProduct(0, ItemID, Convert.ToString(ItemCode).Trim());
                                    var text = BarcodeNumber.Substring(6 + 1);
                                    if (dt.Rows.Count > 0)
                                    {
                                        txtQuantity.Text = Convert.ToString(BarQuantity);
                                        isMOtextCode = true;
                                        SetQuantitesBeforAdding(dt);
                                        if (BarcodeStd == 98)
                                        {
                                            txtQuantity.Text = "1";
                                        }
                                        else
                                        {
                                            txtQuantity.Text = Convert.ToString(BarQuantity / 10000);
                                        }

                                        txtPromoDisc_KeyDown(sender, e);
                                    }

                                }
                            }


                        }

                        //********************************//

                        if (!isMOtextCode)
                        {
                            dt = getProduct(0, ItemID, Convert.ToString(txtProductCode.Text).Trim());

                            if (dt.Rows.Count == 0)
                            {
                                using (frmProductLookUp obj = new frmProductLookUp(Convert.ToInt32(cmbSalemenu.SelectedValue.ToString())))
                                {
                                    if (obj.ShowDialog() == DialogResult.OK)
                                    {
                                        int id = obj.ProductID;
                                        txtProductID.Text = id.ToString();
                                        txtProductCode.Text = obj.ManualNumber;
                                        cmbProducts.SelectedValue = id.ToString();
                                        var dtReturn = getProduct(0, Convert.ToInt32(id));
                                        setAvailableStock(id);
                                        txtRate.Text = Convert.ToString(dtReturn.Rows[0]["ItemSalesPrice"]);
                                        txtTax.Text = Convert.ToString(dtReturn.Rows[0]["TotalTax"]);
                                        txtQuantity.Focus();
                                        txtQuantity.SelectAll();

                                        //txtQtyPrice.Focus();
                                        //txtQtyPrice.Select();
                                    }
                                };
                            }
                            else
                            {
                                if (ItemID > 0)
                                {
                                    SetQuantitesBeforAdding(dt);
                                    txtQuantity.Text = "1";
                                    txtPromoDisc_KeyDown(sender, e);
                                }
                                else
                                {
                                    cmbProducts.SelectedValue = dt.Rows[0]["ItemId"].ToString();

                                    txtRate.Text = Convert.ToString(dt.Rows[0]["ItemSalesPrice"]);
                                    txtTax.Text = Convert.ToString(dt.Rows[0]["TotalTax"]);
                                    txtProductID.Text = Convert.ToString(dt.Rows[0]["ItemId"]);
                                    setAvailableStock(Convert.ToInt32(dt.Rows[0]["ItemId"]));
                                    txtQuantity.Focus();
                                    txtQuantity.SelectAll();

                                    //txtQtyPrice.Focus();
                                    //txtQtyPrice.Select();
                                }
                            }
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

                } catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
            if (e.KeyData == Keys.Space)
            {
                ItemSaleGrid.Focus();
            }
            if (e.KeyCode == Keys.Escape)
            {
                txtDiscountPercentage.Focus();
            }
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (validateSave())
            {
                GrossAmount_Total();
                CheckReceivedAmount();
                this.totalBill = txtReceivableAmount.Text;
                this.ReceivedAmount = txtAmountReceive.Text;
                this.ReturnAmount = txtAmountReturn.Text;
                if (!string.IsNullOrEmpty(txtCustName.Text))
                {
                    this.CustomerName = txtCustName.Text;
                }
                if (!string.IsNullOrEmpty(txtCustPhone.Text))
                {
                    this.CustomerPhone = txtCustPhone.Text;
                }
                if (!string.IsNullOrEmpty(txtRiderAmount.Text))
                {
                    this.RiderAmount = txtRiderAmount.Text;
                }

                //frmCustomerDataFoodMama frm = new frmCustomerDataFoodMama(this);
                //frm.ShowDialog();
                //txtCustName.Text = this.CustomerName;
                //txtCustPhone.Text = this.CustomerPhone;
                //txtSalesManID.Text = this.SaleManId;
                //txtRiderAmount.Text = this.RiderAmount;
                SaveForm();


            }

        }
        private void CheckReceivedAmount()
        {

            decimal payableAmount = txtReceivableAmount.Text == "" ? 0 : Convert.ToDecimal(txtReceivableAmount.Text);
            decimal returnAmount = txtAmountReturn.Text == "" ? 0 : Convert.ToDecimal(txtAmountReturn.Text);

            decimal recAmount = txtAmountReceive.Text == "" ? 0 : Convert.ToDecimal(txtAmountReceive.Text);
            txtAmountReturn.Text = (recAmount - payableAmount).ToString();
            //}
            if (string.IsNullOrEmpty(txtAmountReceive.Text) || Convert.ToDecimal(txtAmountReceive.Text) < Convert.ToDecimal(txtReceivableAmount.Text))
            {
                MessageBox.Show("Received Amount Can't be Less then Bill Amount...");
                return;
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
            dt1.Columns.Add("SchemeID");
            dt1.Columns.Add("MinQuantity");
            dt1.Columns.Add("isExchange");
            int i = 0;
            foreach (DataGridViewRow row in ItemSaleGrid.Rows)
            {
                var TQty = Convert.ToDecimal(row.Cells[3].Value.ToString());
                if (TQty > 0)
                {

                    DataRow dRow = dt1.NewRow();
                    i = i + 1;

                    dRow[0] = i;
                    dRow[1] = row.Cells[0].Value.ToString();
                    dRow[2] = TQty.ToString();
                    dRow[3] = row.Cells[2].Value.ToString();
                    dRow[4] = row.Cells[6].Value.ToString();
                    dRow[5] = row.Cells[7].Value.ToString();
                    dRow[6] = (string.IsNullOrEmpty(Convert.ToString(row.Cells[4].Value)) || Convert.ToString(row.Cells[4].Value) == ".") ? "0" : Convert.ToString(row.Cells[4].Value);
                    dRow[7] = row.Cells[5].Value.ToString();
                    dRow[8] = row.Cells[8].Value.ToString();
                    dRow[9] = 0;//row.Cells[13].Value.ToString();
                    dRow[10] = 0;// row.Cells[4].Value.ToString();
                    dRow[11] = TQty;// row.Cells[7].Value.ToString();
                    dRow[12] = 0; //Convert.ToString(row.Cells[14].Value);

                    dt1.Rows.Add(dRow);
                }
            }
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            SqlTransaction tran;
            con.Open();
            tran = con.BeginTransaction();
            SqlCommand cmd;
            if (SaleReturn == false && InvoiceUpdate == false)
            {
                cmd = new SqlCommand("data_SalePosInfo_Insert", con);

            }
            else if (InvoiceUpdate == true)
            {
                cmd = new SqlCommand("data_SalePosInfo_update", con);
                SalePosMasterID = Convert.ToInt32(SalePosID.Text);
            }
            else
            {
                cmd = new SqlCommand("data_SalePosReturnInfo_Insert", con);
                SalePosMasterID = Convert.ToInt32(SalePosID.Text);
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
            cmd.Parameters.AddWithValue("@NetAmount", txtNetAmount.Text == "" ? 0 : Convert.ToDecimal(txtNetAmount.Text));
            cmd.Parameters.AddWithValue("@SalePosDate", Convert.ToDateTime(txtSaleDate.Value.Date));
            cmd.Parameters.AddWithValue("@MenuId", Convert.ToInt32(cmbSalemenu.SelectedValue));
            cmd.Parameters.AddWithValue("@InvoiceType", Convert.ToInt32(cmbInvoicetype.SelectedValue));
            cmd.Parameters.AddWithValue("@AmountReceive", txtAmountReceive.Text == "" ? 0 : Convert.ToDecimal(txtAmountReceive.Text));
            cmd.Parameters.AddWithValue("@AmountReturn", txtAmountReturn.Text == "" ? 0 : Convert.ToDecimal(txtAmountReturn.Text));
            cmd.Parameters.AddWithValue("@AmountInAccount", txtAccAmount.Text == "" ? 0 : Convert.ToDecimal(txtAccAmount.Text));
            cmd.Parameters.AddWithValue("@CustomerID", txtRegisterID.Text == "" ? 0 : Convert.ToInt32(txtRegisterID.Text));
            cmd.Parameters.AddWithValue("@SaleManId", txtSalesManID.Text == "" ? null : Convert.ToString(txtSalesManID.Text));
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
            cmd.Parameters.AddWithValue("@RiderAmount", txtRiderAmount.Text == "" ? null : Convert.ToString(txtRiderAmount.Text));
            cmd.Parameters.AddWithValue("@LinckedBill", txtLinkedBill.Text == "" ? null : Convert.ToString(txtLinkedBill.Text));

            if (directReturn == true)
            {
                cmd.Parameters.AddWithValue("@DirectReturn", true);
            }
            cmd.Parameters.AddWithValue("@CounterID", CompanyInfo.CounterID);
            cmd.Parameters.AddWithValue("@data_SalePosDetail", dt1);

            da.SelectCommand = cmd;
            try
            {
                cmd.Transaction = tran;
                da.Fill(dt1);
                tran.Commit();
                isBillSaved = true;
                string SaleInvoiceNO = p.Value.ToString();
                var value = new List<string[]>();
                string[] ss = { "@SaleInvoice", SaleInvoiceNO };
                value.Add(ss);
                var valueforLinked = new List<string[]>();
                valueforLinked.Add(ss);
                frmCrystal obj = new frmCrystal();
                string reportName = "";
                if (directReturn == false)
                {
                   
                        reportName = "SaleInvoice";
                        if (!string.IsNullOrEmpty(txtLinkedBill.Text))
                        {
                            string[] PP = { "@LinckedBill", txtLinkedBill.Text.ToString() };
                            valueforLinked.Add(PP);
                            obj.loadSaleFoodMamaReportLinked("rpt_sale_invoice_Lincked", reportName, valueforLinked);
                        }
                        else
                        {
                            if (SaleReturn)
                            {
                                obj.loadSaleFoodMamaReport("rpt_saleReturn_invoice", reportName, value, SaleReturn);
                            }
                            else
                            {
                                obj.loadSaleFoodMamaReport("rpt_sale_invoice", reportName, value, SaleReturn);
                            }
                        }


                        if (Convert.ToInt32(cmbSalemenu.SelectedValue) == 26)
                        {
                            obj.loadSaleKitchenReport("rpt_sale_invoiceKitchen", reportName, value);
                        }
                    
                }
                //else
                //{
                //    reportName = "SaleInvoiceReturn";
                //    obj.loadReport("rpt_sale_invoice", reportName, value);
                //}
                clearAll();
                if (SaleInvoiceNo == 0)
                {
                    //MessageBox.Show("Record has been Saved!");
                }
                else
                {
                    //MessageBox.Show("Record has been Updated!");
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
                MessageBox.Show(ex.Message, "Important Message", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                con.Close();
            }
        }

        public void FbrInvoiceObject()
        {
            Fbr_InvoiceMaster FbrObj = new Fbr_InvoiceMaster();
            FbrObj.InvoiceNumber = string.Empty;
            FbrObj.POSID = 955354;
            FbrObj.USIN = "123457";
            FbrObj.DateTime = txtSaleDate.Value.Date;
            FbrObj.BuyerNTN = "1234567-9";
            FbrObj.BuyerCNIC = "12345-1234567-8";
            FbrObj.BuyerName = "Buyer Name";
            FbrObj.BuyerPhoneNumber = "0345-1234567";
            FbrObj.PaymentMode = 1;
            FbrObj.TotalSaleValue = 0;
            FbrObj.TotalQuantity = 0;
            FbrObj.TotalBillAmount = 0;
            FbrObj.TotalTaxCharged = 0;
            FbrObj.Discount = 1000;
            FbrObj.FurtherTax = 100;
            FbrObj.InvoiceType = 1;
            FbrObj.Items = Items();
            var Responce= JsonConvert.DeserializeObject<Fbr_ResponceObj>(STATICClass.SyncFbrInvoice(FbrObj));
          


        }
        private List<Fbr_InvoiceDetail> Items()
        {
            List<Fbr_InvoiceDetail> lst = new List<Fbr_InvoiceDetail>();

            Fbr_InvoiceDetail objItem = new Fbr_InvoiceDetail();
            objItem.ItemCode = "0000";
            objItem.ItemName = "Item Name";
            objItem.Quantity = 3;
            objItem.TotalAmount = Convert.ToDecimal(3000.00);
            objItem.SaleValue = Convert.ToDecimal(3180);
            objItem.TaxCharged = Convert.ToDecimal(180);
            objItem.TaxRate = 6;
            objItem.PCTCode = "11001010";
            objItem.FurtherTax = 20;
            objItem.InvoiceType = 1;
            objItem.Discount = 500;
            lst.Add(objItem);
            return lst;

        }
      

        private bool validateSave()
        {
            
                if(System.DateTime.Now.Date>txtSaleDate.Value.Date)
                {
                    MessageBox.Show("You can't Save Invoice in Back date...");
                    return false;
                }


            txtAmountReceive.Text = txtAmountReceive.Text == "" || txtAmountReceive.Text == "0" ? Convert.ToString(txtReceivableAmount.Text) : Convert.ToString(txtAmountReceive.Text);
            decimal amountReceived = txtAmountReceive.Text == "" || txtAmountReceive.Text=="0" ? Convert.ToDecimal(txtReceivableAmount.Text) : Convert.ToDecimal(txtAmountReceive.Text);
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
                    txtAmountReceive.Text = Convert.ToString(txtReceivableAmount.Text);
                    validateReturnOK = true;

                    //txtAmountReceive.Focus();
                    //MessageBox.Show("Amount Receive should be greater than Receivable Amount!");
                    //validateReturnOK = false;
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
                    using (FrmSaleInvoiceLookupCounterWise obj = new FrmSaleInvoiceLookupCounterWise())
                    {
                        if (obj.ShowDialog() == DialogResult.OK)
                        {
                            string id = obj.SaleInvoiceNo;
                            if (id != "")
                            {
                                clearAll();
                                txtSaleDate.Value = obj.SaleInvoiceDate;
                                loadWholeInvoice(id);
                                txtInvoiceNo.Text = id;
                            }
                        }
                    };
                    //MessageBox.Show("Please Enter Invoice Number!");
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
            txtRiderAmount.Clear();

            txtLinkedBill.Clear();
            txtPromoDisc.Clear();
            txtPromoDiscAmt.Clear();

            cmbProducts.SelectedValue = "0";

            txtLinkedBillNo.Clear();
            txtQtyPrice.Clear();
            directReturn = false;

            txtAvailableQty.Clear();
            SalePosID.Clear();
            SalePosMasterID = 0;
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
            InvoiceUpdate = false;

            btnUpdate.Visible = false;
            btnSave.Visible = true;
            btnSave.Text = "Save";
            //txtAmountReceive.ReadOnly = false;
        }

        private void getInvoiceNumber()
        {



            int SaleVoucherNo = GetVoucherNoI(Fieldname: "SalePOSNo", TableName: "data_SalePosInfo", CheckTaxable: false,
                    PrimaryKeyValue: 0, PrimaryKeyFieldName: "SalePosID", voucherDate: Convert.ToDateTime(txtSaleDate.Value.Date), voucherDateFieldName: "SalePosDate",
                    companyID:CompanyInfo.CompanyID, FiscalID: CompanyInfo.FiscalID, MenuId:Convert.ToInt32(cmbSalemenu.SelectedValue), CounterField: "CounterID");
            txtInvoiceNo.Text = Convert.ToString(SaleVoucherNo);
        }
        public Int32 GetVoucherNoI(string Fieldname, string TableName, bool CheckTaxable, Int32 PrimaryKeyValue,
          string PrimaryKeyFieldName, DateTime? voucherDate, string voucherDateFieldName = "",
          Int32 companyID = 0, string companyFieldName = "CompanyID", Int32 FiscalID = 0,
          string FiscalIDFieldName = "FiscalID", bool IsTaxable = false,Int32 MenuId=0,string CounterField = "")
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            try
            {
                DataTable dt = new DataTable();
                SqlConnection con = new SqlConnection(connectionString);
                SqlCommand cmd = new SqlCommand("GetVoucherNoPosFoodMama", con);
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
                cmd.Parameters.Add(new SqlParameter("@CounterID", CompanyInfo.CounterID));
                cmd.Parameters.Add(new SqlParameter("@CounterField", CounterField));
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

            else if (keyData == (Keys.F5))
            {
                txtProductCode.Select();
                txtProductCode.Focus();
            }
           
            else if (keyData == (Keys.Alt | Keys.R))
            {
                //if (Convert.ToInt32(cmbSalemenu.SelectedValue)<=0)
                //{
                //    MessageBox.Show("Please Select Menu First .....");
                //    cmbSalemenu.Select();
                //    cmbSalemenu.Focus();
                //    return false;
                //}
                //else
                //{ 
                loadReturnView();

                return true;
                //}
            }
            else if (keyData == (Keys.Alt | Keys.U))
            {
                //if (Convert.ToInt32(cmbSalemenu.SelectedValue) <= 0)
                //{
                //    MessageBox.Show("Please Select Menu First .....");
                //    cmbSalemenu.Select();
                //    cmbSalemenu.Focus();
                //    return false;
                //}
                //else
                //{
                LoadUpdateView();

                return true;
                //}
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
            else if (keyData == (Keys.Alt | Keys.Z))
            {
                txtProductCode.SelectAll();
                txtProductCode.Focus();
                return true;
            }
            return base.ProcessCmdKey(ref msg, keyData);
        }
        private void ItemSaleGrid_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.ColumnIndex == 6)
            {
//                string value = ItemSaleGrid.Rows[e.RowIndex].Cells["Quantity"].Value.ToString();
//                string rateValue = ItemSaleGrid.Rows[e.RowIndex].Cells["Rate"].Value.ToString();
//                string taxValue = ItemSaleGrid.Rows[e.RowIndex].Cells["Tax"].Value.ToString();
//                decimal Bundle = Convert.ToDecimal(ItemSaleGrid.Rows[e.RowIndex].Cells["Bundle"].Value.ToString());
//                decimal BundleSize = Convert.ToDecimal(ItemSaleGrid.Rows[e.RowIndex].Cells["cartonSize"].Value.ToString());
//                decimal rate = Convert.ToDecimal(rateValue);
//                decimal qty = Convert.ToDecimal(value);
//                qty++;
//                ItemSaleGrid.Rows[e.RowIndex].Cells["Quantity"].Value = qty;
//                ItemSaleGrid.Rows[e.RowIndex].Cells["Total"].Value = Math.Round(((Bundle * BundleSize) + qty) * rate, 2);
//                ItemSaleGrid.Rows[e.RowIndex].Cells["TaxAmount"].Value = ((Convert.ToDecimal(taxValue) * rate) / 100) * qty;
            }

            if (e.ColumnIndex == 3)
            {
//                string value = ItemSaleGrid.Rows[e.RowIndex].Cells["Bundle"].Value.ToString();
//                string rateValue = ItemSaleGrid.Rows[e.RowIndex].Cells["Rate"].Value.ToString();
//                string taxValue = ItemSaleGrid.Rows[e.RowIndex].Cells["Tax"].Value.ToString();
//                decimal qty = Convert.ToDecimal(ItemSaleGrid.Rows[e.RowIndex].Cells["Quantity"].Value.ToString());
//                decimal BundleSize = Convert.ToDecimal(ItemSaleGrid.Rows[e.RowIndex].Cells["cartonSize"].Value.ToString());
//                decimal rate = Convert.ToDecimal(rateValue);
//                decimal Bundle = Convert.ToDecimal(value);
//                Bundle++;
//                ItemSaleGrid.Rows[e.RowIndex].Cells["Bundle"].Value = Bundle;
//                ItemSaleGrid.Rows[e.RowIndex].Cells["Total"].Value = Math.Round(((Bundle * BundleSize) + qty) * rate, 2);
//                ItemSaleGrid.Rows[e.RowIndex].Cells["TaxAmount"].Value = ((Convert.ToDecimal(taxValue) * rate) / 100) * qty;
            }
            else if (e.ColumnIndex == 5)
            {
                //string value = ItemSaleGrid.Rows[e.RowIndex].Cells["Bundle"].Value.ToString();
                //string rateValue = ItemSaleGrid.Rows[e.RowIndex].Cells["Rate"].Value.ToString();
                //string taxValue = ItemSaleGrid.Rows[e.RowIndex].Cells["Tax"].Value.ToString();
                //decimal qty = Convert.ToDecimal(ItemSaleGrid.Rows[e.RowIndex].Cells["Quantity"].Value.ToString());
                //decimal BundleSize = Convert.ToDecimal(ItemSaleGrid.Rows[e.RowIndex].Cells["cartonSize"].Value.ToString());
                //decimal rate = Convert.ToDecimal(rateValue);
                //decimal Bundle = Convert.ToDecimal(value);
                //if (Bundle > 1)
                //{
                //    Bundle--;
                //    ItemSaleGrid.Rows[e.RowIndex].Cells["Bundle"].Value = Bundle;
                //    ItemSaleGrid.Rows[e.RowIndex].Cells["Total"].Value = Math.Round(((Bundle * BundleSize) + qty) * rate, 2);
                //    ItemSaleGrid.Rows[e.RowIndex].Cells["TaxAmount"].Value = ((Convert.ToDecimal(taxValue) * rate) / 100) * qty;
                //}
            }
            else if (e.ColumnIndex == 8)
            {
                //string value = ItemSaleGrid.Rows[e.RowIndex].Cells["Quantity"].Value.ToString();
                //string rateValue = ItemSaleGrid.Rows[e.RowIndex].Cells["Rate"].Value.ToString();
                //string taxValue = ItemSaleGrid.Rows[e.RowIndex].Cells["Tax"].Value.ToString();
                //decimal Bundle = Convert.ToDecimal(ItemSaleGrid.Rows[e.RowIndex].Cells["Bundle"].Value.ToString());
                //decimal BundleSize = Convert.ToDecimal(ItemSaleGrid.Rows[e.RowIndex].Cells["cartonSize"].Value.ToString());
                //decimal rate = Convert.ToDecimal(rateValue);
                //decimal qty = Convert.ToDecimal(value);
                //if (qty > 1)
                //{
                //    qty--;
                //    ItemSaleGrid.Rows[e.RowIndex].Cells["Quantity"].Value = qty;
                //    ItemSaleGrid.Rows[e.RowIndex].Cells["Total"].Value = Math.Round(((Bundle * BundleSize) + qty) * rate, 2);
                //    ItemSaleGrid.Rows[e.RowIndex].Cells["TaxAmount"].Value = ((Convert.ToDecimal(taxValue) * rate) / 100) * qty;
                //}
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
            if (ItemSaleGrid.CurrentCell.ColumnIndex == ItemSaleGrid.Columns["dtDiscpercentage"].Index) //Desired Column
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
            NumberFormatInfo nfi = Thread.CurrentThread.CurrentCulture.NumberFormat;
            char decSeperator;

            decSeperator = nfi.CurrencyDecimalSeparator[0];
            //if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar)
            //     && e.KeyChar != '.')
            //{
            //    e.Handled = true;
            //}


            //if (e.KeyChar == '.'
            //    && (sender as TextBox).Text.IndexOf('.') > 0)
            //{
            //    e.Handled = true;
            //}
            if (!char.IsControl(e.KeyChar) && !(char.IsDigit(e.KeyChar)
| e.KeyChar == decSeperator))
            {
                e.Handled = true;
            }
            // only allow one decimal point
            if (e.KeyChar == decSeperator
                && (sender as TextBox).Text.IndexOf(decSeperator) > -1)
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
        private void LoadNewInstance()
        {
            if (NextObj!=null)
            {
                NextObj.Show();
               
               
            }
            else
            {
                NextObj = new POSChSweets();
                BillNoCount++;
                NextObj.lblFindPendingBill.Text = "Pending Bill No " + Convert.ToInt32(BillNoCount);
                NextObj.BillNoCount = BillNoCount;
                NextObj.PreviousObj = this;
                NextObj.PreviousObj.WindowState=FormWindowState.Minimized;
                NextObj.Focus();
                NextObj.ShowDialog();
                
              
            }
        }
        private void LoadPreviousInstance()
        {

            
            if (PreviousObj != null)
            {
                PreviousObj.Focus();
                PreviousObj.Show();
                this.WindowState=FormWindowState.Minimized;
            }
            else
            {
                lblFindPendingBill.Text = "No Pending Bill Found Press F6 to Open New";
            }
        }
        private void loadReturnView()
        {
            clearAll();
            lblSaleType.Text = "Sale Return";
            txtInvoiceNo.ReadOnly = false;
            txtInvoiceNo.Text = "";
            txtInvoiceNo.Focus();
            btnSave.Text = "Return Invoice";
       
            SaleReturn = true;
        }
        private void LoadUpdateView()
        {
            clearAll();
            lblSaleType.Text = "Update Sales Invoice";
            txtInvoiceNo.ReadOnly = false;
            txtInvoiceNo.Text = "";
            txtInvoiceNo.Focus();
            btnSave.Visible = false; 
            btnUpdate.Visible = true;
            InvoiceUpdate = true;
        }
        private void loadDirectReturn()
        {
            clearAll();
            lblSaleType.Text = "Direct Return";
            directReturn = true;
        }

        private void btnNewSale_Click(object sender, EventArgs e)
        {
            using (FrmSaleInvoiceLookupCounterWise obj = new FrmSaleInvoiceLookupCounterWise())
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

            string whereclause = " where SaleposNo=" + InvoiceNo+" and SalePOsDate="+txtSaleDate.Value.Date+" and MenuId="+Convert.ToInt32(cmbSalemenu.SelectedValue)+"";
            cmd.Parameters.AddWithValue("@SelectMaster", 1);
            cmd.Parameters.AddWithValue("@SelectDetail", 1);
            cmd.Parameters.AddWithValue("@InvoiceNo", InvoiceNo);
            cmd.Parameters.AddWithValue("@CounterID", Convert.ToInt32(CompanyInfo.CounterID));
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
                txtAmountReceive.Text = dt.Rows[0]["AmountReceive"].ToString();
                txtAccAmount.Text = dt.Rows[0]["NetAmount"].ToString();
                //txtPayableAmount.Text = dt.Rows[0]["NetAmount"].ToString();
                if (InvoiceUpdate == false)
                {
                    txtPayableAmount.Text = dt.Rows[0]["AmountReceivable"].ToString();
                }
                    txtAmountReturn.Text = dt.Rows[0]["AmountReturn"].ToString();
                txtReceivableAmount.Text = dt.Rows[0]["AmountReceivable"].ToString();
                txtCustName.Text= Convert.ToString(dt.Rows[0]["CustomerName"]);
                txtCustPhone.Text = Convert.ToString(dt.Rows[0]["CustomerPhone"]);
                SalePosID.Text= Convert.ToString(dt.Rows[0]["SalePosID"]);
                txtLinkedBill.Text = Convert.ToString(dt.Rows[0]["LinckedBill"]);
                txtLinkedBillNo.Text = Convert.ToString(dt.Rows[0]["LinkedBillNo"]);
                txtRiderAmount.Text = Convert.ToString(dt.Rows[0]["RiderAmount"]);
                cmbSalemenu.SelectedValue= Convert.ToString(dt.Rows[0]["MenuId"]);
                var abc = dt.Rows[0]["InvoiceType"];
                cmbInvoicetype.SelectedValue= Convert.ToString(dt.Rows[0]["InvoiceType"]);
                if (InvoiceUpdate == false)
                {
                    txtAmountReceive.ReadOnly = true;
                }
                    txtPrint.Visible = true;
                if (InvoiceUpdate == false)
                {
                    SaleReturn = true;
                }
                    for (int i = 0; i < dtdetail.Rows.Count; i++)
                {
                    string[] row = {
                            dtdetail.Rows[i]["ItemId"].ToString(),
                            dtdetail.Rows[i]["ItenName"].ToString(),
                            dtdetail.Rows[i]["ItemRate"].ToString(),
                            
                            
                            Convert.ToDecimal(dtdetail.Rows[i]["TotalQuantity"]).ToString(),
                             dtdetail.Rows[i]["DiscountPercentage"].ToString(),
                            dtdetail.Rows[i]["DiscountAmount"].ToString(),
                            dtdetail.Rows[i]["TaxPercentage"].ToString(),
                            dtdetail.Rows[i]["TaxAmount"].ToString(),
                            dtdetail.Rows[i]["TotalAmount"].ToString()

                    };
                    ItemSaleGrid.Rows.Add(row);
                    CalculateDetail();
                    txtProductCode.Select();
                    txtProductCode.Focus();
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
            if(e.KeyCode==Keys.Enter )
            {
                if (string.IsNullOrEmpty(txtCustPhone.Text))
                {
                    using (frmSearchCustomerLookup obj = new frmSearchCustomerLookup())
                    {
                        if (obj.ShowDialog() == DialogResult.OK)
                        {
                            string Rno = obj.RegisterNo;
                            txtRegisterID.Text = obj.CustomerID;
                            if (obj.CustomerID != "")
                            {
                                LoadCustomerData(obj.CustomerID);
                            }
                        }

                    };
                }
                else
                {
                    txtCustName.Select();
                    txtCustName.Focus();
                }
                

                
                
            }
        }
        private void LoadCustomerData(string CustomerID)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataTable dtdetail = new DataTable();
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            SqlTransaction tran;
            con.Open();
            tran = con.BeginTransaction();
            SqlCommand cmd = new SqlCommand("PosData_tblCustomerData_SelectAll", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter();

            string whereclause = " where CustomerID=" + CustomerID + " and WHID=" + CompanyInfo.WareHouseID + "";
            cmd.Parameters.AddWithValue("@SelectMaster", 1);
            cmd.Parameters.AddWithValue("@WhereClause", whereclause);

            da.SelectCommand = cmd;
            try
            {
                cmd.Transaction = tran; da.Fill(ds);
                dt = ds.Tables[0];

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


               
                txtCustName.Text = Convert.ToString(dt.Rows[0]["CName"]);
                txtCustPhone.Text = Convert.ToString(dt.Rows[0]["CPhone"]);
                txtCustName.Focus();





            }
            else
            {
                MessageBox.Show("We have no Customer  regarding this No!");
            }
        }

        private void ClearFields()
        {
            txtProductID.Clear();

            txtRate.Clear();
            txtQuantity.Clear();
            txtTax.Clear();
            txtTaxAmount.Clear();
            txtdetailAmount.Clear();
            txtProductCode.Clear();
            txtPromoDisc.Clear();
            txtPromoDiscAmt.Clear();

            cmbProducts.SelectedValue = "0";
            txtTax.ReadOnly = true;
            txtTaxAmount.ReadOnly = true;
            txtdetailAmount.ReadOnly = true;
            txtRate.ReadOnly = true;
            txtQtyPrice.Clear();
            txtAvailableQty.Clear();
            StockRunningOut.Visible = false;

        }

        private void ItemSaleGrid_KeyDown(object sender, KeyEventArgs e)
        {
            
            if(e.KeyCode==Keys.Enter)
            {
                if (MessageBox.Show("Are You Sure You Want to Delete the Selected Record...?", "Confirmation...!!", MessageBoxButtons.YesNo) == DialogResult.Yes)
                {
                    ItemSaleGrid.Rows.RemoveAt(ItemSaleGrid.CurrentRow.Index);
                    txtProductCode.Select();
                    txtProductCode.Focus();

                    return;
                }


            }
            if(e.KeyCode==Keys.Space)
            {
               txtDiscountPercentage.Focus();

            }
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
            var valueforLinked = new List<string[]>();
            string[] ss = { "@SaleInvoice", SaleInvoiceNO };
            value.Add(ss);
            valueforLinked.Add(ss);
            frmCrystal obj = new frmCrystal();
            string reportName = "";
            if (directReturn == false)
            {
                reportName = "SaleInvoice";
                //obj.loadReport("rpt_sale_invoice", reportName, value);
                if (!string.IsNullOrEmpty(txtLinkedBill.Text))
                {
                    string[] PP = { "@LinckedBill", txtLinkedBill.Text.ToString() };
                    valueforLinked.Add(PP);
                    obj.loadSaleFoodMamaReportLinked("rpt_sale_invoice_Lincked", reportName, valueforLinked);
                }
                else
                {
                    obj.loadSaleFoodMamaReport("rpt_sale_invoice", reportName, value,false,true);
                }
                   // obj.loadSaleKitchenReport("rpt_sale_invoiceKitchen", reportName, value);
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

        private async void btnStock_Click(object sender, EventArgs e)
        {

            await STATICClass.GetAllInventory();
            await STATICClass.GetStokcIssue();
            using (frmStockArrival obj = new frmStockArrival())
            {
                if (obj.ShowDialog() == DialogResult.OK)
                {

                }
            };
        }

        private void cashBookToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmCashBookReport obj = new frmCashBookReport();
            obj.Show();
        }

        private void stockArrivalListToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmStockArrivalList obj = new frmStockArrivalList();
            obj.ShowDialog();
        }

        private void manualStockInToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmManualStockIN obj = new frmManualStockIN();
            obj.ShowDialog();
        }

        private void syncToServerToolStripMenuItem_Click(object sender, EventArgs e)
        {
            frmDataSyncServer obj =new  frmDataSyncServer();
            obj.ShowDialog();

        }

        private void panel3_Paint(object sender, PaintEventArgs e)
        {

        }

        private void panel4_Paint(object sender, PaintEventArgs e)
        {

        }

        private void tlpProductCategories_Paint(object sender, PaintEventArgs e)
        {

        }

        private void panel2_Paint(object sender, PaintEventArgs e)
        {

        }

        private void label14_Click(object sender, EventArgs e)
        {

        }

        private void txtTotalTax_TextChanged(object sender, EventArgs e)
        {

        }

        private void label6_Click(object sender, EventArgs e)
        {

        }

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void label16_Click(object sender, EventArgs e)
        {

        }

        private void tableLayoutPanel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void lblSaleType_Click(object sender, EventArgs e)
        {

        }

        private void tlpProductCategories_Paint_1(object sender, PaintEventArgs e)
        {

        }

        private void panel4_Paint_1(object sender, PaintEventArgs e)
        {

        }

        private void panel2_Paint_1(object sender, PaintEventArgs e)
        {

        }

        private void label12_Click(object sender, EventArgs e)
        {

        }

        private void SalePosID_TextChanged(object sender, EventArgs e)
        {

        }

        private void lblDateTime_Click(object sender, EventArgs e)
        {

        }

        private void label21_Click(object sender, EventArgs e)
        {

        }

        private void txtInvoiceNo_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtCustName_TextChanged(object sender, EventArgs e)
        {

        }

        private void label10_Click(object sender, EventArgs e)
        {

        }

        private void panel5_Paint(object sender, PaintEventArgs e)
        {

        }

        private void txtProductCode_TextChanged(object sender, EventArgs e)
        {

        }

        private void dgvStockInDetail_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtQuantity_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar) && e.KeyChar != '.')
            {

                e.Handled = true;

            }


            if (e.KeyChar == '.' && (sender as TextBox).Text.IndexOf('.') > -1)
            {


                e.Handled = true;
            }
            CalculateNetAmountDetail();
        }
        private void CalculateNetAmountDetail()
        {
            try
            {
                if (txtQuantity.Text != "" && txtRate.Text != "")
                {
                    var SchemeDiscount = txtPromoDisc.Text == "" ? 0 : Convert.ToDecimal(txtPromoDisc.Text);

                    var DiscontAmountOnRate = (Convert.ToDecimal(txtRate.Text) / 100) * SchemeDiscount;
                    var DiscountedRate = Convert.ToDecimal(txtRate.Text) - DiscontAmountOnRate;
                    var NetAmount = Convert.ToDecimal(txtQuantity.Text) * Convert.ToDecimal(DiscountedRate);
                    var Taxpercent = Convert.ToDecimal(txtTax.Text);
                    var AmountTax = Convert.ToDecimal(txtQuantity.Text) * ((Taxpercent * Convert.ToDecimal(txtRate.Text)) / 100);
                    txtPromoDiscAmt.Text = Convert.ToString(Convert.ToDecimal(txtQuantity.Text) * Convert.ToDecimal(DiscontAmountOnRate));
                    txtTaxAmount.Text = AmountTax.ToString();
                    txtTaxAmount.Text = AmountTax.ToString();
                    txtdetailAmount.Text = Convert.ToString(NetAmount + AmountTax);
                    txtdetailAmount.Text = Convert.ToString(Math.Round(NetAmount + AmountTax, 2));
                }
                else
                {
                    txtNetAmount.Text = "";
                }
            }catch(Exception)
            {

            }
        }

        private void txtQuantity_KeyDown(object sender, KeyEventArgs e)
        {

            if (e.KeyCode == Keys.Enter)
            {
                try
                {
                    txtQtyPrice.Focus();
                    txtQtyPrice.SelectAll();
                           

                  
                }catch(Exception ex)
                {
                    
                }
            }

        
        }

        private void ItemSaleGrid_KeyPress(object sender, KeyPressEventArgs e)
        {
            CalculateDetail();
        }

        private void ItemSaleGrid_Leave(object sender, EventArgs e)
        {

            CalculateDetail();
        }

        private void ItemSaleGrid_CellValueChanged(object sender, DataGridViewCellEventArgs e)
        {
            CalculateDetail();
        }

        private void label6_Click_1(object sender, EventArgs e)
        {

        }

        private void txtNetAmount_TextChanged(object sender, EventArgs e)
        {

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void label17_Click(object sender, EventArgs e)
        {

        }

        private void label8_Click(object sender, EventArgs e)
        {

        }

        private void txtAmountReturn_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtAmountReceive_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
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
                decimal recAmount = txtAmountReceive.Text == "" ? payableAmount : Convert.ToDecimal(txtAmountReceive.Text);
                txtAmountReceive.Text = txtAmountReceive.Text == "" ? Convert.ToString(payableAmount) : Convert.ToString(txtAmountReceive.Text);
                txtAmountReturn.Text = (recAmount - payableAmount).ToString();
                //}
                if (string.IsNullOrEmpty(txtAmountReceive.Text) || Convert.ToDecimal(txtAmountReceive.Text) < Convert.ToDecimal(txtReceivableAmount.Text))
                {
                    MessageBox.Show("Received Amount Can't be Less then Bill Amount...");
                    return;
                }
                else
                {
                    if (InvoiceUpdate == true)
                    {
                        btnUpdate.Focus();
                    }
                    else
                    {
                        btnSave.Focus();
                    }
                }
            }
        }

        private void txtAmountReceive_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar) && e.KeyChar != '.')
            {

                e.Handled = true;

            }


            if (e.KeyChar == '.' && (sender as TextBox).Text.IndexOf('.') > -1)
            {


                e.Handled = true;
            }
        }

        private void txtDiscountPercentage_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                txtDiscountAmount.Focus();
            }
        }

        private void txtDiscountAmount_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                txtOtherCharges.Focus();
            }

        }

        private void txtOtherCharges_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                txtAmountReceive.Focus();
            }
        }

        private void txtReceivableAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar) && e.KeyChar != '.')
            {

                e.Handled = true;

            }


            if (e.KeyChar == '.' && (sender as TextBox).Text.IndexOf('.') > -1)
            {


                e.Handled = true;
            }
        }

        private void txtCustName_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                //cmbSalemenu.Select();
                //cmbSalemenu.Focus();
                cmbSalemenu_KeyDown(sender, e);
            }
        }

        private void cmbSalemenu_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                cmbInvoicetype.Select();
                txtProductCode.Select();
                cmbInvoicetype.Focus();
            }
        }

        private void txtdetailAmount_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtAccAmount_TextChanged(object sender, EventArgs e)
        {

        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        private void cmbInvoicetype_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                txtLinkedBillNo.Clear();
                txtLinkedBillNo.Focus();
            }
        }

        private void cmbSalemenu_SelectedIndexChanged(object sender, EventArgs e)
        {
            getInvoiceNumber();
        }

        private void CheckInvoiceNoForLink(string InvoiceNo)
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

            string whereclause = " where SaleposNo=" + InvoiceNo + " and SalePOsDate=" + txtSaleDate.Value.Date + " and MenuId=" + Convert.ToInt32(cmbSalemenu.SelectedValue) + "";
            cmd.Parameters.AddWithValue("@SelectMaster", 1);
            cmd.Parameters.AddWithValue("@SelectDetail", 1);
            cmd.Parameters.AddWithValue("@InvoiceNo", InvoiceNo);
            cmd.Parameters.AddWithValue("@MenuId", Convert.ToInt32(cmbSalemenu.SelectedValue));
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








                txtLinkedBill.Text = Convert.ToString(dt.Rows[0]["SalePosID"]);
                cmbSalemenu.SelectedValue = Convert.ToString(dt.Rows[0]["MenuId"]);
                var abc = dt.Rows[0]["InvoiceType"];
                cmbInvoicetype.SelectedValue = Convert.ToString(dt.Rows[0]["InvoiceType"]);
               
              
             
            }
            else
            {
                MessageBox.Show("We have no Sale Invoice regarding this No!");
                txtLinkedBill.Clear();
                txtLinkedBillNo.Clear();
            }
        }
        private void txtLinkedBillNo_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.F1)
            {
                if (txtLinkedBillNo.Text != "" || (txtLinkedBillNo.Text == "" ? 0 : Convert.ToInt64(txtLinkedBillNo.Text)) != 0)
                {

                    string InvoiceNo = txtLinkedBillNo.Text;
                    CheckInvoiceNoForLink(InvoiceNo);
                }
                else
                {
                    using (frmSaleInvoiceLookUp obj = new frmSaleInvoiceLookUp())
                    {
                        if (obj.ShowDialog() == DialogResult.OK)
                        {
                            string id = obj.SaleInvoiceNo;
                            if (id != "")
                            {

                                txtSaleDate.Value = obj.SaleInvoiceDate;
                                CheckInvoiceNoForLink(id);
                                txtLinkedBillNo.Text = id;

                            }
                        }
                    };
                    //MessageBox.Show("Please Enter Invoice Number!");
                }
            }
            else if(e.KeyCode==Keys.Enter)
            {
                if (txtLinkedBillNo.Text != "" || (txtLinkedBillNo.Text == "" ? 0 : Convert.ToInt64(txtLinkedBillNo.Text)) != 0)
                {

                    string InvoiceNo = txtLinkedBillNo.Text;
                    CheckInvoiceNoForLink(InvoiceNo);
                    txtProductCode.Clear();
                    txtProductCode.Focus();
                }
                else
                {
                    txtProductCode.Clear();
                    txtProductCode.Focus();
                }
            }
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            SaleReturn = false;
            
                
            InvoiceUpdate = true;
            CalculateNetTotal();
            GrossAmount_Total();
                

           

            if (validateSave())
            {
                GrossAmount_Total();
                CheckReceivedAmount();
                this.totalBill = txtReceivableAmount.Text;
                this.ReceivedAmount = txtAmountReceive.Text;
                this.ReturnAmount = txtAmountReturn.Text;
                if (!string.IsNullOrEmpty(txtCustName.Text))
                {
                    this.CustomerName = txtCustName.Text;
                }
                if (!string.IsNullOrEmpty(txtCustPhone.Text))
                {
                    this.CustomerPhone = txtCustPhone.Text;
                }
                if (!string.IsNullOrEmpty(txtRiderAmount.Text))
                {
                    this.RiderAmount = txtRiderAmount.Text;
                }

                //frmCustomerDataFoodMama frm = new frmCustomerDataFoodMama(this);
                //frm.ShowDialog();
                //txtCustName.Text = this.CustomerName;
                //txtCustPhone.Text = this.CustomerPhone;
                //txtSalesManID.Text = this.SaleManId;
                //txtRiderAmount.Text = this.RiderAmount;
                SaveForm();


            }


        }

        private void txtPromoDisc_KeyDown(object sender, KeyEventArgs e)
        {
            
                if (e.KeyCode == Keys.Enter)
                {
                    if (txtQuantity.Text != "")
                    {
                        if (Convert.ToDecimal(txtQuantity.Text) > 0)
                        {
                            txtdetailAmount.Focus();
                            CalculateNetAmountDetail();
                            AddProducts(cmbProducts.SelectedText, Convert.ToInt32(txtProductID.Text), Convert.ToDecimal(txtRate.Text), Convert.ToDecimal(txtTax.Text));

                        }
                    }
                }
            
        }

        private void txtQtyPrice_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                try
                {


                    var NetPrice = Convert.ToDecimal(txtQtyPrice.Text == "" ? "0" : txtQtyPrice.Text);
                    var RetailPrice = Convert.ToDecimal(txtRate.Text == "" ? "0" : txtRate.Text);
                    
                    if (NetPrice > 0)
                    {
                        var Quantity = Convert.ToDecimal(NetPrice / RetailPrice);
                        txtQuantity.Text = Quantity.ToString();
                    }
                    if (txtQuantity.Text != "")
                    {
                        if (Convert.ToDecimal(txtQuantity.Text) > 0)
                        {
                            CalculateNetAmountDetail();
                            txtPromoDisc_KeyDown(sender, e);
                            //txtPromoDisc.Focus();
                            //txtPromoDisc.Select();
                        }
                    }
                    else
                    {
                       
                        txtQuantity.Focus();
                        txtQuantity.SelectAll();

                    }

                    //txtPromoDisc.Select();
                    //txtPromoDisc.Focus();

                    //txtQuantity.Focus();
                    //txtQuantity.Select();
                }
                catch (Exception)
                {

                }
            }
        }

        private void txtPromoDisc_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar) && e.KeyChar != '.')
            {

                e.Handled = true;

            }


            if (e.KeyChar == '.' && (sender as TextBox).Text.IndexOf('.') > -1)
            {


                e.Handled = true;
            }
        }

        
    }
}
