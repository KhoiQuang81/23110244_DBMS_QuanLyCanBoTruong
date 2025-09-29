using DataLayer;
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
            string username = txt_TenDangNhap.Text.Trim();
            string password = txt_MatKhau.Text.Trim();

            // KẾT NỐI THEO SQL LOGIN
            // Kết nối SQL bằng login đã tạo trong trigger
            string connStr = $"Server=.;Database=QLCanBoGiangVien;User Id={username};Password={password};Encrypt=True;TrustServerCertificate=True;";

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open(); // Sai quyền/sai mật khẩu -> Exception
                }


                // Lấy thông tin role hiện tại bằng view/hàm RTO_CurrentPrincipal
                DataAccess.SetConnection(username, password);
                DataAccess db = new DataAccess(connStr);
                DataTable dt = db.ExecuteQueryText("SELECT RoleName, MaCB FROM dbo.RTO_CurrentPrincipal()");

                string role = dt.Rows[0]["RoleName"].ToString();
                string maCB = dt.Rows[0]["MaCB"].ToString();

                // Mở form chính và truyền role + maCB
                frm_QuanLyCanBo main = new frm_QuanLyCanBo(connStr, role, maCB);
                main.FormClosed += (s, args) => this.Close();
                main.Show();
                this.Hide();


                //var main = new frm_QuanLyCanBo(connStr);
                //main.FormClosed += (s, args) => this.Close();
                //main.Show();
                //this.Hide();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Đăng nhập thất bại: " + ex.Message);
            }
        }
    }
}
