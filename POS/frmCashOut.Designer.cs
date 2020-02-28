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
            this.panel2 = new System.Windows.Forms.Panel();
            this.label3 = new System.Windows.Forms.Label();
            this.cmbCashType = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            this.lblAvaliableBalance = new System.Windows.Forms.Label();
            this.panel1.SuspendLayout();
            this.panel2.SuspendLayout();
            this.SuspendLayout();
            // 
            // txtCashOutAmount
            // 
            this.txtCashOutAmount.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtCashOutAmount.Location = new System.Drawing.Point(153, 187);
            this.txtCashOutAmount.MaxLength = 10;
            this.txtCashOutAmount.Name = "txtCashOutAmount";
            this.txtCashOutAmount.Size = new System.Drawing.Size(213, 26);
            this.txtCashOutAmount.TabIndex = 18;
            this.txtCashOutAmount.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtCashOutAmount_KeyPress);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(23, 92);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(121, 18);
            this.label1.TabIndex = 19;
            this.label1.Text = "Available Balance:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(23, 188);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(62, 18);
            this.label2.TabIndex = 20;
            this.label2.Text = "Amount:";
            // 
            // btnClear
            // 
            this.btnClear.BackColor = System.Drawing.Color.RoyalBlue;
            this.btnClear.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClear.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnClear.ForeColor = System.Drawing.SystemColors.ButtonFace;
            this.btnClear.Location = new System.Drawing.Point(135, 20);
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
            this.btnSave.Location = new System.Drawing.Point(13, 21);
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
            this.panel1.Location = new System.Drawing.Point(0, 298);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(384, 62);
            this.panel1.TabIndex = 23;
            // 
            // panel2
            // 
            this.panel2.BackColor = System.Drawing.Color.Teal;
            this.panel2.Controls.Add(this.label3);
            this.panel2.Location = new System.Drawing.Point(0, 0);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(384, 52);
            this.panel2.TabIndex = 24;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Calibri", 18F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.ForeColor = System.Drawing.SystemColors.Control;
            this.label3.Location = new System.Drawing.Point(4, 13);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(103, 29);
            this.label3.TabIndex = 0;
            this.label3.Text = "Cash Out";
            // 
            // cmbCashType
            // 
            this.cmbCashType.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cmbCashType.FormattingEnabled = true;
            this.cmbCashType.Location = new System.Drawing.Point(153, 138);
            this.cmbCashType.Name = "cmbCashType";
            this.cmbCashType.Size = new System.Drawing.Size(213, 26);
            this.cmbCashType.TabIndex = 25;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(23, 139);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(74, 18);
            this.label4.TabIndex = 26;
            this.label4.Text = "Cash Type:";
            // 
            // lblAvaliableBalance
            // 
            this.lblAvaliableBalance.AutoSize = true;
            this.lblAvaliableBalance.Font = new System.Drawing.Font("Calibri", 14.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblAvaliableBalance.Location = new System.Drawing.Point(150, 89);
            this.lblAvaliableBalance.Name = "lblAvaliableBalance";
            this.lblAvaliableBalance.Size = new System.Drawing.Size(15, 23);
            this.lblAvaliableBalance.TabIndex = 27;
            this.lblAvaliableBalance.Text = ".";
            // 
            // frmCashOut
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(384, 361);
            this.Controls.Add(this.lblAvaliableBalance);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.cmbCashType);
            this.Controls.Add(this.panel2);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.txtCashOutAmount);
            this.Name = "frmCashOut";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Corbis Solution";
            this.Load += new System.EventHandler(this.frmCashOut_Load);
            this.panel1.ResumeLayout(false);
            this.panel2.ResumeLayout(false);
            this.panel2.PerformLayout();
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
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.ComboBox cmbCashType;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label lblAvaliableBalance;
    }
}