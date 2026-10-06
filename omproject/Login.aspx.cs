using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string username = txtUsername.Text;
        string password = txtPassword.Text;

        // Hash the entered password before checking it with the database
        string passwordHash = HashPassword(password);

        // Database connection string
        string connString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"C:\\Users\\OM KADAM\\source\\repos\\omproject\\omproject\\App_Data\\Database.mdf\";Integrated Security=True";

        using (SqlConnection conn = new SqlConnection(connString))
        {
            conn.Open();

            string query = "SELECT UserId, PasswordHash FROM Users WHERE Username = @Username";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Username", username);

            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                int userId = Convert.ToInt32(reader["UserId"]);
                string storedPasswordHash = reader["PasswordHash"].ToString();

                if (storedPasswordHash == passwordHash)
                {
                    // Store userId in session
                    Session["userId"] = userId;

                    // Redirect to MyTickets.aspx
                    Response.Redirect("MyTickets.aspx");
                }
                else
                {
                    lblError.Text = "Invalid username or password.";
                }
            }
            else
            {
                lblError.Text = "Invalid username or password.";
            }
        }
    }


    // Function to hash password using SHA256
    private string HashPassword(string password)
    {
        using (SHA256 sha256 = SHA256.Create())
        {
            byte[] hashBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
            return Convert.ToBase64String(hashBytes);
        }
    }
}
