using MetroFramework.Forms;
using POS.Helper;
using POS.LookUpForms;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace POS
{
    public partial class frmMakeToOrder : MetroForm
    {
        public int OrderNo = 0;
        public bool directReturn = false;
        public bool UpdateOrder = false;
        public bool InvoiceCancel = false;
        public string CardNumber { get; set; }
        public string CardName { get; set; }
        public string totalBill { get; set; }
        public string ReceivedAmount { get; set; }
        public string ReturnAmount { get; set; }
        public frmMakeToOrder()
        {
            InitializeComponent();
            LoadCType();
            GetRegistraionNo();
            clearAll();
            loadProducts();
            loadSaleMenuGroup();
            loadSaleMansMenuGroup();

        }
        private void loadSaleMansMenuGroup()
        {



            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " SELECT SaleManInfoID,SaleManName FROM Gen_saleManInfo where WHID=" + CompanyInfo.WareHouseID + "";
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            DataRow dr = dt.NewRow();
            dr[0] = "0";
            dr[1] = "--Select Sales Person--";
            dt.Rows.InsertAt(dr, 0);

            cmbSalesMan.ValueMember = "SaleManInfoID";
            cmbSalesMan.DisplayMember = "SaleManName";
            cmbSalesMan.DataSource = dt;

        }
        public enum SP
        {

            Posdata_MaketoOrderInfo_Insert

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
        public void GetRegistraionNo()
        {
            int SaleVoucherNo = GetVoucherNoContinuos(Fieldname: "RNo", TableName: "Posdata_MaketoOrderInfo", CheckTaxable: false,
                  PrimaryKeyValue: 0, PrimaryKeyFieldName: "OrderID", voucherDate: Convert.ToDateTime(dtRegisterDate.Value.Date), voucherDateFieldName: "RegisterDate",
                  companyID: CompanyInfo.CompanyID, FiscalID: CompanyInfo.FiscalID);
            txtOrderNo.Text = Convert.ToString(SaleVoucherNo);
            txtPhone.Select();
            txtPhone.Focus();
            txtOrderNo.ReadOnly = true;
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

        public void LoadCType()
        {
            cmbGender.DisplayMember = "Text";
            cmbGender.ValueMember = "Value";

            var items = new[] {
    new { Text = "Male", Value = "1" },
    new { Text = "Female", Value = "2" }
    
};

            cmbGender.DataSource = items;

            hideFemaleOptions();
        }
        private void loadCashSource()
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " select CashTypeSourceID,SourceName from gen_CashTypeSource where IsForCashIn=1";
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            //cmbCashType.ValueMember = "CashTypeSourceID";
            //cmbCashType.DisplayMember = "SourceName";
            //cmbCashType.DataSource = dt;
        }
        
        private void btnSave_Click(object sender, EventArgs e)
        {
            if (validateSave())
            {
                string message = "Do you want to Save the Data?";
                string title = "Close Window";
                MessageBoxButtons buttons = MessageBoxButtons.YesNo;
                DialogResult result = MessageBox.Show(message, title, buttons);
                if (result == DialogResult.Yes)
                {
                    SaveForm();
                }
                else
                {
                    btnSave.Enabled = false;
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
              
             
                //txtOrderNo.Text = Convert.ToString(dt.Rows[0]["Rno"]);
                txtCustname.Text = Convert.ToString(dt.Rows[0]["CName"]);  
                txtPhone.Text=Convert.ToString(dt.Rows[0]["CPhone"]);      
                txtAddress.Text=Convert.ToString(dt.Rows[0]["Address"]);
                txtCity.Text=Convert.ToString(dt.Rows[0]["CityName"]);
                cmbGender.SelectedValue=Convert.ToString(dt.Rows[0]["Gender"]);
                    
                txtCnic.Text=Convert.ToString(dt.Rows[0]["CNIC"]);        
                txtNeck.Text=Convert.ToString(dt.Rows[0]["Neck"]);
                txtFrontNeck.Text=Convert.ToString(dt.Rows[0]["FFrontNeck"]);
                txtBackNeck.Text=Convert.ToString(dt.Rows[0]["FBackNeck"]);
                txtShoulder.Text=Convert.ToString(dt.Rows[0]["Shoulder"]);
                txtUperBust.Text=Convert.ToString(dt.Rows[0]["FUpperBust"]);
                txtBust.Text=Convert.ToString(dt.Rows[0]["Bust"]);
                txtUnderBust.Text=Convert.ToString(dt.Rows[0]["FUnderBust"]);
                txtArmHole.Text=Convert.ToString(dt.Rows[0]["ArmHole"]);
                txtSleeve.Text=Convert.ToString(dt.Rows[0]["SleeveLength"]);
                txtMuscle.Text=Convert.ToString(dt.Rows[0]["Muscle"]);
                txtElbow.Text=Convert.ToString(dt.Rows[0]["Elbow"]);
                txtCuff.Text=Convert.ToString(dt.Rows[0]["Cuff"]);
                txtWaist.Text=Convert.ToString(dt.Rows[0]["Waist"]);
                txthip.Text=Convert.ToString(dt.Rows[0]["Hip"]);
                txtBottomLength.Text=Convert.ToString(dt.Rows[0]["BottomLength"]);
                txtAnkle.Text=Convert.ToString(dt.Rows[0]["Ankle"]);
                txtRemarks.Text=Convert.ToString(dt.Rows[0]["Remarks"]);

                txtPhone.ReadOnly = true;

                if (string.IsNullOrEmpty(txtNeck.Text))
                {
                    txtNeck.Select();
                    txtNeck.Focus();
                }
                else
                {
                    dtDeliveryDate.Select();
                    dtDeliveryDate.Focus();
                }





            }
            else
            {
                MessageBox.Show("We have no Customer  regarding this No!");
            }
        }
        private void LoadSavedOrder(string OrderID)
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DataTable dtdetail = new DataTable();
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection con = new SqlConnection(connectionString);
            SqlTransaction tran;
            con.Open();
            tran = con.BeginTransaction();
            SqlCommand cmd = new SqlCommand("Posdata_MaketoOrderInfo_SelectAll", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter();

            string whereclause = " where OrderID=" + OrderID + " and WHID=" + CompanyInfo.WareHouseID + "";
            string WhereClauseDetail = " where OrderID=" + OrderID;
            cmd.Parameters.AddWithValue("@SelectMaster", 1);
            cmd.Parameters.AddWithValue("@WhereClause", whereclause);
            cmd.Parameters.AddWithValue("@SelectDetail", 1);
            cmd.Parameters.AddWithValue("@WhereClauseDetail", WhereClauseDetail);

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


                //txtOrderNo.Text = Convert.ToString(dt.Rows[0]["Rno"]);
                txtCustname.Text = Convert.ToString(dt.Rows[0]["CName"]);
                txtPhone.Text = Convert.ToString(dt.Rows[0]["CPhone"]);
                txtAddress.Text = Convert.ToString(dt.Rows[0]["Address"]);
                txtCity.Text = Convert.ToString(dt.Rows[0]["CityName"]);
                cmbGender.SelectedValue = Convert.ToString(dt.Rows[0]["Gender"]);

                txtCnic.Text = Convert.ToString(dt.Rows[0]["CNIC"]);
                txtNeck.Text = Convert.ToString(dt.Rows[0]["Neck"]);
                txtFrontNeck.Text = Convert.ToString(dt.Rows[0]["FFrontNeck"]);
                txtBackNeck.Text = Convert.ToString(dt.Rows[0]["FBackNeck"]);
                txtShoulder.Text = Convert.ToString(dt.Rows[0]["Shoulder"]);
                txtUperBust.Text = Convert.ToString(dt.Rows[0]["FUpperBust"]);
                txtBust.Text = Convert.ToString(dt.Rows[0]["Bust"]);
                txtUnderBust.Text = Convert.ToString(dt.Rows[0]["FUnderBust"]);
                txtArmHole.Text = Convert.ToString(dt.Rows[0]["ArmHole"]);
                txtSleeve.Text = Convert.ToString(dt.Rows[0]["SleeveLength"]);
                txtMuscle.Text = Convert.ToString(dt.Rows[0]["Muscle"]);
                txtElbow.Text = Convert.ToString(dt.Rows[0]["Elbow"]);
                txtCuff.Text = Convert.ToString(dt.Rows[0]["Cuff"]);
                txtWaist.Text = Convert.ToString(dt.Rows[0]["Waist"]);
                txthip.Text = Convert.ToString(dt.Rows[0]["Hip"]);
                txtBottomLength.Text = Convert.ToString(dt.Rows[0]["BottomLength"]);
                txtAnkle.Text = Convert.ToString(dt.Rows[0]["Ankle"]);
                txtRemarks.Text = Convert.ToString(dt.Rows[0]["Remarks"]);

                txtTotalTax.Text = dt.Rows[0]["TaxAmount"].ToString();
                txtGrossAmount.Text = dt.Rows[0]["GrossAmount"].ToString();
                txtDiscountPercentage.Text = dt.Rows[0]["DiscountPercentage"].ToString();
                txtDiscountAmount.Text = dt.Rows[0]["DiscountAmount"].ToString();
                txtTotalDiscount.Text = dt.Rows[0]["DiscountTotal"].ToString();
                txtOtherCharges.Text = dt.Rows[0]["OtherCharges"].ToString();
                txtNetAmount.Text = dt.Rows[0]["NetAmount"].ToString();
                txtAmountReceive.Text = "0.00";
                txtAccAmount.Text = dt.Rows[0]["NetAmount"].ToString();
              
                txtPayableAmount.Text = "0.00";
                txtAmountReturn.Text = "0.00";
                txtReceivableAmount.Text = "0.00";
                cmbSalesMan.SelectedValue= Convert.ToString(dt.Rows[0]["SaleManId"])==""?"0": Convert.ToString(dt.Rows[0]["SaleManId"]);
                txtCashAmount.Text = dt.Rows[0]["CashPayment"].ToString();
                txtCardAmount.Text = dt.Rows[0]["CardPayment"].ToString();
                txtCardName.Text = dt.Rows[0]["CardName"].ToString();
                txtCardNumber.Text = dt.Rows[0]["CardNumber"].ToString();

                dtRegisterDate.Value= Convert.ToDateTime(dt.Rows[0]["RegisterDate"]);
                dtDeliveryDate.Value = Convert.ToDateTime(dt.Rows[0]["DeliveryDate"]);
                dtRegisterDate.Enabled = true;
                txtOrderNo.ReadOnly = true;
                txtPhone.ReadOnly = true;

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


                if (string.IsNullOrEmpty(txtNeck.Text))
                {
                    txtNeck.Select();
                    txtNeck.Focus();
                }
                else
                {
                    dtDeliveryDate.Select();
                    dtDeliveryDate.Focus();
                }





            }
            else
            {
                MessageBox.Show("We have no Customer  regarding this No!");
            }
        }
        private bool validateSave()
        {

            btnSave.Enabled = false;
            if (ItemSaleGrid.Rows.Count <= 0)
            {

                
                btnSave.Enabled = true;
                MessageBox.Show("There is no item in cart!");
                return false;

            }
                if (string.IsNullOrEmpty(txtCustname.Text) && string.IsNullOrEmpty(txtPhone.Text))
            {
                MessageBox.Show("Customer Name and Phone # are Required Please Add them...");

                btnSave.Enabled = true;
                return false;
            }
            else
            {
                if((txtPhone.Text.Length>11 || txtPhone.Text.Length < 11))
                {
                    MessageBox.Show("Please Enter Correct Phone No....");
                    txtPhone.Select();
                    txtPhone.Focus();
                    btnSave.Enabled = true;
                    return false;
                }
                else
                {
                    GrossAmount_Total();
                    CheckReceivedAmount();
                    this.totalBill = txtReceivableAmount.Text;
                    this.ReceivedAmount = txtAmountReceive.Text;
                    this.ReturnAmount = txtAmountReturn.Text;
                    return true;
                }

                
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


        public bool IsPhoneNumber(string number)
        {
            var abc = Regex.Match(number, @"^(\+[0-9]{11})$");
            return Regex.Match(number, @"^(\+[0-9]{11})$").Success;
        }
        
        private bool CheckPhoneNo(string PhoneNo)
        {
            if (!string.IsNullOrEmpty(PhoneNo))
            {
                var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
                SqlConnection cnn;
                cnn = new SqlConnection(connectionString);
                cnn.Open();
                
               string SqlString = " Select Top 1 CPhone from tblPos_CustomerData Where WHID=" + CompanyInfo.WareHouseID + " and CPhone like '%" +  PhoneNo + "%'";
                if (!string.IsNullOrEmpty(txtOrderID.Text))
                {
                    SqlString += " and CustomerID!=" + txtOrderID.Text + "";
                }
                SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                //var Decrypt=StringCipher.Decrypt("CORBISNAME",dt.Rows[0])
                cnn.Close();
                if (dt.Rows.Count > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            return false;
        }
        private int GetOrderID(string OrderNo)
        {
            if (!string.IsNullOrEmpty(OrderNo))
            {
                var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
                SqlConnection cnn;
                cnn = new SqlConnection(connectionString);
                cnn.Open();

                string SqlString = " Select OrderID from Posdata_MaketoOrderInfo Where WHID=" + CompanyInfo.WareHouseID + " and Rno=" + OrderNo + "";
               
                SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                //var Decrypt=StringCipher.Decrypt("CORBISNAME",dt.Rows[0])
                cnn.Close();
                if (dt.Rows.Count > 0)
                {
                    return Convert.ToInt32(dt.Rows[0]["OrderID"]);
                }
                else
                {
                    return 0;
                }
            }
            return 0;
        }
        private int GetCustomerID(string PhoneNo)
        {
            int CutomerId = 0;
            if (!string.IsNullOrEmpty(PhoneNo))
            {
                var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
                SqlConnection cnn;
                cnn = new SqlConnection(connectionString);
                cnn.Open();

                string SqlString = " Select CustomerID from tblPos_CustomerData Where WHID=" + CompanyInfo.WareHouseID + " and CPhone='" + PhoneNo + "'";
               
                SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                //var Decrypt=StringCipher.Decrypt("CORBISNAME",dt.Rows[0])
                cnn.Close();
                if (dt.Rows.Count > 0)
                {
                    CutomerId=Convert.ToInt32(dt.Rows[0][0]);
                }
                else
                {
                    CutomerId = 0;
                }
            }
            return CutomerId;
        }
        private DataTable MakeDetailDataTable()
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
                dRow[10] = 0;// row.Cells[4].Value.ToString();
                dRow[11] = TQty;// row.Cells[7].Value.ToString();
                dRow[12] = 0; //Convert.ToString(row.Cells[14].Value);

                dRow[13] = Convert.ToString(row.Cells[13].Value);
                dRow[14] = Convert.ToString(row.Cells[12].Value);
                dRow[15] = Convert.ToBoolean(row.Cells[14].Value);
                dt1.Rows.Add(dRow);
            }

            return dt1;

        }
        private void SaveForm()
        {


            DataTable detailData = MakeDetailDataTable();

            int RegisterID = 0;
            if(!string.IsNullOrEmpty(txtOrderID.Text))
            {
                RegisterID = Convert.ToInt32(txtOrderID.Text);
            }
            SqlParameter p = new SqlParameter("@OrderID", RegisterID);
            p.Direction = ParameterDirection.InputOutput;
            List<SqlParameter> ParamList = new List<SqlParameter>();
            ParamList.Add(p);

            ParamList.Add(new SqlParameter("@UserID", CompanyInfo.UserID));
            ParamList.Add(new SqlParameter("@RegisterDate", Convert.ToDateTime(dtRegisterDate.Value)));

            ParamList.Add(new SqlParameter("@CName", txtCustname.Text));
            ParamList.Add(new SqlParameter("@CPhone", txtPhone.Text));
            ParamList.Add(new SqlParameter("@Address",txtAddress.Text));
            ParamList.Add(new SqlParameter("@CityName", txtCity.Text));
            ParamList.Add(new SqlParameter("@Gender", cmbGender.SelectedValue));
            ParamList.Add(new SqlParameter("@FiscalID", CompanyInfo.FiscalID));
            ParamList.Add(new SqlParameter("@CNIC",  txtCnic.Text));
            ParamList.Add(new SqlParameter("@Neck", txtNeck.Text));
            ParamList.Add(new SqlParameter("@FFrontNeck",txtFrontNeck.Text));
            ParamList.Add(new SqlParameter("@FBackNeck",txtBackNeck.Text));
            ParamList.Add(new SqlParameter("@Shoulder",txtShoulder.Text));
            ParamList.Add(new SqlParameter("@FUpperBust",txtUperBust.Text));
            ParamList.Add(new SqlParameter("@Bust",txtBust.Text));
            ParamList.Add(new SqlParameter("@FUnderBust",txtUnderBust.Text));
            ParamList.Add(new SqlParameter("@ArmHole",txtArmHole.Text));
            ParamList.Add(new SqlParameter("@SleeveLength",txtSleeve.Text));
            ParamList.Add(new SqlParameter("@Muscle",txtMuscle.Text));
            ParamList.Add(new SqlParameter("@Elbow",txtElbow.Text));
            ParamList.Add(new SqlParameter("@Cuff",txtCuff.Text));
            ParamList.Add(new SqlParameter("@Waist",txtWaist.Text));
            ParamList.Add(new SqlParameter("@Hip",txthip.Text));
            ParamList.Add(new SqlParameter("@BottomLength",txtBottomLength.Text));
            ParamList.Add(new SqlParameter("@Ankle",txtAnkle.Text));
            ParamList.Add(new SqlParameter("@Remarks",txtRemarks.Text));
            ParamList.Add(new SqlParameter("@RNo",txtOrderNo.Text));

            ParamList.Add(new SqlParameter("@CompanyID", CompanyInfo.CompanyID));
            ParamList.Add(new SqlParameter("@BranchID", CompanyInfo.BranchID));         
            ParamList.Add(new SqlParameter("@WHID", CompanyInfo.WareHouseID));
            ParamList.Add(new SqlParameter("@CustomerID", txtCustomerID.Text));
            ParamList.Add(new SqlParameter("@AmountReceivable", txtReceivableAmount.Text == "" ? 0 : Convert.ToDecimal(txtReceivableAmount.Text)));
            ParamList.Add(new SqlParameter("@TaxAmount", txtTotalTax.Text == "" ? 0 : Convert.ToDecimal(txtTotalTax.Text)));
            ParamList.Add(new SqlParameter("@GrossAmount", Convert.ToDecimal(txtGrossAmount.Text)));
            ParamList.Add(new SqlParameter("@DiscountPercentage", txtDiscountPercentage.Text == "" ? 0 : Convert.ToDecimal(txtDiscountPercentage.Text)));
            ParamList.Add(new SqlParameter("@DiscountAmount", txtDiscountAmount.Text == "" ? 0 : Convert.ToDecimal(txtDiscountAmount.Text)));
            ParamList.Add(new SqlParameter("@DiscountTotal", Convert.ToDecimal(txtTotalDiscount.Text)));
            ParamList.Add(new SqlParameter("@OtherCharges", txtOtherCharges.Text == "" ? 0 : Convert.ToDecimal(txtOtherCharges.Text)));
            ParamList.Add(new SqlParameter("@NetAmount", Convert.ToDecimal(txtNetAmount.Text)));
            ParamList.Add(new SqlParameter("@Posdata_MaketoOrderDetail",detailData));

            ParamList.Add(new SqlParameter("@AmountReceive", txtAmountReceive.Text == "" ? 0 : Convert.ToDecimal(txtAmountReceive.Text)));
            ParamList.Add(new SqlParameter("@AmountReturn", txtAmountReturn.Text == "" ? 0 : Convert.ToDecimal(txtAmountReturn.Text)));
            ParamList.Add(new SqlParameter("@AmountInAccount", txtAccAmount.Text == "" ? 0 : Convert.ToDecimal(txtAccAmount.Text)));
            ParamList.Add(new SqlParameter("@DeliveryDate", Convert.ToDateTime(dtDeliveryDate.Value)));

            ParamList.Add(new SqlParameter("@SaleManId", Convert.ToString(cmbSalesMan.SelectedValue)));
            ParamList.Add(new SqlParameter("@CashPayment", txtCashAmount.Text == "" ? 0 : Convert.ToDecimal(txtCashAmount.Text)));
            ParamList.Add(new SqlParameter("@CardPayment", txtCardAmount.Text == "" ? 0 : Convert.ToDecimal(txtCardAmount.Text)));
            ParamList.Add(new SqlParameter("@CardName", txtCardName.Text));
            ParamList.Add(new SqlParameter("@CardNumber", txtCardNumber.Text));

        

            //ParamList.Add(new SqlParameter("@ExchangeAmount", txtExchangeAmt.Text == "" ? 0 : Convert.ToDecimal(txtAmountReturn.Text)));




            try
            {
                DataTable ret = STATICClass.ExecuteInsert(SP.Posdata_MaketoOrderInfo_Insert.ToString()
                    , ParamList);
                if (ret.Columns.Contains("@OrderID"))
                {
                     RegisterID = Convert.ToInt32(ret.Rows[0]["@OrderID"].ToString());
                }
                else
                {
                    var msg= Convert.ToString(ret.Rows[0]["ErrorMsg"].ToString());
                    MessageBox.Show(msg);
                    btnSave.Enabled = true;
                    return;

                }
            }catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
                return;
            }
            clearAll();
        }

        private void clearAll()
        {
            ClearTextboxes(this.Controls);
            txtCustname.Clear();
            txtPhone.Clear();
            txtAddress.Clear();
            txtCity.Clear();
            txtCnic.Clear();
            txtNeck.Clear();

            txtFrontNeck.Clear();

            txtBackNeck.Clear();
            txtShoulder.Clear();
            txtUperBust.Clear();
            txtBust.Clear();
            txtUnderBust.Clear();
            txtArmHole.Clear();
            txtSleeve.Clear();
            txtMuscle.Clear();
            cmbSalesMan.SelectedValue = "0";
            btnSave.Enabled = true;
            txtOrderID.Clear();
            GetRegistraionNo();
            ItemSaleGrid.Rows.Clear();
            ItemSaleGrid.Refresh();
            txtPhone.Select();
            txtPhone.Focus();
            txtPhone.ReadOnly = false;

        }
        void ClearTextboxes(System.Windows.Forms.Control.ControlCollection ctrls)
        {
            foreach (Control ctrl in ctrls)
            {
                if (ctrl is TextBox)
                    ((TextBox)ctrl).Text = string.Empty;
                ClearTextboxes(ctrl.Controls);
            }
            
        }

        private void frmMakeToOrder_Load(object sender, EventArgs e)
        {
            //txtBillNo.Focus();
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            clearAll();
         
        }
        protected override bool ProcessCmdKey(ref Message msg, Keys keyData)
        {
            if (keyData == (Keys.Alt | Keys.S))
            {
                if (validateSave())
                {
                    string message = "Do you want to Save the Data?";
                    string title = "Close Window";
                    MessageBoxButtons buttons = MessageBoxButtons.YesNo;
                    DialogResult result = MessageBox.Show(message, title, buttons);
                    if (result == DialogResult.Yes)
                    {
                        SaveForm();
                    }
                    else
                    {
                        return true;
                    }
                   
                }
                return true;
            }
            else if (keyData == (Keys.Alt | Keys.N))
            {
                clearAll();
                return true;
            }
            return base.ProcessCmdKey(ref msg, keyData);
        }

        private void txtCashInAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!(Char.IsDigit(e.KeyChar) || (e.KeyChar == (char)Keys.Back)))
                e.Handled = true;
        }

        private void txtCashInAmount_TextChanged(object sender, EventArgs e)
        {

        }

        private void dtCashDate_ValueChanged(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void txtBust_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtShoulder_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtNeck_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtSleeve_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtUperBust_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtFrontNeck_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtBackNeck_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtUnderBust_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtMuscle_TextChanged(object sender, EventArgs e)
        {

        }

        private void label20_Click(object sender, EventArgs e)
        {

        }

        private void label17_Click(object sender, EventArgs e)
        {

        }

        private void label13_Click(object sender, EventArgs e)
        {

        }

        private void label23_Click(object sender, EventArgs e)
        {

        }

        
        public void hideFemaleOptions()
        {
            lblUpperBust.Visible = false;
            lblUnderBust.Visible = false;
            lblFrontNeck.Visible = false;
            lblBackNeck.Visible = false;
            txtFrontNeck.Visible = false;
            txtBackNeck.Visible = false;
            txtUperBust.Visible = false;
            txtUnderBust.Visible = false;
        }
        public void ShowFemaleOptions()
        {
            lblUpperBust.Visible = true;
            lblUnderBust.Visible = true;
            lblFrontNeck.Visible = true;
            lblBackNeck.Visible = true;
            txtFrontNeck.Visible = true;
            txtBackNeck.Visible = true;
            txtUperBust.Visible = true;
            txtUnderBust.Visible = true;
        }
        private void cmbGender_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(cmbGender.SelectedValue=="1")
            {
                hideFemaleOptions();
            }
            else
            {
                ShowFemaleOptions();
            }
        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void txtCustname_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                cmbGender.Select();
                cmbGender.Focus();
            }
        }

        private void txtPhone_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!(Char.IsDigit(e.KeyChar) || (e.KeyChar == (char)Keys.Back)))
                e.Handled = true;
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            txtOrderNo.ReadOnly = false;
            txtOrderNo.Clear();
            txtOrderNo.Select();

            txtOrderNo.Focus();
        }

        private void txtRno_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                bool isFound = false;
                if (!string.IsNullOrEmpty(txtOrderNo.Text))
                {
                   var OrderID= GetOrderID(txtOrderNo.Text);
                    if(OrderID>0)
                    {
                        txtOrderID.Text = OrderID.ToString();
                       
                        LoadSavedOrder(Convert.ToString(OrderID));
                        isFound = true;
                    }
                    

                }

                if(isFound==false)

                {
                    using (frmSearchMaketoOrder obj = new frmSearchMaketoOrder())
                    {
                        if (obj.ShowDialog() == DialogResult.OK)
                        {
                            string Rno = obj.RegisterNo;
                            txtOrderID.Text = obj.OrderID;
                            txtOrderNo.Text = obj.RegisterNo;
                            LoadSavedOrder(obj.OrderID);
                        }
                        else
                        {
                            clearAll();
                        }
                    };
                }

            }
        }

        private void txtPhone_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                if (string.IsNullOrEmpty(txtPhone.Text))
                {
                    using (frmSearchCustomerLookup obj = new frmSearchCustomerLookup())
                    {
                        if (obj.ShowDialog() == DialogResult.OK)
                        {
                            string Rno = obj.RegisterNo;
                            txtCustomerID.Text = obj.CustomerID;
                            LoadCustomerData(obj.CustomerID);
                        }
                        else
                        {
                            clearAll();
                        }
                    };
                }
                else
                {
                    int CustID=GetCustomerID(txtPhone.Text);
                    if(CustID>0)
                    {
                        txtCustomerID.Text = CustID.ToString();
                        LoadCustomerData(CustID.ToString());
                    }
                    else
                    {
                        using (frmSearchCustomerLookup obj = new frmSearchCustomerLookup())
                        {
                            if (obj.ShowDialog() == DialogResult.OK)
                            {
                                string Rno = obj.RegisterNo;
                                txtCustomerID.Text = obj.CustomerID;
                                LoadCustomerData(obj.CustomerID);
                            }
                            else
                            {
                                clearAll();
                            }
                        };
                    }


                }

                
            }
        }

        private void txtAddress_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                txtCity.Select();
                txtCity.Focus();
            }
        }

        private void txtCity_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                cmbGender.Select();
                cmbGender.Focus();
            }
        }

        private void cmbGender_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                txtNeck.Select();
                txtNeck.Focus();
            }
        }

        private void txtNeck_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                if(txtFrontNeck.Visible)
                {
                    txtFrontNeck.Select();
                    txtFrontNeck.Focus();
                }
                else
                {
                    txtShoulder.Select();
                    txtShoulder.Focus();
                }
            }
        }

        private void txtFrontNeck_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                if (txtBackNeck.Visible)
                {
                    txtBackNeck.Select();
                    txtBackNeck.Focus();
                }
                else
                {
                    txtShoulder.Select();
                    txtShoulder.Focus();
                }
            }
        }

        private void txtBackNeck_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
               
                    txtShoulder.Select();
                    txtShoulder.Focus();
                
            }
        }

        private void txtShoulder_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
              
                txtBust.Select();
                txtBust.Focus();
                
            }
        }

        private void txtBust_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                if (txtUperBust.Visible)
                {
                    txtUperBust.Select();
                    txtUperBust.Focus();
                }
                else
                {
                    txtArmHole.Select();
                    txtArmHole.Focus();
                }
            }
        }

        private void txtUperBust_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                if (txtUnderBust.Visible)
                {
                    txtUnderBust.Select();
                    txtUnderBust.Focus();
                }
                else
                {
                    txtArmHole.Select();
                    txtArmHole.Focus();
                }
            }
        }

        private void txtUnderBust_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
              
                    txtArmHole.Select();
                    txtArmHole.Focus();
                
            }
        }

        private void txtArmHole_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {

                txtSleeve.Select();
                txtSleeve.Focus();

            }
        }

        private void txtSleeve_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {

                txtMuscle.Select();
                txtMuscle.Focus();

            }
        }

        private void txtMuscle_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {

                txtElbow.Select();
                txtElbow.Focus();

            }
        }

        private void txtElbow_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {

                txtCuff.Select();
                txtCuff.Focus();

            }

        }

        private void txtCuff_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {

                txtWaist.Select();
                txtWaist.Focus();

            }
        }

        private void txtWaist_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {

                txthip.Select();
                txthip.Focus();

            }
        }

        private void txthip_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {

                txtBottomLength.Select();
                txtBottomLength.Focus();

            }
        }

        private void txtBottomLength_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {

                txtAnkle.Select();
                txtAnkle.Focus();

            }

        }

        private void txtAnkle_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {

                txtRemarks.Select();
                txtRemarks.Focus();

            }
        }

        private void txtRemarks_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {

                dtDeliveryDate.Select();
                dtDeliveryDate.Focus();

            }
        }

        private void panel2_Paint(object sender, PaintEventArgs e)
        {

        }

        private void txtCuff_TextChanged(object sender, EventArgs e)
        {

        }

        private void label15_Click(object sender, EventArgs e)
        {

        }

        private void txtPhone_TextChanged(object sender, EventArgs e)
        {

        }

        private void label18_Click(object sender, EventArgs e)
        {

        }

        private void label21_Click(object sender, EventArgs e)
        {

        }

        private void label24_Click(object sender, EventArgs e)
        {

        }

        private void txtAnkle_TextChanged(object sender, EventArgs e)
        {

        }

        private void metroPanel1_Paint(object sender, PaintEventArgs e)
        {

        }

        private void txtWaist_TextChanged(object sender, EventArgs e)
        {

        }

        private void lblBackNeck_Click(object sender, EventArgs e)
        {

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
                SqlString += " where data_InventItemsBarcodeDetail.BarcodeNumber='" + ManualNumber + "' or data_InventItemsBarcode.SystemBarcode='" + ManualNumber + "'";
            }
            SqlDataAdapter sda = new SqlDataAdapter(SqlString, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            return dt;
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
            txtGrossAmount.Text = Convert.ToString(Math.Ceiling(sum + (-1 * TotalExchanged)));
            txtTotalTax.Text = Convert.ToString(Math.Ceiling(taxAmountTotal));
            decimal discAmount = txtDiscountAmount.Text == "" ? 0 : Convert.ToDecimal(txtDiscountAmount.Text);
            txtTotalDiscount.Text = Convert.ToString(Math.Ceiling(TotalDiscount + discAmount));
            txtExchangeAmt.Text = Convert.ToString(Math.Ceiling((-1) * TotalExchanged));
            CalculateNetTotal();
            cashCardPayments();

        }
        private void cashCardPayments()
        {
            decimal CashAmount = txtCashAmount.Text == "" ? 0 : Convert.ToDecimal(txtCashAmount.Text);
            decimal CardAmount = txtCardAmount.Text == "" ? 0 : Convert.ToDecimal(txtCardAmount.Text);
            decimal ReceivedAmount = CashAmount + CardAmount;
            txtAmountReceive.Text = Convert.ToString(Math.Round(ReceivedAmount, 2));
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
                if (OrderNo == 0)
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
                    if (UpdateOrder == false)
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
            }
            catch (Exception e)
            {
                MessageBox.Show(e.Message);
            }
        }

        private void AddProducts(string productName, int id, decimal rates, decimal taxPercentage, decimal CartonSize = 0)
        {

            string total = (Convert.ToDecimal(rates) * 1).ToString();
            string taxAmount = (((Convert.ToDecimal(taxPercentage) * Convert.ToDecimal(rates)) / 100) * 1).ToString();

            bool recordExist = false;
            if (!chkExchange.Checked)
            {
                for (int i = 0; i < ItemSaleGrid.Rows.Count; i++)
                {
                    if (id == Convert.ToInt32(ItemSaleGrid.Rows[i].Cells[0].Value.ToString()) && Convert.ToBoolean(ItemSaleGrid.Rows[i].Cells[14].Value.ToString()) == false)
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
                    Value = Value * -1;
                    txtQuantity.Text = Convert.ToString(Value);
                }
                var Rate = txtRate.Text;
                var NetAmount = Convert.ToDecimal(Value) * Convert.ToDecimal(Rate);

                //string[] row = { id.ToString(), cmbProducts.Text, txtQuantity.Text, txtStockRate.Text, NetAmount.ToString(), txtProductID.Text };
                //dgvStockInDetail.Rows.Insert(0, row);
                //ClearFields();
                txtProductID.Focus();

                string[] row = { id.ToString(), Convert.ToString(txtProductCode.Text), cmbProducts.Text, txtRate.Text.ToString(), txtQuantity.Text.ToString(), txtDtGross.Text.ToString(), txtTax.Text.ToString(), txtTaxAmount.Text.ToString(), txtPromoDisc.Text.ToString(), txtPromoDiscAmt.Text.ToString(), txtdetailAmount.Text.ToString(), txtAvailableQty.Text.ToString(), txtMinQty.Text.ToString(), Convert.ToString(txtSchemeID.Text), Convert.ToString(chkExchange.Checked) };
                ItemSaleGrid.Rows.Insert(0, row);
            }
            CalculateDetail();
            GrossAmount_Total();
            ClearFields();
            txtProductCode.Focus();
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
          
            txtTax.ReadOnly = true;
            txtTaxAmount.ReadOnly = true;
            txtdetailAmount.ReadOnly = true;
            txtRate.ReadOnly = true;
            cmbProducts.SelectedIndex = 0;
            txtDtGross.Clear();
            txtAvailableQty.Clear();
        }
        private void CalculateDetail()
        {
            for (int i = 0; i < ItemSaleGrid.Rows.Count; i++)
            {
                var isCheck = Convert.ToString(ItemSaleGrid.Rows[i].Cells[14].Value);

                var strQuantity = Convert.ToString(ItemSaleGrid.Rows[i].Cells[4].Value);
                if (string.IsNullOrEmpty(strQuantity) || strQuantity == "0")
                {
                    ItemSaleGrid.Rows[i].Cells[4].Value = "1";
                }

                int id = Convert.ToInt32(ItemSaleGrid.Rows[i].Cells[0].Value.ToString());
                DataTable dt = getProduct(0, Convert.ToInt32(id));
                var taxPercentage = Convert.ToDecimal(dt.Rows[0]["TotalTax"]);
                string rateValue = ItemSaleGrid.Rows[i].Cells[3].Value.ToString();
                string total = (Convert.ToDecimal(rateValue) * 1).ToString();
                //********** Promo Working Starts From here ***********//

                var SchemeDiscount = Convert.ToDecimal(ItemSaleGrid.Rows[i].Cells[8].Value.ToString());
                var MinSchemQuantity = Convert.ToDecimal(ItemSaleGrid.Rows[i].Cells[12].Value.ToString());
                var OrderQuantity = Convert.ToDecimal(ItemSaleGrid.Rows[i].Cells[4].Value.ToString());
                var defualtQty = 1;
                if (Convert.ToBoolean(isCheck))
                {
                    defualtQty = defualtQty * -1;
                }
                var GrossAmount = OrderQuantity * Convert.ToDecimal(rateValue);
                if (OrderQuantity * defualtQty >= MinSchemQuantity)
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
        private void setAvailableStock(int ItemId)
        {
            var Stock = STATICClass.GetStockQuantityItem(ItemId, CompanyInfo.WareHouseID, dtRegisterDate.Value, CompanyInfo.CompanyID, "", "", false);
            txtAvailableQty.Text = Convert.ToString(Stock);
        }
        private void GetRunningPromo(int ItemId)
        {
            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionStringName"].ConnectionString;
            SqlConnection cnn;
            cnn = new SqlConnection(connectionString);
            cnn.Open();
            string SqlString = " Select * from vw_khaakiPromo";
            //string whereClause = " where BookingStartDate<='"+dtRegisterDate.Value+ "' and BookingEndDate>='"+dtRegisterDate.Value+"' and WHID="+CompanyInfo.WareHouseID+" and ItemId="+ItemId+"" ;
            DateTime StartDate = Convert.ToDateTime(dtRegisterDate.Value);
            DateTime EndDate = StartDate;
            string whereClause = " where ((vw_khaakiPromo.BookingStartDate between '" + Convert.ToDateTime(StartDate) + "' and '" + Convert.ToDateTime(EndDate) + "') OR " +
                " (vw_khaakiPromo.BookingEndDate between '" + Convert.ToDateTime(StartDate) + "' and '" + Convert.ToDateTime(EndDate) + "') OR (BookingStartDate<='" + Convert.ToDateTime(StartDate) + "' and BookingEndDate >='" + Convert.ToDateTime(EndDate) + "')) and vw_khaakiPromo.WHID=" + Convert.ToInt32(CompanyInfo.WareHouseID) + " and ItemId=" + ItemId + "";
            SqlDataAdapter sda = new SqlDataAdapter(SqlString + whereClause, cnn);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            cnn.Close();
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    int SchemeID = Convert.ToInt32(dt.Rows[i]["SchemeID"]);
                    string SchemeTitle = Convert.ToString(dt.Rows[i]["PromoName"]);
                  //  lblRunningPromo.Text = SchemeTitle + "at min " + Convert.ToString(Convert.ToInt32(dt.Rows[i]["Qauntity"])) + " Quantity";
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
                      //  lblRunningPromo.Text = SchemeTitle + "at min " + Convert.ToString(Convert.ToInt32(dt.Rows[i]["Qauntity"])) + " Quantity";
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
        private void CalculateNetAmountDetail()
        {
            if (txtQuantity.Text != "" && txtRate.Text != "")
            {
                var OrderQuantity = Convert.ToDecimal(txtQuantity.Text);
                decimal MinSchemQuantity = 0;
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
                        txtPromoDiscAmt.Text = Convert.ToString(Convert.ToDecimal(txtQuantity.Text) * Convert.ToDecimal(DiscontAmountOnRate));
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
                    txtdetailAmount.Text = Convert.ToString(Math.Round(NetAmount + AmountTax, 2));
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
                                var dtReturn = getProduct(0, Convert.ToInt32(id));
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
                        txtQuantity.Text = "1";
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
            if (e.KeyData == Keys.Space)
            {
                ItemSaleGrid.Focus();
            }
            if (e.KeyCode == Keys.Escape)
            {
                txtDiscountAmount.Focus();
                //txtDiscountPercentage.Focus();
            }
        }

        private void ItemSaleGrid_CellValueChanged(object sender, DataGridViewCellEventArgs e)
        {
            CalculateDetail();
        }

        private void label13_Click_1(object sender, EventArgs e)
        {

        }

        private void dtDeliveryDate_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                cmbSalesMan.Select();
                cmbSalesMan.Focus();
            }
        }

        private void txtCashAmount_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {

                cashCardPayments();

                txtCardAmount.Focus();
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
        private void txtAmountReceive_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
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
                if (string.IsNullOrEmpty(txtAmountReceive.Text) || Convert.ToDecimal(txtAmountReceive.Text) < Convert.ToDecimal(txtReceivableAmount.Text))
                {
                    MessageBox.Show("Received Amount Can't be Less then Bill Amount...");
                    return;
                }
                else
                {
                    btnSave.Focus();
                }
            }
        }

        private void txtCardAmount_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {

                if (txtCardAmount.Text != "")
                {
                    cashCardPayments();
                    frmCreditCardDetailsMake frm = new frmCreditCardDetailsMake(this);

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

        private void ItemSaleGrid_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Delete)
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
            if (e.KeyCode == Keys.Space)
            {
                //txtDiscountPercentage.Focus();
                txtDiscountAmount.Focus();
            }
        }

        private void txtReceivableAmount_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtExchangeAmt_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtDiscountAmount_KeyDown(object sender, KeyEventArgs e)
        {
            if(e.KeyCode==Keys.Enter)
            {
                GrossAmount_Total();
                txtOtherCharges.Select();
                txtOtherCharges.Focus();
            }
        }

        private void txtOtherCharges_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                GrossAmount_Total();
                txtCashAmount.Select();
                txtCashAmount.Focus();
            }
        }

        private void cmbSalesMan_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                txtProductCode.Select();
                txtProductCode.Focus();
            }
        }

        private void label27_Click(object sender, EventArgs e)
        {

        }

        private void txtAccAmount_TextChanged(object sender, EventArgs e)
        {

        }

        private void label25_Click(object sender, EventArgs e)
        {

        }

        private void txtTotalTax_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtAmountReceive_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
