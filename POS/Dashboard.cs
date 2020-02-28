using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace POS
{
    public partial class Dashboard : Form
    {
        public Dashboard()
        {
            InitializeComponent();
        }

        private void btnCashbookReport_Click(object sender, EventArgs e)
        {
            frmCashBookReport obj = new frmCashBookReport();
            obj.Show();
        }
    }
}
