using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace POS.Helper
{
    public class RightsClass 
    {
        public bool EditMode { get; set; }
        public Int32? TransferToShedId { get; set; }
        public bool ViewMode;
        public bool CopyMode;
        public string SchemeStyle { get; set; }
        public bool ErrorLoad;
        public bool Isedit { get; set; }
        public bool Isdelete { get; set; }
        public bool IsPrint { get; set; }
        public bool IsNew { get; set; }
        public bool Assign { get; set; }
        public string UserName { get; set; }
        public bool IsStockToShed { get; set; }
        public bool ActivateShedTransfer { get; set; }
        public Int32 UserID { get; set; }

        public bool Type { get; set; }
        public int FiscalID { get; set; }
        public int CompanyID { get; set; }
        public string IPAddress { get; set; }
        public string GroupLevelName { get; set; }
        public string CategoryLevelName { get; set; }
        public bool GroupLevelAllowed { get; set; }

        public bool CategoryLevelAllowed { get; set; }
        public Int32? GroupLevelID { get; set; }
        public Int32? CategoryLevelID { get; set; }
        public Int32? WHID { get; set; }
        public string Zone { get; set; }
        public string Station { get; set; }
        public string Sector { get; set; }
        public bool ShowSubPartySale { get; set; }
        public string StartYear { get; set; }
        public string EndYear { get; set; }
        public bool AccountPosting { get; set; }

        public string ErrorMsg;

        public bool IsTaxable { get; set; }

        public string TaxMode { get; set; }
        public string BranchIDs { get; set; }
        public int? BranchID { get; set; }
        public bool HideGlCode { get; set; }
        public Int32? TransporterID { get; set; }
        public int vType { get; set; }
        public string VouchersTypes { get; set; }
        public bool IsAutoAttendance { get; set; }
        public string Remarks { get; set; }
        public string OutKm { get; set; }

        public bool SuppressCorbisTag { get; set; }
        public bool ApiConnection { get; set; }

        public int TechnicianID { get; set; }
        public int SaleManId { get; set; }
        public bool SMSEnable { get; set; }
        public bool EmailEnable { get; set; }
        public decimal PaidByCustomer { get; set; }
        public decimal PaidByInsurance { get; set; }
        public bool SaleInvoicePosting { get; set; }

        public bool isMisplSoftware { get; set; }
        public bool AddNewCompany { get; set; }
        public decimal NetAmount { get; set; }
        public int SchemeAvailed { get; set; }
        public bool isAddresswithGL { get; set; }
        public decimal SelectedQuantity { get; set; }

        public bool isApprovalActivated { get; set; }

        public string VouchersApprovalUsers { get; set; }
        public bool ShowVoucherPosting { get; set; }
        public bool StockMainAtInward { get; set; }
        public int EggsIncubatorSoft { get; set; }

        public bool isLayerSoft { get; set; }
        public bool isVouchersDaily { get; set; }
        public bool isStoreWiseRights { get; set; }
        public string WHIDs { get; set; }
        public bool isShedLedgerActive { get; set; }
        public enum MianFields
        {
            UserName,
            UserID,
            Type,
            FiscalID,
            CompanyID,
            IPAddress,
            GroupLevelID,
            CategoryLevelID,
            IsTaxable,
            BranchID,
            EntryUserID,
            RegisrationDate
        }

    }
}