namespace DBMS_QuanLyCanBoGiangVien
{
    partial class frm_QuanLyLuong
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
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle3 = new System.Windows.Forms.DataGridViewCellStyle();
            this.splitContainerControl1 = new DevExpress.XtraEditors.SplitContainerControl();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.gb_ThongTin = new System.Windows.Forms.GroupBox();
            this.txt_KhauTru = new System.Windows.Forms.TextBox();
            this.txt_Thuong = new System.Windows.Forms.TextBox();
            this.btn_LamMoi = new System.Windows.Forms.Button();
            this.btn_Thoát = new System.Windows.Forms.Button();
            this.label7 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.cb_CanBo = new System.Windows.Forms.ComboBox();
            this.label5 = new System.Windows.Forms.Label();
            this.btn_Xoa = new System.Windows.Forms.Button();
            this.btn_Sua = new System.Windows.Forms.Button();
            this.btn_TinhLuong = new System.Windows.Forms.Button();
            this.cb_Nam = new System.Windows.Forms.ComboBox();
            this.cb_Thang = new System.Windows.Forms.ComboBox();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.dgv_BangLuong = new System.Windows.Forms.DataGridView();
            this.MaCB = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.HoTen = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Thang = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Nam = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Thuong = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.KhauTru = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.PhuCap = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.HeSoLuong = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.MucLuongCoSo = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.TongLuong = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1.Panel1)).BeginInit();
            this.splitContainerControl1.Panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1.Panel2)).BeginInit();
            this.splitContainerControl1.Panel2.SuspendLayout();
            this.splitContainerControl1.SuspendLayout();
            this.gb_ThongTin.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_BangLuong)).BeginInit();
            this.SuspendLayout();
            // 
            // splitContainerControl1
            // 
            this.splitContainerControl1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.splitContainerControl1.Horizontal = false;
            this.splitContainerControl1.Location = new System.Drawing.Point(0, 0);
            this.splitContainerControl1.Margin = new System.Windows.Forms.Padding(4);
            this.splitContainerControl1.Name = "splitContainerControl1";
            // 
            // splitContainerControl1.Panel1
            // 
            this.splitContainerControl1.Panel1.Controls.Add(this.label1);
            this.splitContainerControl1.Panel1.Text = "Panel1";
            // 
            // splitContainerControl1.Panel2
            // 
            this.splitContainerControl1.Panel2.Controls.Add(this.label2);
            this.splitContainerControl1.Panel2.Controls.Add(this.gb_ThongTin);
            this.splitContainerControl1.Panel2.Controls.Add(this.dgv_BangLuong);
            this.splitContainerControl1.Panel2.Text = "Panel2";
            this.splitContainerControl1.Size = new System.Drawing.Size(1130, 802);
            this.splitContainerControl1.SplitterPosition = 70;
            this.splitContainerControl1.TabIndex = 0;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Arial", 14F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(455, 35);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(226, 33);
            this.label1.TabIndex = 0;
            this.label1.Text = "Quản Lý Lương";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Arial", 14F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(473, 276);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(183, 33);
            this.label2.TabIndex = 2;
            this.label2.Text = "Bảng Lương";
            // 
            // gb_ThongTin
            // 
            this.gb_ThongTin.Controls.Add(this.txt_KhauTru);
            this.gb_ThongTin.Controls.Add(this.txt_Thuong);
            this.gb_ThongTin.Controls.Add(this.btn_LamMoi);
            this.gb_ThongTin.Controls.Add(this.btn_Thoát);
            this.gb_ThongTin.Controls.Add(this.label7);
            this.gb_ThongTin.Controls.Add(this.label6);
            this.gb_ThongTin.Controls.Add(this.cb_CanBo);
            this.gb_ThongTin.Controls.Add(this.label5);
            this.gb_ThongTin.Controls.Add(this.btn_Xoa);
            this.gb_ThongTin.Controls.Add(this.btn_Sua);
            this.gb_ThongTin.Controls.Add(this.btn_TinhLuong);
            this.gb_ThongTin.Controls.Add(this.cb_Nam);
            this.gb_ThongTin.Controls.Add(this.cb_Thang);
            this.gb_ThongTin.Controls.Add(this.label4);
            this.gb_ThongTin.Controls.Add(this.label3);
            this.gb_ThongTin.Dock = System.Windows.Forms.DockStyle.Top;
            this.gb_ThongTin.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.gb_ThongTin.Location = new System.Drawing.Point(0, 0);
            this.gb_ThongTin.Name = "gb_ThongTin";
            this.gb_ThongTin.Size = new System.Drawing.Size(1130, 261);
            this.gb_ThongTin.TabIndex = 1;
            this.gb_ThongTin.TabStop = false;
            this.gb_ThongTin.Text = "Thông tin Cán bộ";
            // 
            // txt_KhauTru
            // 
            this.txt_KhauTru.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txt_KhauTru.Location = new System.Drawing.Point(958, 133);
            this.txt_KhauTru.Name = "txt_KhauTru";
            this.txt_KhauTru.Size = new System.Drawing.Size(121, 35);
            this.txt_KhauTru.TabIndex = 14;
            this.txt_KhauTru.TextChanged += new System.EventHandler(this.txt_KhauTru_TextChanged);
            // 
            // txt_Thuong
            // 
            this.txt_Thuong.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txt_Thuong.Location = new System.Drawing.Point(958, 70);
            this.txt_Thuong.Name = "txt_Thuong";
            this.txt_Thuong.Size = new System.Drawing.Size(121, 35);
            this.txt_Thuong.TabIndex = 13;
            this.txt_Thuong.TextChanged += new System.EventHandler(this.txt_Thuong_TextChanged);
            // 
            // btn_LamMoi
            // 
            this.btn_LamMoi.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_LamMoi.Location = new System.Drawing.Point(928, 204);
            this.btn_LamMoi.Name = "btn_LamMoi";
            this.btn_LamMoi.Size = new System.Drawing.Size(151, 35);
            this.btn_LamMoi.TabIndex = 12;
            this.btn_LamMoi.Text = "Làm Mới";
            this.btn_LamMoi.UseVisualStyleBackColor = true;
            this.btn_LamMoi.Click += new System.EventHandler(this.btn_LamMoi_Click);
            // 
            // btn_Thoát
            // 
            this.btn_Thoát.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_Thoát.Location = new System.Drawing.Point(685, 204);
            this.btn_Thoát.Name = "btn_Thoát";
            this.btn_Thoát.Size = new System.Drawing.Size(151, 35);
            this.btn_Thoát.TabIndex = 11;
            this.btn_Thoát.Text = "Thoát";
            this.btn_Thoát.UseVisualStyleBackColor = true;
            this.btn_Thoát.Click += new System.EventHandler(this.btn_Thoát_Click);
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label7.Location = new System.Drawing.Point(783, 136);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(114, 27);
            this.label7.TabIndex = 10;
            this.label7.Text = "Khấu trừ:";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.Location = new System.Drawing.Point(783, 78);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(107, 27);
            this.label6.TabIndex = 9;
            this.label6.Text = "Thưởng:";
            // 
            // cb_CanBo
            // 
            this.cb_CanBo.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cb_CanBo.FormattingEnabled = true;
            this.cb_CanBo.Location = new System.Drawing.Point(535, 70);
            this.cb_CanBo.Name = "cb_CanBo";
            this.cb_CanBo.Size = new System.Drawing.Size(121, 35);
            this.cb_CanBo.TabIndex = 8;
            this.cb_CanBo.SelectedIndexChanged += new System.EventHandler(this.cb_CanBo_SelectedIndexChanged);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(399, 78);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(99, 27);
            this.label5.TabIndex = 7;
            this.label5.Text = "Cán Bộ:";
            // 
            // btn_Xoa
            // 
            this.btn_Xoa.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_Xoa.Location = new System.Drawing.Point(471, 204);
            this.btn_Xoa.Name = "btn_Xoa";
            this.btn_Xoa.Size = new System.Drawing.Size(151, 35);
            this.btn_Xoa.TabIndex = 6;
            this.btn_Xoa.Text = "Xóa";
            this.btn_Xoa.UseVisualStyleBackColor = true;
            this.btn_Xoa.Click += new System.EventHandler(this.btn_Xoa_Click);
            // 
            // btn_Sua
            // 
            this.btn_Sua.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_Sua.Location = new System.Drawing.Point(250, 204);
            this.btn_Sua.Name = "btn_Sua";
            this.btn_Sua.Size = new System.Drawing.Size(151, 35);
            this.btn_Sua.TabIndex = 5;
            this.btn_Sua.Text = "Sửa Lương";
            this.btn_Sua.UseVisualStyleBackColor = true;
            this.btn_Sua.Click += new System.EventHandler(this.btn_Sua_Click);
            // 
            // btn_TinhLuong
            // 
            this.btn_TinhLuong.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_TinhLuong.Location = new System.Drawing.Point(35, 204);
            this.btn_TinhLuong.Name = "btn_TinhLuong";
            this.btn_TinhLuong.Size = new System.Drawing.Size(151, 35);
            this.btn_TinhLuong.TabIndex = 4;
            this.btn_TinhLuong.Text = "Tính Lương";
            this.btn_TinhLuong.UseVisualStyleBackColor = true;
            this.btn_TinhLuong.Click += new System.EventHandler(this.btn_TinhLuong_Click);
            // 
            // cb_Nam
            // 
            this.cb_Nam.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cb_Nam.FormattingEnabled = true;
            this.cb_Nam.Location = new System.Drawing.Point(166, 133);
            this.cb_Nam.Name = "cb_Nam";
            this.cb_Nam.Size = new System.Drawing.Size(121, 35);
            this.cb_Nam.TabIndex = 3;
            this.cb_Nam.SelectedIndexChanged += new System.EventHandler(this.cb_Nam_SelectedIndexChanged);
            // 
            // cb_Thang
            // 
            this.cb_Thang.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cb_Thang.FormattingEnabled = true;
            this.cb_Thang.Location = new System.Drawing.Point(166, 75);
            this.cb_Thang.Name = "cb_Thang";
            this.cb_Thang.Size = new System.Drawing.Size(121, 35);
            this.cb_Thang.TabIndex = 2;
            this.cb_Thang.SelectedIndexChanged += new System.EventHandler(this.cb_Thang_SelectedIndexChanged);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(60, 136);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(69, 27);
            this.label4.TabIndex = 1;
            this.label4.Text = "Năm:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(41, 78);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(88, 27);
            this.label3.TabIndex = 0;
            this.label3.Text = "Tháng:";
            // 
            // dgv_BangLuong
            // 
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Arial", 14F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dgv_BangLuong.AlternatingRowsDefaultCellStyle = dataGridViewCellStyle1;
            dataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle2.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle2.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle2.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.dgv_BangLuong.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle2;
            this.dgv_BangLuong.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgv_BangLuong.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.MaCB,
            this.HoTen,
            this.Thang,
            this.Nam,
            this.Thuong,
            this.KhauTru,
            this.PhuCap,
            this.HeSoLuong,
            this.MucLuongCoSo,
            this.TongLuong});
            dataGridViewCellStyle3.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle3.BackColor = System.Drawing.SystemColors.Window;
            dataGridViewCellStyle3.Font = new System.Drawing.Font("Tahoma", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            dataGridViewCellStyle3.ForeColor = System.Drawing.SystemColors.ControlText;
            dataGridViewCellStyle3.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle3.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle3.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
            this.dgv_BangLuong.DefaultCellStyle = dataGridViewCellStyle3;
            this.dgv_BangLuong.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.dgv_BangLuong.Location = new System.Drawing.Point(0, 312);
            this.dgv_BangLuong.Name = "dgv_BangLuong";
            this.dgv_BangLuong.RowHeadersWidth = 62;
            this.dgv_BangLuong.RowTemplate.Height = 28;
            this.dgv_BangLuong.Size = new System.Drawing.Size(1130, 405);
            this.dgv_BangLuong.TabIndex = 0;
            this.dgv_BangLuong.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgv_BangLuong_CellClick);
            // 
            // MaCB
            // 
            this.MaCB.DataPropertyName = "MaCB";
            this.MaCB.HeaderText = "Mã Cán Bộ";
            this.MaCB.MinimumWidth = 8;
            this.MaCB.Name = "MaCB";
            this.MaCB.Width = 150;
            // 
            // HoTen
            // 
            this.HoTen.DataPropertyName = "HoTen";
            this.HoTen.HeaderText = "Tên Cán Bộ";
            this.HoTen.MinimumWidth = 8;
            this.HoTen.Name = "HoTen";
            this.HoTen.Width = 150;
            // 
            // Thang
            // 
            this.Thang.DataPropertyName = "Thang";
            this.Thang.HeaderText = "Tháng";
            this.Thang.MinimumWidth = 8;
            this.Thang.Name = "Thang";
            this.Thang.Width = 150;
            // 
            // Nam
            // 
            this.Nam.DataPropertyName = "Nam";
            this.Nam.HeaderText = "Năm";
            this.Nam.MinimumWidth = 8;
            this.Nam.Name = "Nam";
            this.Nam.Width = 150;
            // 
            // Thuong
            // 
            this.Thuong.DataPropertyName = "Thuong";
            this.Thuong.HeaderText = "Thưởng";
            this.Thuong.MinimumWidth = 8;
            this.Thuong.Name = "Thuong";
            this.Thuong.Width = 150;
            // 
            // KhauTru
            // 
            this.KhauTru.DataPropertyName = "KhauTru";
            this.KhauTru.HeaderText = "Khấu Trừ";
            this.KhauTru.MinimumWidth = 8;
            this.KhauTru.Name = "KhauTru";
            this.KhauTru.Width = 150;
            // 
            // PhuCap
            // 
            this.PhuCap.DataPropertyName = "PhuCap";
            this.PhuCap.HeaderText = "Phụ Cấp";
            this.PhuCap.MinimumWidth = 8;
            this.PhuCap.Name = "PhuCap";
            this.PhuCap.Width = 150;
            // 
            // HeSoLuong
            // 
            this.HeSoLuong.DataPropertyName = "HeSoLuong";
            this.HeSoLuong.HeaderText = "Hệ Số Lương";
            this.HeSoLuong.MinimumWidth = 8;
            this.HeSoLuong.Name = "HeSoLuong";
            this.HeSoLuong.Width = 150;
            // 
            // MucLuongCoSo
            // 
            this.MucLuongCoSo.DataPropertyName = "MucLuongCoSo";
            this.MucLuongCoSo.HeaderText = "Mức Lương Cơ Sở";
            this.MucLuongCoSo.MinimumWidth = 8;
            this.MucLuongCoSo.Name = "MucLuongCoSo";
            this.MucLuongCoSo.Width = 150;
            // 
            // TongLuong
            // 
            this.TongLuong.DataPropertyName = "TongLuong";
            this.TongLuong.HeaderText = "Tổng Lương";
            this.TongLuong.MinimumWidth = 8;
            this.TongLuong.Name = "TongLuong";
            this.TongLuong.Width = 150;
            // 
            // frm_QuanLyLuong
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(16F, 32F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1130, 802);
            this.Controls.Add(this.splitContainerControl1);
            this.Font = new System.Drawing.Font("Arial", 14F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Margin = new System.Windows.Forms.Padding(5);
            this.Name = "frm_QuanLyLuong";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Quản lý Lương";
            this.Load += new System.EventHandler(this.frm_QuanLyLuong_Load);
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1.Panel1)).EndInit();
            this.splitContainerControl1.Panel1.ResumeLayout(false);
            this.splitContainerControl1.Panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1.Panel2)).EndInit();
            this.splitContainerControl1.Panel2.ResumeLayout(false);
            this.splitContainerControl1.Panel2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.splitContainerControl1)).EndInit();
            this.splitContainerControl1.ResumeLayout(false);
            this.gb_ThongTin.ResumeLayout(false);
            this.gb_ThongTin.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_BangLuong)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private DevExpress.XtraEditors.SplitContainerControl splitContainerControl1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DataGridView dgv_BangLuong;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.GroupBox gb_ThongTin;
        private System.Windows.Forms.ComboBox cb_Nam;
        private System.Windows.Forms.ComboBox cb_Thang;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Button btn_TinhLuong;
        private System.Windows.Forms.Button btn_Sua;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Button btn_Xoa;
        private System.Windows.Forms.ComboBox cb_CanBo;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Button btn_Thoát;
        private System.Windows.Forms.Button btn_LamMoi;
        private System.Windows.Forms.TextBox txt_KhauTru;
        private System.Windows.Forms.TextBox txt_Thuong;
        private System.Windows.Forms.DataGridViewTextBoxColumn MaCB;
        private System.Windows.Forms.DataGridViewTextBoxColumn HoTen;
        private System.Windows.Forms.DataGridViewTextBoxColumn Thang;
        private System.Windows.Forms.DataGridViewTextBoxColumn Nam;
        private System.Windows.Forms.DataGridViewTextBoxColumn Thuong;
        private System.Windows.Forms.DataGridViewTextBoxColumn KhauTru;
        private System.Windows.Forms.DataGridViewTextBoxColumn PhuCap;
        private System.Windows.Forms.DataGridViewTextBoxColumn HeSoLuong;
        private System.Windows.Forms.DataGridViewTextBoxColumn MucLuongCoSo;
        private System.Windows.Forms.DataGridViewTextBoxColumn TongLuong;
    }
}