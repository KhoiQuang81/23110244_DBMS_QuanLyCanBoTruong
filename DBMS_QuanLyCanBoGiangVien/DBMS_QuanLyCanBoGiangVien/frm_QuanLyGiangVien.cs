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
    public partial class frm_QuanLyGiangVien : Form
    {
        private DataAccess db;

        public frm_QuanLyGiangVien(string connStr)
        {
            InitializeComponent();
            db = new DataAccess(connStr);
        }

        private void frm_QuanLyGiangVien_Load(object sender, EventArgs e)
        {
            cb_GioiTinh.Items.Clear();
            cb_GioiTinh.Items.Add("M");
            cb_GioiTinh.Items.Add("F");
            cb_GioiTinh.SelectedIndex = -1;
            LoadGiangVien();
        }

        private void LoadGiangVien()
        {
            DataTable dt = db.ExecuteQuery("NonP_GetAllCanBo");
            dgv_GiangVien.DataSource = dt;
        }



        private void button5_Click(object sender, EventArgs e)
        {
            this.Close();
        }


        private void btn_Them_Click(object sender, EventArgs e)
        {
            db.ExecuteNonQuery("HasP_InsertCanBo",
            new SqlParameter("@MaCB", txt_MaCB.Text),
            new SqlParameter("@HoTen", txt_HoTen.Text),
            new SqlParameter("@NgaySinh", dt_NgaySinh.Value),
            new SqlParameter("@GioiTinh", cb_GioiTinh.Text),
            new SqlParameter("@Email", txt_Email.Text),
            new SqlParameter("@Phone", txt_Phone.Text),
            new SqlParameter("@MaKhoa", txt_MaKhoa.Text),
            new SqlParameter("@MaChucVu", txt_MaChucVu.Text),
            new SqlParameter("@MaTrinhDo", txt_MaTrinhDo.Text));
            LoadGiangVien();
        }

        private void btn_Sua_Click(object sender, EventArgs e)
        {
            db.ExecuteNonQuery("HasP_UpdateCanBo",
            new SqlParameter("@MaCB", txt_MaCB.Text),
            new SqlParameter("@HoTen", txt_HoTen.Text),
            new SqlParameter("@NgaySinh", dt_NgaySinh.Value),
            new SqlParameter("@GioiTinh", cb_GioiTinh.Text),
            new SqlParameter("@Email", txt_Email.Text),
            new SqlParameter("@Phone", txt_Phone.Text),
            new SqlParameter("@MaKhoa", txt_MaKhoa.Text),
            new SqlParameter("@MaChucVu", txt_MaChucVu.Text),
            new SqlParameter("@MaTrinhDo", txt_MaTrinhDo.Text));
            LoadGiangVien();
        }

        private void btn_Xoa_Click(object sender, EventArgs e)
        {
            db.ExecuteNonQuery("HasP_DeleteCanBo",
            new SqlParameter("@MaCB", txt_MaCB.Text)
            );
            LoadGiangVien();
        }

        private void dgv_GiangVien_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                DataGridViewRow row = dgv_GiangVien.Rows[e.RowIndex];
                txt_MaCB.Text = row.Cells["MaCB"].Value.ToString();
                txt_HoTen.Text = row.Cells["HoTen"].Value.ToString();
                txt_Email.Text = row.Cells["Email"].Value.ToString();
                txt_Phone.Text = row.Cells["Phone"].Value.ToString();
                txt_MaKhoa.Text = row.Cells["MaKhoa"].Value.ToString();
                txt_MaChucVu.Text = row.Cells["MaChucVu"].Value.ToString();
                txt_MaTrinhDo.Text = row.Cells["MaTrinhDo"].Value.ToString();
                cb_GioiTinh.Text = row.Cells["GioiTinh"].Value.ToString();
                dt_NgaySinh.Value = Convert.ToDateTime(row.Cells["NgaySinh"].Value);
            }
        }

        private void btn_TimKiem_Click(object sender, EventArgs e)
        {
            string keyword = txt_TimTenGV.Text.Trim();

            if (string.IsNullOrEmpty(keyword))
            {
                // Nếu không nhập gì thì load lại toàn bộ
                LoadGiangVien();
                return;
            }

            DataTable dt = db.ExecuteQuery("HasP_GetCanBoByName",
                new SqlParameter("@HoTen", keyword));

            dgv_GiangVien.DataSource = dt;
        }

        private void btn_LamMoi_Click(object sender, EventArgs e)
        {
            txt_MaCB.Clear();
            txt_HoTen.Clear();
            txt_Email.Clear();
            txt_Phone.Clear();
            txt_MaKhoa.Clear();
            txt_MaChucVu.Clear();
            txt_MaTrinhDo.Clear();
            txt_TimTenGV.Clear();
            cb_GioiTinh.SelectedIndex = -1;
            dt_NgaySinh.Value = DateTime.Today;

            dgv_GiangVien.ClearSelection();

            LoadGiangVien();
        }
    }
}
