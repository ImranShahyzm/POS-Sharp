using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace POS.Model
{
    class Fbr_InvoiceMaster
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
        
    }
}
