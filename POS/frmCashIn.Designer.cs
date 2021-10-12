namespace POS
{
    partial class frmCashIn
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
            this.txtCashInAmount = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.btnClear = new System.Windows.Forms.Button();
            this.btnSave = new System.Windows.Forms.Button();
            this.panel1 = new System.Windows.Forms.Panel();
            this.cmbCashType = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            this.dtCashDate = new System.Windows.Forms.DateTimePicker();
            this.label1 = new System.Windows.Forms.Label();
            this.txtRemarks = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.cmbShiftName = new System.Windows.Forms.ComboBox();
            this.lblStartShift = new System.Windows.Forms.Label();
            this.lblShift = new System.Windows.Forms.Label();
            this.btnShiftStart = new System.Windows.Forms.Button();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // txtCashInAmount
            // 
            this.txtCashInAmount.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtCashInAmount.Location = new System.Drawing.Point(153, 141);
            this.txtCashInAmount.MaxLength = 10;
            this.txtCashInAmount.Name = "txtCashInAmount";
            this.txtCashInAmount.Size = new System.Drawing.Size(274, 22);
            this.txtCashInAmount.TabIndex = 18;
            this.txtCashInAmount.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtCashInAmount_KeyDown);
            this.txtCashInAmount.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtCashInAmount_KeyPress);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(77, 142);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(65, 17);
            this.label2.TabIndex = 20;
            this.label2.Text = "Amount:";
            // 
            // btnClear
            // 
            this.btnClear.BackColor = System.Drawing.Color.RoyalBlue;
            this.btnClear.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClear.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnClear.ForeColor = System.Drawing.SystemColors.ButtonFace;
            this.btnClear.Location = new System.Drawing.Point(408, 21);
            this.btnClear.Name = "btnClear";
            this.btnClear.Size = new System.Drawing.Size(115, 31);
            this.btnClear.TabIndex = 22;
            this.btnClear.Text = "Clear (ALT+C)";
            this.btnClear.UseVisualStyleBackColor = false;
            this.btnClear.Click += new System.EventHandler(this.btnClear_Click);
            // 
            // btnSave
            // 
            this.btnSave.BackColor = System.Drawing.Color.RoyalBlue;
            this.btnSave.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnSave.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnSave.ForeColor = System.Drawing.SystemColors.ButtonFace;
            this.btnSave.Location = new System.Drawing.Point(287, 21);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(115, 31);
            this.btnSave.TabIndex = 21;
            this.btnSave.Text = "Save (ALT+S)";
            this.btnSave.UseVisualStyleBackColor = false;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.Color.Gainsboro;
            this.panel1.Controls.Add(this.btnClear);
            this.panel1.Controls.Add(this.btnSave);
            this.panel1.Location = new System.Drawing.Point(-13, 276);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(557, 62);
            this.panel1.TabIndex = 23;
            // 
            // cmbCashType
            // 
            this.cmbCashType.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbCashType.FormattingEnabled = true;
            this.cmbCashType.Location = new System.Drawing.Point(153, 109);
            this.cmbCashType.Name = "cmbCashType";
            this.cmbCashType.Size = new System.Drawing.Size(213, 23);
            this.cmbCashType.TabIndex = 25;
            this.cmbCashType.KeyDown += new System.Windows.Forms.KeyEventHandler(this.cmbCashType_KeyDown);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(60, 110);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(82, 17);
            this.label4.TabIndex = 26;
            this.label4.Text = "Cash Type:";
            // 
            // dtCashDate
            // 
            this.dtCashDate.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dtCashDate.Location = new System.Drawing.Point(153, 83);
            this.dtCashDate.Name = "dtCashDate";
            this.dtCashDate.Size = new System.Drawing.Size(213, 22);
            this.dtCashDate.TabIndex = 27;
            this.dtCashDate.KeyDown += new System.Windows.Forms.KeyEventHandler(this.dtCashDate_KeyDown);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(98, 83);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(44, 17);
            this.label1.TabIndex = 28;
            this.label1.Text = "Date:";
            // 
            // txtRemarks
            // 
            this.txtRemarks.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtRemarks.Location = new System.Drawing.Point(153, 169);
            this.txtRemarks.Multiline = true;
            this.txtRemarks.Name = "txtRemarks";
            this.txtRemarks.Size = new System.Drawing.Size(274, 55);
            this.txtRemarks.TabIndex = 33;
            this.txtRemarks.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtRemarks_KeyDown);
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.Location = new System.Drawing.Point(69, 170);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(73, 17);
            this.label6.TabIndex = 32;
            this.label6.Text = "Remarks:";
            // 
            // cmbShiftName
            // 
            this.cmbShiftName.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbShiftName.FormattingEnabled = true;
            this.cmbShiftName.Location = new System.Drawing.Point(153, 230);
            this.cmbShiftName.Name = "cmbShiftName";
            this.cmbShiftName.Size = new System.Drawing.Size(95, 23);
            this.cmbShiftName.TabIndex = 34;
            this.cmbShiftName.Visible = false;
            // 
            // lblStartShift
            // 
            this.lblStartShift.AutoSize = true;
            this.lblStartShift.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblStartShift.Location = new System.Drawing.Point(69, 231);
            this.lblStartShift.Name = "lblStartShift";
            this.lblStartShift.Size = new System.Drawing.Size(77, 17);
            this.lblStartShift.TabIndex = 35;
            this.lblStartShift.Text = "Start Shift:";
            this.lblStartShift.Visible = false;
            // 
            // lblShift
            // 
            this.lblShift.AutoSize = true;
            this.lblShift.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblShift.ForeColor = System.Drawing.Color.Red;
            this.lblShift.Location = new System.Drawing.Point(204, 31);
            this.lblShift.Name = "lblShift";
            this.lblShift.Size = new System.Drawing.Size(162, 17);
            this.lblShift.TabIndex = 36;
            this.lblShift.Text = "Default Shift is Running";
            this.lblShift.Visible = false;
            // 
            // btnShiftStart
            // 
            this.btnShiftStart.BackColor = System.Drawing.Color.RoyalBlue;
            this.btnShiftStart.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnShiftStart.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnShiftStart.ForeColor = System.Drawing.SystemColors.ButtonFace;
            this.btnShiftStart.Location = new System.Drawing.Point(251, 230);
            this.btnShiftStart.Name = "btnShiftStart";
            this.btnShiftStart.Size = new System.Drawing.Size(54, 25);
            this.btnShiftStart.TabIndex = 37;
            this.btnShiftStart.Text = "Start";
            this.btnShiftStart.UseVisualStyleBackColor = false;
            this.btnShiftStart.Click += new System.EventHandler(this.btnShiftStart_Click);
            // 
            // frmCashIn
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(533, 361);
            this.Controls.Add(this.btnShiftStart);
            this.Controls.Add(this.lblShift);
            this.Controls.Add(this.lblStartShift);
            this.Controls.Add(this.cmbShiftName);
            this.Controls.Add(this.txtRemarks);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.dtCashDate);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.cmbCashType);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.txtCashInAmount);
            this.Name = "frmCashIn";
            this.Text = "Cash Receipt";
            this.Load += new System.EventHandler(this.frmCashIn_Load);
            this.panel1.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.TextBox txtCashInAmount;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button btnClear;
        private System.Windows.Forms.Button btnSave;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.ComboBox cmbCashType;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.DateTimePicker dtCashDate;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtRemarks;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.ComboBox cmbShiftName;
        private System.Windows.Forms.Label lblStartShift;
        private System.Windows.Forms.Label lblShift;
        private System.Windows.Forms.Button btnShiftStart;
    }
}