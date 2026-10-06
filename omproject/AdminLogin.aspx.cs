using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminLogin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
protected void btnLogin_Click(object sender, EventArgs e)
    {
    string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Hardcoded admin credentials
            const string adminUser = "admin";
            const string adminPass = "admin123";

            if (username == adminUser && password == adminPass)
            {
                // Store session for authentication
                Session["AdminLoggedIn"] = true;
                Response.Redirect("MovieListing.aspx");
             }
            else
            {
                lblError.Text = "Invalid username or password.";
            }
        }
    }
