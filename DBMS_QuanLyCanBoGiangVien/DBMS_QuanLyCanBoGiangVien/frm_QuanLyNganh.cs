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
        private string _role;
        private string _maCB;

        public frm_QuanLyNganh(string connStr, string role, string maCB)
        {
            InitializeComponent();
            db = new DataAccess(connStr);
            _role = role;
            _maCB = maCB;
        }

        private void LoadKhoa()
        {
            DataTable dtKhoa;
            if (_role == "Admin")
            {
                dtKhoa = db.ExecuteQuery("NonP_GetAllKhoa");
            }
            else
            {
                dtKhoa = db.ExecuteQueryText("SELECT MaKhoa, TenKhoa FROM Vw_Khoa_CuaToi");
            }

            cb_Khoa.DataSource = dtKhoa;
            cb_Khoa.DisplayMember = "TenKhoa";
            cb_Khoa.ValueMember = "MaKhoa";

            if (dtKhoa.Rows.Count > 0)
            {
                cb_Khoa.SelectedIndex = 0;
                txt_MaKhoa.Text = dtKhoa.Rows[0]["MaKhoa"].ToString();
            }
        }

        private void LoadNganh(string maKhoa)
        {
            DataTable dt;
            if (_role == "Admin" || _role == "TruongKhoa")
            {
                dt = db.ExecuteQuery("HasP_GetNganhByKhoa",
                    new SqlParameter("@MaKhoa", maKhoa));
            }
            else // Giảng viên
            {
                dt = db.ExecuteQueryText("SELECT * FROM Vw_Nganh_TrongKhoaCuaToi");
            }

            dgv_Nganh.AutoGenerateColumns = false;
            dgv_Nganh.DataSource = dt;

            dgv_Nganh.ClearSelection();
        }

        private void frm_QuanLyNganh_Load(object sender, EventArgs e)
        {
            LoadKhoa();
            dgv_Nganh.ClearSelection();

            if (_role == "GiangVien")
            {
                btn_Them.Enabled = false;
                btn_Sua.Enabled = false;
                btn_Xoa.Enabled = false;

                // khóa combobox + textbox
                cb_Khoa.Enabled = false;
                txt_MaKhoa.ReadOnly = true;

                // giảng viên chỉ 1 khoa → load ngành luôn
                if (cb_Khoa.SelectedValue is string maKhoa)
                {
                    LoadNganh(maKhoa);
                }
            }
            else if (_role == "TruongKhoa")
            {
                // trưởng khoa chỉ 1 khoa → khóa combobox + textbox
                cb_Khoa.Enabled = false;
                txt_MaKhoa.ReadOnly = true;
            }
            else if (_role == "Admin")
            {
                // admin được chọn thoải mái
                cb_Khoa.Enabled = true;
                txt_MaKhoa.ReadOnly = true;
            }
        }

        private void txt_MaNganh_TextChanged(object sender, EventArgs e)
        {

        }

        private void txt_TenNganh_TextChanged(object sender, EventArgs e)
        {

        }

        private void cb_Khoa_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cb_Khoa.SelectedIndex >= 0 && cb_Khoa.SelectedValue is string)
            {
                txt_MaKhoa.Text = cb_Khoa.SelectedValue.ToString();
                LoadNganh(cb_Khoa.SelectedValue.ToString());
            }
            else
            {
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
            txt_TenNganh.Clear();
            txt_MaNganh.Clear();
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
            txt_TenNganh.Clear();
            txt_MaNganh.Clear();
        }

        private void btn_Xoa_Click(object sender, EventArgs e)
        {
            db.ExecuteNonQuery("HasP_DeleteNganh",
                new SqlParameter("@MaNganh", txt_MaNganh.Text)
            );
            LoadNganh(cb_Khoa.SelectedValue.ToString());
            txt_TenNganh.Clear();
            txt_MaNganh.Clear();
        }

        private void btn_Thoat_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        string _maNganhSelected = null;

        private void dgv_Nganh_CellClick(object sender, DataGridViewCellEventArgs e)
        {

            if (e.RowIndex < 0) return; // bỏ qua header

            var row = dgv_Nganh.Rows[e.RowIndex];

            // Nếu hàng trống thì bỏ qua
            if (row.Cells["MaNganh"].Value == null || row.Cells["MaKhoa"].Value == null)
                return;

            _maNganhSelected = row.Cells["MaNganh"].Value.ToString();
            txt_MaNganh.Text = _maNganhSelected;
            txt_TenNganh.Text = row.Cells["TenNganh"].Value?.ToString();
            txt_MaKhoa.Text = row.Cells["MaKhoa"].Value?.ToString();

            // chỉ gán combobox khi có giá trị
            if (row.Cells["MaKhoa"].Value != null)
                cb_Khoa.SelectedValue = row.Cells["MaKhoa"].Value;

            txt_MaKhoa.ReadOnly = true;   // khi chọn từ dgv thì khóa
            txt_MaNganh.ReadOnly = true;  // khi sửa thì khóa mã ngành
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
