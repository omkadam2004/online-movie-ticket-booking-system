<%@ Page Title="Login" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .login-form {
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
        .login-form h2 {
            margin-bottom: 1.5rem;
            color: #ffc300; /* Bright Yellow */
        }
        .login-form label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: bold;
            color: #ffd60a; /* Golden Yellow */
            text-align: left;
        }
        .login-form input[type="text"],
        .login-form input[type="password"] {
            width: 100%;
            padding: 0.5rem;
            margin-bottom: 1rem;
            border: 1px solid #ffd60a;
            border-radius: 4px;
            background-color: #000814; /* Dark Blue */
            color: white;
            box-sizing: border-box;
        }
        .login-form input::placeholder {
            color: #ffd60a; /* Golden Yellow Placeholder */
            opacity: 0.8;
        }
        .login-form button {
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
        .login-form button:hover {
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
    <div class="login-form">
        <form id="form1" runat="server">
            <h2>Login</h2>
            
            <label for="txtUsername">Username:</label>
            <asp:TextBox ID="txtUsername" CssClass="input-text" runat="server" placeholder="Enter your username"></asp:TextBox>

            <label for="txtPassword">Password:</label>
            <asp:TextBox ID="txtPassword" TextMode="Password" CssClass="input-text" runat="server" placeholder="Enter your password"></asp:TextBox>

            <asp:Button ID="btnLogin" CssClass="btn-login" Text="Login" OnClick="btnLogin_Click" runat="server" />
            
            <asp:Label ID="lblError" runat="server" ForeColor="Red" CssClass="error" EnableViewState="false"></asp:Label>
        </form>
    </div>
</asp:Content>
