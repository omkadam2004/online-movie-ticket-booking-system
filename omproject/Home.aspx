<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">


    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            text-align: center;
        }

        .container {
            width: 80%;
            margin: 20px auto;
            background: transperent;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        .banner {
            width: 100%;
            height: 300px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        h2 {
            color: white;
        }

        .movies-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 15px;
        }

        .movie-card {
            width: 200px;
            background: white;
            padding: 10px;
            border-radius: 8px;
            box-shadow: 0px 0px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .movie-card img {
            width: 100%;
            height: 250px;
            object-fit: cover;
            border-radius: 8px;
        }

        .btn-view {
            display: inline-block;
            margin-top: 10px;
            padding: 5px 10px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
        }

        .btn-view:hover {
            background-color: #0056b3;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">
        <img src="Images/t1.png" class="banner" alt="Welcome Banner">

        <h2>Welcome to Movie Booking</h2>
        <p>Book your favorite movie tickets online hassle-free. Choose from the latest releases and enjoy a seamless booking experience.</p>

        <h3>Now Showing</h3>
        <div class="movies-container">
            <asp:Repeater ID="rptMovies" runat="server">
                <ItemTemplate>
                    <div class="movie-card">
                        <img src='<%# Eval("PosterUrl") %>' alt='<%# Eval("Title") %>' />
                        <h4><%# Eval("Title") %></h4>
                        <a href='Movies.aspx' class="btn-view">View More</a>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>



