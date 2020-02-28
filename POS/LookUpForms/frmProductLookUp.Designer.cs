namespace POS.LookUpForms
{
    partial class frmProductLookUp
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
            this.dgvProducts = new System.Windows.Forms.DataGridView();
            this.txtProductSearch = new System.Windows.Forms.TextBox();
            this.label11 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.dgvProducts)).BeginInit();
            this.SuspendLayout();
            // 
            // dgvProducts
            // 
            this.dgvProducts.AllowUserToAddRows = false;
            this.dgvProducts.AllowUserToDeleteRows = false;
            this.dgvProducts.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvProducts.Location = new System.Drawing.Point(26, 65);
            this.dgvProducts.Name = "dgvProducts";
            this.dgvProducts.ReadOnly = true;
            this.dgvProducts.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvProducts.Size = new System.Drawing.Size(387, 291);
            this.dgvProducts.TabIndex = 0;
            this.dgvProducts.CellDoubleClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvProducts_CellDoubleClick);
            this.dgvProducts.DoubleClick += new System.EventHandler(this.dgvProducts_DoubleClick);
            this.dgvProducts.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.dgvProducts_KeyPress);
            // 
            // txtProductSearch
            // 
            this.txtProductSearch.Location = new System.Drawing.Point(226, 28);
            this.txtProductSearch.Name = "txtProductSearch";
            this.txtProductSearch.Size = new System.Drawing.Size(123, 20);
            this.txtProductSearch.TabIndex = 1;
            this.txtProductSearch.TextChanged += new System.EventHandler(this.txtProductSearch_TextChanged);
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label11.Location = new System.Drawing.Point(78, 31);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(142, 14);
            this.label11.TabIndex = 6;
            this.label11.Text = "Search By Manual Number:";
            // 
            // frmProductLookUp
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(434, 368);
            this.Controls.Add(this.label11);
            this.Controls.Add(this.txtProductSearch);
            this.Controls.Add(this.dgvProducts);
            this.Name = "frmProductLookUp";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Product LookUp";
            this.Load += new System.EventHandler(this.frmProductLookUp_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvProducts)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dgvProducts;
        private System.Windows.Forms.TextBox txtProductSearch;
        private System.Windows.Forms.Label label11;
    }
}