using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class UHistory : System.Web.UI.Page
{
    private string connString = ConfigurationManager.ConnectionStrings["YourConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
        {
            Response.Redirect("Login.aspx"); // Ensure user is logged in
        }

        if (!IsPostBack)
        {
            LoadBookings();
        }
    }

    private void LoadBookings()
    {
        int userId = Convert.ToInt32(Session["userId"]);
        string query = @"SELECT b.BookingId, m.Title, b.SeatNumber, b.BookingDate, b.Status
                         FROM Bookings b
                         JOIN Movies m ON b.MovieId = m.MovieId
                         WHERE b.UserId = @UserId
                         ORDER BY b.BookingDate DESC";

        using (SqlConnection conn = new SqlConnection(connString))
        {
            SqlDataAdapter da = new SqlDataAdapter(query, conn);
            da.SelectCommand.Parameters.AddWithValue("@UserId", userId);

            DataTable dt = new DataTable();
            da.Fill(dt);

            gvBookings.DataSource = dt;
            gvBookings.DataBind();
        }
    }
}
