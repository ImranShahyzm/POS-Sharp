using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace POS.Model
{
    class Fbr_InvoiceDetail
    {
            public int SIDDetailID { get; set; }
            public Nullable<int> SID { get; set; }
            public string ItemCode { get; set; }
            public string ItemName { get; set; }
            public string PCTCode { get; set; }
            public decimal Quantity { get; set; }
            public decimal TaxRate { get; set; }
            public Nullable<decimal> SaleValue { get; set; }
            public Nullable<decimal> Discount { get; set; }
            public Nullable<decimal> FurtherTax { get; set; }
            public Nullable<decimal> TaxCharged { get; set; }
            public Nullable<decimal> TotalAmount { get; set; }
            public Nullable<int> InvoiceType { get; set; }
            public string RefUSIN { get; set; }
        
    }
}
