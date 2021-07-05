namespace POS
{
    partial class frmCustomerDataKhaaki
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
            this.btnDelete = new System.Windows.Forms.Button();
            this.btnSearch = new System.Windows.Forms.Button();
            this.label5 = new System.Windows.Forms.Label();
            this.dtRegisterDate = new System.Windows.Forms.DateTimePicker();
            this.panel2 = new System.Windows.Forms.Panel();
            this.txtProfession = new System.Windows.Forms.TextBox();
            this.label11 = new System.Windows.Forms.Label();
            this.txtCnic = new System.Windows.Forms.TextBox();
            this.txtRegisterID = new System.Windows.Forms.TextBox();
            this.txtRno = new System.Windows.Forms.TextBox();
            this.label8 = new System.Windows.Forms.Label();
            this.metroPanel1 = new MetroFramework.Controls.MetroPanel();
            this.txtRemarks = new System.Windows.Forms.TextBox();
            this.label10 = new System.Windows.Forms.Label();
            this.txtAnkle = new System.Windows.Forms.TextBox();
            this.txtBottomLength = new System.Windows.Forms.TextBox();
            this.txthip = new System.Windows.Forms.TextBox();
            this.txtWaist = new System.Windows.Forms.TextBox();
            this.txtCuff = new System.Windows.Forms.TextBox();
            this.txtElbow = new System.Windows.Forms.TextBox();
            this.txtMuscle = new System.Windows.Forms.TextBox();
            this.txtSleeve = new System.Windows.Forms.TextBox();
            this.txtArmHole = new System.Windows.Forms.TextBox();
            this.label24 = new System.Windows.Forms.Label();
            this.label23 = new System.Windows.Forms.Label();
            this.label22 = new System.Windows.Forms.Label();
            this.label21 = new System.Windows.Forms.Label();
            this.label20 = new System.Windows.Forms.Label();
            this.label19 = new System.Windows.Forms.Label();
            this.label18 = new System.Windows.Forms.Label();
            this.label17 = new System.Windows.Forms.Label();
            this.label16 = new System.Windows.Forms.Label();
            this.txtUnderBust = new System.Windows.Forms.TextBox();
            this.txtBust = new System.Windows.Forms.TextBox();
            this.txtUperBust = new System.Windows.Forms.TextBox();
            this.txtShoulder = new System.Windows.Forms.TextBox();
            this.txtBackNeck = new System.Windows.Forms.TextBox();
            this.txtFrontNeck = new System.Windows.Forms.TextBox();
            this.txtNeck = new System.Windows.Forms.TextBox();
            this.label15 = new System.Windows.Forms.Label();
            this.lblUnderBust = new System.Windows.Forms.Label();
            this.lblUpperBust = new System.Windows.Forms.Label();
            this.label12 = new System.Windows.Forms.Label();
            this.lblBackNeck = new System.Windows.Forms.Label();
            this.lblFrontNeck = new System.Windows.Forms.Label();
            this.label9 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.cmbGender = new System.Windows.Forms.ComboBox();
            this.label6 = new System.Windows.Forms.Label();
            this.txtCity = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.txtAddress = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.txtPhone = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.txtCustname = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.panel1.SuspendLayout();
            this.panel2.SuspendLayout();
            this.metroPanel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // btnClear
            // 
            this.btnClear.BackColor = System.Drawing.Color.Goldenrod;
            this.btnClear.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnClear.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnClear.ForeColor = System.Drawing.SystemColors.ButtonFace;
            this.btnClear.Location = new System.Drawing.Point(525, 3);
            this.btnClear.Name = "btnClear";
            this.btnClear.Size = new System.Drawing.Size(115, 31);
            this.btnClear.TabIndex = 22;
            this.btnClear.Text = "Clear ";
            this.btnClear.UseVisualStyleBackColor = false;
            this.btnClear.Click += new System.EventHandler(this.btnClear_Click);
            // 
            // btnSave
            // 
            this.btnSave.BackColor = System.Drawing.Color.MediumSeaGreen;
            this.btnSave.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnSave.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnSave.ForeColor = System.Drawing.SystemColors.ButtonFace;
            this.btnSave.Location = new System.Drawing.Point(404, 3);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(115, 31);
            this.btnSave.TabIndex = 21;
            this.btnSave.Text = "Save ";
            this.btnSave.UseVisualStyleBackColor = false;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.Color.Gainsboro;
            this.panel1.Controls.Add(this.btnDelete);
            this.panel1.Controls.Add(this.btnSearch);
            this.panel1.Controls.Add(this.btnClear);
            this.panel1.Controls.Add(this.btnSave);
            this.panel1.Location = new System.Drawing.Point(47, 297);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(670, 43);
            this.panel1.TabIndex = 23;
            this.panel1.Paint += new System.Windows.Forms.PaintEventHandler(this.panel1_Paint);
            // 
            // btnDelete
            // 
            this.btnDelete.BackColor = System.Drawing.Color.Red;
            this.btnDelete.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnDelete.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnDelete.ForeColor = System.Drawing.SystemColors.ButtonFace;
            this.btnDelete.Location = new System.Drawing.Point(283, 3);
            this.btnDelete.Name = "btnDelete";
            this.btnDelete.Size = new System.Drawing.Size(115, 31);
            this.btnDelete.TabIndex = 24;
            this.btnDelete.Text = "Delete";
            this.btnDelete.UseVisualStyleBackColor = false;
            this.btnDelete.Visible = false;
            // 
            // btnSearch
            // 
            this.btnSearch.BackColor = System.Drawing.Color.DarkSlateBlue;
            this.btnSearch.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnSearch.Font = new System.Drawing.Font("Calibri", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btnSearch.ForeColor = System.Drawing.SystemColors.ButtonFace;
            this.btnSearch.Location = new System.Drawing.Point(283, 3);
            this.btnSearch.Name = "btnSearch";
            this.btnSearch.Size = new System.Drawing.Size(115, 31);
            this.btnSearch.TabIndex = 23;
            this.btnSearch.Text = "Search";
            this.btnSearch.UseVisualStyleBackColor = false;
            this.btnSearch.Click += new System.EventHandler(this.btnSearch_Click);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(349, 21);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(105, 17);
            this.label5.TabIndex = 32;
            this.label5.Text = "Register Date:";
            this.label5.Click += new System.EventHandler(this.label5_Click);
            // 
            // dtRegisterDate
            // 
            this.dtRegisterDate.CalendarFont = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dtRegisterDate.CustomFormat = "dd-MMM-yyyy";
            this.dtRegisterDate.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtRegisterDate.Location = new System.Drawing.Point(460, 21);
            this.dtRegisterDate.Name = "dtRegisterDate";
            this.dtRegisterDate.Size = new System.Drawing.Size(175, 25);
            this.dtRegisterDate.TabIndex = 33;
            // 
            // panel2
            // 
            this.panel2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.panel2.Controls.Add(this.txtProfession);
            this.panel2.Controls.Add(this.label11);
            this.panel2.Controls.Add(this.txtCnic);
            this.panel2.Controls.Add(this.txtRegisterID);
            this.panel2.Controls.Add(this.txtRno);
            this.panel2.Controls.Add(this.label8);
            this.panel2.Controls.Add(this.metroPanel1);
            this.panel2.Controls.Add(this.cmbGender);
            this.panel2.Controls.Add(this.label6);
            this.panel2.Controls.Add(this.txtCity);
            this.panel2.Controls.Add(this.label4);
            this.panel2.Controls.Add(this.txtAddress);
            this.panel2.Controls.Add(this.label3);
            this.panel2.Controls.Add(this.txtPhone);
            this.panel2.Controls.Add(this.label2);
            this.panel2.Controls.Add(this.txtCustname);
            this.panel2.Controls.Add(this.label1);
            this.panel2.Controls.Add(this.label5);
            this.panel2.Controls.Add(this.dtRegisterDate);
            this.panel2.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.panel2.Location = new System.Drawing.Point(47, 83);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(668, 208);
            this.panel2.TabIndex = 34;
            // 
            // txtProfession
            // 
            this.txtProfession.Location = new System.Drawing.Point(129, 83);
            this.txtProfession.Name = "txtProfession";
            this.txtProfession.Size = new System.Drawing.Size(254, 25);
            this.txtProfession.TabIndex = 50;
            this.txtProfession.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtProfession_KeyDown);
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label11.Location = new System.Drawing.Point(40, 83);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(82, 17);
            this.label11.TabIndex = 49;
            this.label11.Text = "Profession:";
            // 
            // txtCnic
            // 
            this.txtCnic.Location = new System.Drawing.Point(8, 75);
            this.txtCnic.Name = "txtCnic";
            this.txtCnic.Size = new System.Drawing.Size(39, 25);
            this.txtCnic.TabIndex = 48;
            this.txtCnic.Visible = false;
            // 
            // txtRegisterID
            // 
            this.txtRegisterID.Location = new System.Drawing.Point(230, 21);
            this.txtRegisterID.Name = "txtRegisterID";
            this.txtRegisterID.Size = new System.Drawing.Size(99, 25);
            this.txtRegisterID.TabIndex = 47;
            this.txtRegisterID.Visible = false;
            // 
            // txtRno
            // 
            this.txtRno.Location = new System.Drawing.Point(128, 21);
            this.txtRno.Name = "txtRno";
            this.txtRno.ReadOnly = true;
            this.txtRno.Size = new System.Drawing.Size(99, 25);
            this.txtRno.TabIndex = 46;
            this.txtRno.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtRno_KeyDown);
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label8.Location = new System.Drawing.Point(16, 24);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(106, 17);
            this.label8.TabIndex = 45;
            this.label8.Text = "Registration #:";
            // 
            // metroPanel1
            // 
            this.metroPanel1.BorderStyle = MetroFramework.Drawing.MetroBorderStyle.FixedSingle;
            this.metroPanel1.Controls.Add(this.txtRemarks);
            this.metroPanel1.Controls.Add(this.label10);
            this.metroPanel1.Controls.Add(this.txtAnkle);
            this.metroPanel1.Controls.Add(this.txtBottomLength);
            this.metroPanel1.Controls.Add(this.txthip);
            this.metroPanel1.Controls.Add(this.txtWaist);
            this.metroPanel1.Controls.Add(this.txtCuff);
            this.metroPanel1.Controls.Add(this.txtElbow);
            this.metroPanel1.Controls.Add(this.txtMuscle);
            this.metroPanel1.Controls.Add(this.txtSleeve);
            this.metroPanel1.Controls.Add(this.txtArmHole);
            this.metroPanel1.Controls.Add(this.label24);
            this.metroPanel1.Controls.Add(this.label23);
            this.metroPanel1.Controls.Add(this.label22);
            this.metroPanel1.Controls.Add(this.label21);
            this.metroPanel1.Controls.Add(this.label20);
            this.metroPanel1.Controls.Add(this.label19);
            this.metroPanel1.Controls.Add(this.label18);
            this.metroPanel1.Controls.Add(this.label17);
            this.metroPanel1.Controls.Add(this.label16);
            this.metroPanel1.Controls.Add(this.txtUnderBust);
            this.metroPanel1.Controls.Add(this.txtBust);
            this.metroPanel1.Controls.Add(this.txtUperBust);
            this.metroPanel1.Controls.Add(this.txtShoulder);
            this.metroPanel1.Controls.Add(this.txtBackNeck);
            this.metroPanel1.Controls.Add(this.txtFrontNeck);
            this.metroPanel1.Controls.Add(this.txtNeck);
            this.metroPanel1.Controls.Add(this.label15);
            this.metroPanel1.Controls.Add(this.lblUnderBust);
            this.metroPanel1.Controls.Add(this.lblUpperBust);
            this.metroPanel1.Controls.Add(this.label12);
            this.metroPanel1.Controls.Add(this.lblBackNeck);
            this.metroPanel1.Controls.Add(this.lblFrontNeck);
            this.metroPanel1.Controls.Add(this.label9);
            this.metroPanel1.Controls.Add(this.label7);
            this.metroPanel1.HorizontalScrollbarBarColor = true;
            this.metroPanel1.HorizontalScrollbarHighlightOnWheel = false;
            this.metroPanel1.HorizontalScrollbarSize = 10;
            this.metroPanel1.Location = new System.Drawing.Point(14, 96);
            this.metroPanel1.Name = "metroPanel1";
            this.metroPanel1.Size = new System.Drawing.Size(52, 20);
            this.metroPanel1.TabIndex = 44;
            this.metroPanel1.VerticalScrollbarBarColor = true;
            this.metroPanel1.VerticalScrollbarHighlightOnWheel = false;
            this.metroPanel1.VerticalScrollbarSize = 10;
            this.metroPanel1.Visible = false;
            // 
            // txtRemarks
            // 
            this.txtRemarks.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtRemarks.Location = new System.Drawing.Point(116, 196);
            this.txtRemarks.Multiline = true;
            this.txtRemarks.Name = "txtRemarks";
            this.txtRemarks.Size = new System.Drawing.Size(496, 37);
            this.txtRemarks.TabIndex = 79;
            this.txtRemarks.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtRemarks_KeyDown);
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label10.Location = new System.Drawing.Point(47, 208);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(65, 15);
            this.label10.TabIndex = 78;
            this.label10.Text = "Remarks :";
            // 
            // txtAnkle
            // 
            this.txtAnkle.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtAnkle.Location = new System.Drawing.Point(512, 164);
            this.txtAnkle.Name = "txtAnkle";
            this.txtAnkle.Size = new System.Drawing.Size(100, 22);
            this.txtAnkle.TabIndex = 77;
            this.txtAnkle.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtAnkle_KeyDown);
            // 
            // txtBottomLength
            // 
            this.txtBottomLength.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtBottomLength.Location = new System.Drawing.Point(317, 168);
            this.txtBottomLength.Name = "txtBottomLength";
            this.txtBottomLength.Size = new System.Drawing.Size(100, 22);
            this.txtBottomLength.TabIndex = 76;
            this.txtBottomLength.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtBottomLength_KeyDown);
            // 
            // txthip
            // 
            this.txthip.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txthip.Location = new System.Drawing.Point(116, 168);
            this.txthip.Name = "txthip";
            this.txthip.Size = new System.Drawing.Size(100, 22);
            this.txthip.TabIndex = 75;
            this.txthip.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txthip_KeyDown);
            // 
            // txtWaist
            // 
            this.txtWaist.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtWaist.Location = new System.Drawing.Point(512, 132);
            this.txtWaist.Name = "txtWaist";
            this.txtWaist.Size = new System.Drawing.Size(100, 22);
            this.txtWaist.TabIndex = 74;
            this.txtWaist.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtWaist_KeyDown);
            // 
            // txtCuff
            // 
            this.txtCuff.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtCuff.Location = new System.Drawing.Point(317, 136);
            this.txtCuff.Name = "txtCuff";
            this.txtCuff.Size = new System.Drawing.Size(100, 22);
            this.txtCuff.TabIndex = 73;
            this.txtCuff.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtCuff_KeyDown);
            // 
            // txtElbow
            // 
            this.txtElbow.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtElbow.Location = new System.Drawing.Point(116, 136);
            this.txtElbow.Name = "txtElbow";
            this.txtElbow.Size = new System.Drawing.Size(100, 22);
            this.txtElbow.TabIndex = 72;
            this.txtElbow.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtElbow_KeyDown);
            // 
            // txtMuscle
            // 
            this.txtMuscle.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtMuscle.Location = new System.Drawing.Point(512, 103);
            this.txtMuscle.Name = "txtMuscle";
            this.txtMuscle.Size = new System.Drawing.Size(100, 22);
            this.txtMuscle.TabIndex = 71;
            this.txtMuscle.TextChanged += new System.EventHandler(this.txtMuscle_TextChanged);
            this.txtMuscle.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtMuscle_KeyDown);
            // 
            // txtSleeve
            // 
            this.txtSleeve.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtSleeve.Location = new System.Drawing.Point(317, 101);
            this.txtSleeve.Name = "txtSleeve";
            this.txtSleeve.Size = new System.Drawing.Size(100, 22);
            this.txtSleeve.TabIndex = 70;
            this.txtSleeve.TextChanged += new System.EventHandler(this.txtSleeve_TextChanged);
            this.txtSleeve.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtSleeve_KeyDown);
            // 
            // txtArmHole
            // 
            this.txtArmHole.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtArmHole.Location = new System.Drawing.Point(116, 103);
            this.txtArmHole.Name = "txtArmHole";
            this.txtArmHole.Size = new System.Drawing.Size(100, 22);
            this.txtArmHole.TabIndex = 69;
            this.txtArmHole.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtArmHole_KeyDown);
            // 
            // label24
            // 
            this.label24.AutoSize = true;
            this.label24.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label24.Location = new System.Drawing.Point(452, 171);
            this.label24.Name = "label24";
            this.label24.Size = new System.Drawing.Size(48, 15);
            this.label24.TabIndex = 68;
            this.label24.Text = "Ankle :";
            // 
            // label23
            // 
            this.label23.AutoSize = true;
            this.label23.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label23.Location = new System.Drawing.Point(216, 171);
            this.label23.Name = "label23";
            this.label23.Size = new System.Drawing.Size(95, 15);
            this.label23.TabIndex = 67;
            this.label23.Text = "Bottom Length :";
            this.label23.Click += new System.EventHandler(this.label23_Click);
            // 
            // label22
            // 
            this.label22.AutoSize = true;
            this.label22.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label22.Location = new System.Drawing.Point(79, 171);
            this.label22.Name = "label22";
            this.label22.Size = new System.Drawing.Size(33, 15);
            this.label22.TabIndex = 66;
            this.label22.Text = "Hip :";
            // 
            // label21
            // 
            this.label21.AutoSize = true;
            this.label21.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label21.Location = new System.Drawing.Point(454, 139);
            this.label21.Name = "label21";
            this.label21.Size = new System.Drawing.Size(46, 15);
            this.label21.TabIndex = 65;
            this.label21.Text = "Waist :";
            // 
            // label20
            // 
            this.label20.AutoSize = true;
            this.label20.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label20.Location = new System.Drawing.Point(276, 139);
            this.label20.Name = "label20";
            this.label20.Size = new System.Drawing.Size(35, 15);
            this.label20.TabIndex = 64;
            this.label20.Text = "Cuff:";
            this.label20.Click += new System.EventHandler(this.label20_Click);
            // 
            // label19
            // 
            this.label19.AutoSize = true;
            this.label19.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label19.Location = new System.Drawing.Point(67, 139);
            this.label19.Name = "label19";
            this.label19.Size = new System.Drawing.Size(45, 15);
            this.label19.TabIndex = 63;
            this.label19.Text = "Elbow :";
            // 
            // label18
            // 
            this.label18.AutoSize = true;
            this.label18.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label18.Location = new System.Drawing.Point(446, 108);
            this.label18.Name = "label18";
            this.label18.Size = new System.Drawing.Size(54, 15);
            this.label18.TabIndex = 62;
            this.label18.Text = "Muscle :";
            // 
            // label17
            // 
            this.label17.AutoSize = true;
            this.label17.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label17.Location = new System.Drawing.Point(220, 108);
            this.label17.Name = "label17";
            this.label17.Size = new System.Drawing.Size(91, 15);
            this.label17.TabIndex = 61;
            this.label17.Text = "Sleeve Length :";
            this.label17.Click += new System.EventHandler(this.label17_Click);
            // 
            // label16
            // 
            this.label16.AutoSize = true;
            this.label16.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label16.Location = new System.Drawing.Point(45, 108);
            this.label16.Name = "label16";
            this.label16.Size = new System.Drawing.Size(67, 15);
            this.label16.TabIndex = 60;
            this.label16.Text = "Arm Hole :";
            // 
            // txtUnderBust
            // 
            this.txtUnderBust.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtUnderBust.Location = new System.Drawing.Point(512, 75);
            this.txtUnderBust.Name = "txtUnderBust";
            this.txtUnderBust.Size = new System.Drawing.Size(100, 22);
            this.txtUnderBust.TabIndex = 59;
            this.txtUnderBust.TextChanged += new System.EventHandler(this.txtUnderBust_TextChanged);
            this.txtUnderBust.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtUnderBust_KeyDown);
            // 
            // txtBust
            // 
            this.txtBust.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtBust.Location = new System.Drawing.Point(116, 75);
            this.txtBust.Name = "txtBust";
            this.txtBust.Size = new System.Drawing.Size(100, 22);
            this.txtBust.TabIndex = 58;
            this.txtBust.TextChanged += new System.EventHandler(this.txtBust_TextChanged);
            this.txtBust.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtBust_KeyDown);
            // 
            // txtUperBust
            // 
            this.txtUperBust.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtUperBust.Location = new System.Drawing.Point(317, 75);
            this.txtUperBust.Name = "txtUperBust";
            this.txtUperBust.Size = new System.Drawing.Size(100, 22);
            this.txtUperBust.TabIndex = 57;
            this.txtUperBust.TextChanged += new System.EventHandler(this.txtUperBust_TextChanged);
            this.txtUperBust.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtUperBust_KeyDown);
            // 
            // txtShoulder
            // 
            this.txtShoulder.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtShoulder.Location = new System.Drawing.Point(116, 47);
            this.txtShoulder.Name = "txtShoulder";
            this.txtShoulder.Size = new System.Drawing.Size(100, 22);
            this.txtShoulder.TabIndex = 56;
            this.txtShoulder.TextChanged += new System.EventHandler(this.txtShoulder_TextChanged);
            this.txtShoulder.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtShoulder_KeyDown);
            // 
            // txtBackNeck
            // 
            this.txtBackNeck.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtBackNeck.Location = new System.Drawing.Point(512, 19);
            this.txtBackNeck.Name = "txtBackNeck";
            this.txtBackNeck.Size = new System.Drawing.Size(100, 22);
            this.txtBackNeck.TabIndex = 55;
            this.txtBackNeck.TextChanged += new System.EventHandler(this.txtBackNeck_TextChanged);
            this.txtBackNeck.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtBackNeck_KeyDown);
            // 
            // txtFrontNeck
            // 
            this.txtFrontNeck.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtFrontNeck.Location = new System.Drawing.Point(317, 19);
            this.txtFrontNeck.Name = "txtFrontNeck";
            this.txtFrontNeck.Size = new System.Drawing.Size(100, 22);
            this.txtFrontNeck.TabIndex = 54;
            this.txtFrontNeck.TextChanged += new System.EventHandler(this.txtFrontNeck_TextChanged);
            this.txtFrontNeck.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtFrontNeck_KeyDown);
            // 
            // txtNeck
            // 
            this.txtNeck.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txtNeck.Location = new System.Drawing.Point(116, 19);
            this.txtNeck.Name = "txtNeck";
            this.txtNeck.Size = new System.Drawing.Size(100, 22);
            this.txtNeck.TabIndex = 47;
            this.txtNeck.TextChanged += new System.EventHandler(this.txtNeck_TextChanged);
            this.txtNeck.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtNeck_KeyDown);
            // 
            // label15
            // 
            this.label15.AutoSize = true;
            this.label15.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label15.Location = new System.Drawing.Point(72, 79);
            this.label15.Name = "label15";
            this.label15.Size = new System.Drawing.Size(40, 15);
            this.label15.TabIndex = 53;
            this.label15.Text = "Bust :";
            // 
            // lblUnderBust
            // 
            this.lblUnderBust.AutoSize = true;
            this.lblUnderBust.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblUnderBust.Location = new System.Drawing.Point(424, 79);
            this.lblUnderBust.Name = "lblUnderBust";
            this.lblUnderBust.Size = new System.Drawing.Size(76, 15);
            this.lblUnderBust.TabIndex = 52;
            this.lblUnderBust.Text = "Under Bust :";
            // 
            // lblUpperBust
            // 
            this.lblUpperBust.AutoSize = true;
            this.lblUpperBust.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblUpperBust.Location = new System.Drawing.Point(236, 79);
            this.lblUpperBust.Name = "lblUpperBust";
            this.lblUpperBust.Size = new System.Drawing.Size(75, 15);
            this.lblUpperBust.TabIndex = 51;
            this.lblUpperBust.Text = "Upper Bust :";
            this.lblUpperBust.Click += new System.EventHandler(this.label13_Click);
            // 
            // label12
            // 
            this.label12.AutoSize = true;
            this.label12.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label12.Location = new System.Drawing.Point(48, 50);
            this.label12.Name = "label12";
            this.label12.Size = new System.Drawing.Size(64, 15);
            this.label12.TabIndex = 50;
            this.label12.Text = "Shoulder :";
            // 
            // lblBackNeck
            // 
            this.lblBackNeck.AutoSize = true;
            this.lblBackNeck.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblBackNeck.Location = new System.Drawing.Point(425, 22);
            this.lblBackNeck.Name = "lblBackNeck";
            this.lblBackNeck.Size = new System.Drawing.Size(75, 15);
            this.lblBackNeck.TabIndex = 49;
            this.lblBackNeck.Text = "Back Neck :";
            // 
            // lblFrontNeck
            // 
            this.lblFrontNeck.AutoSize = true;
            this.lblFrontNeck.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblFrontNeck.Location = new System.Drawing.Point(235, 22);
            this.lblFrontNeck.Name = "lblFrontNeck";
            this.lblFrontNeck.Size = new System.Drawing.Size(76, 15);
            this.lblFrontNeck.TabIndex = 48;
            this.lblFrontNeck.Text = "Front Neck :";
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label9.Location = new System.Drawing.Point(69, 22);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(43, 15);
            this.label9.TabIndex = 47;
            this.label9.Text = "Neck :";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Dock = System.Windows.Forms.DockStyle.Fill;
            this.label7.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.ForeColor = System.Drawing.Color.Blue;
            this.label7.Location = new System.Drawing.Point(0, 0);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(107, 17);
            this.label7.TabIndex = 45;
            this.label7.Text = "Measurements";
            // 
            // cmbGender
            // 
            this.cmbGender.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.SuggestAppend;
            this.cmbGender.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems;
            this.cmbGender.FormattingEnabled = true;
            this.cmbGender.Location = new System.Drawing.Point(461, 83);
            this.cmbGender.Name = "cmbGender";
            this.cmbGender.Size = new System.Drawing.Size(175, 25);
            this.cmbGender.TabIndex = 43;
            this.cmbGender.SelectedIndexChanged += new System.EventHandler(this.cmbGender_SelectedIndexChanged);
            this.cmbGender.KeyDown += new System.Windows.Forms.KeyEventHandler(this.cmbGender_KeyDown);
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.Location = new System.Drawing.Point(392, 83);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(62, 17);
            this.label6.TabIndex = 42;
            this.label6.Text = "Gender:";
            // 
            // txtCity
            // 
            this.txtCity.Location = new System.Drawing.Point(128, 147);
            this.txtCity.Name = "txtCity";
            this.txtCity.Size = new System.Drawing.Size(255, 25);
            this.txtCity.TabIndex = 41;
            this.txtCity.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtCity_KeyDown);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(82, 150);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(40, 17);
            this.label4.TabIndex = 40;
            this.label4.Text = "City:";
            // 
            // txtAddress
            // 
            this.txtAddress.Location = new System.Drawing.Point(128, 116);
            this.txtAddress.Name = "txtAddress";
            this.txtAddress.Size = new System.Drawing.Size(507, 25);
            this.txtAddress.TabIndex = 39;
            this.txtAddress.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtAddress_KeyDown);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(54, 119);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(68, 17);
            this.label3.TabIndex = 38;
            this.label3.Text = "Address:";
            // 
            // txtPhone
            // 
            this.txtPhone.Location = new System.Drawing.Point(460, 52);
            this.txtPhone.Name = "txtPhone";
            this.txtPhone.Size = new System.Drawing.Size(176, 25);
            this.txtPhone.TabIndex = 37;
            this.txtPhone.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtPhone_KeyDown);
            this.txtPhone.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.txtPhone_KeyPress);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(388, 52);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(66, 17);
            this.label2.TabIndex = 36;
            this.label2.Text = "Phone #:";
            // 
            // txtCustname
            // 
            this.txtCustname.Location = new System.Drawing.Point(129, 52);
            this.txtCustname.Name = "txtCustname";
            this.txtCustname.Size = new System.Drawing.Size(254, 25);
            this.txtCustname.TabIndex = 35;
            this.txtCustname.KeyDown += new System.Windows.Forms.KeyEventHandler(this.txtCustname_KeyDown);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(2, 55);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(120, 17);
            this.label1.TabIndex = 34;
            this.label1.Text = "Customer Name:";
            // 
            // frmCustomerDataKhaaki
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(784, 402);
            this.Controls.Add(this.panel2);
            this.Controls.Add(this.panel1);
            this.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(0)))), ((int)(((byte)(64)))));
            this.Name = "frmCustomerDataKhaaki";
            this.Text = "New Customer Registration";
            this.Load += new System.EventHandler(this.frmCustomerDataKhaaki_Load);
            this.panel1.ResumeLayout(false);
            this.panel2.ResumeLayout(false);
            this.panel2.PerformLayout();
            this.metroPanel1.ResumeLayout(false);
            this.metroPanel1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.Button btnClear;
        private System.Windows.Forms.Button btnSave;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.DateTimePicker dtRegisterDate;
        private System.Windows.Forms.Panel panel2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtCustname;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox txtPhone;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox txtAddress;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox txtCity;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.ComboBox cmbGender;
        private MetroFramework.Controls.MetroPanel metroPanel1;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.TextBox txtRno;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Label lblFrontNeck;
        private System.Windows.Forms.Label lblBackNeck;
        private System.Windows.Forms.Label label12;
        private System.Windows.Forms.Label lblUnderBust;
        private System.Windows.Forms.Label lblUpperBust;
        private System.Windows.Forms.Label label15;
        private System.Windows.Forms.TextBox txtNeck;
        private System.Windows.Forms.TextBox txtBackNeck;
        private System.Windows.Forms.TextBox txtFrontNeck;
        private System.Windows.Forms.TextBox txtShoulder;
        private System.Windows.Forms.TextBox txtUperBust;
        private System.Windows.Forms.TextBox txtBust;
        private System.Windows.Forms.TextBox txtUnderBust;
        private System.Windows.Forms.Label label16;
        private System.Windows.Forms.Label label17;
        private System.Windows.Forms.Label label18;
        private System.Windows.Forms.Label label22;
        private System.Windows.Forms.Label label21;
        private System.Windows.Forms.Label label20;
        private System.Windows.Forms.Label label19;
        private System.Windows.Forms.Label label23;
        private System.Windows.Forms.Label label24;
        private System.Windows.Forms.TextBox txtArmHole;
        private System.Windows.Forms.TextBox txtSleeve;
        private System.Windows.Forms.TextBox txtMuscle;
        private System.Windows.Forms.TextBox txtAnkle;
        private System.Windows.Forms.TextBox txtBottomLength;
        private System.Windows.Forms.TextBox txthip;
        private System.Windows.Forms.TextBox txtWaist;
        private System.Windows.Forms.TextBox txtCuff;
        private System.Windows.Forms.TextBox txtElbow;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.TextBox txtRemarks;
        private System.Windows.Forms.TextBox txtRegisterID;
        private System.Windows.Forms.TextBox txtCnic;
        private System.Windows.Forms.Button btnSearch;
        private System.Windows.Forms.Button btnDelete;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.TextBox txtProfession;
    }
}