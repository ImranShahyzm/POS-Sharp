namespace POS.LookUpForms
{
    partial class frmClosingLookUp
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
            this.panel1 = new System.Windows.Forms.Panel();
            this.btnClose = new System.Windows.Forms.Button();
            this.panel2 = new System.Windows.Forms.Panel();
            this.label3 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.dgvSaleInvoices = new System.Windows.Forms.DataGridView();
            this.dptSaleToDate = new System.Windows.Forms.DateTimePicker();
            this.dtpSaleFromDate = new System.Windows.Forms.DateTimePicker();
            this.label2 = new System.Windows.Forms.Label();
            this.panel1.SuspendLayout();
            this.panel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvSaleInvoices)).BeginInit();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.Color.Gainsboro;
            this.panel1.Controls.Add(this.btnClose);
            this.panel1.Location = new System.Drawing.Point(5, 501);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(602, 62);
            this.panel1.TabIndex = 32;
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
            // panel2
            // 
            this.panel2.BackColor = System.Drawing.Color.Teal;
            this.panel2.Controls.Add(this.label3);
            this.panel2.Location = new System.Drawing.Point(0, 2);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(606, 52);
            this.panel2.TabIndex = 31;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Calibri", 18F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.ForeColor = System.Drawing.SystemColors.Control;
            this.label3.Location = new System.Drawing.Point(4, 13);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(192, 29);
            this.label3.TabIndex = 0;
            this.label3.Text = "Cash Transcations";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(31, 94);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(63, 14);
            this.label1.TabIndex = 30;
            this.label1.Text = "Date From:";
            // 
            // dgvSaleInvoices
            // 
            this.dgvSaleInvoices.AllowUserToAddRows = false;
            this.dgvSaleInvoices.AllowUserToDeleteRows = false;
            this.dgvSaleInvoices.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvSaleInvoices.Location = new System.Drawing.Point(34, 131);
            this.dgvSaleInvoices.Name = "dgvSaleInvoices";
            this.dgvSaleInvoices.ReadOnly = true;
            this.dgvSaleInvoices.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvSaleInvoices.Size = new System.Drawing.Size(544, 339);
            this.dgvSaleInvoices.TabIndex = 27;
            this.dgvSaleInvoices.CellContentDoubleClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvSaleInvoices_CellContentDoubleClick);
            // 
            // dptSaleToDate
            // 
            this.dptSaleToDate.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dptSaleToDate.Location = new System.Drawing.Point(342, 88);
            this.dptSaleToDate.Name = "dptSaleToDate";
            this.dptSaleToDate.Size = new System.Drawing.Size(153, 20);
            this.dptSaleToDate.TabIndex = 34;
            // 
            // dtpSaleFromDate
            // 
            this.dtpSaleFromDate.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpSaleFromDate.Location = new System.Drawing.Point(120, 88);
            this.dtpSaleFromDate.Name = "dtpSaleFromDate";
            this.dtpSaleFromDate.Size = new System.Drawing.Size(153, 20);
            this.dtpSaleFromDate.TabIndex = 33;
            this.dtpSaleFromDate.ValueChanged += new System.EventHandler(this.dtpSaleFromDate_ValueChanged);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(288, 94);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(48, 14);
            this.label2.TabIndex = 35;
            this.label2.Text = "Date To:";
            this.label2.Visible = false;
            // 
            // frmClosingLookUp
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(610, 564);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.dptSaleToDate);
            this.Controls.Add(this.dtpSaleFromDate);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.panel2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.dgvSaleInvoices);
            this.Name = "frmClosingLookUp";
            this.Text = "frmClosingLookUp";
            this.Load += new System.EventHandler(this.frmClosingLookUp_Load);
            this.panel1.ResumeLayout(false);
            this.panel2.ResumeLayout(false);
            this.panel2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvSaleInvoices)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Button btnClose;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DataGridView dgvSaleInvoices;
        private System.Windows.Forms.DateTimePicker dptSaleToDate;
        private System.Windows.Forms.DateTimePicker dtpSaleFromDate;
        private System.Windows.Forms.Label label2;
    }
}