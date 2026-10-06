using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    private string connString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"C:\\Users\\OM KADAM\\source\\repos\\omproject\\omproject\\App_Data\\Database.mdf\";Integrated Security=True";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindMovies();
        }
    }

    // Method to bind movie data to the Repeater
    private void BindMovies()
    {
        // SQL query to fetch movie details
        string query = "SELECT MovieId, Title, Description, PosterUrl FROM Movies";

        // Create a connection and command to execute the query
        using (SqlConnection conn = new SqlConnection(connString))
        {
            SqlDataAdapter da = new SqlDataAdapter(query, conn);
            DataTable dt = new DataTable();

            // Fill the DataTable with movie data
            da.Fill(dt);

            // Bind the data to the Repeater control
            rptMovies.DataSource = dt;
            rptMovies.DataBind();
        }
    }
}
