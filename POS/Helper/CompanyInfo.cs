﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace POS.Helper
{
   public static class CompanyInfo
    {
        //public static int CompanyID = 1;
        //public static int WareHouseID = 1;
        //public static int FiscalID = 1;
        //public static int UserID = 1;
        public static int CompanyID { get; set; }
        public static int WareHouseID { get; set; }
        public static int FiscalID { get; set; }
        public static int UserID { get; set; }
        public static string username { get; set; }
        public static int BranchID { get; set; }
        public static string WareHouseName { get; set; }
        public static string LocationID { get; set; }
        public static bool isPrinter = true;
        public static bool isKhaakiSoft = true;
        public static int ShopUserType { get; set; }

    }
}
