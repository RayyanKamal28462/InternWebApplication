using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.Script.Serialization;

namespace InternWebApplication
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadLatestTagline();
                LoadVideos();
                LoadPrayer();
                lblPrayerTimes.Text = "Please wait for the location to be detected...";
                Prayer();

            }
        }

         protected async void Prayer()
            {
                // Check if latitude and longitude are passed as query parameters
                string latitudeStr = Request.QueryString["latitude"];
                string longitudeStr = Request.QueryString["longitude"];

                if (!string.IsNullOrEmpty(latitudeStr) && !string.IsNullOrEmpty(longitudeStr))
                {
                    if (double.TryParse(latitudeStr, out double latitude) && double.TryParse(longitudeStr, out double longitude))
                    {
                        string prayerTimesHtml = await GetPrayerTimesHtml(latitude, longitude);
                        Response.Clear();
                        Response.Write(prayerTimesHtml);
                        Response.End();
                    }
                }
            }

            private async Task<string> GetPrayerTimesHtml(double latitude, double longitude)
            {
                string apiUrl = $"https://mpt.i906.my/api/prayer/{latitude},{longitude}";
                var prayerData = await GetPrayerData(apiUrl);

                if (prayerData != null)
                {
                    DateTime today = DateTime.UtcNow.Date;
                    var todayPrayerTimes = prayerData.GetPrayerTimesForDate(today);

                    if (todayPrayerTimes != null)
                    {
                        return $"Fajr: {todayPrayerTimes[0]}<br>" +
                               $"Sunrise: {todayPrayerTimes[1]}<br>" +
                               $"Dhuhr: {todayPrayerTimes[2]}<br>" +
                               $"Asr: {todayPrayerTimes[3]}<br>" +
                               $"Maghrib: {todayPrayerTimes[4]}<br>" +
                               $"Isha: {todayPrayerTimes[5]}";
                    }
                    else
                    {
                        return "No prayer times available for today.";
                    }
                }

                return "Unable to fetch prayer times. Please try again later.";
            }

            private async Task<PrayerApiResponse> GetPrayerData(string url)
            {
                using (HttpClient client = new HttpClient())
                {
                    try
                    {
                        HttpResponseMessage response = await client.GetAsync(url);
                        response.EnsureSuccessStatusCode();
                        string responseBody = await response.Content.ReadAsStringAsync();

                        // Deserialize JSON to a C# object
                        return JsonConvert.DeserializeObject<PrayerApiResponse>(responseBody);
                    }
                    catch
                    {
                        return null;
                    }
                }
            }

            // Classes to map JSON response
            public class PrayerApiResponse
            {
                public PrayerData data { get; set; }

                public List<string> GetPrayerTimesForDate(DateTime date)
                {
                    if (data == null || data.times == null || data.times.Count == 0) return null;

                    // Get the index of the date (assuming times are in sequential order from the current month)
                    DateTime startOfMonth = new DateTime(date.Year, date.Month, 1);
                    int index = (date - startOfMonth).Days;

                    if (index >= 0 && index < data.times.Count)
                    {
                        var unixTimes = data.times[index];
                        List<string> prayerTimes = new List<string>();

                        foreach (var unixTime in unixTimes)
                        {
                            DateTime prayerTime = DateTimeOffset.FromUnixTimeSeconds(unixTime).LocalDateTime;
                            prayerTimes.Add(prayerTime.ToString("hh:mm tt", CultureInfo.InvariantCulture)); // 12-hour format
                        }

                        return prayerTimes;
                    }

                    return null;
                }
            }

            public class PrayerData
            {
                public List<List<long>> times { get; set; }
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


        private void LoadPrayer()
        {
            // Retrieve the prayer times from the query string
            string prayerTimes = Request.QueryString["prayerTimes"];

            if (!string.IsNullOrEmpty(prayerTimes))
            {
                // Split the prayer times into an array
                string[] prayerTimesArray = prayerTimes.Split(',');

                // Check if the array contains the correct number of items
                if (prayerTimesArray.Length == 6)
                {
                    lblPrayerTimes.Text = $"Fajr: {HttpUtility.HtmlEncode(prayerTimesArray[0])}<br>" +
                                          $"Sunrise: {HttpUtility.HtmlEncode(prayerTimesArray[1])}<br>" +
                                          $"Dhuhr: {HttpUtility.HtmlEncode(prayerTimesArray[2])}<br>" +
                                          $"Asr: {HttpUtility.HtmlEncode(prayerTimesArray[3])}<br>" +
                                          $"Maghrib: {HttpUtility.HtmlEncode(prayerTimesArray[4])}<br>" +
                                          $"Isha: {HttpUtility.HtmlEncode(prayerTimesArray[5])}";
                }
                else
                {
                    lblPrayerTimes.Text = "Invalid prayer times data.";
                }
            }
            else
            {
                lblPrayerTimes.Text = "No prayer times available.";
            }
        }

    }

}

