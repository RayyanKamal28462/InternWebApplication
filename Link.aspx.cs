using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace InternWebApplication
{
    public partial class Links : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                // Redirect to the login page if the user is not logged in
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                // Load current user data if the user is logged in
                LoadFiles();

            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string link = txtLink.Text.Trim();
            if (!string.IsNullOrEmpty(link))
            {
                try
                {
                    SaveLinkOrVideo(link, "Link", link.Length);
                    txtLink.Text = string.Empty;
                    lblMessage.Text = "Link added successfully.";
                    lblMessage.CssClass = "w3-text-green";
                    LoadFiles();
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error: " + ex.Message;
                    lblMessage.CssClass = "w3-text-red";
                }
            }
        }

        protected void btnUploadVideo_Click(object sender, EventArgs e)
        {
            if (fileUploadVideo.HasFile)
            {
                try
                {
                    if (fileUploadVideo.PostedFile.ContentLength > 4294967296) // 4GB in bytes
                    {
                        lblMessage.Text = "File size must not exceed 4 GB.";
                        lblMessage.CssClass = "w3-text-red";
                        return;
                    }



                    string folderPath = Server.MapPath("~/UploadedVideos/");
                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                    }

                    string fileName = Path.GetFileName(fileUploadVideo.FileName);
                    string filePath = Path.Combine(folderPath, fileName);
                    fileUploadVideo.SaveAs(filePath);

                    long fileSizeMB = new FileInfo(filePath).Length / 1048576;
                    SaveLinkOrVideo(fileName, "Video", fileSizeMB);

                    lblMessage.Text = "File uploaded successfully.";
                    lblMessage.CssClass = "w3-text-green";
                    LoadFiles();
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error: " + ex.Message;
                    lblMessage.CssClass = "w3-text-red";
                }
            }
            else
            {
                lblMessage.Text = "Please select a file to upload.";
                lblMessage.CssClass = "w3-text-red";
            }
        }

        protected void GridViewFiles_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteRow")
            {
                try
                {
                    int id = Convert.ToInt32(e.CommandArgument);
                    DeleteFile(id);
                    LoadFiles();
                    lblMessage.Text = "File deleted successfully.";
                    lblMessage.CssClass = "w3-text-green";
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error: " + ex.Message;
                    lblMessage.CssClass = "w3-text-red";
                }
            }
        }

        private void SaveLinkOrVideo(string content, string type, long size)
        {
            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["MyDBConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "INSERT INTO Files (content, type, size, created_at) VALUES (@content, @type, @size, @created_at)";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@content", content);
                        cmd.Parameters.AddWithValue("@type", type);
                        cmd.Parameters.AddWithValue("@size", size);
                        cmd.Parameters.AddWithValue("@created_at", DateTime.Now);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Database error: " + ex.Message);
            }
        }

        private void LoadFiles()
        {
            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["MyDBConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "SELECT id, content, type, size, created_at FROM Files ORDER BY created_at DESC";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);
                            GridViewFiles.DataSource = dt;
                            GridViewFiles.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading files: " + ex.Message;
                lblMessage.CssClass = "w3-text-red";
            }
        }

        private void DeleteFile(int id)
        {
            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["MyDBConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "DELETE FROM Files WHERE id = @id";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@id", id);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error deleting file: " + ex.Message);
            }
        }
    }
}

