namespace POS.LookUpForms
{
    partial class StockInDetailKhaakiForm
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
            this.panelMain = new MetroFramework.Controls.MetroPanel();
            this.btnSave = new System.Windows.Forms.Button();
            this.RefIDHidd = new System.Windows.Forms.Label();
            this.txtRefID = new System.Windows.Forms.TextBox();
            this.dgvStockDetailData = new System.Windows.Forms.DataGridView();
            this.txtArrivalNo = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.txtArrivalDate = new System.Windows.Forms.DateTimePicker();
            this.panelMain.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvStockDetailData)).BeginInit();
            this.SuspendLayout();
            // 
            // panelMain
            // 
            this.panelMain.Controls.Add(this.btnSave);
            this.panelMain.Controls.Add(this.RefIDHidd);
            this.panelMain.Controls.Add(this.txtRefID);
            this.panelMain.Controls.Add(this.dgvStockDetailData);
            this.panelMain.Controls.Add(this.txtArrivalNo);
            this.panelMain.Controls.Add(this.label2);
            this.panelMain.Controls.Add(this.label1);
            this.panelMain.Controls.Add(this.txtArrivalDate);
            this.panelMain.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.panelMain.HorizontalScrollbarBarColor = true;
            this.panelMain.HorizontalScrollbarHighlightOnWheel = false;
            this.panelMain.HorizontalScrollbarSize = 10;
            this.panelMain.Location = new System.Drawing.Point(23, 63);
            this.panelMain.Name = "panelMain";
            this.panelMain.Size = new System.Drawing.Size(781, 469);
            this.panelMain.TabIndex = 0;
            this.panelMain.VerticalScrollbarBarColor = true;
            this.panelMain.VerticalScrollbarHighlightOnWheel = false;
            this.panelMain.VerticalScrollbarSize = 10;
            // 
            // btnSave
            // 
            this.btnSave.Location = new System.Drawing.Point(675, 426);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(75, 31);
            this.btnSave.TabIndex = 10;
            this.btnSave.Text = "SAVE";
            this.btnSave.UseVisualStyleBackColor = true;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // RefIDHidd
            // 
            this.RefIDHidd.AutoSize = true;
            this.RefIDHidd.Location = new System.Drawing.Point(610, 27);
            this.RefIDHidd.Name = "RefIDHidd";
            this.RefIDHidd.Size = new System.Drawing.Size(52, 19);
            this.RefIDHidd.TabIndex = 9;
            this.RefIDHidd.Text = "RefID";
            this.RefIDHidd.Visible = false;
            // 
            // txtRefID
            // 
            this.txtRefID.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtRefID.Location = new System.Drawing.Point(696, 24);
            this.txtRefID.Name = "txtRefID";
            this.txtRefID.Size = new System.Drawing.Size(49, 22);
            this.txtRefID.TabIndex = 8;
            this.txtRefID.Visible = false;
            // 
            // dgvStockDetailData
            // 
            this.dgvStockDetailData.AllowUserToAddRows = false;
            this.dgvStockDetailData.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvStockDetailData.Location = new System.Drawing.Point(44, 125);
            this.dgvStockDetailData.Name = "dgvStockDetailData";
            this.dgvStockDetailData.Size = new System.Drawing.Size(692, 295);
            this.dgvStockDetailData.TabIndex = 7;
            this.dgvStockDetailData.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvStockDetailData_CellClick);
            this.dgvStockDetailData.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvStockDetailData_CellContentClick);
            this.dgvStockDetailData.CellValidated += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgvStockDetailData_CellValidated);
            this.dgvStockDetailData.CellValidating += new System.Windows.Forms.DataGridViewCellValidatingEventHandler(this.dgvStockDetailData_CellValidating);
            this.dgvStockDetailData.EditingControlShowing += new System.Windows.Forms.DataGridViewEditingControlShowingEventHandler(this.dgvStockDetailData_EditingControlShowing);
            this.dgvStockDetailData.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.dgvStockDetailData_KeyPress);
            // 
            // txtArrivalNo
            // 
            this.txtArrivalNo.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtArrivalNo.Location = new System.Drawing.Point(142, 49);
            this.txtArrivalNo.Name = "txtArrivalNo";
            this.txtArrivalNo.Size = new System.Drawing.Size(116, 22);
            this.txtArrivalNo.TabIndex = 6;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(23, 49);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(80, 19);
            this.label2.TabIndex = 5;
            this.label2.Text = "Arrival No";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(10, 21);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(93, 19);
            this.label1.TabIndex = 4;
            this.label1.Text = "Arrival Date";
            // 
            // txtArrivalDate
            // 
            this.txtArrivalDate.CalendarFont = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtArrivalDate.CustomFormat = "dd-MMM-yyyy";
            this.txtArrivalDate.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtArrivalDate.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.txtArrivalDate.Location = new System.Drawing.Point(142, 21);
            this.txtArrivalDate.Name = "txtArrivalDate";
            this.txtArrivalDate.Size = new System.Drawing.Size(116, 22);
            this.txtArrivalDate.TabIndex = 3;
            // 
            // StockInDetailKhaakiForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(827, 555);
            this.Controls.Add(this.panelMain);
            this.Name = "StockInDetailKhaakiForm";
            this.Text = "Stock Arrival Detail";
            this.panelMain.ResumeLayout(false);
            this.panelMain.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvStockDetailData)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private MetroFramework.Controls.MetroPanel panelMain;
        private System.Windows.Forms.DateTimePicker txtArrivalDate;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txtArrivalNo;
        private System.Windows.Forms.DataGridView dgvStockDetailData;
        private System.Windows.Forms.Label RefIDHidd;
        private System.Windows.Forms.TextBox txtRefID;
        private System.Windows.Forms.Button btnSave;
    }
}