namespace POS.LookUpForms
{
    partial class frmSearchCustomerLookup
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
            this.dgvSaleInvoices = new System.Windows.Forms.DataGridView();
            this.label11 = new System.Windows.Forms.Label();
            this.txtPhoneSearch = new System.Windows.Forms.TextBox();
            this.btnClose = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dgvSaleInvoices)).BeginInit();
            this.SuspendLayout();
            // 
            // dgvSaleInvoices
            // 
            this.dgvSaleInvoices.AllowUserToAddRows = false;
            this.dgvSaleInvoices.AllowUserToDeleteRows = false;
            this.dgvSaleInvoices.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvSaleInvoices.Location = new System.Drawing.Point(25, 126);
            this.dgvSaleInvoices.Name = "dgvSaleInvoices";
            this.dgvSaleInvoices.ReadOnly = true;
            this.dgvSaleInvoices.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvSaleInvoices.Size = new System.Drawing.Size(624, 339);
            this.dgvSaleInvoices.TabIndex = 0;
            this.dgvSaleInvoices.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvSaleInvoices_CellClick);
            this.dgvSaleInvoices.KeyDown += new System.Windows.Forms.KeyEventHandler(this.dgvSaleInvoices_KeyDown);
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label11.Location = new System.Drawing.Point(411, 100);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(109, 14);
            this.label11.TabIndex = 8;
            this.label11.Text = "Search By Phone No:";
            // 
            // txtPhoneSearch
            // 
            this.txtPhoneSearch.Location = new System.Drawing.Point(526, 100);
            this.txtPhoneSearch.Name = "txtPhoneSearch";
            this.txtPhoneSearch.Size = new System.Drawing.Size(123, 20);
            this.txtPhoneSearch.TabIndex = 7;
            this.txtPhoneSearch.TextChanged += new System.EventHandler(this.txtProductSearch_TextChanged);
            this.txtPhoneSearch.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtPhoneSearch_KeyDown);
            // 
            // btnClose
            // 
            this.btnClose.BackColor = System.Drawing.Color.RoyalBlue;
            this.btnClose.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClose.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnClose.ForeColor = System.Drawing.SystemColors.ButtonFace;
            this.btnClose.Location = new System.Drawing.Point(534, 467);
            this.btnClose.Name = "btnClose";
            this.btnClose.Size = new System.Drawing.Size(115, 31);
            this.btnClose.TabIndex = 29;
            this.btnClose.Text = "Close";
            this.btnClose.UseVisualStyleBackColor = false;
            this.btnClose.Click += new System.EventHandler(this.btnClose_Click);
            // 
            // frmSearchCustomerLookup
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(776, 521);
            this.Controls.Add(this.btnClose);
            this.Controls.Add(this.label11);
            this.Controls.Add(this.txtPhoneSearch);
            this.Controls.Add(this.dgvSaleInvoices);
            this.Name = "frmSearchCustomerLookup";
            this.Text = "Search Existing Customer Data";
            this.Load += new System.EventHandler(this.frmSearchCustomerLookup_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvSaleInvoices)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dgvSaleInvoices;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.TextBox txtPhoneSearch;
        private System.Windows.Forms.Button btnClose;
    }
}