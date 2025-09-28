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
        private string _maCT; // lưu lại mã chương trình hiện tại
        private string _maMonSelected; // lưu mã môn được chọn để sửa/xóa

        public frm_QuanLyMonHoc(string connStr)
        {
            InitializeComponent();
            db = new DataAccess(connStr);
        }
        private void LoadKhoa()
        {
            DataTable dt = db.ExecuteQuery("NonP_GetAllKhoa");
            cb_TenKhoa.DataSource = dt;
            cb_TenKhoa.DisplayMember = "TenKhoa";
            cb_TenKhoa.ValueMember = "MaKhoa";
            cb_TenKhoa.SelectedIndex = -1;
        }

        private void LoadMon(string maCT)
        {
            DataTable dt = db.ExecuteQuery("HasP_GetMonHocByCT",
                new SqlParameter("@MaCT", maCT));
            dgv_MonHoc.DataSource = dt;
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
                new SqlParameter("@BatBuoc", chk_BatBuoc.Checked),
                new SqlParameter("@MaKhoaPhuTrach", cb_TenKhoa.SelectedValue));
            LoadMon(_maCT);
            Clear_Inputs();
        }

        private void btn_Xoa_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(_maMonSelected)) return;

            db.ExecuteNonQuery("HasP_DeleteMonHoc",
                new SqlParameter("@MaMon", _maMonSelected));
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
