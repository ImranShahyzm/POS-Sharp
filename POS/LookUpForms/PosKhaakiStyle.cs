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

namespace POS
{
    public partial class PosKhaakiStyle : MetroForm
    {
        public bool directReturn = false;

        public bool InvoiceCancel = false;
        public int SaleInvoiceNo = 0;
        public int SalePosMasterID = 0;
        public decimal netAmountForReturn = 0;
        public string CustomerName { get; set; }
        public string CustomerPhone { get; set; }

        public string totalBill { get; set; }
        public string ReceivedAmount { get; set; }
        public string ReturnAmount { get; set; }
            public bool SaleReturn = false;
        public bool UpdateInvoice = false;
        public string CardNumber { get; set; }
        public string CardName { get; set; }
        public bool AllowSave { get; set; }
      
        public string SaleManId { get; set; }
        frmmakeOrderNewKhaaki frmMakeOrder =new frmmakeOrderNewKhaaki();
        public PosKhaakiStyle()
        {
            InitializeComponent();
            //SetupDataGridView();
            timer1.Start();
            //laodCategories();
            loadProducts();
            loadSaleMenuGroup();
            lblShopName.Text ="( "+ CompanyInfo.WareHouseName+" )";
            loadNewSale();
            txtProductCode.Select();

            txtProductCode.Focus();

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
            var Stock = STATICClass.GetStockQuantityItem(ItemId, CompanyInfo.WareHouseID,txtSaleDate.Value, CompanyInfo.CompanyID, "", "", false);
            txtAvailableQty.Text = Convert.ToString(Stock);
        }
        private void GetRunningPromo(int ItemId)
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " Select * from vw_khaakiPromo";
            //string whereClause = " where BookingStartDate<='"+txtSaleDate.Value+ "' and BookingEndDate>='"+txtSaleDate.Value+"' and WHID="+CompanyInfo.WareHouseID+" and ItemId="+ItemId+"" ;
            DateTime StartDate = Convert.ToDateTime(txtSaleDate.Value);
            DateTime EndDate = StartDate;
            string whereClause = " where ((vw_khaakiPromo.BookingStartDate between '" + Convert.ToDateTime(StartDate) + "' and '" + Convert.ToDateTime(EndDate) + "') OR " +
                " (vw_khaakiPromo.BookingEndDate between '" + Convert.ToDateTime(StartDate) + "' and '" + Convert.ToDateTime(EndDate) + "') OR (BookingStartDate<='" + Convert.ToDateTime(StartDate) + "' and BookingEndDate >='" + Convert.ToDateTime(EndDate) + "')) and vw_khaakiPromo.WHID=" + Convert.ToInt32(CompanyInfo.WareHouseID) + " and ItemId=" + ItemId + "";
            SqlDataAdapter sda = new SqlDataAdapter(SqlString+whereClause, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    int SchemeID = Convert.ToInt32(dt.Rows[i]["SchemeID"]);
                    string SchemeTitle = Convert.ToString(dt.Rows[i]["PromoName"]);
                    lblRunningPromo.Text = SchemeTitle + "at min "+ Convert.ToString(Convert.ToInt32(dt.Rows[i]["Qauntity"]))+ " Quantity" ;
                    txtPromoDisc.Text = Convert.ToString(dt.Rows[i]["AdditionPercentage"]);
                    txtMinQty.Text = Convert.ToString(dt.Rows[i]["Qauntity"]);
                    txtSchemeID.Text = SchemeID.ToString();

                }
            }
            else
            {
                whereClause = " where ((vw_khaakiPromoonAll.BookingStartDate between '" + Convert.ToDateTime(StartDate) + "' and '" + Convert.ToDateTime(EndDate) + "') OR " +
                " (vw_khaakiPromoonAll.BookingEndDate between '" + Convert.ToDateTime(StartDate) + "' and '" + Convert.ToDateTime(EndDate) + "') OR (BookingStartDate<='" + Convert.ToDateTime(StartDate) + "' and BookingEndDate >='" + Convert.ToDateTime(EndDate) + "')) and vw_khaakiPromoonAll.WHID=" + Convert.ToInt32(CompanyInfo.WareHouseID) + "";
                cnn.Open();
                 sda = new SqlDataAdapter("Select * from  vw_khaakiPromoonAll " + whereClause, cnn);
                dt = new DataTable();
                sda.Fill(dt);
                cnn.Close();
                
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        int SchemeID = Convert.ToInt32(dt.Rows[i]["SchemeID"]);
                        string SchemeTitle = Convert.ToString(dt.Rows[i]["PromoName"]);
                        lblRunningPromo.Text = SchemeTitle + "at min " + Convert.ToString(Convert.ToInt32(dt.Rows[i]["Qauntity"])) + " Quantity";
                        txtPromoDisc.Text = Convert.ToString(dt.Rows[i]["AdditionPercentage"]);
                        txtMinQty.Text = Convert.ToString(dt.Rows[i]["Qauntity"]);
                        txtSchemeID.Text = SchemeID.ToString();

                    }
                }
                else
                {
                    txtPromoDisc.Text = "0";
                    txtMinQty.Text = "0";
                    txtSchemeID.Text = "";
                    txtPromoDiscAmt.Text = "0";
                }
            }
             

            
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
        private void PosKhaakiStyle_Load(object sender, EventArgs e)
        {
          
            //SetupDataGridView();
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
                var isCheck = Convert.ToString(ItemSaleGrid.Rows[i].Cells[14].Value);
                if (isCheck == "True")
                {
                    TotalExchanged += Convert.ToDecimal(Convert.ToString(ItemSaleGrid.Rows[i].Cells[10].Value));
                }
                    sum += Convert.ToDecimal(Convert.ToString(ItemSaleGrid.Rows[i].Cells[5].Value));
                taxAmountTotal += Convert.ToString(ItemSaleGrid.Rows[i].Cells[7].Value) == "" ? 0 : Convert.ToDecimal(ItemSaleGrid.Rows[i].Cells[7].Value); 
                TotalDiscount += Convert.ToString(ItemSaleGrid.Rows[i].Cells[9].Value) == "" ? 0 : Convert.ToDecimal(ItemSaleGrid.Rows[i].Cells[9].Value);
            }
            txtGrossAmount.Text = Convert.ToString(Math.Ceiling(sum+(-1 * TotalExchanged)));
            txtTotalTax.Text = Convert.ToString(Math.Ceiling(taxAmountTotal));
            decimal discAmount = txtDiscountAmount.Text == "" ? 0 : Convert.ToDecimal(txtDiscountAmount.Text);
            txtTotalDiscount.Text = Convert.ToString(Math.Ceiling(TotalDiscount+discAmount));
            txtExchangeAmt.Text = Convert.ToString(Math.Ceiling((-1)*TotalExchanged));
            CalculateNetTotal();
            cashCardPayments();

        }

        private void CalculateNetTotal()
        {
            try
            {
                decimal grossAmount = txtGrossAmount.Text == "" ? 0 : Convert.ToDecimal(txtGrossAmount.Text);
                decimal totalTaxAmount = txtTotalTax.Text == "" ? 0 : Convert.ToDecimal(txtTotalTax.Text);
                decimal ExchangeAmount = txtExchangeAmt.Text == "" ? 0 : Convert.ToDecimal(txtExchangeAmt.Text);
                decimal discAmount = txtDiscountAmount.Text == "" ? 0 : Convert.ToDecimal(txtDiscountAmount.Text);
                //  decimal discPercentage = txtDiscountPercentage.Text == "" ? 0 : Convert.ToDecimal(txtDiscountPercentage.Text);
                decimal otherCharges = txtOtherCharges.Text == "" ? 0 : Convert.ToDecimal(txtOtherCharges.Text);
                // decimal totalDiscount = ((discPercentage * grossAmount) / 100) + discAmount;
                decimal totalDiscount = txtTotalDiscount.Text == "" ? 0 : Convert.ToDecimal(txtTotalDiscount.Text);
                decimal netAmount = grossAmount - totalDiscount + totalTaxAmount + otherCharges - (ExchangeAmount);

                txtNetAmount.Text = Math.Ceiling(netAmount).ToString();
                if (SaleInvoiceNo == 0)
                {
                    if (directReturn == true)
                    {
                        txtPayableAmount.Text = netAmount.ToString();
                    }
                    else
                    {
                        txtReceivableAmount.Text = Math.Ceiling(netAmount).ToString();
                    }

                }
                else
                {
                    decimal recAmount = txtAmountReceive.Text == "" ? 0 : Convert.ToDecimal(txtAmountReceive.Text);
                    decimal accAmount = txtAccAmount.Text == "" ? 0 : Convert.ToDecimal(txtAccAmount.Text);
                    if (UpdateInvoice == false)
                    {
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
                            txtReceivableAmount.Text = Math.Ceiling((netAmount - accAmount)).ToString();
                        }
                    }
                    else

                    {
                        txtReceivableAmount.Text = Math.Ceiling(netAmount).ToString();
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
            } catch(Exception e)
            {
                MessageBox.Show(e.Message);
            }
        }

     
        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }
        private void CalculateDetail()
        {
            for (int i = 0; i < ItemSaleGrid.Rows.Count; i++)
            {
                var isCheck = Convert.ToString(ItemSaleGrid.Rows[i].Cells[14].Value);

                var strQuantity =Convert.ToString(ItemSaleGrid.Rows[i].Cells[4].Value);
                if (string.IsNullOrEmpty(strQuantity) || strQuantity=="0")
                {
                    ItemSaleGrid.Rows[i].Cells[4].Value="1";
                }

                int id = Convert.ToInt32( ItemSaleGrid.Rows[i].Cells[0].Value.ToString());
                DataTable dt = getProduct(0, Convert.ToInt32(id));
                var taxPercentage = Convert.ToDecimal(dt.Rows[0]["TotalTax"]);
                string rateValue = ItemSaleGrid.Rows[i].Cells[3].Value.ToString();
                string total = (Convert.ToDecimal(rateValue) * 1).ToString();
                //********** Promo Working Starts From here ***********//

                var SchemeDiscount = Convert.ToDecimal(ItemSaleGrid.Rows[i].Cells[8].Value.ToString());
                var MinSchemQuantity = Convert.ToDecimal(ItemSaleGrid.Rows[i].Cells[12].Value.ToString());
                var OrderQuantity= Convert.ToDecimal(ItemSaleGrid.Rows[i].Cells[4].Value.ToString());
                var defualtQty = 1;
                if (Convert.ToBoolean(isCheck))
                {
                    defualtQty = defualtQty * -1;
                }
                var GrossAmount = OrderQuantity * Convert.ToDecimal(rateValue);
                if (OrderQuantity* defualtQty >= MinSchemQuantity)
                {
                    var DiscontAmountOnRate = (Convert.ToDecimal(rateValue) / 100) * SchemeDiscount;
                    var DiscountedRate = Convert.ToDecimal(rateValue) - DiscontAmountOnRate;
                    var NetAmount = Convert.ToDecimal(OrderQuantity) * Convert.ToDecimal(DiscountedRate);
                    var txtPromoDiscAmt = Convert.ToDecimal(Convert.ToDecimal(OrderQuantity) * Convert.ToDecimal(DiscontAmountOnRate));
                    ItemSaleGrid.Rows[i].Cells[9].Value = Math.Round(txtPromoDiscAmt, 2);
                    ItemSaleGrid.Rows[i].Cells[10].Value = Math.Round(NetAmount, 2);
                }
                else
                {
                    string taxAmount = (((Convert.ToDecimal(taxPercentage) * Convert.ToDecimal(rateValue)) / 100) * 1).ToString();
                    string value = ItemSaleGrid.Rows[i].Cells[4].Value.ToString();
                    decimal rate = Convert.ToDecimal(rateValue);
                    decimal qty = Convert.ToDecimal(value);
                    ItemSaleGrid.Rows[i].Cells[9].Value = 0;
                    ItemSaleGrid.Rows[i].Cells[10].Value = Math.Round((qty) * rate, 2);
                    ItemSaleGrid.Rows[i].Cells[7].Value = ((Convert.ToDecimal(taxPercentage) * rate) / 100) * (qty);
                }
                ItemSaleGrid.Rows[i].Cells[5].Value = Math.Round((GrossAmount), 2);
                //************ Promo Working Ends Here ************//

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
        private void txtDiscountAmount_KeyPress(object sender, KeyPressEventArgs e)
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
            string SqlString = @" Select * from inventcategory where ItemGroupID="+ItemGroupID+" ";
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
            if (!chkExchange.Checked)
            {
                for (int i = 0; i < ItemSaleGrid.Rows.Count; i++)
                {
                    if (id == Convert.ToInt32(ItemSaleGrid.Rows[i].Cells[0].Value.ToString()) && Convert.ToBoolean(ItemSaleGrid.Rows[i].Cells[14].Value.ToString())==false)
                    {

                        string value = ItemSaleGrid.Rows[i].Cells[4].Value.ToString();

                        string rateValue = ItemSaleGrid.Rows[i].Cells[3].Value.ToString();
                        decimal rate = Convert.ToDecimal(rateValue);
                        decimal qty = Convert.ToDecimal(value);
                        decimal taxPerctge = Convert.ToDecimal(ItemSaleGrid.Rows[i].Cells[6].Value);
                        qty = qty + Convert.ToDecimal(txtQuantity.Text);

                        ItemSaleGrid.Rows[i].Cells[4].Value = qty;
                        ItemSaleGrid.Rows[i].Cells[5].Value = (qty) * rate;
                        ItemSaleGrid.Rows[i].Cells[7].Value = ((Convert.ToDecimal(taxPerctge) * rate) / 100) * qty;

                        recordExist = true;
                        GrossAmount_Total();
                        ClearFields();
                        txtProductCode.Focus();
                        return;
                    }
                }
            }
            if (!recordExist)
            {

                if (txtQuantity.Text == "" || txtRate.Text == "" || txtProductID.Text == "")
                {
                    MessageBox.Show("Please Fill All the Fields...");
                    return;
                }
                
                decimal Value = Convert.ToDecimal(txtQuantity.Text);
                if (chkExchange.Checked)
                {
                    Value = Value* -1;
                    txtQuantity.Text = Convert.ToString(Value);
                }
                var Rate = txtRate.Text;
                var NetAmount = Convert.ToDecimal(Value) * Convert.ToDecimal(Rate);

                //string[] row = { id.ToString(), cmbProducts.Text, txtQuantity.Text, txtStockRate.Text, NetAmount.ToString(), txtProductID.Text };
                //dgvStockInDetail.Rows.Insert(0, row);
                //ClearFields();
                txtProductID.Focus();

                string[] row = { id.ToString(),Convert.ToString(txtProductCode.Text), cmbProducts.Text, txtRate.Text.ToString(), txtQuantity.Text.ToString(),  txtDtGross.Text.ToString(),  txtTax.Text.ToString(),txtTaxAmount.Text.ToString(), txtPromoDisc.Text.ToString(),txtPromoDiscAmt.Text.ToString(),txtdetailAmount.Text.ToString(), txtAvailableQty.Text.ToString(),txtMinQty.Text.ToString(),Convert.ToString(txtSchemeID.Text), Convert.ToString(chkExchange.Checked) };
                ItemSaleGrid.Rows.Insert(0,row);
            }
            CalculateDetail();
            GrossAmount_Total();
            ClearFields();
            txtProductCode.Focus();
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
                        using (frmProductLookUp obj = new frmProductLookUp(Convert.ToInt32(cmbSalemenu.SelectedValue.ToString())))
                        {
                            if (obj.ShowDialog() == DialogResult.OK)
                            {
                                int id = obj.ProductID;
                                txtProductID.Text = id.ToString();
                                txtProductCode.Text = obj.ManualNumber;
                                cmbProducts.SelectedValue = id.ToString();
                               var dtReturn= getProduct(0, Convert.ToInt32(id));
                                setAvailableStock(id);
                                GetRunningPromo(id);
                                txtRate.Text = Convert.ToString(dtReturn.Rows[0]["ItemSalesPrice"]);
                                txtTax.Text = Convert.ToString(dtReturn.Rows[0]["TotalTax"]);
                                //txtQuantity.
                                txtQuantity.Text = "1";
                                txtQuantity_KeyDown(sender, e);
                            }
                        };
                    }
                    else
                    {
                        cmbProducts.SelectedValue = dt.Rows[0]["ItemId"].ToString();
                        
                        txtRate.Text = Convert.ToString(dt.Rows[0]["ItemSalesPrice"]);
                        txtTax.Text = Convert.ToString(dt.Rows[0]["TotalTax"]);
                        txtProductID.Text = Convert.ToString(dt.Rows[0]["ItemId"]);
                        setAvailableStock(Convert.ToInt32(dt.Rows[0]["ItemId"]));
                        GetRunningPromo(Convert.ToInt32(dt.Rows[0]["ItemId"]));
                        txtQuantity.Text="1";
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
            if(e.KeyData==Keys.Space)
            {
                ItemSaleGrid.Focus();
            }
            if(e.KeyCode==Keys.Escape)
            {
                txtDiscountAmount.Focus();
                //txtDiscountPercentage.Focus();
            }
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            btnSave.Enabled = false;
            if (validateSave())
            {
                GrossAmount_Total();
                CheckReceivedAmount();
                this.totalBill = txtReceivableAmount.Text;
                this.ReceivedAmount = txtAmountReceive.Text;
                this.ReturnAmount = txtAmountReturn.Text;

                frmCustomerData frm = new frmCustomerData(this);
                frm.ShowDialog();
                txtCustName.Text = this.CustomerName;
                txtCustPhone.Text = this.CustomerPhone;
                txtSalesManID.Text = this.SaleManId;
                if (Convert.ToInt32(txtSalesManID.Text) == 0)
                {

                    MessageBox.Show("Please Select Sales Person....!!!");
                    return;
                }
                else
                {
                    SaveForm();
                }
                
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
                DataRow dRow = dt1.NewRow();
                i = i + 1;
                var TQty = Convert.ToDecimal(row.Cells[4].Value.ToString());//+(Convert.ToDecimal(row.Cells[4].Value.ToString()) * Convert.ToDecimal(row.Cells[13].Value.ToString()));
                
                dRow[0] = i;
                dRow[1] = row.Cells[0].Value.ToString();
                dRow[2] = TQty.ToString();
                dRow[3] = row.Cells[3].Value.ToString();
                dRow[4] = row.Cells[6].Value.ToString();
                dRow[5] = row.Cells[7].Value.ToString();
                dRow[6] = row.Cells[8].Value.ToString(); 
                dRow[7] = row.Cells[9].Value.ToString();
                dRow[8] = row.Cells[10].Value.ToString();
                dRow[9] = 0;//row.Cells[13].Value.ToString();
                dRow[10] =0;// row.Cells[4].Value.ToString();
                dRow[11] = TQty;// row.Cells[7].Value.ToString();
                dRow[12] = 0; //Convert.ToString(row.Cells[14].Value);
                
                dRow[13] = Convert.ToString(row.Cells[13].Value);
                dRow[14] = Convert.ToString(row.Cells[12].Value);
                dRow[15] = Convert.ToBoolean(row.Cells[14].Value);
                dt1.Rows.Add(dRow);
            }
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            SqlTransaction tran;
            con.Open();
            tran = con.BeginTransaction();
            SqlCommand cmd;
            if (UpdateInvoice == false)
            {
                cmd = new SqlCommand("data_SalePosInfo_Insert", con);
            }
            else if(InvoiceCancel == false)
            {
                cmd = new SqlCommand("data_SalePosInfo_update", con);
                SalePosMasterID = Convert.ToInt32(SalePosID.Text);
            }
            else
            {
                cmd = new SqlCommand("data_SalePosInfo_Cancel", con);
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
            cmd.Parameters.AddWithValue("@NetAmount", Convert.ToDecimal(txtNetAmount.Text));
            cmd.Parameters.AddWithValue("@SalePosDate", Convert.ToDateTime(txtSaleDate.Value.Date));
            
            cmd.Parameters.AddWithValue("@AmountReceive", txtAmountReceive.Text == "" ? 0 : Convert.ToDecimal(txtAmountReceive.Text));
            cmd.Parameters.AddWithValue("@AmountReturn", txtAmountReturn.Text == "" ? 0 : Convert.ToDecimal(txtAmountReturn.Text));
            cmd.Parameters.AddWithValue("@AmountInAccount", txtAccAmount.Text == "" ? 0 : Convert.ToDecimal(txtAccAmount.Text));
            cmd.Parameters.AddWithValue("@ExchangeAmount", txtExchangeAmt.Text == "" ? 0 : Convert.ToDecimal(txtExchangeAmt.Text));
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
            cmd.Parameters.AddWithValue("@CardNumber", txtCardNumber.Text == "" ? null : Convert.ToString(txtCardNumber.Text));
            cmd.Parameters.AddWithValue("@CardName", txtCardName.Text == "" ? null : Convert.ToString(txtCardName.Text));
            cmd.Parameters.AddWithValue("@CashPayment", txtCashAmount.Text == "" ? null : Convert.ToString(txtCashAmount.Text));
            cmd.Parameters.AddWithValue("@CardPayment", txtCardAmount.Text == "" ? null : Convert.ToString(txtCardAmount.Text));
            cmd.Parameters.AddWithValue("@SaleManId", txtSalesManID.Text == "" ? null : Convert.ToString(txtSalesManID.Text));
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
                frmMakeOrder.SalePosID = Convert.ToInt32(p.Value);
               
                var value = new List<string[]>();
                string[] ss = { "@SaleInvoice", SaleInvoiceNO };
                value.Add(ss);
                frmCrystal obj = new frmCrystal();
                string reportName = "";
                if (directReturn == false && InvoiceCancel==false)
                {
                    reportName = "SaleInvoice";

                    obj.loadKhaakiInvoice("rpt_sale_invoice", reportName, value);
                }
                InvoiceCancel = false;
                btnCancelInvoice.Visible = false;
                if (frmMakeOrder.AllowSave == true && InvoiceCancel == false)
                {
                    frmMakeOrder.Saleview = MakeOrderDetailDataTable();
                    frmMakeOrder.SaveForm();
                }
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

                btnSave.Enabled = true;
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

                    btnSave.Enabled = true;
                    validateReturnOK = false;
                }
                else if (amountReturn < 0)
                {
                    txtAmountReceive.Focus();
                    MessageBox.Show("Receiable Amount is not fully paid!");

                    btnSave.Enabled = true;
                    validateReturnOK = false;
                }
                else if (lblSaleType.Text == "Sale Return" && SaleInvoiceNo == 0)
                {
                    MessageBox.Show("There is no Invoice No."+ Environment.NewLine +" For New Sale Please Click New Sale button OR Press ( ALT+N ) !");

                    btnSave.Enabled = true;
                    validateReturnOK = false;
                }
            }
            else
            {
                validateReturnOK = false;

                btnSave.Enabled = true;
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
                    using (frmSaleInvoiceLookUp obj = new frmSaleInvoiceLookUp())
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
            SalePosID.Clear();
            SalePosID.Text="";
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
            txtCardAmount.Clear();
            txtCardNumber.Clear();
            this.CardName = "";
            this.CardNumber = "";
            txtCashAmount.Clear();
            txtCardAmount.Clear();
            this.AllowSave = false;
            this.CustomerName = "";
            this.CustomerPhone = "";
            this.totalBill = "0";
            this.ReceivedAmount = "0";
            this.ReturnAmount = "0";
            btnCancelInvoice.Visible = false;
            btnCancelInvoice.Text = "Cancel Invoice";
            InvoiceCancel = false;
            SalePosMasterID = 0;

        }

        private void loadNewSale()
        {
            lblSaleType.Text = "New Sale";
            txtInvoiceNo.ReadOnly = true;
            SaleInvoiceNo = 0;
            getInvoiceNumber();
            txtCustPhone.Select();
            txtProductCode.Focus();
            SaleReturn = false;
            UpdateInvoice = false;
            InvoiceCancel = false;
            btnSave.Visible = true;

            btnSave.Enabled = true;
            //txtAmountReceive.ReadOnly = false;
            frmMakeOrder.clearAll();
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

            if(btnMakeOrder.Focused && keyData ==Keys.Tab)
            {
                btnSave.Select();
                btnSave.Focus();
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

        private bool IsOKForDecimalTextBox(char theCharacter, TextBox theTextBox)
        {
            // Only allow control characters, digits, plus and minus signs.
            // Only allow ONE plus sign.
            // Only allow ONE minus sign.
            // Only allow the plus or minus sign as the FIRST character.
            // Only allow ONE decimal point.
            // Do NOT allow decimal point or digits BEFORE any plus or minus sign.

            if (
                !char.IsControl(theCharacter)
                && !char.IsDigit(theCharacter)
                && (theCharacter != '.')
                && (theCharacter != '-')
                && (theCharacter != '+')
            )
            {
                // Then it is NOT a character we want allowed in the text box.
                return false;
            }



            // Only allow one decimal point.
            if (theCharacter == '.'
                && theTextBox.Text.IndexOf('.') > -1)
            {
                // Then there is already a decimal point in the text box.
                return false;
            }

            // Only allow one minus sign.
            if (theCharacter == '-'
                && theTextBox.Text.IndexOf('-') > -1)
            {
                // Then there is already a minus sign in the text box.
                return false;
            }

            // Only allow one plus sign.
            if (theCharacter == '+'
                && theTextBox.Text.IndexOf('+') > -1)
            {
                // Then there is already a plus sign in the text box.
                return false;
            }

            // Only allow one plus sign OR minus sign, but not both.
            if (
                (
                    (theCharacter == '-')
                    || (theCharacter == '+')
                )
                &&
                (
                    (theTextBox.Text.IndexOf('-') > -1)
                    ||
                    (theTextBox.Text.IndexOf('+') > -1)
                )
                )
            {
                // Then the user is trying to enter a plus or minus sign and
                // there is ALREADY a plus or minus sign in the text box.
                return false;
            }

            // Only allow a minus or plus sign at the first character position.
            if (
                (
                    (theCharacter == '-')
                    || (theCharacter == '+')
                )
                && theTextBox.SelectionStart != 0
                )
            {
                // Then the user is trying to enter a minus or plus sign at some position 
                // OTHER than the first character position in the text box.
                return false;
            }

            // Only allow digits and decimal point AFTER any existing plus or minus sign
            if (
                    (
                        // Is digit or decimal point
                        char.IsDigit(theCharacter)
                        ||
                        (theCharacter == '.')
                    )
                    &&
                    (
                        // A plus or minus sign EXISTS
                        (theTextBox.Text.IndexOf('-') > -1)
                        ||
                        (theTextBox.Text.IndexOf('+') > -1)
                    )
                    &&
                        // Attempting to put the character at the beginning of the field.
                        theTextBox.SelectionStart == 0
                )
            {
                // Then the user is trying to enter a digit or decimal point in front of a minus or plus sign.
                return false;
            }

            // Otherwise the character is perfectly fine for a decimal value and the character
            // may indeed be placed at the current insertion position.
            return true;
        }
        private void ItemSaleGrid_EditingControlShowing(object sender, DataGridViewEditingControlShowingEventArgs e)
        {
            e.Control.KeyPress -= new KeyPressEventHandler(Column1_KeyPress);
            TextBox ttxb = e.Control as TextBox;
           
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
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar))
            {
                e.Handled = true;
            }

            // only allow one decimal point
            //if (e.KeyChar == '.'
            //    && (sender as TextBox).Text.IndexOf('.') > -1)
            //{
            //    e.Handled = true;
            //}
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
            lblSaleType.Text = "Sale Reprint";
            txtInvoiceNo.ReadOnly = false;
            txtInvoiceNo.Text = "";
            txtInvoiceNo.Focus();
            UpdateInvoice = true;

        }
        private void loadDirectReturn()
        {
            clearAll();
            lblSaleType.Text = "Direct Return";
            directReturn = true;
        }

        private void btnNewSale_Click(object sender, EventArgs e)
        {
            clearAll();
            loadNewSale();
            //return true;
            //using (frmSaleInvoiceLookUp obj = new frmSaleInvoiceLookUp())
            //{
            //    if (obj.ShowDialog() == DialogResult.OK)
            //    {
            //        string id = obj.SaleInvoiceNo;
            //        if (id!="")
            //        {
            //            clearAll();
            //            loadWholeInvoice(id);
            //            txtInvoiceNo.Text = id;
            //        }
            //    }
            //};
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
                SaleReturn = false;
                var isCancelled=Convert.ToBoolean(dt.Rows[0]["DirectReturn"]);
                if(isCancelled==true)
                {
                    btnCancelInvoice.Text = "Cancelled";
                    btnCancelInvoice.Enabled = false;
                }
                else
                {
                    btnCancelInvoice.Enabled = true;
                }
                btnCancelInvoice.Visible = true;
                txtSalesManID.Text= Convert.ToString(dt.Rows[0]["SaleManID"]);

                txtCashAmount.Text = Convert.ToString(dt.Rows[0]["CashPayment"]);

                txtCardAmount.Text = Convert.ToString(dt.Rows[0]["CardPayment"]);

                txtExchangeAmt.Text = Convert.ToString(dt.Rows[0]["ExchangeAmount"]);
                this.SaleManId=Convert.ToString(dt.Rows[0]["SaleManID"]);
                for (int i = 0; i < dtdetail.Rows.Count; i++)
                {
                    string[] row = {
                            Convert.ToString(dtdetail.Rows[i]["ItemId"]),
                         Convert.ToString(dtdetail.Rows[i]["ItemNumber"]),
                        Convert.ToString(dtdetail.Rows[i]["ItenName"]),
                            Convert.ToString(dtdetail.Rows[i]["ItemRate"]),
                            Convert.ToString(dtdetail.Rows[i]["TotalQuantity"]),
                            Convert.ToString(Convert.ToDecimal(dtdetail.Rows[i]["ItemRate"])*Convert.ToDecimal(dtdetail.Rows[i]["TotalQuantity"])),
                            Convert.ToString(dtdetail.Rows[i]["TaxPercentage"]),
                            Convert.ToString(dtdetail.Rows[i]["TaxAmount"]),
                            Convert.ToString(dtdetail.Rows[i]["DiscountPercentage"]),
                            Convert.ToString(dtdetail.Rows[i]["DiscountAmount"]),
                            Convert.ToString(dtdetail.Rows[i]["TotalAmount"]),
                            "0",
                            Convert.ToString(Convert.ToInt32(dtdetail.Rows[i]["MinQuantity"])),
                            Convert.ToString(dtdetail.Rows[i]["SchemeID"]),
                            Convert.ToString(dtdetail.Rows[i]["isExchange"]),
                    };
                    ItemSaleGrid.Rows.Add(row);
                    CalculateDetail();
                    
                }
                txtProductCode.Select();
                txtProductCode.Focus();
                txtInvoiceNo.ReadOnly = true;
                frmMakeOrder.LoadSavedOrderFromInvoice(SalePosID.Text);
                btnSave.Visible = true;

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
                GetCustomerName(txtCustPhone.Text);
                txtCustName.Focus();
                
            }
        }
        private void GetCustomerName (string PhoneNo)
        {
            if(!string.IsNullOrEmpty(PhoneNo))
            {
                var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
                SqlConnection cnn;
                cnn = new SqlConnection(connectionString);
                cnn.Open();
                string SqlString = " Select Top 1 CustomerName from data_SalePosInfo Where WHID="+CompanyInfo.WareHouseID+" and CustomerPhone like '%"+PhoneNo+"%'";

                SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                cnn.Close();
                if (dt.Rows.Count > 0)
                {
                    txtCustName.Text = Convert.ToString(dt.Rows[0][0]);
                }
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
            txtSchemeID.Clear();
            txtPromoDisc.Clear();
            txtPromoDiscAmt.Clear();
            txtMinQty.Clear();
            lblRunningPromo.Text = "";
            txtTax.ReadOnly = true;
            txtTaxAmount.ReadOnly = true;
            txtdetailAmount.ReadOnly = true;
            txtRate.ReadOnly = true;
            cmbProducts.SelectedIndex = 0;
            txtDtGross.Clear();
            txtAvailableQty.Clear();
        }

        private void ItemSaleGrid_KeyDown(object sender, KeyEventArgs e)
        {
            
            if(e.KeyCode==Keys.Delete)
            {
                if (MessageBox.Show("Are You Sure You Want to Delete the Selected Record...?", "Confirmation...!!", MessageBoxButtons.YesNo) == DialogResult.Yes)
                {
                    ItemSaleGrid.Rows.RemoveAt(ItemSaleGrid.CurrentRow.Index);
                    txtProductCode.Select();
                    txtProductCode.Focus();
                    CalculateDetail();
                    return;
                }


            }
            if(e.KeyCode==Keys.Space)
            {
                //txtDiscountPercentage.Focus();
                txtDiscountAmount.Focus();
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
            string[] ss = { "@SaleInvoice", SaleInvoiceNO };
            value.Add(ss);
            frmCrystal obj = new frmCrystal();
            string reportName = "";
            if (directReturn == false)
            {
                reportName = "SaleInvoice";
                //obj.loadReport("rpt_sale_invoice", reportName, value);
                obj.loadKhaakiInvoice("rpt_sale_invoice", reportName, value);
                //obj.loadSaleKitchenReport("rpt_sale_invoiceKitchen", reportName, value);
            }
            btnNewSale_Click(sender,e);
           
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

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtQuantity_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar))
            {

                e.Handled = true;

            }


            //if (e.KeyChar == '.' && (sender as TextBox).Text.IndexOf('.') > -1)
            //{


            //    e.Handled = true;
            //}
            CalculateNetAmountDetail();
        }
        private void CalculateNetAmountDetail()
        {
            if (txtQuantity.Text != "" && txtRate.Text != "")
            {
                var OrderQuantity = Convert.ToDecimal(txtQuantity.Text);
                decimal MinSchemQuantity=0;
                if (!string.IsNullOrEmpty(txtMinQty.Text))
                {
                    MinSchemQuantity = Convert.ToDecimal(txtMinQty.Text);
                }
                txtDtGross.Text = Convert.ToString(OrderQuantity * Convert.ToDecimal(txtRate.Text));

                if (!string.IsNullOrEmpty(txtSchemeID.Text))
                {
                    var SchemeDiscount = Convert.ToDecimal(txtPromoDisc.Text);
                    if (OrderQuantity >= MinSchemQuantity)
                    {
                        var DiscontAmountOnRate = (Convert.ToDecimal(txtRate.Text) / 100) * SchemeDiscount;
                        var DiscountedRate = Convert.ToDecimal(txtRate.Text) - DiscontAmountOnRate;
                        var NetAmount = Convert.ToDecimal(txtQuantity.Text) * Convert.ToDecimal(DiscountedRate);
                        var Taxpercent = Convert.ToDecimal(txtTax.Text);
                        var AmountTax = Convert.ToDecimal(txtQuantity.Text) * ((Taxpercent * Convert.ToDecimal(txtRate.Text)) / 100);
                        txtPromoDiscAmt.Text= Convert.ToString(Convert.ToDecimal(txtQuantity.Text) * Convert.ToDecimal(DiscontAmountOnRate));
                        txtTaxAmount.Text = AmountTax.ToString();

                        txtdetailAmount.Text = Convert.ToString(Math.Round(NetAmount + AmountTax, 2));
                    }
                    else
                    {
                        var NetAmount = Convert.ToDecimal(txtQuantity.Text) * Convert.ToDecimal(txtRate.Text);
                        var Taxpercent = Convert.ToDecimal(txtTax.Text);
                        var AmountTax = Convert.ToDecimal(txtQuantity.Text) * ((Taxpercent * Convert.ToDecimal(txtRate.Text)) / 100);
                        txtTaxAmount.Text = AmountTax.ToString();
                        txtdetailAmount.Text = Convert.ToString(Math.Round(NetAmount + AmountTax, 2));
                    }

                }
                else
                {

                    var NetAmount = Convert.ToDecimal(txtQuantity.Text) * Convert.ToDecimal(txtRate.Text);
                    var Taxpercent = Convert.ToDecimal(txtTax.Text);
                    var AmountTax = Convert.ToDecimal(txtQuantity.Text) * ((Taxpercent * Convert.ToDecimal(txtRate.Text)) / 100);
                    txtTaxAmount.Text = AmountTax.ToString();
                    txtdetailAmount.Text = Convert.ToString(Math.Round(NetAmount + AmountTax,2));
                }
            }
            else
            {
                txtNetAmount.Text = "";
            }
        }

        private void txtQuantity_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                if (txtQuantity.Text != "")
                {
                    if (Convert.ToDecimal(txtQuantity.Text) > 0)
                    {
                        txtdetailAmount.Focus();
                        if (string.IsNullOrEmpty(txtRate.Text) || txtRate.Text == "")
                        {
                            MessageBox.Show("Sale Rate of this Item Is Not Defined By Admin... So You can't Sale this Article..");
                            return;

                        }
                        else

                        {
                            CalculateNetAmountDetail();
                            AddProducts(cmbProducts.SelectedText, Convert.ToInt32(txtProductID.Text), Convert.ToDecimal(txtRate.Text), Convert.ToDecimal(txtTax.Text));
                        }
                    }
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
        private void CheckReceivedAmount()
        {

            decimal payableAmount = txtReceivableAmount.Text == "" ? 0 : Convert.ToDecimal(txtReceivableAmount.Text);
            decimal returnAmount = txtAmountReturn.Text == "" ? 0 : Convert.ToDecimal(txtAmountReturn.Text);
           
            decimal recAmount = txtAmountReceive.Text == "" ? 0 : Convert.ToDecimal(txtAmountReceive.Text);
            txtAmountReturn.Text = (recAmount - payableAmount).ToString();
            //}
            if (string.IsNullOrEmpty(txtAmountReceive.Text) || Math.Round(Convert.ToDecimal(txtAmountReceive.Text)) < Convert.ToDecimal(txtReceivableAmount.Text))
            {
                MessageBox.Show("Received Amount Can't be Less then Bill Amount...");
                return;
            }

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
                decimal recAmount = txtAmountReceive.Text == "" ? 0 : Convert.ToDecimal(txtAmountReceive.Text);
                txtAmountReturn.Text = (recAmount - payableAmount).ToString();
                //}
                try
                {
                    if (string.IsNullOrEmpty(txtAmountReceive.Text) || Convert.ToDecimal(txtAmountReceive.Text) < Convert.ToDecimal(txtReceivableAmount.Text))
                    {
                        MessageBox.Show("Received Amount Can't be Less then Bill Amount...");
                        return;
                    }
                    else
                    {
                        btnMakeOrder.Focus();
                    }
                }catch(Exception ex)
                {
                    MessageBox.Show(ex.Message);
                    return;
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
                GrossAmount_Total();
                txtOtherCharges.Focus();
            }

        }

        private void txtOtherCharges_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {

                GrossAmount_Total();
                
                 txtCashAmount.Focus();
                
                
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

                txtProductCode.Select();
                txtProductCode.Focus();
                //cmbSalemenu.Select();
                //cmbSalemenu.Focus();
            }
        }

        private void cmbSalemenu_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                txtProductCode.Select();
                txtProductCode.Focus();
            }
        }

        private void txtdetailAmount_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtAccAmount_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtProductBarCode_TextChanged(object sender, EventArgs e)
        {

        }

        private void panel1_Paint_1(object sender, PaintEventArgs e)
        {

        }

        private void label5_Click_1(object sender, EventArgs e)
        {

        }

        private void txtReceivableAmount_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtAmountReceive_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtPayableAmount_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtCardAmount_KeyDown(object sender, KeyEventArgs e)
        {
            
                if (e.KeyCode == Keys.Enter)
                {

                    if (txtCardAmount.Text != "")
                    {
                        cashCardPayments();
                        frmCreditCardDetails frm = new frmCreditCardDetails(this);
            
                        frm.ShowDialog();
                        txtCardNumber.Text = this.CardNumber;
                        txtCardName.Text = this.CardName;
                        txtAmountReceive_KeyDown(sender, e);


                }
                    else
                    {

                    txtAmountReceive_KeyDown(sender, e);
                    }

                }
            
        }

        private void txtCashAmount_KeyPress(object sender, KeyPressEventArgs e)
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
        private void cashCardPayments()
        {
            decimal CashAmount = txtCashAmount.Text == "" ? 0 : Convert.ToDecimal(txtCashAmount.Text);
            decimal CardAmount = txtCardAmount.Text == "" ? 0 : Convert.ToDecimal(txtCardAmount.Text);
            decimal ReceivedAmount = CashAmount + CardAmount;
            txtAmountReceive.Text = Convert.ToString(Math.Round(ReceivedAmount, 2));
        }
        private void txtCashAmount_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {

                cashCardPayments();

                txtCardAmount.Focus();
            }
        }

        private void txtCashAmount_TextChanged(object sender, EventArgs e)
        {
            GrossAmount_Total();
            cashCardPayments();
        }

        private void btnSave_Enter(object sender, EventArgs e)
        {
            btnSave.BackColor = Color.Red;
        }

        private void btnSave_Leave(object sender, EventArgs e)
        {
            btnSave.BackColor = Color.RoyalBlue;
        }

        private void txtCardAmount_KeyPress(object sender, KeyPressEventArgs e)
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

        private void btnClear_Click_1(object sender, EventArgs e)
        {
            clearAll();
            loadNewSale();
            
        }

        private void button1_Click(object sender, EventArgs e)
        {

        }

        private void btnReprintPopup_Click(object sender, EventArgs e)
        {
            loadReturnView();
            
        }

        private void buttonCancelInvoice_Click(object sender, EventArgs e)
        {
            if (validateSave())
            {
                InvoiceCancel = true;
                GrossAmount_Total();
                CheckReceivedAmount();
                this.totalBill = txtReceivableAmount.Text;
                this.ReceivedAmount = txtAmountReceive.Text;
                this.ReturnAmount = txtAmountReturn.Text;

                
                SaveForm();

            }
        }

        private void txtCashAmount_Leave(object sender, EventArgs e)
        {
            decimal payableAmount = txtReceivableAmount.Text == "" ? 0 : Convert.ToDecimal(txtReceivableAmount.Text);
            decimal returnAmount = txtAmountReturn.Text == "" ? 0 : Convert.ToDecimal(txtAmountReturn.Text);
            decimal recAmount = txtAmountReceive.Text == "" ? 0 : Convert.ToDecimal(txtAmountReceive.Text);
            txtAmountReturn.Text = (recAmount - payableAmount).ToString();
        }

        private void txtCardAmount_Leave(object sender, EventArgs e)
        {
            decimal payableAmount = txtReceivableAmount.Text == "" ? 0 : Convert.ToDecimal(txtReceivableAmount.Text);
            decimal returnAmount = txtAmountReturn.Text == "" ? 0 : Convert.ToDecimal(txtAmountReturn.Text);
            decimal recAmount = txtAmountReceive.Text == "" ? 0 : Convert.ToDecimal(txtAmountReceive.Text);
            txtAmountReturn.Text = (recAmount - payableAmount).ToString();
        }
        private DataTable MakeOrderDetailDataTable()
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
            dt1.Columns.Add("ItemNumber");
            dt1.Columns.Add("ItenName");
            

            int i = 0;
            foreach (DataGridViewRow row in ItemSaleGrid.Rows)
            {
                DataRow dRow = dt1.NewRow();
                i = i + 1;
                var TQty = Convert.ToDecimal(row.Cells[4].Value.ToString());//+(Convert.ToDecimal(row.Cells[4].Value.ToString()) * Convert.ToDecimal(row.Cells[13].Value.ToString()));

                dRow[0] = i;
                dRow[1] = row.Cells[0].Value.ToString();
                dRow[2] = TQty.ToString();
                dRow[3] = row.Cells[3].Value.ToString();
                dRow[4] = row.Cells[6].Value.ToString();
                dRow[5] = row.Cells[7].Value.ToString();
                dRow[6] = row.Cells[8].Value.ToString();
                dRow[7] = row.Cells[9].Value.ToString();
                dRow[8] = row.Cells[10].Value.ToString();
                dRow[9] = 0;
                dRow[10] = 0;
                dRow[11] = TQty;
                dRow[12] = 0;
                dRow[13] = Convert.ToString(row.Cells[13].Value);
                dRow[14] = Convert.ToString(row.Cells[12].Value);
                dRow[15] = Convert.ToBoolean(row.Cells[14].Value);
                dRow[16] = Convert.ToString(row.Cells[1].Value);
                dRow[17] = Convert.ToString(row.Cells[2].Value);
                dt1.Rows.Add(dRow);
            }

            return dt1;

        }

        private void btnMakeOrder_Click(object sender, EventArgs e)
        {
            if (ItemSaleGrid.Rows.Count <= 0)
            {
                MessageBox.Show("You Must have Data to Generate Make Order....");
                return;
            }
            else
            {
                
                
                  
                    if (frmMakeOrder.ShowDialog() == DialogResult.OK)
                    {
                    
                    }
                    if(frmMakeOrder.AllowSave)
                    {
                        this.CustomerPhone = frmMakeOrder.PhoneNo;
                        this.CustomerName = frmMakeOrder.CustomerName;
                        this.SaleManId = frmMakeOrder.SaleManId;
                        txtCustName.Text = this.CustomerName;
                        txtCustPhone.Text = this.CustomerPhone;
                        txtSalesManID.Text = this.SaleManId;

                    btnSave.Enabled = false;
                    if (validateSave())
                    {
                        GrossAmount_Total();
                        CheckReceivedAmount();
                        this.totalBill = txtReceivableAmount.Text;
                        this.ReceivedAmount = txtAmountReceive.Text;
                        this.ReturnAmount = txtAmountReturn.Text;
                        SaveForm();

                    }
                }
                    else
                {
                    btnSave.Select();
                    btnSave.Focus();
                }
                
            }
        }

       
        

        private void btnMakeOrder_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyData == Keys.Enter)
            {
              
                btnSave.Select();
                btnSave.Focus();
            }

        }
    }
}
