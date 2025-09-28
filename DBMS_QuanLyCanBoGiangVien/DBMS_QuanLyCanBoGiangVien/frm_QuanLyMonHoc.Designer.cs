namespace DBMS_QuanLyCanBoGiangVien
{
    partial class frm_QuanLyMonHoc
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
            this.splitContainerControl1 = new DevExpress.XtraEditors.SplitContainerControl();
            this.label1 = new System.Windows.Forms.Label();
            this.dgv_MonHoc = new System.Windows.Forms.DataGridView();
            this.MaMon = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.TenMon = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.SoTiet = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.SoTinChi = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.BatBuoc = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.btn_TimKiem = new System.Windows.Forms.Button();
            this.txt_TimMon = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.chk_BatBuoc = new System.Windows.Forms.CheckBox();
            this.btn_Thoat = new System.Windows.Forms.Button();
            this.btn_LamMoi = new System.Windows.Forms.Button();
            this.btn_Xoa = new System.Windows.Forms.Button();
            this.btn_Sua = new System.Windows.Forms.Button();
            this.btn_Them = new System.Windows.Forms.Button();
            this.txt_SoTinChi = new System.Windows.Forms.TextBox();
            this.txt_SoTiet = new System.Windows.Forms.TextBox();
            this.txt_TenMon = new System.Windows.Forms.TextBox();
            this.txt_MaMon = new System.Windows.Forms.TextBox();
            this.label9 = new System.Windows.Forms.Label();
            this.label8 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.txt_ChuongTrinh = new System.Windows.Forms.TextBox();
            this.cb_TenNganh = new System.Windows.Forms.ComboBox();
            this.cb_TenKhoa = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1.Panel1)).BeginInit();
            this.splitContainerControl1.Panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1.Panel2)).BeginInit();
            this.splitContainerControl1.Panel2.SuspendLayout();
            this.splitContainerControl1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_MonHoc)).BeginInit();
            this.groupBox2.SuspendLayout();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // splitContainerControl1
            // 
            this.splitContainerControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainerControl1.Horizontal = false;
            this.splitContainerControl1.Location = new System.Drawing.Point(0, 0);
            this.splitContainerControl1.Margin = new System.Windows.Forms.Padding(9, 8, 9, 8);
            this.splitContainerControl1.Name = "splitContainerControl1";
            // 
            // splitContainerControl1.Panel1
            // 
            this.splitContainerControl1.Panel1.Controls.Add(this.label1);
            this.splitContainerControl1.Panel1.Text = "Panel1";
            // 
            // splitContainerControl1.Panel2
            // 
            this.splitContainerControl1.Panel2.Controls.Add(this.dgv_MonHoc);
            this.splitContainerControl1.Panel2.Controls.Add(this.groupBox2);
            this.splitContainerControl1.Panel2.Controls.Add(this.groupBox1);
            this.splitContainerControl1.Panel2.Text = "Panel2";
            this.splitContainerControl1.Size = new System.Drawing.Size(1554, 852);
            this.splitContainerControl1.SplitterPosition = 126;
            this.splitContainerControl1.TabIndex = 0;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Arial", 22F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(583, 45);
            this.label1.Margin = new System.Windows.Forms.Padding(8, 0, 8, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(390, 51);
            this.label1.TabIndex = 5;
            this.label1.Text = "Quản Lý Môn học";
            // 
            // dgv_MonHoc
            // 
            this.dgv_MonHoc.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgv_MonHoc.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.MaMon,
            this.TenMon,
            this.SoTiet,
            this.SoTinChi,
            this.BatBuoc});
            this.dgv_MonHoc.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgv_MonHoc.Location = new System.Drawing.Point(0, 216);
            this.dgv_MonHoc.Margin = new System.Windows.Forms.Padding(4);
            this.dgv_MonHoc.Name = "dgv_MonHoc";
            this.dgv_MonHoc.RowHeadersWidth = 62;
            this.dgv_MonHoc.RowTemplate.Height = 28;
            this.dgv_MonHoc.Size = new System.Drawing.Size(754, 495);
            this.dgv_MonHoc.TabIndex = 2;
            this.dgv_MonHoc.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgv_MonHoc_CellClick);
            // 
            // MaMon
            // 
            this.MaMon.DataPropertyName = "MaMon";
            this.MaMon.HeaderText = "Mã Môn";
            this.MaMon.MinimumWidth = 8;
            this.MaMon.Name = "MaMon";
            this.MaMon.Width = 160;
            // 
            // TenMon
            // 
            this.TenMon.DataPropertyName = "TenMon";
            this.TenMon.HeaderText = "Tên Môn";
            this.TenMon.MinimumWidth = 8;
            this.TenMon.Name = "TenMon";
            this.TenMon.Width = 300;
            // 
            // SoTiet
            // 
            this.SoTiet.DataPropertyName = "SoTiet";
            this.SoTiet.HeaderText = "Số Tiết";
            this.SoTiet.MinimumWidth = 8;
            this.SoTiet.Name = "SoTiet";
            this.SoTiet.Width = 95;
            // 
            // SoTinChi
            // 
            this.SoTinChi.DataPropertyName = "SoTinChi";
            this.SoTinChi.HeaderText = "Số Tín Chỉ";
            this.SoTinChi.MinimumWidth = 8;
            this.SoTinChi.Name = "SoTinChi";
            this.SoTinChi.Width = 95;
            // 
            // BatBuoc
            // 
            this.BatBuoc.DataPropertyName = "BatBuoc";
            this.BatBuoc.HeaderText = "Bắt Buộc";
            this.BatBuoc.MinimumWidth = 8;
            this.BatBuoc.Name = "BatBuoc";
            this.BatBuoc.Width = 120;
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.btn_TimKiem);
            this.groupBox2.Controls.Add(this.txt_TimMon);
            this.groupBox2.Controls.Add(this.label5);
            this.groupBox2.Dock = System.Windows.Forms.DockStyle.Top;
            this.groupBox2.Font = new System.Drawing.Font("Tahoma", 11F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox2.Location = new System.Drawing.Point(0, 0);
            this.groupBox2.Margin = new System.Windows.Forms.Padding(8, 6, 8, 6);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Padding = new System.Windows.Forms.Padding(8, 6, 8, 6);
            this.groupBox2.Size = new System.Drawing.Size(754, 216);
            this.groupBox2.TabIndex = 1;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Tìm Môn";
            // 
            // btn_TimKiem
            // 
            this.btn_TimKiem.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_TimKiem.Location = new System.Drawing.Point(543, 94);
            this.btn_TimKiem.Margin = new System.Windows.Forms.Padding(8, 6, 8, 6);
            this.btn_TimKiem.Name = "btn_TimKiem";
            this.btn_TimKiem.Size = new System.Drawing.Size(129, 45);
            this.btn_TimKiem.TabIndex = 3;
            this.btn_TimKiem.Text = "Tìm kiếm";
            this.btn_TimKiem.UseVisualStyleBackColor = true;
            this.btn_TimKiem.Click += new System.EventHandler(this.btn_TimKiem_Click);
            // 
            // txt_TimMon
            // 
            this.txt_TimMon.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txt_TimMon.Location = new System.Drawing.Point(238, 93);
            this.txt_TimMon.Margin = new System.Windows.Forms.Padding(8, 6, 8, 6);
            this.txt_TimMon.Name = "txt_TimMon";
            this.txt_TimMon.Size = new System.Drawing.Size(192, 46);
            this.txt_TimMon.TabIndex = 2;
            this.txt_TimMon.TextChanged += new System.EventHandler(this.txt_TimMon_TextChanged);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(21, 96);
            this.label5.Margin = new System.Windows.Forms.Padding(8, 0, 8, 0);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(154, 39);
            this.label5.TabIndex = 1;
            this.label5.Text = "Tên môn:";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.chk_BatBuoc);
            this.groupBox1.Controls.Add(this.btn_Thoat);
            this.groupBox1.Controls.Add(this.btn_LamMoi);
            this.groupBox1.Controls.Add(this.btn_Xoa);
            this.groupBox1.Controls.Add(this.btn_Sua);
            this.groupBox1.Controls.Add(this.btn_Them);
            this.groupBox1.Controls.Add(this.txt_SoTinChi);
            this.groupBox1.Controls.Add(this.txt_SoTiet);
            this.groupBox1.Controls.Add(this.txt_TenMon);
            this.groupBox1.Controls.Add(this.txt_MaMon);
            this.groupBox1.Controls.Add(this.label9);
            this.groupBox1.Controls.Add(this.label8);
            this.groupBox1.Controls.Add(this.label7);
            this.groupBox1.Controls.Add(this.label6);
            this.groupBox1.Controls.Add(this.txt_ChuongTrinh);
            this.groupBox1.Controls.Add(this.cb_TenNganh);
            this.groupBox1.Controls.Add(this.cb_TenKhoa);
            this.groupBox1.Controls.Add(this.label4);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Dock = System.Windows.Forms.DockStyle.Right;
            this.groupBox1.Font = new System.Drawing.Font("Tahoma", 11F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(754, 0);
            this.groupBox1.Margin = new System.Windows.Forms.Padding(8, 6, 8, 6);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Padding = new System.Windows.Forms.Padding(8, 6, 8, 6);
            this.groupBox1.Size = new System.Drawing.Size(800, 711);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Thông tin Môn";
            this.groupBox1.Enter += new System.EventHandler(this.groupBox1_Enter);
            // 
            // chk_BatBuoc
            // 
            this.chk_BatBuoc.AutoSize = true;
            this.chk_BatBuoc.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.chk_BatBuoc.Location = new System.Drawing.Point(637, 404);
            this.chk_BatBuoc.Margin = new System.Windows.Forms.Padding(4);
            this.chk_BatBuoc.Name = "chk_BatBuoc";
            this.chk_BatBuoc.Size = new System.Drawing.Size(169, 43);
            this.chk_BatBuoc.TabIndex = 19;
            this.chk_BatBuoc.Text = "Bắt Buộc";
            this.chk_BatBuoc.UseVisualStyleBackColor = true;
            // 
            // btn_Thoat
            // 
            this.btn_Thoat.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_Thoat.Location = new System.Drawing.Point(447, 617);
            this.btn_Thoat.Margin = new System.Windows.Forms.Padding(8, 6, 8, 6);
            this.btn_Thoat.Name = "btn_Thoat";
            this.btn_Thoat.Size = new System.Drawing.Size(207, 64);
            this.btn_Thoat.TabIndex = 17;
            this.btn_Thoat.Text = "Thoát";
            this.btn_Thoat.UseVisualStyleBackColor = true;
            this.btn_Thoat.Click += new System.EventHandler(this.btn_Thoat_Click);
            // 
            // btn_LamMoi
            // 
            this.btn_LamMoi.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_LamMoi.Location = new System.Drawing.Point(151, 617);
            this.btn_LamMoi.Margin = new System.Windows.Forms.Padding(8, 6, 8, 6);
            this.btn_LamMoi.Name = "btn_LamMoi";
            this.btn_LamMoi.Size = new System.Drawing.Size(207, 64);
            this.btn_LamMoi.TabIndex = 16;
            this.btn_LamMoi.Text = "Làm Mới";
            this.btn_LamMoi.UseVisualStyleBackColor = true;
            this.btn_LamMoi.Click += new System.EventHandler(this.btn_LamMoi_Click);
            // 
            // btn_Xoa
            // 
            this.btn_Xoa.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_Xoa.Location = new System.Drawing.Point(554, 521);
            this.btn_Xoa.Margin = new System.Windows.Forms.Padding(8, 6, 8, 6);
            this.btn_Xoa.Name = "btn_Xoa";
            this.btn_Xoa.Size = new System.Drawing.Size(207, 64);
            this.btn_Xoa.TabIndex = 15;
            this.btn_Xoa.Text = "Xóa";
            this.btn_Xoa.UseVisualStyleBackColor = true;
            this.btn_Xoa.Click += new System.EventHandler(this.btn_Xoa_Click);
            // 
            // btn_Sua
            // 
            this.btn_Sua.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_Sua.Location = new System.Drawing.Point(289, 521);
            this.btn_Sua.Margin = new System.Windows.Forms.Padding(8, 6, 8, 6);
            this.btn_Sua.Name = "btn_Sua";
            this.btn_Sua.Size = new System.Drawing.Size(207, 64);
            this.btn_Sua.TabIndex = 14;
            this.btn_Sua.Text = "Sửa";
            this.btn_Sua.UseVisualStyleBackColor = true;
            this.btn_Sua.Click += new System.EventHandler(this.btn_Sua_Click);
            // 
            // btn_Them
            // 
            this.btn_Them.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_Them.Location = new System.Drawing.Point(22, 521);
            this.btn_Them.Margin = new System.Windows.Forms.Padding(8, 6, 8, 6);
            this.btn_Them.Name = "btn_Them";
            this.btn_Them.Size = new System.Drawing.Size(207, 64);
            this.btn_Them.TabIndex = 4;
            this.btn_Them.Text = "Thêm";
            this.btn_Them.UseVisualStyleBackColor = true;
            this.btn_Them.Click += new System.EventHandler(this.btn_Them_Click);
            // 
            // txt_SoTinChi
            // 
            this.txt_SoTinChi.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txt_SoTinChi.Location = new System.Drawing.Point(438, 402);
            this.txt_SoTinChi.Margin = new System.Windows.Forms.Padding(4);
            this.txt_SoTinChi.Name = "txt_SoTinChi";
            this.txt_SoTinChi.Size = new System.Drawing.Size(140, 46);
            this.txt_SoTinChi.TabIndex = 13;
            this.txt_SoTinChi.TextChanged += new System.EventHandler(this.txt_SoTinChi_TextChanged);
            // 
            // txt_SoTiet
            // 
            this.txt_SoTiet.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txt_SoTiet.Location = new System.Drawing.Point(114, 402);
            this.txt_SoTiet.Margin = new System.Windows.Forms.Padding(4);
            this.txt_SoTiet.Name = "txt_SoTiet";
            this.txt_SoTiet.Size = new System.Drawing.Size(140, 46);
            this.txt_SoTiet.TabIndex = 12;
            this.txt_SoTiet.TextChanged += new System.EventHandler(this.txt_SoTiet_TextChanged);
            // 
            // txt_TenMon
            // 
            this.txt_TenMon.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txt_TenMon.Location = new System.Drawing.Point(541, 299);
            this.txt_TenMon.Margin = new System.Windows.Forms.Padding(4);
            this.txt_TenMon.Name = "txt_TenMon";
            this.txt_TenMon.Size = new System.Drawing.Size(239, 46);
            this.txt_TenMon.TabIndex = 11;
            this.txt_TenMon.TextChanged += new System.EventHandler(this.txt_TenMon_TextChanged);
            // 
            // txt_MaMon
            // 
            this.txt_MaMon.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txt_MaMon.Location = new System.Drawing.Point(141, 302);
            this.txt_MaMon.Margin = new System.Windows.Forms.Padding(4);
            this.txt_MaMon.Name = "txt_MaMon";
            this.txt_MaMon.Size = new System.Drawing.Size(239, 46);
            this.txt_MaMon.TabIndex = 10;
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label9.Location = new System.Drawing.Point(284, 405);
            this.label9.Margin = new System.Windows.Forms.Padding(8, 0, 8, 0);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(171, 39);
            this.label9.TabIndex = 9;
            this.label9.Text = "Số Tín Chỉ:";
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label8.Location = new System.Drawing.Point(7, 409);
            this.label8.Margin = new System.Windows.Forms.Padding(8, 0, 8, 0);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(127, 39);
            this.label8.TabIndex = 8;
            this.label8.Text = "Số Tiết:";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.Location = new System.Drawing.Point(392, 305);
            this.label7.Margin = new System.Windows.Forms.Padding(8, 0, 8, 0);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(152, 39);
            this.label7.TabIndex = 7;
            this.label7.Text = "Tên Môn:";
            this.label7.Click += new System.EventHandler(this.label7_Click);
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.Location = new System.Drawing.Point(7, 302);
            this.label6.Margin = new System.Windows.Forms.Padding(8, 0, 8, 0);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(140, 39);
            this.label6.TabIndex = 6;
            this.label6.Text = "Mã Môn:";
            this.label6.Click += new System.EventHandler(this.label6_Click);
            // 
            // txt_ChuongTrinh
            // 
            this.txt_ChuongTrinh.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txt_ChuongTrinh.Location = new System.Drawing.Point(246, 196);
            this.txt_ChuongTrinh.Margin = new System.Windows.Forms.Padding(4);
            this.txt_ChuongTrinh.Name = "txt_ChuongTrinh";
            this.txt_ChuongTrinh.Size = new System.Drawing.Size(515, 46);
            this.txt_ChuongTrinh.TabIndex = 5;
            // 
            // cb_TenNganh
            // 
            this.cb_TenNganh.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cb_TenNganh.FormattingEnabled = true;
            this.cb_TenNganh.Location = new System.Drawing.Point(518, 102);
            this.cb_TenNganh.Margin = new System.Windows.Forms.Padding(4);
            this.cb_TenNganh.Name = "cb_TenNganh";
            this.cb_TenNganh.Size = new System.Drawing.Size(259, 47);
            this.cb_TenNganh.TabIndex = 4;
            this.cb_TenNganh.SelectedIndexChanged += new System.EventHandler(this.cb_TenNganh_SelectedIndexChanged);
            // 
            // cb_TenKhoa
            // 
            this.cb_TenKhoa.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cb_TenKhoa.FormattingEnabled = true;
            this.cb_TenKhoa.Location = new System.Drawing.Point(128, 102);
            this.cb_TenKhoa.Margin = new System.Windows.Forms.Padding(4);
            this.cb_TenKhoa.Name = "cb_TenKhoa";
            this.cb_TenKhoa.Size = new System.Drawing.Size(259, 47);
            this.cb_TenKhoa.TabIndex = 3;
            this.cb_TenKhoa.SelectedIndexChanged += new System.EventHandler(this.cb_TenKhoa_SelectedIndexChanged);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(7, 196);
            this.label4.Margin = new System.Windows.Forms.Padding(8, 0, 8, 0);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(222, 39);
            this.label4.TabIndex = 2;
            this.label4.Text = "Chương Trình:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(392, 104);
            this.label3.Margin = new System.Windows.Forms.Padding(8, 0, 8, 0);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(184, 39);
            this.label3.TabIndex = 1;
            this.label3.Text = "Tên Ngành:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(7, 104);
            this.label2.Margin = new System.Windows.Forms.Padding(8, 0, 8, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(163, 39);
            this.label2.TabIndex = 0;
            this.label2.Text = "Tên Khoa:";
            // 
            // frm_QuanLyMonHoc
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(14F, 27F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1554, 852);
            this.Controls.Add(this.splitContainerControl1);
            this.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.IsMdiContainer = true;
            this.Margin = new System.Windows.Forms.Padding(5, 4, 5, 4);
            this.Name = "frm_QuanLyMonHoc";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Quản lý môn học";
            this.Load += new System.EventHandler(this.frm_QuanLyMonHoc_Load);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1.Panel1)).EndInit();
            this.splitContainerControl1.Panel1.ResumeLayout(false);
            this.splitContainerControl1.Panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1.Panel2)).EndInit();
            this.splitContainerControl1.Panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1)).EndInit();
            this.splitContainerControl1.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.dgv_MonHoc)).EndInit();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private DevExpress.XtraEditors.SplitContainerControl splitContainerControl1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.Button btn_TimKiem;
        private System.Windows.Forms.TextBox txt_TimMon;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.DataGridView dgv_MonHoc;
        private System.Windows.Forms.TextBox txt_SoTinChi;
        private System.Windows.Forms.TextBox txt_SoTiet;
        private System.Windows.Forms.TextBox txt_TenMon;
        private System.Windows.Forms.TextBox txt_MaMon;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox txt_ChuongTrinh;
        private System.Windows.Forms.ComboBox cb_TenNganh;
        private System.Windows.Forms.ComboBox cb_TenKhoa;
        private System.Windows.Forms.Button btn_Them;
        private System.Windows.Forms.Button btn_Thoat;
        private System.Windows.Forms.Button btn_LamMoi;
        private System.Windows.Forms.Button btn_Xoa;
        private System.Windows.Forms.Button btn_Sua;
        private System.Windows.Forms.CheckBox chk_BatBuoc;
        private System.Windows.Forms.DataGridViewTextBoxColumn MaMon;
        private System.Windows.Forms.DataGridViewTextBoxColumn TenMon;
        private System.Windows.Forms.DataGridViewTextBoxColumn SoTiet;
        private System.Windows.Forms.DataGridViewTextBoxColumn SoTinChi;
        private System.Windows.Forms.DataGridViewTextBoxColumn BatBuoc;
    }
}