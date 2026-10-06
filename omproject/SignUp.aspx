<%@ Page Title="Sign Up" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SignUp.aspx.cs" Inherits="SignUp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .signup-form {
            max-width: 400px;
            margin: 2rem auto;
            padding: 2rem;
            background-color: #001d3d; /* Deep Navy */
            border: 2px solid #003566; /* Dark Teal */
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
            color: #ffd60a; /* Golden Yellow */
        }
        .signup-form h2 {
            margin-bottom: 1.5rem;
            color: #ffc300; /* Bright Yellow */
        }
        .signup-form label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
            color: #ffd60a; /* Golden Yellow */
            text-align: left;
        }
        .signup-form input[type="text"],
        .signup-form input[type="email"],
        .signup-form input[type="password"] {
            width: 100%;
            padding: 0.5rem;
            margin-bottom: 1rem;
            border: 1px solid #ffd60a;
            border-radius: 4px;
            background-color: #000814; /* Dark Blue */
            color: white;
            box-sizing: border-box;
        }
        .signup-form input::placeholder {
            color: #ffd60a; /* Golden Yellow Placeholder */
            opacity: 0.8;
        }
        .signup-form button {
            width: 100%;
            padding: 0.75rem;
            background-color: #ffc300; /* Bright Yellow */
            color: #000814; /* Dark Blue */
            font-weight: bold;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .signup-form button:hover {
            background-color: #ffd60a; /* Golden Yellow */
        }
        .error {
            color: red;
            margin-top: 1rem;
            font-weight: bold;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <form runat="server">
    <div class="signup-form">
        <h2>Sign Up</h2>
        <label for="txtUsername">Username:</label>
        <asp:TextBox ID="txtUsername" runat="server" placeholder="Enter your username"></asp:TextBox>

        <label for="txtEmail">Email:</label>
        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="Enter your email"></asp:TextBox>

        <label for="txtPassword">Password:</label>
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter your password"></asp:TextBox>

        <label for="txtConfirmPassword">Confirm Password:</label>
        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Confirm your password"></asp:TextBox>

        <asp:Button ID="btnSignUp" Text="Sign Up" OnClick="btnSignUp_Click" runat="server" CssClass="signup-button" />
        <asp:Label ID="lblError1" runat="server" ForeColor="Green" CssClass="error" EnableViewState="false"></asp:Label> 
        <asp:Label ID="lblError" runat="server" ForeColor="Red" CssClass="error" EnableViewState="false"></asp:Label>
    </div>
        </form>
</asp:Content>
