<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Preventivi.aspx.cs" Inherits="CarEpicode.Preventivi" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="style/style.css" rel="stylesheet" />
    <title>Car Epicode</title>
</head>
<body>
    <form id="formPreventivo" runat="server">
        <div>
            <h2>Modello macchina</h2>
            <asp:DropDownList ID="CarList" runat="server" OnSelectedIndexChanged="CarList_SelectedIndexChanged" AutoPostBack="True">
            </asp:DropDownList>
        </div>
        <div>
            <h2>Cliente</h2>
            <asp:Label ID="lblName" runat="server" Text="Nome:"></asp:Label>
            <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
        </div>
        <div>
            <h2>Optionals</h2>
            <asp:CheckBoxList ID="CarOptionals" runat="server">
                <asp:ListItem Text="Cambio colore carrozzeria" Value="1"></asp:ListItem>
                <asp:ListItem Text="Pacchetto assistenza alla guida" Value="2"></asp:ListItem>
                <asp:ListItem Text="Schermo touchscreen" Value="3"></asp:ListItem>
            </asp:CheckBoxList>
        </div>
        <div>
            <h2>Garanzia</h2>
            <asp:DropDownList ID="carAssurance" runat="server">
                <asp:ListItem Text="0" Value="0"></asp:ListItem>
                <asp:ListItem Text="1" Value="1"></asp:ListItem>
                <asp:ListItem Text="2" Value="2"></asp:ListItem>
                <asp:ListItem Text="3" Value="3"></asp:ListItem>
                <asp:ListItem Text="4" Value="4"></asp:ListItem>
                <asp:ListItem Text="5" Value="5"></asp:ListItem>
                <asp:ListItem Text="6" Value="6"></asp:ListItem>
                <asp:ListItem Text="7" Value="7"></asp:ListItem>
                <asp:ListItem Text="8" Value="8"></asp:ListItem>
                <asp:ListItem Text="9" Value="9"></asp:ListItem>
                <asp:ListItem Text="10" Value="10"></asp:ListItem>
            </asp:DropDownList>
        </div>
        <asp:Panel ID="showPreventivo" runat="server">
            <h2>Preventivo:</h2>
            <asp:Label ID="basePriceAndModel" runat="server" Text="Label"></asp:Label>
            <asp:Label ID="totOptionals" runat="server" Text="Label"></asp:Label>
            <asp:Label ID="totAssurance" runat="server" Text="Label"></asp:Label>
            <asp:Label ID="totalPrice" runat="server" Text="Label"></asp:Label>
        </asp:Panel>
        <asp:Button ID="sendPreventivo" runat="server" Text="Fai un preventivo" OnClick="sendPreventivo_Click" />
    </form>
    <div id="preventiviImg">
        <asp:Image ID="carImage" runat="server" src="" AlternateText="Img Macchina"/>
    </div>
</body>
</html>
