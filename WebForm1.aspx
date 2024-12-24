<%@ Page Title="CMS Dashboard" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="InternWebApplication.WebForm1" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"> 
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <style>
        body, html {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            height: 100%;
            background-color: #F4F4F9;
            overflow-x: hidden;
        }
        .prayer-times-container {
            max-width: 500px;
            margin: 0 auto;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background-color: #f9f9f9;
        }

        .prayer-times-container h2 {
            text-align: center;
            color: #2c3e50;
        }

        .prayer-times-container label {
            font-weight: bold;
            margin-bottom: 8px;
            color: #34495e;
            display: inline-block;
        }

        .prayer-times-container input[type="text"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        .prayer-times-container button {
            width: 100%;
            padding: 10px;
            background-color: #2980b9;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .prayer-times-container button:hover {
            background-color: #3498db;
        }

        .prayer-times-container .result-label {
            margin-top: 20px;
            text-align: center;
            display: block;
            color: #2c3e50;
            font-size: 16px;
        }
        /* Header */
        .header {
            background-color: khaki;
            color: white;
            padding: 15px;
            text-align: center;
            font-size: 1.8rem;
            position: relative;
            z-index: 1000;
            transition: all 0.3s;
        }

        .header .hamburger {
            font-size: 30px;
            cursor: pointer;
            position: absolute;
            top: 15px;
            right: 15px;
            z-index: 1100;
            display: block;
        }

        /* Sidebar */
        .sidebar {
            position: fixed;
            top: 0;
            right: -250px;
            width: 250px;
            height: 100%;
            background-color: khaki;
            color: white;
            padding-top: 60px;
            transition: right 0.3s ease;
            z-index: 999;
            overflow-y: auto;
        }

        .sidebar a {
            padding: 15px 20px;
            text-decoration: none;
            color: white;
            display: block;
            transition: background-color 0.3s;
            border-bottom: 1px solid #444;
        }

        .sidebar a:hover {
            background-color: #ffbf00;
        }

        .sidebar a.active {
            background-color: #ffbf00;
        }

        /* Main Content */
        .main-content {
            margin-left: 0;
            padding: 20px;
            background-color: white;
            min-height: 100vh;
            transition: margin-left 0.3s ease;
        }

       
        #tagline-container {
            color: #fff;
            padding: 10px;
            font-size: 2rem;
            white-space: nowrap;
            overflow: hidden;
            position: relative;
            height: 50px;
            line-height: 30px;
        }

        #tagline {
            position: absolute;
            animation: scrollTagline 20s linear infinite;
        }

        @keyframes scrollTagline {
            from {
                left: 100%;
            }
            to {
                left: -100%;
            }
        }

        /* Hamburger Menu - Show Sidebar */
        .sidebar.show {
            right: 0;
        }

        .main-content.sidebar-open {
            margin-right: 250px;
        }

        /* Responsive Styles */
        @media screen and (max-width: 768px) {
            .header {
                font-size: 1.5rem;
            }

            .sidebar {
                width: 100%;
                height: 100%;
            }

            .sidebar a {
                padding: 15px;
                font-size: 1.2rem;
            }

            .hamburger {
                display: block;
            }
        }
   .video-player-container {
    position: relative;
    width: 100%;
    height: 125vh; /* Full height of the viewport */
    max-width: 100%;
    overflow: hidden;
    background-color: #000;
}

.video-player {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
}

</style>

     
  <script type="text/javascript">
      // Function to get the user's location and send it to the server
      function getLocation() {
          if (navigator.geolocation) {
              navigator.geolocation.getCurrentPosition(function (position) {
                  var latitude = position.coords.latitude;
                  var longitude = position.coords.longitude;

                  // Pass the latitude and longitude to the server
                  fetchPrayerTimes(latitude, longitude);
              }, function (error) {
                  document.getElementById("lblPrayerTimes").innerHTML = "Error occurred while fetching your location. Please refresh the page.";
              });
          } else {
              document.getElementById("lblPrayerTimes").innerHTML = "Geolocation is not supported by this browser.";
          }
      }

      // Function to call the server-side method and update prayer times
      function fetchPrayerTimes(latitude, longitude) {
          const url = `WebForm1.aspx?latitude=${latitude}&longitude=${longitude}`;

          fetch(url)
              .then((response) => response.text())
              .then((data) => {
                  document.getElementById("lblPrayerTimes").innerHTML = data;
              })
              .catch((error) => {
                  document.getElementById("lblPrayerTimes").innerHTML = "Failed to fetch prayer times.";
              });
      }

      // Trigger location detection on page load
      window.onload = function () {
          getLocation();
      };
  
    
        function toggleSidebar() {
            const sidebar = document.querySelector('.sidebar');
            const mainContent = document.querySelector('.main-content');
            sidebar.classList.toggle('show');
            mainContent.classList.toggle('sidebar-open');

        }      
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Header -->
    <div class="header">
        <img src="img/MAIK2.png" />
        <span class="hamburger" onclick="toggleSidebar()">&#9776;</span> <!-- Hamburger Icon -->
    </div>

    <!-- Sidebar -->
    <div class="sidebar">
        <a href="Link.aspx" data-section="PlayerSection" onclick="loadContent('PlayerSection')">Player</a>
        <a href="VideoPlaylist.aspx" class="button">Video Display</a>
        <a href="Setting.aspx" data-section="SettingsSection" onclick="loadContent('SettingsSection')">Settings</a>
        <a href="Login.aspx" class="button">Login</a>
    </div>

   <div>
              <asp:Literal ID="videoContainer" runat="server"></asp:Literal>
                   <asp:Label ID="lblPrayerTimes" runat="server" Text="Prayer times will be displayed here." />
</div>
    <div class="prayer-times-container">
        <h2>Prayer Times</h2>
        <asp:Label ID="Label1" runat="server" CssClass="result-label" Text="Detecting your location..."></asp:Label>
    </div>

    <!-- Footer with Tagline -->
    <footer>
        <div id="tagline-container">
            <div id="tagline">
    <span><asp:Label ID="lblPreview" runat="server"></asp:Label></span>
            </div>
        </div>
    </footer>
</asp:Content>

