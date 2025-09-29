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

namespace DBMS_QuanLyCanBoGiangVien
{
    public partial class frm_QuanLyCanBo : Form
    {
        private string connStr;

        public frm_QuanLyCanBo(string connStr)
        {
            InitializeComponent();
            this.connStr = connStr;
        }

        private void Form1_Load(object sender, EventArgs e)
        {

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
            frm_QuanLyGiangVien frm = new frm_QuanLyGiangVien(connStr);
            frm.ShowDialog();
        }

        private void btn_QLNganh_Click(object sender, EventArgs e)
        {
            frm_QuanLyNganh frm = new frm_QuanLyNganh(connStr);
            frm.ShowDialog();
        }

        private void btn_QLMonHoc_Click(object sender, EventArgs e)
        {
            frm_QuanLyMonHoc frm = new frm_QuanLyMonHoc(connStr);
            frm.ShowDialog();
        }

        private void btn_QLLopHocPhan_Click(object sender, EventArgs e)
        {
            frm_QuanLyLopHocPhan frm = new frm_QuanLyLopHocPhan(connStr);
            frm.ShowDialog();
        }

        private void btn_PhanCongGiangDay_Click(object sender, EventArgs e)
        {
            frm_PhanCongGiangDay frm = new frm_PhanCongGiangDay(connStr);  
            frm.ShowDialog();
        }

        private void btn_QLLuong_Click(object sender, EventArgs e)
        {
            frm_QuanLyLuong frm = new frm_QuanLyLuong(connStr);
            frm.ShowDialog();
        }

        private void btn_DangXuat_Click(object sender, EventArgs e)
        {

        }

        private void btn_HoSoCaNhan_Click(object sender, EventArgs e)
        {
            frm_HoSoCanBo frm = new frm_HoSoCanBo();
            frm.ShowDialog();
        }
    }
}
