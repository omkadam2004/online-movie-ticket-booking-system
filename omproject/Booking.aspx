<%@ Page Title="Seat Booking" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="Booking.aspx.cs" Inherits="Booking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .seat-container {
            display: flex;
            flex-wrap: wrap;
            width: 300px;
            margin: auto;
        }

        .seat {
            width: 40px;
            height: 40px;
            margin: 5px;
            display: inline-block;
            text-align: center;
            line-height: 40px;
            background-color: green;
            color: white;
            cursor: pointer;
            border-radius: 5px;
            transition: background 0.3s ease;
        }

        .seat.booked {
            background-color: red;
            cursor: not-allowed;
        }

        .seat.selected {
            background-color: orange;
        }
    </style>

    <script>
        function toggleSeat(seat) {
            if (seat.classList.contains('booked')) return;
            seat.classList.toggle('selected');
            updateSelectedSeats();
        }

        function updateSelectedSeats() {
            let selectedSeats = [];
            document.querySelectorAll('.seat.selected').forEach(seat => {
                selectedSeats.push(seat.innerText);
            });
            document.getElementById('<%= hdnSelectedSeats.ClientID %>').value = selectedSeats.join(',');
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2>Movie: <asp:Label ID="lblTitle" runat="server" /></h2>
    <p><asp:Label ID="lblShowtime" runat="server" /></p>
    <asp:Image ID="imgMovie" runat="server" Width="200px" Height="300px" />

    <h3>Select Your Seats</h3>
    <div class="seat-container">
        <asp:Literal ID="ltlSeats" runat="server"></asp:Literal>
    </div>

    <!-- HiddenField to store selected seats -->
    <asp:HiddenField ID="hdnSelectedSeats" runat="server" ClientIDMode="Static" />

    <asp:Button ID="btnConfirm" runat="server" Text="Confirm Booking" CssClass="btn" OnClick="btnConfirm_Click" />
</asp:Content>
