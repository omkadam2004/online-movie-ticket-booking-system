using System;
using System.Configuration;
using System.Data.SqlClient;

public partial class Contact : System.Web.UI.Page
{
    private string connStr = ConfigurationManager.ConnectionStrings["YourConnectionString"].ConnectionString;

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string name = txtName.Text.Trim();
        string email = txtEmail.Text.Trim();
        string subject = txtSubject.Text.Trim();
        string message = txtMessage.Text.Trim();

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "INSERT INTO ContactMessages (Name, Email, Subject, Message) VALUES (@Name, @Email, @Subject, @Message)";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Name", name);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@Subject", subject);
            cmd.Parameters.AddWithValue("@Message", message);

            conn.Open();
            cmd.ExecuteNonQuery();
        }

        lblMessage.Text = "Thank you! Your message has been sent.";
        txtName.Text = txtEmail.Text = txtSubject.Text = txtMessage.Text = ""; // Clear fields
    }
}
