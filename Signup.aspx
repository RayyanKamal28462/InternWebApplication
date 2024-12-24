<%@ Page Title="Sign Up" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="InternWebApplication.Signup" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            font-family: "Open Sans", sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .container-signup {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-image: linear-gradient(135deg, #f7e3b5 10%, #f4c27f 50%, #c5b358 100%);
        }

        .signup-box {
            width: 600px;
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            padding: 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .signup-box h3 {
            color: #333333;
            font-size: 2rem;
            margin-bottom: 20px;
            text-align: center;
        }

        .signup-box p {
            color: #666666;
            text-align: center;
            margin-bottom: 30px;
        }

        .signup-box input[type="text"],
        .signup-box input[type="password"],
        .signup-box input[type="email"] {
            width: 100%;
            padding: 15px;
            margin-top: 10px;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-sizing: border-box;
            background-color: #f9f9f9;
        }

        .signup-box button {
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

        .signup-box button:hover {
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

        .signup-box img {
            max-width: 100%;
            border-radius: 8px;
            margin-bottom: 20px;
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
    <div class="container-signup">
        <div class="signup-box">
            <h3>Create Your Account</h3>
            <img src="img/Maiktvprtl.jpeg" alt="MAIKTV Logo" />
            <p>CONTENTWAVE: Redefining Digital Signage and Live Streaming</p>
            <asp:Panel ID="SignupPanel" runat="server">
                <asp:Label ID="ErrorMessage" runat="server" CssClass="error-message" Visible="False"></asp:Label>
                <asp:TextBox ID="Username" runat="server" CssClass="input" placeholder="Username"></asp:TextBox>
                <asp:RequiredFieldValidator ID="UsernameValidator" runat="server" ControlToValidate="Username" ErrorMessage="Username is required." ForeColor="Red" Display="Dynamic" />
                
               
                <asp:TextBox ID="Password" runat="server" CssClass="input" TextMode="Password" placeholder="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="PasswordValidator" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ForeColor="Red" Display="Dynamic" />
                
                <asp:TextBox ID="ConfirmPassword" runat="server" CssClass="input" TextMode="Password" placeholder="Confirm Password"></asp:TextBox>
                <asp:CompareValidator ID="ComparePasswordValidator" runat="server" ControlToValidate="ConfirmPassword" ControlToCompare="Password" ErrorMessage="Passwords do not match." ForeColor="Red" Display="Dynamic" />
                <br />
                <asp:CheckBox ID="AgreeTerms" runat="server" Text="I agree to the Terms and Conditions" CssClass="w3-center" />
                <br />
                <p><asp:Button ID="SignupButton" runat="server" Text="Sign Up" CssClass="w3-button w3-khaki" OnClick="SignupButton_Click" /></p>

                <p>Already have an account? <a href="Login.aspx">Login here</a></p>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
