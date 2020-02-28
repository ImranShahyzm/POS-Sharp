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
    public class LogInBLL
    {
    LoginDAL objDAL = new LoginDAL();
        public DataTable checkLoginBLL(LogInCommon obj)
        {
            try
            {
                return objDAL.SaveForm(obj);
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

    }
}
