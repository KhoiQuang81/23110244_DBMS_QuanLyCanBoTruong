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

        // biến giữ lựa chọn hiện tại
        private string _maCB;
        private string _maMon;
        private string _maLop;

        public frm_PhanCongGiangDay(string connStr)
        {
            InitializeComponent();
            db = new DataAccess(connStr);
        }

        private void frm_PhanCongGiangDay_Load(object sender, EventArgs e)
        {
            // Khoa
            LoadKhoa();
            cb_HocKy.Items.AddRange(new object[] { 1, 2, 3 });
            cb_HocKy.SelectedIndex = -1;

            // các textbox readonly
            txt_TenLopHocPhan.ReadOnly = true;
            txt_TenCB.ReadOnly = true;
            txt_SoTiet.ReadOnly = true;
        }

        private void dgv_GiangVien_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0) return;
            var row = dgv_GiangVien.Rows[e.RowIndex];
            _maCB = row.Cells["MaCB"].Value.ToString();
            txt_TenCB.Text = row.Cells["HoTen"].Value.ToString();
        }

        private void LoadKhoa()
        {
            var dt = db.ExecuteQuery("NonP_GetAllKhoa");
            cb_TenKhoa.DataSource = dt;
            cb_TenKhoa.DisplayMember = "TenKhoa";
            cb_TenKhoa.ValueMember = "MaKhoa";
            cb_TenKhoa.SelectedIndex = -1;
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
            cb_LopHocPhan.DisplayMember = "MaLopHocPhan";   // cho người dùng dễ chọn
            cb_LopHocPhan.ValueMember = "MaLopHocPhan";
            cb_LopHocPhan.SelectedIndex = -1;
        }


        private void btn_Them_Click(object sender, EventArgs e)
        {
            db.ExecuteNonQuery("HasP_InsertPhanCong",
            new SqlParameter("@MaCB", _maCB),
            new SqlParameter("@MaMon", _maMon),
            new SqlParameter("@MaLopHocPhan", _maLop),
            new SqlParameter("@SoTiet", int.Parse(txt_SoTiet.Text)),
            new SqlParameter("@SoTuan", int.Parse(txt_SoTuan.Text)),
            new SqlParameter("@HocKy", Convert.ToInt32(cb_HocKy.SelectedItem)),
            new SqlParameter("@NamHoc", txt_NamHoc.Text.Trim()));

            LoadPhanCong();
            LoadLopHPChuaPC();
            ClearFormAfterAction();
        }

        private void btn_Sua_Click(object sender, EventArgs e)
        {
            // giả sử đang chọn 1 row
            var drv = dgv_PhanCong.CurrentRow?.DataBoundItem as DataRowView;
            if (drv == null) return;

            db.ExecuteNonQuery("HasP_UpdatePhanCong",
                new SqlParameter("@Old_MaCB", drv["MaCB"]),
                new SqlParameter("@Old_MaMon", drv["MaMon"]),
                new SqlParameter("@Old_MaLopHocPhan", drv["MaLopHocPhan"]),
                new SqlParameter("@Old_HocKy", drv["HocKy"]),
                new SqlParameter("@Old_NamHoc", drv["NamHoc"]),
                new SqlParameter("@New_MaMon", _maMon),
                new SqlParameter("@New_MaLopHocPhan", _maLop),
                new SqlParameter("@New_SoTiet", int.Parse(txt_SoTiet.Text)),
                new SqlParameter("@New_SoTuan", int.Parse(txt_SoTuan.Text)),
                new SqlParameter("@New_HocKy", Convert.ToInt32(cb_HocKy.SelectedItem)),
                new SqlParameter("@New_NamHoc", txt_NamHoc.Text.Trim()));

            LoadPhanCong();
            LoadLopHPChuaPC();
            ClearFormAfterAction();
        }

        private void btn_Xoa_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(_maCB) || string.IsNullOrEmpty(_maMon) || string.IsNullOrEmpty(_maLop)) return;

            db.ExecuteNonQuery("HasP_DeletePhanCong",
                new SqlParameter("@MaCB", _maCB),
                new SqlParameter("@MaMon", _maMon),
                new SqlParameter("@MaLopHocPhan", _maLop),
                new SqlParameter("@HocKy", Convert.ToInt32(cb_HocKy.SelectedItem)),
                new SqlParameter("@NamHoc", txt_NamHoc.Text.Trim()));

            LoadPhanCong();
            LoadLopHPChuaPC();
            ClearFormAfterAction();
        }

        private void ClearFormAfterAction()
        {
            _maCB = _maMon = _maLop = null;

            // clear textbox
            txt_TenCB.Clear();
            txt_TenLopHocPhan.Clear();
            txt_SoTiet.Clear();
            txt_SoTuan.Clear();
            txt_NamHoc.Clear();


            // clear combobox chỉ trừ Khoa, Ngành
            cb_MonHoc.DataSource = null;
            cb_LopHocPhan.DataSource = null;
            cb_HocKy.SelectedIndex = -1;
        }

        private void btn_LamMoi_Click(object sender, EventArgs e)
        {
            _maCB = _maMon = _maLop = null;
            txt_TenCB.Clear();
            cb_TenNganh.DataSource = null;
            cb_MonHoc.DataSource = null;
            cb_LopHocPhan.DataSource = null;
            txt_TenLopHocPhan.Clear();
            txt_SoTiet.Clear();
            txt_SoTuan.Clear();
            cb_HocKy.SelectedIndex = -1;
            txt_NamHoc.Clear();
            //dgv_PhanCong.DataSource = null;
            //Reload lại dgv_PhanCong
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

            _maCB = drv["MaCB"].ToString();
            _maMon = drv["MaMon"].ToString();
            _maLop = drv["MaLopHocPhan"].ToString();

            txt_TenCB.Text = _maCB; // hoặc load lại tên từ dgv_GiangVien nếu cần
            txt_TenLopHocPhan.Text = drv["TenMon"].ToString();
            txt_SoTiet.Text = drv["SoTiet"].ToString();
            txt_SoTuan.Text = drv["SoTuan"].ToString();
            cb_HocKy.SelectedItem = Convert.ToInt32(drv["HocKy"]);
            txt_NamHoc.Text = drv["NamHoc"].ToString();
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
            var dtNganh = db.ExecuteQuery("HasP_GetNganhByKhoa",
                new SqlParameter("@MaKhoa", cb_TenKhoa.SelectedValue.ToString()));
            cb_TenNganh.DataSource = dtNganh;
            cb_TenNganh.DisplayMember = "TenNganh";
            cb_TenNganh.ValueMember = "MaNganh";
            cb_TenNganh.SelectedIndex = -1;

            var dtGV = db.ExecuteQuery("HasP_GetGiangVienByKhoa",
                new SqlParameter("@MaKhoa", cb_TenKhoa.SelectedValue.ToString()));
            dgv_GiangVien.DataSource = dtGV;

            LoadPhanCong();
        }

        private void cb_TenNganh_SelectionChangeCommitted(object sender, EventArgs e)
        {
            if (cb_TenNganh.SelectedValue == null) return;
            var dtMon = db.ExecuteQuery("HasP_GetMonHocByNganh_PC",
                new SqlParameter("@MaNganh", cb_TenNganh.SelectedValue.ToString()));
            cb_MonHoc.DataSource = dtMon;
            cb_MonHoc.DisplayMember = "TenMon";
            cb_MonHoc.ValueMember = "MaMon";
            cb_MonHoc.SelectedIndex = -1;
        }

        private void cb_MonHoc_SelectionChangeCommitted(object sender, EventArgs e)
        {
            if (cb_MonHoc.SelectedValue == null) return;
            _maMon = cb_MonHoc.SelectedValue.ToString();

            // số tiết
            var dtTiet = db.ExecuteQuery("HasP_GetSoTietByMon", new SqlParameter("@MaMon", _maMon));
            if (dtTiet.Rows.Count > 0)
                txt_SoTiet.Text = dtTiet.Rows[0]["SoTiet"].ToString();

            // tên lớp = tên môn (readonly)
            var drv = cb_MonHoc.SelectedItem as DataRowView;
            if (drv != null)
                txt_TenLopHocPhan.Text = drv["TenMon"].ToString();

            // load lớp học phần
            LoadLopHPChuaPC();
        }

        private void cb_LopHocPhan_SelectionChangeCommitted(object sender, EventArgs e)
        {
            if (cb_LopHocPhan.SelectedValue == null) return;
            _maLop = cb_LopHocPhan.SelectedValue.ToString();
            var drv = cb_LopHocPhan.SelectedItem as DataRowView;
            //if (drv != null)
            //    txt_TenLopHocPhan.Text = drv["TenLopHocPhan"].ToString();
        }
    }
}
