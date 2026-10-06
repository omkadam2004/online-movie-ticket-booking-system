<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMasterPage.master" AutoEventWireup="true" CodeFile="MovieListing.aspx.cs" Inherits="MovieListing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        /* General Page Styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }

        h2, h3 {
            text-align: center;
            color: #333;
        }

        /* GridView Styling */
        .grid-container {
            width: 80%;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        .grid-container .btn {
            padding: 5px 10px;
            border: none;
            cursor: pointer;
            font-size: 14px;
        }

        .btn-danger {
            background-color: #dc3545;
            color: white;
        }

        .btn-danger:hover {
            background-color: #b52b3a;
        }

        .btn-success {
            background-color: #28a745;
            color: white;
        }

        .btn-success:hover {
            background-color: #218838;
        }

        /* Form Styling */
        .form-container {
            width: 50%;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }

        .form-container label {
            font-weight: bold;
        }

        .form-container input[type="text"] {
            width: 100%;
            padding: 8px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .form-container .btn {
            width: 100%;
            margin-top: 10px;
        }

        /* Error Message */
        #lblErrorMessage {
            text-align: center;
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h2>Manage Movies</h2>

    <!-- Movies GridView -->
    <div class="grid-container">
        <asp:GridView ID="gvMovies" runat="server" AutoGenerateColumns="False" OnRowCommand="gvMovies_RowCommand" DataKeyNames="MovieId" CssClass="gridview">
            <Columns>
                <asp:BoundField DataField="MovieId" HeaderText="ID" />
                <asp:BoundField DataField="Title" HeaderText="Title" />
                <asp:BoundField DataField="Description" HeaderText="Description" />
                <asp:BoundField DataField="PosterUrl" HeaderText="Poster URL" />
                 <asp:BoundField DataField="Showtimes" HeaderText="Show-Time" />

                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Button ID="btnDelete" runat="server" CommandName="DeleteMovie" CommandArgument='<%# Eval("MovieId") %>' Text="Delete" CssClass="btn btn-danger"
                            OnClientClick="return confirm('Are you sure you want to delete this movie?');" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <!-- Error Message -->
        <asp:Label ID="lblErrorMessage" runat="server" Text="" ForeColor="Red"></asp:Label>
    </div>

    <!-- Add New Movie Form -->
    <div class="form-container">
        <h3>Add New Movie</h3>

        <label>Title:</label>
        <asp:TextBox ID="txtTitle" runat="server"></asp:TextBox><br />

        <label>Description:</label>
        <asp:TextBox ID="txtDescription" runat="server"></asp:TextBox><br />

        <label>Poster URL:</label>
        <asp:TextBox ID="txtPosterUrl" runat="server"></asp:TextBox><br />

        <label>Show Time:</label>
        <asp:TextBox ID="txtShowtimes" runat="server"></asp:TextBox><br />

        <asp:Button ID="btnAddMovie" runat="server" Text="Add Movie" OnClick="btnAddMovie_Click" CssClass="btn btn-success" />
    </div>
</asp:Content>
