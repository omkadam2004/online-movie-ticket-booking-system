<%@ Page Title="My Tickets" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="MyTickets.aspx.cs" Inherits="MyTickets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <style>
        /* Page Styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #000814; /* Dark Background */
            color: white;
            text-align: center;
        }

        .container {
            width: 80%;
            margin: 20px auto;
            background: #001d3d; /* Deep Navy */
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(255, 211, 10, 0.2);
        }

        h2 {
            color: #ffd60a; /* Golden Yellow */
            margin-bottom: 20px;
        }

        /* GridView Styling */
        .gridview {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
            color: white;
        }

        .gridview th, .gridview td {
            padding: 12px;
            border: 1px solid #ffc300; /* Yellow Borders */
            text-align: center;
        }

        .gridview th {
            background-color: #ffc300; /* Bright Yellow */
            color: #001d3d; /* Dark Navy */
        }

        .gridview tr:nth-child(even) {
            background-color: #002855; /* Lighter Navy */
        }

        .gridview tr:hover {
            background-color: #003f88; /* Highlight on Hover */
        }

        /* Button Styling */
        .btn {
            padding: 8px 12px;
            border: none;
            cursor: pointer;
            font-size: 14px;
            background-color: #ffc300; /* Bright Yellow */
            color: #001d3d;
            border-radius: 4px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s ease, color 0.3s;
        }

        .btn:hover {
            background-color: #ffd60a;
            color: #000814;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Tickets</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h2>My Tickets</h2>
    <asp:GridView ID="gvTickets" runat="server" AutoGenerateColumns="False" CssClass="ticket-table">
        <Columns>
            <asp:BoundField DataField="TicketId" HeaderText="Ticket ID" />
            <asp:BoundField DataField="Title" HeaderText="Movie" />
            <asp:BoundField DataField="SeatNumber" HeaderText="Seat" />
            <asp:BoundField DataField="BookingDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
            <asp:BoundField DataField="Status" HeaderText="Status" />
        </Columns>
    </asp:GridView>
</body>
</html>

</asp:Content>
