using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class AllTickets : System.Web.UI.Page
{
    private string connStr = ConfigurationManager.ConnectionStrings["YourConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadTickets();
        }
    }

    private void LoadTickets()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = @"SELECT t.TicketId, u.Email AS UserEmail, m.Title AS MovieTitle, 
                                    t.SeatNumber, t.BookingDate, t.Status 
                             FROM Tickets t
                             JOIN Users u ON t.UserId = u.UserId
                             JOIN Movies m ON t.MovieId = m.MovieId";

            SqlCommand cmd = new SqlCommand(query, conn);
            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            gvTickets.DataSource = reader;
            gvTickets.DataBind();
        }
    }

    protected void Timer1_Tick(object sender, EventArgs e)
    {
        LoadTickets(); // Auto-refresh GridView
    }
}
