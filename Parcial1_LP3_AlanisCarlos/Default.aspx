<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Parcial1_LP3_AlanisCarlos.Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tienda Online</title>
    <link href="~/estilos.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="formulario">
            <h1>Gestión de productos</h1>
            <p>Elegí la operación que querés realizar.</p>

            <div class="menu">
                <asp:HyperLink ID="HyperLink1" runat="server"
                    Text="Alta de producto" NavigateUrl="~/altaproducto.aspx" />
                <asp:HyperLink ID="HyperLink2" runat="server"
                    Text="Baja de producto" NavigateUrl="~/bajaproducto.aspx" />
                <asp:HyperLink ID="HyperLink3" runat="server"
                    Text="Modificación de producto" NavigateUrl="~/modificacionproducto.aspx" />
                <asp:HyperLink ID="HyperLink4" runat="server"
                    Text="Consulta de productos" NavigateUrl="~/consultaproducto.aspx" />
            </div>
        </div>
    </form>
</body>
</html>
