using System;
using System.Configuration;
using System.Data.SqlClient;

public partial class PaymentSuccess : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        if (!IsPostBack)
        {
            int userId = Convert.ToInt32(Session["userId"]);
            int movieId;

            if (!int.TryParse(Request.QueryString["movieId"], out movieId))
            {
                Response.Redirect("Movies.aspx"); // Redirect if movieId is missing or invalid
            }

            string seats = Request.QueryString["seats"] ?? "N/A";
            lblSeats.Text = seats;

            LoadBookingDetails(userId, movieId);
        }
    }

    private void LoadBookingDetails(int userId, int movieId)
    {
        string connStr = ConfigurationManager.ConnectionStrings["YourConnectionString"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = @"
                SELECT m.Title, p.UTR, p.TotalAmount 
                FROM Movies m
                JOIN Payments p ON m.MovieId = p.MovieId AND p.UserId = @UserId
                WHERE m.MovieId = @MovieId";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@UserId", userId);
            cmd.Parameters.AddWithValue("@MovieId", movieId);

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                lblMovieName.Text = reader["Title"].ToString();
                lblTransactionID.Text = reader["UTR"].ToString();
                lblTotalPrice.Text = "Rs " + reader["TotalAmount"].ToString();
            }
            else
            {
                lblMovieName.Text = "N/A";
                lblTransactionID.Text = "N/A";
                lblTotalPrice.Text = "N/A";
            }
        }
    }

    protected void btnHome_Click(object sender, EventArgs e)
    {
        Response.Redirect("Movies.aspx");
    }
}
