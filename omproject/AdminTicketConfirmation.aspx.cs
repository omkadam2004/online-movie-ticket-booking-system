using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class AdminTicketConfirmation : System.Web.UI.Page
{
    private string connStr = ConfigurationManager.ConnectionStrings["YourConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadPendingBookings();
        }
    }

    private void LoadPendingBookings()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "SELECT b.BookingId, u.Email AS UserEmail, m.Title AS MovieTitle, b.SeatNumber " +
                           "FROM Bookings b " +
                           "JOIN Users u ON b.UserId = u.UserId " +
                           "JOIN Movies m ON b.MovieId = m.MovieId " +
                           "WHERE b.Status = 'Pending'";

            SqlCommand cmd = new SqlCommand(query, conn);
            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            gvBookings.DataSource = reader;
            gvBookings.DataBind();
        }
    }

    // Timer event to auto-refresh GridView every 1 seconds
    protected void Timer1_Tick(object sender, EventArgs e)
    {
        LoadPendingBookings(); // Refresh GridView without full page reload
    }

    protected void gvBookings_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandArgument != null)
        {
            int bookingId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "ConfirmTicket")
            {
                ConfirmTicket(bookingId);
            }
            else if (e.CommandName == "RejectTicket")
            {
                RejectTicket(bookingId);
            }
        }
    }

    private void ConfirmTicket(int bookingId)
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();
            SqlTransaction transaction = conn.BeginTransaction();

            try
            {
                string getDetailsQuery = "SELECT UserId, MovieId, SeatNumber FROM Bookings WHERE BookingId = @BookingId";
                SqlCommand getDetailsCmd = new SqlCommand(getDetailsQuery, conn, transaction);
                getDetailsCmd.Parameters.AddWithValue("@BookingId", bookingId);
                SqlDataReader reader = getDetailsCmd.ExecuteReader();

                if (reader.Read())
                {
                    int userId = Convert.ToInt32(reader["UserId"]);
                    int movieId = Convert.ToInt32(reader["MovieId"]);
                    string seatNumber = reader["SeatNumber"].ToString();
                    reader.Close();

                    string insertQuery = "INSERT INTO Tickets (UserId, MovieId, SeatNumber, BookingId, BookingDate, Status) " +
                                         "VALUES (@UserId, @MovieId, @SeatNumber, @BookingId, GETDATE(), 'Confirmed')";
                    SqlCommand insertCmd = new SqlCommand(insertQuery, conn, transaction);
                    insertCmd.Parameters.AddWithValue("@UserId", userId);
                    insertCmd.Parameters.AddWithValue("@MovieId", movieId);
                    insertCmd.Parameters.AddWithValue("@SeatNumber", seatNumber);
                    insertCmd.Parameters.AddWithValue("@BookingId", bookingId);
                    insertCmd.ExecuteNonQuery();

                    string updateBookingQuery = "UPDATE Bookings SET Status = 'Confirmed' WHERE BookingId = @BookingId";
                    SqlCommand updateCmd = new SqlCommand(updateBookingQuery, conn, transaction);
                    updateCmd.Parameters.AddWithValue("@BookingId", bookingId);
                    updateCmd.ExecuteNonQuery();

                    transaction.Commit();
                    Response.Write("<script>alert('Ticket confirmed successfully!');</script>");
                }
                else
                {
                    reader.Close();
                    Response.Write("<script>alert('Booking not found!');</script>");
                }
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                Response.Write("<script>alert('Error confirming ticket: " + ex.Message + "');</script>");
            }
        }

        LoadPendingBookings(); // Refresh GridView
    }

    private void RejectTicket(int bookingId)
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string updateQuery = "UPDATE Bookings SET Status = 'Rejected' WHERE BookingId = @BookingId";

            SqlCommand cmd = new SqlCommand(updateQuery, conn);
            cmd.Parameters.AddWithValue("@BookingId", bookingId);

            conn.Open();
            int rowsAffected = cmd.ExecuteNonQuery();

            if (rowsAffected > 0)
            {
                Response.Write("<script>alert('Booking rejected successfully!');</script>");
            }
            else
            {
                Response.Write("<script>alert('Error: Booking not found!');</script>");
            }

            LoadPendingBookings(); // Refresh GridView
        }
    }
}
