using System;

namespace InternWebApplication
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Define the video URL
            string videoUrl = "https://www.youtube.com/embed/dQw4w9WgXcQ";

            // Embed the YouTube video in the iframe
            litYouTubeLink.Text = $"<iframe width='560' height='315' src='{videoUrl}' frameborder='0' allow='accelerometer; autoplay muted; clipboard-write; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe>";
        }
    }
}
