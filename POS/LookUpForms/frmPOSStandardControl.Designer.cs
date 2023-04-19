namespace POS.LookUpForms
{
    partial class frmPOSStandardControl
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.tabPage1 = new System.Windows.Forms.TabPage();
            this.tabPos = new System.Windows.Forms.TabControl();
            this.tabPos.SuspendLayout();
            this.SuspendLayout();
            // 
            // tabPage1
            // 
            this.tabPage1.Location = new System.Drawing.Point(4, 22);
            this.tabPage1.Name = "tabPage1";
            this.tabPage1.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage1.Size = new System.Drawing.Size(1106, 689);
            this.tabPage1.TabIndex = 0;
            this.tabPage1.Text = "tabPage1";
            this.tabPage1.UseVisualStyleBackColor = true;
            // 
            // tabPos
            // 
            this.tabPos.Controls.Add(this.tabPage1);
            this.tabPos.Location = new System.Drawing.Point(23, 17);
            this.tabPos.Name = "tabPos";
            this.tabPos.SelectedIndex = 0;
            this.tabPos.Size = new System.Drawing.Size(1114, 715);
            this.tabPos.TabIndex = 0;
            // 
            // frmPOSStandardControl
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1160, 755);
            this.Controls.Add(this.tabPos);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "frmPOSStandardControl";
            this.Style = MetroFramework.MetroColorStyle.Black;
            this.tabPos.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TabPage tabPage1;
        private System.Windows.Forms.TabControl tabPos;
    }
}