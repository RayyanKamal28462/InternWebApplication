<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="InternWebApplication.Login" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            font-family: "Open Sans", sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .container-login {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-image: linear-gradient(135deg, #f7e3b5 10%, #f4c27f 50%, #c5b358 100%);
        }

        .login-box {
            width: 600px;
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            padding: 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .login-box h3 {
            color: #333333;
            font-size: 2rem;
            margin-bottom: 20px;
            text-align: center;
        }

        .login-box p {
            color: #666666;
            text-align: center;
            margin-bottom: 30px;
        }

        .login-box input[type="text"],
        .login-box input[type="password"] {
            width: 100%;
            padding: 15px;
            margin-top: 10px;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-sizing: border-box;
            background-color: #f9f9f9;
        }

        .login-box button {
            width: 100%;
            background-color: #cc99ff;
            color: #ffffff;
            padding: 15px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-size: 1rem;
            margin-top: 20px;
        }

        .login-box button:hover {
            background-color: #ac73e6;
        }

        .input {
            width: 100%;
            padding: 15px;
            margin-top: 10px;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-sizing: border-box;
            background-color: #f9f9f9;
        }

        .login-box img {
            max-width: 100%;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .login-box p {
            color: #666666;
            font-size: 1rem;
        }

        .w3-center {
            text-align: center;
        }

        a {
            text-decoration: none;
            color: #cc99ff;
        }

        a:hover {
            color: #ac73e6;
        }

        .error-message {
            color: red;
            margin-bottom: 15px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-login">
        <div class="login-box">
            <h3>Welcome to MAIKTV</h3>
            <img src="img/Maiktvprtl.jpeg" alt="MAIKTV Logo" />
            <p>CONTENTWAVE: Redefining Digital Signage and Live Streaming</p>
            <asp:Panel ID="LoginPanel" runat="server">
                <asp:Label ID="ErrorMessage" runat="server" CssClass="error-message" Visible="False"></asp:Label>
                <asp:TextBox ID="Username" runat="server" CssClass="input" placeholder="Username"></asp:TextBox>
                <asp:RequiredFieldValidator ID="UsernameValidator" runat="server" ControlToValidate="Username" ErrorMessage="Username is required." ForeColor="Red" Display="Dynamic" />
                <asp:TextBox ID="Password" runat="server" CssClass="input" TextMode="Password" placeholder="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="PasswordValidator" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ForeColor="Red" Display="Dynamic" />
                <br />
                <asp:CheckBox ID="RememberMe" runat="server" Text="Remember Me" CssClass="w3-center" />
                <p><asp:Button ID="LoginButton" runat="server" Text="Login" CssClass="w3-button w3-khaki" OnClick="LoginButton_Click" /></p>

                <p>Don't have an account? <a href="Signup.aspx">Register Your Account</a></p>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
