<%@ Page Title="Payment" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="Payment.aspx.cs" Inherits="Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .container {
            width: 400px;
            margin: auto;
            text-align: center;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            background-color: #fff;
            color:black;
        }

        img {
            width: 200px;
            margin-bottom: 15px;
        }

        .btn {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .btn:hover {
            background-color: #218838;
        }

        .error {
            color: red;
            font-size: 14px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container">
        <h2>Complete Your Payment</h2>

        <asp:Label ID="lblUserId" runat="server" Visible="false" />
        <h3>Movie: <asp:Label ID="lblMovieTitle" runat="server" /></h3>
        <p>Showtime: <asp:Label ID="lblShowtime" runat="server" /></p>
         <h3>Total seats:<asp:Label ID="lblSelectedSeats" runat="server" /></h3>
         <h3>Amount:<asp:Label ID="lblTotalPrice" runat="server" /></h3>
        <h3>Scan QR to Pay</h3>
        <asp:Image ImageUrl="~/Images/Qr.jpg" runat="server" Width="200px" AlternateText="QR Code for Payment" />

        <h4>Enter UTR Number:</h4>
        <asp:TextBox ID="txtUTR" runat="server" CssClass="form-control" MaxLength="12"></asp:TextBox><br />

        <!-- Validation Message -->
        <asp:Label ID="lblError" runat="server" CssClass="error" Visible="false"></asp:Label><br /><br />

        <asp:Button ID="btnSubmitPayment" runat="server" Text="Submit Payment" CssClass="btn" OnClick="btnSubmitPayment_Click" />
    </div>
</asp:Content>
