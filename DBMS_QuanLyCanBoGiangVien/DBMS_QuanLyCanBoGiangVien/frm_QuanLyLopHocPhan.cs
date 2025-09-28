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
        private string _maCT;
        private string _maLopSelected;

        public frm_QuanLyLopHocPhan(string connStr)
        {
            InitializeComponent();
            db = new DataAccess(connStr);
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

            DataTable dt = db.ExecuteQuery("HasP_GetLopHocPhanByMon",
                new SqlParameter("@MaMon", maMon));
            dgv_LopHocPhan.DataSource = dt;

            //// chỉnh header cho đẹp
            //dgv_LopHocPhan.Columns["MaLopHocPhan"].HeaderText = "Mã Lớp HP";
            //dgv_LopHocPhan.Columns["MaMon"].HeaderText = "Mã Môn";
            //dgv_LopHocPhan.Columns["TenLopHocPhan"].HeaderText = "Tên Lớp HP";
            //dgv_LopHocPhan.Columns["SoLuongSV"].HeaderText = "Số lượng SV";
        }

        private void LoadKhoa()
        {
            DataTable dt = db.ExecuteQuery("NonP_GetAllKhoa");
            cb_TenKhoa.DataSource = dt;
            cb_TenKhoa.DisplayMember = "TenKhoa";
            cb_TenKhoa.ValueMember = "MaKhoa";
            cb_TenKhoa.SelectedIndex = -1;
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
            db.ExecuteNonQuery("HasP_InsertLopHocPhan",
                new SqlParameter("@MaMon", txt_MaMon.Text),
                new SqlParameter("@SoThuTu", int.Parse(txt_MaSoLop.Text)),
                new SqlParameter("@MaKhoa", cb_TenKhoa.SelectedValue),
                new SqlParameter("@MaNganh", cb_TenNganh.SelectedValue),
                new SqlParameter("@MaCT", _maCT),
                new SqlParameter("@SoLuongSV", int.Parse(txt_SoLuongSV.Text)));
            LoadLopHocPhanByMon(txt_MaMon.Text);

        }

        private void btn_Sua_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(_maLopSelected)) return;

            db.ExecuteNonQuery("HasP_UpdateLopHocPhan",
                new SqlParameter("@OldMaLopHocPhan", _maLopSelected),
                new SqlParameter("@SoThuTu", int.Parse(txt_MaSoLop.Text)),
                new SqlParameter("@SoLuongSV", int.Parse(txt_SoLuongSV.Text)));
            LoadLopHocPhanByMon(txt_MaMon.Text);
        }

        private void btn_Xoa_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(_maLopSelected)) return;

            db.ExecuteNonQuery("HasP_DeleteLopHocPhan",
                new SqlParameter("@MaLopHocPhan", _maLopSelected));
            LoadLopHocPhanByMon(txt_MaMon.Text);
            txt_MaMon.Clear();
            txt_TenLopHocPhan.Clear();
            txt_SoLuongSV.Clear();
            txt_MaSoLop.Clear();
            _maLopSelected = null;
            cb_TenMon.SelectedIndex = -1;
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
            if (e.RowIndex >= 0)
            {
                var row = dgv_LopHocPhan.Rows[e.RowIndex];
                _maLopSelected = row.Cells["MaLopHocPhan"].Value.ToString();
                //txt_MaMon.Text = row.Cells["MaMon"].Value.ToString();
                txt_TenLopHocPhan.Text = row.Cells["TenLopHocPhan"].Value.ToString();
                txt_SoLuongSV.Text = row.Cells["SoLuongSV"].Value.ToString();
            }
        }

        private void frm_QuanLyLopHocPhan_Load(object sender, EventArgs e)
        {
            LoadKhoa();
            dgv_LopHocPhan.AutoGenerateColumns = false;
        }
    }
}
