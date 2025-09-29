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
            connectionString = $"Data Source=.;Initial Catalog=QLCanBoGiangVien;" +
                         $"User ID={username};Password={password};" +
                         "Encrypt=True;TrustServerCertificate=True;";
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
    }
}
