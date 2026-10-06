using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;


    public partial class MyTickets : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userId"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else if (!IsPostBack)
            {
                LoadTickets();
            }
        }

        private void LoadTickets()
        {
            int userId = Convert.ToInt32(Session["userId"]);
            string connStr = ConfigurationManager.ConnectionStrings["YourConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT T.TicketId, M.Title, T.SeatNumber, T.BookingDate, T.Status 
                    FROM Tickets T
                    JOIN Movies M ON T.MovieId = M.MovieId
                    WHERE T.UserId = @UserId";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@userId", userId);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvTickets.DataSource = dt;
                    gvTickets.DataBind();
                }
            }
        }
    }

