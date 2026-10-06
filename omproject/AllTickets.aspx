<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="AllTickets.aspx.cs" Inherits="AllTickets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  
    <h2>All Tickets</h2>

    <asp:ScriptManager runat="server" />

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:GridView ID="gvTickets" runat="server" AutoGenerateColumns="False" CssClass="table">
                <Columns>
                    <asp:BoundField DataField="TicketId" HeaderText="Ticket ID" />
                    <asp:BoundField DataField="UserEmail" HeaderText="User Email" />
                    <asp:BoundField DataField="MovieTitle" HeaderText="Movie Title" />
                    <asp:BoundField DataField="SeatNumber" HeaderText="Seat Number" />
                    <asp:BoundField DataField="BookingDate" HeaderText="Booking Date" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                </Columns>
            </asp:GridView>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick" />
        </Triggers>
    </asp:UpdatePanel>

    <!-- Timer to auto-refresh every 10 seconds -->
    <asp:Timer ID="Timer1" runat="server" Interval="10000" OnTick="Timer1_Tick" />

</asp:Content>

