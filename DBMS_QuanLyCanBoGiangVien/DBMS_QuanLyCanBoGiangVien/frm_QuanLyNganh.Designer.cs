namespace DBMS_QuanLyCanBoGiangVien
{
    partial class frm_QuanLyNganh
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
            this.dgv_Nganh = new System.Windows.Forms.DataGridView();
            this.MaNganh = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.TenNganh = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.MaKhoa = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.txt_MaNganh = new System.Windows.Forms.TextBox();
            this.txt_TenNganh = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.cb_Khoa = new System.Windows.Forms.ComboBox();
            this.btn_Them = new System.Windows.Forms.Button();
            this.btn_Xoa = new System.Windows.Forms.Button();
            this.btn_Sua = new System.Windows.Forms.Button();
            this.btn_Thoat = new System.Windows.Forms.Button();
            this.label5 = new System.Windows.Forms.Label();
            this.txt_MaKhoa = new System.Windows.Forms.TextBox();
            this.btn_LamMoi = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.dgv_Nganh)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Arial", 22F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(552, 35);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(346, 51);
            this.label1.TabIndex = 1;
            this.label1.Text = "Quản Lý Ngành";
            // 
            // dgv_Nganh
            // 
            this.dgv_Nganh.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgv_Nganh.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.MaNganh,
            this.TenNganh,
            this.MaKhoa});
            this.dgv_Nganh.Location = new System.Drawing.Point(22, 125);
            this.dgv_Nganh.Name = "dgv_Nganh";
            this.dgv_Nganh.RowHeadersWidth = 62;
            this.dgv_Nganh.RowTemplate.Height = 28;
            this.dgv_Nganh.Size = new System.Drawing.Size(590, 579);
            this.dgv_Nganh.TabIndex = 2;
            this.dgv_Nganh.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgv_Nganh_CellClick);
            // 
            // MaNganh
            // 
            this.MaNganh.DataPropertyName = "MaNganh";
            this.MaNganh.HeaderText = "Mã Ngành";
            this.MaNganh.MinimumWidth = 8;
            this.MaNganh.Name = "MaNganh";
            this.MaNganh.Width = 175;
            // 
            // TenNganh
            // 
            this.TenNganh.DataPropertyName = "TenNganh";
            this.TenNganh.HeaderText = "Tên Ngành";
            this.TenNganh.MinimumWidth = 8;
            this.TenNganh.Name = "TenNganh";
            this.TenNganh.Width = 175;
            // 
            // MaKhoa
            // 
            this.MaKhoa.DataPropertyName = "MaKhoa";
            this.MaKhoa.HeaderText = "Mã Khoa";
            this.MaKhoa.MinimumWidth = 8;
            this.MaKhoa.Name = "MaKhoa";
            this.MaKhoa.Width = 175;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Arial", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(682, 467);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(191, 41);
            this.label2.TabIndex = 3;
            this.label2.Text = "Mã Ngành:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Arial", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(677, 342);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(195, 41);
            this.label3.TabIndex = 4;
            this.label3.Text = "Tên ngành:";
            // 
            // txt_MaNganh
            // 
            this.txt_MaNganh.Font = new System.Drawing.Font("Arial", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txt_MaNganh.Location = new System.Drawing.Point(928, 464);
            this.txt_MaNganh.Name = "txt_MaNganh";
            this.txt_MaNganh.Size = new System.Drawing.Size(385, 49);
            this.txt_MaNganh.TabIndex = 5;
            this.txt_MaNganh.TextChanged += new System.EventHandler(this.txt_MaNganh_TextChanged);
            // 
            // txt_TenNganh
            // 
            this.txt_TenNganh.Font = new System.Drawing.Font("Arial", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txt_TenNganh.Location = new System.Drawing.Point(928, 339);
            this.txt_TenNganh.Name = "txt_TenNganh";
            this.txt_TenNganh.Size = new System.Drawing.Size(385, 49);
            this.txt_TenNganh.TabIndex = 6;
            this.txt_TenNganh.TextChanged += new System.EventHandler(this.txt_TenNganh_TextChanged);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Arial", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(692, 128);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(181, 41);
            this.label4.TabIndex = 7;
            this.label4.Text = "Tên Khoa:";
            // 
            // cb_Khoa
            // 
            this.cb_Khoa.Font = new System.Drawing.Font("Arial", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.cb_Khoa.FormattingEnabled = true;
            this.cb_Khoa.Location = new System.Drawing.Point(928, 125);
            this.cb_Khoa.Name = "cb_Khoa";
            this.cb_Khoa.Size = new System.Drawing.Size(385, 49);
            this.cb_Khoa.TabIndex = 8;
            this.cb_Khoa.SelectedIndexChanged += new System.EventHandler(this.cb_Khoa_SelectedIndexChanged);
            // 
            // btn_Them
            // 
            this.btn_Them.Font = new System.Drawing.Font("Arial", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_Them.Location = new System.Drawing.Point(732, 553);
            this.btn_Them.Name = "btn_Them";
            this.btn_Them.Size = new System.Drawing.Size(135, 58);
            this.btn_Them.TabIndex = 9;
            this.btn_Them.Text = "Thêm";
            this.btn_Them.UseVisualStyleBackColor = true;
            this.btn_Them.Click += new System.EventHandler(this.btn_Them_Click);
            // 
            // btn_Xoa
            // 
            this.btn_Xoa.Font = new System.Drawing.Font("Arial", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_Xoa.Location = new System.Drawing.Point(1107, 553);
            this.btn_Xoa.Name = "btn_Xoa";
            this.btn_Xoa.Size = new System.Drawing.Size(135, 58);
            this.btn_Xoa.TabIndex = 10;
            this.btn_Xoa.Text = "Xóa";
            this.btn_Xoa.UseVisualStyleBackColor = true;
            this.btn_Xoa.Click += new System.EventHandler(this.btn_Xoa_Click);
            // 
            // btn_Sua
            // 
            this.btn_Sua.Font = new System.Drawing.Font("Arial", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_Sua.Location = new System.Drawing.Point(918, 553);
            this.btn_Sua.Name = "btn_Sua";
            this.btn_Sua.Size = new System.Drawing.Size(135, 58);
            this.btn_Sua.TabIndex = 11;
            this.btn_Sua.Text = "Sửa";
            this.btn_Sua.UseVisualStyleBackColor = true;
            this.btn_Sua.Click += new System.EventHandler(this.btn_Sua_Click);
            // 
            // btn_Thoat
            // 
            this.btn_Thoat.Font = new System.Drawing.Font("Arial", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_Thoat.Location = new System.Drawing.Point(1021, 646);
            this.btn_Thoat.Name = "btn_Thoat";
            this.btn_Thoat.Size = new System.Drawing.Size(135, 58);
            this.btn_Thoat.TabIndex = 12;
            this.btn_Thoat.Text = "Thoát";
            this.btn_Thoat.UseVisualStyleBackColor = true;
            this.btn_Thoat.Click += new System.EventHandler(this.btn_Thoat_Click);
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Arial", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(702, 229);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(170, 41);
            this.label5.TabIndex = 13;
            this.label5.Text = "Mã Khoa:";
            // 
            // txt_MaKhoa
            // 
            this.txt_MaKhoa.Font = new System.Drawing.Font("Arial", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.txt_MaKhoa.Location = new System.Drawing.Point(928, 226);
            this.txt_MaKhoa.Name = "txt_MaKhoa";
            this.txt_MaKhoa.Size = new System.Drawing.Size(385, 49);
            this.txt_MaKhoa.TabIndex = 14;
            // 
            // btn_LamMoi
            // 
            this.btn_LamMoi.Font = new System.Drawing.Font("Arial", 16F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.btn_LamMoi.Location = new System.Drawing.Point(813, 646);
            this.btn_LamMoi.Name = "btn_LamMoi";
            this.btn_LamMoi.Size = new System.Drawing.Size(135, 58);
            this.btn_LamMoi.TabIndex = 15;
            this.btn_LamMoi.Text = "Làm mới";
            this.btn_LamMoi.UseVisualStyleBackColor = true;
            this.btn_LamMoi.Click += new System.EventHandler(this.btn_LamMoi_Click);
            // 
            // frm_QuanLyNganh
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(14F, 27F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1380, 716);
            this.Controls.Add(this.btn_LamMoi);
            this.Controls.Add(this.txt_MaKhoa);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.btn_Thoat);
            this.Controls.Add(this.btn_Sua);
            this.Controls.Add(this.btn_Xoa);
            this.Controls.Add(this.btn_Them);
            this.Controls.Add(this.cb_Khoa);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.txt_TenNganh);
            this.Controls.Add(this.txt_MaNganh);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.dgv_Nganh);
            this.Controls.Add(this.label1);
            this.Font = new System.Drawing.Font("Arial", 12F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.Margin = new System.Windows.Forms.Padding(5, 4, 5, 4);
            this.Name = "frm_QuanLyNganh";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Quản lý Ngành";
            this.Load += new System.EventHandler(this.frm_QuanLyNganh_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dgv_Nganh)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DataGridView dgv_Nganh;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox txt_MaNganh;
        private System.Windows.Forms.TextBox txt_TenNganh;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.ComboBox cb_Khoa;
        private System.Windows.Forms.Button btn_Them;
        private System.Windows.Forms.Button btn_Xoa;
        private System.Windows.Forms.Button btn_Sua;
        private System.Windows.Forms.Button btn_Thoat;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox txt_MaKhoa;
        private System.Windows.Forms.DataGridViewTextBoxColumn MaNganh;
        private System.Windows.Forms.DataGridViewTextBoxColumn TenNganh;
        private System.Windows.Forms.DataGridViewTextBoxColumn MaKhoa;
        private System.Windows.Forms.Button btn_LamMoi;
    }
}