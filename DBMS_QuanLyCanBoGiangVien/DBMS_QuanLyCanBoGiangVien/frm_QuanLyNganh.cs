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
    public partial class frm_QuanLyNganh : Form
    {
        private DataAccess db;

        public frm_QuanLyNganh(string connStr)
        {
            InitializeComponent();
            db = new DataAccess(connStr);
        }

        private void LoadKhoa()
        {
            DataTable dtKhoa = db.ExecuteQuery("NonP_GetAllKhoa");
            cb_Khoa.DataSource = dtKhoa;
            cb_Khoa.DisplayMember = "TenKhoa";   // hiện tên
            cb_Khoa.ValueMember = "MaKhoa";      // giá trị ẩn
            cb_Khoa.SelectedIndex = -1;
        }

        private void LoadNganh(string maKhoa)
        {
            DataTable dt = db.ExecuteQuery("HasP_GetNganhByKhoa",
                new SqlParameter("@MaKhoa", maKhoa));
            dgv_Nganh.AutoGenerateColumns = false; // Ngăn tự sinh cột
            dgv_Nganh.DataSource = dt;
        }

        private void frm_QuanLyNganh_Load(object sender, EventArgs e)
        {
            LoadKhoa();
            dgv_Nganh.ClearSelection();
        }

        private void txt_MaNganh_TextChanged(object sender, EventArgs e)
        {

        }

        private void txt_TenNganh_TextChanged(object sender, EventArgs e)
        {

        }

        private void cb_Khoa_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cb_Khoa.SelectedIndex >= 0)
            {
                // hiển thị MaKhoa trong textbox
                txt_MaKhoa.Text = cb_Khoa.SelectedValue.ToString();

                // load ngành theo khoa
                LoadNganh(cb_Khoa.SelectedValue.ToString());
            }
            else
            {
                // nếu chưa chọn gì thì clear
                txt_MaKhoa.Clear();
                dgv_Nganh.DataSource = null;
            }
        }

        private void btn_Them_Click(object sender, EventArgs e)
        {
            db.ExecuteNonQuery("HasP_InsertNganh",
                new SqlParameter("@MaNganh", txt_MaNganh.Text),
                new SqlParameter("@TenNganh", txt_TenNganh.Text),
                new SqlParameter("@MaKhoa", cb_Khoa.SelectedValue)  // lấy mã khoa từ combobox
            );
            LoadNganh(cb_Khoa.SelectedValue.ToString());
        }

        private void btn_Sua_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(_maNganhSelected)) return;

            db.ExecuteNonQuery("HasP_UpdateNganh",
                new SqlParameter("@MaNganh", txt_MaNganh.Text),
                new SqlParameter("@TenNganh", txt_TenNganh.Text),
                new SqlParameter("@MaKhoa", cb_Khoa.SelectedValue)
             );
            LoadNganh(cb_Khoa.SelectedValue.ToString());
        }

        private void btn_Xoa_Click(object sender, EventArgs e)
        {
            db.ExecuteNonQuery("HasP_DeleteNganh",
                new SqlParameter("@MaNganh", txt_MaNganh.Text)
            );
            LoadNganh(cb_Khoa.SelectedValue.ToString());
        }

        private void btn_Thoat_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        string _maNganhSelected = null;

        private void dgv_Nganh_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            //if (e.RowIndex >= 0)
            //{
            //    DataGridViewRow row = dgv_Nganh.Rows[e.RowIndex];
            //    txt_MaNganh.Text = row.Cells["MaNganh"].Value.ToString();
            //    txt_TenNganh.Text = row.Cells["TenNganh"].Value.ToString();

            //    string maKhoa = row.Cells["MaKhoa"].Value.ToString();
            //    txt_MaKhoa.Text = maKhoa;
            //    txt_MaKhoa.Enabled = true; // Khóa không cho sửa MaKhoa trực tiếp

            //    cb_Khoa.SelectedValue = maKhoa;
            //}


            //if (e.RowIndex >= 0)
            //{
            //    var row = dgv_Nganh.Rows[e.RowIndex];
            //    _maNganhSelected = row.Cells["MaNganh"].Value.ToString();

            //    txt_MaNganh.Text = _maNganhSelected;
            //    txt_TenNganh.Text = row.Cells["TenNganh"].Value.ToString();
            //    var maKhoa = row.Cells["MaKhoa"].Value.ToString();
            //    cb_Khoa.SelectedValue = maKhoa;

            //    txt_MaNganh.ReadOnly = true;   // khóa khi sửa
            //}


            if (e.RowIndex >= 0) // đảm bảo click không phải header
            {
                var row = dgv_Nganh.Rows[e.RowIndex];

                // Nếu hàng trống thì bỏ qua
                if (row.Cells["MaNganh"].Value == null) return;

                _maNganhSelected = row.Cells["MaNganh"].Value.ToString();
                txt_MaNganh.Text = _maNganhSelected;
                txt_TenNganh.Text = row.Cells["TenNganh"].Value?.ToString();
                txt_MaKhoa.Text = row.Cells["MaKhoa"].Value?.ToString();

                cb_Khoa.SelectedValue = row.Cells["MaKhoa"].Value;
                txt_MaKhoa.ReadOnly = true;  // khi chọn từ dgv thì khóa


                txt_MaNganh.ReadOnly = true;   // khi sửa thì khóa mã ngành
            }
        }

        private void btn_LamMoi_Click(object sender, EventArgs e)
        {
            txt_MaNganh.Clear();
            txt_TenNganh.Clear();

            txt_MaNganh.ReadOnly = false;  // mở lại khi thêm mới
            _maNganhSelected = null;
        }
    }
}
