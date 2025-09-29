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

namespace DBMS_QuanLyCanBoGiangVien
{
    public partial class frm_QuanLyLopHocPhan : Form
    {
        private DataAccess db;
        private string _role;
        private string _maCB;
        private string _maCT;
        private string _maLopSelected;

        public frm_QuanLyLopHocPhan(string connStr, string role, string maCB)
        {
            InitializeComponent();
            db = new DataAccess(connStr);
            _role = role;
            _maCB = maCB;
        }

        private void cb_TimLopTheoMon_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void btn_TimKiem_Click(object sender, EventArgs e)
        {
            if (cb_TimLopTheoMon.SelectedIndex < 0) return;

            string maMon = cb_TimLopTheoMon.SelectedValue?.ToString();
            if (string.IsNullOrEmpty(maMon)) return;

            DataTable dt = db.ExecuteQuery("HasP_GetLopHocPhanByMon",
                new SqlParameter("@MaMon", maMon));
            dgv_LopHocPhan.DataSource = dt;

        }

        private void LoadMonHocTimKiem(string maNganh)
        {
            if (string.IsNullOrEmpty(maNganh))
            {
                cb_TimLopTheoMon.DataSource = null;
                return;
            }

            DataTable dt = db.ExecuteQuery("HasP_GetMonHocByNganh",
                new SqlParameter("@MaNganh", maNganh));

            cb_TimLopTheoMon.DataSource = dt;
            cb_TimLopTheoMon.DisplayMember = "TenMon";
            cb_TimLopTheoMon.ValueMember = "MaMon";
            cb_TimLopTheoMon.SelectedIndex = -1;
        }

        private void LoadLopHocPhanByMon(string maMon)
        {
            if (string.IsNullOrEmpty(maMon)) return;

            DataTable dt;
            if (_role == "Admin" || _role == "TruongKhoa")
            {
                dt = db.ExecuteQuery("HasP_GetLopHocPhanByMon",
                    new SqlParameter("@MaMon", maMon));
            }
            else // Giảng viên
            {
                dt = db.ExecuteQueryText("SELECT * FROM Vw_LopHP_TrongKhoaCuaToi");
            }

            dgv_LopHocPhan.DataSource = dt;
        }

        private void LoadKhoa()
        {
            DataTable dtKhoa;
            if (_role == "Admin")
                dtKhoa = db.ExecuteQuery("NonP_GetAllKhoa");
            else
                dtKhoa = db.ExecuteQueryText("SELECT MaKhoa, TenKhoa FROM Vw_Khoa_CuaToi");

            cb_TenKhoa.DataSource = dtKhoa;
            cb_TenKhoa.DisplayMember = "TenKhoa";
            cb_TenKhoa.ValueMember = "MaKhoa";

            if (dtKhoa.Rows.Count > 0)
                cb_TenKhoa.SelectedIndex = 0;
        }

        private void cb_TenKhoa_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cb_TenKhoa.SelectedIndex < 0 || cb_TenKhoa.SelectedValue == null || cb_TenKhoa.SelectedValue.ToString() == "System.Data.DataRowView")
                return;

            string maKhoa = cb_TenKhoa.SelectedValue.ToString();

            // Load ngành theo khoa
            DataTable dt = db.ExecuteQuery("HasP_GetNganhByKhoa",
                new SqlParameter("@MaKhoa", maKhoa));
            cb_TenNganh.DataSource = dt;
            cb_TenNganh.DisplayMember = "TenNganh";
            cb_TenNganh.ValueMember = "MaNganh";
            cb_TenNganh.SelectedIndex = -1;

            // Reset các control bên dưới
            cb_TenMon.DataSource = null;
            txt_ChuongTrinh.Clear();
            txt_MaMon.Clear();
            txt_TenLopHocPhan.Clear();
        }

        private void cb_TenNganh_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cb_TenNganh.SelectedIndex < 0 || cb_TenNganh.SelectedValue == null || cb_TenNganh.SelectedValue.ToString() == "System.Data.DataRowView")
                return;

            string maNganh = cb_TenNganh.SelectedValue.ToString();

            // Lấy chương trình theo ngành
            DataTable dtCT = db.ExecuteQuery("HasP_GetChuongTrinhByNganh",
                new SqlParameter("@MaNganh", maNganh));

            if (dtCT.Rows.Count > 0)
            {
                _maCT = dtCT.Rows[0]["MaCT"].ToString();
                txt_ChuongTrinh.Text = dtCT.Rows[0]["TenCT"].ToString();
                txt_ChuongTrinh.ReadOnly = true;

                // Load môn theo chương trình
                DataTable dtMon = db.ExecuteQuery("HasP_GetMonHocByCT",
                    new SqlParameter("@MaCT", _maCT));
                cb_TenMon.DataSource = dtMon;
                cb_TenMon.DisplayMember = "TenMon";
                cb_TenMon.ValueMember = "MaMon";
                cb_TenMon.SelectedIndex = -1;
                LoadMonHocTimKiem(maNganh);
            }
            else
            {
                _maCT = null;
                txt_ChuongTrinh.Clear();
                cb_TenMon.DataSource = null;
                cb_TimLopTheoMon.DataSource = null;
            }

            // Reset môn
            txt_MaMon.Clear();
            txt_TenLopHocPhan.Clear();
        }

        private void cb_TenMon_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cb_TenMon.SelectedIndex < 0 || cb_TenMon.SelectedValue == null || cb_TenMon.SelectedValue.ToString() == "System.Data.DataRowView")
                return;

            string maMon = cb_TenMon.SelectedValue.ToString();

            txt_MaMon.Text = maMon;
            txt_MaMon.ReadOnly = true;
            txt_TenLopHocPhan.Text = cb_TenMon.Text; // Tên lớp = tên môn
            txt_TenLopHocPhan.ReadOnly = true;

            // Khi chọn môn → load danh sách lớp học phần
            LoadLopHocPhanByMon(maMon);
        }

        private void txt_ChuongTrinh_TextChanged(object sender, EventArgs e)
        {
            
        }

        private void txt_TenLopHocPhan_TextChanged(object sender, EventArgs e)
        {

        }

        private void txt_SoLuongSV_TextChanged(object sender, EventArgs e)
        {

        }

        private void txt_MaMon_TextChanged(object sender, EventArgs e)
        {

        }

        private void txt_MaSoLop_TextChanged(object sender, EventArgs e)
        {

        }

        private void btn_Them_Click(object sender, EventArgs e)
        {
            if (cb_TenMon.SelectedValue == null || !int.TryParse(txt_MaSoLop.Text, out var soThuTu) ||  !int.TryParse(txt_SoLuongSV.Text, out var soLuong))
            {
                MessageBox.Show("Vui lòng chọn môn và nhập Số thứ tự / Số lượng SV hợp lệ!");
                return;
            }

            try
            {
                db.ExecuteNonQuery("HasP_InsertLopHocPhan",
                    new SqlParameter("@MaMon", (string)cb_TenMon.SelectedValue),
                    new SqlParameter("@SoThuTu", soThuTu),
                    new SqlParameter("@SoLuongSV", soLuong)
                );

                LoadLopHocPhanByMon((string)cb_TenMon.SelectedValue);
                txt_MaSoLop.Clear();
                txt_SoLuongSV.Clear();
            }
            catch (SqlException ex)
            {
                MessageBox.Show(ex.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

        }

        private void btn_Sua_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(_maLopSelected) || string.IsNullOrEmpty(txt_MaSoLop.Text) || string.IsNullOrEmpty(txt_SoLuongSV.Text))
            {
                MessageBox.Show("Vui lòng chọn lớp học phần để sửa!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            try
            {
                db.ExecuteNonQuery("HasP_UpdateLopHocPhan",
                    new SqlParameter("@OldMaLopHocPhan", _maLopSelected),
                    new SqlParameter("@SoThuTu", int.Parse(txt_MaSoLop.Text)),
                    new SqlParameter("@SoLuongSV", int.Parse(txt_SoLuongSV.Text))
                );

                LoadLopHocPhanByMon(txt_MaMon.Text);
                txt_MaSoLop.Clear();
                txt_SoLuongSV.Clear();
                MessageBox.Show("Cập nhật lớp học phần thành công!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi cập nhật lớp học phần: " + ex.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btn_Xoa_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(_maLopSelected))
            {
                MessageBox.Show("Vui lòng chọn lớp học phần để xóa!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            try
            {
                db.ExecuteNonQuery("HasP_DeleteLopHocPhan",
                    new SqlParameter("@MaLopHocPhan", _maLopSelected)
                );

                LoadLopHocPhanByMon(txt_MaMon.Text);
                txt_MaSoLop.Clear();
                txt_SoLuongSV.Clear();
                MessageBox.Show("Xóa lớp học phần thành công!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi xóa lớp học phần: " + ex.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btn_LamMoi_Click(object sender, EventArgs e)
        {
            txt_MaMon.Clear();
            txt_TenLopHocPhan.Clear();
            txt_SoLuongSV.Clear();
            txt_MaSoLop.Clear();
            _maLopSelected = null;
            cb_TenMon.SelectedIndex = -1;
            dgv_LopHocPhan.DataSource = null;
        }

        private void btn_Thoat_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void dgv_LopHocPhan_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0) return;

            var row = dgv_LopHocPhan.Rows[e.RowIndex];
            _maLopSelected = row.Cells["MaLopHocPhan"].Value?.ToString();
            txt_TenLopHocPhan.Text = row.Cells["TenLopHocPhan"].Value?.ToString();
            txt_SoLuongSV.Text = row.Cells["SoLuongSV"].Value?.ToString();

            // Gợi ý Số thứ tự từ mã lớp: MaMon-XYZ
            var parts = _maLopSelected?.Split('-');
            if (parts?.Length == 2 && int.TryParse(parts[1], out var stt))
                txt_MaSoLop.Text = stt.ToString();
        }

        private void frm_QuanLyLopHocPhan_Load(object sender, EventArgs e)
        {
            LoadKhoa();
            dgv_LopHocPhan.AutoGenerateColumns = false;

            if (_role == "GiangVien")
            {
                // Giảng viên chỉ được xem
                btn_Them.Enabled = false;
                btn_Sua.Enabled = false;
                btn_Xoa.Enabled = false;

                cb_TenKhoa.Enabled = false;  // chỉ 1 khoa của giảng viên

                // Tự load ngành luôn vì chỉ có 1 khoa
                if (cb_TenKhoa.Items.Count > 0)
                {
                    string maKhoa = cb_TenKhoa.SelectedValue?.ToString();
                    if (!string.IsNullOrEmpty(maKhoa))
                    {
                        DataTable dt = db.ExecuteQuery("HasP_GetNganhByKhoa",
                            new SqlParameter("@MaKhoa", maKhoa));

                        cb_TenNganh.DataSource = dt;
                        cb_TenNganh.DisplayMember = "TenNganh";
                        cb_TenNganh.ValueMember = "MaNganh";
                        if (dt.Rows.Count > 0) cb_TenNganh.SelectedIndex = 0;
                    }
                }
            }
            else if (_role == "TruongKhoa")
            {
                cb_TenKhoa.Enabled = false; // trưởng khoa cũng chỉ 1 khoa

                // Tự load ngành luôn vì chỉ có 1 khoa
                if (cb_TenKhoa.Items.Count > 0)
                {
                    string maKhoa = cb_TenKhoa.SelectedValue?.ToString();
                    if (!string.IsNullOrEmpty(maKhoa))
                    {
                        DataTable dt = db.ExecuteQuery("HasP_GetNganhByKhoa",
                            new SqlParameter("@MaKhoa", maKhoa));

                        cb_TenNganh.DataSource = dt;
                        cb_TenNganh.DisplayMember = "TenNganh";
                        cb_TenNganh.ValueMember = "MaNganh";
                        if (dt.Rows.Count > 0) cb_TenNganh.SelectedIndex = 0;
                    }
                }
            }
        }
    }
}
