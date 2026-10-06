using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class AdminMessage : System.Web.UI.Page
{
    private string connStr = ConfigurationManager.ConnectionStrings["YourConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadMessages();
        }
    }

    private void LoadMessages()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "SELECT Id, Name, Email, Subject, Message, SubmittedDate FROM ContactMessages ORDER BY SubmittedDate DESC";
            SqlDataAdapter da = new SqlDataAdapter(query, conn);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvMessages.DataSource = dt;
            gvMessages.DataBind();
        }
    }
}
