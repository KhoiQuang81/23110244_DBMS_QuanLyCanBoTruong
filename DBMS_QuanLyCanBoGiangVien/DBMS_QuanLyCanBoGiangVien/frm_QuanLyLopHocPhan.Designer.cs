namespace DBMS_QuanLyCanBoGiangVien
{
    partial class frm_QuanLyLopHocPhan
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
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
            this.splitContainerControl1 = new DevExpress.XtraEditors.SplitContainerControl();
            this.label1 = new System.Windows.Forms.Label();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.txt_MaSoLop = new System.Windows.Forms.TextBox();
            this.label8 = new System.Windows.Forms.Label();
            this.txt_MaMon = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.dgv_LopHocPhan = new System.Windows.Forms.DataGridView();
            this.MaLopHocPhan = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.TenlopHocPhan = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.SoLuongSV = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.cb_TimLopTheoMon = new System.Windows.Forms.ComboBox();
            this.btn_TimKiem = new System.Windows.Forms.Button();
            this.label5 = new System.Windows.Forms.Label();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.txt_SoLuongSV = new System.Windows.Forms.TextBox();
            this.label10 = new System.Windows.Forms.Label();
            this.txt_TenLopHocPhan = new System.Windows.Forms.TextBox();
            this.label9 = new System.Windows.Forms.Label();
            this.cb_TenMon = new System.Windows.Forms.ComboBox();
            this.btn_Thoat = new System.Windows.Forms.Button();
            this.btn_LamMoi = new System.Windows.Forms.Button();
            this.btn_Xoa = new System.Windows.Forms.Button();
            this.btn_Sua = new System.Windows.Forms.Button();
            this.btn_Them = new System.Windows.Forms.Button();
            this.label7 = new System.Windows.Forms.Label();
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
            this.groupBox3.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_LopHocPhan)).BeginInit();
            this.groupBox2.SuspendLayout();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // splitContainerControl1
            // 
            this.splitContainerControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainerControl1.Horizontal = false;
            this.splitContainerControl1.Location = new System.Drawing.Point(0, 0);
            this.splitContainerControl1.Name = "splitContainerControl1";
            // 
            // splitContainerControl1.Panel1
            // 
            this.splitContainerControl1.Panel1.Controls.Add(this.label1);
            this.splitContainerControl1.Panel1.Text = "Panel1";
            // 
            // splitContainerControl1.Panel2
            // 
            this.splitContainerControl1.Panel2.Controls.Add(this.groupBox3);
            this.splitContainerControl1.Panel2.Controls.Add(this.dgv_LopHocPhan);
            this.splitContainerControl1.Panel2.Controls.Add(this.groupBox2);
            this.splitContainerControl1.Panel2.Controls.Add(this.groupBox1);
            this.splitContainerControl1.Panel2.Text = "Panel2";
            this.splitContainerControl1.Size = new System.Drawing.Size(1541, 801);
            this.splitContainerControl1.SplitterPosition = 81;
            this.splitContainerControl1.TabIndex = 0;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Arial", 18F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(572, 23);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(417, 43);
            this.label1.TabIndex = 1;
            this.label1.Text = "Quản Lý Lớp Học Phần";
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.txt_MaSoLop);
            this.groupBox3.Controls.Add(this.label8);
            this.groupBox3.Controls.Add(this.txt_MaMon);
            this.groupBox3.Controls.Add(this.label6);
            this.groupBox3.Font = new System.Drawing.Font("Tahoma", 11F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox3.Location = new System.Drawing.Point(700, 378);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(841, 100);
            this.groupBox3.TabIndex = 19;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Mã Lớp học phần";
            // 
            // txt_MaSoLop
            // 
            this.txt_MaSoLop.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txt_MaSoLop.Location = new System.Drawing.Point(569, 38);
            this.txt_MaSoLop.Margin = new System.Windows.Forms.Padding(4);
            this.txt_MaSoLop.Name = "txt_MaSoLop";
            this.txt_MaSoLop.Size = new System.Drawing.Size(259, 46);
            this.txt_MaSoLop.TabIndex = 20;
            this.txt_MaSoLop.TextChanged += new System.EventHandler(this.txt_MaSoLop_TextChanged);
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label8.Location = new System.Drawing.Point(440, 41);
            this.label8.Margin = new System.Windows.Forms.Padding(8, 0, 8, 0);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(173, 39);
            this.label8.TabIndex = 19;
            this.label8.Text = "Mã số Lớp:";
            // 
            // txt_MaMon
            // 
            this.txt_MaMon.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txt_MaMon.Location = new System.Drawing.Point(151, 38);
            this.txt_MaMon.Margin = new System.Windows.Forms.Padding(4);
            this.txt_MaMon.Name = "txt_MaMon";
            this.txt_MaMon.Size = new System.Drawing.Size(259, 46);
            this.txt_MaMon.TabIndex = 10;
            this.txt_MaMon.TextChanged += new System.EventHandler(this.txt_MaMon_TextChanged);
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.Location = new System.Drawing.Point(7, 41);
            this.label6.Margin = new System.Windows.Forms.Padding(8, 0, 8, 0);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(140, 39);
            this.label6.TabIndex = 6;
            this.label6.Text = "Mã Môn:";
            // 
            // dgv_LopHocPhan
            // 
            dataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Tahoma", 14F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgv_LopHocPhan.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle1;
            this.dgv_LopHocPhan.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgv_LopHocPhan.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.MaLopHocPhan,
            this.TenlopHocPhan,
            this.SoLuongSV});
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle2.BackColor = System.Drawing.SystemColors.Window;
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Tahoma", 14F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle2.ForeColor = System.Drawing.SystemColors.ControlText;
            dataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
            this.dgv_LopHocPhan.DefaultCellStyle = dataGridViewCellStyle2;
            this.dgv_LopHocPhan.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgv_LopHocPhan.Location = new System.Drawing.Point(0, 194);
            this.dgv_LopHocPhan.Margin = new System.Windows.Forms.Padding(4);
            this.dgv_LopHocPhan.Name = "dgv_LopHocPhan";
            this.dgv_LopHocPhan.RowHeadersWidth = 62;
            this.dgv_LopHocPhan.RowTemplate.Height = 28;
            this.dgv_LopHocPhan.Size = new System.Drawing.Size(688, 511);
            this.dgv_LopHocPhan.TabIndex = 3;
            this.dgv_LopHocPhan.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgv_LopHocPhan_CellClick);
            // 
            // MaLopHocPhan
            // 
            this.MaLopHocPhan.DataPropertyName = "MaLopHocPhan";
            this.MaLopHocPhan.HeaderText = "Mã Lớp Học Phần";
            this.MaLopHocPhan.MinimumWidth = 8;
            this.MaLopHocPhan.Name = "MaLopHocPhan";
            this.MaLopHocPhan.Width = 170;
            // 
            // TenlopHocPhan
            // 
            this.TenlopHocPhan.DataPropertyName = "TenlopHocPhan";
            this.TenlopHocPhan.HeaderText = "Tên Lớp Học Phần";
            this.TenlopHocPhan.MinimumWidth = 8;
            this.TenlopHocPhan.Name = "TenlopHocPhan";
            this.TenlopHocPhan.Width = 250;
            // 
            // SoLuongSV
            // 
            this.SoLuongSV.DataPropertyName = "SoLuongSV";
            this.SoLuongSV.HeaderText = "Số lượng SV";
            this.SoLuongSV.MinimumWidth = 8;
            this.SoLuongSV.Name = "SoLuongSV";
            this.SoLuongSV.Width = 150;
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.cb_TimLopTheoMon);
            this.groupBox2.Controls.Add(this.btn_TimKiem);
            this.groupBox2.Controls.Add(this.label5);
            this.groupBox2.Dock = System.Windows.Forms.DockStyle.Top;
            this.groupBox2.Font = new System.Drawing.Font("Tahoma", 11F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox2.Location = new System.Drawing.Point(0, 0);
            this.groupBox2.Margin = new System.Windows.Forms.Padding(8, 6, 8, 6);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Padding = new System.Windows.Forms.Padding(8, 6, 8, 6);
            this.groupBox2.Size = new System.Drawing.Size(688, 194);
            this.groupBox2.TabIndex = 2;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Tìm Lớp học phần";
            // 
            // cb_TimLopTheoMon
            // 
            this.cb_TimLopTheoMon.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cb_TimLopTheoMon.FormattingEnabled = true;
            this.cb_TimLopTheoMon.Location = new System.Drawing.Point(187, 93);
            this.cb_TimLopTheoMon.Margin = new System.Windows.Forms.Padding(4);
            this.cb_TimLopTheoMon.Name = "cb_TimLopTheoMon";
            this.cb_TimLopTheoMon.Size = new System.Drawing.Size(308, 47);
            this.cb_TimLopTheoMon.TabIndex = 19;
            this.cb_TimLopTheoMon.SelectedIndexChanged += new System.EventHandler(this.cb_TimLopTheoMon_SelectedIndexChanged);
            // 
            // btn_TimKiem
            // 
            this.btn_TimKiem.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_TimKiem.Location = new System.Drawing.Point(517, 93);
            this.btn_TimKiem.Margin = new System.Windows.Forms.Padding(8, 6, 8, 6);
            this.btn_TimKiem.Name = "btn_TimKiem";
            this.btn_TimKiem.Size = new System.Drawing.Size(144, 45);
            this.btn_TimKiem.TabIndex = 3;
            this.btn_TimKiem.Text = "Tìm kiếm";
            this.btn_TimKiem.UseVisualStyleBackColor = true;
            this.btn_TimKiem.Click += new System.EventHandler(this.btn_TimKiem_Click);
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
            this.groupBox1.Controls.Add(this.txt_SoLuongSV);
            this.groupBox1.Controls.Add(this.label10);
            this.groupBox1.Controls.Add(this.txt_TenLopHocPhan);
            this.groupBox1.Controls.Add(this.label9);
            this.groupBox1.Controls.Add(this.cb_TenMon);
            this.groupBox1.Controls.Add(this.btn_Thoat);
            this.groupBox1.Controls.Add(this.btn_LamMoi);
            this.groupBox1.Controls.Add(this.btn_Xoa);
            this.groupBox1.Controls.Add(this.btn_Sua);
            this.groupBox1.Controls.Add(this.btn_Them);
            this.groupBox1.Controls.Add(this.label7);
            this.groupBox1.Controls.Add(this.txt_ChuongTrinh);
            this.groupBox1.Controls.Add(this.cb_TenNganh);
            this.groupBox1.Controls.Add(this.cb_TenKhoa);
            this.groupBox1.Controls.Add(this.label4);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Dock = System.Windows.Forms.DockStyle.Right;
            this.groupBox1.Font = new System.Drawing.Font("Tahoma", 11F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(688, 0);
            this.groupBox1.Margin = new System.Windows.Forms.Padding(8, 6, 8, 6);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Padding = new System.Windows.Forms.Padding(8, 6, 8, 6);
            this.groupBox1.Size = new System.Drawing.Size(853, 705);
            this.groupBox1.TabIndex = 1;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Thông tin Lớp học phần";
            // 
            // txt_SoLuongSV
            // 
            this.txt_SoLuongSV.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txt_SoLuongSV.Location = new System.Drawing.Point(581, 289);
            this.txt_SoLuongSV.Margin = new System.Windows.Forms.Padding(4);
            this.txt_SoLuongSV.Name = "txt_SoLuongSV";
            this.txt_SoLuongSV.Size = new System.Drawing.Size(259, 46);
            this.txt_SoLuongSV.TabIndex = 22;
            this.txt_SoLuongSV.TextChanged += new System.EventHandler(this.txt_SoLuongSV_TextChanged);
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label10.Location = new System.Drawing.Point(434, 292);
            this.label10.Margin = new System.Windows.Forms.Padding(8, 0, 8, 0);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(200, 39);
            this.label10.TabIndex = 21;
            this.label10.Text = "Số lượng SV:";
            // 
            // txt_TenLopHocPhan
            // 
            this.txt_TenLopHocPhan.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txt_TenLopHocPhan.Location = new System.Drawing.Point(163, 289);
            this.txt_TenLopHocPhan.Margin = new System.Windows.Forms.Padding(4);
            this.txt_TenLopHocPhan.Name = "txt_TenLopHocPhan";
            this.txt_TenLopHocPhan.Size = new System.Drawing.Size(259, 46);
            this.txt_TenLopHocPhan.TabIndex = 20;
            this.txt_TenLopHocPhan.TextChanged += new System.EventHandler(this.txt_TenLopHocPhan_TextChanged);
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label9.Location = new System.Drawing.Point(7, 293);
            this.label9.Margin = new System.Windows.Forms.Padding(8, 0, 8, 0);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(223, 39);
            this.label9.TabIndex = 19;
            this.label9.Text = "Tên học phần:";
            // 
            // cb_TenMon
            // 
            this.cb_TenMon.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cb_TenMon.FormattingEnabled = true;
            this.cb_TenMon.Location = new System.Drawing.Point(163, 200);
            this.cb_TenMon.Margin = new System.Windows.Forms.Padding(4);
            this.cb_TenMon.Name = "cb_TenMon";
            this.cb_TenMon.Size = new System.Drawing.Size(259, 47);
            this.cb_TenMon.TabIndex = 18;
            this.cb_TenMon.SelectedIndexChanged += new System.EventHandler(this.cb_TenMon_SelectedIndexChanged);
            // 
            // btn_Thoat
            // 
            this.btn_Thoat.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_Thoat.Location = new System.Drawing.Point(484, 616);
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
            this.btn_LamMoi.Location = new System.Drawing.Point(188, 616);
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
            this.btn_Xoa.Location = new System.Drawing.Point(591, 520);
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
            this.btn_Sua.Location = new System.Drawing.Point(326, 520);
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
            this.btn_Them.Location = new System.Drawing.Point(59, 520);
            this.btn_Them.Margin = new System.Windows.Forms.Padding(8, 6, 8, 6);
            this.btn_Them.Name = "btn_Them";
            this.btn_Them.Size = new System.Drawing.Size(207, 64);
            this.btn_Them.TabIndex = 4;
            this.btn_Them.Text = "Thêm";
            this.btn_Them.UseVisualStyleBackColor = true;
            this.btn_Them.Click += new System.EventHandler(this.btn_Them_Click);
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.Location = new System.Drawing.Point(7, 204);
            this.label7.Margin = new System.Windows.Forms.Padding(8, 0, 8, 0);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(88, 39);
            this.label7.TabIndex = 7;
            this.label7.Text = "Môn:";
            // 
            // txt_ChuongTrinh
            // 
            this.txt_ChuongTrinh.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txt_ChuongTrinh.Location = new System.Drawing.Point(581, 196);
            this.txt_ChuongTrinh.Margin = new System.Windows.Forms.Padding(4);
            this.txt_ChuongTrinh.Name = "txt_ChuongTrinh";
            this.txt_ChuongTrinh.Size = new System.Drawing.Size(259, 46);
            this.txt_ChuongTrinh.TabIndex = 5;
            this.txt_ChuongTrinh.TextChanged += new System.EventHandler(this.txt_ChuongTrinh_TextChanged);
            // 
            // cb_TenNganh
            // 
            this.cb_TenNganh.Font = new System.Drawing.Font("Tahoma", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cb_TenNganh.FormattingEnabled = true;
            this.cb_TenNganh.Location = new System.Drawing.Point(581, 105);
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
            this.cb_TenKhoa.Location = new System.Drawing.Point(163, 105);
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
            this.label4.Location = new System.Drawing.Point(434, 199);
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
            this.label3.Location = new System.Drawing.Point(434, 107);
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
            this.label2.Location = new System.Drawing.Point(7, 108);
            this.label2.Margin = new System.Windows.Forms.Padding(8, 0, 8, 0);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(163, 39);
            this.label2.TabIndex = 0;
            this.label2.Text = "Tên Khoa:";
            // 
            // frm_QuanLyLopHocPhan
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(14F, 27F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1541, 801);
            this.Controls.Add(this.splitContainerControl1);
            this.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Margin = new System.Windows.Forms.Padding(5, 4, 5, 4);
            this.Name = "frm_QuanLyLopHocPhan";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "frm_QuanLyLopHocPhan";
            this.Load += new System.EventHandler(this.frm_QuanLyLopHocPhan_Load);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1.Panel1)).EndInit();
            this.splitContainerControl1.Panel1.ResumeLayout(false);
            this.splitContainerControl1.Panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1.Panel2)).EndInit();
            this.splitContainerControl1.Panel2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1)).EndInit();
            this.splitContainerControl1.ResumeLayout(false);
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_LopHocPhan)).EndInit();
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
        private System.Windows.Forms.Button btn_Thoat;
        private System.Windows.Forms.Button btn_LamMoi;
        private System.Windows.Forms.Button btn_Xoa;
        private System.Windows.Forms.Button btn_Sua;
        private System.Windows.Forms.Button btn_Them;
        private System.Windows.Forms.TextBox txt_MaMon;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox txt_ChuongTrinh;
        private System.Windows.Forms.ComboBox cb_TenNganh;
        private System.Windows.Forms.ComboBox cb_TenKhoa;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.Button btn_TimKiem;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.DataGridView dgv_LopHocPhan;
        private System.Windows.Forms.ComboBox cb_TenMon;
        private System.Windows.Forms.ComboBox cb_TimLopTheoMon;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.TextBox txt_MaSoLop;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.TextBox txt_TenLopHocPhan;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.TextBox txt_SoLuongSV;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.DataGridViewTextBoxColumn MaLopHocPhan;
        private System.Windows.Forms.DataGridViewTextBoxColumn TenlopHocPhan;
        private System.Windows.Forms.DataGridViewTextBoxColumn SoLuongSV;
    }
}