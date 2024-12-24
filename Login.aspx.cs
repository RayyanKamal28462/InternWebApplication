using System;
using System.Configuration;
using System.Data.SqlClient;

namespace InternWebApplication
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is already logged in
            if (Session["username"] != null)
            {
                Response.Redirect("WebForm1.aspx"); // Redirect if logged in
            }

            // Check if username cookie exists for "Remember Me"
            if (!IsPostBack && Request.Cookies["username"] != null)
            {
                Username.Text = Request.Cookies["username"].Value;
                RememberMe.Checked = true;
            }
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            string username = Username.Text.Trim();
            string password = Password.Text.Trim();

            if (ValidateUser(username, password))
            {
                // Store username in session
                Session["username"] = username;

                // Handle "Remember Me"
                if (RememberMe.Checked)
                {
                    Response.Cookies["username"].Value = username;
                    Response.Cookies["username"].Expires = DateTime.Now.AddDays(1);
                }
                else
                {
                    // Clear cookie if not checked
                    if (Request.Cookies["username"] != null)
                    {
                        Response.Cookies["username"].Expires = DateTime.Now.AddDays(-1);
                    }
                }

                // Redirect to the main page after successful login
                Response.Redirect("WebForm1.aspx");
            }
            else
            {
                ErrorMessage.Text = "Invalid username or password.";
                ErrorMessage.Visible = true;
            }
        }

        private bool ValidateUser(string username, string password)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyDBConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT admin_password FROM tbl_admins WHERE admin_username = @Username";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", username);

                    try
                    {
                        conn.Open();
                        object result = cmd.ExecuteScalar();

                        if (result != null)
                        {
                            string storedPasswordHash = result.ToString();
                            // Verify password using BCrypt
                            return BCrypt.Net.BCrypt.Verify(password, storedPasswordHash);
                        }
                    }
                    catch (Exception ex)
                    {
                        // Log error details for debugging
                        System.Diagnostics.Trace.WriteLine($"Error during login: {ex.Message}");

                        ErrorMessage.Text = "An error occurred. Please try again.";
                        ErrorMessage.Visible = true;
                    }
                }
            }

            return false;
        }
    }
}
