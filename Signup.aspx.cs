using System;
using System.Configuration;
using System.Data.SqlClient;

namespace InternWebApplication
{
    public partial class Signup : System.Web.UI.Page
    {
        protected void SignupButton_Click(object sender, EventArgs e)
        {
            string username = Username.Text.Trim();
            string password = Password.Text.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                ErrorMessage.Text = "Username and Password are required.";
                ErrorMessage.Visible = true;
                return;
            }

            string connectionString = ConfigurationManager.ConnectionStrings["MyDBConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string checkQuery = "SELECT COUNT(*) FROM tbl_admins WHERE admin_username = @Username";
                string insertQuery = "INSERT INTO tbl_admins (admin_username, admin_password) VALUES (@Username, @Password)";

                using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("@Username", username);

                    try
                    {
                        conn.Open();

                        int userExists = (int)checkCmd.ExecuteScalar();

                        if (userExists > 0)
                        {
                            ErrorMessage.Text = "Username is already taken. Please choose another.";
                            ErrorMessage.Visible = true;
                            return;
                        }

                        // Insert new user
                        using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                        {
                            insertCmd.Parameters.AddWithValue("@Username", username);
                            insertCmd.Parameters.AddWithValue("@Password", BCrypt.Net.BCrypt.HashPassword(password));

                            int rowsAffected = insertCmd.ExecuteNonQuery();

                            if (rowsAffected > 0)
                            {
                                ErrorMessage.Text = "Account created successfully! You can now log in.";
                                ErrorMessage.Visible = true;

                                // Clear fields
                                Username.Text = string.Empty;
                                Password.Text = string.Empty;
                            }
                            else
                            {
                                ErrorMessage.Text = "An error occurred. Please try again.";
                                ErrorMessage.Visible = true;
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        // Log error details for troubleshooting
                        System.Diagnostics.Trace.WriteLine($"Error during signup: {ex.Message}");

                        ErrorMessage.Text = "An error occurred. Please try again.";
                        ErrorMessage.Visible = true;
                    }
                }
            }
        }
    }
}
