using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;

namespace InternWebApplication
{
    public partial class RearrangeContent : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadContent();
                LoadVideos();
                LoadLatestTagline();

            }

            // If the order is passed in the query string, save it
            if (Request.QueryString["order"] != null)
            {
                SaveNewOrder(Request.QueryString["order"]);
            }
        }
       
     
        private void LoadContent()
        {
            List<ContentItem> contentList = new List<ContentItem>();
            string connStr = ConfigurationManager.ConnectionStrings["MyDBConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "SELECT id, content, sort_order FROM Files ORDER BY sort_order";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            while (reader.Read())
                            {
                                contentList.Add(new ContentItem
                                {
                                    Id = reader.GetInt32(0),
                                    Content = reader.GetString(1),
                                    SortOrder = reader.IsDBNull(2) ? 0 : reader.GetInt32(2) // Handle NULL values
                                });
                            }
                        }
                        else
                        {
                            // If no data, handle it gracefully
                            contentListHtml.Text = "<li>No content found.</li>";
                            return; // Exit the method early
                        }
                    }
                }

                // Dynamically generate HTML for the content list
                string contentHtml = string.Empty;
                foreach (var item in contentList)
                {
                    contentHtml += $"<li class='content-item'>" +
                                   $"<input type='radio' name='contentOrder' value='{item.Id}' onchange='updateOrder({item.Id}, {item.SortOrder})'/>" +
                                   $"{item.Content}</li>";
                }

                // Set the generated HTML to the Literal control
                contentListHtml.Text = contentHtml;
            }
            catch (Exception ex)
            {
                // Log or handle the exception accordingly
                Response.Write("<script>alert('Error occurred while loading content: " + ex.Message + "');</script>");
            }
        }


        private void SaveNewOrder(string order)
        {
            string[] ids = order.Split(',');
            string connStr = ConfigurationManager.ConnectionStrings["MyDBConnectionString"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlTransaction transaction = conn.BeginTransaction();

                    try
                    {
                        for (int i = 0; i < ids.Length; i++)
                        {
                            int id = Convert.ToInt32(ids[i]);
                            string updateQuery = "UPDATE Files SET sort_order = @SortOrder WHERE id = @Id";
                            SqlCommand cmd = new SqlCommand(updateQuery, conn, transaction);
                            cmd.Parameters.AddWithValue("@SortOrder", i + 1);
                            cmd.Parameters.AddWithValue("@Id", id);
                            cmd.ExecuteNonQuery();
                        }

                        transaction.Commit();
                        Response.Redirect("RearrangeContent.aspx"); // Refresh the page
                    }
                    catch 
                    {
                      
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle any connection-related errors
                Response.Write($"<script>alert('Database connection error: {ex.Message}');</script>");
            }
        }
        private void LoadVideos()
        {
            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["MyDBConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "SELECT id, content, type FROM Files WHERE type = 'Video' ORDER BY sort_order ASC"; // Sort in increasing order
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);

                            // Prepare the HTML for displaying videos in a container with scrolling functionality
                            string videoHtml = "<div class='video-slider-container'>" +
                                               "<button class='slider-btn left' onclick='scrollVideos(-1)'>◄</button>" +
                                               "<div class='video-slider'>";

                            foreach (DataRow row in dt.Rows)
                            {
                                string videoPath = Server.MapPath("~/UploadedVideos/") + row["content"];
                                videoHtml += $"<div class='w3-card-4 w3-margin-bottom video-item w3-padding w3-white'>" +
                                             $"<h4>{row["content"]}</h4>" +
                                             $"<video width='320' height='240' controls autoplay muted>" + // Add muted here
                                             $"<source src='{ResolveUrl("~/UploadedVideos/" + row["content"])}' type='video/mp4'>" +
                                             "Your browser does not support the video tag." +
                                             "</video>" +
                                             "</div>";
                            }

                            videoHtml += "</div>" +
                                         "<button class='slider-btn right' onclick='scrollVideos(1)'>►</button>" +
                                         "</div>";

                            // Set the generated HTML to the Literal control
                            videoContainer.Text = videoHtml;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle errors (e.g., database connection failure)
                videoContainer.Text = "Error loading videos: " + ex.Message;
            }
        }



        private class ContentItem
        {
            public int Id { get; set; }
            public string Content { get; set; }
            public int SortOrder { get; set; }
        }
        // Submit Button Click - Save the tagline and settings
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string tagline = txtLargeInput.Text;
            string font = ddlFont.SelectedValue;
            string bgColor = ddlBackgroundColor.SelectedValue;
            int speed = int.Parse(txtSpeed.Text);

            string connStr = ConfigurationManager.ConnectionStrings["MyDBConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
    
            {
                string query = "INSERT INTO Tagline (TaglineText, Font, BackgroundColor, Speed) " +
                               "VALUES (@TaglineText, @Font, @BackgroundColor, @Speed)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@TaglineText", tagline);
                cmd.Parameters.AddWithValue("@Font", font);
                cmd.Parameters.AddWithValue("@BackgroundColor", bgColor);
                cmd.Parameters.AddWithValue("@Speed", speed);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                lblMessage.Text = "Tagline saved successfully!";
                LoadLatestTagline();  // Refresh the preview after saving
            }
        }

        // Load the latest saved tagline from the database and update the preview
        private void LoadLatestTagline()
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDBConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT TOP 1 * FROM Tagline ORDER BY CreatedAt DESC";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    // Display the latest tagline with selected styling options
                    lblPreview.Text = reader["TaglineText"].ToString();
                    lblPreview.Font.Name = reader["Font"].ToString();
                    lblPreview.BackColor = System.Drawing.Color.FromName(reader["BackgroundColor"].ToString());
                    lblPreview.ForeColor = System.Drawing.Color.Black;

                    // Apply speed for animation duration
                    int speed = Convert.ToInt32(reader["Speed"]);
                    lblPreview.Style["animation-duration"] = speed.ToString() + "ms";

                }

                conn.Close();
            }
        }

    }
}
