<%@ Page Title="Settings" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Setting.aspx.cs" Inherits="InternWebApplication.Settings" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            font-family: "Open Sans", sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .container-settings {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-image: linear-gradient(135deg, #f7e3b5 10%, #f4c27f 50%, #c5b358 100%);
        }

        .settings-box {
            width: 100%;
            max-width: 600px;
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            padding: 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        .settings-box h3 {
            color: #333333;
            font-size: 2rem;
            margin-bottom: 20px;
        }

        .settings-box img {
            max-width: 100%;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .settings-box p {
            font-size: 1rem;
            color: #666666;
            margin-bottom: 20px;
        }

        .form-section {
            width: 100%;
            margin-bottom: 20px;
            text-align: left;
        }

        .form-section h4 {
            font-size: 1.2rem;
            color: #333333;
            margin-bottom: 10px;
        }

        .form-section .input {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-sizing: border-box;
            background-color: #f9f9f9;
        }

        .settings-box button,
        .settings-box a {
            display: inline-block;
            background-color: #cc99ff;
            color: #ffffff;
            padding: 15px;
            border-radius: 8px;
            border: none;
            text-align: center;
            font-size: 1rem;
            cursor: pointer;
            margin: 10px 5px 0;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .settings-box button:hover,
        .settings-box a:hover {
            background-color: #ac73e6;
        }

        .error-message {
            color: red;
            margin-bottom: 15px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-settings">
        <div class="settings-box">
            <h3>Update Your Account</h3>
            <img src="img/Maiktvprtl.jpeg" alt="MAIKTV Logo" />
            <p>CONTENTWAVE: Redefining Digital Signage and Live Streaming</p>
            <asp:Panel ID="SettingsPanel" runat="server">
                <asp:Label ID="ErrorMessage" runat="server" CssClass="error-message" Visible="False"></asp:Label>

                <!-- Username Section -->
                <div class="form-section">
                    <h4>Update Username</h4>
                    <asp:TextBox ID="Username" runat="server" CssClass="input" placeholder="New Username"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="UsernameValidator" runat="server" ControlToValidate="Username" ErrorMessage="Username is required." ForeColor="Red" Display="Dynamic" />
                </div>

                <!-- Password Section -->
                <div class="form-section">
                    <h4>Change Password</h4>
                    <asp:TextBox ID="Password" runat="server" CssClass="input" TextMode="Password" placeholder="New Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="PasswordValidator" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ForeColor="Red" Display="Dynamic" />
                </div>

                <!-- Buttons -->
                <div style="display: flex; justify-content: center; gap: 10px; flex-wrap: wrap;">
                    <asp:Button ID="SaveChangesButton" runat="server" Text="Save Changes" CssClass="w3-button w3-khaki" OnClick="SaveChangesButton_Click" />
                    <a href="WebForm1.aspx" class="w3-button w3-khaki">Cancel</a>
                </div>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
