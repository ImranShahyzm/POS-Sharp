namespace POS
{
    partial class frmCounterConfiguration
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
            this.btnClear = new System.Windows.Forms.Button();
            this.btnSave = new System.Windows.Forms.Button();
            this.panel1 = new System.Windows.Forms.Panel();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.txtCounterID = new System.Windows.Forms.TextBox();
            this.txtConfigID = new System.Windows.Forms.TextBox();
            this.txtManualPasswordField = new System.Windows.Forms.TextBox();
            this.txtApiAddress = new System.Windows.Forms.TextBox();
            this.lblIpApi = new System.Windows.Forms.Label();
            this.txtFbrPOSID = new System.Windows.Forms.TextBox();
            this.lblFbrPOSID = new System.Windows.Forms.Label();
            this.cbxIsFbrConnected = new System.Windows.Forms.CheckBox();
            this.lblFbrConnected = new System.Windows.Forms.Label();
            this.lblServerOffline = new System.Windows.Forms.Label();
            this.cbxISServerOffline = new System.Windows.Forms.CheckBox();
            this.txtBillPrefix = new System.Windows.Forms.TextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.txtNoOfInvoicePrint = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.cmbClosingSource = new System.Windows.Forms.ComboBox();
            this.label5 = new System.Windows.Forms.Label();
            this.cmbTranscation = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            this.cmbPosStyle = new System.Windows.Forms.ComboBox();
            this.label3 = new System.Windows.Forms.Label();
            this.cmbCashAccount = new System.Windows.Forms.ComboBox();
            this.label2 = new System.Windows.Forms.Label();
            this.cmbRevenueAccount = new System.Windows.Forms.ComboBox();
            this.label1 = new System.Windows.Forms.Label();
            this.lblCode = new System.Windows.Forms.Label();
            this.txtCounterTitle = new System.Windows.Forms.TextBox();
            this.lblCompanyName = new System.Windows.Forms.Label();
            this.panel1.SuspendLayout();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // btnClear
            // 
            this.btnClear.BackColor = System.Drawing.Color.RoyalBlue;
            this.btnClear.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClear.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnClear.ForeColor = System.Drawing.SystemColors.ButtonFace;
            this.btnClear.Location = new System.Drawing.Point(375, 19);
            this.btnClear.Name = "btnClear";
            this.btnClear.Size = new System.Drawing.Size(115, 31);
            this.btnClear.TabIndex = 22;
            this.btnClear.Text = "Cancel";
            this.btnClear.UseVisualStyleBackColor = false;
            this.btnClear.Click += new System.EventHandler(this.btnClear_Click);
            // 
            // btnSave
            // 
            this.btnSave.BackColor = System.Drawing.Color.RoyalBlue;
            this.btnSave.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnSave.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnSave.ForeColor = System.Drawing.SystemColors.ButtonFace;
            this.btnSave.Location = new System.Drawing.Point(254, 19);
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
            this.panel1.Location = new System.Drawing.Point(47, 384);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(710, 62);
            this.panel1.TabIndex = 23;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.txtCounterID);
            this.groupBox1.Controls.Add(this.txtConfigID);
            this.groupBox1.Controls.Add(this.txtManualPasswordField);
            this.groupBox1.Controls.Add(this.txtApiAddress);
            this.groupBox1.Controls.Add(this.lblIpApi);
            this.groupBox1.Controls.Add(this.txtFbrPOSID);
            this.groupBox1.Controls.Add(this.lblFbrPOSID);
            this.groupBox1.Controls.Add(this.cbxIsFbrConnected);
            this.groupBox1.Controls.Add(this.lblFbrConnected);
            this.groupBox1.Controls.Add(this.lblServerOffline);
            this.groupBox1.Controls.Add(this.cbxISServerOffline);
            this.groupBox1.Controls.Add(this.txtBillPrefix);
            this.groupBox1.Controls.Add(this.label7);
            this.groupBox1.Controls.Add(this.txtNoOfInvoicePrint);
            this.groupBox1.Controls.Add(this.label6);
            this.groupBox1.Controls.Add(this.cmbClosingSource);
            this.groupBox1.Controls.Add(this.label5);
            this.groupBox1.Controls.Add(this.cmbTranscation);
            this.groupBox1.Controls.Add(this.label4);
            this.groupBox1.Controls.Add(this.cmbPosStyle);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.cmbCashAccount);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.cmbRevenueAccount);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Controls.Add(this.lblCode);
            this.groupBox1.Controls.Add(this.txtCounterTitle);
            this.groupBox1.Font = new System.Drawing.Font("Arial", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.ForeColor = System.Drawing.Color.MidnightBlue;
            this.groupBox1.Location = new System.Drawing.Point(47, 86);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(710, 292);
            this.groupBox1.TabIndex = 25;
            this.groupBox1.TabStop = false;
            // 
            // txtCounterID
            // 
            this.txtCounterID.Location = new System.Drawing.Point(612, 79);
            this.txtCounterID.Name = "txtCounterID";
            this.txtCounterID.Size = new System.Drawing.Size(92, 20);
            this.txtCounterID.TabIndex = 47;
            this.txtCounterID.Visible = false;
            // 
            // txtConfigID
            // 
            this.txtConfigID.Location = new System.Drawing.Point(612, 47);
            this.txtConfigID.Name = "txtConfigID";
            this.txtConfigID.Size = new System.Drawing.Size(92, 20);
            this.txtConfigID.TabIndex = 46;
            this.txtConfigID.Visible = false;
            // 
            // txtManualPasswordField
            // 
            this.txtManualPasswordField.Location = new System.Drawing.Point(612, 13);
            this.txtManualPasswordField.Name = "txtManualPasswordField";
            this.txtManualPasswordField.PasswordChar = '*';
            this.txtManualPasswordField.Size = new System.Drawing.Size(92, 20);
            this.txtManualPasswordField.TabIndex = 45;
            this.txtManualPasswordField.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtManualPasswordField_KeyDown);
            // 
            // txtApiAddress
            // 
            this.txtApiAddress.Location = new System.Drawing.Point(171, 261);
            this.txtApiAddress.Name = "txtApiAddress";
            this.txtApiAddress.Size = new System.Drawing.Size(435, 20);
            this.txtApiAddress.TabIndex = 44;
            this.txtApiAddress.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtApiAddress_KeyDown);
            // 
            // lblIpApi
            // 
            this.lblIpApi.AutoSize = true;
            this.lblIpApi.Font = new System.Drawing.Font("Arial", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblIpApi.ForeColor = System.Drawing.Color.MidnightBlue;
            this.lblIpApi.Location = new System.Drawing.Point(55, 265);
            this.lblIpApi.Name = "lblIpApi";
            this.lblIpApi.Size = new System.Drawing.Size(116, 14);
            this.lblIpApi.TabIndex = 43;
            this.lblIpApi.Text = "Ip Address For API :";
            // 
            // txtFbrPOSID
            // 
            this.txtFbrPOSID.Location = new System.Drawing.Point(391, 238);
            this.txtFbrPOSID.Name = "txtFbrPOSID";
            this.txtFbrPOSID.Size = new System.Drawing.Size(215, 20);
            this.txtFbrPOSID.TabIndex = 42;
            this.txtFbrPOSID.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtFbrPOSID_KeyDown);
            // 
            // lblFbrPOSID
            // 
            this.lblFbrPOSID.AutoSize = true;
            this.lblFbrPOSID.Font = new System.Drawing.Font("Arial", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblFbrPOSID.ForeColor = System.Drawing.Color.MidnightBlue;
            this.lblFbrPOSID.Location = new System.Drawing.Point(326, 242);
            this.lblFbrPOSID.Name = "lblFbrPOSID";
            this.lblFbrPOSID.Size = new System.Drawing.Size(68, 14);
            this.lblFbrPOSID.TabIndex = 41;
            this.lblFbrPOSID.Text = "FBR POSID :";
            // 
            // cbxIsFbrConnected
            // 
            this.cbxIsFbrConnected.AutoSize = true;
            this.cbxIsFbrConnected.Location = new System.Drawing.Point(305, 242);
            this.cbxIsFbrConnected.Name = "cbxIsFbrConnected";
            this.cbxIsFbrConnected.Size = new System.Drawing.Size(15, 14);
            this.cbxIsFbrConnected.TabIndex = 40;
            this.cbxIsFbrConnected.UseVisualStyleBackColor = true;
            this.cbxIsFbrConnected.KeyDown += new System.Windows.Forms.KeyEventHandler(this.cbxIsFbrConnected_KeyDown);
            // 
            // lblFbrConnected
            // 
            this.lblFbrConnected.AutoSize = true;
            this.lblFbrConnected.Font = new System.Drawing.Font("Arial", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblFbrConnected.ForeColor = System.Drawing.Color.MidnightBlue;
            this.lblFbrConnected.Location = new System.Drawing.Point(192, 241);
            this.lblFbrConnected.Name = "lblFbrConnected";
            this.lblFbrConnected.Size = new System.Drawing.Size(107, 14);
            this.lblFbrConnected.TabIndex = 39;
            this.lblFbrConnected.Text = "Is Fbr Connected :";
            // 
            // lblServerOffline
            // 
            this.lblServerOffline.AutoSize = true;
            this.lblServerOffline.Font = new System.Drawing.Font("Arial", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblServerOffline.ForeColor = System.Drawing.Color.MidnightBlue;
            this.lblServerOffline.Location = new System.Drawing.Point(69, 241);
            this.lblServerOffline.Name = "lblServerOffline";
            this.lblServerOffline.Size = new System.Drawing.Size(102, 14);
            this.lblServerOffline.TabIndex = 38;
            this.lblServerOffline.Text = "Is Server Offline :";
            // 
            // cbxISServerOffline
            // 
            this.cbxISServerOffline.AutoSize = true;
            this.cbxISServerOffline.Location = new System.Drawing.Point(171, 241);
            this.cbxISServerOffline.Name = "cbxISServerOffline";
            this.cbxISServerOffline.Size = new System.Drawing.Size(15, 14);
            this.cbxISServerOffline.TabIndex = 37;
            this.cbxISServerOffline.UseVisualStyleBackColor = true;
            this.cbxISServerOffline.KeyDown += new System.Windows.Forms.KeyEventHandler(this.cbxISServerOffline_KeyDown);
            // 
            // txtBillPrefix
            // 
            this.txtBillPrefix.Location = new System.Drawing.Point(391, 208);
            this.txtBillPrefix.Name = "txtBillPrefix";
            this.txtBillPrefix.Size = new System.Drawing.Size(215, 20);
            this.txtBillPrefix.TabIndex = 16;
            this.txtBillPrefix.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtBillPrefix_KeyDown);
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Arial", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.ForeColor = System.Drawing.Color.MidnightBlue;
            this.label7.Location = new System.Drawing.Point(326, 211);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(64, 14);
            this.label7.TabIndex = 15;
            this.label7.Text = "Bill Prefix :";
            // 
            // txtNoOfInvoicePrint
            // 
            this.txtNoOfInvoicePrint.Location = new System.Drawing.Point(171, 208);
            this.txtNoOfInvoicePrint.Name = "txtNoOfInvoicePrint";
            this.txtNoOfInvoicePrint.Size = new System.Drawing.Size(135, 20);
            this.txtNoOfInvoicePrint.TabIndex = 14;
            this.txtNoOfInvoicePrint.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtNoOfInvoicePrint_KeyDown);
            this.txtNoOfInvoicePrint.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtNoOfInvoicePrint_KeyPress);
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Arial", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.ForeColor = System.Drawing.Color.MidnightBlue;
            this.label6.Location = new System.Drawing.Point(94, 208);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(77, 14);
            this.label6.TabIndex = 13;
            this.label6.Text = "No of Prints :";
            // 
            // cmbClosingSource
            // 
            this.cmbClosingSource.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.SuggestAppend;
            this.cmbClosingSource.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cmbClosingSource.FormattingEnabled = true;
            this.cmbClosingSource.Items.AddRange(new object[] {
            "select Product"});
            this.cmbClosingSource.Location = new System.Drawing.Point(171, 174);
            this.cmbClosingSource.Name = "cmbClosingSource";
            this.cmbClosingSource.Size = new System.Drawing.Size(435, 22);
            this.cmbClosingSource.TabIndex = 12;
            this.cmbClosingSource.KeyDown += new System.Windows.Forms.KeyEventHandler(this.cmbClosingSource_KeyDown);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Arial", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.ForeColor = System.Drawing.Color.MidnightBlue;
            this.label5.Location = new System.Drawing.Point(49, 177);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(122, 14);
            this.label5.TabIndex = 11;
            this.label5.Text = "Closing Transcation :";
            // 
            // cmbTranscation
            // 
            this.cmbTranscation.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.SuggestAppend;
            this.cmbTranscation.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cmbTranscation.FormattingEnabled = true;
            this.cmbTranscation.Items.AddRange(new object[] {
            "select Product"});
            this.cmbTranscation.Location = new System.Drawing.Point(171, 146);
            this.cmbTranscation.Name = "cmbTranscation";
            this.cmbTranscation.Size = new System.Drawing.Size(435, 22);
            this.cmbTranscation.TabIndex = 10;
            this.cmbTranscation.KeyDown += new System.Windows.Forms.KeyEventHandler(this.cmbTranscation_KeyDown);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Arial", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.ForeColor = System.Drawing.Color.MidnightBlue;
            this.label4.Location = new System.Drawing.Point(45, 149);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(126, 14);
            this.label4.TabIndex = 9;
            this.label4.Text = "Opening Transcation :";
            // 
            // cmbPosStyle
            // 
            this.cmbPosStyle.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.SuggestAppend;
            this.cmbPosStyle.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cmbPosStyle.FormattingEnabled = true;
            this.cmbPosStyle.Items.AddRange(new object[] {
            "select Product"});
            this.cmbPosStyle.Location = new System.Drawing.Point(171, 113);
            this.cmbPosStyle.Name = "cmbPosStyle";
            this.cmbPosStyle.Size = new System.Drawing.Size(435, 22);
            this.cmbPosStyle.TabIndex = 8;
            this.cmbPosStyle.KeyDown += new System.Windows.Forms.KeyEventHandler(this.cmbPosStyle_KeyDown);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Arial", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.ForeColor = System.Drawing.Color.MidnightBlue;
            this.label3.Location = new System.Drawing.Point(106, 116);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(65, 14);
            this.label3.TabIndex = 7;
            this.label3.Text = "POS Style :";
            // 
            // cmbCashAccount
            // 
            this.cmbCashAccount.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.SuggestAppend;
            this.cmbCashAccount.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cmbCashAccount.FormattingEnabled = true;
            this.cmbCashAccount.Items.AddRange(new object[] {
            "select Product"});
            this.cmbCashAccount.Location = new System.Drawing.Point(171, 79);
            this.cmbCashAccount.Name = "cmbCashAccount";
            this.cmbCashAccount.Size = new System.Drawing.Size(435, 22);
            this.cmbCashAccount.TabIndex = 6;
            this.cmbCashAccount.KeyDown += new System.Windows.Forms.KeyEventHandler(this.cmbCashAccount_KeyDown);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Arial", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.ForeColor = System.Drawing.Color.MidnightBlue;
            this.label2.Location = new System.Drawing.Point(82, 79);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(89, 14);
            this.label2.TabIndex = 5;
            this.label2.Text = "Cash Account :";
            // 
            // cmbRevenueAccount
            // 
            this.cmbRevenueAccount.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.SuggestAppend;
            this.cmbRevenueAccount.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cmbRevenueAccount.FormattingEnabled = true;
            this.cmbRevenueAccount.Items.AddRange(new object[] {
            "select Product"});
            this.cmbRevenueAccount.Location = new System.Drawing.Point(171, 45);
            this.cmbRevenueAccount.Name = "cmbRevenueAccount";
            this.cmbRevenueAccount.Size = new System.Drawing.Size(435, 22);
            this.cmbRevenueAccount.TabIndex = 4;
            this.cmbRevenueAccount.KeyDown += new System.Windows.Forms.KeyEventHandler(this.cmbRevenueAccount_KeyDown);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Arial", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.ForeColor = System.Drawing.Color.MidnightBlue;
            this.label1.Location = new System.Drawing.Point(62, 48);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(109, 14);
            this.label1.TabIndex = 2;
            this.label1.Text = "Revenue Account :";
            // 
            // lblCode
            // 
            this.lblCode.AutoSize = true;
            this.lblCode.Font = new System.Drawing.Font("Arial", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblCode.ForeColor = System.Drawing.Color.MidnightBlue;
            this.lblCode.Location = new System.Drawing.Point(79, 16);
            this.lblCode.Name = "lblCode";
            this.lblCode.Size = new System.Drawing.Size(92, 14);
            this.lblCode.TabIndex = 1;
            this.lblCode.Text = "Counter Name :";
            // 
            // txtCounterTitle
            // 
            this.txtCounterTitle.Location = new System.Drawing.Point(171, 13);
            this.txtCounterTitle.Name = "txtCounterTitle";
            this.txtCounterTitle.Size = new System.Drawing.Size(435, 20);
            this.txtCounterTitle.TabIndex = 1;
            this.txtCounterTitle.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtCounterTitle_KeyDown);
            // 
            // lblCompanyName
            // 
            this.lblCompanyName.AutoSize = true;
            this.lblCompanyName.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblCompanyName.ForeColor = System.Drawing.Color.MidnightBlue;
            this.lblCompanyName.Location = new System.Drawing.Point(278, 64);
            this.lblCompanyName.Name = "lblCompanyName";
            this.lblCompanyName.Size = new System.Drawing.Size(224, 19);
            this.lblCompanyName.TabIndex = 26;
            this.lblCompanyName.Text = "Company name of the Client";
            // 
            // frmCounterConfiguration
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(825, 457);
            this.Controls.Add(this.lblCompanyName);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.panel1);
            this.Name = "frmCounterConfiguration";
            this.Style = MetroFramework.MetroColorStyle.Orange;
            this.Text = "Counter Configuration";
            this.Load += new System.EventHandler(this.frmCounterConfiguration_Load);
            this.panel1.ResumeLayout(false);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.Button btnClear;
        private System.Windows.Forms.Button btnSave;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Label lblCode;
        private System.Windows.Forms.TextBox txtCounterTitle;
        private System.Windows.Forms.Label lblCompanyName;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox cmbRevenueAccount;
        private System.Windows.Forms.ComboBox cmbCashAccount;
        private System.Windows.Forms.ComboBox cmbPosStyle;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.ComboBox cmbTranscation;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.ComboBox cmbClosingSource;
        private System.Windows.Forms.TextBox txtNoOfInvoicePrint;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TextBox txtBillPrefix;
        private System.Windows.Forms.CheckBox cbxIsFbrConnected;
        private System.Windows.Forms.Label lblFbrConnected;
        private System.Windows.Forms.Label lblServerOffline;
        private System.Windows.Forms.CheckBox cbxISServerOffline;
        private System.Windows.Forms.TextBox txtFbrPOSID;
        private System.Windows.Forms.Label lblFbrPOSID;
        private System.Windows.Forms.TextBox txtApiAddress;
        private System.Windows.Forms.Label lblIpApi;
        private System.Windows.Forms.TextBox txtManualPasswordField;
        private System.Windows.Forms.TextBox txtCounterID;
        private System.Windows.Forms.TextBox txtConfigID;
    }
}