<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="altaProducto.aspx.cs" Inherits="Parcial1_LP3_AlanisCarlos.altaProducto" Culture="es-AR" UICulture="es-AR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Alta de producto</title>
    <link href="~/estilos.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="formulario">
            <h1>Alta de producto</h1>

            <div class="campo">
                <asp:Label ID="lblNombre" runat="server" Text="Nombre" AssociatedControlID="txtNombre" />
                <asp:TextBox ID="txtNombre" runat="server" MaxLength="80" />
            </div>

            <div class="campo">
                <asp:Label ID="lblPrecio" runat="server" Text="Precio" AssociatedControlID="txtPrecio" />
                <asp:TextBox ID="txtPrecio" runat="server" />
            </div>

            <div class="campo">
                <asp:Label ID="lblCategoria" runat="server" Text="Categoría" AssociatedControlID="ddlCategoria" />
                <asp:DropDownList ID="ddlCategoria" runat="server"
                    DataSourceID="sdsCategorias"
                    DataTextField="descripcion"
                    DataValueField="idCategoria" />
            </div>

            <div class="campo">
                <asp:Button ID="btnConfirmar" runat="server" Text="Confirmar" OnClick="btnConfirmar_Click" />
            </div>

            <asp:Label ID="lblMensaje" runat="server" />

            <div class="navegacion">
                <asp:HyperLink ID="hlVolver" runat="server"
                    Text="Volver a la página principal" NavigateUrl="~/Default.aspx" />
            </div>
        </div>

        <!-- Origen de datos 1: categorías (llena el DropDownList) -->
        <asp:SqlDataSource ID="sdsCategorias" runat="server"
            ConnectionString="<%$ ConnectionStrings:tienda %>"
            SelectCommand="SELECT idCategoria, descripcion FROM categorias ORDER BY descripcion" />

        <!-- Origen de datos 2: productos (inserta el nuevo registro) -->
        <asp:SqlDataSource ID="sdsProductos" runat="server"
            ConnectionString="<%$ ConnectionStrings:tienda %>"
            InsertCommand="INSERT INTO productos (nombre, precio, idCategoria) VALUES (@nombre, @precio, @idCategoria)">
            <InsertParameters>
                <asp:Parameter Name="nombre" Type="String" />
                <asp:Parameter Name="precio" Type="Decimal" />
                <asp:Parameter Name="idCategoria" Type="Int32" />
            </InsertParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
