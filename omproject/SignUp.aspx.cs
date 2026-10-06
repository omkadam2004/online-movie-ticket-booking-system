using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Web.UI;
using System.Data.SqlClient;

using System.Web.UI.WebControls;
using System.Security.Cryptography;

public partial class SignUp : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSignUp_Click(object sender, EventArgs e)
    {
            string username = txtUsername.Text;
            string email = txtEmail.Text;
            string password = txtPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;

            if (password != confirmPassword)
            {
                // Passwords do not match
                Response.Write("Passwords do not match!");
                return;
            }

            // Hash the password before storing it in the database
            string passwordHash = HashPassword(password);

            // Database connection string
            string connString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"C:\\Users\\OM KADAM\\source\\repos\\omproject\\omproject\\App_Data\\Database.mdf\";Integrated Security=True";  // Update with your actual connection string

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                string query = "INSERT INTO Users (Username, PasswordHash, Email) VALUES (@Username, @PasswordHash, @Email)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@PasswordHash", passwordHash);
                cmd.Parameters.AddWithValue("@Email", email);

                try
                {
                    cmd.ExecuteNonQuery();
                lblError1.Text = "Successfully SignUp."; 
            }
                catch (Exception ex)
                {
                // Handle exception (like username already exists)
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
