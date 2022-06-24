using POS.Helper;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ZXing;

namespace POS.Model
{
    public class Fbr_InvoiceMaster
    {

        public int SID { get; set; }
        public int SalePOSID { get; set; }
        public string InvoiceNumber { get; set; }
        public long POSID { get; set; }
        public string USIN { get; set; }
        public string RefUSIN { get; set; }
        public System.DateTime DateTime { get; set; }
        public string BuyerName { get; set; }
        public string BuyerNTN { get; set; }
        public string BuyerCNIC { get; set; }
        public string BuyerPhoneNumber { get; set; }
        public decimal TotalSaleValue { get; set; }
        public decimal TotalTaxCharged { get; set; }
        public decimal TotalQuantity { get; set; }
        public Nullable<decimal> Discount { get; set; }
        public Nullable<decimal> FurtherTax { get; set; }
        public decimal TotalBillAmount { get; set; }
        public int PaymentMode { get; set; }
        public Nullable<int> InvoiceType { get; set; }
        public Nullable<bool> isSynced { get; set; }
        public string FBRInvoiceNumber { get; set; }
        public Nullable<int> CreatedBy { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public Nullable<int> CounterID { get; set; }
        public Nullable<int> CompanyID { get; set; }
        public Nullable<int> WHID { get; set; }
        public List<Fbr_InvoiceDetail> Items { get; set; }

        public string ErrorMsg { get; set; }
        public string imagePath { get; set; }
        public enum Fbr_InvoiceMasterStoredProcedures
        {
            Fbr_InvoiceMaster_Insert


        }
        public enum Fbr_InvoiceMasterFields
        {
             SalePOSID
           , InvoiceNumber
           , POSID
           , USIN
           , RefUSIN
           , DateTime
           , BuyerName
           , BuyerNTN
           , BuyerCNIC
           , BuyerPhoneNumber
           , TotalSaleValue
           , TotalTaxCharged
           , TotalQuantity
           , Discount
           , FurtherTax
           , TotalBillAmount
           , PaymentMode
           , InvoiceType
           , isSynced
           , FBRInvoiceNumber
           , CreatedBy
           , CreatedDate
           , CounterID
           , CompanyID
           , WHID
           , SaleSerielNo
           , SID
                , imagePath

        }

        public DataTable ToDataTable<T>(List<T> items)
        {
            DataTable dataTable = new DataTable(typeof(T).Name);
            //Get all the properties
            PropertyInfo[] Props = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance);
            foreach (PropertyInfo prop in Props)
            {
                //Setting column names as Property names
                dataTable.Columns.Add(prop.Name);
            }
            foreach (T item in items)
            {
                var values = new object[Props.Length];
                for (int i = 0; i < Props.Length; i++)
                {
                    //inserting property values to datatable rows
                    values[i] = Props[i].GetValue(item, null);
                }
                dataTable.Rows.Add(values);
            }
            //put a breakpoint here and check datatable
            return dataTable;
        }
        public string GenerateQRCode(string qrcodeText, Fbr_InvoiceMaster a)
        {
            string folderPath = "~/QrImages/";
            string imagePath = "~/QrImages/QrCode" + Convert.ToString(a.SalePOSID) + ".jpg";
            // If the directory doesn't exist then create it.
            if (!Directory.Exists(Path.Combine(Application.StartupPath, folderPath)))
            {
                Directory.CreateDirectory(Path.Combine(Application.StartupPath, folderPath));
            }

            var barcodeWriter = new BarcodeWriter();
            barcodeWriter.Format = BarcodeFormat.QR_CODE;
            var result = barcodeWriter.Write(a.InvoiceNumber);

            string barcodePath = Path.Combine(Application.StartupPath, imagePath);
            var barcodeBitmap = new Bitmap(result);
            using (MemoryStream memory = new MemoryStream())
            {
                using (FileStream fs = new FileStream(barcodePath, FileMode.Create, FileAccess.ReadWrite))
                {
                    barcodeBitmap.Save(memory, ImageFormat.Jpeg);
                    byte[] bytes = memory.ToArray();
                    fs.Write(bytes, 0, bytes.Length);
                }
            }
            return barcodePath;
        }
        public bool Insert(Fbr_InvoiceMaster a)
        {
          

            DataTable dt = new DataTable();
            var connectionString = STATICClass.Connection();
            SqlConnection con = new SqlConnection(connectionString);
            SqlTransaction tran;
            con.Open();
            tran = con.BeginTransaction();
            SqlCommand cmd = new SqlCommand(Fbr_InvoiceMasterStoredProcedures.Fbr_InvoiceMaster_Insert.ToString(), con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter();
            SqlParameter p = new SqlParameter(Fbr_InvoiceMasterFields.SID.ToString(), a.SID);
            p.Direction = ParameterDirection.InputOutput; cmd.Parameters.Add(p);
         
            
            cmd.Parameters.Add(new SqlParameter(Fbr_InvoiceMasterFields.SalePOSID.ToString()       ,a.SalePOSID));
            cmd.Parameters.Add(new SqlParameter(Fbr_InvoiceMasterFields.InvoiceNumber.ToString(), a.InvoiceNumber));
            cmd.Parameters.Add(new SqlParameter(Fbr_InvoiceMasterFields.POSID.ToString(), a.POSID));
            cmd.Parameters.Add(new SqlParameter(Fbr_InvoiceMasterFields.USIN.ToString(), a.USIN));
            cmd.Parameters.Add(new SqlParameter(Fbr_InvoiceMasterFields.RefUSIN.ToString(), a.RefUSIN));
            cmd.Parameters.Add(new SqlParameter(Fbr_InvoiceMasterFields.DateTime.ToString(), a.DateTime));
            cmd.Parameters.Add(new SqlParameter(Fbr_InvoiceMasterFields.BuyerName.ToString(), a.BuyerName));
            cmd.Parameters.Add(new SqlParameter(Fbr_InvoiceMasterFields.BuyerNTN.ToString(), a.BuyerNTN));
            cmd.Parameters.Add(new SqlParameter(Fbr_InvoiceMasterFields.BuyerCNIC.ToString(), a.BuyerCNIC));
            cmd.Parameters.Add(new SqlParameter(Fbr_InvoiceMasterFields.BuyerPhoneNumber.ToString(), a.BuyerPhoneNumber));
            cmd.Parameters.Add(new SqlParameter(Fbr_InvoiceMasterFields.TotalSaleValue.ToString(), a.TotalSaleValue));
            cmd.Parameters.Add(new SqlParameter(Fbr_InvoiceMasterFields.TotalTaxCharged.ToString(), a.TotalTaxCharged ));
            cmd.Parameters.Add(new SqlParameter(Fbr_InvoiceMasterFields.TotalQuantity.ToString(), a.TotalQuantity));
            cmd.Parameters.Add(new SqlParameter(Fbr_InvoiceMasterFields.Discount.ToString(), a.Discount));
            cmd.Parameters.Add(new SqlParameter(Fbr_InvoiceMasterFields.FurtherTax.ToString(), a.FurtherTax));
            cmd.Parameters.Add(new SqlParameter(Fbr_InvoiceMasterFields.TotalBillAmount.ToString(), a.TotalBillAmount ));
            cmd.Parameters.Add(new SqlParameter(Fbr_InvoiceMasterFields.PaymentMode.ToString(), a.PaymentMode));
            cmd.Parameters.Add(new SqlParameter(Fbr_InvoiceMasterFields.InvoiceType.ToString(), a.InvoiceType));
            cmd.Parameters.Add(new SqlParameter(Fbr_InvoiceMasterFields.isSynced.ToString(), a.isSynced));
            cmd.Parameters.Add(new SqlParameter(Fbr_InvoiceMasterFields.FBRInvoiceNumber.ToString(), a.FBRInvoiceNumber));
            cmd.Parameters.Add(new SqlParameter(Fbr_InvoiceMasterFields.CreatedBy.ToString(), CompanyInfo.UserID));
            cmd.Parameters.Add(new SqlParameter(Fbr_InvoiceMasterFields.CreatedDate.ToString(), System.DateTime.Now));
            cmd.Parameters.Add(new SqlParameter(Fbr_InvoiceMasterFields.CounterID.ToString(), CompanyInfo.CounterID));
            cmd.Parameters.Add(new SqlParameter(Fbr_InvoiceMasterFields.CompanyID.ToString(), CompanyInfo.CompanyID));
            cmd.Parameters.Add(new SqlParameter(Fbr_InvoiceMasterFields.WHID.ToString(), CompanyInfo.WareHouseID));
            cmd.Parameters.Add(new SqlParameter(Fbr_InvoiceMasterFields.imagePath.ToString(), a.imagePath));

            cmd.Parameters.Add(new SqlParameter("@Fbr_InvoiceDetail", a.ToDataTable<Fbr_InvoiceDetail>(a.Items)));
            da.SelectCommand = cmd;
            try
            {
                cmd.Transaction = tran; da.Fill(dt); tran.Commit();
                a.SID = Convert.ToInt32(p.Value.ToString());
            }
            catch (Exception ex)
            {
                tran.Rollback();
                a.ErrorMsg = ex.Message;
                return false;
            }
            finally
            {
                con.Close();
            }

            return true;

        }

    }
}
