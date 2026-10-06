<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="AdminTicketConfirmation.aspx.cs" Inherits="AdminTicketConfirmation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .grid-container {
            margin-top: 20px;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .grid-action-btns {
            display: flex;
            gap: 5px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2 class="text-center text-primary">Pending Ticket Confirmations</h2>

    <asp:ScriptManager runat="server" />

    <div class="grid-container">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="gvBookings" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover"
                    OnRowCommand="gvBookings_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="BookingId" HeaderText="Booking ID" />
                        <asp:BoundField DataField="UserEmail" HeaderText="User Email" />
                        <asp:BoundField DataField="MovieTitle" HeaderText="Movie Title" />
                        <asp:BoundField DataField="SeatNumber" HeaderText="Seat Number" />
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <div class="grid-action-btns">
                                    <asp:Button ID="btnConfirm" runat="server" Text="Confirm" CommandName="ConfirmTicket"
                                        CommandArgument='<%# Eval("BookingId") %>' CssClass="btn btn-success btn-sm" />
                                    <asp:Button ID="btnReject" runat="server" Text="Reject" CommandName="RejectTicket"
                                        CommandArgument='<%# Eval("BookingId") %>' CssClass="btn btn-danger btn-sm" />
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick" />
            </Triggers>
        </asp:UpdatePanel>
    </div>

    <!-- Timer to refresh GridView every 10 seconds -->
    <asp:Timer ID="Timer1" runat="server" Interval="50" OnTick="Timer1_Tick" />
</asp:Content>
