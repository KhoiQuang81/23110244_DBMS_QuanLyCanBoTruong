namespace DBMS_QuanLyCanBoGiangVien
{
    partial class frm_QuanLyGiangVien
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
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.dgv_GiangVien = new System.Windows.Forms.DataGridView();
            this.txt_TimTenGV = new System.Windows.Forms.TextBox();
            this.btn_TimKiem = new System.Windows.Forms.Button();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.label8 = new System.Windows.Forms.Label();
            this.label9 = new System.Windows.Forms.Label();
            this.label10 = new System.Windows.Forms.Label();
            this.label11 = new System.Windows.Forms.Label();
            this.txt_MaCB = new System.Windows.Forms.TextBox();
            this.txt_HoTen = new System.Windows.Forms.TextBox();
            this.txt_MaKhoa = new System.Windows.Forms.TextBox();
            this.txt_MaChucVu = new System.Windows.Forms.TextBox();
            this.txt_MaTrinhDo = new System.Windows.Forms.TextBox();
            this.txt_Email = new System.Windows.Forms.TextBox();
            this.txt_Phone = new System.Windows.Forms.TextBox();
            this.cb_GioiTinh = new System.Windows.Forms.ComboBox();
            this.btn_Them = new System.Windows.Forms.Button();
            this.btn_Xoa = new System.Windows.Forms.Button();
            this.btn_Sua = new System.Windows.Forms.Button();
            this.button5 = new System.Windows.Forms.Button();
            this.dt_NgaySinh = new System.Windows.Forms.DateTimePicker();
            this.btn_LamMoi = new System.Windows.Forms.Button();
            this.MaCB = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.HoTen = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.MaKhoa = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.MaChucVu = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.MaTrinhDo = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Email = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Phone = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.NgaySinh = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.GioiTinh = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_GiangVien)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Arial", 18F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(531, 23);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(356, 43);
            this.label1.TabIndex = 0;
            this.label1.Text = "Quản Lý Giảng Viên";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(21, 233);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(177, 27);
            this.label2.TabIndex = 1;
            this.label2.Text = "Tên giảng viên:";
            // 
            // dgv_GiangVien
            // 
            this.dgv_GiangVien.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgv_GiangVien.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.MaCB,
            this.HoTen,
            this.MaKhoa,
            this.MaChucVu,
            this.MaTrinhDo,
            this.Email,
            this.Phone,
            this.NgaySinh,
            this.GioiTinh});
            this.dgv_GiangVien.Location = new System.Drawing.Point(26, 290);
            this.dgv_GiangVien.Name = "dgv_GiangVien";
            this.dgv_GiangVien.RowHeadersWidth = 62;
            this.dgv_GiangVien.RowTemplate.Height = 28;
            this.dgv_GiangVien.Size = new System.Drawing.Size(1173, 462);
            this.dgv_GiangVien.TabIndex = 2;
            this.dgv_GiangVien.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgv_GiangVien_CellClick);
            // 
            // txt_TimTenGV
            // 
            this.txt_TimTenGV.Location = new System.Drawing.Point(214, 229);
            this.txt_TimTenGV.Name = "txt_TimTenGV";
            this.txt_TimTenGV.Size = new System.Drawing.Size(265, 35);
            this.txt_TimTenGV.TabIndex = 3;
            // 
            // btn_TimKiem
            // 
            this.btn_TimKiem.Location = new System.Drawing.Point(539, 229);
            this.btn_TimKiem.Name = "btn_TimKiem";
            this.btn_TimKiem.Size = new System.Drawing.Size(154, 35);
            this.btn_TimKiem.TabIndex = 4;
            this.btn_TimKiem.Text = "Tìm kiếm";
            this.btn_TimKiem.UseVisualStyleBackColor = true;
            this.btn_TimKiem.Click += new System.EventHandler(this.btn_TimKiem_Click);
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(24, 92);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(184, 27);
            this.label3.TabIndex = 5;
            this.label3.Text = "Mã Giảng Viên: ";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(24, 163);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(104, 27);
            this.label4.TabIndex = 6;
            this.label4.Text = "Họ Tên: ";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(734, 160);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(79, 27);
            this.label5.TabIndex = 7;
            this.label5.Text = "Email:";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(1056, 89);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(134, 27);
            this.label6.TabIndex = 8;
            this.label6.Text = "Điện Thoại:";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(1056, 160);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(131, 27);
            this.label7.TabIndex = 9;
            this.label7.Text = "Ngày Sinh:";
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(1056, 233);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(119, 27);
            this.label8.TabIndex = 10;
            this.label8.Text = "Giới Tính:";
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(419, 92);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(114, 27);
            this.label9.TabIndex = 11;
            this.label9.Text = "Mã Khoa:";
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Location = new System.Drawing.Point(419, 163);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(114, 27);
            this.label10.TabIndex = 12;
            this.label10.Text = "Chức Vụ:";
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Location = new System.Drawing.Point(734, 89);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(111, 27);
            this.label11.TabIndex = 13;
            this.label11.Text = "Trình Độ:";
            // 
            // txt_MaCB
            // 
            this.txt_MaCB.Location = new System.Drawing.Point(214, 89);
            this.txt_MaCB.Name = "txt_MaCB";
            this.txt_MaCB.Size = new System.Drawing.Size(154, 35);
            this.txt_MaCB.TabIndex = 14;
            // 
            // txt_HoTen
            // 
            this.txt_HoTen.Location = new System.Drawing.Point(214, 160);
            this.txt_HoTen.Name = "txt_HoTen";
            this.txt_HoTen.Size = new System.Drawing.Size(154, 35);
            this.txt_HoTen.TabIndex = 15;
            // 
            // txt_MaKhoa
            // 
            this.txt_MaKhoa.Location = new System.Drawing.Point(539, 89);
            this.txt_MaKhoa.Name = "txt_MaKhoa";
            this.txt_MaKhoa.Size = new System.Drawing.Size(154, 35);
            this.txt_MaKhoa.TabIndex = 16;
            // 
            // txt_MaChucVu
            // 
            this.txt_MaChucVu.Location = new System.Drawing.Point(539, 160);
            this.txt_MaChucVu.Name = "txt_MaChucVu";
            this.txt_MaChucVu.Size = new System.Drawing.Size(154, 35);
            this.txt_MaChucVu.TabIndex = 17;
            // 
            // txt_MaTrinhDo
            // 
            this.txt_MaTrinhDo.Location = new System.Drawing.Point(851, 86);
            this.txt_MaTrinhDo.Name = "txt_MaTrinhDo";
            this.txt_MaTrinhDo.Size = new System.Drawing.Size(154, 35);
            this.txt_MaTrinhDo.TabIndex = 18;
            // 
            // txt_Email
            // 
            this.txt_Email.Location = new System.Drawing.Point(851, 155);
            this.txt_Email.Name = "txt_Email";
            this.txt_Email.Size = new System.Drawing.Size(154, 35);
            this.txt_Email.TabIndex = 19;
            // 
            // txt_Phone
            // 
            this.txt_Phone.Location = new System.Drawing.Point(1193, 86);
            this.txt_Phone.Name = "txt_Phone";
            this.txt_Phone.Size = new System.Drawing.Size(157, 35);
            this.txt_Phone.TabIndex = 20;
            // 
            // cb_GioiTinh
            // 
            this.cb_GioiTinh.FormattingEnabled = true;
            this.cb_GioiTinh.Location = new System.Drawing.Point(1193, 230);
            this.cb_GioiTinh.Name = "cb_GioiTinh";
            this.cb_GioiTinh.Size = new System.Drawing.Size(157, 35);
            this.cb_GioiTinh.TabIndex = 22;
            // 
            // btn_Them
            // 
            this.btn_Them.Location = new System.Drawing.Point(1239, 313);
            this.btn_Them.Name = "btn_Them";
            this.btn_Them.Size = new System.Drawing.Size(111, 43);
            this.btn_Them.TabIndex = 23;
            this.btn_Them.Text = "Thêm";
            this.btn_Them.UseVisualStyleBackColor = true;
            this.btn_Them.Click += new System.EventHandler(this.btn_Them_Click);
            // 
            // btn_Xoa
            // 
            this.btn_Xoa.Location = new System.Drawing.Point(1239, 563);
            this.btn_Xoa.Name = "btn_Xoa";
            this.btn_Xoa.Size = new System.Drawing.Size(111, 43);
            this.btn_Xoa.TabIndex = 24;
            this.btn_Xoa.Text = "Xóa";
            this.btn_Xoa.UseVisualStyleBackColor = true;
            this.btn_Xoa.Click += new System.EventHandler(this.btn_Xoa_Click);
            // 
            // btn_Sua
            // 
            this.btn_Sua.Location = new System.Drawing.Point(1239, 444);
            this.btn_Sua.Name = "btn_Sua";
            this.btn_Sua.Size = new System.Drawing.Size(111, 43);
            this.btn_Sua.TabIndex = 25;
            this.btn_Sua.Text = "Sửa";
            this.btn_Sua.UseVisualStyleBackColor = true;
            this.btn_Sua.Click += new System.EventHandler(this.btn_Sua_Click);
            // 
            // button5
            // 
            this.button5.Location = new System.Drawing.Point(1239, 673);
            this.button5.Name = "button5";
            this.button5.Size = new System.Drawing.Size(111, 43);
            this.button5.TabIndex = 26;
            this.button5.Text = "Thoát";
            this.button5.UseVisualStyleBackColor = true;
            this.button5.Click += new System.EventHandler(this.button5_Click);
            // 
            // dt_NgaySinh
            // 
            this.dt_NgaySinh.Location = new System.Drawing.Point(1193, 154);
            this.dt_NgaySinh.Name = "dt_NgaySinh";
            this.dt_NgaySinh.Size = new System.Drawing.Size(157, 35);
            this.dt_NgaySinh.TabIndex = 27;
            // 
            // btn_LamMoi
            // 
            this.btn_LamMoi.Location = new System.Drawing.Point(851, 229);
            this.btn_LamMoi.Name = "btn_LamMoi";
            this.btn_LamMoi.Size = new System.Drawing.Size(154, 36);
            this.btn_LamMoi.TabIndex = 28;
            this.btn_LamMoi.Text = "Làm Mới";
            this.btn_LamMoi.UseVisualStyleBackColor = true;
            this.btn_LamMoi.Click += new System.EventHandler(this.btn_LamMoi_Click);
            // 
            // MaCB
            // 
            this.MaCB.DataPropertyName = "MaCB";
            this.MaCB.HeaderText = "Mã Cán Bộ";
            this.MaCB.MinimumWidth = 8;
            this.MaCB.Name = "MaCB";
            this.MaCB.Width = 125;
            // 
            // HoTen
            // 
            this.HoTen.DataPropertyName = "HoTen";
            this.HoTen.HeaderText = "Họ Tên";
            this.HoTen.MinimumWidth = 8;
            this.HoTen.Name = "HoTen";
            this.HoTen.Width = 160;
            // 
            // MaKhoa
            // 
            this.MaKhoa.DataPropertyName = "MaKhoa";
            this.MaKhoa.HeaderText = "Mã Khoa";
            this.MaKhoa.MinimumWidth = 8;
            this.MaKhoa.Name = "MaKhoa";
            this.MaKhoa.Width = 110;
            // 
            // MaChucVu
            // 
            this.MaChucVu.DataPropertyName = "MaChucVu";
            this.MaChucVu.HeaderText = "Chức Vụ";
            this.MaChucVu.MinimumWidth = 8;
            this.MaChucVu.Name = "MaChucVu";
            this.MaChucVu.Width = 130;
            // 
            // MaTrinhDo
            // 
            this.MaTrinhDo.DataPropertyName = "MaTrinhDo";
            this.MaTrinhDo.HeaderText = "Trình Độ";
            this.MaTrinhDo.MinimumWidth = 8;
            this.MaTrinhDo.Name = "MaTrinhDo";
            this.MaTrinhDo.Width = 110;
            // 
            // Email
            // 
            this.Email.DataPropertyName = "Email";
            this.Email.HeaderText = "Email";
            this.Email.MinimumWidth = 8;
            this.Email.Name = "Email";
            this.Email.Width = 140;
            // 
            // Phone
            // 
            this.Phone.DataPropertyName = "Phone";
            this.Phone.HeaderText = "Điện Thoại";
            this.Phone.MinimumWidth = 8;
            this.Phone.Name = "Phone";
            this.Phone.Width = 130;
            // 
            // NgaySinh
            // 
            this.NgaySinh.DataPropertyName = "NgaySinh";
            this.NgaySinh.HeaderText = "Ngày Sinh";
            this.NgaySinh.MinimumWidth = 8;
            this.NgaySinh.Name = "NgaySinh";
            this.NgaySinh.Width = 130;
            // 
            // GioiTinh
            // 
            this.GioiTinh.DataPropertyName = "GioiTinh";
            this.GioiTinh.HeaderText = "Giới Tính";
            this.GioiTinh.MinimumWidth = 8;
            this.GioiTinh.Name = "GioiTinh";
            this.GioiTinh.Width = 110;
            // 
            // frm_QuanLyGiangVien
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(14F, 27F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1387, 764);
            this.Controls.Add(this.btn_LamMoi);
            this.Controls.Add(this.dt_NgaySinh);
            this.Controls.Add(this.button5);
            this.Controls.Add(this.btn_Sua);
            this.Controls.Add(this.btn_Xoa);
            this.Controls.Add(this.btn_Them);
            this.Controls.Add(this.cb_GioiTinh);
            this.Controls.Add(this.txt_Phone);
            this.Controls.Add(this.txt_Email);
            this.Controls.Add(this.txt_MaTrinhDo);
            this.Controls.Add(this.txt_MaChucVu);
            this.Controls.Add(this.txt_MaKhoa);
            this.Controls.Add(this.txt_HoTen);
            this.Controls.Add(this.txt_MaCB);
            this.Controls.Add(this.label11);
            this.Controls.Add(this.label10);
            this.Controls.Add(this.label9);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.btn_TimKiem);
            this.Controls.Add(this.txt_TimTenGV);
            this.Controls.Add(this.dgv_GiangVien);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Margin = new System.Windows.Forms.Padding(5, 4, 5, 4);
            this.Name = "frm_QuanLyGiangVien";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "frm_QuanLyGiangVien";
            this.Load += new System.EventHandler(this.frm_QuanLyGiangVien_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgv_GiangVien)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.DataGridView dgv_GiangVien;
        private System.Windows.Forms.TextBox txt_TimTenGV;
        private System.Windows.Forms.Button btn_TimKiem;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.TextBox txt_MaCB;
        private System.Windows.Forms.TextBox txt_HoTen;
        private System.Windows.Forms.TextBox txt_MaKhoa;
        private System.Windows.Forms.TextBox txt_MaChucVu;
        private System.Windows.Forms.TextBox txt_MaTrinhDo;
        private System.Windows.Forms.TextBox txt_Email;
        private System.Windows.Forms.TextBox txt_Phone;
        private System.Windows.Forms.ComboBox cb_GioiTinh;
        private System.Windows.Forms.Button btn_Them;
        private System.Windows.Forms.Button btn_Xoa;
        private System.Windows.Forms.Button btn_Sua;
        private System.Windows.Forms.Button button5;
        private System.Windows.Forms.DateTimePicker dt_NgaySinh;
        private System.Windows.Forms.Button btn_LamMoi;
        private System.Windows.Forms.DataGridViewTextBoxColumn MaCB;
        private System.Windows.Forms.DataGridViewTextBoxColumn HoTen;
        private System.Windows.Forms.DataGridViewTextBoxColumn MaKhoa;
        private System.Windows.Forms.DataGridViewTextBoxColumn MaChucVu;
        private System.Windows.Forms.DataGridViewTextBoxColumn MaTrinhDo;
        private System.Windows.Forms.DataGridViewTextBoxColumn Email;
        private System.Windows.Forms.DataGridViewTextBoxColumn Phone;
        private System.Windows.Forms.DataGridViewTextBoxColumn NgaySinh;
        private System.Windows.Forms.DataGridViewTextBoxColumn GioiTinh;
    }
}