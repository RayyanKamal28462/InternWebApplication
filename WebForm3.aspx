<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WebForm3.aspx.cs" Inherits="InternWebApplication.WebForm3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Body */
        body, html {
            height: 100%;
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            overflow-x: hidden; /* Prevent horizontal scrolling */
        }

        /* Header */
        .header {
            background-color: khaki;
            color: white;
            padding: 15px;
            text-align: center;
            font-size: 1.8rem;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            transition: all 0.3s;
            box-sizing: border-box;
            height: auto;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .header img {
            max-width: 150px; /* Increased for better visibility */
            height: auto;
        }

        /* Video Player Container */
        .video-player-container {
            width: 100%;
            height: 100vh; /* Adjust height dynamically based on viewport */
            background-color: #000;
            margin-top: 80px; /* Allow space for the header */
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Video Player */
        .video-player {
            width: 100%;
            height: 100%;
            border-radius: 10px;
            object-fit: cover; /* Ensures the video covers the container without distortion */
        }

        /* Tagline Animation */
        #tagline-container {
            position: fixed;
            bottom: 0;
            width: 100%;
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 10px 0;
            font-size: 1.8rem;
            white-space: nowrap;
            overflow: hidden;
            box-sizing: border-box;
            z-index: 2000;
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

        /* Footer */
        footer {
            position: relative;
            height: 50px;
            background-color: #333;
            color: white;
            text-align: center;
            line-height: 50px;
            font-size: 1rem;
        }

        /* Responsive Adjustments */
        @media screen and (max-width: 768px) {
            .header {
                font-size: 1.5rem;
            }
            #tagline-container {
                font-size: 1.5rem;
            }
            .video-player-container {
                height: 60vh; /* Adjust video height for smaller screens */
            }
        }

        @media screen and (max-width: 480px) {
            .header {
                font-size: 1.2rem;
            }
            #tagline-container {
                font-size: 1.2rem;
            }
            footer {
                font-size: 0.9rem;
            }
        }

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Header -->
    <div class="header">
        <img src="img/MAIK2.png" alt="Logo" />
    </div>

    <!-- Video Player -->
    <div class="video-player-container">
        <asp:Literal ID="videoContainer" runat="server"></asp:Literal>
    </div>

    <!-- Footer -->
    <footer>
        <div id="tagline-container">
            <div id="tagline">
                <span><asp:Label ID="lblPreview" runat="server"></asp:Label></span>
            </div>
        </div>
    </footer>
</asp:Content>
