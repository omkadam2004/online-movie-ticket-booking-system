using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

public partial class Payment : System.Web.UI.Page
{
    private const int TicketPrice = 100; // Price per seat

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["userId"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            if (Request.QueryString["movieId"] == null || string.IsNullOrEmpty(Request.QueryString["seats"]))
            {
                Response.Redirect("Movies.aspx");
            }

            int userId = Convert.ToInt32(Session["userId"]);
            int movieId = Convert.ToInt32(Request.QueryString["movieId"]);
            string selectedSeats = Request.QueryString["seats"];

            lblSelectedSeats.Text = "Seats: " + selectedSeats;
            lblTotalPrice.Text = "Total Price: Rs" + (selectedSeats.Split(',').Length * TicketPrice);

            LoadPaymentDetails(movieId, userId);
        }
    }

    private void LoadPaymentDetails(int movieId, int userId)
    {
        lblUserId.Text = "User ID: " + userId;
        string connStr = ConfigurationManager.ConnectionStrings["YourConnectionString"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "SELECT Title, Showtimes FROM Movies WHERE MovieId = @MovieId";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@MovieId", movieId);

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                lblMovieTitle.Text = "Movie: " + reader["Title"].ToString();
                lblShowtime.Text = "Showtime: " + reader["Showtimes"].ToString();
            }
        }
    }

    protected void btnSubmitPayment_Click(object sender, EventArgs e)
    {
        if (Session["userId"] == null || Request.QueryString["movieId"] == null || string.IsNullOrWhiteSpace(Request.QueryString["seats"]))
        {
            Response.Redirect("Movies.aspx");
        }

        int userId = Convert.ToInt32(Session["userId"]);
        int movieId = Convert.ToInt32(Request.QueryString["movieId"]);
        string selectedSeats = Request.QueryString["seats"].Trim();
        string utr = txtUTR.Text.Trim();

        if (string.IsNullOrEmpty(utr))
        {
            Response.Write("<script>alert('Please enter a valid UTR number.');</script>");
            return;
        }

        string connStr = ConfigurationManager.ConnectionStrings["YourConnectionString"].ConnectionString;
        int totalPrice = selectedSeats.Split(',').Length * TicketPrice;

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            // **Check if UTR already exists**
            string checkUTRQuery = "SELECT COUNT(*) FROM Payments WHERE UTR = @UTR";
            SqlCommand checkUTRCmd = new SqlCommand(checkUTRQuery, conn);
            checkUTRCmd.Parameters.AddWithValue("@UTR", utr);
            int count = (int)checkUTRCmd.ExecuteScalar();

            if (count > 0)
            {
                Response.Write("<script>alert('This UTR is already used. Please use a different UTR.');</script>");
                return;
            }

            // **Insert payment**
            string paymentQuery = "INSERT INTO Payments (UserId, MovieId, UTR, TotalAmount, PaymentDate) VALUES (@UserId, @MovieId, @UTR, @TotalAmount, GETDATE());";
            SqlCommand paymentCmd = new SqlCommand(paymentQuery, conn);
            paymentCmd.Parameters.AddWithValue("@UserId", userId);
            paymentCmd.Parameters.AddWithValue("@MovieId", movieId);
            paymentCmd.Parameters.AddWithValue("@UTR", utr);
            paymentCmd.Parameters.AddWithValue("@TotalAmount", totalPrice);

            int paymentResult = paymentCmd.ExecuteNonQuery();

            if (paymentResult > 0)
            {
                // **Insert bookings**
                string[] seats = selectedSeats.Split(',');
                foreach (string seat in seats)
                {
                    string bookingQuery = "INSERT INTO Bookings (UserId, MovieId, SeatNumber, BookingDate) VALUES (@UserId, @MovieId, @Seat, GETDATE());";
                    SqlCommand bookingCmd = new SqlCommand(bookingQuery, conn);
                    bookingCmd.Parameters.AddWithValue("@UserId", userId);
                    bookingCmd.Parameters.AddWithValue("@MovieId", movieId);
                    bookingCmd.Parameters.AddWithValue("@Seat", seat.Trim());
                    bookingCmd.ExecuteNonQuery();
                }

                // **Redirect to success page**
                Response.Redirect($"PaymentSuccess.aspx?movieId={movieId}&seats={selectedSeats}&price={totalPrice}");
            }
            else
            {
                Response.Write("<script>alert('Payment failed. Please try again.');</script>");
            }
        }
    }
}
