﻿namespace POS
{
    partial class POSSaleNew
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
            this.components = new System.ComponentModel.Container();
            this.timer1 = new System.Windows.Forms.Timer(this.components);
            this.btnStock = new System.Windows.Forms.Button();
            this.txtPrint = new System.Windows.Forms.Button();
            this.label18 = new System.Windows.Forms.Label();
            this.btnClear = new System.Windows.Forms.Button();
            this.btnSave = new System.Windows.Forms.Button();
            this.ItemSaleGrid = new System.Windows.Forms.DataGridView();
            this.label9 = new System.Windows.Forms.Label();
            this.txtProductCode = new System.Windows.Forms.TextBox();
            this.label19 = new System.Windows.Forms.Label();
            this.txtCustName = new System.Windows.Forms.TextBox();
            this.txtCustPhone = new System.Windows.Forms.TextBox();
            this.lblShopName = new System.Windows.Forms.Label();
            this.cmbSalemenu = new System.Windows.Forms.ComboBox();
            this.label22 = new System.Windows.Forms.Label();
            this.panel1 = new System.Windows.Forms.Panel();
            this.label17 = new System.Windows.Forms.Label();
            this.txtPayableAmount = new System.Windows.Forms.TextBox();
            this.label16 = new System.Windows.Forms.Label();
            this.txtReceivableAmount = new System.Windows.Forms.TextBox();
            this.label15 = new System.Windows.Forms.Label();
            this.txtAccAmount = new System.Windows.Forms.TextBox();
            this.label14 = new System.Windows.Forms.Label();
            this.txtOtherCharges = new System.Windows.Forms.TextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.txtAmountReceive = new System.Windows.Forms.TextBox();
            this.label8 = new System.Windows.Forms.Label();
            this.txtAmountReturn = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.txtTotalTax = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.txtNetAmount = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.txtTotalDiscount = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.txtDiscountAmount = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.txtDiscountPercentage = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.txtGrossAmount = new System.Windows.Forms.TextBox();
            this.panel5 = new System.Windows.Forms.Panel();
            this.label10 = new System.Windows.Forms.Label();
            this.txtProductID = new System.Windows.Forms.TextBox();
            this.txtdetailAmount = new System.Windows.Forms.TextBox();
            this.txtTaxAmount = new System.Windows.Forms.TextBox();
            this.txtTax = new System.Windows.Forms.TextBox();
            this.txtRate = new System.Windows.Forms.TextBox();
            this.txtQuantity = new System.Windows.Forms.TextBox();
            this.cmbProducts = new System.Windows.Forms.ComboBox();
            this.lblSaleType = new System.Windows.Forms.Label();
            this.label21 = new System.Windows.Forms.Label();
            this.label20 = new System.Windows.Forms.Label();
            this.lblDateTime = new System.Windows.Forms.Label();
            this.SalePosID = new System.Windows.Forms.TextBox();
            this.txtProductBarCode = new System.Windows.Forms.TextBox();
            this.txtSaleDate = new System.Windows.Forms.DateTimePicker();
            this.label12 = new System.Windows.Forms.Label();
            this.txtInvoiceNo = new System.Windows.Forms.TextBox();
            this.txtAvailableQty = new System.Windows.Forms.TextBox();
            this.label11 = new System.Windows.Forms.Label();
            this.ProductId = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ProductName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Rate = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Quantity = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Tax = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.TaxAmount = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.NetAmount = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Qty = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.ItemSaleGrid)).BeginInit();
            this.panel1.SuspendLayout();
            this.panel5.SuspendLayout();
            this.SuspendLayout();
            // 
            // timer1
            // 
            this.timer1.Tick += new System.EventHandler(this.timer1_Tick);
            // 
            // btnStock
            // 
            this.btnStock.BackColor = System.Drawing.Color.RoyalBlue;
            this.btnStock.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnStock.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnStock.ForeColor = System.Drawing.SystemColors.ButtonFace;
            this.btnStock.Location = new System.Drawing.Point(916, 8);
            this.btnStock.Name = "btnStock";
            this.btnStock.Size = new System.Drawing.Size(115, 31);
            this.btnStock.TabIndex = 12;
            this.btnStock.Text = "Stock Arrival";
            this.btnStock.UseVisualStyleBackColor = false;
            this.btnStock.Click += new System.EventHandler(this.btnStock_Click);
            // 
            // txtPrint
            // 
            this.txtPrint.Location = new System.Drawing.Point(949, 103);
            this.txtPrint.Name = "txtPrint";
            this.txtPrint.Size = new System.Drawing.Size(75, 28);
            this.txtPrint.TabIndex = 11;
            this.txtPrint.Text = "Print";
            this.txtPrint.UseVisualStyleBackColor = true;
            this.txtPrint.Visible = false;
            // 
            // label18
            // 
            this.label18.AutoSize = true;
            this.label18.Font = new System.Drawing.Font("Calibri", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label18.Location = new System.Drawing.Point(724, 45);
            this.label18.Name = "label18";
            this.label18.Size = new System.Drawing.Size(230, 18);
            this.label18.TabIndex = 10;
            this.label18.Text = "{ALT+A} = Focuses Amount Recieved";
            // 
            // btnClear
            // 
            this.btnClear.BackColor = System.Drawing.Color.RoyalBlue;
            this.btnClear.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClear.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnClear.ForeColor = System.Drawing.SystemColors.ButtonFace;
            this.btnClear.Location = new System.Drawing.Point(705, 100);
            this.btnClear.Name = "btnClear";
            this.btnClear.Size = new System.Drawing.Size(115, 31);
            this.btnClear.TabIndex = 1;
            this.btnClear.Text = "New Sale (ALT+N)";
            this.btnClear.UseVisualStyleBackColor = false;
            // 
            // btnSave
            // 
            this.btnSave.BackColor = System.Drawing.Color.RoyalBlue;
            this.btnSave.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnSave.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnSave.ForeColor = System.Drawing.SystemColors.ButtonFace;
            this.btnSave.Location = new System.Drawing.Point(828, 100);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(115, 31);
            this.btnSave.TabIndex = 15;
            this.btnSave.Text = "Save (ALT+S)";
            this.btnSave.UseVisualStyleBackColor = false;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // ItemSaleGrid
            // 
            this.ItemSaleGrid.AllowUserToAddRows = false;
            this.ItemSaleGrid.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.ItemSaleGrid.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.ItemSaleGrid.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.ProductId,
            this.ProductName,
            this.Rate,
            this.Quantity,
            this.Tax,
            this.TaxAmount,
            this.NetAmount,
            this.Qty});
            this.ItemSaleGrid.Location = new System.Drawing.Point(90, 243);
            this.ItemSaleGrid.Name = "ItemSaleGrid";
            this.ItemSaleGrid.Size = new System.Drawing.Size(939, 281);
            this.ItemSaleGrid.TabIndex = 10;
            this.ItemSaleGrid.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.ItemSaleGrid_CellContentClick);
            this.ItemSaleGrid.CellValueChanged += new System.Windows.Forms.DataGridViewCellEventHandler(this.ItemSaleGrid_CellValueChanged);
            this.ItemSaleGrid.EditingControlShowing += new System.Windows.Forms.DataGridViewEditingControlShowingEventHandler(this.ItemSaleGrid_EditingControlShowing);
            this.ItemSaleGrid.KeyDown += new System.Windows.Forms.KeyEventHandler(this.ItemSaleGrid_KeyDown);
            this.ItemSaleGrid.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.ItemSaleGrid_KeyPress);
            this.ItemSaleGrid.Leave += new System.EventHandler(this.ItemSaleGrid_Leave);
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Font = new System.Drawing.Font("Times New Roman", 20.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label9.ForeColor = System.Drawing.Color.Red;
            this.label9.Location = new System.Drawing.Point(177, 5);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(166, 31);
            this.label9.TabIndex = 0;
            this.label9.Text = "CORBIS POS";
            // 
            // txtProductCode
            // 
            this.txtProductCode.Location = new System.Drawing.Point(100, 140);
            this.txtProductCode.MaxLength = 4;
            this.txtProductCode.Name = "txtProductCode";
            this.txtProductCode.Size = new System.Drawing.Size(100, 20);
            this.txtProductCode.TabIndex = 2;
            this.txtProductCode.TextChanged += new System.EventHandler(this.txtProductCode_TextChanged);
            this.txtProductCode.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtProductCode_KeyDown);
            // 
            // label19
            // 
            this.label19.AutoSize = true;
            this.label19.Font = new System.Drawing.Font("Times New Roman", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label19.Location = new System.Drawing.Point(258, 72);
            this.label19.Name = "label19";
            this.label19.Size = new System.Drawing.Size(84, 14);
            this.label19.TabIndex = 11;
            this.label19.Text = "Customer Name:";
            this.label19.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // txtCustName
            // 
            this.txtCustName.Location = new System.Drawing.Point(348, 69);
            this.txtCustName.Name = "txtCustName";
            this.txtCustName.Size = new System.Drawing.Size(296, 20);
            this.txtCustName.TabIndex = 2;
            this.txtCustName.TextChanged += new System.EventHandler(this.txtCustName_TextChanged);
            this.txtCustName.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtCustName_KeyDown);
            // 
            // txtCustPhone
            // 
            this.txtCustPhone.Location = new System.Drawing.Point(106, 72);
            this.txtCustPhone.Name = "txtCustPhone";
            this.txtCustPhone.Size = new System.Drawing.Size(146, 20);
            this.txtCustPhone.TabIndex = 1;
            this.txtCustPhone.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtCustPhone_KeyDown);
            // 
            // lblShopName
            // 
            this.lblShopName.AutoSize = true;
            this.lblShopName.Font = new System.Drawing.Font("Times New Roman", 20.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblShopName.ForeColor = System.Drawing.Color.DodgerBlue;
            this.lblShopName.Location = new System.Drawing.Point(827, 5);
            this.lblShopName.Name = "lblShopName";
            this.lblShopName.Size = new System.Drawing.Size(166, 31);
            this.lblShopName.TabIndex = 14;
            this.lblShopName.Text = "CORBIS POS";
            // 
            // cmbSalemenu
            // 
            this.cmbSalemenu.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.SuggestAppend;
            this.cmbSalemenu.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cmbSalemenu.FormattingEnabled = true;
            this.cmbSalemenu.Items.AddRange(new object[] {
            "select Product"});
            this.cmbSalemenu.Location = new System.Drawing.Point(732, 65);
            this.cmbSalemenu.Name = "cmbSalemenu";
            this.cmbSalemenu.Size = new System.Drawing.Size(146, 21);
            this.cmbSalemenu.TabIndex = 3;
            this.cmbSalemenu.KeyDown += new System.Windows.Forms.KeyEventHandler(this.cmbSalemenu_KeyDown);
            // 
            // label22
            // 
            this.label22.AutoSize = true;
            this.label22.Font = new System.Drawing.Font("Times New Roman", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label22.Location = new System.Drawing.Point(650, 72);
            this.label22.Name = "label22";
            this.label22.Size = new System.Drawing.Size(63, 14);
            this.label22.TabIndex = 16;
            this.label22.Text = "Select Menu";
            this.label22.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // panel1
            // 
            this.panel1.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.panel1.BackColor = System.Drawing.Color.Gainsboro;
            this.panel1.Controls.Add(this.label18);
            this.panel1.Controls.Add(this.txtPrint);
            this.panel1.Controls.Add(this.btnStock);
            this.panel1.Controls.Add(this.label17);
            this.panel1.Controls.Add(this.txtPayableAmount);
            this.panel1.Controls.Add(this.btnClear);
            this.panel1.Controls.Add(this.label16);
            this.panel1.Controls.Add(this.btnSave);
            this.panel1.Controls.Add(this.txtReceivableAmount);
            this.panel1.Controls.Add(this.label15);
            this.panel1.Controls.Add(this.txtAccAmount);
            this.panel1.Controls.Add(this.label14);
            this.panel1.Controls.Add(this.txtOtherCharges);
            this.panel1.Controls.Add(this.label7);
            this.panel1.Controls.Add(this.txtAmountReceive);
            this.panel1.Controls.Add(this.label8);
            this.panel1.Controls.Add(this.txtAmountReturn);
            this.panel1.Controls.Add(this.label6);
            this.panel1.Controls.Add(this.txtTotalTax);
            this.panel1.Controls.Add(this.label5);
            this.panel1.Controls.Add(this.txtNetAmount);
            this.panel1.Controls.Add(this.label4);
            this.panel1.Controls.Add(this.txtTotalDiscount);
            this.panel1.Controls.Add(this.label3);
            this.panel1.Controls.Add(this.txtDiscountAmount);
            this.panel1.Controls.Add(this.label2);
            this.panel1.Controls.Add(this.txtDiscountPercentage);
            this.panel1.Controls.Add(this.label1);
            this.panel1.Controls.Add(this.txtGrossAmount);
            this.panel1.Location = new System.Drawing.Point(28, 530);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(1034, 140);
            this.panel1.TabIndex = 9;
            // 
            // label17
            // 
            this.label17.AutoSize = true;
            this.label17.Font = new System.Drawing.Font("Times New Roman", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label17.Location = new System.Drawing.Point(410, 71);
            this.label17.Name = "label17";
            this.label17.Size = new System.Drawing.Size(96, 13);
            this.label17.TabIndex = 23;
            this.label17.Text = "Payable Amount:";
            this.label17.Click += new System.EventHandler(this.label17_Click);
            // 
            // txtPayableAmount
            // 
            this.txtPayableAmount.Font = new System.Drawing.Font("Calibri", 20.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtPayableAmount.Location = new System.Drawing.Point(413, 87);
            this.txtPayableAmount.MaxLength = 10;
            this.txtPayableAmount.Name = "txtPayableAmount";
            this.txtPayableAmount.Size = new System.Drawing.Size(163, 40);
            this.txtPayableAmount.TabIndex = 22;
            this.txtPayableAmount.TabStop = false;
            // 
            // label16
            // 
            this.label16.AutoSize = true;
            this.label16.Font = new System.Drawing.Font("Times New Roman", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label16.Location = new System.Drawing.Point(17, 71);
            this.label16.Name = "label16";
            this.label16.Size = new System.Drawing.Size(111, 13);
            this.label16.TabIndex = 21;
            this.label16.Text = "Receivable Amount:";
            // 
            // txtReceivableAmount
            // 
            this.txtReceivableAmount.Font = new System.Drawing.Font("Calibri", 20.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtReceivableAmount.ForeColor = System.Drawing.Color.Red;
            this.txtReceivableAmount.Location = new System.Drawing.Point(20, 87);
            this.txtReceivableAmount.MaxLength = 10;
            this.txtReceivableAmount.Name = "txtReceivableAmount";
            this.txtReceivableAmount.ReadOnly = true;
            this.txtReceivableAmount.Size = new System.Drawing.Size(149, 40);
            this.txtReceivableAmount.TabIndex = 20;
            this.txtReceivableAmount.TabStop = false;
            this.txtReceivableAmount.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtReceivableAmount_KeyPress);
            // 
            // label15
            // 
            this.label15.AutoSize = true;
            this.label15.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label15.Location = new System.Drawing.Point(779, 17);
            this.label15.Name = "label15";
            this.label15.Size = new System.Drawing.Size(94, 14);
            this.label15.TabIndex = 19;
            this.label15.Text = "Account Amount :";
            this.label15.Visible = false;
            // 
            // txtAccAmount
            // 
            this.txtAccAmount.Location = new System.Drawing.Point(88, 9);
            this.txtAccAmount.MaxLength = 10;
            this.txtAccAmount.Name = "txtAccAmount";
            this.txtAccAmount.Size = new System.Drawing.Size(73, 20);
            this.txtAccAmount.TabIndex = 18;
            this.txtAccAmount.TabStop = false;
            this.txtAccAmount.Visible = false;
            this.txtAccAmount.TextChanged += new System.EventHandler(this.txtAccAmount_TextChanged);
            // 
            // label14
            // 
            this.label14.AutoSize = true;
            this.label14.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label14.Location = new System.Drawing.Point(6, 42);
            this.label14.Name = "label14";
            this.label14.Size = new System.Drawing.Size(54, 14);
            this.label14.TabIndex = 17;
            this.label14.Text = "Total Tax:";
            // 
            // txtOtherCharges
            // 
            this.txtOtherCharges.Location = new System.Drawing.Point(265, 42);
            this.txtOtherCharges.MaxLength = 10;
            this.txtOtherCharges.Name = "txtOtherCharges";
            this.txtOtherCharges.Size = new System.Drawing.Size(89, 20);
            this.txtOtherCharges.TabIndex = 13;
            this.txtOtherCharges.TextChanged += new System.EventHandler(this.txtDiscountAmount_TextChanged);
            this.txtOtherCharges.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtOtherCharges_KeyDown);
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Times New Roman", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.Location = new System.Drawing.Point(175, 71);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(95, 13);
            this.label7.TabIndex = 15;
            this.label7.Text = "Receive Amount:";
            // 
            // txtAmountReceive
            // 
            this.txtAmountReceive.Font = new System.Drawing.Font("Calibri", 20.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtAmountReceive.Location = new System.Drawing.Point(172, 87);
            this.txtAmountReceive.MaxLength = 10;
            this.txtAmountReceive.Name = "txtAmountReceive";
            this.txtAmountReceive.Size = new System.Drawing.Size(100, 40);
            this.txtAmountReceive.TabIndex = 14;
            this.txtAmountReceive.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtAmountReceive_KeyDown);
            this.txtAmountReceive.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtAmountReceive_KeyPress);
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Font = new System.Drawing.Font("Times New Roman", 8.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label8.Location = new System.Drawing.Point(276, 71);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(92, 13);
            this.label8.TabIndex = 13;
            this.label8.Text = "Return Amount:";
            this.label8.Click += new System.EventHandler(this.label8_Click);
            // 
            // txtAmountReturn
            // 
            this.txtAmountReturn.Font = new System.Drawing.Font("Calibri", 20.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtAmountReturn.Location = new System.Drawing.Point(278, 87);
            this.txtAmountReturn.Name = "txtAmountReturn";
            this.txtAmountReturn.ReadOnly = true;
            this.txtAmountReturn.Size = new System.Drawing.Size(120, 40);
            this.txtAmountReturn.TabIndex = 12;
            this.txtAmountReturn.TabStop = false;
            this.txtAmountReturn.TextChanged += new System.EventHandler(this.txtAmountReturn_TextChanged);
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.Location = new System.Drawing.Point(169, 42);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(80, 14);
            this.label6.TabIndex = 11;
            this.label6.Text = "Other Charges:";
            this.label6.Click += new System.EventHandler(this.label6_Click_1);
            // 
            // txtTotalTax
            // 
            this.txtTotalTax.Location = new System.Drawing.Point(88, 42);
            this.txtTotalTax.Name = "txtTotalTax";
            this.txtTotalTax.ReadOnly = true;
            this.txtTotalTax.Size = new System.Drawing.Size(73, 20);
            this.txtTotalTax.TabIndex = 10;
            this.txtTotalTax.TabStop = false;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(363, 49);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(70, 14);
            this.label5.TabIndex = 9;
            this.label5.Text = "Net Amount:";
            // 
            // txtNetAmount
            // 
            this.txtNetAmount.Location = new System.Drawing.Point(434, 43);
            this.txtNetAmount.Name = "txtNetAmount";
            this.txtNetAmount.ReadOnly = true;
            this.txtNetAmount.Size = new System.Drawing.Size(100, 20);
            this.txtNetAmount.TabIndex = 8;
            this.txtNetAmount.TabStop = false;
            this.txtNetAmount.TextChanged += new System.EventHandler(this.txtNetAmount_TextChanged);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(496, 12);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(80, 14);
            this.label4.TabIndex = 7;
            this.label4.Text = "Total Discount:";
            // 
            // txtTotalDiscount
            // 
            this.txtTotalDiscount.Location = new System.Drawing.Point(582, 9);
            this.txtTotalDiscount.Name = "txtTotalDiscount";
            this.txtTotalDiscount.ReadOnly = true;
            this.txtTotalDiscount.Size = new System.Drawing.Size(61, 20);
            this.txtTotalDiscount.TabIndex = 6;
            this.txtTotalDiscount.TabStop = false;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(360, 15);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(73, 14);
            this.label3.TabIndex = 5;
            this.label3.Text = "Disc Amount:";
            this.label3.Click += new System.EventHandler(this.label3_Click);
            // 
            // txtDiscountAmount
            // 
            this.txtDiscountAmount.Location = new System.Drawing.Point(434, 9);
            this.txtDiscountAmount.MaxLength = 10;
            this.txtDiscountAmount.Name = "txtDiscountAmount";
            this.txtDiscountAmount.Size = new System.Drawing.Size(59, 20);
            this.txtDiscountAmount.TabIndex = 12;
            this.txtDiscountAmount.TextChanged += new System.EventHandler(this.txtDiscountAmount_TextChanged);
            this.txtDiscountAmount.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtDiscountAmount_KeyDown);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(169, 12);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(65, 14);
            this.label2.TabIndex = 3;
            this.label2.Text = "Discount %:";
            // 
            // txtDiscountPercentage
            // 
            this.txtDiscountPercentage.Location = new System.Drawing.Point(265, 9);
            this.txtDiscountPercentage.MaxLength = 10;
            this.txtDiscountPercentage.Name = "txtDiscountPercentage";
            this.txtDiscountPercentage.Size = new System.Drawing.Size(89, 20);
            this.txtDiscountPercentage.TabIndex = 11;
            this.txtDiscountPercentage.TextChanged += new System.EventHandler(this.txtDiscountAmount_TextChanged);
            this.txtDiscountPercentage.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtDiscountPercentage_KeyDown);
            this.txtDiscountPercentage.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtDiscountPercentage_KeyPress);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Calibri", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(3, 11);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(80, 14);
            this.label1.TabIndex = 1;
            this.label1.Text = "Gross Amount:";
            // 
            // txtGrossAmount
            // 
            this.txtGrossAmount.Location = new System.Drawing.Point(99, 9);
            this.txtGrossAmount.Name = "txtGrossAmount";
            this.txtGrossAmount.ReadOnly = true;
            this.txtGrossAmount.Size = new System.Drawing.Size(70, 20);
            this.txtGrossAmount.TabIndex = 0;
            // 
            // panel5
            // 
            this.panel5.Controls.Add(this.label11);
            this.panel5.Controls.Add(this.txtAvailableQty);
            this.panel5.Controls.Add(this.label10);
            this.panel5.Controls.Add(this.txtProductID);
            this.panel5.Controls.Add(this.txtdetailAmount);
            this.panel5.Controls.Add(this.txtTaxAmount);
            this.panel5.Controls.Add(this.txtTax);
            this.panel5.Controls.Add(this.txtRate);
            this.panel5.Controls.Add(this.txtQuantity);
            this.panel5.Controls.Add(this.cmbProducts);
            this.panel5.Controls.Add(this.cmbSalemenu);
            this.panel5.Controls.Add(this.label22);
            this.panel5.Controls.Add(this.txtProductCode);
            this.panel5.Controls.Add(this.lblSaleType);
            this.panel5.Controls.Add(this.label21);
            this.panel5.Controls.Add(this.txtCustName);
            this.panel5.Controls.Add(this.txtCustPhone);
            this.panel5.Controls.Add(this.label19);
            this.panel5.Controls.Add(this.lblShopName);
            this.panel5.Controls.Add(this.label20);
            this.panel5.Controls.Add(this.lblDateTime);
            this.panel5.Controls.Add(this.SalePosID);
            this.panel5.Controls.Add(this.txtProductBarCode);
            this.panel5.Controls.Add(this.txtSaleDate);
            this.panel5.Controls.Add(this.label12);
            this.panel5.Controls.Add(this.txtInvoiceNo);
            this.panel5.Controls.Add(this.label9);
            this.panel5.Location = new System.Drawing.Point(23, 74);
            this.panel5.Name = "panel5";
            this.panel5.Size = new System.Drawing.Size(1038, 163);
            this.panel5.TabIndex = 10;
            this.panel5.Paint += new System.Windows.Forms.PaintEventHandler(this.panel5_Paint);
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Font = new System.Drawing.Font("Times New Roman", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label10.Location = new System.Drawing.Point(8, 113);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(77, 14);
            this.label10.TabIndex = 24;
            this.label10.Text = "Search Barcode";
            this.label10.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // txtProductID
            // 
            this.txtProductID.Location = new System.Drawing.Point(9, 139);
            this.txtProductID.MaxLength = 10;
            this.txtProductID.Name = "txtProductID";
            this.txtProductID.Size = new System.Drawing.Size(80, 20);
            this.txtProductID.TabIndex = 23;
            this.txtProductID.TabStop = false;
            this.txtProductID.Visible = false;
            this.txtProductID.TextChanged += new System.EventHandler(this.textBox1_TextChanged);
            // 
            // txtdetailAmount
            // 
            this.txtdetailAmount.Location = new System.Drawing.Point(803, 139);
            this.txtdetailAmount.MaxLength = 10;
            this.txtdetailAmount.Name = "txtdetailAmount";
            this.txtdetailAmount.Size = new System.Drawing.Size(104, 20);
            this.txtdetailAmount.TabIndex = 22;
            this.txtdetailAmount.TabStop = false;
            this.txtdetailAmount.TextChanged += new System.EventHandler(this.txtdetailAmount_TextChanged);
            // 
            // txtTaxAmount
            // 
            this.txtTaxAmount.Location = new System.Drawing.Point(710, 139);
            this.txtTaxAmount.MaxLength = 10;
            this.txtTaxAmount.Name = "txtTaxAmount";
            this.txtTaxAmount.Size = new System.Drawing.Size(87, 20);
            this.txtTaxAmount.TabIndex = 9;
            // 
            // txtTax
            // 
            this.txtTax.Location = new System.Drawing.Point(610, 139);
            this.txtTax.MaxLength = 10;
            this.txtTax.Name = "txtTax";
            this.txtTax.Size = new System.Drawing.Size(87, 20);
            this.txtTax.TabIndex = 8;
            // 
            // txtRate
            // 
            this.txtRate.Location = new System.Drawing.Point(411, 139);
            this.txtRate.MaxLength = 10;
            this.txtRate.Name = "txtRate";
            this.txtRate.Size = new System.Drawing.Size(100, 20);
            this.txtRate.TabIndex = 6;
            // 
            // txtQuantity
            // 
            this.txtQuantity.Location = new System.Drawing.Point(517, 139);
            this.txtQuantity.MaxLength = 10;
            this.txtQuantity.Name = "txtQuantity";
            this.txtQuantity.Size = new System.Drawing.Size(87, 20);
            this.txtQuantity.TabIndex = 7;
            this.txtQuantity.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtQuantity_KeyDown);
            this.txtQuantity.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtQuantity_KeyPress);
            // 
            // cmbProducts
            // 
            this.cmbProducts.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.SuggestAppend;
            this.cmbProducts.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cmbProducts.FormattingEnabled = true;
            this.cmbProducts.Items.AddRange(new object[] {
            "select Product"});
            this.cmbProducts.Location = new System.Drawing.Point(206, 139);
            this.cmbProducts.Name = "cmbProducts";
            this.cmbProducts.Size = new System.Drawing.Size(197, 21);
            this.cmbProducts.TabIndex = 5;
            // 
            // lblSaleType
            // 
            this.lblSaleType.AutoSize = true;
            this.lblSaleType.Font = new System.Drawing.Font("Times New Roman", 14.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblSaleType.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(64)))), ((int)(((byte)(0)))));
            this.lblSaleType.Location = new System.Drawing.Point(4, 5);
            this.lblSaleType.Name = "lblSaleType";
            this.lblSaleType.Size = new System.Drawing.Size(96, 21);
            this.lblSaleType.TabIndex = 9;
            this.lblSaleType.Text = "Sale Return";
            // 
            // label21
            // 
            this.label21.AutoSize = true;
            this.label21.Font = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label21.Location = new System.Drawing.Point(309, 46);
            this.label21.Name = "label21";
            this.label21.Size = new System.Drawing.Size(33, 15);
            this.label21.TabIndex = 11;
            this.label21.Text = "Date:";
            this.label21.Click += new System.EventHandler(this.label21_Click);
            // 
            // label20
            // 
            this.label20.AutoSize = true;
            this.label20.Font = new System.Drawing.Font("Times New Roman", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label20.Location = new System.Drawing.Point(8, 75);
            this.label20.Name = "label20";
            this.label20.Size = new System.Drawing.Size(87, 14);
            this.label20.TabIndex = 12;
            this.label20.Text = "Customer Phone:";
            this.label20.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // lblDateTime
            // 
            this.lblDateTime.AutoSize = true;
            this.lblDateTime.Font = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblDateTime.Location = new System.Drawing.Point(830, 36);
            this.lblDateTime.Name = "lblDateTime";
            this.lblDateTime.Size = new System.Drawing.Size(61, 15);
            this.lblDateTime.TabIndex = 8;
            this.lblDateTime.Text = "Date & Time";
            this.lblDateTime.Click += new System.EventHandler(this.lblDateTime_Click);
            // 
            // SalePosID
            // 
            this.SalePosID.Location = new System.Drawing.Point(106, 46);
            this.SalePosID.MaxLength = 10;
            this.SalePosID.Name = "SalePosID";
            this.SalePosID.Size = new System.Drawing.Size(100, 20);
            this.SalePosID.TabIndex = 12;
            this.SalePosID.TabStop = false;
            this.SalePosID.Visible = false;
            this.SalePosID.TextChanged += new System.EventHandler(this.SalePosID_TextChanged);
            // 
            // txtProductBarCode
            // 
            this.txtProductBarCode.Location = new System.Drawing.Point(100, 113);
            this.txtProductBarCode.Name = "txtProductBarCode";
            this.txtProductBarCode.Size = new System.Drawing.Size(100, 20);
            this.txtProductBarCode.TabIndex = 6;
            this.txtProductBarCode.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtProductBarCode_KeyDown);
            // 
            // txtSaleDate
            // 
            this.txtSaleDate.Location = new System.Drawing.Point(348, 46);
            this.txtSaleDate.Name = "txtSaleDate";
            this.txtSaleDate.Size = new System.Drawing.Size(200, 20);
            this.txtSaleDate.TabIndex = 0;
            this.txtSaleDate.ValueChanged += new System.EventHandler(this.txtSaleDate_ValueChanged_1);
            // 
            // label12
            // 
            this.label12.AutoSize = true;
            this.label12.Font = new System.Drawing.Font("Times New Roman", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label12.Location = new System.Drawing.Point(41, 51);
            this.label12.Name = "label12";
            this.label12.Size = new System.Drawing.Size(54, 15);
            this.label12.TabIndex = 5;
            this.label12.Text = "Invoice #:";
            this.label12.Click += new System.EventHandler(this.label12_Click);
            // 
            // txtInvoiceNo
            // 
            this.txtInvoiceNo.Location = new System.Drawing.Point(106, 46);
            this.txtInvoiceNo.MaxLength = 10;
            this.txtInvoiceNo.Name = "txtInvoiceNo";
            this.txtInvoiceNo.Size = new System.Drawing.Size(146, 20);
            this.txtInvoiceNo.TabIndex = 4;
            this.txtInvoiceNo.TextChanged += new System.EventHandler(this.txtInvoiceNo_TextChanged);
            this.txtInvoiceNo.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtInvoiceNo_KeyDown);
            // 
            // txtAvailableQty
            // 
            this.txtAvailableQty.Location = new System.Drawing.Point(913, 139);
            this.txtAvailableQty.MaxLength = 10;
            this.txtAvailableQty.Name = "txtAvailableQty";
            this.txtAvailableQty.ReadOnly = true;
            this.txtAvailableQty.Size = new System.Drawing.Size(93, 20);
            this.txtAvailableQty.TabIndex = 25;
            this.txtAvailableQty.TabStop = false;
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Font = new System.Drawing.Font("Times New Roman", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label11.Location = new System.Drawing.Point(910, 116);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(93, 14);
            this.label11.TabIndex = 26;
            this.label11.Text = "Available Quantity";
            this.label11.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // ProductId
            // 
            this.ProductId.HeaderText = "ProductID";
            this.ProductId.Name = "ProductId";
            this.ProductId.ReadOnly = true;
            // 
            // ProductName
            // 
            this.ProductName.HeaderText = "ProductName";
            this.ProductName.Name = "ProductName";
            this.ProductName.ReadOnly = true;
            this.ProductName.Width = 200;
            // 
            // Rate
            // 
            this.Rate.HeaderText = "Rate";
            this.Rate.Name = "Rate";
            this.Rate.ReadOnly = true;
            // 
            // Quantity
            // 
            this.Quantity.HeaderText = "Quantity";
            this.Quantity.Name = "Quantity";
            // 
            // Tax
            // 
            this.Tax.HeaderText = "Tax";
            this.Tax.Name = "Tax";
            this.Tax.ReadOnly = true;
            // 
            // TaxAmount
            // 
            this.TaxAmount.HeaderText = "Tax Amount";
            this.TaxAmount.Name = "TaxAmount";
            this.TaxAmount.ReadOnly = true;
            // 
            // NetAmount
            // 
            this.NetAmount.HeaderText = "Net Amount";
            this.NetAmount.Name = "NetAmount";
            this.NetAmount.ReadOnly = true;
            // 
            // Qty
            // 
            this.Qty.HeaderText = "Quantity";
            this.Qty.Name = "Qty";
            // 
            // POSSaleNew
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1084, 693);
            this.Controls.Add(this.ItemSaleGrid);
            this.Controls.Add(this.panel5);
            this.Controls.Add(this.panel1);
            this.KeyPreview = true;
            this.MaximizeBox = false;
            this.Name = "POSSaleNew";
            this.Text = "Corbis Solution";
            this.Load += new System.EventHandler(this.POSSaleNew_Load);
            ((System.ComponentModel.ISupportInitialize)(this.ItemSaleGrid)).EndInit();
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.panel5.ResumeLayout(false);
            this.panel5.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.Timer timer1;
        private System.Windows.Forms.Button btnStock;
        private System.Windows.Forms.Button txtPrint;
        private System.Windows.Forms.Label label18;
        private System.Windows.Forms.Button btnClear;
        private System.Windows.Forms.Button btnSave;
        private System.Windows.Forms.DataGridView ItemSaleGrid;
        private System.Windows.Forms.Label label22;
        private System.Windows.Forms.ComboBox cmbSalemenu;
        private System.Windows.Forms.Label lblShopName;
        private System.Windows.Forms.TextBox txtCustPhone;
        private System.Windows.Forms.TextBox txtCustName;
        private System.Windows.Forms.Label label19;
        private System.Windows.Forms.TextBox txtProductCode;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Label label17;
        private System.Windows.Forms.TextBox txtPayableAmount;
        private System.Windows.Forms.Label label16;
        private System.Windows.Forms.TextBox txtReceivableAmount;
        private System.Windows.Forms.Label label15;
        private System.Windows.Forms.TextBox txtAccAmount;
        private System.Windows.Forms.Label label14;
        private System.Windows.Forms.TextBox txtOtherCharges;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TextBox txtAmountReceive;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.TextBox txtAmountReturn;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox txtTotalTax;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox txtNetAmount;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox txtTotalDiscount;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox txtDiscountAmount;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txtDiscountPercentage;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtGrossAmount;
        private System.Windows.Forms.Panel panel5;
        private System.Windows.Forms.Label label20;
        private System.Windows.Forms.TextBox SalePosID;
        private System.Windows.Forms.Label label21;
        private System.Windows.Forms.DateTimePicker txtSaleDate;
        private System.Windows.Forms.Label lblSaleType;
        private System.Windows.Forms.Label lblDateTime;
        private System.Windows.Forms.TextBox txtInvoiceNo;
        private System.Windows.Forms.TextBox txtProductBarCode;
        private System.Windows.Forms.Label label12;
        private System.Windows.Forms.ComboBox cmbProducts;
        private System.Windows.Forms.TextBox txtRate;
        private System.Windows.Forms.TextBox txtQuantity;
        private System.Windows.Forms.TextBox txtdetailAmount;
        private System.Windows.Forms.TextBox txtTaxAmount;
        private System.Windows.Forms.TextBox txtTax;
        private System.Windows.Forms.TextBox txtProductID;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.TextBox txtAvailableQty;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.DataGridViewTextBoxColumn ProductId;
        private System.Windows.Forms.DataGridViewTextBoxColumn ProductName;
        private System.Windows.Forms.DataGridViewTextBoxColumn Rate;
        private System.Windows.Forms.DataGridViewTextBoxColumn Quantity;
        private System.Windows.Forms.DataGridViewTextBoxColumn Tax;
        private System.Windows.Forms.DataGridViewTextBoxColumn TaxAmount;
        private System.Windows.Forms.DataGridViewTextBoxColumn NetAmount;
        private System.Windows.Forms.DataGridViewTextBoxColumn Qty;
    }
}

