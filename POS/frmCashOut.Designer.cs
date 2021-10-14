namespace POS
{
    partial class frmCashOut
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
            this.txtCashOutAmount = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.btnClear = new System.Windows.Forms.Button();
            this.btnSave = new System.Windows.Forms.Button();
            this.panel1 = new System.Windows.Forms.Panel();
            this.button1 = new System.Windows.Forms.Button();
            this.cmbCashType = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            this.lblAvaliableBalance = new System.Windows.Forms.Label();
            this.dtCashDate = new System.Windows.Forms.DateTimePicker();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.txtRemarks = new System.Windows.Forms.TextBox();
            this.lblShift = new System.Windows.Forms.Label();
            this.btnShiftStart = new System.Windows.Forms.Button();
            this.btnGenerateClosing = new System.Windows.Forms.Button();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // txtCashOutAmount
            // 
            this.txtCashOutAmount.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtCashOutAmount.Location = new System.Drawing.Point(137, 144);
            this.txtCashOutAmount.MaxLength = 10;
            this.txtCashOutAmount.Name = "txtCashOutAmount";
            this.txtCashOutAmount.Size = new System.Drawing.Size(274, 22);
            this.txtCashOutAmount.TabIndex = 18;
            this.txtCashOutAmount.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtCashOutAmount_KeyDown);
            this.txtCashOutAmount.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtCashOutAmount_KeyPress);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(152, 92);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(129, 17);
            this.label1.TabIndex = 19;
            this.label1.Text = "Available Balance:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(61, 144);
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
            this.btnClear.Location = new System.Drawing.Point(300, 20);
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
            this.btnSave.Location = new System.Drawing.Point(179, 21);
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
            this.panel1.Controls.Add(this.btnGenerateClosing);
            this.panel1.Controls.Add(this.button1);
            this.panel1.Controls.Add(this.btnClear);
            this.panel1.Controls.Add(this.btnSave);
            this.panel1.Location = new System.Drawing.Point(-38, 276);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(610, 62);
            this.panel1.TabIndex = 23;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(421, 20);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(84, 32);
            this.button1.TabIndex = 30;
            this.button1.Text = "Trans List";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // cmbCashType
            // 
            this.cmbCashType.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbCashType.FormattingEnabled = true;
            this.cmbCashType.Location = new System.Drawing.Point(137, 115);
            this.cmbCashType.Name = "cmbCashType";
            this.cmbCashType.Size = new System.Drawing.Size(274, 23);
            this.cmbCashType.TabIndex = 25;
            this.cmbCashType.KeyDown += new System.Windows.Forms.KeyEventHandler(this.cmbCashType_KeyDown);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(44, 115);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(82, 17);
            this.label4.TabIndex = 26;
            this.label4.Text = "Cash Type:";
            // 
            // lblAvaliableBalance
            // 
            this.lblAvaliableBalance.AutoSize = true;
            this.lblAvaliableBalance.Font = new System.Drawing.Font("Calibri", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblAvaliableBalance.Location = new System.Drawing.Point(287, 89);
            this.lblAvaliableBalance.Name = "lblAvaliableBalance";
            this.lblAvaliableBalance.Size = new System.Drawing.Size(15, 23);
            this.lblAvaliableBalance.TabIndex = 27;
            this.lblAvaliableBalance.Text = ".";
            // 
            // dtCashDate
            // 
            this.dtCashDate.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dtCashDate.Location = new System.Drawing.Point(137, 233);
            this.dtCashDate.Name = "dtCashDate";
            this.dtCashDate.Size = new System.Drawing.Size(274, 22);
            this.dtCashDate.TabIndex = 28;
            this.dtCashDate.ValueChanged += new System.EventHandler(this.dtCashDate_ValueChanged);
            this.dtCashDate.KeyDown += new System.Windows.Forms.KeyEventHandler(this.dtCashDate_KeyDown);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(82, 233);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(44, 17);
            this.label5.TabIndex = 29;
            this.label5.Text = "Date:";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.Location = new System.Drawing.Point(53, 171);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(73, 17);
            this.label6.TabIndex = 30;
            this.label6.Text = "Remarks:";
            // 
            // txtRemarks
            // 
            this.txtRemarks.Font = new System.Drawing.Font("Microsoft Sans Serif", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtRemarks.Location = new System.Drawing.Point(137, 172);
            this.txtRemarks.Multiline = true;
            this.txtRemarks.Name = "txtRemarks";
            this.txtRemarks.Size = new System.Drawing.Size(274, 55);
            this.txtRemarks.TabIndex = 31;
            this.txtRemarks.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtRemarks_KeyDown);
            // 
            // lblShift
            // 
            this.lblShift.AutoSize = true;
            this.lblShift.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblShift.ForeColor = System.Drawing.Color.Red;
            this.lblShift.Location = new System.Drawing.Point(152, 72);
            this.lblShift.Name = "lblShift";
            this.lblShift.Size = new System.Drawing.Size(162, 17);
            this.lblShift.TabIndex = 37;
            this.lblShift.Text = "Default Shift is Running";
            this.lblShift.Visible = false;
            // 
            // btnShiftStart
            // 
            this.btnShiftStart.BackColor = System.Drawing.Color.RoyalBlue;
            this.btnShiftStart.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnShiftStart.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnShiftStart.ForeColor = System.Drawing.SystemColors.ButtonFace;
            this.btnShiftStart.Location = new System.Drawing.Point(323, 69);
            this.btnShiftStart.Name = "btnShiftStart";
            this.btnShiftStart.Size = new System.Drawing.Size(54, 25);
            this.btnShiftStart.TabIndex = 38;
            this.btnShiftStart.Text = "Close";
            this.btnShiftStart.UseVisualStyleBackColor = false;
            this.btnShiftStart.Click += new System.EventHandler(this.btnShiftStart_Click);
            // 
            // btnGenerateClosing
            // 
            this.btnGenerateClosing.BackColor = System.Drawing.Color.RoyalBlue;
            this.btnGenerateClosing.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnGenerateClosing.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnGenerateClosing.ForeColor = System.Drawing.SystemColors.ButtonFace;
            this.btnGenerateClosing.Location = new System.Drawing.Point(61, 9);
            this.btnGenerateClosing.Name = "btnGenerateClosing";
            this.btnGenerateClosing.Size = new System.Drawing.Size(69, 43);
            this.btnGenerateClosing.TabIndex = 39;
            this.btnGenerateClosing.Text = "Generate Closing";
            this.btnGenerateClosing.UseVisualStyleBackColor = false;
            this.btnGenerateClosing.Visible = false;
            this.btnGenerateClosing.Click += new System.EventHandler(this.btnGenerateClosing_Click);
            // 
            // frmCashOut
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(490, 361);
            this.Controls.Add(this.btnShiftStart);
            this.Controls.Add(this.lblShift);
            this.Controls.Add(this.txtRemarks);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.dtCashDate);
            this.Controls.Add(this.lblAvaliableBalance);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.cmbCashType);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.txtCashOutAmount);
            this.Name = "frmCashOut";
            this.Text = "Cash Out/Expenses";
            this.Load += new System.EventHandler(this.frmCashOut_Load);
            this.panel1.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.TextBox txtCashOutAmount;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button btnClear;
        private System.Windows.Forms.Button btnSave;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.ComboBox cmbCashType;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label lblAvaliableBalance;
        private System.Windows.Forms.DateTimePicker dtCashDate;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox txtRemarks;
        private System.Windows.Forms.Label lblShift;
        private System.Windows.Forms.Button btnShiftStart;
        private System.Windows.Forms.Button btnGenerateClosing;
    }
}