namespace POS.LookUpForms
{
    partial class frmManualStockIN
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
            this.btnDelete = new System.Windows.Forms.Button();
            this.btnSearch = new System.Windows.Forms.Button();
            this.txtArrivalID = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.txtArrivalDate = new System.Windows.Forms.DateTimePicker();
            this.txtRemarks = new System.Windows.Forms.TextBox();
            this.txtVehicleNo = new System.Windows.Forms.TextBox();
            this.txtManualNo = new System.Windows.Forms.TextBox();
            this.txtSerielNo = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.txtStockInNo = new System.Windows.Forms.Label();
            this.txtProductID = new System.Windows.Forms.TextBox();
            this.txtQuantity = new System.Windows.Forms.TextBox();
            this.txtStockRate = new System.Windows.Forms.TextBox();
            this.txtNetAmount = new System.Windows.Forms.TextBox();
            this.panel2 = new System.Windows.Forms.Panel();
            this.dgvStockInDetail = new System.Windows.Forms.DataGridView();
            this.ItemID = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Itemname = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Quantity = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Rate = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.NetAmount = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ManualNo = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.cmbProducts = new System.Windows.Forms.ComboBox();
            this.txtItemID = new System.Windows.Forms.TextBox();
            this.btnCancel = new System.Windows.Forms.Button();
            this.btnSave = new System.Windows.Forms.Button();
            this.btnClear = new System.Windows.Forms.Button();
            this.panel1.SuspendLayout();
            this.panel2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvStockInDetail)).BeginInit();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel1.Controls.Add(this.btnDelete);
            this.panel1.Controls.Add(this.btnSearch);
            this.panel1.Controls.Add(this.txtArrivalID);
            this.panel1.Controls.Add(this.label4);
            this.panel1.Controls.Add(this.txtArrivalDate);
            this.panel1.Controls.Add(this.txtRemarks);
            this.panel1.Controls.Add(this.txtVehicleNo);
            this.panel1.Controls.Add(this.txtManualNo);
            this.panel1.Controls.Add(this.txtSerielNo);
            this.panel1.Controls.Add(this.label3);
            this.panel1.Controls.Add(this.label2);
            this.panel1.Controls.Add(this.label1);
            this.panel1.Controls.Add(this.txtStockInNo);
            this.panel1.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.panel1.Location = new System.Drawing.Point(23, 81);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(918, 81);
            this.panel1.TabIndex = 0;
            this.panel1.Paint += new System.Windows.Forms.PaintEventHandler(this.panel1_Paint);
            // 
            // btnDelete
            // 
            this.btnDelete.BackColor = System.Drawing.Color.Red;
            this.btnDelete.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.btnDelete.Location = new System.Drawing.Point(806, 15);
            this.btnDelete.Name = "btnDelete";
            this.btnDelete.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.btnDelete.Size = new System.Drawing.Size(75, 28);
            this.btnDelete.TabIndex = 13;
            this.btnDelete.Text = "Delete";
            this.btnDelete.UseVisualStyleBackColor = false;
            this.btnDelete.Visible = false;
            this.btnDelete.Click += new System.EventHandler(this.btnDelete_Click);
            // 
            // btnSearch
            // 
            this.btnSearch.BackColor = System.Drawing.Color.Teal;
            this.btnSearch.ForeColor = System.Drawing.SystemColors.Control;
            this.btnSearch.Location = new System.Drawing.Point(806, 14);
            this.btnSearch.Name = "btnSearch";
            this.btnSearch.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.btnSearch.Size = new System.Drawing.Size(75, 28);
            this.btnSearch.TabIndex = 13;
            this.btnSearch.Text = "Search";
            this.btnSearch.UseVisualStyleBackColor = false;
            this.btnSearch.Click += new System.EventHandler(this.btnSearch_Click);
            // 
            // txtArrivalID
            // 
            this.txtArrivalID.Location = new System.Drawing.Point(195, 14);
            this.txtArrivalID.Name = "txtArrivalID";
            this.txtArrivalID.ReadOnly = true;
            this.txtArrivalID.Size = new System.Drawing.Size(100, 25);
            this.txtArrivalID.TabIndex = 9;
            this.txtArrivalID.Visible = false;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(511, 17);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(39, 17);
            this.label4.TabIndex = 8;
            this.label4.Text = "Date";
            // 
            // txtArrivalDate
            // 
            this.txtArrivalDate.CalendarFont = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtArrivalDate.CustomFormat = "dd-MMM-yyyy";
            this.txtArrivalDate.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtArrivalDate.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.txtArrivalDate.Location = new System.Drawing.Point(556, 13);
            this.txtArrivalDate.Name = "txtArrivalDate";
            this.txtArrivalDate.Size = new System.Drawing.Size(116, 22);
            this.txtArrivalDate.TabIndex = 2;
            this.txtArrivalDate.ValueChanged += new System.EventHandler(this.txtArrivalDate_ValueChanged);
            this.txtArrivalDate.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtArrivalDate_KeyDown);
            // 
            // txtRemarks
            // 
            this.txtRemarks.Location = new System.Drawing.Point(393, 44);
            this.txtRemarks.Name = "txtRemarks";
            this.txtRemarks.Size = new System.Drawing.Size(488, 25);
            this.txtRemarks.TabIndex = 4;
            this.txtRemarks.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtRemarks_KeyDown);
            // 
            // txtVehicleNo
            // 
            this.txtVehicleNo.Location = new System.Drawing.Point(393, 14);
            this.txtVehicleNo.Name = "txtVehicleNo";
            this.txtVehicleNo.Size = new System.Drawing.Size(100, 25);
            this.txtVehicleNo.TabIndex = 1;
            this.txtVehicleNo.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtVehicleNo_KeyDown);
            // 
            // txtManualNo
            // 
            this.txtManualNo.Location = new System.Drawing.Point(89, 44);
            this.txtManualNo.Name = "txtManualNo";
            this.txtManualNo.Size = new System.Drawing.Size(100, 25);
            this.txtManualNo.TabIndex = 3;
            this.txtManualNo.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtManualNo_KeyDown);
            // 
            // txtSerielNo
            // 
            this.txtSerielNo.Location = new System.Drawing.Point(89, 14);
            this.txtSerielNo.Name = "txtSerielNo";
            this.txtSerielNo.ReadOnly = true;
            this.txtSerielNo.Size = new System.Drawing.Size(100, 25);
            this.txtSerielNo.TabIndex = 0;
            this.txtSerielNo.TabStop = false;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(325, 44);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(68, 17);
            this.label3.TabIndex = 3;
            this.label3.Text = "Remarks";
            this.label3.Click += new System.EventHandler(this.label3_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(315, 17);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(79, 17);
            this.label2.TabIndex = 2;
            this.label2.Text = "Vehicle No";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(4, 44);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(80, 17);
            this.label1.TabIndex = 1;
            this.label1.Text = "Manual No";
            // 
            // txtStockInNo
            // 
            this.txtStockInNo.AutoSize = true;
            this.txtStockInNo.Location = new System.Drawing.Point(13, 17);
            this.txtStockInNo.Name = "txtStockInNo";
            this.txtStockInNo.Size = new System.Drawing.Size(69, 17);
            this.txtStockInNo.TabIndex = 0;
            this.txtStockInNo.Text = "Seriel No";
            // 
            // txtProductID
            // 
            this.txtProductID.Location = new System.Drawing.Point(113, 168);
            this.txtProductID.Name = "txtProductID";
            this.txtProductID.Size = new System.Drawing.Size(100, 20);
            this.txtProductID.TabIndex = 5;
            this.txtProductID.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtProductID_KeyDown);
            // 
            // txtQuantity
            // 
            this.txtQuantity.Location = new System.Drawing.Point(810, 168);
            this.txtQuantity.Name = "txtQuantity";
            this.txtQuantity.Size = new System.Drawing.Size(95, 20);
            this.txtQuantity.TabIndex = 6;
            this.txtQuantity.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtQuantity_KeyDown);
            this.txtQuantity.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtQuantity_KeyPress);
            // 
            // txtStockRate
            // 
            this.txtStockRate.Location = new System.Drawing.Point(700, 168);
            this.txtStockRate.Name = "txtStockRate";
            this.txtStockRate.Size = new System.Drawing.Size(99, 20);
            this.txtStockRate.TabIndex = 7;
            this.txtStockRate.Visible = false;
            this.txtStockRate.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtStockRate_KeyDown);
            this.txtStockRate.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtStockRate_KeyPress);
            // 
            // txtNetAmount
            // 
            this.txtNetAmount.Location = new System.Drawing.Point(805, 168);
            this.txtNetAmount.Name = "txtNetAmount";
            this.txtNetAmount.ReadOnly = true;
            this.txtNetAmount.Size = new System.Drawing.Size(100, 20);
            this.txtNetAmount.TabIndex = 8;
            this.txtNetAmount.Visible = false;
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.dgvStockInDetail);
            this.panel2.Location = new System.Drawing.Point(24, 194);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(917, 357);
            this.panel2.TabIndex = 9;
            // 
            // dgvStockInDetail
            // 
            this.dgvStockInDetail.AllowUserToAddRows = false;
            this.dgvStockInDetail.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvStockInDetail.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.ItemID,
            this.Itemname,
            this.Quantity,
            this.Rate,
            this.NetAmount,
            this.ManualNo});
            this.dgvStockInDetail.Location = new System.Drawing.Point(89, 12);
            this.dgvStockInDetail.Name = "dgvStockInDetail";
            this.dgvStockInDetail.ReadOnly = true;
            this.dgvStockInDetail.Size = new System.Drawing.Size(792, 329);
            this.dgvStockInDetail.TabIndex = 0;
            this.dgvStockInDetail.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvStockInDetail_CellClick);
            // 
            // ItemID
            // 
            this.ItemID.HeaderText = "Product ID";
            this.ItemID.Name = "ItemID";
            this.ItemID.ReadOnly = true;
            this.ItemID.Width = 50;
            // 
            // Itemname
            // 
            this.Itemname.HeaderText = "ProductName";
            this.Itemname.Name = "Itemname";
            this.Itemname.ReadOnly = true;
            this.Itemname.Width = 600;
            // 
            // Quantity
            // 
            this.Quantity.HeaderText = "Quantity";
            this.Quantity.Name = "Quantity";
            this.Quantity.ReadOnly = true;
            // 
            // Rate
            // 
            this.Rate.HeaderText = "Stock Rate";
            this.Rate.Name = "Rate";
            this.Rate.ReadOnly = true;
            this.Rate.Visible = false;
            // 
            // NetAmount
            // 
            this.NetAmount.HeaderText = "Net Amount";
            this.NetAmount.Name = "NetAmount";
            this.NetAmount.ReadOnly = true;
            this.NetAmount.Visible = false;
            // 
            // ManualNo
            // 
            this.ManualNo.HeaderText = "Manual No";
            this.ManualNo.Name = "ManualNo";
            this.ManualNo.ReadOnly = true;
            this.ManualNo.Visible = false;
            // 
            // cmbProducts
            // 
            this.cmbProducts.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.SuggestAppend;
            this.cmbProducts.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cmbProducts.FormattingEnabled = true;
            this.cmbProducts.Items.AddRange(new object[] {
            "select Product"});
            this.cmbProducts.Location = new System.Drawing.Point(219, 167);
            this.cmbProducts.Name = "cmbProducts";
            this.cmbProducts.Size = new System.Drawing.Size(579, 21);
            this.cmbProducts.TabIndex = 7;
            // 
            // txtItemID
            // 
            this.txtItemID.Location = new System.Drawing.Point(23, 168);
            this.txtItemID.Name = "txtItemID";
            this.txtItemID.Size = new System.Drawing.Size(84, 20);
            this.txtItemID.TabIndex = 10;
            this.txtItemID.Visible = false;
            // 
            // btnCancel
            // 
            this.btnCancel.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            this.btnCancel.Location = new System.Drawing.Point(830, 557);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.btnCancel.Size = new System.Drawing.Size(75, 28);
            this.btnCancel.TabIndex = 1;
            this.btnCancel.Text = "Cancel";
            this.btnCancel.UseVisualStyleBackColor = false;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // btnSave
            // 
            this.btnSave.BackColor = System.Drawing.Color.DarkGreen;
            this.btnSave.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.btnSave.Location = new System.Drawing.Point(749, 557);
            this.btnSave.Name = "btnSave";
            this.btnSave.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.btnSave.Size = new System.Drawing.Size(75, 28);
            this.btnSave.TabIndex = 11;
            this.btnSave.Text = "Save";
            this.btnSave.UseVisualStyleBackColor = false;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // btnClear
            // 
            this.btnClear.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(192)))), ((int)(((byte)(192)))));
            this.btnClear.Location = new System.Drawing.Point(911, 163);
            this.btnClear.Name = "btnClear";
            this.btnClear.RightToLeft = System.Windows.Forms.RightToLeft.Yes;
            this.btnClear.Size = new System.Drawing.Size(29, 28);
            this.btnClear.TabIndex = 12;
            this.btnClear.Text = "X";
            this.btnClear.UseVisualStyleBackColor = false;
            this.btnClear.Click += new System.EventHandler(this.btnClear_Click);
            // 
            // frmManualStockIN
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(964, 594);
            this.Controls.Add(this.btnClear);
            this.Controls.Add(this.btnSave);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.txtItemID);
            this.Controls.Add(this.cmbProducts);
            this.Controls.Add(this.panel2);
            this.Controls.Add(this.txtNetAmount);
            this.Controls.Add(this.txtStockRate);
            this.Controls.Add(this.txtQuantity);
            this.Controls.Add(this.txtProductID);
            this.Controls.Add(this.panel1);
            this.Name = "frmManualStockIN";
            this.Text = "Manual Stock In";
            this.Load += new System.EventHandler(this.frmManualStockIN_Load);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgvStockInDetail)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Label txtStockInNo;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox txtVehicleNo;
        private System.Windows.Forms.TextBox txtManualNo;
        private System.Windows.Forms.TextBox txtSerielNo;
        private System.Windows.Forms.TextBox txtRemarks;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.DateTimePicker txtArrivalDate;
        private System.Windows.Forms.TextBox txtProductID;
        private System.Windows.Forms.TextBox txtQuantity;
        private System.Windows.Forms.TextBox txtStockRate;
        private System.Windows.Forms.TextBox txtNetAmount;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.DataGridView dgvStockInDetail;
        private System.Windows.Forms.ComboBox cmbProducts;
        private System.Windows.Forms.TextBox txtItemID;
        private System.Windows.Forms.Button btnCancel;
        private System.Windows.Forms.Button btnSave;
        private System.Windows.Forms.Button btnClear;
        private System.Windows.Forms.TextBox txtArrivalID;
        private System.Windows.Forms.Button btnSearch;
        private System.Windows.Forms.Button btnDelete;
        private System.Windows.Forms.DataGridViewTextBoxColumn ItemID;
        private System.Windows.Forms.DataGridViewTextBoxColumn Itemname;
        private System.Windows.Forms.DataGridViewTextBoxColumn Quantity;
        private System.Windows.Forms.DataGridViewTextBoxColumn Rate;
        private System.Windows.Forms.DataGridViewTextBoxColumn NetAmount;
        private System.Windows.Forms.DataGridViewTextBoxColumn ManualNo;
    }
}