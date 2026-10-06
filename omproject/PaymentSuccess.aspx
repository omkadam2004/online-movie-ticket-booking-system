<%@ Page Title="Payment Success" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="PaymentSuccess.aspx.cs" Inherits="PaymentSuccess" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            text-align: center;
            padding: 50px;
        }

        .success-container {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: inline-block;
            color:black;
        }

        h2 {
            color: green;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin-top: 20px;
            background: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            border: none;
            cursor: pointer;
        }

        .btn:hover {
            background: #0056b3;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="success-container">
        <h2>🎉 Payment Successful!</h2>
        <p>Thank you for booking your ticket.</p>

        <strong>Movie:</strong> <asp:Label ID="lblMovieName" runat="server" /><br />
        <strong>Seats:</strong> <asp:Label ID="lblSeats" runat="server" /><br />
        <strong>Total Price</strong> :<asp:Label ID="lblTotalPrice" runat="server" /><br />
        <strong>Transaction ID:</strong> <asp:Label ID="lblTransactionID" runat="server" /><br />

        <asp:Button ID="btnHome" runat="server" CssClass="btn" Text="Go to Homepage" OnClick="btnHome_Click" />
    </div>
</asp:Content>
