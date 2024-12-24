using System;
using System.Web;

namespace InternWebApplication
{
    public partial class Settings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the user is logged in by verifying the session
            if (Session["username"] == null)
            {
                // Redirect to the login page if the user is not logged in
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                // Load current user data if the user is logged in
                LoadUserSettings();
            }
        }

        private void LoadUserSettings()
        {
            // Fetch user data (this would typically come from the database)
            string currentUsername = Session["admin_username"]?.ToString(); // Get the logged-in username from the session

            // Populate the form fields
            Username.Text = currentUsername;
   
        }

        protected void SaveChangesButton_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    // Get updated values from the input fields
                    string newUsername = Username.Text.Trim();
                    string newPassword = Password.Text.Trim();
                   

                    // Update user settings in the database (replace with your database logic)
                    UpdateUserSettings(newUsername, newPassword);

                    // Update session username if username was changed
                    Session["username"] = newUsername;
                    Response.Redirect("WebForm1.aspx");

                    // Show success message
                    ErrorMessage.Visible = true;
                    ErrorMessage.Text = "Settings updated successfully!";
                    ErrorMessage.ForeColor = System.Drawing.Color.Green;

                }
                catch (Exception)
                {
                    // Show error message
                    ErrorMessage.Visible = true;
                    ErrorMessage.Text = "An error occurred while updating your settings. Please try again.";
                    ErrorMessage.ForeColor = System.Drawing.Color.Red;
                }
            }

        }

        private void UpdateUserSettings(string newUsername, string newPassword)
        {
            // Replace with your actual database update logic
            // Example: UPDATE Users SET Username = ..., Email = ..., Password = ... WHERE UserId = ...

            Console.WriteLine($"Updated Settings: {newUsername}, {newPassword}");
        }
    }
}
