using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Movies : System.Web.UI.Page
{
    private string connString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"C:\\Users\\OM KADAM\\source\\repos\\omproject\\omproject\\App_Data\\Database.mdf\";Integrated Security=True";

    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (Session["userId"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        if (!IsPostBack)
        {
            LoadMovies();
        }
    }

    private void LoadMovies()
    {
        string query = "SELECT MovieId, Title, Description, PosterUrl,Showtimes FROM Movies";

        using (SqlConnection conn = new SqlConnection(connString))
        {
            SqlDataAdapter da = new SqlDataAdapter(query, conn);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptMovies.DataSource = dt;
            rptMovies.DataBind();
        }
    }
}
