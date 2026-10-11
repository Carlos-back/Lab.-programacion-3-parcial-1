<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="modificacionProducto.aspx.cs" Inherits="Parcial1_LP3_AlanisCarlos.modificacionProducto" Culture="es-AR" UICulture="es-AR" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Modificación de producto</title>
    <link href="~/estilos.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="formulario">
            <h1>Modificación de producto</h1>

            <!-- Paso 1: buscar el producto por su código -->
            <div class="campo">
                <asp:Label ID="lblCodigo" runat="server" Text="Código del producto" AssociatedControlID="txtCodigo" />
                <asp:TextBox ID="txtCodigo" runat="server" />
                <asp:Button ID="btnBuscar" runat="server" Text="Buscar" OnClick="btnBuscar_Click" />
            </div>

            <div class="navegacion">
                <asp:HyperLink ID="hlListado" runat="server"
                    Text="Ver el listado de productos (para consultar los códigos)"
                    NavigateUrl="~/consultaproducto.aspx" />
            </div>

            <!-- Paso 2: campos editables (se muestran solo si se encontró el producto) -->
            <asp:Panel ID="pnlEdicion" runat="server" Visible="False">
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
                    <asp:Button ID="btnModificar" runat="server" Text="Modificar" OnClick="btnModificar_Click" />
                </div>
            </asp:Panel>

            <asp:Label ID="lblMensaje" runat="server" />

            <div class="navegacion">
                <asp:HyperLink ID="hlVolver" runat="server"
                    Text="Volver a la página principal" NavigateUrl="~/Default.aspx" />
            </div>
        </div>

        <!-- Categorías: llena el DropDownList -->
        <asp:SqlDataSource ID="sdsCategorias" runat="server"
            ConnectionString="<%$ ConnectionStrings:tienda %>"
            SelectCommand="SELECT idCategoria, descripcion FROM categorias ORDER BY descripcion" />

        <!-- Búsqueda: se lee con SqlDataReader desde el código -->
        <asp:SqlDataSource ID="sdsBuscar" runat="server"
            ConnectionString="<%$ ConnectionStrings:tienda %>"
            DataSourceMode="DataReader"
            SelectCommand="SELECT idProducto, nombre, precio, idCategoria FROM productos WHERE idProducto = @idProducto">
            <SelectParameters>
                <asp:Parameter Name="idProducto" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <!-- Modificación: actualiza producto y categoría asignada -->
        <asp:SqlDataSource ID="sdsModificar" runat="server"
            ConnectionString="<%$ ConnectionStrings:tienda %>"
            UpdateCommand="UPDATE productos SET nombre = @nombre, precio = @precio, idCategoria = @idCategoria WHERE idProducto = @idProducto">
            <UpdateParameters>
                <asp:Parameter Name="nombre" Type="String" />
                <asp:Parameter Name="precio" Type="Decimal" />
                <asp:Parameter Name="idCategoria" Type="Int32" />
                <asp:Parameter Name="idProducto" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
