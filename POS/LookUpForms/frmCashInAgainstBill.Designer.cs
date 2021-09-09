namespace POS
{
    partial class frmCashInAgainstBill
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
            this.label4 = new System.Windows.Forms.Label();
            this.dtCashDate = new System.Windows.Forms.DateTimePicker();
            this.label1 = new System.Windows.Forms.Label();
            this.txtBillNo = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.txtRecoverdAmount = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.dtRecoveryDate = new System.Windows.Forms.DateTimePicker();
            this.txtSaleID = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.txtAcRider = new System.Windows.Forms.TextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.txtRiderRem = new System.Windows.Forms.TextBox();
            this.label8 = new System.Windows.Forms.Label();
            this.txtRiderRecovery = new System.Windows.Forms.TextBox();
            this.panel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // txtCashInAmount
            // 
            this.txtCashInAmount.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtCashInAmount.Location = new System.Drawing.Point(337, 146);
            this.txtCashInAmount.MaxLength = 10;
            this.txtCashInAmount.Name = "txtCashInAmount";
            this.txtCashInAmount.ReadOnly = true;
            this.txtCashInAmount.Size = new System.Drawing.Size(186, 25);
            this.txtCashInAmount.TabIndex = 18;
            this.txtCashInAmount.TextChanged += new System.EventHandler(this.txtCashInAmount_TextChanged);
            this.txtCashInAmount.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtCashInAmount_KeyPress);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(243, 149);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(85, 18);
            this.label2.TabIndex = 20;
            this.label2.Text = "Bill Amount:";
            this.label2.Click += new System.EventHandler(this.label2_Click);
            // 
            // btnClear
            // 
            this.btnClear.BackColor = System.Drawing.Color.RoyalBlue;
            this.btnClear.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClear.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnClear.ForeColor = System.Drawing.SystemColors.ButtonFace;
            this.btnClear.Location = new System.Drawing.Point(251, 20);
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
            this.btnSave.Location = new System.Drawing.Point(129, 21);
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
            this.panel1.Location = new System.Drawing.Point(22, 247);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(501, 62);
            this.panel1.TabIndex = 23;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(83, 154);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(53, 18);
            this.label4.TabIndex = 26;
            this.label4.Text = "Bill No:";
            // 
            // dtCashDate
            // 
            this.dtCashDate.CalendarFont = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dtCashDate.Location = new System.Drawing.Point(142, 121);
            this.dtCashDate.Name = "dtCashDate";
            this.dtCashDate.Size = new System.Drawing.Size(186, 20);
            this.dtCashDate.TabIndex = 27;
            this.dtCashDate.ValueChanged += new System.EventHandler(this.dtCashDate_ValueChanged);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(72, 124);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(64, 18);
            this.label1.TabIndex = 28;
            this.label1.Text = "Bill Date:";
            this.label1.Click += new System.EventHandler(this.label1_Click);
            // 
            // txtBillNo
            // 
            this.txtBillNo.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtBillNo.Location = new System.Drawing.Point(142, 147);
            this.txtBillNo.Name = "txtBillNo";
            this.txtBillNo.Size = new System.Drawing.Size(78, 25);
            this.txtBillNo.TabIndex = 29;
            this.txtBillNo.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtBillNo_KeyDown);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(44, 223);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(92, 18);
            this.label3.TabIndex = 30;
            this.label3.Text = "Bill Recovery:";
            // 
            // txtRecoverdAmount
            // 
            this.txtRecoverdAmount.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtRecoverdAmount.Location = new System.Drawing.Point(142, 216);
            this.txtRecoverdAmount.MaxLength = 10;
            this.txtRecoverdAmount.Name = "txtRecoverdAmount";
            this.txtRecoverdAmount.Size = new System.Drawing.Size(110, 25);
            this.txtRecoverdAmount.TabIndex = 31;
            this.txtRecoverdAmount.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtRecoverdAmount_KeyDown);
            this.txtRecoverdAmount.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtRecoverdAmount_KeyPress);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(35, 85);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(101, 18);
            this.label5.TabIndex = 32;
            this.label5.Text = "Recovery Date:";
            // 
            // dtRecoveryDate
            // 
            this.dtRecoveryDate.CalendarFont = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dtRecoveryDate.Location = new System.Drawing.Point(142, 85);
            this.dtRecoveryDate.Name = "dtRecoveryDate";
            this.dtRecoveryDate.Size = new System.Drawing.Size(186, 20);
            this.dtRecoveryDate.TabIndex = 33;
            // 
            // txtSaleID
            // 
            this.txtSaleID.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtSaleID.Location = new System.Drawing.Point(337, 116);
            this.txtSaleID.Name = "txtSaleID";
            this.txtSaleID.Size = new System.Drawing.Size(78, 25);
            this.txtSaleID.TabIndex = 34;
            this.txtSaleID.Visible = false;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.Location = new System.Drawing.Point(38, 187);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(98, 18);
            this.label6.TabIndex = 35;
            this.label6.Text = "Rider Amount:";
            // 
            // txtAcRider
            // 
            this.txtAcRider.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtAcRider.Location = new System.Drawing.Point(142, 184);
            this.txtAcRider.MaxLength = 10;
            this.txtAcRider.Name = "txtAcRider";
            this.txtAcRider.ReadOnly = true;
            this.txtAcRider.Size = new System.Drawing.Size(110, 25);
            this.txtAcRider.TabIndex = 36;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.Location = new System.Drawing.Point(258, 187);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(139, 18);
            this.label7.TabIndex = 37;
            this.label7.Text = "Rider Amount (Rem):";
            // 
            // txtRiderRem
            // 
            this.txtRiderRem.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtRiderRem.Location = new System.Drawing.Point(403, 184);
            this.txtRiderRem.MaxLength = 10;
            this.txtRiderRem.Name = "txtRiderRem";
            this.txtRiderRem.ReadOnly = true;
            this.txtRiderRem.Size = new System.Drawing.Size(120, 25);
            this.txtRiderRem.TabIndex = 38;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label8.Location = new System.Drawing.Point(258, 219);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(130, 18);
            this.label8.TabIndex = 39;
            this.label8.Text = "Exchange Recovery:";
            // 
            // txtRiderRecovery
            // 
            this.txtRiderRecovery.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtRiderRecovery.Location = new System.Drawing.Point(403, 216);
            this.txtRiderRecovery.MaxLength = 10;
            this.txtRiderRecovery.Name = "txtRiderRecovery";
            this.txtRiderRecovery.Size = new System.Drawing.Size(120, 25);
            this.txtRiderRecovery.TabIndex = 40;
            this.txtRiderRecovery.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtRiderRecovery_KeyDown);
            this.txtRiderRecovery.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtRiderRecovery_KeyPress);
            // 
            // frmCashInAgainstBill
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(558, 342);
            this.Controls.Add(this.txtRiderRecovery);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.txtRiderRem);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.txtAcRider);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.txtSaleID);
            this.Controls.Add(this.dtRecoveryDate);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.txtRecoverdAmount);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.txtBillNo);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.dtCashDate);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.txtCashInAmount);
            this.Name = "frmCashInAgainstBill";
            this.Text = "Bill Wise Recovery";
            this.Load += new System.EventHandler(this.frmCashInAgainstBill_Load);
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
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.DateTimePicker dtCashDate;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtBillNo;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox txtRecoverdAmount;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.DateTimePicker dtRecoveryDate;
        private System.Windows.Forms.TextBox txtSaleID;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox txtAcRider;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TextBox txtRiderRem;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.TextBox txtRiderRecovery;
    }
}