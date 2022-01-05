namespace POS
{
    partial class frmStockReport
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
            this.btnPreview = new System.Windows.Forms.Button();
            this.panel1 = new System.Windows.Forms.Panel();
            this.label1 = new System.Windows.Forms.Label();
            this.dtpSaleFromDate = new System.Windows.Forms.DateTimePicker();
            this.label2 = new System.Windows.Forms.Label();
            this.dtpSaleToDate = new System.Windows.Forms.DateTimePicker();
            this.cmbCategory = new System.Windows.Forms.ComboBox();
            this.dtRegisterDate = new System.Windows.Forms.DateTimePicker();
            this.dtRegisterTo = new System.Windows.Forms.DateTimePicker();
            this.chkArticlesFilter = new System.Windows.Forms.CheckBox();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // btnPreview
            // 
            this.btnPreview.BackColor = System.Drawing.Color.RoyalBlue;
            this.btnPreview.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnPreview.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnPreview.ForeColor = System.Drawing.SystemColors.ButtonFace;
            this.btnPreview.Location = new System.Drawing.Point(258, 12);
            this.btnPreview.Name = "btnPreview";
            this.btnPreview.Size = new System.Drawing.Size(115, 31);
            this.btnPreview.TabIndex = 21;
            this.btnPreview.Text = "Preview";
            this.btnPreview.UseVisualStyleBackColor = false;
            this.btnPreview.Click += new System.EventHandler(this.btnPreview_Click);
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.Color.Gainsboro;
            this.panel1.Controls.Add(this.btnPreview);
            this.panel1.Location = new System.Drawing.Point(-68, 229);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(646, 54);
            this.panel1.TabIndex = 23;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(86, 173);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(86, 19);
            this.label1.TabIndex = 26;
            this.label1.Text = "Date From:";
            this.label1.Visible = false;
            // 
            // dtpSaleFromDate
            // 
            this.dtpSaleFromDate.CustomFormat = "dd-MMM-yyyy";
            this.dtpSaleFromDate.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dtpSaleFromDate.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtpSaleFromDate.Location = new System.Drawing.Point(90, 173);
            this.dtpSaleFromDate.Name = "dtpSaleFromDate";
            this.dtpSaleFromDate.Size = new System.Drawing.Size(215, 26);
            this.dtpSaleFromDate.TabIndex = 25;
            this.dtpSaleFromDate.Visible = false;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Times New Roman", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(92, 95);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(80, 22);
            this.label2.TabIndex = 28;
            this.label2.Text = "Date To:";
            this.label2.Click += new System.EventHandler(this.label2_Click);
            // 
            // dtpSaleToDate
            // 
            this.dtpSaleToDate.CustomFormat = "dd-MMM-yyyy";
            this.dtpSaleToDate.Font = new System.Drawing.Font("Times New Roman", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dtpSaleToDate.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtpSaleToDate.Location = new System.Drawing.Point(90, 120);
            this.dtpSaleToDate.Name = "dtpSaleToDate";
            this.dtpSaleToDate.Size = new System.Drawing.Size(215, 29);
            this.dtpSaleToDate.TabIndex = 27;
            this.dtpSaleToDate.ValueChanged += new System.EventHandler(this.dtpSaleToDate_ValueChanged);
            // 
            // cmbCategory
            // 
            this.cmbCategory.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.SuggestAppend;
            this.cmbCategory.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cmbCategory.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbCategory.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbCategory.FormattingEnabled = true;
            this.cmbCategory.ItemHeight = 20;
            this.cmbCategory.Items.AddRange(new object[] {
            "select Product"});
            this.cmbCategory.Location = new System.Drawing.Point(90, 171);
            this.cmbCategory.Name = "cmbCategory";
            this.cmbCategory.Size = new System.Drawing.Size(215, 28);
            this.cmbCategory.TabIndex = 31;
            this.cmbCategory.Visible = false;
            // 
            // dtRegisterDate
            // 
            this.dtRegisterDate.CustomFormat = "dd-MMM-yyyy";
            this.dtRegisterDate.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dtRegisterDate.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtRegisterDate.Location = new System.Drawing.Point(41, 167);
            this.dtRegisterDate.Name = "dtRegisterDate";
            this.dtRegisterDate.Size = new System.Drawing.Size(215, 26);
            this.dtRegisterDate.TabIndex = 33;
            this.dtRegisterDate.Visible = false;
            // 
            // dtRegisterTo
            // 
            this.dtRegisterTo.CustomFormat = "dd-MMM-yyyy";
            this.dtRegisterTo.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dtRegisterTo.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtRegisterTo.Location = new System.Drawing.Point(90, 167);
            this.dtRegisterTo.Name = "dtRegisterTo";
            this.dtRegisterTo.Size = new System.Drawing.Size(215, 26);
            this.dtRegisterTo.TabIndex = 35;
            this.dtRegisterTo.Visible = false;
            // 
            // chkArticlesFilter
            // 
            this.chkArticlesFilter.AutoSize = true;
            this.chkArticlesFilter.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chkArticlesFilter.Location = new System.Drawing.Point(115, 199);
            this.chkArticlesFilter.Name = "chkArticlesFilter";
            this.chkArticlesFilter.Size = new System.Drawing.Size(214, 18);
            this.chkArticlesFilter.TabIndex = 37;
            this.chkArticlesFilter.Text = "Apply Artilces Register Date Filters";
            this.chkArticlesFilter.UseVisualStyleBackColor = true;
            this.chkArticlesFilter.Visible = false;
            this.chkArticlesFilter.CheckedChanged += new System.EventHandler(this.chkArticlesFilter_CheckedChanged);
            // 
            // frmStockReport
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(366, 304);
            this.Controls.Add(this.chkArticlesFilter);
            this.Controls.Add(this.dtRegisterTo);
            this.Controls.Add(this.dtRegisterDate);
            this.Controls.Add(this.cmbCategory);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.dtpSaleToDate);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.dtpSaleFromDate);
            this.Controls.Add(this.panel1);
            this.Name = "frmStockReport";
            this.Text = "Stock Report";
            this.Load += new System.EventHandler(this.frmStockReport_Load);
            this.panel1.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.Button btnPreview;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DateTimePicker dtpSaleFromDate;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.DateTimePicker dtpSaleToDate;
        private System.Windows.Forms.ComboBox cmbCategory;
        private System.Windows.Forms.DateTimePicker dtRegisterDate;
        private System.Windows.Forms.DateTimePicker dtRegisterTo;
        private System.Windows.Forms.CheckBox chkArticlesFilter;
    }
}