using Common;
using DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class StockArrivalBLL
    {
        StockArrivalDAL objDAL = new StockArrivalDAL();
        public DataTable GetArrivalData(int BranchID,int WHID)
        {
            try
            {
                return objDAL.GetAllPendingArrival(BranchID, WHID);
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

    }
}
