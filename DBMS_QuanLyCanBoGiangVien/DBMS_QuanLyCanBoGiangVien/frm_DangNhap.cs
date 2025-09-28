using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;

namespace DBMS_QuanLyCanBoGiangVien
{
    public partial class frm_DangNhap : Form
    {
        public frm_DangNhap()
        {
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void txt_TenDangNhap_TextChanged(object sender, EventArgs e)
        {

        }

        private void txt_MatKhau_TextChanged(object sender, EventArgs e)
        {

        }

        private void btn_Thoat_Click(object sender, EventArgs e)
        {
            DialogResult result = MessageBox.Show("Bạn có chắc chắn muốn thoát?", "Xác nhận", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (result == DialogResult.Yes)
            {
                Application.Exit();
            }
        }

        private void btn_DangNhap_Click(object sender, EventArgs e)
        {
            //string username = txt_TenDangNhap.Text.Trim();
            //string password = txt_MatKhau.Text.Trim();

            //// Connection string động, dùng chính SQL Login
            //string connStr = $"Server=.;Database=QLCanBoGiangVien;User Id={username};Password={password};";

            //try
            //{
            //    using (SqlConnection conn = new SqlConnection(connStr))
            //    {
            //        conn.Open(); // Nếu login sai hoặc không có quyền → Exception
            //        MessageBox.Show("Đăng nhập thành công!");

            //        // Truyền connStr qua FormMain để các form khác dùng
            //        frm_QuanLyCanBo main = new frm_QuanLyCanBo(connStr, username);
            //        main.Show();
            //        this.Hide();
            //    }
            //}
            //catch (Exception ex)
            //{
            //    MessageBox.Show("Đăng nhập thất bại: " + ex.Message);
            //}
            //MessageBox.Show("Đăng nhập thành công!");
            //frm_QuanLyCanBo main = new frm_QuanLyCanBo();
            //main.Show();
            //this.Hide();

            // ví dụ dựng tạm connStr: tích hợp Windows (test nhanh)
            string connStr = "Server=.;Database=QLCanBoGiangVien;Integrated Security=True";

            // hoặc nếu dùng SQL Login:
            // string connStr = $"Server=.;Database=QLCanBoGiangVien;User Id={txtUser.Text};Password={txtPass.Text};";

            var main = new frm_QuanLyCanBo(connStr);
            main.FormClosed += (s, args) => this.Close();  // đóng app khi form chính đóng
            main.Show();
            this.Hide();
        }
    }
}
