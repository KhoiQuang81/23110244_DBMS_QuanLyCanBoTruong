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
using System.Security.Cryptography;


namespace DBMS_QuanLyCanBoGiangVien
{
    public partial class frm_PhanCongGiangDay : Form
    {
        private DataAccess db;
        private string _role;
        private string _maCB;   // mã cán bộ đăng nhập

        private string _maMon;
        private string _maLop;
        private string _maNganh;
        private string _maCBSelected;

        public frm_PhanCongGiangDay(string connStr, string role, string maCB)
        {
            InitializeComponent();
            db = new DataAccess(connStr);
            _role = role;
            _maCB = maCB;
        }

        private void frm_PhanCongGiangDay_Load(object sender, EventArgs e)
        {
            LoadKhoa();

            cb_HocKy.Items.AddRange(new object[] { 1, 2, 3 });
            cb_HocKy.SelectedIndex = -1;

            txt_TenLopHocPhan.ReadOnly = true;
            txt_TenCB.ReadOnly = true;
            txt_SoTiet.ReadOnly = true;

            if (_role == "Admin")
            {
                // Admin toàn quyền, có thể chọn bất kỳ khoa nào
                cb_TenKhoa.Enabled = true;
            }
            else if (_role == "TruongKhoa")
            {
                cb_TenKhoa.Enabled = false;

                if (cb_TenKhoa.SelectedValue != null)
                {
                    string maKhoa = cb_TenKhoa.SelectedValue.ToString();

                    // load ngành theo khoa
                    LoadNganhByKhoa(maKhoa);

                    // load danh sách giảng viên theo khoa
                    var dtGV = db.ExecuteQuery("HasP_GetGiangVienByKhoa",
                        new SqlParameter("@MaKhoa", maKhoa));
                    dgv_GiangVien.DataSource = dtGV;

                    // load phân công theo khoa
                    var dtPC = db.ExecuteQuery("HasP_GetPhanCongByKhoa",
                        new SqlParameter("@MaKhoa", maKhoa));
                    dgv_PhanCong.DataSource = dtPC;
                }
            }
            else if (_role == "GiangVien")
            {
                // Giảng viên: cố định 1 khoa
                cb_TenKhoa.Enabled = false;

                btn_Them.Enabled = false;
                btn_Sua.Enabled = false;
                btn_Xoa.Enabled = false;

                cb_TenNganh.Enabled = false;
                cb_MonHoc.Enabled = false;
                cb_LopHocPhan.Enabled = false;
                cb_HocKy.Enabled = false;

                txt_SoTiet.ReadOnly = true;
                txt_SoTuan.ReadOnly = true;
                txt_NamHoc.ReadOnly = true;

                // chỉ xem phân công của mình
                DataTable dt = db.ExecuteQueryText("SELECT * FROM Vw_PhanCong_CuaToi");
                dgv_PhanCong.DataSource = dt;
            }
        }


        private void dgv_GiangVien_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0) return;
            var row = dgv_GiangVien.Rows[e.RowIndex];
            _maCBSelected = row.Cells["MaCB"].Value.ToString();
            txt_TenCB.Text = row.Cells["HoTen"].Value.ToString();
        }

        private void LoadKhoa()
        {
            DataTable dt;

            if (_role == "Admin")
            {
                dt = db.ExecuteQuery("NonP_GetAllKhoa");
            }
            else
            {
                // Trưởng khoa hoặc Giảng viên → chỉ load khoa của mình
                dt = db.ExecuteQueryText("SELECT MaKhoa, TenKhoa FROM Vw_Khoa_CuaToi");
            }

            cb_TenKhoa.DataSource = dt;
            cb_TenKhoa.DisplayMember = "TenKhoa";
            cb_TenKhoa.ValueMember = "MaKhoa";

            // Nếu có dữ liệu thì chọn khoa đầu tiên
            if (dt.Rows.Count > 0)
                cb_TenKhoa.SelectedIndex = 0;
        }

        private void LoadPhanCong()
        {
            if (cb_TenKhoa.SelectedValue == null) return;
            var dt = db.ExecuteQuery("HasP_GetPhanCongByKhoa",
                new SqlParameter("@MaKhoa", cb_TenKhoa.SelectedValue.ToString()));
            dgv_PhanCong.DataSource = dt;
        }

        private void LoadLopHPChuaPC()
        {
            if (string.IsNullOrEmpty(_maMon)) return;

            var dt = db.ExecuteQuery("HasP_GetLopChuaPhanCong",
                new SqlParameter("@MaMon", _maMon));

            cb_LopHocPhan.DataSource = dt;
            cb_LopHocPhan.DisplayMember = "MaLopHocPhan";
            cb_LopHocPhan.ValueMember = "MaLopHocPhan";
            cb_LopHocPhan.SelectedIndex = -1;
        }


        private void btn_Them_Click(object sender, EventArgs e)
        {
            if (cb_LopHocPhan.SelectedValue == null || string.IsNullOrEmpty(_maCBSelected))
            {
                MessageBox.Show("Vui lòng chọn lớp học phần và giảng viên!",
                    "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            try
            {
                db.ExecuteNonQuery("HasP_InsertPhanCong",
                new SqlParameter("@MaCB", _maCBSelected),
                new SqlParameter("@MaMon", _maMon),
                new SqlParameter("@MaLopHocPhan", _maLop),
                new SqlParameter("@SoTiet", int.Parse(txt_SoTiet.Text)),
                new SqlParameter("@SoTuan", int.Parse(txt_SoTuan.Text)),
                new SqlParameter("@HocKy", Convert.ToInt32(cb_HocKy.SelectedItem)),
                new SqlParameter("@NamHoc", txt_NamHoc.Text.Trim()),
                new SqlParameter("@MaNganh", _maNganh));

                LoadPhanCong();
                LoadLopHPChuaPC();
                ClearFormAfterAction();
                MessageBox.Show("Thêm phân công thành công!", "Thông báo");
            }
            catch (SqlException ex)
            {
                MessageBox.Show("Lỗi thêm phân công: " + ex.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btn_Sua_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(_maLop) || string.IsNullOrEmpty(_maCBSelected))
            {
                MessageBox.Show("Vui lòng chọn phân công để sửa!",
                    "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            try
            {
                var drv = dgv_PhanCong.CurrentRow?.DataBoundItem as DataRowView;
                if (drv == null) return;

                db.ExecuteNonQuery("HasP_UpdatePhanCong",
                    new SqlParameter("@OldMaCB", drv["MaCB"]),
                    new SqlParameter("@OldMaMon", drv["MaMon"]),
                    new SqlParameter("@OldMaLopHocPhan", drv["MaLopHocPhan"]),
                    new SqlParameter("@OldHocKy", drv["HocKy"]),
                    new SqlParameter("@OldNamHoc", drv["NamHoc"]),

                    new SqlParameter("@NewMaMon", _maMon),
                    new SqlParameter("@NewMaLopHocPhan", _maLop),
                    new SqlParameter("@NewSoTiet", int.Parse(txt_SoTiet.Text)),
                    new SqlParameter("@NewSoTuan", int.Parse(txt_SoTuan.Text)),
                    new SqlParameter("@NewHocKy", Convert.ToInt32(cb_HocKy.SelectedItem)),
                    new SqlParameter("@NewNamHoc", txt_NamHoc.Text.Trim()),
                    new SqlParameter("@NewMaNganh", _maNganh)
                );

                LoadPhanCong();
                LoadLopHPChuaPC();
                ClearFormAfterAction();
                MessageBox.Show("Cập nhật phân công thành công!", "Thông báo");
            }
            catch (SqlException ex)
            {
                MessageBox.Show("Lỗi cập nhật phân công: " + ex.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btn_Xoa_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(_maCBSelected) || string.IsNullOrEmpty(_maMon) || string.IsNullOrEmpty(_maLop))
            {
                MessageBox.Show("Vui lòng chọn phân công để xóa!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            try
            {
                db.ExecuteNonQuery("HasP_DeletePhanCong",
                new SqlParameter("@MaCB", _maCBSelected),
                new SqlParameter("@MaMon", _maMon),
                new SqlParameter("@MaLopHocPhan", _maLop),
                new SqlParameter("@HocKy", Convert.ToInt32(cb_HocKy.SelectedItem)),
                new SqlParameter("@NamHoc", txt_NamHoc.Text.Trim()));

                LoadPhanCong();
                LoadLopHPChuaPC();
                ClearFormAfterAction();
            }
            catch (SqlException ex)
            {
                MessageBox.Show("Lỗi xóa phân công: " + ex.Message, "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void ClearFormAfterAction()
        {
            _maCBSelected = _maMon = _maLop = null;

            txt_TenCB.Clear();
            txt_TenLopHocPhan.Clear();
            txt_SoTiet.Clear();
            txt_SoTuan.Clear();
            txt_NamHoc.Clear();

            cb_MonHoc.DataSource = null;
            cb_LopHocPhan.DataSource = null;
            cb_HocKy.SelectedIndex = -1;
        }

        private void btn_LamMoi_Click(object sender, EventArgs e)
        {
            _maCBSelected = _maMon = _maLop = null;
            txt_TenCB.Clear();
            cb_TenNganh.DataSource = null;
            cb_TenNganh.SelectedIndex = -1;   // ép về null

            cb_MonHoc.DataSource = null;
            cb_MonHoc.SelectedIndex = -1;

            cb_LopHocPhan.DataSource = null;
            cb_LopHocPhan.SelectedIndex = -1;

            cb_HocKy.SelectedIndex = -1;

            
            txt_TenLopHocPhan.Clear();
            txt_SoTiet.Clear();
            txt_SoTuan.Clear();
            cb_HocKy.SelectedIndex = -1;
            txt_NamHoc.Clear();
            LoadPhanCong();
        }

        private void btn_Thoat_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void dgv_PhanCong_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0) return;
            var drv = dgv_PhanCong.Rows[e.RowIndex].DataBoundItem as DataRowView;
            if (drv == null) return;

            _maCBSelected = drv["MaCB"].ToString();
            _maMon = drv["MaMon"].ToString();
            _maLop = drv["MaLopHocPhan"].ToString();

            txt_TenCB.Text = _maCBSelected;
            txt_TenLopHocPhan.Text = drv["TenMon"].ToString();
            txt_SoTiet.Text = drv["SoTiet"].ToString();
            txt_SoTuan.Text = drv["SoTuan"].ToString();
            cb_HocKy.SelectedItem = Convert.ToInt32(drv["HocKy"]);
            txt_NamHoc.Text = drv["NamHoc"].ToString();
            cb_TenNganh.SelectedValue = drv["MaNganh"].ToString();
        }


        private void cb_TenNganh_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        private void cb_LopHocPhan_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        private void cb_TenKhoa_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        private void txt_NamHoc_TextChanged_1(object sender, EventArgs e)
        {
        }

        private void cb_HocKy_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        private void txt_SoTuan_TextChanged_1(object sender, EventArgs e)
        {

        }

        private void txt_TenLopHocPhan_TextChanged(object sender, EventArgs e)
        {

        }

        private void txt_SoTiet_TextChanged(object sender, EventArgs e)
        {

        }

        private void cb_MonHoc_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        private void txt_TenCB_TextChanged(object sender, EventArgs e)
        {

        }

        private void dgv_GiangVien_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            
        }

        private void cb_TenKhoa_SelectionChangeCommitted(object sender, EventArgs e)
        {
            if (cb_TenKhoa.SelectedValue == null) return;

            string maKhoa = cb_TenKhoa.SelectedValue.ToString();

            // load ngành
            LoadNganhByKhoa(maKhoa);

            // load giảng viên
            var dtGV = db.ExecuteQuery("HasP_GetGiangVienByKhoa",
                new SqlParameter("@MaKhoa", maKhoa));
            dgv_GiangVien.DataSource = dtGV;

            // load phân công
            LoadPhanCong();
        }

        private void cb_TenNganh_SelectionChangeCommitted(object sender, EventArgs e)
        {
            if (cb_TenNganh.SelectedValue == null) return;
            _maNganh = cb_TenNganh.SelectedValue.ToString();

            var dtMon = db.ExecuteQuery("HasP_GetMonHocByNganh_PC",
                new SqlParameter("@MaNganh", _maNganh));
            cb_MonHoc.DataSource = dtMon;
            cb_MonHoc.DisplayMember = "TenMon";
            cb_MonHoc.ValueMember = "MaMon";
            cb_MonHoc.SelectedIndex = -1;
        }

        private void cb_MonHoc_SelectionChangeCommitted(object sender, EventArgs e)
        {
            if (cb_MonHoc.SelectedValue == null) return;
            _maMon = cb_MonHoc.SelectedValue.ToString();

            var dtTiet = db.ExecuteQuery("HasP_GetSoTietByMon", new SqlParameter("@MaMon", _maMon));
            if (dtTiet.Rows.Count > 0)
                txt_SoTiet.Text = dtTiet.Rows[0]["SoTiet"].ToString();

            var drv = cb_MonHoc.SelectedItem as DataRowView;
            if (drv != null)
                txt_TenLopHocPhan.Text = drv["TenMon"].ToString();

            LoadLopHPChuaPC();
        }

        private void cb_LopHocPhan_SelectionChangeCommitted(object sender, EventArgs e)
        {
            if (cb_LopHocPhan.SelectedValue == null) return;
            _maLop = cb_LopHocPhan.SelectedValue.ToString();
        }

        private void LoadNganhByKhoa(string maKhoa)
        {
            if (string.IsNullOrEmpty(maKhoa)) return;

            var dtNganh = db.ExecuteQuery("HasP_GetNganhByKhoa",
                new SqlParameter("@MaKhoa", maKhoa));

            cb_TenNganh.DataSource = dtNganh;
            cb_TenNganh.DisplayMember = "TenNganh";
            cb_TenNganh.ValueMember = "MaNganh";
            cb_TenNganh.SelectedIndex = dtNganh.Rows.Count > 0 ? 0 : -1;
        }
    }
}
