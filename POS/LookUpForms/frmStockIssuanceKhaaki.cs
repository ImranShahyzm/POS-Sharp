using MetroFramework.Forms;
using Newtonsoft.Json;
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
    public partial class frmStockIssuanceKhaaki : MetroForm
    {
        public frmStockIssuanceKhaaki()
        {
            InitializeComponent();
            loadProducts();
            getIssuanceNo();
            txtStockRate.Text = "1";
            
            //cmbIssuanceType.Items.Insert(0,"Issuance to Kitchen");
            //cmbIssuanceType.Items.Insert(1, "Return from Kitchen");
            cmbIssuanceType.Items.Insert(0, "Return to HeadOffice");
            cmbIssuanceType.SelectedIndex = 0;
            txtProductID.Select();
            txtProductID.Focus();

        }
        public async Task SyncLiveDataAsync()
        {
            var RInvoices = new data_StockTransferInfoModel().StockReturnedToServer("where IssuanceDate between '" + txtArrivalDate.Value.ToString("dd-MMM-yyyy") + "' and '" + txtArrivalDate.Value.ToString("dd-MMM-yyyy") + "' and  FromWHID=" + CompanyInfo.WareHouseID + " and CompanyID=" + CompanyInfo.CompanyID + "", true, true, "where IssuanceDate between '" + txtArrivalDate.Value.ToString("dd-MMM-yyyy") + "' and '" + txtArrivalDate.Value.ToString("dd-MMM-yyyy") + "' and  FromWHID=" + CompanyInfo.WareHouseID + " and CompanyID=" + CompanyInfo.CompanyID + "","",false);

            string RJsonInvoices = JsonConvert.SerializeObject(RInvoices);
            var RInvoiceRespomnce = "";
            if (RInvoices.Tables[0].Rows.Count > 0)
            {
                RInvoiceRespomnce = await STATICClass.InsertAllStockReturntoServer(RJsonInvoices, txtArrivalDate.Value.ToString("dd-MMM-yyyy"), txtArrivalDate.Value.ToString("dd-MMM-yyyy"), CompanyInfo.WareHouseID.ToString(), CompanyInfo.CompanyID.ToString());
            }
            else
            {
                RInvoiceRespomnce = "Done";
            }

        }
        public void getIssuanceNo()
        {
            int SaleVoucherNo = GetVoucherNoContinuos(Fieldname: "IssuanceNo", TableName: "data_StockIssuancetoPosKitchen", CheckTaxable: false,
                  PrimaryKeyValue: 0, PrimaryKeyFieldName: "IssuanceID", voucherDate: Convert.ToDateTime(txtArrivalDate.Value.Date), voucherDateFieldName: "IssuanceDate",
                  companyID: CompanyInfo.CompanyID, FiscalID: CompanyInfo.FiscalID);
            txtSerielNo.Text = Convert.ToString(SaleVoucherNo);
            txtProductID.Select();
            txtProductID.Focus();
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
        public Int32 GetVoucherNoContinuos(string Fieldname, string TableName, bool CheckTaxable, Int32 PrimaryKeyValue,
        string PrimaryKeyFieldName, DateTime? voucherDate, string voucherDateFieldName = "",
        Int32 companyID = 0, string companyFieldName = "CompanyID", Int32 FiscalID = 0,
        string FiscalIDFieldName = "FiscalID", bool IsTaxable = false)
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            try
            {
                DataTable dt = new DataTable();
                SqlConnection con = new SqlConnection(connectionString);
                SqlCommand cmd = new SqlCommand("GetVoucherNoS", con);
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

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void frmStockIssuanceKhaaki_Load(object sender, EventArgs e)
        {
            getIssuanceNo();

            txtProductID.Focus();
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
        private void AddProducts( int id)
        {

          
            bool recordExist = false;

            for (int i = 0; i < dgvStockInDetail.Rows.Count; i++)
            {
                if (id == Convert.ToInt32(dgvStockInDetail.Rows[i].Cells[0].Value.ToString()))
                {

                    string value = dgvStockInDetail.Rows[i].Cells[3].Value.ToString();
                    string rateValue = dgvStockInDetail.Rows[i].Cells[4].Value.ToString();
                    decimal rate = Convert.ToDecimal(rateValue);
                    decimal qty = Convert.ToDecimal(value);
                    qty++;

                    dgvStockInDetail.Rows[i].Cells[3].Value = qty;
                    dgvStockInDetail.Rows[i].Cells[5].Value = (qty * rate);

                    recordExist = true;
                    ClearFields();
                    txtProductID.Focus();
                    return;
                }
            }
            if (!recordExist)
            {
                
                if(txtQuantity.Text=="" || txtItemID.Text=="")
                {
                    MessageBox.Show("Please Fill All the Fields...");
                    return;
                }
                var Value = txtQuantity.Text;
                var Rate = txtStockRate.Text;
                var NetAmount = Convert.ToDecimal(Value) * Convert.ToDecimal(Rate);

                string[] row = { id.ToString(), txtProductID.Text, cmbProducts.Text, txtQuantity.Text,txtStockRate.Text, NetAmount.ToString() };
                dgvStockInDetail.Rows.Insert(0, row);
                ClearFields();
                txtProductID.Focus();
            }
            
        }
        public void ClearFields()
        {
            txtItemID.Clear();
            txtProductID.Clear();
            cmbProducts.SelectedValue = 0 ;
            txtQuantity.Clear();
            txtStockRate.Clear();
            txtNetAmount.Clear();
            txtStockRate.Text="1";
        }
        public void ClearFieldsAllData()
        {
            txtManualNo.Clear();
            txtRemarks.Clear();
          
        
            txtVehicleNo.Clear();
            txtItemID.Clear();
            txtProductID.Clear();
            cmbProducts.SelectedValue = 0;
            txtQuantity.Clear();
            txtStockRate.Clear();
            txtNetAmount.Clear();
            dgvStockInDetail.Rows.Clear();
            dgvStockInDetail.Refresh();

            txtSerielNo.Clear();
            txtManualNo.ReadOnly=true;
            txtRemarks.ReadOnly=true;
            txtVehicleNo.ReadOnly = true;

        }

        private void txtProductID_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyData == Keys.Enter)
            {
                if (txtProductID.Text != "")
                {
                    var BarcodeString = txtProductID.Text.Trim() ;
                    BarcodeString = BarcodeString.TrimStart('0');
                    if (BarcodeString.Length == 9)
                    {
                        BarcodeString = BarcodeString.Substring(0, BarcodeString.Length - 1);
                        txtProductID.Text = BarcodeString;
                    }
                    DataTable dt = getProduct(0, 0, BarcodeString);


                    if (dt.Rows.Count == 0)
                    {
                        using (frmProductLookUp obj = new frmProductLookUp())
                        {
                            if (obj.ShowDialog() == DialogResult.OK)
                            {
                                int id = obj.ProductID;
                                txtProductID.Text = obj.ManualNumber;
                                cmbProducts.SelectedValue = id.ToString();
                                txtItemID.Text = id.ToString();
                                txtQuantity.Text = "1";
                                txtQuantity_KeyDown(sender, e);
                            }
                        };
                    }
                    else
                    {
                        cmbProducts.SelectedValue = dt.Rows[0]["ItemId"].ToString();
                        txtItemID.Text = dt.Rows[0]["ItemId"].ToString();
                        txtQuantity.Text = "1";
                        txtStockRate.Text= dt.Rows[0]["ItemSalesPrice"].ToString(); 
                        txtQuantity_KeyDown(sender, e);
                    }
                    string ids = cmbProducts.SelectedValue.ToString();
                    {
                        if (ids != "0")
                        {
                            DataTable dt1 = getProduct(0, Convert.ToInt32(ids));
                            
                        }
                    }
                }
                else
                {
                    using (frmProductLookUp obj = new frmProductLookUp())
                    {
                        if (obj.ShowDialog() == DialogResult.OK)
                        {
                            int id = obj.ProductID;
                            txtProductID.Text = obj.ManualNumber;
                            cmbProducts.SelectedValue = id.ToString();
                            txtItemID.Text = id.ToString();
                            txtQuantity.Text = "1";
                            txtQuantity_KeyDown(sender, e);
                        }
                    };
                }
            }
            if(e.KeyData==Keys.Escape)
            {
                btnSave.Focus();
            }
            if(e.KeyData==Keys.Space)
            {
                dgvStockInDetail.Focus();
            }
        }

        private void txtQuantity_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                if (txtQuantity.Text != "")
                {
                    if (Convert.ToDecimal(txtQuantity.Text) > 0)
                    {
                        AddProducts(Convert.ToInt32(txtItemID.Text));
                        //txtStockRate.Focus();
                    }
                }
                CalculateDetail();
            }
        }

        private void txtQuantity_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar)  && e.KeyChar != '.')
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
            if(txtQuantity.Text!="" && txtStockRate.Text!="")
            {
                var NetAmount = Convert.ToDecimal(txtQuantity.Text) * Convert.ToDecimal(txtStockRate.Text);
                txtNetAmount.Text = Convert.ToString(NetAmount);
            }
            else
            {
                txtNetAmount.Text = "";
            }
        }

        private void txtStockRate_KeyPress(object sender, KeyPressEventArgs e)
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

        private void txtArrivalDate_ValueChanged(object sender, EventArgs e)
        {
            getIssuanceNo();
        }

        private void txtVehicleNo_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                txtArrivalDate.Focus();
            }
        }

        private void txtStockRate_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                AddProducts(Convert.ToInt32(txtItemID.Text));
            }
        }

        private void txtManualNo_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                txtRemarks.Focus();
            }
        }

        private void txtRemarks_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                txtProductID.Focus();
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        private DataTable GetdataTableFromGrid()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("RowID");
            dt.Columns.Add("Issuance");
            dt.Columns.Add("ItemId");
            dt.Columns.Add("Quantity");
            dt.Columns.Add("StockRate");
            dt.Columns.Add("CartonQuantity");
            dt.Columns.Add("LooseQuantity");
            dt.Columns.Add("TransferDetailID");

            //Adding the Rows.
            foreach (DataGridViewRow row in dgvStockInDetail.Rows)
            {
                dt.Rows.Add();
                dt.Rows[dt.Rows.Count - 1][0] = dt.Rows.Count - 1;

                dt.Rows[dt.Rows.Count - 1][1] = 0;
                dt.Rows[dt.Rows.Count - 1][2] = row.Cells[0].Value.ToString();
                dt.Rows[dt.Rows.Count - 1][3] = row.Cells[3].Value.ToString();
                dt.Rows[dt.Rows.Count - 1][4] = row.Cells[4].Value.ToString();
                dt.Rows[dt.Rows.Count - 1][5] =0;
                dt.Rows[dt.Rows.Count - 1][6] =0;
                dt.Rows[dt.Rows.Count - 1][7] =0;

            }
            return dt;
        }
        private void btnSave_ClickAsync(object sender, EventArgs e)
        {

            try
            {
               
                DataTable dtGrid = GetdataTableFromGrid();
               
                data_StockTransferInfoModel model = new data_StockTransferInfoModel();
                if ((dtGrid.Rows.Count<=0))
                {
                    MessageBox.Show("No Rows for Saving Record...");
                    return;
                }
                if(string.IsNullOrEmpty(txtIssuanceID.Text))
                {
                    txtIssuanceID.Text = "0";
                }

                model.IssuanceID = Convert.ToInt32(txtIssuanceID.Text);
                model.ArrivalDate = txtArrivalDate.Value;
                model.ManualNo = txtManualNo.Text;
                model.VehicleNo = txtVehicleNo.Text;
                model.Remarks = txtRemarks.Text;
                model.IssuanceType = 2;// cmbIssuanceType.SelectedIndex;
                var message = model.InsertStockIssuanceDetaildata(dtGrid, model);
                if (message == true)
                {
                    dgvStockInDetail.DataSource = null;
                    dgvStockInDetail.Rows.Clear();
                    dgvStockInDetail.Refresh();
                     SyncLiveDataAsync();
                    this.Close();
                }
                else
                {
                    MessageBox.Show(model.ErrorMsg);
                    return;
                
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
                return;
            }
        }

        private void dgvStockInDetail_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            //if (dgvStockInDetail.CurrentRow != null)
            //{
            //    DataGridViewRow dgr = dgvStockInDetail.Rows[dgvStockInDetail.CurrentRow.Index];
            //    var value = dgr.Cells[1].Value;
            //    txtItemID.Text = dgr.Cells[0].Value.ToString();

            //    cmbProducts.SelectedValue = dgr.Cells[0].Value.ToString();

            //    txtProductID.Text = dgr.Cells[5].Value.ToString();
            //    txtQuantity.Text = dgr.Cells[2].Value.ToString();
            //    txtStockRate.Text = dgr.Cells[3].Value.ToString();
            //    txtNetAmount.Text = dgr.Cells[4].Value.ToString();
            //    dgvStockInDetail.Rows.RemoveAt(dgvStockInDetail.CurrentRow.Index);
            //    txtQuantity.Focus();
            //}
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            ClearFields();
            txtProductID.Focus();
        }
        public void LoadStockDetailDataMaster(int IssuanceID)
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " ";
            if (IssuanceID > 0)
            {
                SqlString = " Select data_StockIssuancetoPosKitchenDetail.ItemId , Quantity ,StockRate,ItenName as ProductName,InventItems.ManualNumber,data_StockIssuancetoPosKitchen.IssuanceNo,data_StockIssuancetoPosKitchen.Remarks,IssuanceDate,data_StockIssuancetoPosKitchen.IssuanceType from data_StockIssuancetoPosKitchenDetail inner join data_StockIssuancetoPosKitchen on data_StockIssuancetoPosKitchen.IssuanceID = data_StockIssuancetoPosKitchenDetail.IssuanceID inner join InventItems on InventItems.ItemId = data_StockIssuancetoPosKitchenDetail.ItemId where data_StockIssuancetoPosKitchen.IssuanceID =" + IssuanceID + "";


                SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                cnn.Close();
                if (dt.Rows.Count > 0)
                {
                    txtIssuanceID.Text = Convert.ToString(IssuanceID);
                    
                    foreach(DataRow row in dt.Rows)
                    {

                        
                        txtIssuanceID.Text = IssuanceID.ToString();
                        txtSerielNo.Text = row[5].ToString();
                        txtRemarks.Text = row[6].ToString();
                        txtArrivalDate.Value = Convert.ToDateTime(row[7].ToString());
                        cmbIssuanceType.SelectedIndex= 0;
                        txtProductID.Text = row[4].ToString();
                        txtItemID.Text = row[0].ToString();
                        txtQuantity.Text = row[1].ToString();
                        txtStockRate.Text = row[2].ToString();
                        cmbProducts.SelectedValue = row[0].ToString();

                        AddProducts(Convert.ToInt32(row[0]));
                    }
                    btnDelete.Visible = true;
                    btnSearch.Visible = false;
                    txtSerielNo.ReadOnly = true;
                    CalculateDetail();
                }
                else
                {
                    this.dgvStockInDetail.DataSource = null;
                    dgvStockInDetail.Rows.Clear();
                    dgvStockInDetail.Refresh();
                    btnDelete.Visible = false;
                    btnSearch.Visible = true;
                }
            }
        }



        private void btnSearch_Click(object sender, EventArgs e)
        {
            ClearFieldsAllData();
            txtSerielNo.ReadOnly = false;
            txtSerielNo.Focus();
            using (fromStockIssuanceLookUp obj = new fromStockIssuanceLookUp())
            {
                if (obj.ShowDialog() == DialogResult.OK)
                {
                    int id = obj.IssuanceID;
                    LoadStockDetailDataMaster(id);
                }
            };
        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }
        public void refreshForm()
        {
            this.dgvStockInDetail.DataSource = null;
            dgvStockInDetail.Rows.Clear();
            dgvStockInDetail.Refresh();
            ClearFields();
            btnDelete.Visible = false;
            btnSearch.Visible = true;
            txtManualNo.ReadOnly = false;
            txtRemarks.ReadOnly = false;
            txtVehicleNo.ReadOnly = false;
            txtSerielNo.ReadOnly = true;
            getIssuanceNo();
            txtArrivalDate.Value = System.DateTime.Now;

        }
        private void btnDelete_Click(object sender, EventArgs e)
        {
            var IssuanceID = Convert.ToInt32(txtIssuanceID.Text);
            if (IssuanceID > 0)
            {
                if (MessageBox.Show("Are You Sure You Want to Delete the Selected Record...?", "Confirmation...!!", MessageBoxButtons.YesNo) == DialogResult.Yes)
                {
                    data_StockTransferInfoModel obj = new data_StockTransferInfoModel();
                    var Responce = obj.IssuanceDelete(IssuanceID);
                    if (Responce == "Deleted")
                    {
                        refreshForm();
                      

                    }
                    else
                    {
                        MessageBox.Show(Responce);
                    }
                    return;


                }

            }
        }

       

        private void cmbIssuanceType_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                txtRemarks.Focus();
            }

        }

        private void frmStockIssuanceKhaaki_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                if (dgvStockInDetail.CurrentRow != null)
                {
                    DataGridViewRow dgr = dgvStockInDetail.Rows[dgvStockInDetail.CurrentRow.Index];
                    var value = dgr.Cells[1].Value;
                    txtItemID.Text = dgr.Cells[0].Value.ToString();

                    cmbProducts.SelectedValue = dgr.Cells[0].Value.ToString();

                    txtProductID.Text = dgr.Cells[5].Value.ToString();
                    txtQuantity.Text = dgr.Cells[2].Value.ToString();
                    txtStockRate.Text = dgr.Cells[3].Value.ToString();
                    txtNetAmount.Text = dgr.Cells[4].Value.ToString();
                    dgvStockInDetail.Rows.RemoveAt(dgvStockInDetail.CurrentRow.Index);
                    txtQuantity.Focus();
                }
            }
        }
       
        private void Column1_KeyPress(object sender, KeyPressEventArgs e)
        {
           
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar))
            {
                e.Handled = true;
            }

           
           // CalculateDetail();

        }
        private void CalculateDetail()
        {
            decimal NetAmount = 0;
            decimal NetPcs = 0;
            for (int i = 0; i < dgvStockInDetail.Rows.Count; i++)
            {

              
                //var taxPercentage = Convert.ToDecimal(dt.Rows[0]["TotalTax"]);
                //string rateValue = dgvStockInDetail.Rows[i].Cells[2].Value.ToString();
                //string total = (Convert.ToDecimal(rateValue) * 1).ToString();
                //string taxAmount = (((Convert.ToDecimal(taxPercentage) * Convert.ToDecimal(rateValue)) / 100) * 1).ToString();
                 NetAmount += Convert.ToDecimal(dgvStockInDetail.Rows[i].Cells[5].Value);
                NetPcs += Convert.ToDecimal(dgvStockInDetail.Rows[i].Cells[3].Value);
             
            }
            txtGrandAmount.Text = Convert.ToString((Int32)NetAmount);

            txtTotalPCs.Text = Convert.ToString((Int32)NetPcs);
        }

        private void dgvStockInDetail_EditingControlShowing(object sender, DataGridViewEditingControlShowingEventArgs e)
        {
            e.Control.KeyPress -= new KeyPressEventHandler(Column1_KeyPress);
            TextBox ttxb = e.Control as TextBox;

            if (dgvStockInDetail.CurrentCell.ColumnIndex == dgvStockInDetail.Columns["Quantity"].Index) //Desired Column
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

        private void dgvStockInDetail_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Delete)
            {
                  dgvStockInDetail.Rows.RemoveAt(dgvStockInDetail.CurrentRow.Index);
            }
        }

        private void dgvStockInDetail_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
