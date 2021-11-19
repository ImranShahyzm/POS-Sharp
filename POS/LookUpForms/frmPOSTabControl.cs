using MetroFramework.Forms;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace POS.LookUpForms
{
    public partial class frmPOSTabControl : MetroForm
    {
        public frmPOSTabControl()
        {

            try
            {
                InitializeComponent();
                POSChSweets frm = new POSChSweets();
                tabPos.Controls[0].Text = "Default Bill";
                frm.TopLevel = false;
                frm.BillNoCount = 1;
                tabPage1.Controls.Add(frm);
                frm.Dock = DockStyle.Fill;
                frm.Show();
             
               
                frm.Select();
                frm.Focus();
            }
            catch(Exception e)
            {
                var a = e.Message;
            }
        }
        private void LoadNewInstance()
        {
            int Length = tabPos.TabCount;
            if(Length>=0)
            {
            
                TabPage tab = new TabPage();
                POSChSweets frm = new POSChSweets();
                frm.BillNoCount = Length;
                tab.Text = "Default Bill # "+Convert.ToString(Length++);
                frm.TopLevel = false;
                tabPos.TabPages.Add(tab);
                tab.Controls.Add(frm);
                tabPos.SelectedTab = tab;
                frm.Dock = DockStyle.Fill;
                frm.Show();
               
                tab.Select();
                tab.Focus();
                frm.Select();
                frm.Focus();
            }
        }
        protected override bool ProcessCmdKey(ref Message msg, Keys keyData)
        {
         if (keyData == (Keys.Control | Keys.Up))
            {

                LoadNewInstance();

                return true;
            }
           else if (keyData == (Keys.F6))
            {

                if (tabPos.SelectedIndex != 0)
                {
                    tabPos.SelectedTab.Dispose();
                }
                return true;
            }
            else if (keyData == (Keys.Control | Keys.Right))
            {

                
                    var SelectedIdx = tabPos.SelectedIndex;
                    SelectedIdx++;
                    if (tabPos.TabCount-1 >= SelectedIdx)
                    {
                        tabPos.SelectTab(SelectedIdx);
                        //tabPos.TabPages[SelectedIdx].Focus();
                 
                   
                    }
                
                return true;
            }
            else if (keyData == (Keys.Control | Keys.Left))
            {

                
                    var SelectedIdx = tabPos.SelectedIndex;
                    SelectedIdx--;
                    if (SelectedIdx >= 0)
                    {
                        
                    tabPos.SelectTab(SelectedIdx);
                   // tabPos.SelectTab(SelectedIdx);
                    //tabPos.TabPages[SelectedIdx].Focus();
                }
                
                return true;
            }





            return base.ProcessCmdKey(ref msg, keyData);
    }
}
}
