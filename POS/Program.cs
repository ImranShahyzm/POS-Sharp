using Common;
using DAL;
using POS.Helper;
using POS.LookUpForms;
using POS.Report;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace POS
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            try
            {
                if(String.IsNullOrEmpty(CommonClass.ConnectionString))
                {
                    CommonClass.ConnectionString = STATICClass.Connection();
                }
                if (new LoginDAL().CheckIfBarcodePrinterExe() == 1)
                {
                    Application.Run(new frmOnScreenBarcodePrint());
                }
                else
                {

                    Application.Run(new frmLogIn());

                }
            }
            catch (Exception e)
            {
                MessageBox.Show(e.Message);
            }
        
}
    }
}
