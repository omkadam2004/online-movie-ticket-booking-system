<%@ Page Title="Movies" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="Movies.aspx.cs" Inherits="Movies" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        /* Page Styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #000814; /* Dark Background */
            color: white;
        }

        h2 {
            text-align: center;
            color: #ffd60a; /* Golden Yellow */
            margin-bottom: 20px;
        }

        /* Movie Container */
        .movies-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            padding: 20px;
        }

        /* Movie Card */
        .movie-card {
            width: 250px;
            background: #001d3d; /* Deep Navy */
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(255, 211, 10, 0.2);
            text-align: center;
            transition: transform 0.3s ease;
        }

        .movie-card:hover {
            transform: scale(1.05);
        }

        .movie-card img {
            width: 100%;
            height: 300px;
            object-fit: cover;
            border-radius: 8px;
            border: 2px solid #ffc300; /* Bright Yellow */
        }

        .movie-card h3 {
            margin: 10px 0;
            font-size: 18px;
            color: #ffd60a; /* Golden Yellow */
        }

        .movie-card p {
            font-size: 14px;
            color: #ccc;
        }

        .btn-book {
            display: inline-block;
            margin-top: 10px;
            padding: 10px 15px;
            background-color: #ffc300; /* Bright Yellow */
            color: #000814;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
            font-weight: bold;
            transition: background-color 0.3s ease, color 0.3s;
        }

        .btn-book:hover {
            background-color: #ffd60a; /* Golden Yellow */
            color: #001d3d; /* Deep Navy */
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h2>Now Showing</h2>

    <div class="movies-container">
        <asp:Repeater ID="rptMovies" runat="server">
            <ItemTemplate>
                <div class="movie-card">
                    <img src='<%# Eval("PosterUrl") %>' alt='<%# Eval("Title") %>' />
                    <h3><%# Eval("Title") %></h3>
                    <h3><%# Eval("Showtimes") %></h3>
                    <h2>Price:100</h2>
                    <p><%# Eval("Description") %></p>
                    <a href='Booking.aspx?movieId=<%# Eval("MovieId") %>&userId=<%= Request.QueryString["userId"] %>' class="btn-book">Book Now</a>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
