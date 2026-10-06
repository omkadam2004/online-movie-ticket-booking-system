<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="UHistory.aspx.cs" Inherits="UHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   
<!DOCTYPE html>
<html>
<head >
    <title>Your Bookings</title>
    <style>
        body { font-family: Arial, sans-serif; }
        .container { width: 80%; margin: auto; padding: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #007BFF; color: white; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Your Bookings</h2>
        <asp:GridView ID="gvBookings" runat="server" AutoGenerateColumns="False" CssClass="table">
            <Columns>
                <asp:BoundField DataField="BookingId" HeaderText="Booking ID" />
                <asp:BoundField DataField="Title" HeaderText="Movie Name" />
                <asp:BoundField DataField="SeatNumber" HeaderText="Seat" />
                <asp:BoundField DataField="BookingDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                <asp:BoundField DataField="Status" HeaderText="Status" />
            </Columns>
        </asp:GridView>
    </div>
</body>
</html>

</asp:Content>

