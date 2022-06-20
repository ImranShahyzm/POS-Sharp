namespace POS.LookUpForms
{
    partial class frmIMEILookUp
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
            this.dgvIMEIs = new System.Windows.Forms.DataGridView();
            this.txtIMEISearch = new System.Windows.Forms.TextBox();
            this.label11 = new System.Windows.Forms.Label();
            this.lblHeading = new System.Windows.Forms.Label();
            this.lblItemNameDisplay = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.dgvIMEIs)).BeginInit();
            this.SuspendLayout();
            // 
            // dgvIMEIs
            // 
            this.dgvIMEIs.AllowUserToAddRows = false;
            this.dgvIMEIs.AllowUserToDeleteRows = false;
            this.dgvIMEIs.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvIMEIs.Location = new System.Drawing.Point(26, 96);
            this.dgvIMEIs.Name = "dgvIMEIs";
            this.dgvIMEIs.ReadOnly = true;
            this.dgvIMEIs.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvIMEIs.Size = new System.Drawing.Size(445, 289);
            this.dgvIMEIs.TabIndex = 0;
            this.dgvIMEIs.CellDoubleClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvIMEIs_CellDoubleClick);
            this.dgvIMEIs.DoubleClick += new System.EventHandler(this.dgvIMEIs_DoubleClick);
            this.dgvIMEIs.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.dgvIMEIs_KeyPress);
            // 
            // txtIMEISearch
            // 
            this.txtIMEISearch.Location = new System.Drawing.Point(248, 68);
            this.txtIMEISearch.Name = "txtIMEISearch";
            this.txtIMEISearch.Size = new System.Drawing.Size(223, 20);
            this.txtIMEISearch.TabIndex = 1;
            this.txtIMEISearch.TextChanged += new System.EventHandler(this.txtIMEISearch_TextChanged);
            this.txtIMEISearch.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtIMEISearch_KeyDown);
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label11.Location = new System.Drawing.Point(151, 71);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(94, 14);
            this.label11.TabIndex = 6;
            this.label11.Text = "Search Item IMEI:";
            // 
            // lblHeading
            // 
            this.lblHeading.AutoSize = true;
            this.lblHeading.Font = new System.Drawing.Font("Cambria", 20.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblHeading.ForeColor = System.Drawing.Color.DarkRed;
            this.lblHeading.Location = new System.Drawing.Point(20, 9);
            this.lblHeading.Name = "lblHeading";
            this.lblHeading.Size = new System.Drawing.Size(342, 32);
            this.lblHeading.TabIndex = 15;
            this.lblHeading.Text = "Please Select IMEI Number";
            // 
            // lblItemNameDisplay
            // 
            this.lblItemNameDisplay.AutoSize = true;
            this.lblItemNameDisplay.Font = new System.Drawing.Font("Cambria", 14F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblItemNameDisplay.ForeColor = System.Drawing.Color.DarkRed;
            this.lblItemNameDisplay.Location = new System.Drawing.Point(26, 45);
            this.lblItemNameDisplay.Name = "lblItemNameDisplay";
            this.lblItemNameDisplay.Size = new System.Drawing.Size(81, 22);
            this.lblItemNameDisplay.TabIndex = 16;
            this.lblItemNameDisplay.Text = "for Item";
            // 
            // frmIMEILookUp
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(496, 397);
            this.Controls.Add(this.lblItemNameDisplay);
            this.Controls.Add(this.lblHeading);
            this.Controls.Add(this.label11);
            this.Controls.Add(this.txtIMEISearch);
            this.Controls.Add(this.dgvIMEIs);
            this.Name = "frmIMEILookUp";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "IMEI LookUp";
            this.Load += new System.EventHandler(this.frmIMEILookUp_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgvIMEIs)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView dgvIMEIs;
        private System.Windows.Forms.TextBox txtIMEISearch;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.Label lblHeading;
        private System.Windows.Forms.Label lblItemNameDisplay;
    }
}