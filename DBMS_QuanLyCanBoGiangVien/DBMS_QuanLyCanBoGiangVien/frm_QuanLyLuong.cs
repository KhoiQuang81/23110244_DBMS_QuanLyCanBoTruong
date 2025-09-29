using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using DataLayer;
using System.Data.SqlClient;

namespace DBMS_QuanLyCanBoGiangVien
{
    public partial class frm_QuanLyLuong : Form
    {
        private DataAccess db;
        private string _maCB;
        private string _role;


        public frm_QuanLyLuong(string connStr, string maCB, string role)
        {
            InitializeComponent();
            db = new DataAccess(connStr);
            _maCB = maCB;
            _role = role;
        }

        private void frm_QuanLyLuong_Load(object sender, EventArgs e)
        {
            if (_role == "Admin")
            {
                LoadLuong(); // load tất cả
                gb_ThongTin.Enabled = true; // nhóm nhập liệu được bật
            }
            else
            {
                LoadLuongByCanBo(_maCB); // load chỉ lương của giảng viên
                gb_ThongTin.Enabled = false; // ẩn hoặc disable nhập liệu
            }
            cb_Thang.Items.AddRange(Enumerable.Range(1, 12).Cast<object>().ToArray());
            cb_Nam.Items.AddRange(Enumerable.Range(2023, 10).Cast<object>().ToArray());
        }

        private void LoadLuong()
        {
            DataTable dt = db.ExecuteQueryText("SELECT * FROM Vw_CanBo_Luong");
            dgv_BangLuong.DataSource = dt;
        }

        private void LoadLuongByCanBo(string maCB)
        {
            DataTable dt = db.ExecuteQueryText("SELECT * FROM Vw_CanBo_Luong WHERE MaCB=@MaCB",
                new SqlParameter("@MaCB", maCB));
            dgv_BangLuong.DataSource = dt;
        }

        private void TinhLuong()
        {
            try
            {
                SqlParameter[] prms = new SqlParameter[]
                {
                    new SqlParameter("@MaCB", cb_CanBo.Text.Trim()),
                    new SqlParameter("@Thang", Convert.ToInt32(cb_Thang.SelectedItem)),
                    new SqlParameter("@Nam", Convert.ToInt32(cb_Nam.SelectedItem)),
                    new SqlParameter("@Thuong", string.IsNullOrWhiteSpace(txt_Thuong.Text) ? 0 : Convert.ToDecimal(txt_Thuong.Text)),
                    new SqlParameter("@KhauTru", string.IsNullOrWhiteSpace(txt_KhauTru.Text) ? 0 : Convert.ToDecimal(txt_KhauTru.Text))
                };

                db.ExecuteNonQuery("Re_TinhLuongCanBo", prms);
                MessageBox.Show("Tính lương thành công!");
                LoadLuong();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi: " + ex.Message);
            }
        }

        private void dgv_BangLuong_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void btn_TinhLuong_Click(object sender, EventArgs e)
        {
            TinhLuong();
        }

        private void btn_Xoa_Click(object sender, EventArgs e)
        {
            try
            {
                if (dgv_BangLuong.CurrentRow == null)
                {
                    MessageBox.Show("Vui lòng chọn dòng cần xóa!");
                    return;
                }

                int maBangLuong = Convert.ToInt32(dgv_BangLuong.CurrentRow.Cells["MaBangLuong"].Value);
                SqlParameter prm = new SqlParameter("@MaBangLuong", maBangLuong);

                db.ExecuteNonQuery("HasP_DeleteBangLuong", prm);
                MessageBox.Show("Xóa lương thành công!");
                LoadLuong();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi: " + ex.Message);
            }
        }

        private void cb_Thang_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void cb_Nam_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void cb_CanBo_SelectedIndexChanged(object sender, EventArgs e)
        {

        }


        private void btn_Thoát_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btn_LamMoi_Click(object sender, EventArgs e)
        {
            if (_role == "Admin")
                LoadLuong();
            else
                LoadLuongByCanBo(_maCB);

            txt_Thuong.Clear();
            txt_KhauTru.Clear();
            cb_CanBo.SelectedIndex = -1;
            cb_Thang.SelectedIndex = -1;
            cb_Nam.SelectedIndex = -1;
        }

        private void dgv_BangLuong_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0 && dgv_BangLuong.CurrentRow != null)
            {
                txt_Thuong.Text = dgv_BangLuong.CurrentRow.Cells["Thuong"].Value.ToString();
                txt_KhauTru.Text = dgv_BangLuong.CurrentRow.Cells["KhauTru"].Value.ToString();
            }
        }

        private void btn_Sua_Click(object sender, EventArgs e)
        {
            try
            {
                if (dgv_BangLuong.CurrentRow == null)
                {
                    MessageBox.Show("Vui lòng chọn dòng cần sửa!");
                    return;
                }

                int maBangLuong = Convert.ToInt32(dgv_BangLuong.CurrentRow.Cells["MaBangLuong"].Value);
                decimal thuong = string.IsNullOrWhiteSpace(txt_Thuong.Text) ? 0 : Convert.ToDecimal(txt_Thuong.Text);
                decimal khauTru = string.IsNullOrWhiteSpace(txt_KhauTru.Text) ? 0 : Convert.ToDecimal(txt_KhauTru.Text);

                SqlParameter[] prms = new SqlParameter[]
                {
                    new SqlParameter("@MaBangLuong", maBangLuong),
                    new SqlParameter("@Thuong", thuong),
                    new SqlParameter("@KhauTru", khauTru)
                };

                db.ExecuteNonQuery("HasP_UpdateBangLuong", prms);
                MessageBox.Show("Cập nhật lương thành công!");
                LoadLuong();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi: " + ex.Message);
            }
        }
    }
}
