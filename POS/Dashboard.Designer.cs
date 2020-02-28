namespace POS
{
    partial class Dashboard
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
            this.panel2 = new System.Windows.Forms.Panel();
            this.label3 = new System.Windows.Forms.Label();
            this.panel1 = new System.Windows.Forms.Panel();
            this.btnClose = new System.Windows.Forms.Button();
            this.btnCashbookReport = new System.Windows.Forms.Button();
            this.panel2.SuspendLayout();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // panel2
            // 
            this.panel2.BackColor = System.Drawing.Color.Teal;
            this.panel2.Controls.Add(this.label3);
            this.panel2.Location = new System.Drawing.Point(0, 0);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(783, 52);
            this.panel2.TabIndex = 26;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Calibri", 18F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.ForeColor = System.Drawing.SystemColors.Control;
            this.label3.Location = new System.Drawing.Point(4, 13);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(123, 29);
            this.label3.TabIndex = 0;
            this.label3.Text = "Dashboard";
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.Color.Gainsboro;
            this.panel1.Controls.Add(this.btnClose);
            this.panel1.Location = new System.Drawing.Point(0, 498);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(783, 62);
            this.panel1.TabIndex = 27;
            // 
            // btnClose
            // 
            this.btnClose.BackColor = System.Drawing.Color.RoyalBlue;
            this.btnClose.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClose.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnClose.ForeColor = System.Drawing.SystemColors.ButtonFace;
            this.btnClose.Location = new System.Drawing.Point(25, 19);
            this.btnClose.Name = "btnClose";
            this.btnClose.Size = new System.Drawing.Size(115, 31);
            this.btnClose.TabIndex = 23;
            this.btnClose.Text = "Close";
            this.btnClose.UseVisualStyleBackColor = false;
            // 
            // btnCashbookReport
            // 
            this.btnCashbookReport.BackColor = System.Drawing.Color.RoyalBlue;
            this.btnCashbookReport.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnCashbookReport.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnCashbookReport.ForeColor = System.Drawing.SystemColors.ButtonFace;
            this.btnCashbookReport.Location = new System.Drawing.Point(61, 124);
            this.btnCashbookReport.Name = "btnCashbookReport";
            this.btnCashbookReport.Size = new System.Drawing.Size(115, 31);
            this.btnCashbookReport.TabIndex = 28;
            this.btnCashbookReport.Text = "Cash Book Report";
            this.btnCashbookReport.UseVisualStyleBackColor = false;
            this.btnCashbookReport.Click += new System.EventHandler(this.btnCashbookReport_Click);
            // 
            // Dashboard
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(784, 561);
            this.Controls.Add(this.btnCashbookReport);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.panel2);
            this.Name = "Dashboard";
            this.Text = "Corbis Solution";
            this.panel2.ResumeLayout(false);
            this.panel2.PerformLayout();
            this.panel1.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Button btnClose;
        private System.Windows.Forms.Button btnCashbookReport;
    }
}