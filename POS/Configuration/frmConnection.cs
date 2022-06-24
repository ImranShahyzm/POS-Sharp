using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;
using POS.Helper;
using Common;

namespace POS
{
    public partial class frmConnection : MetroFramework.Forms.MetroForm
    {
        public frmConnection()
        {
            InitializeComponent();

            txtServer.Text = (POS.Properties.Settings.Default["Server"]).ToString();
            txtDatabase.Text = (POS.Properties.Settings.Default["Database"]).ToString();
            txtID.Text = (POS.Properties.Settings.Default["ID"]).ToString();
            txtPassword.Text = (POS.Properties.Settings.Default["Password"]).ToString();
           
        }

        private void Header_Click(object sender, EventArgs e)
        {

        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                POS.Properties.Settings.Default["Server"] = Convert.ToString(txtServer.Text);
                POS.Properties.Settings.Default["Database"] = Convert.ToString(txtDatabase.Text);
                POS.Properties.Settings.Default["ID"] = Convert.ToString(txtID.Text);
                POS.Properties.Settings.Default["Password"] = Convert.ToString(txtPassword.Text);
                POS.Properties.Settings.Default.Save();
               
               createConnection(Convert.ToString(txtServer.Text), Convert.ToString(txtDatabase.Text),
                    Convert.ToString(txtID.Text), Convert.ToString(txtPassword.Text));
                STATICClass.SetConnectionString();
                CommonClass.ConnectionString = STATICClass.Connection();
                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "Error",
                MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
           

        }
        public void createConnection(string Server, string Database, string ID, string Password)
        {
            Properties.Settings.Default["Server"] = Server;
            Properties.Settings.Default["Database"] = Database;
            Properties.Settings.Default["ID"] = ID;
            Properties.Settings.Default["Password"] = Password;
            Properties.Settings.Default.Save();
        }

        private void txtDatabase_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtID_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtPassword_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
