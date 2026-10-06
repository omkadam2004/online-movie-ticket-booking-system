<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  
<!DOCTYPE html>
<html>
<head>
    <title>Contact Us</title>
    <style>
        .container { max-width: 500px; margin: auto; padding: 20px; border: 1px solid #ccc; border-radius: 5px; }
        label { font-weight: bold; }
        .form-control { width: 100%; padding: 8px; margin-bottom: 10px; border: 1px solid #ccc; border-radius: 4px; }
        .btn-submit { background-color: #28a745; color: white; padding: 10px 15px; border: none; cursor: pointer; }
    </style>
</head>
<body>
    <form runat="server">    <div class="container">
        <h2>Contact Us</h2>
        <asp:Label ID="lblMessage" runat="server" ForeColor="Green"></asp:Label>
        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Placeholder="Your Name" Required="true"></asp:TextBox>
        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Your Email" Required="true"></asp:TextBox>
        <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" Placeholder="Subject" Required="true"></asp:TextBox>
        <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" Placeholder="Your Message" Required="true"></asp:TextBox>
        <asp:Button ID="btnSubmit" runat="server" CssClass="btn-submit" Text="Submit" OnClick="btnSubmit_Click" />
    </div>
</body>
</html>
    </form>

</asp:Content>

