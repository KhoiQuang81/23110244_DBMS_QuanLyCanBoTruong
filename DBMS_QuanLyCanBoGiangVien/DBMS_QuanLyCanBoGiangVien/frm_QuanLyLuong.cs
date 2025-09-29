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


        public frm_QuanLyLuong(string connStr, string role, string maCB)
        {
            InitializeComponent();
            db = new DataAccess(connStr);
            _maCB = maCB;
            _role = role;
        }

        private void frm_QuanLyLuong_Load(object sender, EventArgs e)
        {
            cb_Thang.Items.AddRange(Enumerable.Range(1, 12).Cast<object>().ToArray());
            cb_Nam.Items.AddRange(Enumerable.Range(2023, 10).Cast<object>().ToArray());

            LoadCanBo();

            if (_role == "Admin")
            {
                LoadLuong(); // SELECT từ Vw_CanBo_Luong
                gb_ThongTin.Enabled = true;
                btn_TinhLuong.Enabled = true;
                btn_Sua.Enabled = true;
                btn_Xoa.Enabled = true;
            }
            else
            {
                LoadLuongByCanBo(_maCB); // SELECT từ Vw_Luong_CuaToi
                gb_ThongTin.Enabled = false;
                btn_TinhLuong.Enabled = false;
                btn_Sua.Enabled = false;
                btn_Xoa.Enabled = false;
            }
        }


        private void LoadCanBo()
        {
            DataTable dt;

            if (_role == "Admin")
            {
                // Admin xem được tất cả cán bộ
                dt = db.ExecuteQueryText("SELECT MaCB, HoTen FROM CanBo");
            }
            else
            {
                // Trưởng khoa, Giảng viên → chỉ load chính mình
                dt = db.ExecuteQueryText("SELECT * FROM Vw_Luong_CuaToi",
                    new SqlParameter("@MaCB", _maCB));
            }

            cb_CanBo.DataSource = dt;
            cb_CanBo.DisplayMember = "HoTen";
            cb_CanBo.ValueMember = "MaCB";

            if (dt.Rows.Count > 0)
                cb_CanBo.SelectedIndex = 0;
        }


        //private void LoadLuong()
        //{
        //    DataTable dt = db.ExecuteQueryText("SELECT * FROM Vw_CanBo_Luong");
        //    dgv_BangLuong.DataSource = dt;
        //}

        private void LoadLuong()
        {
            DataTable dt = db.ExecuteQueryText("SELECT * FROM Vw_CanBo_Luong");
            dgv_BangLuong.DataSource = dt;
        }

        private void LoadLuongByCanBo(string maCB)
        {
            DataTable dt = db.ExecuteQueryText("SELECT * FROM Vw_Luong_CuaToi");
            dgv_BangLuong.DataSource = dt;
        }

        private void TinhLuong()
        {
            try
            {
                SqlParameter[] prms = new SqlParameter[]
                {
                    new SqlParameter("@MaCB", cb_CanBo.SelectedValue.ToString()),
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

                string maCB = dgv_BangLuong.CurrentRow.Cells["MaCB"].Value.ToString();
                int thang = Convert.ToInt32(dgv_BangLuong.CurrentRow.Cells["Thang"].Value);
                int nam = Convert.ToInt32(dgv_BangLuong.CurrentRow.Cells["Nam"].Value);

                db.ExecuteNonQuery("HasP_DeleteBangLuong",
                    new SqlParameter("@MaCB", maCB),
                    new SqlParameter("@Thang", thang),
                    new SqlParameter("@Nam", nam));

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
                DataGridViewRow row = dgv_BangLuong.CurrentRow;

                cb_CanBo.SelectedValue = row.Cells["MaCB"].Value.ToString();
                cb_Thang.SelectedItem = Convert.ToInt32(row.Cells["Thang"].Value);
                cb_Nam.SelectedItem = Convert.ToInt32(row.Cells["Nam"].Value);
                txt_Thuong.Text = row.Cells["Thuong"].Value.ToString();
                txt_KhauTru.Text = row.Cells["KhauTru"].Value.ToString();
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

                string maCB = dgv_BangLuong.CurrentRow.Cells["MaCB"].Value.ToString();
                int thang = Convert.ToInt32(dgv_BangLuong.CurrentRow.Cells["Thang"].Value);
                int nam = Convert.ToInt32(dgv_BangLuong.CurrentRow.Cells["Nam"].Value);

                decimal thuong = string.IsNullOrWhiteSpace(txt_Thuong.Text) ? 0 : Convert.ToDecimal(txt_Thuong.Text);
                decimal khauTru = string.IsNullOrWhiteSpace(txt_KhauTru.Text) ? 0 : Convert.ToDecimal(txt_KhauTru.Text);

                db.ExecuteNonQuery("HasP_UpdateBangLuong",
                    new SqlParameter("@MaCB", maCB),
                    new SqlParameter("@Thang", thang),
                    new SqlParameter("@Nam", nam),
                    new SqlParameter("@Thuong", thuong),
                    new SqlParameter("@KhauTru", khauTru));

                MessageBox.Show("Cập nhật lương thành công!");
                LoadLuong();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi: " + ex.Message);
            }
        }

        private void txt_Thuong_TextChanged(object sender, EventArgs e)
        {

        }

        private void txt_KhauTru_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
