using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class MovieListing : System.Web.UI.Page
{
    private string connString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"C:\\Users\\OM KADAM\\source\\repos\\omproject\\omproject\\App_Data\\Database.mdf\";Integrated Security=True";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindMovies();
        }
    }

    // Method to bind movie data to the GridView
    private void BindMovies()
    {
        string query = "SELECT MovieId, Title, Description, PosterUrl, Showtimes FROM Movies";

        using (SqlConnection conn = new SqlConnection(connString))
        {
            SqlDataAdapter da = new SqlDataAdapter(query, conn);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvMovies.DataSource = dt;
            gvMovies.DataBind();
        }
    }

    // Handle RowCommand for the GridView (Edit/Delete functionality)
    protected void gvMovies_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (!string.IsNullOrEmpty(e.CommandArgument.ToString()))
        {
            string movieId = e.CommandArgument.ToString(); // MovieId from CommandArgument

            if (e.CommandName == "EditMovie")
            {
                // Redirect to EditMovie.aspx with movieId
                Response.Redirect("EditMovie.aspx?movieId=" + movieId);
            }
            else if (e.CommandName == "DeleteMovie")
            {
                // Delete movie logic
                DeleteMovie(movieId);
            }
            else if (e.CommandName == "BookMovie")
            {
                // Redirect to booking page with movieId
                Response.Redirect("Booking.aspx?movieId=" + movieId);
            }
        }
        else
        {
            lblErrorMessage.Text = "Invalid movie selected.";
            lblErrorMessage.Visible = true;
        }
    }

    // Method to delete a movie
    private void DeleteMovie(string movieId)
    {
        string query = "DELETE FROM Movies WHERE MovieId = @MovieId";

        using (SqlConnection conn = new SqlConnection(connString))
        {
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@MovieId", movieId);

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                BindMovies(); // Refresh GridView after deletion
            }
            catch (Exception ex)
            {
                lblErrorMessage.Text = "Error deleting movie: " + ex.Message;
                lblErrorMessage.Visible = true;
            }
        }
    }

    // Method to handle adding a new movie
    protected void btnAddMovie_Click(object sender, EventArgs e)
    {
        string title = txtTitle.Text;
        string description = txtDescription.Text;
        string posterUrl = txtPosterUrl.Text;
        string showtimes = txtShowtimes.Text; // Add showtimes field

        string query = "INSERT INTO Movies (Title, Description, PosterUrl, Showtimes) VALUES (@Title, @Description, @PosterUrl, @Showtimes)";

        using (SqlConnection conn = new SqlConnection(connString))
        {
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Title", title);
            cmd.Parameters.AddWithValue("@Description", description);
            cmd.Parameters.AddWithValue("@PosterUrl", posterUrl);
            cmd.Parameters.AddWithValue("@Showtimes", showtimes); // Save showtimes

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                BindMovies(); // Refresh GridView after adding the new movie
            }
            catch (Exception ex)
            {
                lblErrorMessage.Text = "Error adding movie: " + ex.Message;
                lblErrorMessage.Visible = true;
            }
        }
    }
}
