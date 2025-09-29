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
            this.splitContainerControl1.Size = new System.Drawing.Size(1521, 802);
            this.splitContainerControl1.SplitterPosition = 70;
            this.splitContainerControl1.TabIndex = 0;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Arial", 14F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(639, 26);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(226, 33);
            this.label1.TabIndex = 0;
            this.label1.Text = "Quản Lý Lương";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Arial", 14F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(668, 264);
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
            this.gb_ThongTin.Size = new System.Drawing.Size(1521, 261);
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
            // 
            // txt_Thuong
            // 
            this.txt_Thuong.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txt_Thuong.Location = new System.Drawing.Point(958, 70);
            this.txt_Thuong.Name = "txt_Thuong";
            this.txt_Thuong.Size = new System.Drawing.Size(121, 35);
            this.txt_Thuong.TabIndex = 13;
            // 
            // btn_LamMoi
            // 
            this.btn_LamMoi.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_LamMoi.Location = new System.Drawing.Point(1307, 216);
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
            this.btn_Thoát.Location = new System.Drawing.Point(998, 216);
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
            this.btn_Xoa.Location = new System.Drawing.Point(685, 216);
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
            this.btn_Sua.Location = new System.Drawing.Point(337, 216);
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
            this.btn_TinhLuong.Location = new System.Drawing.Point(46, 216);
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
            dataGridViewCellStyle1.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.dgv_BangLuong.AlternatingRowsDefaultCellStyle = dataGridViewCellStyle1;
            this.dgv_BangLuong.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgv_BangLuong.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.dgv_BangLuong.Location = new System.Drawing.Point(0, 312);
            this.dgv_BangLuong.Name = "dgv_BangLuong";
            this.dgv_BangLuong.RowHeadersWidth = 62;
            this.dgv_BangLuong.RowTemplate.Height = 28;
            this.dgv_BangLuong.Size = new System.Drawing.Size(1521, 405);
            this.dgv_BangLuong.TabIndex = 0;
            this.dgv_BangLuong.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgv_BangLuong_CellClick);
            this.dgv_BangLuong.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgv_BangLuong_CellContentClick);
            // 
            // frm_QuanLyLuong
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(16F, 32F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1521, 802);
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
    }
}