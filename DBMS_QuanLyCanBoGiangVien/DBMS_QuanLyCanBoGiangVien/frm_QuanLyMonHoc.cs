using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using DataLayer;

namespace DBMS_QuanLyCanBoGiangVien
{
    public partial class frm_QuanLyMonHoc : Form
    {
        private DataAccess db;
        private string _role;
        private string _maCB;
        private string _maCT; // lưu lại mã chương trình hiện tại
        private string _maMonSelected; // lưu mã môn được chọn để sửa/xóa

        public frm_QuanLyMonHoc(string connStr, string role, string maCB)
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
                dtKhoa = db.ExecuteQuery("NonP_GetAllKhoa");
            else
                dtKhoa = db.ExecuteQueryText("SELECT MaKhoa, TenKhoa FROM Vw_Khoa_CuaToi");

            cb_TenKhoa.DataSource = dtKhoa;
            cb_TenKhoa.DisplayMember = "TenKhoa";
            cb_TenKhoa.ValueMember = "MaKhoa";

            if (dtKhoa.Rows.Count > 0)
                cb_TenKhoa.SelectedIndex = 0;
        }

        private void LoadMon(string maCT)
        {
            DataTable dt;
            if (_role == "Admin" || _role == "TruongKhoa")
            {
                dt = db.ExecuteQuery("HasP_GetMonHocByCT",
                    new SqlParameter("@MaCT", maCT));
            }
            else // Giảng viên
            {
                dt = db.ExecuteQueryText("SELECT * FROM Vw_MonHoc_TrongKhoaCuaToi");
            }

            dgv_MonHoc.AutoGenerateColumns = false;
            dgv_MonHoc.DataSource = dt;
            dgv_MonHoc.ClearSelection();
        }

        private void btn_TimKiem_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(_maCT))
            {
                DataTable dt = db.ExecuteQuery("HasP_SearchMonHoc",
                    new SqlParameter("@MaCT", _maCT),
                    new SqlParameter("@Keyword", txt_TimMon.Text));
                dgv_MonHoc.DataSource = dt;
            }
        }

        private void frm_QuanLyMonHoc_Load(object sender, EventArgs e)
        {
            LoadKhoa();

            if (_role == "GiangVien")
            {
                btn_Them.Enabled = false;
                btn_Sua.Enabled = false;
                btn_Xoa.Enabled = false;
                cb_TenKhoa.Enabled = false;

                txt_ChuongTrinh.ReadOnly = true;
                txt_MaMon.ReadOnly = true;
                txt_TenMon.ReadOnly = true;
                txt_SoTiet.ReadOnly = true;
                txt_SoTinChi.ReadOnly = true;
                chk_BatBuoc.Enabled = false;
                btn_LamMoi.Enabled = false;

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
                cb_TenKhoa.Enabled = false;

                // tự load ngành luôn (nếu chỉ có 1 khoa)
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

        private void txt_TimMon_TextChanged(object sender, EventArgs e)
        {
            
        }

        private void cb_TenKhoa_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cb_TenKhoa.SelectedIndex >= 0 && cb_TenKhoa.SelectedValue != null)
            {
                string maKhoa = cb_TenKhoa.SelectedValue.ToString();

                DataTable dt = db.ExecuteQuery("HasP_GetNganhByKhoa",
                    new SqlParameter("@MaKhoa", maKhoa));

                cb_TenNganh.DataSource = dt;
                cb_TenNganh.DisplayMember = "TenNganh";
                cb_TenNganh.ValueMember = "MaNganh";
                cb_TenNganh.SelectedIndex = -1;

                txt_ChuongTrinh.Clear();
                dgv_MonHoc.DataSource = null;

            }
        }

        private void cb_TenNganh_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cb_TenNganh.SelectedIndex >= 0 && cb_TenNganh.SelectedValue != null)
            {
                string maNganh = cb_TenNganh.SelectedValue.ToString();

                DataTable dtCT = db.ExecuteQuery("HasP_GetChuongTrinhByNganh",
                    new SqlParameter("@MaNganh", maNganh));

                if (dtCT.Rows.Count > 0)
                {
                    _maCT = dtCT.Rows[0]["MaCT"].ToString();
                    txt_ChuongTrinh.Text = dtCT.Rows[0]["TenCT"].ToString();
                    LoadMon(_maCT);
                }
            }
        }


        private void txt_SoTiet_TextChanged(object sender, EventArgs e)
        {

        }

        private void txt_TenMon_TextChanged(object sender, EventArgs e)
        {

        }

        private void txt_SoTinChi_TextChanged(object sender, EventArgs e)
        {

        }

        private void btn_Them_Click(object sender, EventArgs e)
        {
            db.ExecuteNonQuery("HasP_InsertMonHoc",
                new SqlParameter("@MaMon", txt_MaMon.Text),
                new SqlParameter("@TenMon", txt_TenMon.Text),
                new SqlParameter("@SoTiet", int.Parse(txt_SoTiet.Text)),
                new SqlParameter("@SoTinChi", int.Parse(txt_SoTinChi.Text)),
                new SqlParameter("@MaCT", _maCT),
                new SqlParameter("@BatBuoc", chk_BatBuoc.Checked),
                new SqlParameter("@MaKhoaPhuTrach", cb_TenKhoa.SelectedValue));
            LoadMon(_maCT);
            Clear_Inputs();
        }

        private void btn_Sua_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(_maMonSelected)) return;

            db.ExecuteNonQuery("HasP_UpdateMonHoc",
                new SqlParameter("@MaMon", txt_MaMon.Text),
                new SqlParameter("@TenMon", txt_TenMon.Text),
                new SqlParameter("@SoTiet", int.Parse(txt_SoTiet.Text)),
                new SqlParameter("@SoTinChi", int.Parse(txt_SoTinChi.Text)),
                new SqlParameter("@MaCT", _maCT), 
                new SqlParameter("@BatBuoc", chk_BatBuoc.Checked),
                new SqlParameter("@MaKhoaPhuTrach", cb_TenKhoa.SelectedValue));
            LoadMon(_maCT);
            Clear_Inputs();
        }

        private void btn_Xoa_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(_maMonSelected)) return;

            db.ExecuteNonQuery("HasP_DeleteMonHoc",
                new SqlParameter("@MaMon", _maMonSelected),
                new SqlParameter("@MaCT", _maCT));
            LoadMon(_maCT);
            Clear_Inputs();
        }

        private void btn_LamMoi_Click(object sender, EventArgs e)
        {
            txt_MaMon.Clear();
            txt_TenMon.Clear();
            txt_SoTiet.Clear();
            txt_SoTinChi.Clear();
            chk_BatBuoc.Checked = false;
            _maMonSelected = null;
            txt_MaMon.ReadOnly = false;
        }

        private void Clear_Inputs()
        {
            txt_MaMon.Clear();
            txt_TenMon.Clear();
            txt_SoTiet.Clear();
            txt_SoTinChi.Clear();
            chk_BatBuoc.Checked = false;
            _maMonSelected = null;
            txt_MaMon.ReadOnly = false;
        }

        private void btn_Thoat_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void dgv_MonHoc_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                var row = dgv_MonHoc.Rows[e.RowIndex];

                // Nếu hàng đó trống (chưa có dữ liệu) thì bỏ qua
                if (row.Cells["MaMon"].Value == null) return;

                _maMonSelected = row.Cells["MaMon"].Value?.ToString();
                txt_MaMon.Text = _maMonSelected;

                txt_TenMon.Text = row.Cells["TenMon"].Value?.ToString();
                txt_SoTiet.Text = row.Cells["SoTiet"].Value?.ToString();
                txt_SoTinChi.Text = row.Cells["SoTinChi"].Value?.ToString();

                // Nếu BatBuoc có giá trị null thì mặc định là false
                if (row.Cells["BatBuoc"].Value != null && row.Cells["BatBuoc"].Value != DBNull.Value)
                    chk_BatBuoc.Checked = (bool)row.Cells["BatBuoc"].Value;
                else
                    chk_BatBuoc.Checked = false;

                txt_MaMon.ReadOnly = true; // Khóa khi sửa
            }
        }

        private void label7_Click(object sender, EventArgs e)
        {

        }

        private void label6_Click(object sender, EventArgs e)
        {

        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }
    }
}
