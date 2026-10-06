<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>
<html>
<head>
    <title>Movie Listings</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Now Showing</h2>
            <asp:Repeater ID="rptMovies" runat="server">
                <ItemTemplate>
                    <div class="movie-card">
                        <img src='<%# Eval("PosterUrl") %>' alt='<%# Eval("Title") %>' class="movie-poster" />
                        <h3><%# Eval("Title") %></h3>
                        <p><%# Eval("Description") %></p>
                        <asp:HyperLink ID="lnkBook" runat="server" NavigateUrl='<%# "Booking.aspx?movieId=" + Eval("MovieId") %>' CssClass="book-button">Book Now</asp:HyperLink>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </form>
</body>
</html>