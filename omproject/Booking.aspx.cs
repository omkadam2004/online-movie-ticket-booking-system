using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Configuration;

public partial class Booking : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userId"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        if (!IsPostBack)
        {
            if (Request.QueryString["movieId"] != null)
            {
                int movieId = Convert.ToInt32(Request.QueryString["movieId"]);
                int userId = Convert.ToInt32(Session["userId"]); // Get userId from session

                Session["movieId"] = movieId; // Store movie ID in session
                LoadMovieDetails(movieId);
                GenerateSeatSelection();
            }
            else
            {
                Response.Redirect("Movies.aspx");
            }
        }
    }

    private void LoadMovieDetails(int movieId)
    {
        string connStr = ConfigurationManager.ConnectionStrings["YourConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "SELECT Title, Showtimes, PosterUrl FROM Movies WHERE MovieId = @MovieId";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@MovieId", movieId);
            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                lblTitle.Text = reader["Title"].ToString();
                lblShowtime.Text = "Showtime: " + reader["Showtimes"].ToString();
                imgMovie.ImageUrl = reader["PosterUrl"].ToString();
            }
        }
    }

    private void GenerateSeatSelection()
    {
        int movieId = Convert.ToInt32(Session["movieId"]);
        string connStr = ConfigurationManager.ConnectionStrings["YourConnectionString"].ConnectionString;
        string seatHtml = "";

        HashSet<string> bookedSeats = new HashSet<string>();

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "SELECT SeatNumber FROM Bookings WHERE MovieId = @MovieId";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@MovieId", movieId);

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                bookedSeats.Add(reader["SeatNumber"].ToString());
            }
        }

        for (int i = 1; i <= 42; i++)
        {
            string seatClass = bookedSeats.Contains(i.ToString()) ? "seat booked" : "seat available";
            string clickEvent = bookedSeats.Contains(i.ToString()) ? "" : "onclick='toggleSeat(this)'";

            seatHtml += $"<div class='{seatClass}' {clickEvent} id='seat-{i}'>{i}</div>";
        }

        ltlSeats.Text = seatHtml;
    }

    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        if (Session["userId"] != null && Session["movieId"] != null)
        {
            int userId = Convert.ToInt32(Session["userId"]);
            int movieId = Convert.ToInt32(Session["movieId"]);
            string selectedSeats = hdnSelectedSeats.Value;

            string connStr = ConfigurationManager.ConnectionStrings["YourConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string[] seats = selectedSeats.Split(',');
                foreach (string seat in seats)
                {
                    string query = "INSERT INTO Bookings (UserId, MovieId, SeatNumber) VALUES (@UserId, @MovieId, @SeatNumber)";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.Parameters.AddWithValue("@MovieId", movieId);
                    cmd.Parameters.AddWithValue("@SeatNumber", seat);
                    cmd.ExecuteNonQuery();
                }
            }

            Response.Redirect($"Payment.aspx?movieId={movieId}&userId={userId}&seats={selectedSeats}");
        }
        else
        {
            Response.Redirect("Login.aspx");
        }
    }
}
