using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace InternWebApplication
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadVideos();
                LoadLatestTagline();
            }
        }
        private void LoadVideos()
        {
            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["MyDBConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "SELECT id, content, type FROM Files WHERE type = 'Video' ORDER BY sort_order ASC";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);
                            string videoHtml = @"
<div class='video-player-container'>
    <video id='videoPlayer' class='video-player' controls autoplay muted>
        <source id='videoSource' type='video/mp4'>
        Your browser does not support the video tag.
    </video>
</div>";


                            string videoPaths = "[";
                            foreach (DataRow row in dt.Rows)
                            {
                                string videoPath = ResolveUrl("~/UploadedVideos/" + row["content"]);
                                videoPaths += $"'{videoPath}',";
                            }

                            videoPaths = videoPaths.TrimEnd(',') + "]";

                            videoContainer.Text = videoHtml;

                            string script = @"
                    <script>
                        var videoPaths = " + videoPaths + @";
                        var currentIndex = 0;

                        function changeVideo(index) {
                            currentIndex = index;
                            if (currentIndex >= videoPaths.length) {
                                currentIndex = 0; // Loop back to the first video
                            }

                            var videoPlayer = document.getElementById('videoPlayer');
                            var videoSource = document.getElementById('videoSource');
                            videoSource.src = videoPaths[currentIndex];
                            videoPlayer.load();
                            videoPlayer.play();
                        }

                        document.addEventListener('DOMContentLoaded', function() {
                            var videoPlayer = document.getElementById('videoPlayer');
                            changeVideo(0);

                            videoPlayer.addEventListener('ended', function() {
                                changeVideo(currentIndex + 1);
                            });
                        });
                    </script>";

                            Page.ClientScript.RegisterStartupScript(this.GetType(), "videoSliderScript", script, false);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                videoContainer.Text = "Error loading videos: " + ex.Message;
            }
        }

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