using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Reflection.Emit;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using DataLayer;

namespace DBMS_QuanLyCanBoGiangVien
{
    public partial class frm_QuanLyCanBo : Form
    {
        private string connStr;
        private string role;
        private string maCB;

        public frm_QuanLyCanBo(string connStr, string role, string maCB)
        {
            InitializeComponent();
            this.connStr = connStr;
            this.role = role;
            this.maCB = maCB;
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            label3.Text = $"Chào mừng bạn đến với hệ thống.";
            lbl_Role.Text = $"Bạn đang đăng nhập với quyền: {role}";
        }

        private void btn_ThoatApp_Click(object sender, EventArgs e)
        {
            DialogResult result = MessageBox.Show("Bạn có chắc chắn muốn thoát?", "Xác nhận", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (result == DialogResult.Yes)
            {
                Application.Exit();
            }
        }

        private void btn_QLGiangVien_Click(object sender, EventArgs e)
        {
            frm_QuanLyGiangVien frm = new frm_QuanLyGiangVien(connStr, role, maCB);
            frm.ShowDialog();
        }

        private void btn_QLNganh_Click(object sender, EventArgs e)
        {
            frm_QuanLyNganh frm = new frm_QuanLyNganh(connStr, role, maCB);
            frm.ShowDialog();
        }

        private void btn_QLMonHoc_Click(object sender, EventArgs e)
        {
            frm_QuanLyMonHoc frm = new frm_QuanLyMonHoc(connStr, role, maCB);
            frm.ShowDialog();
        }

        private void btn_QLLopHocPhan_Click(object sender, EventArgs e)
        {
            frm_QuanLyLopHocPhan frm = new frm_QuanLyLopHocPhan(connStr, role, maCB);
            frm.ShowDialog();
        }

        private void btn_PhanCongGiangDay_Click(object sender, EventArgs e)
        {
            frm_PhanCongGiangDay frm = new frm_PhanCongGiangDay(connStr, role, maCB);  
            frm.ShowDialog();
        }

        private void btn_QLLuong_Click(object sender, EventArgs e)
        {
            frm_QuanLyLuong frm = new frm_QuanLyLuong(connStr, role, maCB);
            frm.ShowDialog();
        }
    }
}
