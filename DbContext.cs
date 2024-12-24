using System;
using System.Data.Entity;
using System.Web.UI.WebControls;

public class DigitalSignageContext : DbContext
{
    public DbSet<User> Users { get; set; }
    public DbSet<Content> Contents { get; set; }
}
public class User
{
    public int UserID { get; set; }
    public string Username { get; set; }
    public string PasswordHash { get; set; }
    public string Role { get; set; }
}

public class Content
{
    public int ContentID { get; set; }
    public string Title { get; set; }
    public string Type { get; set; }
    public string FilePath { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }
}
public class File
{
    public int Id { get; set; }          // The primary key of the file record
    public string Content { get; set; }   // The file content (either the file path or URL)
    public string Type { get; set; }      // The type of file (e.g., 'file' or 'link')
    public DateTime CreatedAt { get; set; } // The timestamp when the file was created
}

