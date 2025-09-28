using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer
{
    public class DataAccess
    {
        SqlConnection conn = null;
        SqlCommand cmd = null;
        SqlDataAdapter da = null;

        private static string connectionString = "Data Source=.;Initial Catalog=QLCanBoGiangVien;Integrated Security=True;";

        public DataAccess(string connStr)
        {
            //connectionString = connStr;
            conn = new SqlConnection(connectionString);
            cmd = conn.CreateCommand();
        }

        public static void SetConnection(string username, string password)
        {
            //connectionString = $"Data Source=.;Initial Catalog=QLCanBoGiangVien;" +
            //             $"User ID={username};Password={password};" +
            //             "Encrypt=True;TrustServerCertificate=True;";
        }

        public DataTable ExecuteQuery(string spName, params SqlParameter[] parameters)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(spName, conn);
                cmd.CommandType = CommandType.StoredProcedure;
                if (parameters != null) cmd.Parameters.AddRange(parameters);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        public int ExecuteNonQuery(string spName, params SqlParameter[] parameters)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(spName, conn);
                cmd.CommandType = CommandType.StoredProcedure;
                if (parameters != null) cmd.Parameters.AddRange(parameters);
                return cmd.ExecuteNonQuery();
            }
        }


        public DataTable ExecuteQueryText(string query, params SqlParameter[] parameters)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.CommandType = CommandType.Text;
                if (parameters != null) cmd.Parameters.AddRange(parameters);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }


        //public DataSet ExecuteQueryDataSet(string strSql, CommandType ct) // SELECT / EXEC SP không tham số -> trả về DataSet
        //{
        //    if (conn.State == ConnectionState.Open)
        //    {
        //        conn.Close();
        //    }
        //    try
        //    {
        //        conn.Open();
        //        cmd.CommandText = strSql;
        //        cmd.CommandType = ct;
        //        cmd.Parameters.Clear(); // xóa tham số cũ
        //        da = new SqlDataAdapter(cmd);
        //        DataSet ds = new DataSet();
        //        da.Fill(ds);
        //        return ds;
        //    }
        //    finally { conn.Close(); }

        //}

        //public DataSet ExecuteDataSetParam(string strSql, CommandType ct, params SqlParameter[] param) //// SELECT / EXEC SP có tham số -> trả DataSet
        //{
        //    if (conn.State == ConnectionState.Open)
        //    {
        //        conn.Close();
        //    }
        //    try
        //    {
        //        conn.Open();
        //        cmd.CommandText = strSql;
        //        cmd.CommandType = ct;
        //        cmd.Parameters.Clear(); // xóa tham số cũ

        //        foreach (SqlParameter p in param)
        //        {
        //            cmd.Parameters.Add(p);
        //        }
        //        da = new SqlDataAdapter(cmd);
        //        DataSet ds = new DataSet();
        //        da.Fill(ds);
        //        return ds;
        //    }
        //    finally { conn.Close(); }
        //}

        //// Thực thi lệnh không trả dữ liệu (Thêm/sửa/xóa). Nếu thành công trả về true, ngược lại false và gán error
        //public bool ExecuteNonQuery(string strSql, CommandType ct, ref string error, params SqlParameter[] param)
        //{
        //    bool f = false;
        //    if (conn.State == ConnectionState.Open)
        //    {
        //        conn.Close();
        //    }
        //    conn.Open();
        //    cmd.Parameters.Clear();
        //    cmd.CommandText = strSql;
        //    cmd.CommandType = ct;
        //    foreach (SqlParameter p in param)
        //    {
        //        cmd.Parameters.Add(p);
        //    }
        //    try
        //    {
        //        cmd.ExecuteNonQuery();
        //        f = true;
        //    }
        //    catch (Exception ex)
        //    {
        //        error = ex.Message;
        //    }
        //    finally
        //    {
        //        conn.Close();
        //    }
        //    return f;
        //}

        //public int ExecuteScalarFunction(string strSql) // chạy lệnh trả về một giá trị (ô đầu tiên hàng đầu tiên) và ép về int.
        //{
        //    if (conn.State == ConnectionState.Open)
        //    {
        //        conn.Close();
        //    }
        //    conn.Open();
        //    try
        //    {
        //        cmd.Parameters.Clear();
        //        cmd.CommandText = strSql;
        //        cmd.CommandType = CommandType.Text;

        //        int result = 0;

        //        int? count = cmd.ExecuteScalar() as int?;
        //        if (count != null)
        //        {
        //            result = count.Value;
        //        }
        //        return result;
        //    }
        //    finally { conn.Close(); }
        //}
    }
}
